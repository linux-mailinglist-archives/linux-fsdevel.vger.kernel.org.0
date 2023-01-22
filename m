Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B44676A77
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 01:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjAVAj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 19:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVAj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 19:39:57 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E8F1F91F;
        Sat, 21 Jan 2023 16:39:54 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VZzM22S_1674347990;
Received: from 192.168.1.38(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZzM22S_1674347990)
          by smtp.aliyun-inc.com;
          Sun, 22 Jan 2023 08:39:51 +0800
Message-ID: <31fc4be5-0e53-b1fb-9a2c-f34d598c0fe7@linux.alibaba.com>
Date:   Sun, 22 Jan 2023 08:39:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <87ilh0g88n.fsf@redhat.com>
 <321dfdb1-3771-b16d-604f-224ce8aa22cf@linux.alibaba.com>
 <878rhvg8ru.fsf@redhat.com>
 <3ae1205a-b666-3211-e649-ad402c69e724@linux.alibaba.com>
 <87sfg3ecv5.fsf@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87sfg3ecv5.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/22 06:34, Giuseppe Scrivano wrote:
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> On 2023/1/22 00:19, Giuseppe Scrivano wrote:
>>> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
>>>
>>>> On 2023/1/21 06:18, Giuseppe Scrivano wrote:
>>>>> Hi Amir,
>>>>> Amir Goldstein <amir73il@gmail.com> writes:
>>>>>
>>>>>> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wrote:
>>>>
>>>> ...
>>>>
>>>>>>>
>>>>>>
>>>>>> Hi Alexander,
>>>>>>
>>>>>> I must say that I am a little bit puzzled by this v3.
>>>>>> Gao, Christian and myself asked you questions on v2
>>>>>> that are not mentioned in v3 at all.
>>>>>>
>>>>>> To sum it up, please do not propose composefs without explaining
>>>>>> what are the barriers for achieving the exact same outcome with
>>>>>> the use of a read-only overlayfs with two lower layer -
>>>>>> uppermost with erofs containing the metadata files, which include
>>>>>> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
>>>>>> to the lowermost layer containing the content files.
>>>>> I think Dave explained quite well why using overlay is not
>>>>> comparable to
>>>>> what composefs does.
>>>>> One big difference is that overlay still requires at least a syscall
>>>>> for
>>>>> each file in the image, and then we need the equivalent of "rm -rf" to
>>>>> clean it up.  It is somehow acceptable for long-running services, but it
>>>>> is not for "serverless" containers where images/containers are created
>>>>> and destroyed frequently.  So even in the case we already have all the
>>>>> image files available locally, we still need to create a checkout with
>>>>> the final structure we need for the image.
>>>>> I also don't see how overlay would solve the verified image problem.
>>>>> We
>>>>> would have the same problem we have today with fs-verity as it can only
>>>>> validate a single file but not the entire directory structure.  Changes
>>>>> that affect the layer containing the trusted.overlay.{metacopy,redirect}
>>>>> xattrs won't be noticed.
>>>>> There are at the moment two ways to handle container images, both
>>>>> somehow
>>>>> guided by the available file systems in the kernel.
>>>>> - A single image mounted as a block device.
>>>>> - A list of tarballs (OCI image) that are unpacked and mounted as
>>>>>      overlay layers.
>>>>> One big advantage of the block devices model is that you can use
>>>>> dm-verity, this is something we miss today with OCI container images
>>>>> that use overlay.
>>>>> What we are proposing with composefs is a way to have "dm-verity"
>>>>> style
>>>>> validation based on fs-verity and the possibility to share individual
>>>>> files instead of layers.  These files can also be on different file
>>>>> systems, which is something not possible with the block device model.
>>>>
>>>> That is not a new idea honestly, including chain of trust.  Even laterly
>>>> out-of-tree incremental fs using fs-verity for this as well, except that
>>>> it's in a real self-contained way.
>>>>
>>>>> The composefs manifest blob could be generated remotely and signed.
>>>>> A
>>>>> client would need just to validate the signature for the manifest blob
>>>>> and from there retrieve the files that are not in the local CAS (even
>>>>> from an insecure source) and mount directly the manifest file.
>>>>
>>>>
>>>> Back to the topic, after thinking something I have to make a
>>>> compliment for reference.
>>>>
>>>> First, EROFS had the same internal dissussion and decision at
>>>> that time almost _two years ago_ (June 2021), it means:
>>>>
>>>>     a) Some internal people really suggested EROFS could develop
>>>>        an entire new file-based in-kernel local cache subsystem
>>>>        (as you called local CAS, whatever) with stackable file
>>>>        interface so that the exist Nydus image service [1] (as
>>>>        ostree, and maybe ostree can use it as well) don't need to
>>>>        modify anything to use exist blobs;
>>>>
>>>>     b) Reuse exist fscache/cachefiles;
>>>>
>>>> The reason why we (especially me) finally selected b) because:
>>>>
>>>>     - see the people discussion of Google's original Incremental
>>>>       FS topic [2] [3] in 2019, as Amir already mentioned.  At
>>>>       that time all fs folks really like to reuse exist subsystem
>>>>       for in-kernel caching rather than reinvent another new
>>>>       in-kernel wheel for local cache.
>>>>
>>>>       [ Reinventing a new wheel is not hard (fs or caching), just
>>>>         makes Linux more fragmented.  Especially a new filesystem
>>>>         is just proposed to generate images full of massive massive
>>>>         new magical symlinks with *overriden* uid/gid/permissions
>>>>         to replace regular files. ]
>>>>
>>>>     - in-kernel cache implementation usually met several common
>>>>       potential security issues; reusing exist subsystem can
>>>>       make all fses addressed them and benefited from it.
>>>>
>>>>     - Usually an exist widely-used userspace implementation is
>>>>       never an excuse for a new in-kernel feature.
>>>>
>>>> Although David Howells is always quite busy these months to
>>>> develop new netfs interface, otherwise (we think) we should
>>>> already support failover, multiple daemon/dirs, daemonless and
>>>> more.
>>> we have not added any new cache system.  overlay does "layer
>>> deduplication" and in similar way composefs does "file deduplication".
>>> That is not a built-in feature, it is just a side effect of how things
>>> are packed together.
>>> Using fscache seems like a good idea and it has many advantages but
>>> it
>>> is a centralized cache mechanism and it looks like a potential problem
>>> when you think about allowing mounts from a user namespace.
>>
>> I think Christian [1] had the same feeling of my own at that time:
>>
>> "I'm pretty skeptical of this plan whether we should add more filesystems
>>   that are mountable by unprivileged users. FUSE and Overlayfs are
>>   adventurous enough and they don't have their own on-disk format. The
>>   track record of bugs exploitable due to userns isn't making this
>>   very attractive."
>>
>> Yes, you could add fs-verity, but EROFS could add fs-verity (or just use
>> dm-verity) as well, but it doesn't change _anything_ about concerns of
>> "allowing mounts from a user namespace".
> 
> I've mentioned that as a potential feature we could add in future, given
> the simplicity of the format and that it uses a CAS for its data instead
> of fscache.  Each user can have and use their own store to mount the
> images.
> 
> At this point it is just a wish from userspace, as it would improve a
> few real use cases we have.
> 
> Having the possibility to run containers without root privileges is a
> big deal for many users, look at Flatpak apps for example, or rootless
> Podman.  Mounting and validating images would be a a big security
> improvement.  It is something that is not possible at the moment as
> fs-verity doesn't cover the directory structure and dm-verity seems out
> of reach from a user namespace.
> 
> Composefs delegates the entire logic of dealing with files to the
> underlying file system in a similar way to overlay.
> 
> Forging the inode metadata from a user namespace mount doesn't look
> like an insurmountable problem as well since it is already possible
> with a FUSE filesystem.
> 
> So the proposal/wish here is to have a very simple format, that at some
> point could be considered safe to mount from a user namespace, in
> addition to overlay and FUSE.

