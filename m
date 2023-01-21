Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50E676762
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 17:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjAUQ0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 11:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUQ0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:26:31 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F178024489;
        Sat, 21 Jan 2023 08:26:27 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VZyXkiY_1674318382;
Received: from 30.121.21.55(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZyXkiY_1674318382)
          by smtp.aliyun-inc.com;
          Sun, 22 Jan 2023 00:26:23 +0800
Message-ID: <7ee72d29-6ba6-77e6-7515-e710a26a1e0d@linux.alibaba.com>
Date:   Sun, 22 Jan 2023 00:26:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Amir Goldstein <amir73il@gmail.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <87ilh0g88n.fsf@redhat.com>
 <CAOQ4uxi7wT09MPf+edS6AkJzBCxjzOnCTfcdwn===q-+G2C4Gw@mail.gmail.com>
 <87cz78exub.fsf@redhat.com>
 <CAOQ4uxi2W=HwoXbrLo3yePTGzMxb++EDLj-fAcQZgGWU5Pz3vQ@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxi2W=HwoXbrLo3yePTGzMxb++EDLj-fAcQZgGWU5Pz3vQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/21 23:54, Amir Goldstein wrote:
> On Sat, Jan 21, 2023 at 5:01 PM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>
>> Amir Goldstein <amir73il@gmail.com> writes:
>>
>>> On Sat, Jan 21, 2023 at 12:18 AM Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>>>>
>>>> Hi Amir,
>>>>
>>>> Amir Goldstein <amir73il@gmail.com> writes:
>>>>
>>>>> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wrote:
>>>>>>
>>>>>> Giuseppe Scrivano and I have recently been working on a new project we
>>>>>> call composefs. This is the first time we propose this publically and
>>>>>> we would like some feedback on it.
>>>>>>
>>>>>> At its core, composefs is a way to construct and use read only images
>>>>>> that are used similar to how you would use e.g. loop-back mounted
>>>>>> squashfs images. On top of this composefs has two fundamental
>>>>>> features. First it allows sharing of file data (both on disk and in
>>>>>> page cache) between images, and secondly it has dm-verity like
>>>>>> validation on read.
>>>>>>
>>>>>> Let me first start with a minimal example of how this can be used,
>>>>>> before going into the details:
>>>>>>
>>>>>> Suppose we have this source for an image:
>>>>>>
>>>>>> rootfs/
>>>>>> ├── dir
>>>>>> │   └── another_a
>>>>>> ├── file_a
>>>>>> └── file_b
>>>>>>
>>>>>> We can then use this to generate an image file and a set of
>>>>>> content-addressed backing files:
>>>>>>
>>>>>> # mkcomposefs --digest-store=objects rootfs/ rootfs.img
>>>>>> # ls -l rootfs.img objects/*/*
>>>>>> -rw-------. 1 root root   10 Nov 18 13:20 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
>>>>>> -rw-------. 1 root root   10 Nov 18 13:20 objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>>>>>> -rw-r--r--. 1 root root 4228 Nov 18 13:20 rootfs.img
>>>>>>
>>>>>> The rootfs.img file contains all information about directory and file
>>>>>> metadata plus references to the backing files by name. We can now
>>>>>> mount this and look at the result:
>>>>>>
>>>>>> # mount -t composefs rootfs.img -o basedir=objects /mnt
>>>>>> # ls  /mnt/
>>>>>> dir  file_a  file_b
>>>>>> # cat /mnt/file_a
>>>>>> content_a
>>>>>>
>>>>>> When reading this file the kernel is actually reading the backing
>>>>>> file, in a fashion similar to overlayfs. Since the backing file is
>>>>>> content-addressed, the objects directory can be shared for multiple
>>>>>> images, and any files that happen to have the same content are
>>>>>> shared. I refer to this as opportunistic sharing, as it is different
>>>>>> than the more course-grained explicit sharing used by e.g. container
>>>>>> base images.
>>>>>>
>>>>>> The next step is the validation. Note how the object files have
>>>>>> fs-verity enabled. In fact, they are named by their fs-verity digest:
>>>>>>
>>>>>> # fsverity digest objects/*/*
>>>>>> sha256:02927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4 objects/02/927862b4ab9fb69919187bb78d394e235ce444eeb0a890d37e955827fe4bf4
>>>>>> sha256:cc3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>>>>>>
>>>>>> The generated filesystm image may contain the expected digest for the
>>>>>> backing files. When the backing file digest is incorrect, the open
>>>>>> will fail, and if the open succeeds, any other on-disk file-changes
>>>>>> will be detected by fs-verity:
>>>>>>
>>>>>> # cat objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>>>>>> content_a
>>>>>> # rm -f objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>>>>>> # echo modified > objects/cc/3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f
>>>>>> # cat /mnt/file_a
>>>>>> WARNING: composefs backing file '3da5b14909626fc99443f580e4d8c9b990e85e0a1d18883dc89b23d43e173f' unexpectedly had no fs-verity digest
>>>>>> cat: /mnt/file_a: Input/output error
>>>>>>
>>>>>> This re-uses the existing fs-verity functionallity to protect against
>>>>>> changes in file contents, while adding on top of it protection against
>>>>>> changes in filesystem metadata and structure. I.e. protecting against
>>>>>> replacing a fs-verity enabled file or modifying file permissions or
>>>>>> xattrs.
>>>>>>
>>>>>> To be fully verified we need another step: we use fs-verity on the
>>>>>> image itself. Then we pass the expected digest on the mount command
>>>>>> line (which will be verified at mount time):
>>>>>>
>>>>>> # fsverity enable rootfs.img
>>>>>> # fsverity digest rootfs.img
>>>>>> sha256:da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 rootfs.img
>>>>>> # mount -t composefs rootfs.img -o basedir=objects,digest=da42003782992856240a3e25264b19601016114775debd80c01620260af86a76 /mnt
>>>>>>
>>>>>> So, given a trusted set of mount options (say unlocked from TPM), we
>>>>>> have a fully verified filesystem tree mounted, with opportunistic
>>>>>> finegrained sharing of identical files.
>>>>>>
>>>>>> So, why do we want this? There are two initial users. First of all we
>>>>>> want to use the opportunistic sharing for the podman container image
>>>>>> baselayer. The idea is to use a composefs mount as the lower directory
>>>>>> in an overlay mount, with the upper directory being the container work
>>>>>> dir. This will allow automatical file-level disk and page-cache
>>>>>> sharning between any two images, independent of details like the
>>>>>> permissions and timestamps of the files.
>>>>>>
>>>>>> Secondly we are interested in using the verification aspects of
>>>>>> composefs in the ostree project. Ostree already supports a
>>>>>> content-addressed object store, but it is currently referenced by
>>>>>> hardlink farms. The object store and the trees that reference it are
>>>>>> signed and verified at download time, but there is no runtime
>>>>>> verification. If we replace the hardlink farm with a composefs image
>>>>>> that points into the existing object store we can use the verification
>>>>>> to implement runtime verification.
>>>>>>
>>>>>> In fact, the tooling to create composefs images is 100% reproducible,
>>>>>> so all we need is to add the composefs image fs-verity digest into the
>>>>>> ostree commit. Then the image can be reconstructed from the ostree
>>>>>> commit info, generating a file with the same fs-verity digest.
>>>>>>
>>>>>> These are the usecases we're currently interested in, but there seems
>>>>>> to be a breadth of other possible uses. For example, many systems use
>>>>>> loopback mounts for images (like lxc or snap), and these could take
>>>>>> advantage of the opportunistic sharing. We've also talked about using
>>>>>> fuse to implement a local cache for the backing files. I.e. you would
>>>>>> have the second basedir be a fuse filesystem. On lookup failure in the
>>>>>> first basedir it downloads the file and saves it in the first basedir
>>>>>> for later lookups. There are many interesting possibilities here.
>>>>>>
>>>>>> The patch series contains some documentation on the file format and
>>>>>> how to use the filesystem.
>>>>>>
>>>>>> The userspace tools (and a standalone kernel module) is available
>>>>>> here:
>>>>>>    https://github.com/containers/composefs
>>>>>>
>>>>>> Initial work on ostree integration is here:
>>>>>>    https://github.com/ostreedev/ostree/pull/2640
>>>>>>
>>>>>> Changes since v2:
>>>>>> - Simplified filesystem format to use fixed size inodes. This resulted
>>>>>>    in simpler (now < 2k lines) code as well as higher performance at
>>>>>>    the cost of slightly (~40%) larger images.
>>>>>> - We now use multi-page mappings from the page cache, which removes
>>>>>>    limits on sizes of xattrs and makes the dirent handling code simpler.
>>>>>> - Added more documentation about the on-disk file format.
>>>>>> - General cleanups based on review comments.
>>>>>>
>>>>>
>>>>> Hi Alexander,
>>>>>
>>>>> I must say that I am a little bit puzzled by this v3.
>>>>> Gao, Christian and myself asked you questions on v2
>>>>> that are not mentioned in v3 at all.
>>>>>
>>>>> To sum it up, please do not propose composefs without explaining
>>>>> what are the barriers for achieving the exact same outcome with
>>>>> the use of a read-only overlayfs with two lower layer -
>>>>> uppermost with erofs containing the metadata files, which include
>>>>> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
>>>>> to the lowermost layer containing the content files.
>>>>
>>>> I think Dave explained quite well why using overlay is not comparable to
>>>> what composefs does.
>>>>
>>>
>>> Where? Can I get a link please?
>>
>> I am referring to this message: https://lore.kernel.org/lkml/20230118002242.GB937597@dread.disaster.area/
>>
> 
> That is a good explanation why the current container runtime
> overlay storage driver is inadequate, because the orchestration
> requires untar of OCI tarball image before mounting overlayfs.
> 
> It is not a kernel issue, it is a userspace issue, because userspace
> does not utilize overlayfs driver features that are now 6 years
> old (redirect_dir) and 4 years old (metacopy).
> 
> I completely agree that reflink and hardlinks are not a viable solution
> to ephemeral containers.
> 
>>> If there are good reasons why composefs is superior to erofs+overlayfs
>>> Please include them in the submission, since several developers keep
>>> raising the same questions - that is all I ask.
>>>
>>>> One big difference is that overlay still requires at least a syscall for
>>>> each file in the image, and then we need the equivalent of "rm -rf" to
>>>> clean it up.  It is somehow acceptable for long-running services, but it
>>>> is not for "serverless" containers where images/containers are created
>>>> and destroyed frequently.  So even in the case we already have all the
>>>> image files available locally, we still need to create a checkout with
>>>> the final structure we need for the image.
>>>>
>>>
>>> I think you did not understand my suggestion:
>>>
>>> overlay read-only mount:
>>>      layer 1: erofs mount of a precomposed image (same as mkcomposefs)
>>>      layer 2: any pre-existing fs path with /blocks repository
>>>      layer 3: any per-existing fs path with /blocks repository
>>>      ...
>>>
>>> The mkcomposefs flow is exactly the same in this suggestion
>>> the upper layer image is created without any syscalls and
>>> removed without any syscalls.
>>
>> mkcomposefs is supposed to be used server side, when the image is built.
>> The clients that will mount the image don't have to create it (at least
>> for images that will provide the manifest).
>>
>> So this is quite different as in the overlay model we must create the
>> layout, that is the equivalent of the composefs manifest, on any node
>> the image is pulled to.
>>
> 
> You don't need to re-create the erofs manifest on the client.
> Unless I am completely missing something, the flow that I am
> suggesting is drop-in replacement to what you have done.
> 
> IIUC, you invented an on-disk format for composefs manifest.
> Is there anything preventing you from using the existing
> erofs on-disk format to pack the manifest file?
> The files in the manifest would be inodes with no blocks, only
> with size and attributes and overlay xattrs with references to
> the real object blocks, same as you would do with mkcomposefs.
> Is it not?

