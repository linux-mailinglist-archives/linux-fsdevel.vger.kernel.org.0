Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299FD6897C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 12:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjBCLdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 06:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjBCLdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44E13DD8
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Feb 2023 03:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675423940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YMxBc6Qx2mQP/U4a3uk+Re92Kb3SNZ/mfutNOwJP8zE=;
        b=RuQaTt5QneI7gGPQTbTA71nsoOrmvQ6NuiAZyMnMbcMllT6xrffit4O2g6QaUWSrI16b7K
        8R/MeRX20oToS7b7O5rD6N3Ybu1G5zrpiaiYPtXdCENrY4Vs5ofDNUkuNLPSaYVgXa6gK8
        Ky960qS0xmOahxVCbHq6LI/9ZOE/QWY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-fK8-FfVzODKdn4Lc8KYGpw-1; Fri, 03 Feb 2023 06:32:19 -0500
X-MC-Unique: fK8-FfVzODKdn4Lc8KYGpw-1
Received: by mail-ed1-f72.google.com with SMTP id g25-20020aa7c859000000b004a3fe4cbb0cso3393135edt.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Feb 2023 03:32:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMxBc6Qx2mQP/U4a3uk+Re92Kb3SNZ/mfutNOwJP8zE=;
        b=b3LooXxkPVN93dj+NY7ojn/O60oyZ5KUhdLl/b1lc8bsaGrAx8jjqYFGLk6eGjg+Ql
         EKTDTXOUkzy275/ruVPYCiETMSn1S065/wZutx5vLtes5i4lMn02YBQrlYp6ppsaGjGb
         VkLXf5zDzLUbcbUyAtsy5B4SgjTeB1bO3N41FCm2H/bmunPrjcyj4L/4bb5RZ/UscYXM
         nh+QQ3InKRJYoAaXJHdNiA9J+MgNueMi2Funt4yel1v5LHkuKGZ9D/JFK399SN4ufPeH
         h7bMXpmx2eTEPLT+QPZGbHNnDGE+t6pkT/qLSyq2+sJ9NUG+RNhs2BK92NlmJbjGBtFn
         b2WA==
X-Gm-Message-State: AO0yUKVWlTSHYDYaYfuzL3qceU39/EAC9fvycMSnf+iaD6A5Rls4I3rD
        0UB2AlT3JiwqLkDzFrA58CFoD/KCX5gczQCeH7anuZ+wNslPRHmf3zKsaMRTizdJFuQRkKjhbnu
        6YlXWmThgMqaYPc86a5cvfpwfZw==
X-Received: by 2002:a17:906:3bc3:b0:87f:89f2:c012 with SMTP id v3-20020a1709063bc300b0087f89f2c012mr9618136ejf.24.1675423937704;
        Fri, 03 Feb 2023 03:32:17 -0800 (PST)
X-Google-Smtp-Source: AK7set88l6T5MDa5fcgFZm6kEiCryVfsXDnS5CPBJsuoTovgp2+j5kZMOzF6GC1LjmqN/n8i2PZwxg==
X-Received: by 2002:a17:906:3bc3:b0:87f:89f2:c012 with SMTP id v3-20020a1709063bc300b0087f89f2c012mr9618112ejf.24.1675423937429;
        Fri, 03 Feb 2023 03:32:17 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170906f6ca00b00878812a8d14sm1250755ejb.85.2023.02.03.03.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 03:32:16 -0800 (PST)
Message-ID: <3d4b17795413a696b373553147935bf1560bb8c0.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Jingbo Xu <jefflexu@linux.alibaba.com>, gscrivan@redhat.com,
        brauner@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@fromorbit.com,
        viro@zeniv.linux.org.uk, Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 03 Feb 2023 12:32:15 +0100
