Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BEE68631B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 10:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjBAJrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 04:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjBAJrs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68499760
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 01:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675244818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nX3Sju01yAvnUklbguJHQoTEONurdEPyIljO4LvviIw=;
        b=S9nXMzPaoY5eRwisC7oFqYfr1xRRehq7eCm3qrLg1/weEd8jz/4u6DqsXzy9G/G3Mb5UvT
        P9DrngAE+ansfoGNjYCXRDeo+s2MeFkjf6JSau5sD4u3ZWEXULXfh12mzUkAaEQWt4t/A9
        U8d04A0NxZeOkbZ4EpoY/S1bkQXFyg8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-RlcE8CmhP76LRzrNZhzakQ-1; Wed, 01 Feb 2023 04:46:57 -0500
X-MC-Unique: RlcE8CmhP76LRzrNZhzakQ-1
Received: by mail-ej1-f69.google.com with SMTP id qc18-20020a170906d8b200b0088e3a3a02b6so366821ejb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Feb 2023 01:46:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nX3Sju01yAvnUklbguJHQoTEONurdEPyIljO4LvviIw=;
        b=n2AJL9wt8l87xjHM6nMajffVp66uSrnB7RTAdZ4ASeIfDYJfv5yeOusvqXMnrWfv31
         smKpDlOwTzK5mgFXIQ0tsJmCAE2pffMfrZyQN0tm0LJP9I0s6eILSmK20xfNnPJgKL3F
         wi9axCB7SlKcWyRssrtxYt30G5SUPxDf9+o1anSO7g2RidzxELo5XJb5mUE8bRBK+uB1
         PTp+I8FNP5MaUbICAMvYM8LS1ZO7g9ZQvQKpv9FdhTqrCrTYE0/Sg2w+/CcIwWD72xGZ
         v6djSJgCykXEIKFrQp13Bpy2fka8na44ajzGEjB1TjmN24nC6lWcrqKi3JloJxVRr2qy
         /yFw==
X-Gm-Message-State: AO0yUKWwDga1m9q5sQw9baKs1y2CrU6lvuBzVu1HJs8oU0L+hMg9NS6E
        +SSYBHrhnUtl2h4vn7sXPfwt2SC55JmDKBt3pPfAdi/XKcl0teBrfcRiDVP1uF3Dk5Q2B/9rA47
        /2ipkuQBzlOJEdgk6+ut+5+HSBg==
X-Received: by 2002:a17:906:5dcb:b0:877:61e8:915a with SMTP id p11-20020a1709065dcb00b0087761e8915amr1127499ejv.75.1675244816309;
        Wed, 01 Feb 2023 01:46:56 -0800 (PST)
X-Google-Smtp-Source: AK7set+5x0GFlMZdMQ7po8ZqDuDaJg67N4TVXFKMI+cgeM+B85VRZVl9KDVVwhGIMA9idUiIFSmcxg==
X-Received: by 2002:a17:906:5dcb:b0:877:61e8:915a with SMTP id p11-20020a1709065dcb00b0087761e8915amr1127481ejv.75.1675244816095;
        Wed, 01 Feb 2023 01:46:56 -0800 (PST)
