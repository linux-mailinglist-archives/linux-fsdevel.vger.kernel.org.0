Return-Path: <linux-fsdevel+bounces-45943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5493A7FB7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0817A4AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF673267AF2;
	Tue,  8 Apr 2025 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMoltob2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163F7FBD6;
	Tue,  8 Apr 2025 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107111; cv=none; b=qje83R6Vedwub53pTdPlb/sYxGGPWfN6Sc574qkY02d5bukFAqYWDOqtDGPwMjP4rcNb+820rYIEKC1m6gGsxTPFlnMlBH/MaO/0fGS2/oOM3wfyMw36+kTHdcv6ImIX/j8hl7ubA3KNsEk5oLrJajasQxi9gEMVpmjx7g2aYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107111; c=relaxed/simple;
	bh=rEOk4CBly4AlRVttK5V5QQUlaR69H0x+24xY/q+krdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+cYqmrJY4l+WtgYNPZ6NNt7AcluE49kzvdjC5kngxdXK2hUkZgQPsMgZSvviOt0efWqYA+oM716D7gQXYPWOBp6J3pHVZFRuGFjLVIQ9i5OMg2Pty4hvjQgpiTGbb8T8ErBhkjnkfNETG70y1HHbe62gtymzjwIoJUQmHioY9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMoltob2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4549849b3a.0;
        Tue, 08 Apr 2025 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744107109; x=1744711909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTVPSXCmMLq6EC4r2uIbhTrhstuJngMRN9cKMT6ddPE=;
        b=gMoltob2ydWJ7IxtVcYbmMWbu3bdZ+ZcLQV+irFkbPPJFS3YX9JmFWIBgiEdGPm7vp
         fwiK7SeEPnrgwk7iizIG9XFAiqFWyB4Av1lqLNTb69CJ7aITXtxE/M9fgLza4VnrmBOL
         8R1+jw/CRnrXmIHVXCJopk3IPgRhQhuhhzkYyVwz4gBqxGfBfchOk9e8Wj1aaRMpP2Az
         IFjHOGsOANS+CN8ruM35vEFDI/RGAQQshubjxt8H7AZtgI9gD/GyMlqVXKhi00Ebih1Z
         Q5ktPUQWU5cqOSnVOyKTYQVTd8JEScPN69bRsosKJJU6yHgn3JBIEGWbyA0lnayyZa/Y
         SdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744107109; x=1744711909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTVPSXCmMLq6EC4r2uIbhTrhstuJngMRN9cKMT6ddPE=;
        b=OAnj1BDPbpeY4TGMzm2iAFhoP0MgQPRa19EtEkhQehp/+s7UinfBOLooxXX2GTUxYo
         XKQACKWaa05zQr1CoC3xPoA+mj3s9eFyB+wvCmikw1/RA7pdYznLcZ4XQ4K0OGb+sIJQ
         W4k6elmc3ynHvpkiU7M56bTY+Y+AdiocV2Ct6ynIc49d+syl8tGZPD55b3WjytP1jbQb
         EyfoQorFp1UpCx2EVcywkYWe7b5/6ebv9F1EeOgG83jwFTJ2dZQs0Fw4fWTu/Szwhh05
         yLIRYb+ZCWMKSNGh1EQ49dJba4t5BoGH/UU5vxjToMNH2b9kcde4ZD26ztzxnClkAHKw
         W5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVjfSrZYvyC0oXPO4hKqW5xZsP1XNf9n0YPigt5qy0rnME+8hG52pN7TuhA7CKzsz+kWKb8BSG/WqfC0sj6@vger.kernel.org, AJvYcCWg9F9gtKo+VuAawO7glmNhiA7pfPKcpQrM6vBlpGvdxTxJw0tPZFFMdkWk4jBoEl1ax6FHsOQXwjW03MfI@vger.kernel.org, AJvYcCXgNQm+TzemmgJsBPryUSZMbfGIyUx89yR9zFOmdUGu9HpsKg8QEKvncS9K7iYWpDYmDNC78461@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUw6kkk1GyzSzosfE/+GYYrEtU+I2zdkMKwBlR5bJnVwEhmr/
	jl5tNnHT3PxiI3FlgKCjiGwpivnc7qymSbYfUOd3z7nhSYAmv+LUe4MJNTqUL3N1z4YeAr21UHT
	OskJQ5HONilwM2wki+ZJB/EkCrM0=