In-Reply-To: <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
References: <cover.1674227308.git.alexl@redhat.com>
         <CAOQ4uxgGc33_QVBXMbQTnmbpHio4amv=W7ax2vQ1UMet0k_KoA@mail.gmail.com>
         <1ea88c8d1e666b85342374ed7c0ddf7d661e0ee1.camel@redhat.com>
         <CAOQ4uxinsBB-LpGh4h44m6Afv0VT5yWRveDG7sNvE2uJyEGOkg@mail.gmail.com>
         <5fb32a1297821040edd8c19ce796fc0540101653.camel@redhat.com>
         <CAOQ4uxhGX9NVxwsiBMP0q21ZRot6-UA0nGPp1wGNjgmKBjjBBA@mail.gmail.com>
         <b8601c976d6e5d3eccf6ef489da9768ad72f9571.camel@redhat.com>
         <e840d413-c1a7-d047-1a63-468b42571846@linux.alibaba.com>
         <2ef122849d6f35712b56ffbcc95805672980e185.camel@redhat.com>
         <8ffa28f5-77f6-6bde-5645-5fb799019bca@linux.alibaba.com>
         <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
         <071074ad149b189661681aada453995741f75039.camel@redhat.com>
         <0d2ef9d6-3b0e-364d-ec2f-c61b19d638e2@linux.alibaba.com>
         <de57aefc-30e8-470d-bf61-a1cca6514988@linux.alibaba.com>
         <CAOQ4uxgS+-MxydqgO8+NQfOs9N881bHNbov28uJYX9XpthPPiw@mail.gmail.com>
         <9c8e76a3-a60a-90a2-f726-46db39bc6558@linux.alibaba.com>
         <02edb5d6-a232-eed6-0338-26f9a63cfdb6@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-02-02 at 15:37 +0800, Gao Xiang wrote:
>=20
>=20
> On 2023/2/2 15:17, Gao Xiang wrote:
> >=20
> >=20
> > On 2023/2/2 14:37, Amir Goldstein wrote:
> > > On Wed, Feb 1, 2023 at 1:22 PM Gao Xiang
> > > <hsiangkao@linux.alibaba.com> wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > On 2023/2/1 18:01, Gao Xiang wrote:
> > > > >=20
> > > > >=20
> > > > > On 2023/2/1 17:46, Alexander Larsson wrote:
> > > > >=20
> > > > > ...
> > > > >=20
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | uncached(ms)|
> > > > > > > cached(ms)
> > > > > > > ----------------------------------|-------------|--------
> > > > > > > ---
> > > > > > > composefs (with digest)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 326=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 135
> > > > > > > erofs (w/o -T0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 264=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 172
> > > > > > > erofs (w/o -T0) + overlayfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 651=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 238
> > > > > > > squashfs (compressed)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 538=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 211
> > > > > > > squashfs (compressed) + overlayfs | 968=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 302
> > > > > >=20
> > > > > >=20
> > > > > > Clearly erofs with sparse files is the best fs now for the
> > > > > > ro-fs +
> > > > > > overlay case. But still, we can see that the additional
> > > > > > cost of the
> > > > > > overlayfs layer is not negligible.
> > > > > >=20
> > > > > > According to amir this could be helped by a special
> > > > > > composefs-like mode
> > > > > > in overlayfs, but its unclear what performance that would
> > > > > > reach, and
> > > > > > we're then talking net new development that further
> > > > > > complicates the
> > > > > > overlayfs codebase. Its not clear to me which alternative
> > > > > > is easier to
> > > > > > develop/maintain.
> > > > > >=20
> > > > > > Also, the difference between cached and uncached here is
> > > > > > less than in
> > > > > > my tests. Probably because my test image was larger. With
> > > > > > the test
> > > > > > image I use, the results are:
> > > > > >=20
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
uncached(ms)|
> > > > > > cached(ms)
> > > > > > ----------------------------------|-------------|----------
> > > > > > -
> > > > > > composefs (with digest)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 681=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 390
> > > > > > erofs (w/o -T0) + overlayfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 1788=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 532
> > > > > > squashfs (compressed) + overlayfs | 2547=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 443
> > > > > >=20
> > > > > >=20
> > > > > > I gotta say it is weird though that squashfs performed
> > > > > > better than
> > > > > > erofs in the cached case. May be worth looking into. The
> > > > > > test data I'm
> > > > > > using is available here:
> > > > >=20
> > > > > As another wild guess, cached performance is a just vfs-
> > > > > stuff.
> > > > >=20
> > > > > I think the performance difference may be due to ACL (since
> > > > > both
> > > > > composefs and squashfs don't support ACL).=C2=A0 I already asked
> > > > > Jingbo
> > > > > to get more "perf data" to analyze this but he's now busy in
> > > > > another
> > > > > stuff.
> > > > >=20
> > > > > Again, my overall point is quite simple as always, currently
> > > > > composefs is a read-only filesystem with massive symlink-like
> > > > > files.
> > > > > It behaves as a subset of all generic read-only filesystems
> > > > > just
> > > > > for this specific use cases.
> > > > >=20
> > > > > In facts there are many options to improve this (much like
> > > > > Amir
> > > > > said before):
> > > > > =C2=A0=C2=A0=C2=A0 1) improve overlayfs, and then it can be used =
with any
> > > > > local fs;
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 2) enhance erofs to support this (even without=
 on-disk
> > > > > change);
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0 3) introduce fs/composefs;
> > > > >=20
> > > > > In addition to option 1), option 2) has many benefits as
> > > > > well, since
> > > > > your manifest files can save real regular files in addition
> > > > > to composefs
> > > > > model.
> > > >=20
> > > > (add some words..)
> > > >=20
> > > > My first response at that time (on Slack) was "kindly request
> > > > Giuseppe to ask in the fsdevel mailing list if this new overlay
> > > > model
> > > > and use cases is feasable", if so, I'm much happy to integrate
> > > > in to
> > > > EROFS (in a cooperative way) in several ways:
> > > >=20
> > > > =C2=A0=C2=A0 - just use EROFS symlink layout and open such file in =
a
> > > > stacked way;
> > > >=20
> > > > or (now)
> > > >=20
> > > > =C2=A0=C2=A0 - just identify overlayfs "trusted.overlay.redirect" i=
n
> > > > EROFS itself
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 and open file so such image can be both us=
ed for EROFS
> > > > only and
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 EROFS + overlayfs.
> > > >=20
> > > > If that happened, then I think the overlayfs "metacopy" option
> > > > can
> > > > also be shown by other fs community people later (since I'm not
> > > > an
> > > > overlay expert), but I'm not sure why they becomes impossible
> > > > finally
> > > > and even not mentioned at all.
> > > >=20
> > > > Or if you guys really don't want to use EROFS for whatever
> > > > reasons
> > > > (EROFS is completely open-source, used, contributed by many
> > > > vendors),
> > > > you could improve squashfs, ext4, or other exist local fses
> > > > with this
> > > > new use cases (since they don't need any on-disk change as
> > > > well, for
> > > > example, by using some xattr), I don't think it's really hard.
> > > >=20
> > >=20
> > > Engineering-wise, merging composefs features into EROFS
> > > would be the simplest option and FWIW, my personal preference.
> > >=20
> > > However, you need to be aware that this will bring into EROFS
> > > vfs considerations, such as=C2=A0 s_stack_depth nesting (which AFAICS
> > > is not see incremented composefs?). It's not the end of the
> > > world, but this
> > > is no longer plain fs over block game. There's a whole new class
> > > of bugs
> > > (that syzbot is very eager to explore) so you need to ask
> > > yourself whether
> > > this is a direction you want to lead EROFS towards.
> >=20
> > I'd like to make a seperated Kconfig for this.=C2=A0 I consider this
> > just because
> > currently composefs is much similar to EROFS but it doesn't have
> > some ability
> > to keep real regular file (even some README, VERSION or Changelog
> > in these
> > images) in its (composefs-called) manifest files. Even its on-disk
> > super block
> > doesn't have a UUID now [1] and some boot sector for booting or
> > some potential
> > hybird formats such as tar + EROFS, cpio + EROFS.
> >=20
> > I'm not sure if those potential new on-disk features is unneeded
> > even for
> > future composefs.=C2=A0 But if composefs laterly supports such on-disk
> > features,
> > that makes composefs closer to EROFS even more.=C2=A0 I don't see
> > disadvantage to
> > make these actual on-disk compatible (like ext2 and ext4).
> >=20
> > The only difference now is manifest file itself I/O interface --
> > bio vs file.
> > but EROFS can be distributed to raw block devices as well,
> > composefs can't.
> >=20
> > Also, I'd like to seperate core-EROFS from advanced features (or
> > people who
> > are interested to work on this are always welcome) and composefs-
> > like model,
> > if people don't tend to use any EROFS advanced features, it could
> > be disabled
> > from compiling explicitly.
>=20
> Apart from that, I still fail to get some thoughts (apart from
> unprivileged
> mounts) how EROFS + overlayfs combination fails on automative real
> workloads
> aside from "ls -lR" (readdir + stat).
>=20
> And eventually we still need overlayfs for most use cases to do
> writable
> stuffs, anyway, it needs some words to describe why such < 1s
> difference is
> very very important to the real workload as you already mentioned
> before.
>=20
> And with overlayfs lazy lookup, I think it can be close to ~100ms or
> better.
>=20