Yes, some EROFS special images work as all regular files with empty
data and some overlay "trusted" xattrs included as lower dir would
be ok.

> 
> Maybe what I am missing is how are the blob objects distributed?
> Are they also shipped as composefs image bundles?
> That can still be the case with erofs images that may contain both
> blobs with data and metadata files referencing blobs in older images.

Maybe just empty regular files in EROFS (or whatever else fs) with
a magic "trusted.overlay.blablabla" xattr to point to the real file.

> 
>>> Overlayfs already has the feature of redirecting from upper layer
>>> to relative paths in lower layers.
>>
>> Could you please provide more information on how you would compose the
>> overlay image first?
>>
>>  From what I can see, it still requires at least one syscall for each
>> file in the image to be created and these images are not portable to a
>> different machine.
> 
> Terminology nuance - you do not create an overlayfs image on the server
> you create an erofs image on the server, exactly as you would create
> a composefs image on the server.
> 
> The shipped overlay "image" would then be the erofs image with
> references to prereqisite images that contain the blobs and the digest
> of the erofs image.
> 
> # mount -t composefs rootfs.img -o basedir=objects /mnt
> 
> client will do:
> 
> # mount -t erofs rootfs.img -o digest=da.... /metadata
> # mount -t overlay -o ro,metacopy=on,lowerdir=/metadata:/objects /mnt

Currently maybe not even introduce "-o digest", just loop+dm-verity for
such manifest is already ok.

> 
>>
>> Should we always make "/blocks" a whiteout to prevent it is leaked in
>> the container?
> 
> That would be the simplest option, yes.
> If needed we can also make it a hidden layer whose objects
> never appear in the namespace and can only be referenced
> from an upper layer redirection.
> 
>>
>> And what prevents files under "/blocks" to be replaced with a different
>> version?  I think fs-verity on the EROFS image itself won't cover it.
>>
> 
> I think that part should be added to the overlayfs kernel driver.
> We could enhance overlayfs to include optional "overlay.verity" digest
> on the metacopy upper files to be fed into fsverity when opening lower
> blob files that reside on an fsverity supported filesystem.

Agreed, another overlayfs "trusted.overlay.verity" xattr in EROFS (or
whatever else fs) for each empty regular files to do the same
fsverity_get_digest() trick.  That would have the same impact IMO.

Thanks,
Gao Xiang

...

> 
> Thanks,
> Amir.
