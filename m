Return-Path: <linux-fsdevel+bounces-71692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3C5CCDE69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACDFD3024892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 23:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F8A30B51A;
	Thu, 18 Dec 2025 23:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="N0r26LLg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cU4C5hv2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B62C11CF;
	Thu, 18 Dec 2025 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766099229; cv=none; b=TTEi6bKUYEVK/2V9PuUocRecXqmdLcaZYABcHL4mJCuP46JrBDyJyLQ+7auwyCdtdPxaZ4kNrmI60IwNSe+le96b34+Y60jXiB4Hj+CL3g8AHE/ul0NlEGNmKbbt44/sew4k+fX7szLV6dEFLC0hmB5eu6/sB2UFUC7vpT285Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766099229; c=relaxed/simple;
	bh=jhG4gAfa4OU3Chyzua7N2zznJOfh/TjAFOfq5rpWjuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qFqjU0bWZnC7WamQ9JGqp+6GgsIHcRTpnWN12MhsqRsU3gWshNYkQupmr5MfVbZYHnCzIVSgRJJASvDKvNiMWzTJAnuIvUoH6szKPTh779RpDuxfIMtjox0fOT1wy5dIbVkE3JYPknsM0meO1YBp40M9yr6Gn0QcolTRW8UQ/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=N0r26LLg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cU4C5hv2; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AEE3F1D0009E;
	Thu, 18 Dec 2025 18:07:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 18:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1766099224; x=1766185624; bh=RkjI2Tc90zBhrrveRKS3/
	+cl4hVdHbrnQaa6eodw164=; b=N0r26LLgxh1msfwg7A3oGO86Xkw9irQbgCn3V
	YCzvdujMMpJ0w2RukUbSaedcA7aQ6JVBWLxwD/aYazZZgGpLuPYbOZrcH0WnincR
	pCZPV/BZ+jBY09StlcKeUeDGtUIbbBZCUubb7hlatn5uAI4mrNC0iQIzPJQU8YST
	rKXWAEoYBQQaatAIzjz3F+o8Os7ItrbDlVCtfKZ758+tG80qVciYvX6NOC5je8NC
	VWaAPtKa8HysAveCybid+Vr1uhc+FyW1cIGIrnzC2XeGdm/IDrJirORSnPi12qIF
	BYK/ghnaInVjBBrCqrbrFI3tXhATUqnPgrVG4PiT81KTyZCZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766099224; x=1766185624; bh=RkjI2Tc90zBhrrveRKS3/+cl4hVdHbrnQaa
	6eodw164=; b=cU4C5hv21dCf1huRYK0t5b9q+RM7b3J5VuB7yRRt1o46JemTeoL
	a7l2NIb0nfqmi1kqv/MA/IQSnpmM0QdcuWpbUYEvo74mlVH1sHkF1j5bwX3TzTFw
	RmDlB0muer5tEu2SMy7Xt4yNkq4osODVVZwGv1FcavhCib4L5ABg4qvUJTdwZuqx
	cyIIIvnxgsUzTMbvF3yRl4k6zPs0MFImLO30YVqta8gbYWF79hYLeB1ztY/TR417
	UmKx7RE2Q8Sa0gX0uB0FczqnOp9uaMV5ELtbrzMI5d8dnxTXBgTH5y8jRW38SV+G
	lhgSjPBzWXM+QbBimFABGhW0jn8Q7ZTeLxA==
X-ME-Sender: <xms:GIlEabp1n9R1rKolVlcYpCdFdGeDkeYksUv81lBegjq2xp4ZjAnTtA>
    <xme:GIlEaanxrqz_BZ13O2MSNE0dNWXXjt-OgIrSgKZF79r4vajg4VBNeOk0zUKCcEvxX
    q9EadL3UqUFFE6rvsVeTK7FjJ3CDsQ5_dKKru59y4WFTvNkH4n9>
X-ME-Received: <xmr:GIlEacfq5oqaCpYpc366sQpma_K8Fb4zWo4vWOIQrtEFP89qBgtUTu46YMrXYrR5Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehkefgtdevte
    dtkeduudeguefgudejheeugfelgeettdfhffduhfehudfhudeuhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghl
    gieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepmhhsiigvrhgvughisehrvgguhhgrthdrtghomhdprhgtphht
    thhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhgrnh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesiigvnhhivhdr
    lhhinhhugidrohhrghdruhhk
X-ME-Proxy: <xmx:GIlEaep2Vq5xZvU1xsXl94V5sSv4nsDHpFazvEAPIH9vrzkfc8iC0g>
    <xmx:GIlEaePZZT69ZIl0evO8ePShVGkHPeNOu8Gkhm8qsZMUdFxO9GtM0g>
    <xmx:GIlEaZieL0JhcYAhjV-pLlDRg9bLRRiMfYNz59DHUAj38GCbtNBbhA>
    <xmx:GIlEaZtPiW7HD_TPTPMLKVPb_0ESlShI4SkWvXU1KCrzP3SVEWyWIw>
    <xmx:GIlEafmtYDO9kgdcV_i8Pnic5wBXUBn6-Ii0BIkc91wLL0t5Hwnj3mPW>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 18:07:03 -0500 (EST)
Received: by fw12.qyliss.net (Postfix, from userid 1000)
	id 7C82A7CDB41E; Fri, 19 Dec 2025 00:06:53 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Alejandro Colomar <alx@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-man@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH] man/man2/statmount.2: document flags argument
Date: Fri, 19 Dec 2025 00:05:17 +0100
Message-ID: <20251218230517.244704-1-hi@alyssa.is>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading the man page for the first time, I assumed the lack of
mentioned flags meant that there weren't any, but I had to check the
kernel source to be sure.  Sure enough:

	if (flags)
		return -EINVAL;

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 man/man2/statmount.2 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
index 8a83d5e34..cdc96da92 100644
--- a/man/man2/statmount.2
+++ b/man/man2/statmount.2
@@ -68,6 +68,8 @@ The returned buffer is a
 which is of size
 .I bufsize
 with the fields filled in as described below.
+.I flags
+must be 0.
 .P
 (Note that reserved space and padding is omitted.)
 .SS The mnt_id_req structure

base-commit: a5342ef55f0a96790bf279a98c9d2a30b19fc9eb
-- 
2.51.0


