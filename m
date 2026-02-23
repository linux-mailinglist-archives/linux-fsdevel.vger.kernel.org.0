Return-Path: <linux-fsdevel+bounces-77917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NqLHhgDnGkn/AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:34:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D95172BC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 08:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35A11301B67D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 07:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FF5346FA9;
	Mon, 23 Feb 2026 07:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jWKWI2BS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4925393B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771832065; cv=none; b=nQtIBFfT2GD020cbqKMRdyJDke7naR7TRLcgCodD46xV7KVOCK+GUZPTAlU7Qoz6MivTfNBj+sdqlfpsW0mBvqJOv+KFlxKKrtwaL+oe0jAkUhVTWSm2bZOEmerHmBhQTU2xOo7KGDu+jAu4JXEm1xCCrgK8tjWqNAe0MEYAcPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771832065; c=relaxed/simple;
	bh=0huX/VxKilF8hpaSTLWepBfLKx2I+S2zYQYhOjq70Dw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A+OMfImOtOFqqMqz9XJPcS/217n0Ld406VV5xqXYPm63v3HbVTYnXxfvTr3oaSUKO5RcSlQWBub/Xvz5iAsjmaPbtA+1GclaCuCRv/t0n5QPozbkZ3Z2McJmIXy2UDEXwE+BjevmFXOcCcWF8Rxqqyv0H/XDlDom+0/mOALy3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jWKWI2BS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bce224720d8so2461312a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Feb 2026 23:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771832063; x=1772436863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9KxNHasV2s2NqGw0lhhtRyZ4y7rgrLWzlcKrVq6wew=;
        b=jWKWI2BSw7DXGXh3yljnoeQln9/RNdZac7+Ry42c5FGjDrqi5ximGr3zBUFUmxUT+9
         jblMfgtpHtLcqLbyl9XQbDNcFIw69VKZm+4vgw+z3o+MYFKj8kFIWbi9Rfd52JdMPmF8
         y5xXEMjR7hqmxMOU074Gxpdk/L0iEYBt9fsHCpbx9o+6/6KlTTAyfHjx/nJqD0+adCSZ
         +vbMe8VhbBh4c2fxTLMtEx3Jwj9MlCU2y/WDsAzB8UcvN6mr5Piu1Dz/Sc/Ltg1NMWph
         qakVvJnpVhV6yWhovuSHsdLygYw4z7Cj1c+TJr7m6Tqwt1xJ644qADO27/fadrY8yH56
         OSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771832063; x=1772436863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9KxNHasV2s2NqGw0lhhtRyZ4y7rgrLWzlcKrVq6wew=;
        b=Usq+gztagLmkvbG18DyUaESuoL5Nx+0gIRc3o3X9D3qLfVUqRdiso1pNZeRzHZ+To/
         HwGkrPvCV5rRKkocVgVAiOTmmhrYWB96gJK3En8YVhEG1sBH6Fm37Oy/jS2NvIl8zUTF
         AKK3fDRuqIsKud5cZ4HV17IJzDDfMzOkJ7wrTrpmrOchmvCscib2wTQT/dYo7v3VdIGF
         Q6ewSV2sZiqEWNddUD4olMee63JzZgl9oxs9Zf+EhE7WSth8kEsMjV2tV04/PJ4Djw0p
         sg/ef+fw4t2lCtxnFhQRoC5biDX4m2OEUbcav9ItRkyB7oY6YIzSdnx7jm2k8RYmJMIY
         piBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEgYbMr2z3EPrMt3x1/empPjvO9e7RpOoWKOKOnXh2uRQwMqw0Q+HXITCslNlAahzlhWQ1Vy6+PJRan77m@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxxp7nimbDCF92ZQqpKXpLNI9NL3BhHu6quLcKkkdCQHNQDeGE
	5aljCuz1vQE6+ihW3wFHHeLTMNV7aBeUIYj3LJ5Q6LC/eGd9RlMyQQyy4qHpqPwOJ3xm8nQDBxy
	JjTVDXVodb7GHfbPlamg9UPaDzw==
X-Received: from pgbcq6.prod.google.com ([2002:a05:6a02:4086:b0:c65:e8e7:d481])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6e8a:b0:395:16a3:c142 with SMTP id adf61e73a8af0-39545fac8b8mr6774757637.60.1771832063160;
 Sun, 22 Feb 2026 23:34:23 -0800 (PST)
Date: Mon, 23 Feb 2026 07:34:12 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <cover.1771831836.git.ackerleytng@google.com>
Subject: [RFC PATCH v3 0/2] Fix storing in XArray check_split tests
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77917-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0D95172BC3
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

Previous versions:

+ RFC v3: Cleaned up commits and subject references (sorry for the noise!)
+ RFC v2: Rebased on Linux 7.0-rc1 (https://lore.kernel.org/all/cover.1771831180.git.ackerleytng@google.com/T/)
+ RFC v1: https://lore.kernel.org/all/720e32d8e185d5c82659bbdede05e87b3318c413.1769818406.git.ackerleytng@google.com/

[1] https://lore.kernel.org/all/20251028223414.299268-1-ackerleytng@google.com/

Ackerley Tng (2):
  XArray tests: Fix check_split tests to store correctly
  XArray tests: Verify xa_erase behavior in check_split

 lib/test_xarray.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
--
2.53.0.345.g96ddfc5eaa-goog

