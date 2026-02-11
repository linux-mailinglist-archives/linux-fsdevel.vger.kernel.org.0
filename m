Return-Path: <linux-fsdevel+bounces-76945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDrRAKqOjGlQrAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:14:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F79112519C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 15:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0367A30166C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ABC2D8375;
	Wed, 11 Feb 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw2BTBtv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2681126C03;
	Wed, 11 Feb 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819236; cv=none; b=damUAzqcc2qYhpHMm4L2WdBOWY1HmQzO+6bDoSIYj90nPGH14fBpSs0orO60hNqU90gqqghue1ZuHya6JobX6RB2W2Kqo3QMj+P0NDbcclXlnMeWbFqSkr4N2za9WMf4w5UpmVcvgJvJNfTDa13WVMLl+qb9XnaGJsPkZnpv008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819236; c=relaxed/simple;
	bh=kTmR8HlNNdypEC2sQgZd8Hmj4lVNRQD+1rgOJ0XCm9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYhjkh/jDxzyWJeQG6EqFjc75obIK594/qW3DqOginmp1W3HSavs8AkBVVFGD1vp+SalpXNrAIOYMcoXet7M3EbRFxpLM8Y0QznxgWS+mbnETxLMv977HuF8E/73hUfMLFv7dqg1sdlu8DXve0J65T5pv8ohAPfkMuMYk3fZFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw2BTBtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7734FC4CEF7;
	Wed, 11 Feb 2026 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770819236;
	bh=kTmR8HlNNdypEC2sQgZd8Hmj4lVNRQD+1rgOJ0XCm9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pw2BTBtv9scYBWfC9uofOv7JqG3PX16nhSlPA3Nu82z5WqjDAYyWTCyHsHukkJY/T
	 UMYJQ1WNiL/Od1c+fGA+teYmZnGYrJsYZI+73VTwE+G17hKpKCSSVKDpg9bx76MmXZ
	 Mx0vWRwlvemxvM2vwkT1oNyg2Z8eY35Rm7s4uhljb0visdkSuiIH7dT7clhODH69W+
	 Sia5s51Go1PrzGGnmktoeMGMg54++Y/bXyGJXb5OUq8TvzOwcf94hUdR1Rh051WavK
	 aMaOJ64ZqYrkFEApgUa/EHMW3ksOh9IDV5G2C8LleQ1wZHvV7SYq/ciM/8EX0KHlfq
	 KG13vuP7myTAQ==
Date: Wed, 11 Feb 2026 06:13:55 -0800
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
Message-ID: <202602110613.7FEC92C@keescook>
References: <20260211004811.work.981-kees@kernel.org>
 <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
 <202602101736.80F1783@keescook>
 <CAG48ez1wxj5uxuMXQLV+yxfT4gumNSoK8UX2+K=5aCLAKg+VPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1wxj5uxuMXQLV+yxfT4gumNSoK8UX2+K=5aCLAKg+VPg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76945-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F79112519C
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 03:06:47AM +0100, Jann Horn wrote:
> Actually, looking around a bit, there really aren't that many
> allocations with __GFP_RECLAIMABLE, so this probably isn't all that
> useful for same-cache attacks. (To be clear: Anything with
> __GFP_RECLAIMABLE goes in the special kmalloc-rcl-* slabs.) Looking

Ah! Yeah, I looked right past __GFP_RECLAIMABLE. As you say, this will
keep it isolated already.

-- 
Kees Cook

