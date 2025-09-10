Return-Path: <linux-fsdevel+bounces-60808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B978AB51B57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F58A4E2F90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CBC255F24;
	Wed, 10 Sep 2025 15:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3lpzYxSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rcJtvcfS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D04212FA0;
	Wed, 10 Sep 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757517599; cv=none; b=BI8MVZU+3vBsaT1ZzVE0zwVIZZt7emaXLx5ATud6QtOE3SZCsCrRGHQKxMBm0tmQ1qDAOojj/HPWIhUb6uhSmXaUP6spRuJ9FlOeBY2wiO0zDcJRsmKMCQX1kfsnry+3gOLZUp8/kESVV/7+AWL0AdlRmeg1jknjGmqcXs/+BIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757517599; c=relaxed/simple;
	bh=9pHXN39DCPQvOkmPBX1MN2blSfg4I0tm4i0nrwnt4Aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o8QDXdivSbGBm59G1PTyd5dqEhQKnECKq2Qr8UNcY03Bpanj4dy/ubxmMjI8NYnkrRN1qChuEjsZHKLBcyRok4JMBC+o11QDu/1byOyQpCqi/LhnM+y72CzjxqxwgeXTdGXAaxxQan/JSIxZUJDjVFYg4iFDCgyE62oinjk4uiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3lpzYxSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rcJtvcfS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757517595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pHXN39DCPQvOkmPBX1MN2blSfg4I0tm4i0nrwnt4Aw=;
	b=3lpzYxSM7f/0YDTTIymnYRNNx4r0BrVdXNYQh1R4vDqKFnVrYUyWdTd7fIlVCCwF62Ma5K
	sMIEmG4EbPqyHdovUipdBhksyV0gGcsq7HyErvaBDZPngxLbeD8l7HoRQuSQGQ9zNxyEMP
	QZ1WmklfhorBgVwNO3HIT3+ddD3QuIGmc8W4u1Vo8ZnBel5zEmtcRBgZGYPxj9omh0ATXq
	70r/vvFun7Gyu6wkFwZjZ93QlhZYlqigKcroeHXnaZ8W/BDqIsuIhDq+5efF3Ve47Vz6Yt
	Q3QOCFQxiyA7rJuOlR1apUswG6ZwmR6wUSt7kkUQBsgDTO+JJkluWKdWHeCizg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757517595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pHXN39DCPQvOkmPBX1MN2blSfg4I0tm4i0nrwnt4Aw=;
	b=rcJtvcfSNts8HwUXBaVKvPD528y7c29WMhHTxeMfd9KrbgnACJghPOkotuhFndJ0IWkumO
	Nuq9F1n4fE1q07BA==
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Amir
 Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, Daan De
 Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Eric Dumazet
 <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org, Christian Brauner
 <brauner@kernel.org>
Subject: Re: [PATCH 22/32] time: support iterator
In-Reply-To: <20250910-work-namespace-v1-22-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-22-4dd56e7359d8@kernel.org>
Date: Wed, 10 Sep 2025 17:19:54 +0200
Message-ID: <87zfb2s5b9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 10 2025 at 16:37, Christian Brauner wrote:
> Support the generic namespace iterator and lookup infrastructure to
> support file handles for namespaces.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

