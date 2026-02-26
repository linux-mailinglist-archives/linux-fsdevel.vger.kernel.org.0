Return-Path: <linux-fsdevel+bounces-78438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLfAGFPGn2kzdwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:04:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 878381A0C15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A83993023D78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E6538A708;
	Thu, 26 Feb 2026 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEYQbSZD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CC38551E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078659; cv=none; b=aaIx26Z6w92oOiUTIFj8T6gCNQDe0FX/LzkMLKNwTS4N5XNndkUzwHQjclY+xCT2PMyyrSG+IFereWk12FNJMX3BComiZPVN533bpyc9PGbT7Ky/DQ1+KabZ7taNgaz2b+4YqYpQO2znX3sUPSwznp20sIEa4mrk/LyCAVbqPHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078659; c=relaxed/simple;
	bh=hzQVhjaSP+qcRRN6UWE5+eHmnCqVf4TOTLjd2mdvzcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvPYOZ8JSBAHi15Lt0LuIAMRgvzvLa2Ol9ZvOPaEgEv6rdV4YG4xM3QS8wpKLvsXTNTcOFzPfGpLNn7pGmUqxVDVqOdVViXZn0GYBNTkdYCWhDEqGdNoZbja33/cNsVrZeC01HNcAiQn92c4nRFg9rXvLZdqno80u51QlfG2VlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEYQbSZD; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so307870d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 20:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772078657; x=1772683457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnZ/pDUrDFnoEM6bg4B+njajENgtjVHfzWtgYjXZ31I=;
        b=hEYQbSZDFA3udI0S6kx3UtdGFB5e8mvL1n4sFyEO08WaVx9uhU9VlXyp6LV490SAOh
         UJkwcDaTD+uUpLUU0DCiqRljUEMRZlc9U47X0Hz8XUHRzQIq0fcPOl+AsYJFxwJC6WH2
         zmOVOkwwWAYdJKGpGQCuxmO1NFn2o9nP4mHyupX+N+UnlL2cPN4wbtU5pxapfUHby/zU
         Z8HfBnw9OGvGgTmU9/QFQvIIpg2IJvUGfKWRnRtnQgCm+xeyGsUpKlFrLHsQrEHZ95gt
         znbY+STNHSyrGnKmyfU8qQHJkRvijqELV2lNXq9MxYOQQhkD25dwE4zaL4joe96MWym5
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078657; x=1772683457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnZ/pDUrDFnoEM6bg4B+njajENgtjVHfzWtgYjXZ31I=;
        b=bzlv5bsRFEfWKMJLAfJqLpKms3BFExPvfnSRLdnjVYplyNtm+f6kjoBfFGT3i6q75B
         pC0mGHj3ARiC2GBWjZwxBN6pyyVqh9haOPgLQYEdcKpdHwf+UHrHkieJpY1gXhKqkfxJ
         rXmWSfyDy3Nnt2X23bHY+TGTzMvkSn3cVXyfS450OAjhcCpdcYIWdlWmb9wNBeXHf06G
         ZnNe3xbK9Y0Eb4f+AK+S+IwO4inAHeW0HloTZcOZooJnw6Q1Nmaef56uECwZmzwtTOuM
         2iAdcIF4m/TLG+cnB4OD4I9483Pxf0bNnZOatKqYKjnlsEA4dBoMccNHbvhGcEPJCBV6
         cykg==
X-Gm-Message-State: AOJu0YzuRd922QCV0kUz6lIXBT4Bmq0fMYzyJDaR7NWosJGralsQRSuc
	X+IGLhuWZ/9tGvxfnY86eXgPsh6F4ij7lPwXzpnJJbo7yhwB/sDZTBxf
X-Gm-Gg: ATEYQzwfEw3hZAlVClwpE9pCqiYf2HxDYdn4Uo+vCGXa3vn41uyxn02OZGWGwImvdlw
	zMkW9Iam6UWIVG+aMKdEpyiVj2i2yqH/I3FxqfXoPqRgxi0hUkeLUdQEwCwFEXeQaABam4oLO26
	CMou4dhKym7zSINvgXInhO7VFWmejE352JzgBqfCcX9WlUUQ7XOw6GqCXaGxXSqGOMm9GLj9zxl
	3UFgK/19omHPciuubt46bubObqCODu9HtAK9an5I3N0opbgFicCLKLu/uqmBqcwQiHsdXwGOUhx
	hhFYlzL6eM0OoWfHTYBWkCiNfSUyLuBCKaGP8e8+pcLsP4bj7D+NAFc7SfLWuafJRl5YnZ75Mwu
	5knEgKMgkntYg9EUR84asz5nCYncUE7IUf9KaDR9qhpSBR5pbZUjo7QFxjf2dZlrf5BVIMMtoa+
	eXUyRg75NgYer/GU0EzXYkjfUZMyxnK2f7pk9gZ/bfRUtvrb1Cu9TE9K+OmTWFeL0AMoNsKYjia
	prPGEBEL4jTIncQxOC+nvVg
X-Received: by 2002:a05:690e:1915:b0:649:d502:3bfd with SMTP id 956f58d0204a3-64cb2523b04mr2441186d50.68.1772078657113;
        Wed, 25 Feb 2026 20:04:17 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb759f638sm498466d50.7.2026.02.25.20.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:04:16 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 2/2] ntfs: Remove impossible condition
Date: Wed, 25 Feb 2026 22:03:55 -0600
Message-ID: <20260226040355.1974628-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226040355.1974628-1-ethantidmore06@gmail.com>
References: <20260226040355.1974628-1-ethantidmore06@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78438-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 878381A0C15
X-Rspamd-Action: no action

The variable name_len is checked to see if it's larger than the macro
NTFS_MAX_NAME_LEN however this condition is impossible because name_len
is of type u8 and NTFS_MAX_NAME_LEN is hardcoded to be 255.

Detected by Smatch:
fs/ntfs/namei.c:1175 __ntfs_link() warn:
impossible condition '(name_len > 255) => (0-255 > 255)'

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/ntfs/namei.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index cecfaabfbfe7..2952b377dda2 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1172,10 +1172,7 @@ static int __ntfs_link(struct ntfs_inode *ni, struct ntfs_inode *dir_ni,
 
 	/* Create FILE_NAME attribute. */
 	fn_len = sizeof(struct file_name_attr) + name_len * sizeof(__le16);
-	if (name_len > NTFS_MAX_NAME_LEN) {
-		err = -EIO;
-		goto err_out;
-	}
+
 	fn = kzalloc(fn_len, GFP_NOFS);
 	if (!fn) {
 		err = -ENOMEM;
-- 
2.53.0


