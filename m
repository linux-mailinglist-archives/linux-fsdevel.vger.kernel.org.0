Return-Path: <linux-fsdevel+bounces-17067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B438A72C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 20:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E6281F22CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB14B134425;
	Tue, 16 Apr 2024 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uGWW3Onz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E9134405
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290662; cv=none; b=kMacPRQvzAdAXcfM4gGyqDagqr6n9YS6OhAZuxh5pPCo5FowtB8Ko1yNzKbvwq7IJlVoWYLz+0yJuvZ5ThjKmKoEK/IE1PxHy8tdfxBlUNMVMDb/XFQa7SFzN1pBq8ijZg/xIe0gKaZsfIN2xg28G+XCobjX0iEBs/ifZPFtV48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290662; c=relaxed/simple;
	bh=frKMeqIQN8+KD3KcIt43192PkN7TbKSuREzwZvQgruw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XCtKwHUvzrWwJCjbdME6mpr1zENWw0bb6o/Adb/zL50mgOoP9w5bMy0BaqdBodEOjSn2NuoywuO/5DRJeAhtfNWy9wcbFA6+6L2HLL9qASDzfL5YeviQiEmhCRhJCgDIxzQ2TKtu9+VQLYkxZ0qOhUnOoa4ZkmQo9fuFdAhcPyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uGWW3Onz; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-78d777d7d1fso351823685a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 11:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1713290656; x=1713895456; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnRxPaR/WBJie/EF1MXtzJQaBMFQNq2FarwzuZwnBfM=;
        b=uGWW3OnzIDaxszO4LgMV87Q9Hs1FnNuFpYf55aHXMoCEsfQwQkqm64K3F64sZ/FcLZ
         J/BKyQb4I5C3cE2eH5rfXUpOZsDoUNH54yw0jmMcZLnDSFfJmdWkKQRydJN4PdvXRuW0
         Sp/dn+gglhHxCxr7Z00eEc6hkO4r1v+/ShZ8RgeJgw0RQxRgoFb7vcGMvz777IAtaNRL
         fV+sxozwBQr/mM6WeZtwFtTXEX5hT+8aKwr6/Oms7pwS6lCgw26VOBdARXh6waZaKWoI
         /9yZY4jOrSwBgW/sdaEts2Jq8jFMUUfToDR3XnwR7o4zo47CD1wjwMp5MWnOpsLp3P4d
         3ByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713290656; x=1713895456;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnRxPaR/WBJie/EF1MXtzJQaBMFQNq2FarwzuZwnBfM=;
        b=aSS74x0ejIU8R3x6Lrlcx/T9LKjAcvF1bMM3OGCHcRfzrR3L/HWaEkFSm7yEmXXvdt
         sYOp1fUM+cQv7m+enjibupwXNExpP/KhsP77H4E6PnCDNYzo1o0WGQXnPx6+r+26FqSd
         j1LpaNyTbZLXS2cv77mQey/osSaiQOF0H2Oue90Ui7F/V+/w9q5ZW6RWOR1mpxJ7JWBy
         3aij8fg+eOwEO2MtEwPmAXX5sM4F+UNndqYF9pAQNUSOdN26C08dMnY4o0SdT+MaQHlb
         mXZzIqzBkcJEJzyMv7uBYJvGfq2DUn1mstQN9bidwPDRuBzL2FoRSTlh1MpoK0RPHYtI
         f0gA==
X-Gm-Message-State: AOJu0Yxh4ek58oMD86MekQRueqnf81DiRU0bAE3vI6x0/3Ruijvdpbe5
	O8YjVyJXvHGvNV0vJY2RaFq2LWbvM+TX6nySvHqsbW6/qDvu//MtHN2u145URERh8aDYculOAiv
	0
X-Google-Smtp-Source: AGHT+IHRcEXxoyqW3xSMY7oCoKgyWep7SRC5LYWZUMEi263EnozyJV4jcx2O46enuMrTShc8Ny3x1Q==
X-Received: by 2002:a05:620a:f92:b0:78b:c9f0:9c26 with SMTP id b18-20020a05620a0f9200b0078bc9f09c26mr14640367qkn.50.1713290655912;
        Tue, 16 Apr 2024 11:04:15 -0700 (PDT)
