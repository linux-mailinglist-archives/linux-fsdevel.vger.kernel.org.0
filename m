Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60666BB91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 11:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAPKTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 05:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjAPKTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:19:31 -0500
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E6193EC;
        Mon, 16 Jan 2023 02:19:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZhOcfO_1673864363;
Received: from 30.97.48.228(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZhOcfO_1673864363)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 18:19:24 +0800
Message-ID: <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
Date:   Mon, 16 Jan 2023 18:19:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com
References: <cover.1673623253.git.alexl@redhat.com>
 <3065ecb6-8e6a-307f-69ea-fb72854aeb0f@linux.alibaba.com>
 <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <d3c63da908ef16c43a6a65a22a8647bf874695c7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

On 2023/1/16 17:30, Alexander Larsson wrote:
> On Mon, 2023-01-16 at 12:44 +0800, Gao Xiang wrote:
>> Hi Alexander and folks,
>>
>> I'd like to say sorry about comments in LWN.net article.  If it helps
>> to the community,  my own concern about this new overlay model was
>> (which is different from overlayfs since overlayfs doesn't have
>>    different permission of original files) somewhat a security issue
>> (as
>> I told Giuseppe Scrivano before when he initially found me on slack):
>>
>> As composefs on-disk shown:
>>
>> struct cfs_inode_s {
>>
>>           ...
>>
>>          u32 st_mode; /* File type and mode.  */
>>          u32 st_nlink; /* Number of hard links, only for regular
>> files.  */
>>          u32 st_uid; /* User ID of owner.  */
>>          u32 st_gid; /* Group ID of owner.  */
>>
>>           ...
>> };
>>
>> It seems Composefs can override uid / gid and mode bits of the
>> original file
>>
>>      considering a rootfs image:
>>        ├── /bin
>>        │   └── su
>>
>> /bin/su has SUID bit set in the Composefs inode metadata, but I
>> didn't
>> find some clues if ostree "objects/abc" could be actually replaced
>> with data of /bin/sh if composefs fsverity feature is disabled (it
>> doesn't seem composefs enforcely enables fsverity according to
>> documentation).
>>
>> I think that could cause _privilege escalation attack_ of these SUID
>> files is replaced with some root shell.  Administrators cannot keep
>> all the time of these SUID files because such files can also be
>> replaced at runtime.
>>
>> Composefs may assume that ostree is always for such content-addressed
>> directory.  But if considering it could laterly be an upstream fs, I
>> think we cannot always tell people "no, don't use this way, it
>> doesn't
>> work" if people use Composefs under an untrusted repo (maybe even
>> without ostree).
>>
>> That was my own concern at that time when Giuseppe Scrivano told me
>> to enhance EROFS as this way, and I requested him to discuss this in
>> the fsdevel mailing list in order to resolve this, but it doesn't
>> happen.
>>
>> Otherwise, EROFS could face such issue as well, that is why I think
>> it needs to be discussed first.
> 
> I mean, you're not wrong about this being possible. But I don't see
> that this is necessarily a new problem. For example, consider the case
> of loopback mounting an ext4 filesystem containing a setuid /bin/su
> file. If you have the right permissions, nothing prohibits you from
> modifying the loopback mounted file and replacing the content of the su
> file with a copy of bash.
> 
> In both these cases, the security of the system is fully defined by the
> filesystem permissions of the backing file data. I think viewing
> composefs as a "new type" of overlayfs gets the wrong idea across. Its
> more similar to a "new type" of loopback mount. In particular, the
> backing file metadata is completely unrelated to the metadata exposed
> by the filesystem, which means that you can chose to protect the
> backing files (and directories) in ways which protect against changes
> from non-privileged users.
> 
> Note: The above assumes that mounting either a loopback mount or a
> composefs image is a privileged operation. Allowing unprivileged mounts
> is a very different thing.

Thanks for the reply.  I think if I understand correctly, I could
answer some of your questions.  Hopefully help to everyone interested.

Let's avoid thinking unprivileged mounts first, although Giuseppe told
me earilier that is also a future step of Composefs. But I don't know
how it could work reliably if a fs has some on-disk format, we could
discuss it later.

I think as a loopback mount, such loopback files are quite under control
(take ext4 loopback mount as an example, each ext4 has the only one file
  to access when setting up loopback devices and such loopback file was
  also opened when setting up loopback mount so it cannot be replaced.

  If you enables fsverity for such loopback mount before, it cannot be
  modified as well) by admins.


But IMHO, here composefs shows a new model that some stackable
filesystem can point to massive files under a random directory as what
ostree does (even files in such directory can be bind-mounted later in
principle).  But the original userspace ostree strictly follows
underlayfs permission check but Composefs can override
uid/gid/permission instead.

