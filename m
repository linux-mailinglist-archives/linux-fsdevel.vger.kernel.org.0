Return-Path: <linux-fsdevel+bounces-68539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E2C5F0A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 20:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6AEC3B5B74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 19:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61972EFDBF;
	Fri, 14 Nov 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mzEGyLyV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lhvJq1so"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE32ED86F;
	Fri, 14 Nov 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763148478; cv=none; b=G8malftjErRBz8HvheRFvOjiDlkBqehAJVntXuYtgV7HrnbhZCkPmhjZ2OEVAIbWDsqleWczhr0xAjNSPLwMpu/KrvxmHd4AN0ZKhXwLWPxe4FufflWZF4uBcAbraPZhaWVfNHAr/QqWNq4e3EzWCdl3+tXAmDdpgIh+Ki8yQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763148478; c=relaxed/simple;
	bh=fIP30BIi+nbkk1jws3UoNLwug2/m6PXiHl2hbLq4bu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oBV+SoQ3t9xFttmAqGMx4lXbsPr6N5zFDgt5UtYqqYMQx/v7yQgBPxl9o9NMAAoBQUnW267Kr74t4lksuuWBbmjpHkdG541p5MVKv27AMC2j9A3fjj5voUZ1mA0mkjN2otrLbOmEtgmxJjayBN4O5Jd+OmE7fzA/qD9FQm+8xyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mzEGyLyV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lhvJq1so; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763148474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIP30BIi+nbkk1jws3UoNLwug2/m6PXiHl2hbLq4bu4=;
	b=mzEGyLyVwMwvGCrTRPZcdj9gBt9D/Gi/TW4q/DtNC3mT/YRfTB44dXerQ0xCYHW0Jvx18G
	Avgb9L0sKkiHMzFAYvobT37WVRr1+0n83BXeKMlPzfHW8h2r9ntgDeYRq3L9mwnlCbKOTN
	mL87vv9eyOgrWwG6qfY4QZLloSEgGSct4hTGKmlCme/3R+Y6FNbMSuvxQ/05BmGH6j+t7U
	AfZodXJ68xIgK7G7iY50g0ek9rYr0m45oyN1p/gJR4MEzJIIz+Q4PXDBnZHoYnUd1dg+Z3
	E0/Nm24A/xOEPapJrGULtIK1VgXnV/h5ybyewtFZzWCPuMgvBboMAzxKi8obkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763148474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIP30BIi+nbkk1jws3UoNLwug2/m6PXiHl2hbLq4bu4=;
	b=lhvJq1soMa2ManHvchkFhjlnOemj1riOo5kEisjHHlHvp2eijVtcSNsrnrrNd/pMvN99ag
	QNNtykBJKnqr1sBA==
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering
 <mzxreary@0pointer.de>, Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa
 Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, Tejun Heo
 <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 16/17] ns: drop custom reference count initialization
 for initial namespaces
In-Reply-To: <20251110-work-namespace-nstree-fixes-v1-16-e8a9264e0fb9@kernel.org>
References: <20251110-work-namespace-nstree-fixes-v1-0-e8a9264e0fb9@kernel.org>
 <20251110-work-namespace-nstree-fixes-v1-16-e8a9264e0fb9@kernel.org>
Date: Fri, 14 Nov 2025 20:27:53 +0100
Message-ID: <87bjl4beiu.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 10 2025 at 16:08, Christian Brauner wrote:
> Initial namespaces don't modify their reference count anymore.
> They remain fixed at one so drop the custom refcount initializations.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

