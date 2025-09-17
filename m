Return-Path: <linux-fsdevel+bounces-61883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79302B7CF35
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D1E1C060D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 07:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187F271468;
	Wed, 17 Sep 2025 07:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NzJfLEVu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3maXnGZq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E1304965;
	Wed, 17 Sep 2025 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094084; cv=none; b=CPjaQN+n4qn+5rgFTn/5WLN361sTF4vgznjmIPG8N5fcp1qrJKOR0EH8Iw/KT9d+kIzILqNQEllhYSUw455Ft0jJBPZiZjz+KxZONUOAIQrs4yib9ebZEpm48ypilr8k0Y3XRKIeq2zuCs3q2+wkvI8nfFpQSsBqIIleBDLEHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094084; c=relaxed/simple;
	bh=vlReshKq7aZiP2IfeO+rloJkTdp+7ht9eznCdHzR5lM=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IXxw6cKNJN5Dc64rS0Z6niVVpN8NcEOgqmIzJk08H/gRbKGGQkU0J3RmreJwNvr8JRdQ7TLj0vVbxUxY5zMSpwWpTo5iHnOGRVTKx014bvvO0crDbir4DC6WERPK7LyT7YsgXzvNl28ql1pH3Z2fkH/AiDobVuByA1JjN0eGCgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NzJfLEVu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3maXnGZq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758094079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlReshKq7aZiP2IfeO+rloJkTdp+7ht9eznCdHzR5lM=;
	b=NzJfLEVuUnqN+7gW7+P5zXHZLrBbaclyUPsaVxuKZ/TWksQeQLoQf4GzlWDpBklzq34scv
	RyU4kvLMYQR5J1sU/iMzC0dXiuMLZrUjsbwZ0twDRVkkIJjr/hrb1/SnTKSHU4LkG/bGty
	iGOziT3CHWrLy/WPTIMBAwY362Z9VmQVwtdO+2x+wsICKBELLsPzE15wJdFpTV2tdBtXHs
	lIJRnPry5lO/tw+bBsgNnZp87W8DCWZi3R7MoyFOnrpRJb4GxJxNXCAArm1FJkQHfD3W3v
	I0bcmkal5qoJN2J1LWBFeozK31msYacyYFQmOOG59ADugxKMeimJPzBbPgkf8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758094079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlReshKq7aZiP2IfeO+rloJkTdp+7ht9eznCdHzR5lM=;
	b=3maXnGZqsZADUCiXBeytBnMWW/Xyr5mpq/7hpeT3sbGgqE+99hrN0eacNNKjyWQvn+Dq26
	ld+tNp7RGGoZqjCw==
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan
 <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas
 Yeganeh <soheil@google.com>, Khazhismel Kumykov <khazhy@google.com>,
 Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>,
 Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] eventpoll: Fix epoll_wait() report false negative
In-Reply-To: <cover.1752824628.git.namcao@linutronix.de>
References: <cover.1752824628.git.namcao@linutronix.de>
Date: Wed, 17 Sep 2025 09:27:59 +0200
Message-ID: <875xdh35ds.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:
> While staring at epoll, I noticed ep_events_available() looks wrong. I
> wrote a small program to confirm, and yes it is definitely wrong.
>
> This series adds a reproducer to kselftest, and fix the bug.

Friendly reminder that this exists.

This probably only appears once in a blue moon, and the impact is
probably not significant. But it still should be fixed.

Nam

