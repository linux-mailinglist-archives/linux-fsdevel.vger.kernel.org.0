Return-Path: <linux-fsdevel+bounces-57423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08356B214D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF456801B8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161922E284D;
	Mon, 11 Aug 2025 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b="NBmwLfRp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hope.aquinas.su (hope.aquinas.su [82.148.24.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75710F2;
	Mon, 11 Aug 2025 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.148.24.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938116; cv=none; b=rRmrDNSKJ+/q1G4CuNHNGFYq+41qjxckd+FD8exB1zlpwISvvzGknGDnySH6Jt9jl/TVqc2jvq5Qd+WqZLp5TJz4YRN2mtRHEEqHgl6toB7IqPAnoolaspDeUZKUpL27sSPAwmkiSEdTBcklgloAlRvingTDIAl22ur1PGXR2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938116; c=relaxed/simple;
	bh=hXwG2EnMb6cQPDJ3IceiTT76RKkMbhadBuQU7JGzWPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2/kdeMZEAr7R49Z+btMiQQiNxR4VXSq1E+n61QjIpXIQ4zVIJ82mj243lI9qtKqUhPyjXyH5jLVvx/zpsv7sQIA+kxW21BSgK8i1w/9CPFF7KDoZYpJE5v5QCxloQAie/jyAC9nUBjqYfzB+hbjGgLxD0Iq+J0fa/w94gWb2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su; spf=pass smtp.mailfrom=aquinas.su; dkim=pass (2048-bit key) header.d=aquinas.su header.i=@aquinas.su header.b=NBmwLfRp; arc=none smtp.client-ip=82.148.24.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aquinas.su
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aquinas.su
Received: from woolf.localnet (host-46-241-65-133.bbcustomer.zsttk.net [46.241.65.133])
	(Authenticated sender: admin@aquinas.su)
	by hope.aquinas.su (Postfix) with ESMTPSA id E9FE86EBEC;
	Mon, 11 Aug 2025 21:48:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aquinas.su; s=default;
	t=1754938110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcnxmAGYKlRkSegiUeAuD2DV7x1h+M7msECCakintXc=;
	b=NBmwLfRpUfvPAg21oWutjJuwQRieUWzSg8EbCRKXlTl9CY7P5KpgZKT0wcHFZ4HCwjLIUI
	OXrQJ4e4000EmGZRThaDR9FXGRE0X6yV09sKQtmU1V3zNY5xT+vJ5JVjW2vuc9Pa/AFelv
	34tU2V5D2t5gaWM0/H3MfhhRaTC4WBbMAQPEEXG23ccgk2Ux7SjHh7fRDgyLlK3/BqontZ
	MEP7VGriSjfkcMny3hHTuyWOOs0q4RHdnbFJUViZ02aMPI2TGch5spKl6mMRA/vB64ogmH
	OXiWSTzO2GIJ8eVyZVguzjU9b400vM+uPFJej7jp/5eaoOQWWHE+TQVBTkVz4A==
Authentication-Results: hope.aquinas.su;
	auth=pass smtp.auth=admin@aquinas.su smtp.mailfrom=admin@aquinas.su
From: Aquinas Admin <admin@aquinas.su>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Konstantin Shelekhin <k.shelekhin@ftml.net>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-kernel@vger.kernel.org
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Tue, 12 Aug 2025 01:48:28 +0700
Message-ID: <6181534.lOV4Wx5bFT@woolf>
In-Reply-To: <514556110.413.1754936038265@mail.carlthompson.net>
References:
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <514556110.413.1754936038265@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> Either he is an unashamed and extremely prolific liar or
> he is very sick.

Accusations need to be supported by facts. You don't have any. And you are 
currently harassing the developer, which is completely unjustified. I think 
those Kent was talking about can certainly provide arguments if they want to. 
But this behavior is extremely offensive, at the very least.