My response is quite similar to
https://lore.kernel.org/r/CAJfpeguyajzHwhae=4PWLF4CUBorwFWeybO-xX6UBD2Ekg81fg@mail.gmail.com/

> 
> 
>>> As you know as I've contacted you, I've looked at EROFS in the past
>>> and tried to get our use cases to work with it before thinking about
>>> submitting composefs upstream.
>>>   From what I could see EROFS and composefs use two different
>>> approaches
>>> to solve a similar problem, but it is not possible to do exactly with
>>> EROFS what we are trying to do.  To oversimplify it: I see EROFS as a
>>> block device that uses fscache, and composefs as an overlay for files
>>> instead of directories.
>>
>> I don't think so honestly.  EROFS "Multiple device" feature is
>> actually "multiple blobs" feature if you really think "device"
>> is block device.
>>
>> Primary device -- primary blob -- "composefs manifest blob"
>> Blob device -- data blobs -- "composefs backing files"
>>
>> any difference?
> 
> I wouldn't expect any substancial difference between two RO file
> systems.
> 
> Please correct me if I am wrong: EROFS uses 16 bits for the blob device
> ID, so if we map each file to a single blob device we are kind of
> limited on how many files we can have.

I was here just to represent "composefs manifest file" concept rather than
device ID.

> Sure this is just an artificial limit and can be bumped in a future
> version but the major difference remains: EROFS uses the blob device
> through fscache while the composefs files are looked up in the specified
> repositories.

