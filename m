Return-Path: <linux-fsdevel+bounces-62432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A9B93634
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 23:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877912E1A64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 21:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08322FD1DA;
	Mon, 22 Sep 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuoiYeuE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8TbGcw8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17623C516;
	Mon, 22 Sep 2025 21:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577019; cv=none; b=Z/Y6Xaj5am+zJ5kY8arpjifRV2MiYAvTdo3ODKxjBIkzr2gUbz4dKzMZG9tEg7SaxXPag785x31LHzfDLweOxWL68apyCoYagZxFYcWAVTtsMdrkiOnYBWJuLHaqWno43sA3j3LRxOqUKdZncboxTVAWTIXpoxiWnE3bFoRkEwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577019; c=relaxed/simple;
	bh=KC96uCx5DSvhx389nDby1jHwBDrEr4sDKF+iChEG1mU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kjLQCFnLYXrBpkd+ML3JB71OpRKRljrDbo3kQubIdY9iEh85GLjfuzLLdOtPwWblgkcd99S1jU5fDFoZTvIFk02y7LB0KdqRHtEDctygqRhzok8bGTbNiT/DvYmTksXEFd6DEh57yGeOEUGavXzpLCtG+O+WZCHcMW236t7bmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuoiYeuE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8TbGcw8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758577015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8uS2q661HV+PtHIDEt86BNdyP2JqVrKYxRml3PY7Gk=;
	b=fuoiYeuErmGIzXsfYRf8I/qnw40UkgsM2hQCOC4SU21p7PVW7vNemjFvJGanmOf8xcmxZU
	WxwitZF5AIjD2lZGGlDJeVnoD8xHcqjWFH+m+rMcfjo6ysKfqT9j6YTJzasITKNxs5YSeq
	OZ5L60Nzb5DNpelpA9xwRMfiXpIp0+EnD5qWuVkgRsdZDbsr8nRJMAosv7zAU8KPSodJnP
	RiYNeuKSZsEvUVMG3pFXIfdyWEKTU2fAC/kOxlp89tFQjahRBqeJbauJ6LykXuVSZSvK9c
	4jjOeK9RJ7fduRH8zEXNnQbUKwx8SmnSrX0+WA/99HGG/8jZNkAZGSBlXNGIWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758577015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s8uS2q661HV+PtHIDEt86BNdyP2JqVrKYxRml3PY7Gk=;
	b=Q8TbGcw8AH0H5kK6wnfOpETCALVAyJklHv/VJtrz0zE9VZD4ujt5n/W4OWOqcPicfKZRYH
	afJ4L3gq0SZYMzDw==
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering
 <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?K?=
 =?utf-8?Q?outn=C3=BD?=
 <mkoutny@suse.com>, Jakub Kicinski <kuba@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 2/3] ns: simplify ns_common_init() further
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-2-3c26aeb30831@kernel.org>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
 <20250922-work-namespace-ns_common-fixes-v1-2-3c26aeb30831@kernel.org>
Date: Mon, 22 Sep 2025 23:36:54 +0200
Message-ID: <87h5wu41ah.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 22 2025 at 14:42, Christian Brauner wrote:
> Simply derive the ns operations from the namespace type.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/namespace.c            |  4 ++--
>  include/linux/ns_common.h | 30 ++++++++++++++++++++++++++----
>  ipc/namespace.c           |  2 +-
>  kernel/cgroup/namespace.c |  2 +-
>  kernel/pid_namespace.c    |  2 +-
>  kernel/time/namespace.c   |  2 +-

Acked-by: Thomas Gleixner <tglx@linutronix.de>

