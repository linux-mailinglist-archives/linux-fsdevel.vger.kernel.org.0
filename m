Return-Path: <linux-fsdevel+bounces-76314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDf5Neo2g2kwjAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:09:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 732F8E597A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C577C3033FA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96EE3ED11A;
	Wed,  4 Feb 2026 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="AZSOnMie"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CEA3ED105;
	Wed,  4 Feb 2026 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206656; cv=none; b=AewFP6zwKFuu+4ZFJh6CSlpeJSVnR2mTBVIUDir1gjg2Z2avDdN84wvwE0an5rihqEcEo52ua5lBiIUTexTgbkk0TuCljd5WxOGIRHprBcREZVpuzpJZDTl7xPklY9xmU3rvsf2j4SXwxEZOs8v/WPSzlG63bYCdJQfh/JqqW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206656; c=relaxed/simple;
	bh=7G/PwzIk3g4uIGdcJqA20KrJMGGg5TpRuyz/ChE2xac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icXkCsvyp8U7m1Iv+Rb8QlTU5+juSY6JptLVV46yX+0jBdXpqWP1J9y578koz0BwBA3JMcV7oAMNUgH3Kraajxk1whWTc9gxe5ToGFU/m8DI1N1FOGGXAw1NeAbtivHbDQEHCt9vxYUgJO7iXPdwDlCQW8aSFXbce2bs9b1lTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=AZSOnMie; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=Q+Ks08PzHVA8pXNev8uKWfCnJ6OcTFhczPTs0oqi89M=; b=AZSOnMie4dVcjCOeODKz4Zoxz2
	7ozRS3+UpFV3dz8fQWwx4MRQCqx8EZdSUlQy9wfvjeT1edNHzmGMg6V4L+s4p5d6DeBz+fDC6MBWm
	SQR4I+C2LEaUpn4f+RI6u4oX1eRpa1XLY3uoLinNmp9TPAio4wlaBBcQQICxbNjlPYQKPNeOp3u8h
	bHqZSoyKqNoauavjA7QUNPPveR2zwQiM7TgMXCoQsYvoQOY3dosMhNFBrAwxmoEKlHcXI5+R2WPKc
	KFxNVDbiy6dRu5hjxZM/IzfAt8oWS/8NBfsS6IZH3OVt81yj0trwXyuNi230F0zdBM6q7wOGDRNAf
	yCrdXMsYT4hOM+WzmhGD3pI93xh7S+oOkEe+mOMurAAajyGUJ6H/mer9PS1kjKOr6vSu/anOtSKaU
	BMClTz45J/5xzVksHMjaT3JEhz8HZV1A8zd8gPzx/pGNo1EKMoI46dC64ZCm5SLQUX9NfXv/gE1Vk
	O0l9haMVubcIq5eM8DdGRRWu8LEK38Nz4oSl+98tYEu0fgJS2YVVSx9h8YnMxfoDPygOQZSHAjoWg
	TxEav8G/iSIdYe535wH3L5J9SWh+uxIu4G0v/28tpU0A6SxWy5EMpbM8Wkgn/pzwbNl9PGNetVXJK
	nOIXLcHrFmMYeAmh905U3bbXF+gl02CLOzIrzTCSo=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: v9fs@lists.linux.dev, Remi Pommarel <repk@triplefau.lt>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 0/3] 9p: Performance improvements for build workloads
Date: Wed, 04 Feb 2026 12:37:55 +0100
Message-ID: <4711141.LvFx2qVVIh@weasel>
In-Reply-To: <cover.1769013622.git.repk@triplefau.lt>
References: <cover.1769013622.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76314-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 732F8E597A
X-Rspamd-Action: no action

On Wednesday, 21 January 2026 20:56:07 CET Remi Pommarel wrote:
> This patchset introduces several performance optimizations for the 9p
> filesystem when used with cache=loose option (exclusive or read only
> mounts). These improvements particularly target workloads with frequent
> lookups of non-existent paths and repeated symlink resolutions.
[...]
> Here is summary of the different hostapd/wpa_supplicant build times:
> 
>   - Baseline (no patch): 2m18.702s
>   - negative dentry caching (patches 1-2): 1m46.198s (23% improvement)
>   - Above + symlink caching (patches 1-3): 1m26.302s (an additional 18%
>     improvement, 37% in total)
> 
> With this ~37% performance gain, 9pfs with cache=loose can compete with
> virtiofs for (at least) this specific scenario. Although this benchmark
> is not the most typical, I do think that these caching optimizations
> could benefit a wide range of other workflows as well.

I did a wide range of tests. In broad average I'm also seeing ~40% improvement 
when compiling. Some individual sources even had 60% improvements and more. So 
there is quite a big variance.

I did not encounter misbehaviours in my tests, so feel free to add:

Tested-by: Christian Schoenebeck <linux_oss@crudebyte.com>

I still need to make a proper review though.

/Christian