No, fscache can also open any cookie when opening file.  Again, even with
fscache, EROFS doesn't need to modify _any_ on-disk format to:

   - record a "cookie id" for such special "magical symlink" with a similar
     symlink on-disk format (or whatever on-disk format with data, just with
     a new on-disk flag);

   - open such "cookie id" on demand when opening such EROFS file just as
     any other network fses.  I don't think blob device is limited here.

some difference now?

> 
>>> Sure composefs is quite simple and you could embed the composefs
>>> features in EROFS and let EROFS behave as composefs when provided a
>>> similar manifest file.  But how is that any better than having a
>>
>> EROFS always has such feature since v5.16, we called primary device,
>> or Nydus concept --- "bootstrap file".
>>
>>> separate implementation that does just one thing well instead of merging
>>> different paradigms together?
>>
>> It's exist fs on-disk compatible (people can deploy the same image
>> to wider scenarios), or you could modify/enhacnce any in-kernel local
>> fs to do so like I already suggested, such as enhancing "fs/romfs" and
>> make it maintained again due to this magic symlink feature
>>
>> (because composefs don't have other on-disk requirements other than
>>   a symlink path and a SHA256 verity digest from its original
>>   requirement.  Any local fs can be enhanced like this.)
>>
>>>
>>>> I know that you guys repeatedly say it's a self-contained
>>>> stackable fs and has few code (the same words as Incfs
>>>> folks [3] said four years ago already), four reasons make it
>>>> weak IMHO:
>>>>
>>>>     - I think core EROFS is about 2~3 kLOC as well if
>>>>       compression, sysfs and fscache are all code-truncated.
>>>>
>>>>       Also, it's always welcome that all people could submit
>>>>       patches for cleaning up.  I always do such cleanups
>>>>       from time to time and makes it better.
>>>>
>>>>     - "Few code lines" is somewhat weak because people do
>>>>       develop new features, layout after upstream.
>>>>
>>>>       Such claim is usually _NOT_ true in the future if you
>>>>       guys do more to optimize performance, new layout or even
>>>>       do your own lazy pulling with your local CAS codebase in
>>>>       the future unless
>>>>       you *promise* you once dump the code, and do bugfix
>>>>       only like Christian said [4].
>>>>
>>>>       From LWN.net comments, I do see the opposite
>>>>       possibility that you'd like to develop new features
>>>>       later.
>>>>
>>>>     - In the past, all in-tree kernel filesystems were
>>>>       designed and implemented without some user-space
>>>>       specific indication, including Nydus and ostree (I did
>>>>       see a lot of discussion between folks before in ociv2
>>>>       brainstorm [5]).
>>> Since you are mentioning OCI:
>>> Potentially composefs can be the file system that enables something
>>> very
>>> close to "ociv2", but it won't need to be called v2 since it is
>>> completely compatible with the current OCI image format.
>>> It won't require a different image format, just a seekable tarball
>>> that
>>> is compatible with old "v1" clients and we need to provide the composefs
>>> manifest file.
>>
>> May I ask did you really look into what Nydus + EROFS already did (as you
>> mentioned we discussed before)?
>>
>> Your "composefs manifest file" is exactly "Nydus bootstrap file", see:
>> https://github.com/dragonflyoss/image-service/blob/master/docs/nydus-design.md
>>
>> "Rafs is a filesystem image containing a separated metadata blob and
>>   several data-deduplicated content-addressable data blobs. In a typical
>>   rafs filesystem, the metadata is stored in bootstrap while the data
>>   is stored in blobfile.
>>   ...
>>
>>   bootstrap:  The metadata is a merkle tree (I think that is typo, should be
>>   filesystem tree) whose nodes represents a regular filesystem's
>>   directory/file a leaf node refers to a file and contains hash value of
>>   its file data.
>>     Root node and internal nodes refer to directories and contain the
>>    hash value
>>   of their children nodes."
>>
>> Nydus is already supported "It won't require a different image format, just
>> a seekable tarball that is compatible with old "v1" clients and we need to
>> provide the composefs manifest file." feature in v2.2 and will be released
>> later.
> 
> Nydus is not using a tarball compatible with OCI v1.
> 
> It defines a media type "application/vnd.oci.image.layer.nydus.blob.v1", that
> means it is not compatible with existing clients that don't know about
> it and you need special handling for that.

