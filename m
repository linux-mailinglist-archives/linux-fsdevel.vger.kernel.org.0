Return-Path: <linux-fsdevel+bounces-75657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bADbEXs3eWkJwAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:08:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9807A9AE91
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A959D3013D59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 22:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4D333431;
	Tue, 27 Jan 2026 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="L/jbmUyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40732528FD;
	Tue, 27 Jan 2026 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551728; cv=none; b=R/JR2A90nl+x5PfMvmbt6o3TDxUnZLdAu7On6f+VhKDamalLinhr7++XEZrMNQLuq18GSmrwSZfLCu0xSiFoyNJar1DhUhPRVU+ZII7/wtHPBTdqJfjQdg2f6CKUBDNsXJsk3GWs/I4OonNiQszNSZaUClTyBtOQLL6du8zy7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551728; c=relaxed/simple;
	bh=zNVhpK/eZkgjDcqYKfDXwfMPXICvW52/vsM2Le5DWTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abPv/yNpDWsIBrpVzZkLkbt/AfJABKjCKpi4uwpAsui9QpRbrv0EAtwp/0IRww5em2LPz5kuVjOUmLC4Hv3szX+AkGvoBQy3McZRiwTcOKFcYNX3AIcxoAhY8w/y/9CjLctpjr9F+5iwsXRGrr2DUappzEJCY0cv7l0OGWhzJHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=L/jbmUyY; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60RM8DIF3885489
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 27 Jan 2026 14:08:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60RM8DIF3885489
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1769551703;
	bh=y6oQ+uU7Q3nNg8DhxvmUv17AhGXlIrzJZrr4lvC2aak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/jbmUyY8rTYcmXtCACsourh+UsnYa5sLFXMiTh5vsW9LvP623NbcECoo6P0I4XAr
	 F2x8JjtqADk1Jr4uOgcRal76ZYdDU0Atr9lDOxpqXSSr5kteGRve8JranIWKWRbK5L
	 nAjr3Ugfdt5CvzlVK+ptm1y/PfzGjQJF8IjfLJ81MfNIQfHTAneFxeIdqRhySihZbN
	 979g0YiEJqdgdnC8kBHvNN3D2T8skbw8AaS9/HCghG5+bHEMJVF8+qjE1t4SS/6Nrg
	 i4lc4luY+87ZydMSy5rk/ThKHc5oDi04N7r7w6N5H6wjWZysF/+LB2mBkBEALO0Gy7
	 OALr36iXO0eZg==
Message-ID: <93b5c10e-747d-4164-9733-947a63b4f25d@zytor.com>
Date: Tue, 27 Jan 2026 14:08:07 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] initramfs: Refactor to use hex2bin() instead of
 custom approach
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Disseldorp <ddiss@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Petr Mladek <pmladek@suse.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20260119204151.1447503-1-andriy.shevchenko@linux.intel.com>
 <20260119204151.1447503-3-andriy.shevchenko@linux.intel.com>
 <20260120230030.5813bfb1.ddiss@suse.de> <aW_m5eRzqRJzFWnF@smile.fi.intel.com>
 <20260121080015.6aca8808.ddiss@suse.de> <aW_xA0wbC2bf981d@smile.fi.intel.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <aW_xA0wbC2bf981d@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75657-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[zytor.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:mid,zytor.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,opengroup.org:url]
X-Rspamd-Queue-Id: 9807A9AE91
X-Rspamd-Action: no action

On 2026-01-20 13:17, Andy Shevchenko wrote:
>>
>> I.e. a "0x" isn't specified as valid prefix. I don't feel strongly
>> regarding diverging from existing behaviour,
> 
>> but it should still be
>> considered (and documented) as a potentially user-visible regression.
> 
> I disagree, this is not specified and should not be used. The CPIO archive in
> the original form doesn't specify leading 0 for octals (at least how I read it,
> please correct me, if I'm wrong).
> 
> https://pubs.opengroup.org/onlinepubs/007908799/xcu/pax.html
> 

This is the "newc" or "crc" format used by BSD (header magic 070701 and
070702, respectively), those were never standardized by POSIX.

These formats use 8-character hexadecimal (%08x).

As far as a 0x prefix, or upper case -- no, that is technically not according
to spec, but we DO NOT break user space tools that have been working for 20+
years, unless it is either (a) a security problem or (b) is holding back
further development (e.g. because the format is ambiguous. This is Postel's
law in action.

	-hpa



