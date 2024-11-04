Return-Path: <linux-fsdevel+bounces-33627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6C09BBB18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 18:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B3A28161A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 17:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE01C4A2A;
	Mon,  4 Nov 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoYK7c7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CD1C1738;
	Mon,  4 Nov 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739835; cv=none; b=JOoUL/nUOfT5djBJPmpySW4Mrx8Ib6WG4iBnMcxnQqc8WLXKbcTBUeh+nbyrV2WKL1fe/H22IfsHaQX9gcv6WmCwAamXIdioh8gUFhoB2to9mNM90RxfweMf+igR1RUWLKsSvAQ1rov/zfhsJ3Bm5pi8KRfz7moUxkFCCKUGGl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739835; c=relaxed/simple;
	bh=SICAjadzqgYxQNrgOYg+UztLoDJSRQ1yNROvKSIJepM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/Qc1VILtdMx8Nsibgx30irDRJTY9+xDFspdLBTunP/CErV5NmaliDv2pk7hiKhDd+HTtaq+6LoMWBQ5Es/yl21tMi+Qu8cJxvZZHRHUBZTlcMtPeOvP3qwS2gLDx3SqJ87pVFc9DXpJUwnzWGIIpIas8UdWYyV5bU8umGnRWlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoYK7c7C; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460963d6233so28911811cf.2;
        Mon, 04 Nov 2024 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739833; x=1731344633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOGNDRBscOv7asRgZqi0hnlWitc/6LWLRWws462u1mc=;
        b=ZoYK7c7CubG5odDLCDzkLS1LKK4kgcx873ww0Ec1pu7uNAMP4x9Cxl+BORtgz9j8xg
         QdkMVU/DGvXCe8fy/Q5CG7nzgM0lV6F3wpDHcslJzc89wSEOhdoEFFbP36Pd4HvyfGDA
         NtIKl+zsFMQQ1y9LVpaN845J04p2DTaMSfXzK/zd6cc4gdfuhjCnNaWDQuSe1xQm76Em
         6ii9MMap/FGWU/xhIxD0zck6RRSG/wHOc7g2RYC2dekJKQzPFpR/vZ2MZWjvY4TiWRgG
         8i3o+ciuILnVP2B64zbqOG+zrJI6uI3eqMZAw7OK0lj/pAop4cJbgWuRaoahJVoQyQEW
         06Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739833; x=1731344633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOGNDRBscOv7asRgZqi0hnlWitc/6LWLRWws462u1mc=;
        b=kpDTISUQ1lMFy1ugCDzWHeJuAbU7+D08LgCXEcOg4CsF1fnSfd4JoiHUHsybZxLQxj
         wFyM8Bo+wNMLNXNL8o/ZrbOvU04dAQKlRQC8wA1nefVB8lq1bqA3t4qAiphKPaTrc0FR
         T5oNMWZs6q7SSDcIXNhQBrfomQvicW5xT2g3mVr5My6PuuPBM9d2Ytt6gS/kpBzHAD6a
         6qaNiZLFrFVkXHlpqk1WsdcnjFKTynbHv3B82h+mHTgJzjRbJhyyMx76xJ1vARW7C5dR
         ywjHi64RJw6BJFdRPLXswJGPjPpDfvFXnEZJ0h2k/lTObeG6XB/WIH5veKQDU6XDenIC
         rGBg==
X-Forwarded-Encrypted: i=1; AJvYcCV5OY4zyAE8eJacZQY9J7pIkbbHOWPNYXrqQSYRpQZCF46QNJjyCZMp23p8ZlwcRqrCvgqIDx8cSys3pSsA@vger.kernel.org, AJvYcCVWWGXspHclkLfM8Y9CpmFce2d/HpPfzTYLIIA5ceoJehMrSdE+sjCbultU+FHDGZqk/6pFpcTW8OedwdzHRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Lm9j6tf0LkpCXEmEd6HzNz5q7ydSM+FuwIr9ixQlm4O1QNQd
	Zf4510yxNMYDMDSglxcalx2+ZLh3BJrofUUs6E2qe0oCAOWx05w5BmIslmY5N7cPnD3h/h3q+h5
	MlTvJvIvE+U8YISTlkMATG6Bia0w=
