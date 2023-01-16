Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433DD66BFC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 14:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjAPN0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 08:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjAPN03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:26:29 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757771CAF7;
        Mon, 16 Jan 2023 05:26:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VZjiPto_1673875578;
Received: from 30.236.8.126(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZjiPto_1673875578)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 21:26:19 +0800
Message-ID: <d7c4686b-24cc-0991-d6db-0dec8fb9942e@linux.alibaba.com>
Date:   Mon, 16 Jan 2023 21:26:18 +0800
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
 <0a144ffd-38bb-0ff3-e8b2-bca5e277444c@linux.alibaba.com>
 <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <9d44494fdf07df000ce1b9bafea7725ea240ca41.camel@redhat.com>
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



On 2023/1/16 20:33, Alexander Larsson wrote:
> On Mon, 2023-01-16 at 18:19 +0800, Gao Xiang wrote:
>> Hi Alexander,
>>
>> On 2023/1/16 17:30, Alexander Larsson wrote:
>>>
>>> I mean, you're not wrong about this being possible. But I don't see
>>> that this is necessarily a new problem. For example, consider the
>>> case
>>> of loopback mounting an ext4 filesystem containing a setuid /bin/su
>>> file. If you have the right permissions, nothing prohibits you from
>>> modifying the loopback mounted file and replacing the content of
>>> the su
>>> file with a copy of bash.
>>>
>>> In both these cases, the security of the system is fully defined by
>>> the
>>> filesystem permissions of the backing file data. I think viewing
>>> composefs as a "new type" of overlayfs gets the wrong idea across.
>>> Its
>>> more similar to a "new type" of loopback mount. In particular, the
>>> backing file metadata is completely unrelated to the metadata
>>> exposed
>>> by the filesystem, which means that you can chose to protect the
>>> backing files (and directories) in ways which protect against
>>> changes
>>> from non-privileged users.
>>>
>>> Note: The above assumes that mounting either a loopback mount or a
>>> composefs image is a privileged operation. Allowing unprivileged
>>> mounts
>>> is a very different thing.
>>
>> Thanks for the reply.  I think if I understand correctly, I could
>> answer some of your questions.  Hopefully help to everyone
>> interested.
>>
>> Let's avoid thinking unprivileged mounts first, although Giuseppe
>> told
>> me earilier that is also a future step of Composefs. But I don't know
>> how it could work reliably if a fs has some on-disk format, we could
>> discuss it later.
>>
>> I think as a loopback mount, such loopback files are quite under
>> control
>> (take ext4 loopback mount as an example, each ext4 has the only one
>> file
>>    to access when setting up loopback devices and such loopback file
>> was
>>    also opened when setting up loopback mount so it cannot be
>> replaced.
>>
>>    If you enables fsverity for such loopback mount before, it cannot
>> be
>>    modified as well) by admins.
>>
>>
>> But IMHO, here composefs shows a new model that some stackable
>> filesystem can point to massive files under a random directory as
>> what
>> ostree does (even files in such directory can be bind-mounted later
>> in
>> principle).  But the original userspace ostree strictly follows
>> underlayfs permission check but Composefs can override
>> uid/gid/permission instead.
> 
> Suppose you have:
> 
> -rw-r--r-- root root image.ext4
> -rw-r--r-- root root image.composefs
> drwxr--r-- root root objects/
> -rw-r--r-- root root objects/backing.file
> 
> Are you saying it is easier for someone to modify backing.file than
> image.ext4?
> 
> I argue it is not, but composefs takes some steps to avoid issues here.
> At mount time, when the basedir ("objects/" above) argument is parsed,
> we resolve that path and then create a private vfsmount for it:
> 
>   resolve_basedir(path) {
>          ...
> 	mnt = clone_private_mount(&path);
>          ...
>   }
> 
>   fsi->bases[i] = resolve_basedir(path);
> 
> Then we open backing files with this mount as root:
> 
>   real_file = file_open_root_mnt(fsi->bases[i], real_path,
>   			        file->f_flags, 0);
> 
> This will never resolve outside the initially specified basedir, even
> with symlinks or whatever. It will also not be affected by later mount
> changes in the original mount namespace, as this is a private mount.
> 
> This is the same mechanism that overlayfs uses for its upper dirs.

Ok.  I have no problem of this part.

> 
> I would argue that anyone who has rights to modify the contents of
> files in "objects" (supposing they were created with sane permissions)
> would also have rights to modify "image.ext4".

But you don't have any permission check for files in such
"objects/" directory in composefs source code, do you?

As I said in my original reply, don't assume random users or
malicious people just passing in or behaving like your expected
way.  Sometimes they're not but I think in-kernel fses should
handle such cases by design.  Obviously, any system written by
human can cause unexpected bugs, but that is another story.
I think in general it needs to have such design at least.

