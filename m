Return-Path: <linux-fsdevel+bounces-12834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F526867C0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C7F1C2BA52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A51D12EBEA;
	Mon, 26 Feb 2024 16:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDaDXXaQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB212C7E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964705; cv=none; b=cAiJuRA5CZOQWqcyKQrQ1jxaHPoygFBhEAiPJkpVI1J0zuRNe8v5kfZKYz7KB47YwEC7GYFYJsFU3Qf75V6tMRDmHRudnFxOmEywKGgOt/PXVnq6tjge0EafK/pm+OpyREAR2AkjNcQCKyx4DsGshnU4lwCywbrzSNCX6Z/O3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964705; c=relaxed/simple;
	bh=YK0D5gZYvoG8pvxIEP54FQ8WQUfFkgspv8vwjCyacZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+eO97IlKMO3mfHaXqBdWApGHHCKuTniF6pMtPZaNJaeNuQqOaZod+D7YeT2p0uwZ6tkSw/uTsXrltgdMy3+Dp/seUJAML3EPgkJzfgOe3hH+KzbTjQ+rVtDwIrOa0lX7cMRUlU7m+Mk2QI7x2IuekJT6kDGCPWL3US4ekRfOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDaDXXaQ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-785bdb57dfaso215477885a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 08:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708964702; x=1709569502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQrE8Oo49OIvNSyKeRutgRRj1vFRIp4xdCCzUsy9RcA=;
        b=UDaDXXaQ1eS0wutoCgVYgyYUuSnXS5qjeO/ljruUU0gofR1h0okarwTFNTAkJn9MRK
         W8zqSFf/DNnDErSPz1taPBBIIq0eUHMNY+78+vxpEfW4ConGNm5en9JibXmDKwpb+Uha
         hTTN4L1F4ChltWmPZPGtu14wxC+GqPhUpa1GaKOEy1vPQuw+EXUbgXHH+SJjCIuhKvyM
         C3Lh679UrRjEqio76Xf6Mv8q7TqkjTsvYqaguk6z3H+/rbnqjT8CvFYzaqXGOHdluztT
         1JZXfy/6GO+LOl0KytwUSRPDOSj495wIfJi/b1jdKSeciY5XP4CevmS0SHI14/4WZMNi
         LRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708964702; x=1709569502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQrE8Oo49OIvNSyKeRutgRRj1vFRIp4xdCCzUsy9RcA=;
        b=SPc8Hwdc/n31/tzt+kMJFDt3ifGHK4At/6iyX6JXOCxaH2k26o6GHkF+ZF41/rE5b4
         Dc2fbnQmKzushGDmRq1Myr2CDLbKnwNGRzZeE9Ror6JVpOi11blrfU7djUeYJ1EKwTtt
         QlC6VY4KjWII391sGqASbReeG0I1UkWeElvZ4BYP0Uf8dgkIgRFYct3mw+dppPhkyzzC
         VGePGmiQfye0v4hCYZvQWWVmvknRfpk8tMXCZjI/Zj1SFee2nSlTgLuI9vtM+MYbnW3U
         BfBSfoIGIwAVfeFCwWkDzuQqjdTklhWrSS/CseexurB0PwilJljERa2sss0wep3XUA5f
         XtLA==
X-Forwarded-Encrypted: i=1; AJvYcCVWYyQJsX4qbkpESVIgtcUkTR/xW4U4ctAzNG/G5Fs6hoNIM65SuM9tXTe2F8SSBl+GZtPP22cEJGRB7sWDjBcdc03JN1IwxcC5XsbQSQ==
X-Gm-Message-State: AOJu0Yxpr2OvTwX7cWq2Y4Jp4hEtR6+OE4fMPK+HdBV4MTENcy0rktf/
	xSU85hxfCBVAGK0TKPutc6xFtRQOowAw3Tf2TSJgCjxtHjH/Yd/AE4Q0Jz6ucgNpHrAfhvnSB/+
	itGKfOskEbF5YE04ejdWKwNrJhok=
X-Google-Smtp-Source: AGHT+IF6P0qaSlJsr9N0hx5zAJO1b8wQOXlqjo/x3PzDzEZ/UtKDmDt+MQPLBuu5DdjrPkkwFA3Yd5acIdJNhQ8Js24=
X-Received: by 2002:a05:620a:370e:b0:787:c4cc:60f4 with SMTP id
 de14-20020a05620a370e00b00787c4cc60f4mr9993757qkb.33.1708964701854; Mon, 26
 Feb 2024 08:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2uvhm6gweyl7iyyp2xpfryvcu2g3padagaeqcbiavjyiis6prl@yjm725bizncq>
 <CAJfpeguBzbhdcknLG4CjFr12_PdGo460FSRONzsYBKmT9uaSMA@mail.gmail.com>
 <20240221210811.GA1161565@perftesting> <CAJfpegucM5R_pi_EeDkg9yPNTj_esWYrFd6vG178_asram0=Ew@mail.gmail.com>
 <w534uujga5pqcbhbc5wad7bdt5lchxu6gcmwvkg6tdnkhnkujs@wjqrhv5uqxyx>
 <20240222110138.ckai4sxiin3a74ku@quack3> <CAJfpegtUZ4YWhYqqnS_BcKKpwhHvdUsQPQMf4j49ahwAe2_AXQ@mail.gmail.com>
 <20240222160823.pclx6isoyaf7l64r@quack3> <CAJfpegvvuzXUDusbsJ1VO0CQf5iZO=TZ8kK7V3-k738oi5RM5w@mail.gmail.com>
In-Reply-To: <CAJfpegvvuzXUDusbsJ1VO0CQf5iZO=TZ8kK7V3-k738oi5RM5w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 26 Feb 2024 18:24:50 +0200
Message-ID: <CAOQ4uxgRX2L52XS7ZoZBLe+GbhcNMbNcOEbkHOzV-xRF2g=vew@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF TOPIC] statx extensions for subvol/snapshot
 filesystems & more
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 10:27=E2=80=AFAM Miklos Szeredi via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
> On Thu, 22 Feb 2024 at 17:08, Jan Kara <jack@suse.cz> wrote:
>
> > > If we are going to start fixing userspace, then we better make sure t=
o
> > > use the right interfaces, that won't have issues in the future.
> >
> > I agree we should give this a good thought which identification of a
> > filesystem is the best.
>
> To find mount boundaries statx.stx_mnt_id (especially with
> STATX_MNT_ID_UNIQUE) is perfect.
>
> By supplying stx_mnt_id to statmount(2) it's possible to get the
> device number associated with that filesystem (statmount.sb_dev_*).  I
> think it's what Josef wants btrfs to return as st_dev.
>
> And statx could return that in stx_dev_*, with an interface feature
> flag, same as we've done with stx_mnt_id.  I.e. STATX_DEV_NOHACK would
> force the vfs to replace anything the filesystem put in kstat.dev with
> sb->s_dev.
>

Miklos,

I would really like to have this discussion at LSFMM and it would be great
if you could join it remotely.

Care to fill out the form and ask for a virtual invite so that we have
you on our list?
          https://forms.gle/TGCgBDH1x5pXiWFo7

Thanks,
Amir.