I am not sure what you're saying: "media type" is quite out of topic here.

If you said "mkcomposefs" is done in the server side, what is the media
type of such manifest files?

And why not Nydus cannot do in the same way?
https://github.com/dragonflyoss/image-service/blob/master/docs/nydus-zran.md

> 
> Anyway, let's not bother LKML folks with these userspace details.  It
> has no relevance to the kernel and what file systems do.

I'd like to avoid, I did't say anything about userspace details, I just would
like to say
"merged filesystem tree is also _not_ a new idea of composefs"
not "media type", etc.

> 
> 
>>> The seekable tarball allows individual files to be retrieved.  OCI
>>> clients will not need to pull the entire tarball, but only the individual
>>> files that are not already present in the local CAS. They won't also need
>>> to create the overlay layout at all, as we do today, since it is already
>>> described with the composefs manifest file.
>>> The manifest is portable on different machines with different
>>> configurations, as you can use multiple CAS when mounting composefs.
>>> Some users might have a local CAS, some others could have a
>>> secondary
>>> CAS on a network file system and composefs support all these
>>> configurations with the same signed manifest file.
>>>
>>>>       That is why EROFS selected exist in-kernel fscache and
>>>>       made userspace Nydus adapt it:
>>>>
>>>>         even (here called) manifest on-disk format ---
>>>>              EROFS call primary device ---
>>>>              they call Nydus bootstrap;
>>>>
>>>>       I'm not sure why it becomes impossible for ... ($$$$).
>>> I am not sure what you mean, care to elaborate?
>>
>> I just meant these concepts are actually the same concept with
>> different names and:
>>    Nydus is a 2020 stuff;
> 
> CRFS[1] is 2019 stuff.

Does CRFS have anything similiar to a merged filesystem tree?

Here we talked about local CAS:
I have no idea CRFS has anything similar to it.

> 
>>    EROFS + primary device is a 2021-mid stuff.
>>
>>>> In addition, if fscache is used, it can also use
>>>> fsverity_get_digest() to enable fsverity for non-on-demand
>>>> files.
>>>>
>>>> But again I think even Google's folks think that is
>>>> (somewhat) broken so that they added fs-verity to its incFS
>>>> in a self-contained way in Feb 2021 [6].
>>>>
>>>> Finally, again, I do hope a LSF/MM discussion for this new
>>>> overlay model (full of massive magical symlinks to override
>>>> permission.)
>>> you keep pointing it out but nobody is overriding any permission.
>>> The
>>> "symlinks" as you call them are just a way to refer to the payload files
>>> so they can be shared among different mounts.  It is the same idea used
>>> by "overlay metacopy" and nobody is complaining about it being a
>>> security issue (because it is not).
>>
>> See overlay documentation clearly wrote such metacopy behavior:
>> https://docs.kernel.org/filesystems/overlayfs.html
>>
>> "
>> Do not use metacopy=on with untrusted upper/lower directories.
>> Otherwise it is possible that an attacker can create a handcrafted file
>> with appropriate REDIRECT and METACOPY xattrs, and gain access to file
>> on lower pointed by REDIRECT. This should not be possible on local
>> system as setting “trusted.” xattrs will require CAP_SYS_ADMIN. But
>> it should be possible for untrusted layers like from a pen drive.
>> "
>>
>> Do we really need such behavior working on another fs especially with
>> on-disk format?  At least Christian said,
>> "FUSE and Overlayfs are adventurous enough and they don't have their
>> own on-disk format."
> 
> If users want to do something really weird then they can always find a
> way but the composefs lookup is limited under the directories specified
> at mount time, so it is not possible to access any file outside the
> repository.
> 
> 
>>> The files in the CAS are owned by the user that creates the mount,
>>> so
>>> there is no need to circumvent any permission check to access them.
>>> We use fs-verity for these files to make sure they are not modified by a
>>> malicious user that could get access to them (e.g. a container breakout).
>>
>> fs-verity is not always enforcing and it's broken here if fsverity is not
>> supported in underlay fses, that is another my arguable point.
> 
> It is a trade-off.  It is up to the user to pick a configuration that
> allows using fs-verity if they care about this feature.

I don't think fsverity is optional with your plan.

I wrote this all because it seems I didn't mention the original motivation
to use fscache in v2: kernel already has such in-kernel local cache, and
people liked to use it in 2019 rather than another stackable way (as
mentioned in incremental fs thread.)

Thanks,
Gao Xiang

> 
> Regards,
> Giuseppe
> 
> [1] https://github.com/google/crfs