If we had an overlay.fs-verity xattr, then I think there are no
individual features lacking for it to work for the automotive usecase
I'm working on. Nor for the OCI container usecase. However, the
possibility of doing something doesn't mean it is the better technical
solution.

The container usecase is very important in real world Linux use today,
and as such it makes sense to have a technically excellent solution for
it, not just a workable solution. Obviously we all have different
viewpoints of what that is, but these are the reasons why I think a
composefs=C2=A0solution is better:

* It is faster than all other approaches for the one thing it actually
needs to do (lookup and readdir performance). Other kinds of
performance (file i/o speed, etc) is up to the backing filesystem
anyway.=C2=A0

Even if there are possible approaches to make overlayfs perform better
here (the "lazy lookup" idea) it will not reach the performance of
composefs, while further complicating the overlayfs codebase. (btw, did
someone ask Miklos what he thinks of that idea?)

For the automotive usecase we have strict cold-boot time requirements
that make cold-cache performance very important to us. Of course, there
is no simple time requirements for the specific case of listing files
in an image, but any improvement in cold-cache performance for both the
ostree rootfs and the containers started during boot will be worth its
weight in gold trying to reach these hard KPIs.

* It uses less memory, as we don't need the extra inodes that comes
with the overlayfs mount. (See profiling data in giuseppes mail[1]).

The use of loopback vs directly reading the image file from page cache
also have effects on memory use. Normally we have both the loopback
file in page cache, plus the block cache for the loopback device. We
could use loopback with O_DIRECT, but then we don't use the page cache
for the image file, which I think could have performance implications.

* The userspace API complexity of the combined overlayfs approach is
much greater than for composefs, with more moving pieces. For
composefs, all you need is a single mount syscall for set up. For the
overlay approach you would need to first create a loopback device, then
create a dm-verity device-mapper device from it, then mount the
readonly fs, then mount the overlayfs. All this complexity has a cost
in terms of setup/teardown performance, userspace complexity and
overall memory use.

Are any of these a hard blocker for the feature? Not really, but I
would find it sad to use an (imho) worse solution.



The other mentioned approach is to extend EROFS with composefs
features.=C2=A0 For this to be interesting to me it would have to include:=
=C2=A0

 * Direct reading of the image from page cache (not via loopback)
 * Ability to verify fs-verity digest of that image file
 * Support for stacked content files in a set of specified basedirs=C2=A0
   (not using fscache).
 * Verification of expected fs-verity digest for these basedir files

Anything less than this and I think the overlayfs+erofs approach is a
better choice.

However, this is essentially just proposing we re-implement all the
composefs code with a different name. And then we get a filesystem
supporting *both* stacking and traditional block device use, which
seems a bit weird to me. It will certainly=C2=A0make the erofs code more
complex having to support all these combinations.=C2=A0Also, given the hars=
h
arguments and accusations towards me on the list I don't feel very
optimistic about how well such a cooperation would work.

(A note about Kconfig options: I'm totally uninterested in using a
custom build of erofs. We always use a standard distro kernel that has
to support all possible uses of erofs, so we can't ship a neutered
version of it.)


[1] https://lore.kernel.org/lkml/87wn5ac2z6.fsf@redhat.com/

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a world-famous day-dreaming cop on his last day in the job. She's
a=20
plucky streetsmart wrestler descended from a line of powerful witches.=20
They fight crime!=20

