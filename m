Return-Path: <linux-fsdevel+bounces-77572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOo2M/y2lWk/UQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:56:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 303ED15674E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F95F3013253
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7E31D750;
	Wed, 18 Feb 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Sb+Jv6Tz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1A2D6E76;
	Wed, 18 Feb 2026 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771419381; cv=none; b=fnka1c934K/rleEwqnN0tui7yEtFqkKD3dz4KJKWXAaotXNGR+FE3tfarZfTI+dPIEXb//4fCURNPccLI5luKdGqSPOeJrPpwqe296pJNYJyX3bAz7qWqeeol/2QVSc5jhIIbFEhffXcRzIpiMBN4ijQcQ9VwqLJScI2mt8kP0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771419381; c=relaxed/simple;
	bh=D721kOqnMJgXW11UxJ3c5NKSoTFXExUb5Aw9fORLDYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQpSHzb6dTlRZIGAS0p4bvLQQduNm3uSQZUpyksbn2jKMq/7DXREYfzzH6/mtF3n9MOf8yU7INRAyUWuvplIxtUlgYrl3DoprEA/WvOIQfigMLJL38jCScFsobfxyc0QjeLG1kyi9HIqo2Ie7KLJHSw0RG4gHF062nDx4CIVPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=Sb+Jv6Tz; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=MZt2HE8eiO0uRLaoVeWG4Oj2x1b20jHkcdDTYTxItYA=; b=Sb+Jv6TzH9c1P6zdgMahAJ6etA
	09cxKjmAbDIjSpfti5nxypN9xZ/2CCaTTjiJ2W2L0/mRPM3uBcsi1WzD1jVSGWA90kzx7CSqTBhqG
	Vf9ElvCi4AIanh8oONWg9OpCi7WCI5saHLMmbrp1pgRHxZyKXQSl2Igtv2M7GyVJxa7qIf+7SXX3J
	4F3+WDgC9P/pE7OGbaQ24K5BSWv6ZFFS6a5qd0wHO5R6zUABuwuujQSuBitpOO5V6aj5Sklj74Ozp
	YvJtKu/Np8ALnNsgGyJnOBNKPv+xZB662LIvKnHvJGP9IAo8v7L0EXUPDsQb4TLjUF61xOIi1LKIz
	CgyBitTv5WeUt5DzcpwNTlm1YJHwRMy/imgcxPtVWMRc4IAqWx3pgDiwgVpDi/34NW9V36OmzfXde
	Q2y8hEU6Y2OVc24qwlAmbmcTkZhEbOO/p6zG8hcJGrlvD5CHnCr3o7h+juGjVufQczBevwSTg2Wme
	PsDlwgGcSjqj6gSb8bZmfjf8k5inTkdkoHNo9H67cRsxA5L/MIs4ZIOhstgAulUaKq4+fILR/Uzmg
	o4qIm+ExEb6UKPEeI3RdFCnJo9qaC91Ui3F3T/gq5n2MNFUuM9hTpMTn+LnOFIMCy+2t7+aNnib1r
	qsLChisCYyUoQ06/wAg1CFyxCiB60fvpxG9W9SKj0=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Remi Pommarel <repk@triplefau.lt>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>
Subject:
 Re: [PATCH v2 2/3] 9p: Introduce option for negative dentry cache retention
 time
Date: Wed, 18 Feb 2026 13:56:15 +0100
Message-ID: <3031269.e9J7NaK4W3@weasel>
In-Reply-To: <aY2cS77rIL-h-8il@pilgrim>
References:
 <cover.1769013622.git.repk@triplefau.lt> <3929797.kQq0lBPeGt@weasel>
 <aY2cS77rIL-h-8il@pilgrim>
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
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77572-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crudebyte.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 303ED15674E
X-Rspamd-Action: no action

On Thursday, 12 February 2026 10:24:27 CET Remi Pommarel wrote:
> On Wed, Feb 11, 2026 at 04:58:02PM +0100, Christian Schoenebeck wrote:
> > On Wednesday, 21 January 2026 20:56:09 CET Remi Pommarel wrote:
[...]
> > Wouldn't it make sense to enable this option with some meaningful value
> > for
> > say cache=loose by default? 24 hours maybe?
> 
> That is an interesting question, I have seen pretty satisfying (at least
> for me) perf results on the different builds I ran, even with a 1 to 2
> seconds cache timeout, maybe this would be a good tradeoff for
> cache=loose being almost transparent in the eye of the user ? But maybe
> this is too specific to the build workflow (that hit the same negative
> dentries fast enough) ?

Always hard to pick magic numbers. But I would also say that 1s...2s is 
probably a use-case specific pick specifically for compiling sources.

When running 9p as rootfs you will also frequently run into libs querying the 
same non-existing configuration files and DLLs over and over again. So I would 
pick a higher value. Personally I would be fine with anything between few 
minutes ... 24h for cache=loose. For other cache modes this could be lower.

/Christian



