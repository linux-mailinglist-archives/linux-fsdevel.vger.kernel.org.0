Return-Path: <linux-fsdevel+bounces-73193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DCED11591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 141523003FEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 08:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0A7345740;
	Mon, 12 Jan 2026 08:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ons10gPP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516233C51B
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208006; cv=none; b=apJ9Y5SMzvMSPBXvw2PVd2aTYWKlGXrXyEe+1aZKQLZ69ibNXku0V3B1BKsJO5vf9iMy8fMjojtOeSz/3cOa2IwGrHJ6qOwhvvzs5UTuWTpocoIwQt4ObP0kGKfpojgaA33FQC5a37ceM2C2Mhm3PHgJaWqZdSGONPcyAhx55bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208006; c=relaxed/simple;
	bh=iR5bRUfJYWXaSU9ncyR3oaolwq/uZb/GylTznAhVrMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bm1MWKRGk3RKgGpG8TkhPekLymIahNEguzXxvF5JNYqL9F6p6yLgYMMPnkzU8Xp8/vYZk9JGaHdfqPjGQc5h/rbhK9HGeEhtg0mCuQOigfKKbP2e6B47IFbzpmrcd94iK7MFX4RuIBPJCF192lvGDIgur1xEpqO98IUWgdaIQWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ons10gPP; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=iR5bRUfJYWXaSU9ncyR3oaolwq/uZb/GylTznAhVrMw=; b=O
	ns10gPPFU8QktfXlUVwKR7l9aH5q+l1lnUt8kVXQaZTTJFgZ8Wo7XfoerTyokSIw
	xy75RHrDP7Sodu3Ci/bUOWDPBOPkkij+tGJKpi6Z9t/HOOd3ruZhMIw+LpJKe1HW
	P3xcaIt1iiTMvF3JSvnAwhYyapmYJDMPIdWujvRNoo=
Received: from nzzhao$126.com ( [212.135.214.5] ) by
 ajax-webmail-wmsvr-41-111 (Coremail) ; Mon, 12 Jan 2026 16:52:53 +0800
 (CST)
Date: Mon, 12 Jan 2026 16:52:53 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Chao Yu" <chao@kernel.org>
Cc: "Jaegeuk Kim" <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re:Re: [f2fs-dev] [PATCH v2 1/2] f2fs: add 'folio_in_bio' to handle
 readahead folios with no BIO submission
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-2-nzzhao@126.com>
 <0aca7d1f-b323-4e14-b33c-8e2f0b9e63ea@kernel.org>
X-NTES-SC: AL_Qu2dCv6buEEs5SeQY+kfmUgRgOw3XMSyu/oi2o9UO5FwjDLjwRsMZHpGDETu+umrJzuojyeoUiJT2OJdb6ZCY4wQcJ9J+riUUVsG47H+5gMBKg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <13c7c3ce.71fa.19bb1687da1.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bykvCgDH56pmtmRp9DFDAA--.49576W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQY6CmlktmY-GgAA3-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjYtMDEtMTIgMDk6MDI6NDgsICJDaGFvIFl1IiA8Y2hhb0BrZXJuZWwub3JnPiB3cm90
ZToKPj4gQEAgLTI1NDUsNiArMjU0OCwxMSBAQCBzdGF0aWMgaW50IGYyZnNfcmVhZF9kYXRhX2xh
cmdlX2ZvbGlvKHN0cnVjdCBpbm9kZSAqaW5vZGUsCj4+ICAgCX0KPj4gICAJdHJhY2VfZjJmc19y
ZWFkX2ZvbGlvKGZvbGlvLCBEQVRBKTsKPj4gICAJaWYgKHJhYykgewo+PiArCQlpZiAoIWZvbGlv
X2luX2Jpbykgewo+PiArCQkJaWYgKCFyZXQpCj4KPnJldCBzaG91bGQgbmV2ZXIgYmUgdHJ1ZSBo
ZXJlPwo+Cj5UaGFua3MsClllcy5OZWVkIEkgc2VuZCBhIHYzIHBhdGNoIHRvIHJlbW92ZSB0aGUg
cmVkdW5kYW50IGNoZWNrPwoKVGhhbmtzLApOYW56aGUgWmhhbwo=

