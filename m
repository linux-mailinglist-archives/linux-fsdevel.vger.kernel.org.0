Return-Path: <linux-fsdevel+bounces-13762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A13108739CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 15:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533AC285C95
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59600134404;
	Wed,  6 Mar 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuAF5nFH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B366613440D
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736680; cv=none; b=jDOXO3Kw2Sz8uHLOG/hZWuI3lmzABl7VuDZOGBAn+5sjCtkmQKVUTshO3Yk7h79vIxpi1eyWhx4N7a5ya1mTXo7XpAiGdMGqH71HMdDKw75FMcK0hsOwqPtqnP1+Qx8Vrp59FhnmZiFEI1JVOIGsRH9Vdf8IGW3xIj/r5bgoKXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736680; c=relaxed/simple;
	bh=7NipnKjCyBp0/Kp4PHAiMLsQezDCu2m25ymDSor4z8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=my/dzBWYJZZ/zLAaOzxFcoH06WlJRX4JUbt/nrACbhuo0kch9pI09eWBR9EngMJhw41xjexMRI8UK8vbxQVdEgKHztoYQbMj5is2C8+gzclAfUdR4ozadoNaeB3mi213cwgROjUln+TOzbXdQUuDD4P4iqchQ5vRU3H3eYEGpeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuAF5nFH; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42ee2012bf0so6665731cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 06:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736677; x=1710341477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zE2xk6QFHTEnp5sMRGuPv7VdheuZolY9qf15a3fNNDI=;
        b=BuAF5nFH+duVZlvhfYqCKDT0dDkXiIW5s7r1s6AJmOPIcTlC9dxqdJKOG4xgysIL2A
         1mPX0bNVlekQxqM85aiNkUlFosxw8e6Dcr7fybyAycW7lefBf0SyoZPbaOzV5gzjR6Kg
         IhNA8RDyqY/G6xlwhjKBgbidDgK9J3dkM+/TWDROhN8LsAyBGoDXQ2MJr5nhM+2g1ktD
         kyPOSYFCoumA9nWgB4aQTWiLK6nSTTTEJEgnykEgVWbcSHNXEFOCGjWFrK8rzcAEQEo3
         vClrnb5OrIl/6SxdgXxCNXIdtLpFFvfDGkH80jCtwxUTdbQ6p1U2EMU+dzkeEfbmIQkW
         NUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736677; x=1710341477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zE2xk6QFHTEnp5sMRGuPv7VdheuZolY9qf15a3fNNDI=;
        b=fq5M6fdqDh/3D8O0ljHLh6Vou1IjWdYUBB4EVehfZD1hyzX/TtsicTJJC3mgIsX5OK
         9ICVeMXRPi+R6HpfF4VMWed99tKT1afwEJ+qCEMKT2CX0Lmm8UVqrseah6dLdxsTO076
         4udp6ujadddtss+KqkNt6GBmyTauSKKh3IfN8kQaUJxcBcPzGgDcy7qdw78p8ZvQ0mtC
         We2YB/RHyLPtC4QLXeEGCNGQtU/2y42q2FG7ZisGznqT8p2LQzd+hOmvJZam3MSDgyZz
         u2pjTj2BBdgk1UnjSkQ+2o1IXTkcLXJcfGHR+uh68Te0pvXAs3Y1CmWcceDrB1fbeXbU
         zblA==
X-Forwarded-Encrypted: i=1; AJvYcCWG5E+Bm15PhW/RU1MDaP8ri5vSu+7MG2vc2ivXRrt12AYpG1jxaa4s5SRur8O1GuzvvtnzfQXnpBwjo0rRBoHqt51liLj+b3lo6Zgqjw==
X-Gm-Message-State: AOJu0YwMsuYi2P4o3/GP6xBmmBBYPj/8lilWzyYJPq966W15FniFWbjf
	MCZI7M4hIgx5wmVQ6TnlaNw+X4Fi6/zcfS5M2gl7g0bLRpccZzgcPvpYScDYLRfP0PkxDoY4P3N
	7ZxyWU0FOYF92kKPjMiSId5VkHFA=
X-Google-Smtp-Source: AGHT+IGTOp7sSure/y68mQpvO1VTyA38qNwB4iWaZK2Jn4dGsYTWg2YJMLpHAW1gEfkO8UIT1KnxTSdePBXHFt65c84=
X-Received: by 2002:ac8:7f89:0:b0:42e:b180:8427 with SMTP id
 z9-20020ac87f89000000b0042eb1808427mr464256qtj.32.1709736677510; Wed, 06 Mar
 2024 06:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116113247.758848-1-amir73il@gmail.com> <20240116120434.gsdg7lhb4pkcppfk@quack3>
 <CAOQ4uxjioTjpxueE8OF_SjgqknDAsDVmCbG6BSmGLB_kqXRLmg@mail.gmail.com>
 <20240124160758.zodsoxuzfjoancly@quack3> <CAOQ4uxiDyULTaJcBsYy_GLu8=DVSRzmntGR2VOyuOLsiRDZPhw@mail.gmail.com>
 <CAOQ4uxj-waY5KZ20-=F4Gb3F196P-2bc4Q1EDcr_GDraLZHsKQ@mail.gmail.com>
 <20240214112310.ovg2w3p6wztuslnw@quack3> <CAOQ4uxjS1NNJY0tQXRC3qo3_J4CB4xZpxJc7OCGp1236G6yNFw@mail.gmail.com>
 <20240215083648.dhjgdj43npgkoe7p@quack3>
