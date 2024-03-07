Return-Path: <linux-fsdevel+bounces-13881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0074A874F84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7DE1C210BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0A212BEA5;
	Thu,  7 Mar 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAo2UX58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DF212C530
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709816251; cv=none; b=mitJjiChPkVYuf/38FL5kauCVTzIY+mK5EabntaZy0i9R04aabXc2bBPb9iBRUFUmX/id0z6O2Y2tR9U8X5TgD4sK6MTupMp0kjyxHuR+8IDMjnr6HQHTPdIxHOGxkixEt5o6l6psObINOLtAS1dzpnzOKH2QXPdKDIvJUHwap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709816251; c=relaxed/simple;
	bh=RJdyXZLNvnH8cN9wPXjrAPOlXdC7e8+6kAEh4RhBejE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pmfTTsy2C9H+3cmCLgsnUdyA4+KLsMsCBxrFyzFHD5xo8WuUqCHiD73JX5CIzbonoVWPDM+MR1i7krD5fYfO7TZw/ArjZSkZExvtHwZYszgXY1vCisg64lFOH6SP1zxEkQwwSkOuZWTvYW4YM65lLJ8iikSw4ndALeHiZqFVryw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAo2UX58; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a45a90e1661so59672866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709816248; x=1710421048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBW/1MEz6JNZVrnhcpxVAwMPPAr+vdVKO2wgbn75mCU=;
        b=EAo2UX58MvMc9Wbtba/wMaNJ5Hq3S/5wWGr/Q/BSzmJAAYbXl6j/jZc7pDC2cD8GF5
         HWt6Utz/0l5PHLQRDXfDyaMcFxvgg14/UMILZs0ivEJm4ZaikxD7KhaILl3UzaQw8+Mu
         bDX3y5WTa2n42jdg+DMPyRj/2aBEANwnVNyUxb6Zhant0lnu7gxSDuDU+SK1Aitq7+1N
         mKmmdrf9YzpNq73NAthR5/Gz7tDkn2o3EdHSv7FZgzkReZ1oruwEU2VkrpK40Pz8fpux
         kKp/XvjZMV4abeKSn2GkbVI1xIhqMyiQBpi5dmfNHlUNyf08bbJAaldb5oB8S09FCXsW
         gXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709816248; x=1710421048;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBW/1MEz6JNZVrnhcpxVAwMPPAr+vdVKO2wgbn75mCU=;
        b=EHsoNc/Ral5dU1tQJ+SbzEXVhKKMt21y2lc8EJHYvUWx6oIsh3dDL8yWlhQbF+3R5e
         o7Ws9srjdXTrdFN6fCgUgQQ3FLmCFW7DcUrerISRuydbbtUsIHiIdyCkxfVQXOOKEQvW
         imcb8Tg1duaDXSCr7njIVntV7ApVCFhwOfWC9mC00OH9CDkomDg1lLZM00i2Qlv00l+x
         aCjJhGFcrp2G3LWtdCsG4iIpmpI+wd9ktSBoj+rdNf/Msn0PqMVtU0DVcACZe0zUeuza
         tjwf21mNbe1zRGbj5MHVfu91S1CZN/hCcgatUnYp2/pg4/cDYIzyiTH5ZuY5MxcNME+o
         HKsg==
X-Forwarded-Encrypted: i=1; AJvYcCUiLG0S99LCitDsvNisN47Kk8vUVPT6HnDujnPy5SjpFuHwFrO3WdmByUOmfYAfvNv1pn/95AQ9GL17QctUwJSbp7C9JWIWAAolCsIasg==
X-Gm-Message-State: AOJu0YzYmLDuZD6vIImJGZuJvV4F2h50EGXWWvQ2e05u5HPSLldEnMws
	qE0Y/BMsbAycqNxN42tsmZLTUhzsthppKIGqrNuRHgetrJ3X2JIeAXRVxMc+GqaECY/xNzL+TFk
	c5g==
X-Google-Smtp-Source: AGHT+IHjqHWp2CPC7ca+ld5dxvSKopEz7nwEwKfTKFdzg18uJSgze7bS6XZR5A4/Au9LDR+Ykn2ASs8lcXI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:1c4d:b0:a42:ea24:f8b8 with SMTP id
 l13-20020a1709061c4d00b00a42ea24f8b8mr32093ejg.14.1709816248127; Thu, 07 Mar
 2024 04:57:28 -0800 (PST)
Date: Thu, 7 Mar 2024 13:57:26 +0100
In-Reply-To: <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219.chu4Yeegh3oo@digikod.net> <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com> <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com> <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
Message-ID: <Zem5tnB7lL-xLjFP@google.com>
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	"=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Paul Moore <paul@paul-moore.com>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2024 at 01:21:48PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 13:15, Christian Brauner wrote:
> > On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
> >> On Wed, Mar 6, 2024, at 14:47, Micka=C3=ABl Sala=C3=BCn wrote:
> >> >
> >> > Arnd, Christian, Paul, are you OK with this new hook proposal?
> >>=20
> >> I think this sounds better. It would fit more closely into
> >> the overall structure of the ioctl handlers with their multiple
> >> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
> >> you have the same structure for sockets and blockdev, and
> >> then additional levels below that and some weirdness for
> >> things like tty, scsi or cdrom.
> >
> > So an additional security hook called from tty, scsi, or cdrom?
> > And the original hook is left where it is right now?
>=20
> For the moment, I think adding another hook in vfs_ioctl()
> and the corresponding compat path would do what Micka=C3=ABl
> wants. Beyond that, we could consider having hooks in
> socket and block ioctls if needed as they are easy to
> filter out based on inode->i_mode.
>=20
> The tty/scsi/cdrom hooks would be harder to do, let's assume
> for now that we don't need them.

Thank you all for the help!

Yes, tty/scsi/cdrom are just examples.  We do not need special features for
these for Landlock right now.

What I would do is to invoke the new LSM hook in the following two places i=
n
fs/ioctl.c:

1) at the top of vfs_ioctl()
2) at the top of ioctl_compat()

(Both of these functions are just invoking the f_op->unlocked_ioctl() and
f_op->compat_ioctl() operations with a safeguard for that being a NULL poin=
ter.)

The intent is that the new hook gets called everytime before an ioctl is se=
nt to
these IOCTL operations in f_op, so that the LSM can distinguish cleanly bet=
ween
the "safe" IOCTLs that are implemented fully within fs/ioctl.c and the
"potentially unsafe" IOCTLs which are implemented by these hooks (as it is
unrealistic for us to holistically reason about the safety of all possible
implementations).

The alternative approach where we try to do the same based on the existing =
LSM
IOCTL hook resulted in the patch further up in this mail thread - it involv=
es
maintaining a list of "safe" IOCTL commands, and it is difficult to guarant=
ee
that these lists of IOCTL commands stay in sync.

Christian, does that make sense in your mind?

Thanks,
=E2=80=94G=C3=BCnther

