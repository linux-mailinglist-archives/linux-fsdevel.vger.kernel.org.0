Return-Path: <linux-fsdevel+bounces-77655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M+cCidclmkdeQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:41:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBA715B36C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 01:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B27C301F16D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 00:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CBA21FF2E;
	Thu, 19 Feb 2026 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2N2GMLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620E35977
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 00:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771461665; cv=none; b=RFkCjM6SeeO6rAQdBhJxqDvGBuk1NP4nSSnNvaEWHyyZ+BSE5AaYzq3mVjUsfPDAWNPm0+7GRMsSGNyzfiy+Hoanay9jdNGn0zvF10emgIrZjnt0aPEkZ6F1oCCXryZpM2cE9d5t34BQobjNE9atEH2NmcFAl5Q3Iri9OYANDlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771461665; c=relaxed/simple;
	bh=sxQpAIX4AbQlLOLwcvZ1w2qKB01qBROhugZS/yUUQ+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqJlTLkLz4O06cXP55jysxHDr+EFa/0QF/coBjPpqZJN/SRtJD/OzH1LBds1RJMs4siExhOG3xA/VY6F46OERYRrKjPGgVskCcEIcXtqsN1rWn1t/ajDId016cPbtGR019slXQZ4hCua5QyhqgDAtPEa+KuNAQBunwmX5rF37wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2N2GMLn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824a3ba5222so175969b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 16:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771461664; x=1772066464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fueMwuOXfHo4uF8ac/YNOqXibnj5Vce+f7zMVZ9C+4=;
        b=O2N2GMLnw08ABGf2PHyI+FF1VdVL88k5akkYc7FaGs/sW9Vqs8bxUIMRg8un1KN5RO
         o/DDqir9eyOq5+YH88qrFdXXgp6zO4YfcjB4x67aYMrZWKn+BojQwWULbX6El4JYF/HU
         8YdXMPswlInNqBx4u+Okcj87Hkpcbwy8E1oaRHEzyiTnogm1ZKc2jWGcv9/kLJF349us
         Lf4XgaayHW3rwXK30aH00/MPGebgTmMgceaDEYLBAJp0KtWhj2XLBJqmI4bwwOQZbLdL
         ogtoan/djF1QSw2oSqqR60XEOx/95b8YtyRgatYCabL4Zs0JP1VRsib5F5zUzdNNUlVo
         YXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771461664; x=1772066464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fueMwuOXfHo4uF8ac/YNOqXibnj5Vce+f7zMVZ9C+4=;
        b=ruv76FdPVjFEMwsS4BByfPRjsnq52x1Rrl1g6z2wy4KBV+Vw33Mtcjq0ogXp9OjYZL
         hjihdtdbAlW82vjdxvjf73AOf5ff3cqvGXD3ZRr11bh3yx+S62hxu9nTKEm/q25yw/cQ
         eb7ZFvv/ns1rGXn6RlpW+AnJTMpRdN2knj9WguqU0afUloAeA+6cKLmk2ItHlOBQ6/5w
         fIcpr2mLZ16ylzFx/V8c6ePRw82Ul34jDC1pztgHvgfpSVjssL3EaqfXojLu9F/9uy0g
         G9y2o05O24R02uu0Tkx4ttKksYfsxnNDgFMNonxL9saeshjYmw6mu/6whvPZ62XB+DRp
         V7CA==
X-Forwarded-Encrypted: i=1; AJvYcCUXN1fnhbRuOQvViu928n2nzSIUh66VbQtlbI5p/fSlyk0yve5yBt0b8iYD5RYDq+yC5UWVwheBgdtqloXi@vger.kernel.org
X-Gm-Message-State: AOJu0YyhEokEV4roXo5dvM2gsDOz3XaMk54VUF9P7hBIV53H96+DuOiw
	5a3BpI8dqoNYdnTXHSR2GYwkJ09pSC7Ow4X7qg2euJqerZHC4ewvGo5Q
X-Gm-Gg: AZuq6aL8ME+4xyXW/6w84YwSYBuJXTGnAxSOOS3vOXQJKegj5VkLFl277ZQuVP7nzEi
	GduA45vI/YwxCeMveiaoFYlGI2Tz+zRm6H2AwYpe/SETK4JroflnupUjp754Dp1fmPrBpZ56Wz2
	YOVEvCxi3qcc3AjjkimAW2Z81LjzO/V/dXV+O58lvjUbqWnuirv0X7zVR5NaahNftfOOWm23qqW
	gwOHsA61KoX6xzQ5RCNfge889uHiEqbKj42vTQzjJ3fmQvs04fCmywn2chHR0L4YRZ+ApX3zaUI
	LaV5Sh3/5Dss6rwLALQ1mHDFXARUurkjwCewJFRICR2ebbDHdmmYUZXeDdb26leeoiFvibt4kYN
	H1Imo2ozSMDcT8dK06L3Rqad7V/+6CfB7saxQF/vFNOU4RUFWMm2232oLnOBj9fP6JKplZpPrJS
	k3k0ReklaBm7a07E77bmcpdtUF2k4Z
X-Received: by 2002:a17:90b:57e5:b0:356:7917:23c with SMTP id 98e67ed59e1d1-35844fc002cmr13711003a91.27.1771461664214;
        Wed, 18 Feb 2026 16:41:04 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f8cc13sm26542111a91.14.2026.02.18.16.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 16:41:03 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: willy@infradead.org,
	wegao@suse.com,
	sashal@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 0/1] iomap: don't mark folio uptodate if read IO has bytes pending
Date: Wed, 18 Feb 2026 16:39:10 -0800
Message-ID: <20260219003911.344478-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77655-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AFBA715B36C
X-Rspamd-Action: no action

This is a fix for this scenario:

->read_folio() gets called on a folio size that is 16k while the file is 4k:
  a) ifs->read_bytes_pending gets initialized to 16k
  b) ->read_folio_range() is called for the 4k read
  c) the 4k read succeeds, ifs->read_bytes_pending is now 12k and the
0 to 4k range is marked uptodate
  d) the post-eof blocks are zeroed and marked uptodate in the call to
iomap_set_range_uptodate()
  e) iomap_set_range_uptodate() sees all the ranges are marked
uptodate and it marks the folio uptodate
  f) iomap_read_end() gets called to subtract the 12k from
ifs->read_bytes_pending. it too sees all the ranges are marked
uptodate and marks the folio uptodate using XOR
  g) the XOR call clears the uptodate flag on the folio

The same situation can occur if the last range read for the folio is done as an
inline read and all the previous ranges have already completed by the time the
inline read completes.

For more context, the full discussion can be found in [1]. There was a
discussion about alternative approaches in that thread, but they had more
complications.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1Z9za5w4FoJqTGx50zR2haHHaoot1KJViQyEHJQq4=34w@mail.gmail.com/#t

Joanne Koong (1):
  iomap: don't mark folio uptodate if read IO has bytes pending

 fs/iomap/buffered-io.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.47.3


