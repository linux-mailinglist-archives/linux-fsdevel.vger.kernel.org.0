Return-Path: <linux-fsdevel+bounces-77211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HVQCWWNkGn+bAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 15:57:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475D13C3EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 15:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C0DD30247E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 14:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C49C257431;
	Sat, 14 Feb 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GbqH/2B7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D515ECCC;
	Sat, 14 Feb 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081033; cv=none; b=TqZupMBlfigdV7DJULB0JAdUsZEOtLZ+KC2bbp+QvH3S6ypeWLUEv4RppigMQnE0dW5no4/2GrbEUTC3W0UILGt2xZNiM3RRu2y3O4mDMJzlMVwY1DMYmj+gSggen3b0OuqG4tD1Q2w74vNQDGJmX9p5358VsskI88AJu291KH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081033; c=relaxed/simple;
	bh=jEA/qXJdFzDwGJw/PQ74iSIPzhK9C4Fgkc5hJtv+jtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=La7I7t5pIOd9W6HgnIXOO+aemmQ/leOhSlrY2ecyeNKcBJxd9mCWBEMcHw66Igr5lwuGpbLznpKMUT3E3CkZfiTGMUdea9kKpuuwZ89Pth2E3dImggsl41Z5tpAjELYUZBRdeoj14yEPX9hVYf1KGq+KZ/Ste6XcJo+c227hGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GbqH/2B7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB55A411E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1771081025; bh=XXRfMeDTxgrLPvdt9qOWHFDKksHhh8PjgJMcdb8J3Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GbqH/2B7UtPqraQAoJZROudiH5rnpFIAYsyL34vc8dI8kDPt1uiL9BuSdcn7mi2ZI
	 QwygA34nGNaYVP8yGwpTh3yIpMNflu75rAsWhpinwCoQJOTUkhzDUq06hUEE3L7nT1
	 5nl607azT/C1Ry3n35GnW9t8gNzti1ijeosuxGCgav47v7BYCfyIeTwVC2yg58+HWD
	 yQ9FYVF9PT+AEFP/jP2cwoPMqovQrm8j81eDzJFZTtcSB0nXPL12chyVrp80vgTVxN
	 zJEHMMl9DmartF1x3zbvMpzMLvu9dTtmfkDkThEIz1goD4mU25s+q3tX5+ZwT+VOQA
	 V0CAmILttlrcQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CB55A411E3;
	Sat, 14 Feb 2026 14:57:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Wojciech <wojciech.develop@gmail.com>, adobriyan@gmail.com
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: proc: fix double whitespace
In-Reply-To: <CALGt97-amOrBjW0LStyJSoT=n0TsR8nbEuE8rk7ME4joq51+5w@mail.gmail.com>
References: <CALGt97-amOrBjW0LStyJSoT=n0TsR8nbEuE8rk7ME4joq51+5w@mail.gmail.com>
Date: Sat, 14 Feb 2026 07:57:03 -0700
Message-ID: <87v7fzqsow.fsf@trenco.lwn.net>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77211-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lwn.net:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trenco.lwn.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lwn.net:dkim]
X-Rspamd-Queue-Id: 7475D13C3EE
X-Rspamd-Action: no action

Thank you for working to improve our documentation.

FWIW, there must be a lot of places where proc.rst is need of actual
updates.

Wojciech <wojciech.develop@gmail.com> writes:

> From 67259d718da986c176cb45f861a43eb04dfc481b Mon Sep 17 00:00:00 2001
> From: "Wojciech S." <wojciech.develop@gmail.com>
> Date: Sat, 14 Feb 2026 09:51:35 +0100
> Subject: [PATCH] docs: proc: fix double whitespace
>
> v2: Corrected Signed-off-by email address.
> Remove an unintended double whitespace in proc.rst.

So none of this belongs in the changelog; the changes in this version
can be noted below the "---" line, but the email headers simply should
not be here.

Overall: it seems clear that, at some point, somebody wanted this
document to be right-justified.  I agree that's not too helpful and need
not be there.  But: "two spaces after a period" is explicitly not an
error in the kernel docs and need not be "corrected".  Avoiding those
changes would reduce the churn here considerably.

Thanks,

jon

