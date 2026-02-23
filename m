Return-Path: <linux-fsdevel+bounces-77914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JI9HzoBnGn6+wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:26:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE4172A17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2E030420B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330D34AB19;
	Mon, 23 Feb 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zanGjF4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1670349B17
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771831533; cv=none; b=q0mNWrTTgMaoQ3+pgERai5ZhoirEwDTZTBMtot1y6WF27FaimZiliuOVT8Mes6kexU1Oxyrw0FRYvDIz2uCO+ux0Vi/psRUfnHsuZe77Q0jeqa4gY7n1H+vebGyfYOiKBGK46znqC4r3sTEV5Ywjd1/hFUXIoBaEOhUnuaQuBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771831533; c=relaxed/simple;
	bh=0p7wwNeK2XBIAUid0QAunaqfnwA2Hqu8GgTT6oKSXe8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZepIgKHjHFxRlfpyHJ2bTYgUPPyJmaqQiVcLqDeicuztisgwCm7A5wXKGa7IH75efEIvfw7EzfTnkZxlBaXKX+8YaVXGPqyJw1jj92YePl59aUQFj2P+hFf8H++O7nesmGWxvB3N4PLalD3XNr5Y+PXQ6X4STAbnsEjMmePIFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zanGjF4f; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35658758045so2882715a91.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771831532; x=1772436332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qPGaF4mjxi/fFntScorjXmFNHsOVxo5tJME7XiGxi7M=;
        b=zanGjF4fSWliDA5Rwdd6W1MEn6N4YDL6ahiIaB7L5K0TJoXGtTOg39pZCt49x8z540
         KwsCiJDwfzn6feleAljvxYUNDqyPvs5rVwA1A2DYLHSVhNE+kGLpn05YdGydvSQLePap
         2jQmL0zx4yrFQSsarTeftmx6MkhSIKgbIYsPKKmVmp+d4VFCRnr0C8S8VJg2XjDJlAyJ
         Ll51NqvL1DBnlPbdMvDbWeOrVAPxGzcHI1YmXSVzJwiD4qaVZdFjc6RmAEY2aplWOXjQ
         l2Z2w7HCcNN9T59KQNctO2E6SkqBk9h8neylAwz4bHRA6opVqoDZbyl4wonODHEeoaoi
         FULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771831532; x=1772436332;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPGaF4mjxi/fFntScorjXmFNHsOVxo5tJME7XiGxi7M=;
        b=OxDhrgQqCKQwFfkOGOJlYXuL4JZ6azGuWLLI7ifDGVkKN5RT6PFlgI1D2z1nMKoXgU
         YeeNyAIJQJU5qZpe/ch7nvR3ueshqA+QAVa+9H0tdvUdg/5YQnL1qKT2QFdGSF/ZqUdC
         agsCajgAFV3LcCelqO97n63RxGPotliabB6mb74css5nYnHJbLx2CTuUbsaWcYu7TjqD
         7i5h2QRORqugV7/uL7CdZFJGY78qm/Q4C06PPGY6n9HowmpMbFOwSdqpEB7fvni02w2t
         /kx/jtPUd3DI2vc6kkIwC96762hlOHsItaRyVppK9SYExIlYyy2gj61h6Iqe/b+ezc8v
         1w2g==
X-Forwarded-Encrypted: i=1; AJvYcCXUf2UT0ISU7vO2i13LeRLSzGkJfElIXStJggUf1G+ipwTcYFdJEKxuhN9u+ndmVQG2ta5vN4CbSxNeEAfw@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXcscpVQTvmNxSnVAu3fPOLSYs7Oj5+W1oA9x09s+p670dbth
	LZAO8NYiPcH1FnI/ASlxpL9VkqAkXi2HMO/ykz2yXjJR7DoeAJwURxuoLlukQxQvs0wGbk5pfGw
	QeZ5MbcxIL5/yno1MqpbmG4YtFQ==
X-Received: from pjbmt17.prod.google.com ([2002:a17:90b:2311:b0:353:28:3531])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d40e:b0:34a:8e4b:5b52 with SMTP id 98e67ed59e1d1-358ae7fd277mr5726192a91.8.1771831531726;
 Sun, 22 Feb 2026 23:25:31 -0800 (PST)
Date: Mon, 23 Feb 2026 07:25:26 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <cover.1771831180.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 0/2] Fix storing in XArray check_split tests
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@kernel.org, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77914-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20AE4172A17
X-Rspamd-Action: no action

Hi,

I hit an assertion while making some modifications to
lib/test_xarray.c [1] and I believe this is the fix.

In check_split, the tests split the XArray node and then store values
after the split to verify that splitting worked. While storing and
retrieval works as expected, the node's metadata, specifically
node->nr_values, is not updated correctly.

This led to the assertion being hit in [1], since the storing process
did not increment node->nr_values sufficiently, while the erasing
process assumed the fully-incremented node->nr_values state.

Would like to check my understanding on these:

1. In the multi-index xarray world, is node->nr_values definitely the
   total number of values *and siblings* in the node?

2. IIUC xas_store() has significantly different behavior when entry is
   NULL vs non-NULL: when entry is NULL, xas_store() does not make
   assumptions on the number of siblings and erases all the way till
   the next non-sibling entry. This sounds fair to me, but it's also
   kind of surprising that it is differently handled when entry is
   non-NULL, where xas_store() respects xas->xa_sibs.

3. If xas_store() is dependent on its caller to set up xas correctly
   (also sounds fair), then there are places where xas_store() is
   used, like replace_page_cache_folio() or
   migrate_huge_page_move_mapping(), where xas is set up assuming 0
   order pages. Are those buggy?

Changes in RFC v2:

+ Rebased on Linux 7.0-rc1

[1] https://lore.kernel.org/all/20251028223414.299268-1-ackerleytng@google.com/
[2] RFC v1: https://lore.kernel.org/all/720e32d8e185d5c82659bbdede05e87b3318c413.1769818406.git.ackerleytng@google.com/

Ackerley Tng (2):
  XArray tests: Fix check_split tests to store correctly
  XArray tests: Verify xa_erase behavior in check_split

 lib/test_xarray.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
--
2.53.0.345.g96ddfc5eaa-goog

