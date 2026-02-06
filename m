Return-Path: <linux-fsdevel+bounces-76652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBvXNk9yhmlINQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 23:59:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C6103FEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 23:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 546D8300E461
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 22:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9130FC06;
	Fri,  6 Feb 2026 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YyzMC78p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FC52EC080;
	Fri,  6 Feb 2026 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770418762; cv=none; b=h8436UYvwi7ug5mPhHf9dM5aoMORWKoKO123oVb3I5OKM54HyemDsl5/Rzu1qquDB5EKGBeZ9EBir2f4Mifi7tb8yFWJKueV/kh2DD+SSp/EYw4OgFLoL3019KTSwlPHZH0AZMEzshv8vckLfaf44Mg8qjQInt02MjdpciKSNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770418762; c=relaxed/simple;
	bh=HgrPqahvKSC+3pLJbLbSqxeZA+MNAMItNVfs14dPLzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UK02kb7ZByehDAhJyt0UT4LcVKcOciaFyi6R0tAe3l2UVQo2VxOUeSIn8XylUOvEex7d8MDJYwACDyAUKR+ngpFYf/mvXUjqnppXVMjZ5oPS6csTX5G5aD0HmjpyHRHRmDm1t3uYRRTfnu87/j6r2XJSZiOSnkXReGkdoP0N1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YyzMC78p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 82B7340C3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1770418761; bh=RBeZ3QqeRRrFj81rm3Ls1gh3UuGDICwkpAl601siemc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YyzMC78p4uc6xu28e8vgtoPqMypY5xFMnDOgvZXDtINjD9hAA9rSluQ6SejloPR2K
	 98OGQr1IUV7GV8jevu52Lir0ixlyqwnAtuBbeWnSaA06m6DlLPEsBi3ok3LtywF2+A
	 8Kp/8VySVkAaxf7CHWPdENjgQ6/m7rqIIvAMoGArlMY2xRkWr/nZWT9o6j3BFwPaRh
	 HiWuw3DbWsK65Sp+KPgli/VEa1ReWjIJk5GcpecJf749d7tjARBNTTYxmVkvd8SzHJ
	 37Sa+Y/eLzYj35c4UToHdvyD/Naxbs/7A9UjJ2cxphn80j8xlwOvcsQM0E2k15K15Z
	 lKKhUxJqLyIsg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 82B7340C3E;
	Fri,  6 Feb 2026 22:59:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Viacheslav Dubeyko <slava@dubeyko.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com, slava@dubeyko.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/4] Machine Learning (ML) library in Linux kernel
In-Reply-To: <20260206191136.2609767-1-slava@dubeyko.com>
References: <20260206191136.2609767-1-slava@dubeyko.com>
Date: Fri, 06 Feb 2026 15:59:20 -0700
Message-ID: <87343deawn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76652-lists,linux-fsdevel=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lwn.net:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:dkim,trenco.lwn.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 024C6103FEB
X-Rspamd-Action: no action

Viacheslav Dubeyko <slava@dubeyko.com> writes:

> This patchset introduces initial vision of Machine Learning (ML) library
> in Linux kernel. It is an effort to define the ML library API and
> to elaborate the way of running ML models in Linux kernel.

I went looking for the documentation files ... but then I've always been
known as an optimist.  That would be a nice thing to fill in.

Perhaps more important, though, would be a real user for this facility.
You must certainly have one in mind, can we see it to get a sense for
how this library is meant to be used?

Thanks,

jon

