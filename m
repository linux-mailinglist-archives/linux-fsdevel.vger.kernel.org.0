Return-Path: <linux-fsdevel+bounces-13950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC5875AE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 00:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165802813F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DAC3D970;
	Thu,  7 Mar 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="PcJN1NmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69E2E648
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Mar 2024 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709852948; cv=none; b=isSgeLo8PSXmVoNBV4FazL3ZvoolldL+yto1n9SPUGg8eQAXZ6em1KaKGEBT/S8BY3mWtEyoTXuNe8t+HQfRTW7LO2DqD/cvBO3ZMYltVk8II9yjJ8j8xSqlQ4WSIFSfWUZwe2dezpuUnwm+slMEDArRU4P+6l4KJtz8y6yTRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709852948; c=relaxed/simple;
	bh=aMe+MrIcPrmNT0GgOpdUwuxpZPNyPcWDAZT7ot9Retk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUTf7YMXkeQNEt/S9hUc+qlTuunJUVVLOeoB/RhaWaP37DGjkTE/WcdSVkT7EFiFKYY8eF59TgJBrDjIVHgNJUheUrqD26/o2K4KCDSZCLN3j4nZWwR5Vh+/A2jrSc1YStrDZU8RzCd0NPjpFBajzBqv/42lEzTAF1F2+kveeko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=PcJN1NmG; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e152c757a5so167114a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 15:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709852946; x=1710457746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cE26fS+fxbP0bGtECJ6ak66AlxwxcdDXL020aU+m/ns=;
        b=PcJN1NmGBQs/UE3oTE+wd7FlN0aThldf/IZHcokvSr/m3LBtlUxiBQVIHfUtpvuJi+
         eQ5Qsqg805MEEOHvJDDoZ8+6InwUj+sCqiJVgGTzsvZj4d2OqlHkJJ5Vdt2mS3bcTKu+
         0tLTbt9zekYaJJYhKV2DlZBuYAgsSFIRJORfLkxKQYt0jC5Zek0q9BFEQJn9RndbiBk+
         0I2/wlPbelKl/+R1KYJJz1czOcrlj3zNwXm2rtvsignkFsWM2icuzllEshTBL1YfKf3w
         h0TFgILHlcwL3eW9H3yd4qmMIdwQONRnxsHqYkdwRo+L7rITOU30DSMEXcnoqplfk91m
         HwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709852946; x=1710457746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cE26fS+fxbP0bGtECJ6ak66AlxwxcdDXL020aU+m/ns=;
        b=mKJ22NIBKzFyjPPtEGZGJJUBiVKdeIUZtMtAabDiYcxbin9oBGwmyY4yNPQDEmXUHQ
         tvlj3iPYF6FIDonVqXuqLLFXvEmbFTBMraWmVyG4Nn6z4bDDGHDy+nvicbzA8UugGyF7
         Zz4kRupyHvfWAm/tOc4+fWEHUea09xNr6OWYYS284fIP8QMeRND6xnjFERcOF8S0F0WJ
         rRtp4m/pm/Lzd3OB5YUqXAeCg4lvik3CIwK5PoJSivSPaFwOOokq3OG4NXMQoxlJLCmi
         mzYtDQNbMaXa4Dk1AYjGmHQb+gT0weMI+jDhIPtlb1M1LFHfTyh0FfJVhvyDL9/fkCGv
         FuSA==
X-Forwarded-Encrypted: i=1; AJvYcCVfuUzsiuvS+aRO2/aQZeOruiGeXokLfO0QbAOzuMG1CR2TZtHiU0cogqJ1ZOiwGcMc84KdbDMCHYRGP+8NVpnOgfYa0pj6B0P14u850w==
X-Gm-Message-State: AOJu0YyxUB+wlnBrRWT0AhK+xjmBQM+85w8sEunMalxsoCUi05jhIKBt
	a6df33Vh6GjPTvGmheKJxAEJShrp6Ed3sIdtqgLReZurJFPFPW3msKHH/7AOFhU=
X-Google-Smtp-Source: AGHT+IEV5Tb6cvCIOyfvwprZ2mjXD9T855LAvXgfGrrF8chsROepjV9aeVqwZsiHVj6Np91eUCtbdg==
X-Received: by 2002:a05:6a20:9f98:b0:1a1:6735:b8be with SMTP id mm24-20020a056a209f9800b001a16735b8bemr7882829pzb.41.1709852945941;
        Thu, 07 Mar 2024 15:09:05 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id q37-20020a17090a17a800b0029bb1cc2e05sm40193pja.3.2024.03.07.15.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 15:09:05 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1riMrG-00GSJi-0L;
	Fri, 08 Mar 2024 10:09:02 +1100
