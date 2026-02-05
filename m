Return-Path: <linux-fsdevel+bounces-76364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNJsAZIPhGnixgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 04:33:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A0EE4C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 04:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FEF130162AE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 03:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F88293B75;
	Thu,  5 Feb 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="iMBZcmeH";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="TzytMQbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a10-27.smtp-out.amazonses.com (a10-27.smtp-out.amazonses.com [54.240.10.27])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FC22339
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262408; cv=none; b=KYNYUJSoo/+/9m8izcEy2xDOO/J9fTaSEj5GKpiieRop3Asw4fqBUJA5NZQwoEKyJWBrXAZBLW8JMViVsHmopX6rY+xWDnGbOVgM2wGBFuDstF5bZ1gLlwsTlsyHs1/2HxAkeSZk8UIJU6OeLhyHptzOcsZflaPVoAbEzadhVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262408; c=relaxed/simple;
	bh=gRQZ28uMsULbQMhLr8X9ODsQroP4pIEiGJDo0lolHww=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=KcI+bvNeg4xQl/QSF7VjDJ11p+f8QNBagCLqoOIMuefEQ39Ct3QQBfzcQ+8FwLZlBNxkbWB2TkzeQdj03vG1WFBwQnhrCaOwDJR+ya0qF6CF8yVPbGNqdfhrklRW92+B3k4sIZMw2YMBSnMxCjLlpEx/720JNzn9/TRRkuqDJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=iMBZcmeH; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=TzytMQbT; arc=none smtp.client-ip=54.240.10.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1770262407;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id;
	bh=gRQZ28uMsULbQMhLr8X9ODsQroP4pIEiGJDo0lolHww=;
	b=iMBZcmeH1EK7A0XFUOCCJ9XiAfTDBCUGMqj1WOo/idUPsqwg6jvP6dUGnu+4Bz5t
	amYjYdhDB3g2w8i/YrmjIuV9XftftqtxSQVbI7d6IVqd2n55GTdSVg+vuFatBiq1dGJ
	iAG3IWEF9KGVAaw6eGJfz6jq7l7EB9SZnXstjnsU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1770262407;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id:Feedback-ID;
	bh=gRQZ28uMsULbQMhLr8X9ODsQroP4pIEiGJDo0lolHww=;
	b=TzytMQbT8HscpGQxliWNxidVhOKwbDH7I136E59t+O5dzD3GazhZZRAtbdIj1O6I
	V6lhVWOMKyvI1Gn6FXTHuumU81MuhukGM8/JLwUsXEyXPIfp/UieOw84QUxq6iFsEQO
	IwsDSdb1SHQzUCDSUYzvVVmXI5KN/+RjXHmfFESI=
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Darrick_J=2E_Wong?= <djwong@kernel.org>
Cc: =?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?f-pc=40lists?= =?UTF-8?Q?=2Elinux-foundation=2Eorg?= <f-pc@lists.linux-foundation.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?John_Groves?= <John@groves.net>, 
	=?UTF-8?Q?Bernd_Schubert?= <bernd@bsbernd.com>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Luis_Henriques?= <luis@igalia.com>, 
	=?UTF-8?Q?Horst_Birthelmer?= <horst@birthelmer.de>
Date: Thu, 5 Feb 2026 03:33:27 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260204190649.GB7693@frogsfrogsfrogs>
References: 
 <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com> 
 <20260204190649.GB7693@frogsfrogsfrogs> <aYQNcagFg6-Yz1Fw@groves.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHcllAvpSGd72RtQKiH/5TuuBbaYQ==
Thread-Topic: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Reply-To: john@groves.net
X-Wm-Sent-Timestamp: 1770262406
Message-ID: <0100019c2bdca8b7-b1760667-a4e6-4a52-b976-9f039e65b976-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.02.05-54.240.10.27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.75 / 15.00];
	CC_EXCESS_QP(1.20)[];
	TO_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jagalactic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[jagalactic.com:s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq,amazonses.com:s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76364-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[email.amazonses.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amazonses.com:dkim,groves.net:replyto];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[szeredi.hu,lists.linux-foundation.org,vger.kernel.org,gmail.com,groves.net,bsbernd.com,igalia.com,birthelmer.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jagalactic.com:+,amazonses.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[john@jagalactic.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.997];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EXCESS_QP(0.00)[];
	HAS_REPLYTO(0.00)[john@groves.net];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: EC2A0EE4C0
X-Rspamd-Action: no action

On 26/02/04 11:06AM, Darrick J. Wong wrote:

[ ... ]

> >  - famfs: export distributed memory
> 
> This has been, uh, hanging out for an extraordinarily long time.

Um, *yeah*. Although a significant part of that time was on me, because 
getting it ported into fuse was kinda hard, my users and I are hoping we 
can get this upstreamed fairly soon now. I'm hoping that after the 6.19 
merge window dust settles we can negotiate any needed changes etc. and 
shoot for the 7.0 merge window.

:D

Regards,
John