Received: from localhost ([76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a295100b0078d5ffa723asm7690595qkp.94.2024.04.16.11.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:04:15 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:04:14 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
	kernel-team@fb.com
Subject: [LSF/MM/BPF TOPIC] Changing how we do file system maintenance
Message-ID: <20240416180414.GA2100066@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

There have been a few common themes that have come up over the years that I feel
like we should address.

1. Adding new file systems.  This is a long and painful process, and I think it
   should be more painful in order to encourage more FUSE use cases.  However, a
   lot of the reason it's painful is because it's a "send to Linus and see what
   happens" sort of process.  Obviously a lot of us get a say, but there's a
   sort of arbitrary point where it becomes "well send a PR to Linus and see
   what he thinks."  This is annoying for people who review stuff who may have
   legitimate concerns, and it's annoying for new file systems who aren't sure
   what feedback they're supposed to take seriously and what feedback is safe to
   ignore.

2. Removing file systems.  We've gotten some good guidance from Greg and others
   on this, but this still becomes a thing where nobody feels particularly
   empowered to send the first patch of actually removing a file system.  In
   super obvious cases it's easier, but there's a lot of non-obvious cases where
   we kind of sit here and talk about it without doing anything.

3. API changes.  Sometimes we make API changes in the core code and then
   provided helpers for the other file systems to use until they're converted,
   and that long tail goes on forever.  We generally avoid doing work that
   touches all the file systems because we have to coordinate with at least 4
   major trees. I'm particularly guilty of this one, I didn't even notice when
   the new mount API went in, and then I wasn't sufficiently motivated to work
   on it until it intersected with some other work I was doing.  I was easily
   halfway through the work when I found out that Christian had done all of the
   work for us previously, which brings me to #4.

4. We all have our own ways of doing things, but we're all really similar at the
   same time.  In btrfs land we prefer small, bitesize patches.  This makes it
   easier for review, easier for bisecting, etc.  This exists because we take in
   3x the number of changes as any other file system, we have been bitten
   several times by some 6'4" jackass with a swearing problem with a 6000 line
   patch with an unhelpful changelog.  I've had developers get frustrated with
   our way of running our tree because it's setup differently than others. At
   the end of the day however a lot of our policies exist to make it as easy as
   possible for everybody involved to understand what is going on, and to make
   sure we don't repeat previous mistakes.  At the same time we all do a lot of
   the same things, emphasize patch review and testing.

There are other related problems, but these are the big ones as I see them.

I would like to propose we organize ourselves more akin to the other large
subsystems.  We are one of the few where everybody sends their own PR to Linus,
so oftentimes the first time we're testing eachothers code is when we all rebase
our respective trees onto -rc1.  I think we could benefit from getting more
organized amongst ourselves, having a single tree we all flow into, and then
have that tree flow into Linus.

I'm also not a fan of single maintainers in general, much less for this large of
an undertaking.  I would also propose that we have a maintainership group where
we rotate the responsibilities of the mechanics of running a tree like this.
I'm nothing if not unreliable so I wouldn't be part of this group per se, but I
don't think we should just make Christian do it.  This would be a big job, and
it would need to be shared.

I would also propose that along with this single tree and group maintainership
we organize some guidelines about the above problems and all collectively agree
on how we're going to address them.  Having clear guidelines for adding new file
systems, clear guidelines for removing them.  Giving developers the ability to
make big API changes outside of the individual file systems trees to make it
easier to get things merged instead of having to base against 4 or 5 different
trees.  Develop some guidelines about how we want patches to look, how we want
testing to be done, etc. so people can move through our different communities
and not have drastically different experiences.

This is a massive proposal, and not one that we're going to be able to nail down
and implement quickly or easily.  But I think in the long term it'll make
working in our community simpler, more predictable, and less frustrating for
everybody.  Thanks,

Josef

