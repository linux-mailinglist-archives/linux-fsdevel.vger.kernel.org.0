Return-Path: <linux-fsdevel+bounces-9083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A505283E01F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 18:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D13282094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1ED20327;
	Fri, 26 Jan 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bGdeKoUW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuzagaiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445532232D;
	Fri, 26 Jan 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290206; cv=none; b=L5YvgZjs770hr3tZmtODHg5gAj7dOKu0ac/byP00eN1b4geL7ZVfyc4vJhoxBOsHqJLnySm2quOzKkAVsa0Qmt705was782T0lkULPNJatUaK3p7Q1LDCNlsSrWwbYlph2HpQK9hiXuD7+l0xC29z/THstn1aoPnRf3VB80e7yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290206; c=relaxed/simple;
	bh=AY8Cks8zfkNSy5SPyTgmyBUVqOof+a8pLzc/7ONF3ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tO008iGdDgwW2UsvOL6xI0dD8oonNyeMrNQM/Yd6SuS0udpyHQWKwKl/jDobxLwwNg5xzxM9CKAOXYGMknR0dbPph9AfyjuXn7Gx/NFn94rhEvnZtvPdTy1VtFrz9iGTPSlz4koV+00K+zdChgVYJn/5aISnMqySDurzbIT6TVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bGdeKoUW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tuzagaiU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706290203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y16NGcUWXAd/jpol4Aw++3XVEwkU5CL0GFzr1MU53XY=;
	b=bGdeKoUW9WdLqEtKEsxkWkPluiF27VXCxZSKAv3EF91of84hHPJu/t+7B9mlIfqDmwyhVQ
	5Wy0Ak8LYkBMFC536ObQrarSAFKXlxaX18tfj4mZezpiUfaQdkDMG9wQCtqs11xhoOwLv7
	pA8thEtSPHwm3lmTvJ07FPxtZYE52z+dy31Yz3fjNkM6LKIgSZ5nuds6Q52aKp/nVmBSyY
	+spk4CBBiK/sbO9HcOKfH2EIVtfT4fH6iY90wZoZZeksjxdCmGo7r0pBec73lzMMxFQhVc
	xpFa/bEbvEtI2gao8tw9CtiPgX/FYFPnpnN4YzjNzl3kjaWgFj/y/mmB8OSJKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706290203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y16NGcUWXAd/jpol4Aw++3XVEwkU5CL0GFzr1MU53XY=;
	b=tuzagaiUxCjRffYVMgp6n3kaVE2tR+Ydl0coEnXTNFJKMgQQ2tLfSrtS+THdp+B8unTwvq
	SjL+Cz4iYZ9oxJBQ==
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org, rostedt@goodmis.org,
 joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
 duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
 willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
 gregkh@linuxfoundation.org, kernel-team@lge.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, mhocko@kernel.org, minchan@kernel.org,
 hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org,
 jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org,
 rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
 linux-block@vger.kernel.org, josef@toxicpanda.com,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 jlayton@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
 djwong@kernel.org, dri-devel@lists.freedesktop.org,
 rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
 gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
 boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
 her0gyugyu@gmail.com
Subject: Re: [PATCH v11 14/26] locking/lockdep, cpu/hotplus: Use a weaker
 annotation in AP thread
In-Reply-To: <20240124115938.80132-15-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
 <20240124115938.80132-15-byungchul@sk.com>
Date: Fri, 26 Jan 2024 18:30:02 +0100
Message-ID: <87il3ggfz9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 20:59, Byungchul Park wrote:

Why is lockdep in the subsystem prefix here? You are changing the CPU
hotplug (not hotplus) code, right?

> cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
> introduced to make lockdep_assert_cpus_held() work in AP thread.
>
> However, the annotation is too strong for that purpose. We don't have to
> use more than try lock annotation for that.

This lacks a proper explanation why this is too strong.

> Furthermore, now that Dept was introduced, false positive alarms was
> reported by that. Replaced it with try lock annotation.

I still have zero idea what this is about.

Thanks,

        tglx

