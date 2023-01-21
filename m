Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24237676340
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 04:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjAUDIW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 22:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjAUDIW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 22:08:22 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F9564A7;
        Fri, 20 Jan 2023 19:08:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VZxLIEi_1674270494;
Received: from 192.168.1.38(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VZxLIEi_1674270494)
          by smtp.aliyun-inc.com;
          Sat, 21 Jan 2023 11:08:15 +0800
Message-ID: <321dfdb1-3771-b16d-604f-224ce8aa22cf@linux.alibaba.com>
Date:   Sat, 21 Jan 2023 11:08:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
To:     Giuseppe Scrivano <gscrivan@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cover.1674227308.git.alexl@redhat.com>
 <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
 <87ilh0g88n.fsf@redhat.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87ilh0g88n.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/1/21 06:18, Giuseppe Scrivano wrote:
> Hi Amir,
> 
> Amir Goldstein <amir73il@gmail.com> writes:
> 
>> On Fri, Jan 20, 2023 at 5:30 PM Alexander Larsson <alexl@redhat.com> wrote:

...

>>>
>>
>> Hi Alexander,
>>
>> I must say that I am a little bit puzzled by this v3.
>> Gao, Christian and myself asked you questions on v2
>> that are not mentioned in v3 at all.
>>
>> To sum it up, please do not propose composefs without explaining
>> what are the barriers for achieving the exact same outcome with
>> the use of a read-only overlayfs with two lower layer -
>> uppermost with erofs containing the metadata files, which include
>> trusted.overlay.metacopy and trusted.overlay.redirect xattrs that refer
>> to the lowermost layer containing the content files.
> 
> I think Dave explained quite well why using overlay is not comparable to
> what composefs does.
> 
> One big difference is that overlay still requires at least a syscall for
> each file in the image, and then we need the equivalent of "rm -rf" to
> clean it up.  It is somehow acceptable for long-running services, but it
> is not for "serverless" containers where images/containers are created
> and destroyed frequently.  So even in the case we already have all the
> image files available locally, we still need to create a checkout with
> the final structure we need for the image.
> 
> I also don't see how overlay would solve the verified image problem.  We
> would have the same problem we have today with fs-verity as it can only
> validate a single file but not the entire directory structure.  Changes
> that affect the layer containing the trusted.overlay.{metacopy,redirect}
> xattrs won't be noticed.
> 
> There are at the moment two ways to handle container images, both somehow
> guided by the available file systems in the kernel.
> 
> - A single image mounted as a block device.
> - A list of tarballs (OCI image) that are unpacked and mounted as
>    overlay layers.
> 
> One big advantage of the block devices model is that you can use
> dm-verity, this is something we miss today with OCI container images
> that use overlay.
> 
> What we are proposing with composefs is a way to have "dm-verity" style
> validation based on fs-verity and the possibility to share individual
> files instead of layers.  These files can also be on different file
> systems, which is something not possible with the block device model.

That is not a new idea honestly, including chain of trust.  Even laterly
out-of-tree incremental fs using fs-verity for this as well, except that
it's in a real self-contained way.

> 
> The composefs manifest blob could be generated remotely and signed.  A
> client would need just to validate the signature for the manifest blob
> and from there retrieve the files that are not in the local CAS (even
> from an insecure source) and mount directly the manifest file.


Back to the topic, after thinking something I have to make a
compliment for reference.

First, EROFS had the same internal dissussion and decision at
that time almost _two years ago_ (June 2021), it means:

   a) Some internal people really suggested EROFS could develop
      an entire new file-based in-kernel local cache subsystem
      (as you called local CAS, whatever) with stackable file
      interface so that the exist Nydus image service [1] (as
      ostree, and maybe ostree can use it as well) don't need to
      modify anything to use exist blobs;

   b) Reuse exist fscache/cachefiles;

The reason why we (especially me) finally selected b) because:

   - see the people discussion of Google's original Incremental
     FS topic [2] [3] in 2019, as Amir already mentioned.  At
     that time all fs folks really like to reuse exist subsystem
     for in-kernel caching rather than reinvent another new
     in-kernel wheel for local cache.

     [ Reinventing a new wheel is not hard (fs or caching), just
       makes Linux more fragmented.  Especially a new filesystem
       is just proposed to generate images full of massive massive
       new magical symlinks with *overriden* uid/gid/permissions
       to replace regular files. ]

   - in-kernel cache implementation usually met several common
     potential security issues; reusing exist subsystem can
     make all fses addressed them and benefited from it.

   - Usually an exist widely-used userspace implementation is
     never an excuse for a new in-kernel feature.

Although David Howells is always quite busy these months to
develop new netfs interface, otherwise (we think) we should
already support failover, multiple daemon/dirs, daemonless and
more.

I know that you guys repeatedly say it's a self-contained
stackable fs and has few code (the same words as Incfs
folks [3] said four years ago already), four reasons make it
weak IMHO:

   - I think core EROFS is about 2~3 kLOC as well if
     compression, sysfs and fscache are all code-truncated.

     Also, it's always welcome that all people could submit
     patches for cleaning up.  I always do such cleanups
     from time to time and makes it better.

   - "Few code lines" is somewhat weak because people do
     develop new features, layout after upstream.

     Such claim is usually _NOT_ true in the future if you
     guys do more to optimize performance, new layout or even
     do your own lazy pulling with your local CAS codebase in
     the future unless
     you *promise* you once dump the code, and do bugfix
     only like Christian said [4].

     From LWN.net comments, I do see the opposite
     possibility that you'd like to develop new features
     later.

   - In the past, all in-tree kernel filesystems were
     designed and implemented without some user-space
     specific indication, including Nydus and ostree (I did
     see a lot of discussion between folks before in ociv2
     brainstorm [5]).

     That is why EROFS selected exist in-kernel fscache and
     made userspace Nydus adapt it:

       even (here called) manifest on-disk format ---
            EROFS call primary device ---
            they call Nydus bootstrap;

     I'm not sure why it becomes impossible for ... ($$$$).

In addition, if fscache is used, it can also use
fsverity_get_digest() to enable fsverity for non-on-demand
files.

But again I think even Google's folks think that is
(somewhat) broken so that they added fs-verity to its incFS
in a self-contained way in Feb 2021 [6].

Finally, again, I do hope a LSF/MM discussion for this new
overlay model (full of massive magical symlinks to override
permission.)

[1] https://github.com/dragonflyoss/image-service
[2] https://lore.kernel.org/r/CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com/
[3] https://lore.kernel.org/r/CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com/
[4] https://lore.kernel.org/r/20230117101202.4v4zxuj2tbljogbx@wittgenstein/
[5] https://hackmd.io/@cyphar/ociv2-brainstorm
[6] https://android-review.googlesource.com/c/kernel/common/+/1444521

Thanks,
Gao Xiang

> 
> Regards,
> Giuseppe
> 
>> Any current functionality gap in erofs and/or in overlayfs
>> cannot be considered as a reason to maintain a new filesystem
>> driver unless you come up with an explanation why closing that
>> functionality gap is not possible or why the erofs+overlayfs alternative
>> would be inferior to maintaining a new filesystem driver.
>>
>>  From the conversations so far, it does not seem like Gao thinks
>> that the functionality gap in erofs cannot be closed and I don't
>> see why the functionality gap in overlayfs cannot be closed.
>>
>> Are we missing something?
>>
>> Thanks,
>> Amir.
> 
