Return-Path: <linux-fsdevel+bounces-78437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJYZOGbGn2kzdwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:04:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E01A0C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCCC3078724
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44515389E1F;
	Thu, 26 Feb 2026 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJnaddVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4270281357
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078658; cv=none; b=N+HOrD8Y8GYUkuoZq0waBqdtRUzGr85LmRqnQad4T1Q0ZQc2c4q7x45smj5hAQror9BzdWhelkspMZtPltMDl4S9AqHoO4bTB5cNo0qoCl93AGbaIATTPo2P4QHM9IwhR1KrksSIO5vnIKwVujt3CQF+eBEW+EmZOamlXh5U/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078658; c=relaxed/simple;
	bh=jk3xFRUoiaUySXubylxU67dzpVU4OZlc84xph3b29hk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t8PJ5KbmQGxLgIf19dsBT0/K6Hv0QZ7svxxyGPSXJbxnyhmvT2QM69fQiwKR0AD9Bk2vqVUB3p07L6YQ/cQom0lx+HVP3fKbrs5KpdJjjBeoc773QYhHW5KZbc1wXovdhjXLQuNmRFHcMvOhyl0iEx+M9047K4JEV9+Z7hUh9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJnaddVD; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ae222d978so247495d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 20:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772078656; x=1772683456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BZGS2iXBu3e5mLILUuzixZMMtSe8MPp48i6zZDjQrxU=;
        b=XJnaddVDtXIM3il3JhNVhh+lWjk5FsIJWd3H0VV+kLLvU6AAFWvkj9Cs1/feWXGqc8
         Aw4pNjzb53JE/EfJMUR42rT60jM0zItOnmfJGBViM9IjnvLtKrc7ts15bOBPKC1flNEX
         12lGMTyc/A30rW6+MXTkiOh/KlHteQZC1Rlrcfj7rr0BGIm0bPqxQ9QhrsaaA7tNazIl
         lrXwKlWv4HhjwegQXS9pJFI1RmQrAng0NHteVqik9i9OFVcDwT1cuvNf9ml6I0KOdKTR
         x8K+ThV8F/D9C/hrH7utctGcuyTVdd8mbe5pgFEjukm5x7DdBWXUYCHsd6/GDAYBQMDX
         pdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078656; x=1772683456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZGS2iXBu3e5mLILUuzixZMMtSe8MPp48i6zZDjQrxU=;
        b=HqTjUrd7lb46gUfKIHAQXXLyXnGCKEVwOyHhi/Xnr/dX0vv+kPqKmNKMtT1PYbl/Wt
         J1xACPh3L6RG/TLyGz8JThmVCZTjU8J8uBEPfo7W9ZPHC2fhIC3gyc9Ao/9YcOQEX44D
         AOCaLU/ThzjyWrGgfWUh4jv9mnFI3U3zNqohLbm5AfX/NgtNmKegLsUjwSsI7oxfLiST
         Oqy9DI4E3H7W7NBolnVajECMc1X9AYyiM2PPrvbXlJH6qtUv84/1KD83UjVBD+6ATrI4
         v2PE9SJn5HJi+4bXP+MWRygMAZ5KAJOyh+tELTRVhTaYdtaPp3g1PQVUpZtKXqYHNby1
         i3Ww==
X-Gm-Message-State: AOJu0YxJh4OlrzgnW7IhClDrkdHyNnVYX5Gn2oyx2wkU5DDXuS1jd8/p
	dueRNYc5pnBKd2m1hj4hfbQO10wRa2WEiZOcnvnrE0BTC/b+KXFme3N0
X-Gm-Gg: ATEYQzyjk1FuCaQ4/EMovubd83oXk2tnUIQZ+J0fJMtc4OLixef1rLhASdYBPtw2Us0
	1pU5udSzPLJi9vqLiFXa4YGfGvCcPxZoOVJkfrJ7k2PwqGTkWccLZy+2CNDk4d8z0xK1hZ6kuZP
	LFmbB6WEzeYsL0cmDigAxeVWkZRsJBWJZEdh/EEQXrAmZJjFUgDa9rPWtv9DdsmkLRB3jtnf6AL
	VRyuYSP7ju/R30By+cdE6W4TEPvvXLC/vKLBRPZr2uHfGzfqnhM1RG0pTHujD7IwN7etlZoJM1O
	/ft8kknUUeVHPQZvnN2hBRF6Gbj2xuwFKcJhjYvOu6865f5/EwnezJzDoBiju3ujct26EW45EqO
	2BR9t5ssmJtJKlQkQFmyfVL7x4Bv1rjjooisR4gyDBqd/RVyOSLb+umgML1ZSLFIZquG23x9+F2
	7uEDKEnHqIUFwyu7cutKOUMdJF/zUya7PoLXCQCRJE/TwlDn2j1MSEWpqA7GjU0WyB/vuCcbC7g
	50qsMUDW0NVQQZiNSx+qrV9
X-Received: by 2002:a05:690e:1501:b0:64a:d9f7:9d5b with SMTP id 956f58d0204a3-64c789c7ad6mr16598690d50.19.1772078655603;
        Wed, 25 Feb 2026 20:04:15 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb759f638sm498466d50.7.2026.02.25.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:04:15 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 0/2] ntfs: Fix two minor issues in namei.c
Date: Wed, 25 Feb 2026 22:03:53 -0600
Message-ID: <20260226040355.1974628-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78437-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B6E01A0C24
X-Rspamd-Action: no action

Here are two non-bug issues but should be fixed.

Ethan Tidmore (2):
  ntfs: Replace ERR_PTR(0) with NULL
  ntfs: Remove impossible condition

 fs/ntfs/namei.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

-- 
2.53.0