X-Gm-Gg: ASbGncsdMt7gZ/L2z7tb8oxy8e2+HTswUsQmNgWN7Pqf0DkHdtjDqgah/KqUPXCX8eA
	bgJ4ItB8sVOPR0OSaejMugAYyom1aJ3ophpSdTrEnc1c1asqquqTuuMFC1C/Dz5+c91cYXIGl19
	3APsHGP0Oz58FlOucir3V2QXA5
X-Google-Smtp-Source: AGHT+IFhEirAccPm6diooe5A56ckmlLwkK2C0zEsLm8HntfBxz5BRD+WrLEptloFT/6kAAaD8cz1blHSA7D0fDgTFCY=
X-Received: by 2002:a17:90b:2711:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-306af788dbbmr12565246a91.23.1744107108986; Tue, 08 Apr 2025
 03:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019191303.24048-1-kovalev@altlinux.org> <Z9xsx-w4YCBuYjx5@eldamar.lan>
 <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
 <2025032402-jam-immovable-2d57@gregkh> <7qi6est65ekz4kjktvmsbmywpo5n2kla2m3whbvq4dsckdcyst@e646jwjazvqh>
 <2025032404-important-average-9346@gregkh> <dzmprnddbx2qaukb7ukr5ngdx6ydwxynaq6ctxakem43yrczqb@y7dg7kzxsorc>
 <20250407-biegung-furor-e7313ca9d712@brauner> <20250407190814.GB6258@frogsfrogsfrogs>
In-Reply-To: <20250407190814.GB6258@frogsfrogsfrogs>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Tue, 8 Apr 2025 12:11:36 +0200
X-Gm-Features: ATxdqUGUflWhsc7_t9EwiCgdbFbM8FViOml_3iPU3I88ZbHoy2WAA1j9TB8rW0o
Message-ID: <CAFLxGvxH=4rHWu-44LSuWaGA_OB0FU0Eq4fedVTj3tf2D3NgYQ@mail.gmail.com>
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Cengiz Can <cengiz.can@canonical.com>, 
	Attila Szasz <szasza.contact@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org, 
	dutyrok@altlinux.org, syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, 
	stable@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 9:08=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
> It's also the default policy on Debian 12 and RHEL9 that if you're
> logged into the GUI, any program can run:
>
> $ truncate -s 3g /tmp/a
> $ mkfs.hfs /tmp/a
> $ <write evil stuff on /tmp/a>
> $ udisksctl loop-setup -f /tmp/a
> $ udisksctl mount -b /dev/loopX
>
> and the user never sees a prompt.  GNOME and KDE both display a
> notification when the mount finishes, but by then it could be too late.
> Someone should file a CVE against them too.

At least on SUSE orphaned and other problematic filesystem kernel modules
are blacklisted. I wonder why other distros didn't follow this approach.

> You can tighten this up by doing this:
>
> # cat > /usr/share/polkit-1/rules.d/always-ask-mount.rules << ENDL
> // don't allow mounting, reformatting, or loopdev creation without asking
> polkit.addRule(function(action, subject) {
>         if ((action.id =3D=3D "org.freedesktop.udisks2.loop-setup" ||
>              action.id =3D=3D "org.freedesktop.udisks2.filesystem-mount" =
||
>              action.id =3D=3D "org.freedesktop.udisks2.modify-device") &&
>             subject.local =3D=3D true) {
>                 return polkit.Result.AUTH_ADMIN_KEEP;
>         }
> });
> ENDL

Thanks for sharing this!

> so at least you have to authenticate with an admin account.  We do love
> our footguns, don't we?  At least it doesn't let you do that if you're
> ssh'd in...

IMHO guestmount and other userspace filesystem implementations should
be the default
for such mounts.

//richard

