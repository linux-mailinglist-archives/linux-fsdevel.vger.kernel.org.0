Return-Path: <linux-fsdevel+bounces-62365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B48FB8F241
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 08:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF38C188A87A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE94620E6E2;
	Mon, 22 Sep 2025 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwsjDxxl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wu4D2YFm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2C16CD33;
	Mon, 22 Sep 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522397; cv=none; b=Ov0UnjCMlEy9Q6TOoTL39HbNJ1reXImPPWOETnenC74zxjzHcEFjssp5EKcVaJTeExbzMHCQHEnDa3qFeAkZBT6NaA4ZsOGL7eQg/brkbagWECdj2D1aio6PSh7YB1ekWzxB3DBY/5sdvE7wmWaqSuLVw0eqqp8sTQ6a+ja+PJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522397; c=relaxed/simple;
	bh=mTlCST+NV6monq4VDOGsq1nkeaCC9gjKSnK3woeXd44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vE5fw6KmIJATxmGCIjO11ILPCZm2BvaRJhtqQCWGPv2+A7f0IZ1vKxnMFbLDsEfeGYLcetA7LONJg3hfwLg+OaK04v8Gp7XCrTj2mcojdGArC29C2pt09J+sgrhvGb1ft35GjeBV3zLc+yPmV3QTFFp1PGgi9NvDGml2tMPhwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwsjDxxl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wu4D2YFm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758522392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTlCST+NV6monq4VDOGsq1nkeaCC9gjKSnK3woeXd44=;
	b=CwsjDxxlHNkml+W3XMI/NH9FoEPr3tY3Yipw6ooOdoWPglQmbvWmxh7WpyqD6T/rnr1BoX
	x8EYY1ToGm6T15s2flEIA8Q+uVu9Fq5dU8PF8pRGRdAafezhgagsUgH7RwPZlfCKbEOwiw
	EtuQntYV9GyksLRZB3WvX5we5IdsgxClxjspoVdEtlYXRd9NN+JM9cWUE3BuPNeUgB7Mn7
	M0tov5A0Vry0YCWPREOJp41V58SeLiQ2Z6ivWgjTeQutq8gPRP6RMxrlhlz04m7jgkIWuX
	uVZ8im9wantJn0jr1Tha+FXSv9cLYzCSrkyYAkJFjjG3YFDDbbifEgpdKbIZ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758522392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mTlCST+NV6monq4VDOGsq1nkeaCC9gjKSnK3woeXd44=;
	b=wu4D2YFmKcfY9Afa/rL7Stcq7Qf4DibBFtqNw42AMRXDqiOqDyv4xakDvdI1GbFVrge3Sr
	CiNMfbqm2yd4ErDg==
To: Mateusz Guzik <mjguzik@gmail.com>, Khazhy Kumykov <khazhy@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan
 <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas
 Yeganeh <soheil@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
In-Reply-To: <CAGudoHF8pKE3ODqY-WnbV=ZpjC9hH+U+COq_KE=aH7mEW8fsKQ@mail.gmail.com>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof>
 <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
 <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
 <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
 <CAGudoHF8pKE3ODqY-WnbV=ZpjC9hH+U+COq_KE=aH7mEW8fsKQ@mail.gmail.com>
Date: Mon, 22 Sep 2025 08:26:30 +0200
Message-ID: <87qzvz9f55.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mateusz Guzik <mjguzik@gmail.com> writes:
> a sequence counter around shenanigans will sort it out, but I don't
> know if it is worth it and don't really want to investigate myself.

The original commit did mention "1% CPU/RPC reduction in RPC benchmarks".
I'm not sure what "RPC" stands for and which benchmark it is. But if it
is really important, we must have heard by now.

Nam

