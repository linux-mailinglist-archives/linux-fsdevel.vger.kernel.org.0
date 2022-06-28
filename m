Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C9355F0BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 23:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiF1V4b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 17:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiF1V4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:56:30 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9673E1AF1C
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 14:56:29 -0700 (PDT)
Received: from [10.10.0.40] (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 0A3743E947;
        Tue, 28 Jun 2022 21:56:28 +0000 (UTC)
Message-ID: <3062694c-8725-3653-a8e6-de2942aed1c2@openvpn.net>
Date:   Tue, 28 Jun 2022 15:56:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20220627221107.176495-1-james@openvpn.net>
 <CAOQ4uxi5mKd1OuAcdFemx=h+1Ay-Ka4F6ddO5_fjk7m6G88MuQ@mail.gmail.com>
From:   James Yonan <james@openvpn.net>
In-Reply-To: <CAOQ4uxi5mKd1OuAcdFemx=h+1Ay-Ka4F6ddO5_fjk7m6G88MuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/22 03:46, Amir Goldstein wrote:
> [+linux-api]
>
> On Tue, Jun 28, 2022 at 1:58 AM James Yonan <james@openvpn.net> wrote:
>> RENAME_NEWER is a new userspace-visible flag for renameat2(), and
>> stands alongside existing flags such as RENAME_NOREPLACE,
>> RENAME_EXCHANGE, and RENAME_WHITEOUT.
>>
>> RENAME_NEWER is a conditional variation on RENAME_NOREPLACE, and
>> indicates that if the target of the rename exists, the rename will
>> only succeed if the source file is newer than the target (i.e. source
>> mtime > target mtime).  Otherwise, the rename will fail with -EEXIST
>> instead of replacing the target.  When the target doesn't exist,
>> RENAME_NEWER does a plain rename like RENAME_NOREPLACE.
>>
>> RENAME_NEWER is very useful in distributed systems that mirror a
>> directory structure, or use a directory as a key/value store, and need
>> to guarantee that files will only be overwritten by newer files, and
>> that all updates are atomic.
> This feature sounds very cool.
> For adding a new API it is always useful if you bring forward a userland
> tool (rsync?) that intend to use it, preferably with a POC patch.
> A concrete prospective user is always better than a hypothetical one.
> Some people hold the opinion that only new APIs with real prospective
> users should be merged.

Not sure that rsync would be the canonical user, though it might be a 
reasonable POC.  The problem that we are solving is essentially 
near-real-time directory mirroring or replication of one source 
directory to many target directories on follower nodes.  Many writers, 
many readers, filesystem-based, strong guarantees of eventual 
convergence, infinitely scalable.  You have a source directory that 
could be an AWS S3 bucket.  You have potentially thousands of follower 
nodes that want to replicate the source directory on a local 
filesystem.  You have messages flying around the network (Kafka, AWS 
SQS, etc.) representing file updates.  These messages might be reordered 
or duplicated but each contains the file content and a unique 
nanosecond-scale timestamp.  Because the file update throughput can be 
in the thousands of files per second, you might have multiple threads on 
each node, receiving updates, and moving them into the target 
directory.  The only way to guarantee that the state of the mirror 
target directory on all nodes converges to the state of the source 
directory is to have the last-step move operation be atomic and 
conditional to the modification time (so that an earlier version of the 
file doesn't overwrite a later version).

So I understand that there needs to be a strong case to extend the Linux 
API, and I think the argument is that conditional atomic file operations 
enable entirely new classes of applications.  The fact that this can be 
facilitated by essentially 5 lines of kernel code is remarkable.

>
>> While this patch may appear large at first glance, most of the changes
>> deal with renameat2() flags validation, and the core logic is only
>> 5 lines in the do_renameat2() function in fs/namei.c:
>>
>>          if ((flags & RENAME_NEWER)
>>              && d_is_positive(new_dentry)
>>              && timespec64_compare(&d_backing_inode(old_dentry)->i_mtime,
>>                                    &d_backing_inode(new_dentry)->i_mtime) <= 0)
>>                  goto exit5;
>>
> I have a few questions:
> - Why mtime?
> - Why not ctime?
> - Shouldn't a feature like that protect from overwriting metadata changes
>    to the destination file?
>
> In any case, I would be much more comfortable with comparing ctime
> because when it comes to user settable times, what if rsync *wants*
> to update the destination file's mtime to an earlier time that was set in
> the rsync source?
>
> If comparing ctime does not fit your use case and you can convince
> the community that comparing mtime is a justified use case, we would
> need to use a flag name to reflect that like RENAME_NEWER_MTIME
> so we don't block future use case of RENAME_NEWER_CTIME.
> I hope that we can agree that ctime is enough and that mtime will not
> make sense so we can settle with RENAME_NEWER that means ctime.

So I actually think that mtime is the better timestamp to use because 
ctime is modified by the rename operation itself, while mtime measures 
the last modification time of the file content, which is what we care about.

>
>> It's pretty cool in a way that a new atomic file operation can even be
>> implemented in just 5 lines of code, and it's thanks to the existing
>> locking infrastructure around file rename/move that these operations
>> become almost trivial.  Unfortunately, every fs must approve a new
>> renameat2() flag, so it bloats the patch a bit.
>>
>> So one question to ask is could this functionality be implemented
>> in userspace without adding a new renameat2() flag?  I think you
>> could attempt it with iterative RENAME_EXCHANGE, but it's hackish,
>> inefficient, and not atomic, because races could cause temporary
>> mtime backtracks.  How about using file locking?  Probably not,
>> because the problem we want to solve is maintaining file/directory
>> atomicity for readers by creating files out-of-directory, setting
>> their mtime, and atomically moving them into place.  The strategy
>> to lock such an operation really requires more complex locking methods
>> than are generally exposed to userspace.  And if you are using inotify
>> on the directory to notify readers of changes, it certainly makes
>> sense to reduce unnecessary churn by preventing a move operation
>> based on the mtime check.
>>
>> While some people might question the utility of adding features to
>> filesystems to make them more like databases, there is real value
>> in the performance, atomicity, consistent VFS interface, multi-thread
>> safety, and async-notify capabilities of modern filesystems that
>> starts to blur the line, and actually make filesystem-based key-value
>> stores a win for many applications.
>>
>> Like RENAME_NOREPLACE, the RENAME_NEWER implementation lives in
>> the VFS, however the individual fs implementations do strict flags
>> checking and will return -EINVAL for any flag they don't recognize.
>> For this reason, my general approach with flags is to accept
>> RENAME_NEWER wherever RENAME_NOREPLACE is also accepted, since
>> RENAME_NEWER is simply a conditional variant of RENAME_NOREPLACE.
> You are not taking into account that mtime may be cached attribute that is not
> uptodate in network filesystems (fuse too) so behavior can be a bit
> unpredictable,
> unless filesystem code compares also the cache coherency of the attributes
> on both files and even then, without extending the network protocol this is
> questionable behavior for client side.
> So I think your filter of which filesystems to enable is way too wide.

So I'm new to the filesystem code, but my reading of do_renameat2() in 
fs/namei.c seems to indicate that if d_is_positive(dentry) is true, it's 
safe to access the inode struct via d_backing_inode(dentry) and 
dereference mtime.  But what you're saying is that the mtime value 
cached in the inode struct might not be up-to-date for network filesystems?

>
> How many of them did you test, I'll take a wild guess that not all of them.
>
> Please do not enable RENAME_NEWER is any filesystem that you did
> not test or that was not tested by some other fs developer using the
> tests that you write.

So I'm mostly interested in implementing this on local filesystems, 
because the application layer has already done the heavy lifting on the 
networking side so that the filesystem layer can be local, fast, and 
atomic.  So yes, I haven't tested this yet on networked filesystems.  
But I'm thinking that because all functionality is implemented at the 
VFS layer, it should be portable to any fs that also supports 
RENAME_NOREPLACE, with the caveat that it depends on the ability of the 
VFS to get a current and accurate mtime attribute inside the critical 
section between lock_rename() and unlock_rename().

>
>> I noticed only one fs driver (cifs) that treated RENAME_NOREPLACE
>> in a non-generic way, because no-replace is the natural behavior
>> for CIFS, and it therefore considers RENAME_NOREPLACE as a hint that
>> no replacement can occur.  Aside from this special case, it seems
>> safe to assume that any fs that supports RENAME_NOREPLACE should
>> also be able to support RENAME_NEWER out of the box.
>>
>> I did not notice a general self-test for renameat2() at the VFS
>> layer (outside of fs-specific tests), so I created one, though
>> at the moment it only exercises RENAME_NEWER.  Build and run with:
>>
>>    make -C tools/testing/selftests TARGETS=renameat2 run_tests
> Please make sure to also add test coverage in fstests and/or LTP.
> See fstest generic/024 for RENAME_NOREPLACE and LTP test
> renameat201 as examples.
> renameat201 can and should be converted to newlib and run with
> .all_filesystems = 1.
> This is the easiest and fastest way for you to verify your patch
> on the common fs that are installed on your system.
> LTP maintainers can help you with that.

Thanks, that's good to know.  And thanks for taking the time to write up 
such a detailed response.

James