X-Google-Smtp-Source: AGHT+IFWPgM0oQhJ6otrU9zrdF5XZmrGrMFj5ETaueLB2e8eX81G+1jBc8aeJmMCbjo2HpiUByK/Nxen4Rgm3X/dxVw=
X-Received: by 2002:ac8:5f54:0:b0:447:e769:76fc with SMTP id
 d75a77b69052e-462ab281dd7mr249615061cf.34.1730739832207; Mon, 04 Nov 2024
 09:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner> <20241028192804.axbj2onyoscgzvwi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20241028192804.axbj2onyoscgzvwi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 4 Nov 2024 18:03:40 +0100
Message-ID: <CAOQ4uxhoLO2shZAYxMuF7sjZs6GR3GLwpJ8KMT+tW21gZYOkLg@mail.gmail.com>
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2 (new
 mount APIs)
To: Zorro Lang <zlang@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, sandeen@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:28=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Mon, Oct 28, 2024 at 01:22:52PM +0100, Christian Brauner wrote:
> > On Sun, Oct 27, 2024 at 02:07:41AM +0800, Zorro Lang wrote:
> > > Hi,
> > >
> > > Recently, I hit lots of fstests cases fail on overlayfs (xfs underlyi=
ng, no
> > > specific mount options), e.g.
> > >
> > > FSTYP         -- overlay
> > > PLATFORM      -- Linux/s390x s390x-xxxx 6.12.0-rc4+ #1 SMP Fri Oct 25=
 14:29:18 EDT 2024
> > > MKFS_OPTIONS  -- -m crc=3D1,finobt=3D1,rmapbt=3D0,reflink=3D1,inobtco=
unt=3D1,bigtime=3D1 /mnt/fstests/SCRATCH_DIR
> > > MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /mnt/fstest=
s/SCRATCH_DIR /mnt/fstests/SCRATCH_DIR/ovl-mnt
> > >
> > > generic/294       [failed, exit status 1]- output mismatch (see /var/=
lib/xfstests/results//generic/294.out.bad)
> > >     --- tests/generic/294.out       2024-10-25 14:38:32.098692473 -04=
00
> > >     +++ /var/lib/xfstests/results//generic/294.out.bad      2024-10-2=
5 15:02:34.698605062 -0400
> > >     @@ -1,5 +1,5 @@
> > >      QA output created by 294
> > >     -mknod: SCRATCH_MNT/294.test/testnode: File exists
> > >     -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': F=
ile exists
> > >     -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only=
 file system
> > >     -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File=
 exists
> > >     +mount: /mnt/fstests/SCRATCH_DIR/ovl-mnt: fsconfig system call fa=
iled: overlay: No changes allowed in reconfigure.
> > >     +       dmesg(1) may have more information after failed mount sys=
tem call.
> >
> > In the new mount api overlayfs has been changed to reject invalid mount
> > option on remount whereas in the old mount api we just igorned them.
>
> Not only g/294 fails on new mount utils, not sure if all of them are from=
 same issue.
> If you need, I can paste all test failures (only from my side) at here.

Please share them.

>
> > If this a big problem then we need to change overlayfs to continue
> > ignoring garbage mount options passed to it during remount.
>
> Do you mean this behavior change is only for overlayfs, doesn't affect ot=
her fs?

That is correct.

>
> If it's not necessary, I think we'd better to not change the behaviors wh=
ich we've
> used so many years. But if you all agree with this change, then we need t=
o update
> related regression test cases and more scripts maybe.

Can you check if this workaround (done for ostree) solves the problem:

--- a/common/overlay
+++ b/common/overlay
@@ -127,7 +127,7 @@ _overlay_base_scratch_mount()
 _overlay_scratch_mount()
 {
        if echo "$*" | grep -q remount; then
-               $MOUNT_PROG $SCRATCH_MNT $*
+               $MOUNT_PROG --options-source=3Ddisable $SCRATCH_MNT $*
                return
        fi

I am not sure about the proper fix for general use cases,
but if this is enough to fix fstests, I think we should do this anyway.

Thanks,
Amir.