> 
>> That is also why we selected fscache at the first time to manage all
>> local cache data for EROFS, since such content-defined directory is
>> quite under control by in-kernel fscache instead of selecting a
>> random directory created and given by some userspace program.
>>
>> If you are interested in looking info the current in-kernel fscache
>> behavior, I think that is much similar as what ostree does now.
>>
>> It just needs new features like
>>     - multiple directories;
>>     - daemonless
>> to match.
>>
> 
> Obviously everything can be extended to support everything. But
> composefs is very small and simple (2128 lines of code), while at the
> same time being easy to use (just mount it with one syscall) and needs
> no complex userspace machinery and configuration. But even without the
> above feature additions fscache + cachefiles is 7982 lines, plus erofs
> is 9075 lines, and then on top of that you need userspace integration
> to even use the thing.

I've replied this in the comment of LWN.net.  EROFS can handle both
device-based or file-based images. It can handle FSDAX, compression,
data deduplication, rolling-hash finer compressed data duplication,
etc.  Of course, for your use cases, you can just turn them off by
Kconfig, I think such code is useless to your use cases as well.

And as a team work these years, EROFS always accept useful features
from other people.  And I've been always working on cleaning up
EROFS, but as long as it gains more features, the code can expand
of course.

Also take your project -- flatpak for example, I don't think the
total line of current version is as same as the original version.

Also you will always maintain Composefs source code below 2.5k Loc?

> 
> Don't take me wrong, EROFS is great for its usecases, but I don't
> really think it is the right choice for my usecase.
> 
>>>>
>>> Secondly, the use of fs-cache doesn't stack, as there can only be
>>> one
>>> cachefs agent. For example, mixing an ostree EROFS boot with a
>>> container backend using EROFS isn't possible (at least without deep
>>> integration between the two userspaces).
>>
>> The reasons above are all current fscache implementation limitation:
>>
>>    - First, if such overlay model really works, EROFS can do it
>> without
>> fscache feature as well to integrate userspace ostree.  But even that
>> I hope this new feature can be landed in overlayfs rather than some
>> other ways since it has native writable layer so we don't need
>> another
>> overlayfs mount at all for writing;
> 
> I don't think it is the right approach for overlayfs to integrate
> something like image support. Merging the two codebases would
> complicate both while adding costs to users who need only support for
> one of the features. I think reusing and stacking separate features is
> a better idea than combining them.

Why? overlayfs could have metadata support as well, if they'd like
to support advanced features like partial copy-up without fscache
support.

> 
>>
>>>
>>> Instead what we have done with composefs is to make filesystem
>>> image
>>> generation from the ostree repository 100% reproducible. Then we
>>> can
>>
>> EROFS is all 100% reproduciable as well.
>>
> 
> 
> Really, so if I today, on fedora 36 run:
> # tar xvf oci-image.tar
> # mkfs.erofs oci-dir/ oci.erofs
> 
> And then in 5 years, if someone on debian 13 runs the same, with the
> same tar file, then both oci.erofs files will have the same sha256
> checksum?

Why it doesn't?  Reproducable builds is a MUST for Android use cases
as well.

Yes, it may break between versions by mistake, but I think
reproducable builds is a basic functionalaity for all image
use cases.

> 
> How do you handle things like different versions or builds of
> compression libraries creating different results? Do you guarantee to
> not add any new backwards compat changes by default, or change any
> default options? Do you guarantee that the files are read from "oci-
> dir" in the same order each time? It doesn't look like it.

If you'd like to say like that, why mkcomposefs doesn't have the
same issue that it may be broken by some bug.

> 
>>
>> But really, personally I think the issue above is different from
>> loopback devices and may need to be resolved first. And if possible,
>> I hope it could be an new overlayfs feature for everyone.
> 
> Yeah. Independent of composefs, I think EROFS would be better if you
> could just point it to a chunk directory at mount time rather than
> having to route everything through a system-wide global cachefs
> singleton. I understand that cachefs does help with the on-demand
> download aspect, but when you don't need that it is just in the way.

Just check your reply to Dave's review, it seems that how
composefs dir on-disk format works is also much similar to
EROFS as well, see:

https://docs.kernel.org/filesystems/erofs.html -- Directories

a block vs a chunk = dirent + names

cfs_dir_lookup -> erofs_namei + find_target_block_classic;
cfs_dir_lookup_in_chunk -> find_target_dirent.

Yes, great projects could be much similar to each other
occasionally, not to mention opensource projects ;)

Anyway, I'm not opposed to Composefs if folks really like a
new read-only filesystem for this. That is almost all I'd like
to say about Composefs formally, have fun!

Thanks,
Gao Xiang

> 
> 