In-Reply-To: <20240215083648.dhjgdj43npgkoe7p@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Mar 2024 16:51:06 +0200
Message-ID: <CAOQ4uxjDndJr8oTGyWhLSebFsBcRQ4g=GwYZvdWQmRpXXdmx5A@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: optimize the case of no parent watcher
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 10:36=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 14-02-24 15:40:31, Amir Goldstein wrote:
> > > > > > Merged your improvement now (and I've split off the cleanup int=
o a separate
> > > > > > change and dropped the creation of fsnotify_path() which seemed=
 a bit
> > > > > > pointless with a single caller). All pushed out.
> > > > > >
> > > > >
> > > >
> > > > Jan & Jens,
> > > >
> > > > Although Jan has already queued this v3 patch with sufficient perfo=
rmance
> > > > improvement for Jens' workloads, I got a performance regression rep=
ort from
> > > > kernel robot on will-it-scale microbenchmark (buffered write loop)
> > > > on my fan_pre_content patches, so I tried to improve on the existin=
g solution.
> > > >
> > > > I tried something similar to v1/v2 patches, where the sb keeps acco=
unting
> > > > of the number of watchers for specific sub-classes of events.
> > > >
> > > > I've made two major changes:
> > > > 1. moved to counters into a per-sb state object fsnotify_sb_connect=
or
> > > >     as Christian requested
> > > > 2. The counters are by fanotify classes, not by specific events, so=
 they
> > > >     can be used to answer the questions:
> > > > a) Are there any fsnotify watchers on this sb?
> > > > b) Are there any fanotify permission class listeners on this sb?
> > > > c) Are there any fanotify pre-content (a.k.a HSM) class listeners o=
n this sb?
> > > >
> > > > I think that those questions are very relevant in the real world, b=
ecause
> > > > a positive answer to (b) and (c) is quite rare in the real world, s=
o the
> > > > overhead on the permission hooks could be completely eliminated in
> > > > the common case.
> > > >
> > > > If needed, we can further bisect the class counters per specific pa=
inful
> > > > events (e.g. FAN_ACCESS*), but there is no need to do that before
> > > > we see concrete benchmark results.
> ...
>
> > > Then I dislike how we have to specialcase superblock in quite a few p=
laces
> > > and add these wrappers and what not. This seems to be mostly caused b=
y the
> > > fact that you directly embed fsnotify_mark_connector into fsnotify_sb=
_info.
> > > What if we just put fsnotify_connp_t there? I understand that this wi=
ll
> > > mean one more pointer fetch if there are actually marks attached to t=
he
> > > superblock and the event mask matches s_fsnotify_mask. But in that ca=
se we
> > > are likely to generate the event anyway so the cost of that compared =
to
> > > event generation is negligible?
> > >
> >
> > I guess that can work.
> > I can try it and see if there are any other complications.
> >
> > > And I'd allocate fsnotify_sb_info on demand from fsnotify_add_mark_lo=
cked()
> > > which means that we need to pass object pointer (in the form of void =
*)
> > > instead of fsnotify_connp_t to various mark adding functions (and tra=
nsform
> > > it to fsnotify_connp_t only in fsnotify_add_mark_locked() after possi=
bly
> > > setting up fsnotify_sb_info). Passing void * around is not great but =
it
> > > should be fairly limited (and actually reduces the knowledge of fsnot=
ify
> > > internals outside of the fsnotify core).
> >
> > Unless I am missing something, I think we only need to pass an extra sb
> > arg to fsnotify_add_mark_locked()? and it does not sound like a big dea=
l.
> > For adding an sb mark, connp arg could be NULL, and then we get connp
> > from sb->fsnotify_sb_info after making sure that it is allocated.
>
> Yes that would be another possibility but frankly I like passing the
> 'object' pointer instead of connp pointer a bit more. But we can see how
> the code looks like.

Ok, here it is:

https://github.com/amir73il/linux/commits/fsnotify-sbinfo/

I agree that the interface does end up looking better this way.

I've requested to re-test performance on fsnotify-sbinfo.

You can use this rebased branch to look at the diff from the
the previous patches that were tested by 0day:

https://github.com/amir73il/linux/commits/fsnotify-sbconn/

If you have the bandwidth to consider those patches as candidates
for (the second half of?) 6.9 merge window, I can post them for review.

The main benefit of getting them merged in 6.9 is that I could work
on pre-content events for 6.10 without having to worry about perf
regressions.

Thanks,
Amir.