Received: from greebo.mooo.com (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.gmail.com with ESMTPSA id l23-20020a50d6d7000000b004a0b1d7e39csm9584437edj.51.2023.02.01.01.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 01:46:55 -0800 (PST)
Message-ID: <071074ad149b189661681aada453995741f75039.camel@redhat.com>
Subject: Re: [PATCH v3 0/6] Composefs: an opportunistically sharing verified
 image filesystem
From:   Alexander Larsson <alexl@redhat.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Amir Goldstein <amir73il@gmail.com>, gscrivan@redhat.com,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@fromorbit.com, viro@zeniv.linux.org.uk,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 01 Feb 2023 10:46:54 +0100
In-Reply-To: <51d9d1b3-2b2a-9b58-2f7f-f3a56c9e04ac@linux.alibaba.com>
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

On Wed, 2023-02-01 at 12:28 +0800, Jingbo Xu wrote:
> Hi all,
>=20
> There are some updated performance statistics with different
> combinations on my test environment if you are interested.
>=20
>=20
> On 1/27/23 6:24 PM, Gao Xiang wrote:
> > ...
> >=20
> > I've made a version and did some test, it can be fetched from:
> > git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
> > -b
> > experimental
> >=20
>=20
> Setup
> =3D=3D=3D=3D=3D=3D
> CPU: x86_64 Intel(R) Xeon(R) Platinum 8269CY CPU @ 2.50GHz
> Disk: 6800 IOPS upper limit
> OS: Linux v6.2 (with composefs v3 patchset)

For the record, what was the filesystem backing the basedir files?

> I build erofs/squashfs images following the scripts attached on [1],
> with each file in the rootfs tagged with "metacopy" and "redirect"
> xattr.
>=20
> The source rootfs is from the docker image of tensorflow [2].
>=20
> The erofs images are built with mkfs.erofs with support for sparse
> file
> added [3].
>=20
> [1]
> https://lore.kernel.org/linux-fsdevel/5fb32a1297821040edd8c19ce796fc05401=
01653.camel@redhat.com/
> [2]
> https://hub.docker.com/layers/tensorflow/tensorflow/2.10.0/images/sha256-=
7f9f23ce2473eb52d17fe1b465c79c3a3604047343e23acc036296f512071bc9?context=3D=
explore
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/com=
mit/?h=3Dexperimental&id=3D7c49e8b195ad90f6ca9dfccce9f6e3e39a8676f6
>=20
>=20
>=20
> Image size
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 6.4M large.composefs
> 5.7M large.composefs.w/o.digest (w/o --compute-digest)
> 6.2M large.erofs
> 5.2M large.erofs.T0 (with -T0, i.e. w/o nanosecond timestamp)
> 1.7M large.squashfs
> 5.8M large.squashfs.uncompressed (with -noI -noD -noF -noX)
>=20
> (large.erofs.T0 is built without nanosecond timestamp, so that we get
> smaller disk inode size (same with squashfs).)
>=20
>=20
> Runtime Perf
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The "uncached" column is tested with:
> hyperfine -p "echo 3 > /proc/sys/vm/drop_caches" "ls -lR $MNTPOINT"
>=20
>=20
> While the "cached" column is tested with:
> hyperfine -w 1 "ls -lR $MNTPOINT"
>=20
>=20
> erofs and squashfs are mounted with loopback device.
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | uncached(ms)| cached(=
ms)
> ----------------------------------|-------------|-----------
> composefs (with digest)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 326=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 1=
35
> erofs (w/o -T0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 264=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 172
> erofs (w/o -T0) + overlayfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 651=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 238
> squashfs (compressed)	            | 538         | 211
> squashfs (compressed) + overlayfs | 968         | 302


Clearly erofs with sparse files is the best fs now for the ro-fs +
overlay case. But still, we can see that the additional cost of the
overlayfs layer is not negligible.=C2=A0

According to amir this could be helped by a special composefs-like mode
in overlayfs, but its unclear what performance that would reach, and
we're then talking net new development that further complicates the
overlayfs codebase. Its not clear to me which alternative is easier to
develop/maintain.

Also, the difference between cached and uncached here is less than in
my tests. Probably because my test image was larger. With the test
image I use, the results are:

                                  | uncached(ms)| cached(ms)
----------------------------------|-------------|-----------
composefs (with digest)           | 681         | 390
erofs (w/o -T0) + overlayfs       | 1788        | 532
squashfs (compressed) + overlayfs | 2547        | 443


I gotta say it is weird though that squashfs performed better than
erofs in the cached case. May be worth looking into. The test data I'm
using is available here:
 =20
https://my.owndrive.com/index.php/s/irHJXRpZHtT3a5i


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
=3D-=3D-=3D
 Alexander Larsson                                            Red Hat,
Inc=20
       alexl@redhat.com            alexander.larsson@gmail.com=20
He's a lonely flyboy grifter living undercover at Ringling Bros.
Circus.=20
She's a virginal thirtysomething former first lady looking for love in=20
all the wrong places. They fight crime!=20

