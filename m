Return-Path: <linux-fsdevel+bounces-11554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6E854AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 14:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3AA1C243DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49265475D;
	Wed, 14 Feb 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO0bAh0i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FE1DFEA
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707918046; cv=none; b=XPzWR3aFR+SVgZYM0MiRL+R89l2MeuD/qTqX1YPd1AKziuCPRSujz4vmKIvleOh/LThFGyRoigUeTUIEwiew1yU8b6ICvf7pVQnVGkAqicaqroXKbYyGHXhGGeV2XKro8xjqOLEiuzIzVjljTsECHlkCa2U2ZK6fSlnJk7PmEnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707918046; c=relaxed/simple;
	bh=G1nS6/kpqUSInm9l6oWu2YKLNGi9u2PYPY/GIpPp3tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b50zwe+jorTWUc0qys9UW18/kJaH/rBULmQO2dm8F/CYZOBuNiMU24zxqFOOlmfP1G1v9oGqLBWTYx0cHcGnv0+zDv2i/cITZWSZ9p6jDNkITN6NYIDsxc2rr7Kvgmp7mMv+AvofHQ+XMDIey+uODlg58ZDf78GHR9/APKCyk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO0bAh0i; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42ce63b1d30so21514351cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 05:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707918043; x=1708522843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ0znjR+DZU+wSMVZKtOMnCFyRJN7XifJR/bpY1zT6k=;
        b=TO0bAh0io0IAXXf57gcfuGb2kFZFRftujdPleBwfLA/ojAD4yZTMLDZLXsy4iCoppw
         PpMhHONI0nx1YKj/yX86DxtzWCdOEytY6JkXTARb0VmGZAPbGz/ejgrie6cMdlFakRHB
         iYXYBSvaHRREXNLxo4VX6yVAQHioVCxoOYr/ZL/GA9XsK1YiUtRlgtaf0rjVPNx6wJpH
         ztnFoYkLdzF1KpeRKjl1IoaNIZwRe1LKwW+UkWt/+ZkatycTw41CJv4RWlE4ls8vcWHE
         Due/+8l62vipIBM+VuxjFAmEB4u0M7kWwpk72c11HgWPCWkRtReax7ALB0a7C8m4Bhcg
         OwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707918043; x=1708522843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJ0znjR+DZU+wSMVZKtOMnCFyRJN7XifJR/bpY1zT6k=;
        b=lz//iC06I1bt3KKUsOqBcxHRO04p0UVP6O70DkCZOu6tAvnbohHb/QJJjK8LmV09I4
         VW5uXL2g+Qi2kUGKoNsfWBmMQaeXqslnDE/gHDG7B07xlDMK8nU10U215vch0RgFS/xT
         lfDl0zeUnsg+MpU2fdLUIO/Ru535jCFPDdF6qmYDY1Ycyxhw71NnIocJ6wredtwNTgiU
         yX44286sZT7IwUghll/PVnZH8Lk9lZ3oVUjUpWPIyb4FXxPw3tVIRCJNFCcUh03PskS2
         AubrKfcbdE5cs7mROhM7D0+3kvjTxxrcSTYA3tu/DV84DQiSxz6HXTLEeSaxjB8BZWXJ
         TpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd/xU+EWWyUmPugZvDW+BS0Wf9fCidxZ9mLxYE1yBypNnsbfD0+la0yB5Ojtagum3QECSzHrO63zIPN7+HS5GhiZaUtBBjmIvNTW4VbQ==
X-Gm-Message-State: AOJu0YzMw4UrOoPl+OH55LmfAxXHbjobNc8wi3fgl1uk4KzS2nELBmmK
	pEAXnQJGyz66mweLdZdOGbeFvwam3Rt/Iapf4IiwesqdOZTdldVyC2tBD5vdPCbRj0rIq6YMp1g
	Xg6bEbyQ269kDgolK6SFjMleb50MpQDCvi+c=