Date: Fri, 8 Mar 2024 10:09:02 +1100
From: Dave Chinner <david@fromorbit.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Allen Webb <allenwebb@google.com>,
	Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>,
	Jorge Lucangeli Obes <jorgelo@chromium.org>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Message-ID: <ZepJDgvxVkhZ5xYq@dread.disaster.area>
References: <20240219.chu4Yeegh3oo@digikod.net>
 <20240219183539.2926165-1-mic@digikod.net>
 <ZedgzRDQaki2B8nU@google.com>
 <20240306.zoochahX8xai@digikod.net>
 <263b4463-b520-40b5-b4d7-704e69b5f1b0@app.fastmail.com>
 <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>

On Thu, Mar 07, 2024 at 03:40:44PM -0500, Paul Moore wrote:
> On Thu, Mar 7, 2024 at 7:57 AM Günther Noack <gnoack@google.com> wrote:
> > On Thu, Mar 07, 2024 at 01:21:48PM +0100, Arnd Bergmann wrote:
> > > On Thu, Mar 7, 2024, at 13:15, Christian Brauner wrote:
> > > > On Wed, Mar 06, 2024 at 04:18:53PM +0100, Arnd Bergmann wrote:
> > > >> On Wed, Mar 6, 2024, at 14:47, Mickaël Salaün wrote:
> > > >> >
> > > >> > Arnd, Christian, Paul, are you OK with this new hook proposal?
> > > >>
> > > >> I think this sounds better. It would fit more closely into
> > > >> the overall structure of the ioctl handlers with their multiple
> > > >> levels, where below vfs_ioctl() calling into f_ops->unlocked_ioctl,
> > > >> you have the same structure for sockets and blockdev, and
> > > >> then additional levels below that and some weirdness for
> > > >> things like tty, scsi or cdrom.
> > > >
> > > > So an additional security hook called from tty, scsi, or cdrom?
> > > > And the original hook is left where it is right now?
> > >
> > > For the moment, I think adding another hook in vfs_ioctl()
> > > and the corresponding compat path would do what Mickaël
> > > wants. Beyond that, we could consider having hooks in
> > > socket and block ioctls if needed as they are easy to
> > > filter out based on inode->i_mode.
> > >
> > > The tty/scsi/cdrom hooks would be harder to do, let's assume
> > > for now that we don't need them.
> >
> > Thank you all for the help!
> >
> > Yes, tty/scsi/cdrom are just examples.  We do not need special features for
> > these for Landlock right now.
> >
> > What I would do is to invoke the new LSM hook in the following two places in
> > fs/ioctl.c:
> >
> > 1) at the top of vfs_ioctl()
> > 2) at the top of ioctl_compat()
> >
> > (Both of these functions are just invoking the f_op->unlocked_ioctl() and
> > f_op->compat_ioctl() operations with a safeguard for that being a NULL pointer.)
> >
> > The intent is that the new hook gets called everytime before an ioctl is sent to
> > these IOCTL operations in f_op, so that the LSM can distinguish cleanly between
> > the "safe" IOCTLs that are implemented fully within fs/ioctl.c and the
> > "potentially unsafe" IOCTLs which are implemented by these hooks (as it is
> > unrealistic for us to holistically reason about the safety of all possible
> > implementations).
> >
> > The alternative approach where we try to do the same based on the existing LSM
> > IOCTL hook resulted in the patch further up in this mail thread - it involves
> > maintaining a list of "safe" IOCTL commands, and it is difficult to guarantee
> > that these lists of IOCTL commands stay in sync.
> 
> I need some more convincing as to why we need to introduce these new
> hooks, or even the vfs_masked_device_ioctl() classifier as originally
> proposed at the top of this thread.  I believe I understand why
> Landlock wants this, but I worry that we all might have different
> definitions of a "safe" ioctl list, and encoding a definition into the
> LSM hooks seems like a bad idea to me.

I have no idea what a "safe" ioctl means here. Subsystems already
restrict ioctls that can do damage if misused to CAP_SYS_ADMIN, so
"safe" clearly means something different here.

> At this point in time, I think I'd rather see LSMs that care about
> ioctls maintaining their own list of "safe" ioctls and after a while
> if it looks like everyone is in agreement (VFS folks, individual LSMs,
> etc.) we can look into either an ioctl classifier or multiple LSM
> ioctl hooks focused on different categories of ioctls.

From the perspective of a VFS and subsystem developer, I really have
no clue what would make a "safe" ioctl from a LSM perspective, and I
very much doubt an LSM developer has any clue whether deep, dark
subsystem ioctls are "safe" to allow, or even what would stop
working if they decided something was not "safe".

This just seems like a complex recipe for creating unusable and/or
impossible to configure/secure systems to me.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