That is also why we selected fscache at the first time to manage all
local cache data for EROFS, since such content-defined directory is
quite under control by in-kernel fscache instead of selecting a
random directory created and given by some userspace program.

If you are interested in looking info the current in-kernel fscache
behavior, I think that is much similar as what ostree does now.

It just needs new features like
   - multiple directories;
   - daemonless
to match.

> 
>>> To be fully verified we need another step: we use fs-verity on the
>>> image itself. Then we pass the expected digest on the mount command
>>> line (which will be verified at mount time):
>>>
>>> # fsverity enable rootfs.img
>>> # fsverity digest rootfs.img
>>> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af8
>>> 6a76 rootfs.img
>>> # mount -t composefs rootfs.img -o
>>> basedir=objects,digest=da42003782992856240a3e25264b19601016114775de
>>> bd80c01620260af86a76 /mnt
>>>
>>
>>
>> It seems that Composefs uses fsverity_get_digest() to do fsverity
>> check.  If Composefs uses symlink-like payload to redirect a file to
>> another underlayfs file, such underlayfs file can exist in any other
>> fses.
>>
>> I can see Composefs could work with ext4, btrfs, f2fs, and later XFS
>> but I'm not sure how it could work with overlayfs, FUSE, or other
>> network fses.  That could limit the use cases as well.
> 
> Yes, if you chose to store backing files on a non-fs-verity enabled
> filesystem you cannot use the fs-verity feature. But this is just a
> decision users of composefs have to take if they wish to use this
> particular feature. I think re-using fs-verity like this is a better
> approach than re-implementing verity.
> 
>> Except for the above, I think EROFS could implement this in about
>> 300~500 new lines of code as Giuseppe found me, or squashfs or
>> overlayfs.
>>
>> I'm very happy to implement such model if it can be proved as safe
>> (I'd also like to say here by no means I dislike ostree) and I'm
>> also glad if folks feel like to introduce a new file system for
>> this as long as this overlay model is proved as safe.
> 
> My personal target usecase is that of the ostree trusted root
> filesystem, and it has a lot of specific requirements that lead to
> choices in the design of composefs. I took a look at EROFS a while ago,
> and I think that even with some verify-like feature it would not fit
> this usecase.
> 
> EROFS does indeed do some of the file-sharing aspects of composefs with
> its use of fs-cache (although the current n_chunk limit would need to
> be raised). However, I think there are two problems with this.
> 
> First of all is the complexity of having to involve a userspace for the
> cache. For trusted boot to work we have to have all the cachefs
> userspace machinery on the (signed) initrd, and then have to properly
> transition this across the pivot-root into the full os boot. I'm sure
> it is technically *possible*, but it is very complex and a pain to set
> up and maintain.
> 
> Secondly, the use of fs-cache doesn't stack, as there can only be one
> cachefs agent. For example, mixing an ostree EROFS boot with a
> container backend using EROFS isn't possible (at least without deep
> integration between the two userspaces).

The reasons above are all current fscache implementation limitation:

  - First, if such overlay model really works, EROFS can do it without
fscache feature as well to integrate userspace ostree.  But even that
I hope this new feature can be landed in overlayfs rather than some
other ways since it has native writable layer so we don't need another
overlayfs mount at all for writing;

  - Second, as I mentioned above, the limitation above is what fscache
behaves now not fscache will behave.  I did discuss with David Howells
that he also would like to develop multiple directories and daemonless
features for network fses.

> 
> Also, f we ignore the file sharing aspects there is the question of how
> to actually integrate a new digest-based image format with the pre-
> existing ostree formats and distribution mechanisms. If we just replace
> everything with distributing a signed image file then we can easily use
> existing technology (say dm-verity + squashfs + loopback). However,
> this would be essentially A/B booting and we would lose all the
> advantages of ostree.
EROFS now can do data-duplication and later page cache sharing as well.

> 
> Instead what we have done with composefs is to make filesystem image
> generation from the ostree repository 100% reproducible. Then we can

EROFS is all 100% reproduciable as well.

> keep the entire pre-existing ostree distribution mechanism and on-disk
> repo format, adding just a single piece of metadata to the ostree
> commit, containing the composefs toplevel digest. Then the client can
> easily and efficiently re-generate the composefs image locally, and
> boot into it specifying the trusted not-locally-generated digest. A
> filesystem that doesn't have this reproduceability feature isn't going
> to be possible to integrate with ostree without enormous changes to
> ostree, and a filesystem more complex that composefs will have a hard
> time giving such guarantees.

I'm not sure why EROFS is not good at this, I could also make an
EROFS-version the same as what Composefs does with some symlink path
attached to each regular file. And ostree can also make use of it.

But really, personally I think the issue above is different from
loopback devices and may need to be resolved first. And if possible,
I hope it could be an new overlayfs feature for everyone.

Thanks,
Gao Xiang

> 
> 