X-Google-Smtp-Source: AGHT+IH85/v7keKUBAbd3l7g5xr384WAXRrw4iw0KGJe/rIbmX+CClkKWeci77XzVlG3FsUmhFjTn0OeT8VGk1enjxo=
X-Received: by 2002:a05:622a:243:b0:42c:7bef:c3bc with SMTP id
 c3-20020a05622a024300b0042c7befc3bcmr2799573qtx.53.1707918043336; Wed, 14 Feb
 2024 05:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113247.758848-1-amir73il@gmail.com> <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3> <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com> <20240214112310.ovg2w3p6wztuslnw@quack3>
In-Reply-To: <20240214112310.ovg2w3p6wztuslnw@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Feb 2024 15:40:31 +0200
Message-ID: <CAOQ4uxjS1NNJY0tQXRC3qo3_J4CB4xZpxJc7OCGp1236G6yNFw@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > > > Merged your improvement now (and I've split off the cleanup into a separate
> > > > change and dropped the creation of fsnotify_path() which seemed a bit
> > > > pointless with a single caller). All pushed out.
> > > >
> > >
> >
> > Jan & Jens,
> >
> > Although Jan has already queued this v3 patch with sufficient performance
> > improvement for Jens' workloads, I got a performance regression report from
> > kernel robot on will-it-scale microbenchmark (buffered write loop)
> > on my fan_pre_content patches, so I tried to improve on the existing solution.
> >
> > I tried something similar to v1/v2 patches, where the sb keeps accounting
> > of the number of watchers for specific sub-classes of events.
> >
> > I've made two major changes:
> > 1. moved to counters into a per-sb state object fsnotify_sb_connector
> >     as Christian requested
> > 2. The counters are by fanotify classes, not by specific events, so they
> >     can be used to answer the questions:
> > a) Are there any fsnotify watchers on this sb?
> > b) Are there any fanotify permission class listeners on this sb?
> > c) Are there any fanotify pre-content (a.k.a HSM) class listeners on this sb?
> >
> > I think that those questions are very relevant in the real world, because
> > a positive answer to (b) and (c) is quite rare in the real world, so the
> > overhead on the permission hooks could be completely eliminated in
> > the common case.
> >
> > If needed, we can further bisect the class counters per specific painful
> > events (e.g. FAN_ACCESS*), but there is no need to do that before
> > we see concrete benchmark results.
>
> OK, I think this idea is sound, I'd just be interested whether the 0-day
> bot (or somebody else) is able to see improvement with this. Otherwise why
> bother :)
>

Exactly.

> > Jan,
> >
> > Whenever you have the time, feel free to see if this is a valid direction,
> > if not for the perf optimization then we are going to need the
> > fsnotify_sb_connector container for other features as well.
>
> So firstly the name fsnotify_sb_connector really confuses me. I'd save
> "connector" names to fsnotify_mark_connector. Maybe fsnotify_sb_info?
>

Sure.

> Then I dislike how we have to specialcase superblock in quite a few places
> and add these wrappers and what not. This seems to be mostly caused by the
> fact that you directly embed fsnotify_mark_connector into fsnotify_sb_info.
> What if we just put fsnotify_connp_t there? I understand that this will
> mean one more pointer fetch if there are actually marks attached to the
> superblock and the event mask matches s_fsnotify_mask. But in that case we
> are likely to generate the event anyway so the cost of that compared to
> event generation is negligible?
>

I guess that can work.
I can try it and see if there are any other complications.

> And I'd allocate fsnotify_sb_info on demand from fsnotify_add_mark_locked()
> which means that we need to pass object pointer (in the form of void *)
> instead of fsnotify_connp_t to various mark adding functions (and transform
> it to fsnotify_connp_t only in fsnotify_add_mark_locked() after possibly
> setting up fsnotify_sb_info). Passing void * around is not great but it
> should be fairly limited (and actually reduces the knowledge of fsnotify
> internals outside of the fsnotify core).

Unless I am missing something, I think we only need to pass an extra sb
arg to fsnotify_add_mark_locked()? and it does not sound like a big deal.
For adding an sb mark, connp arg could be NULL, and then we get connp
from sb->fsnotify_sb_info after making sure that it is allocated.

I will get to look at it in ~2 weeks.

Thanks for the quick feedback.
Amir.

