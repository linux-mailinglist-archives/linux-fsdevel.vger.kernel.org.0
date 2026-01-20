Return-Path: <linux-fsdevel+bounces-74748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDIaD0INcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:18:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEF04DAB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 729E8963641
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704673D4118;
	Tue, 20 Jan 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+kgav7W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEADF3A900D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949471; cv=none; b=gT9apMiJbeCBZHlQaz0L85jdeLy8WuDOeOjFQUq9qp9P+ZIvPRvqq5NeJIRpO2V9AlmKncdHcfZ5lbrkM+4cu0dseneF6KdC9k8YG7kvR+E4OMmjbMjWaB5r8VW2KjduhCISpiTUeGZkcsBs7WFwcmJWQgfghHqCfZNuEtq4juA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949471; c=relaxed/simple;
	bh=7O+7tv5l3ZvKlLLpybjewB46qXilyGMu1z1v9h6MOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ssfNuRJ18dZhvgYlklW9rM6Z7eFDs0Upft96Yv6KE1PvH2ND0ra7CKk4nB6JtKcNuAK22fw39ueqeaH5fxIpJrug1OtPQ+y28oG4yAj+iWYp216rueR01kpofR2Rw1Jw4kCDmbTKdofniliFxqiIBVcnN60WbwaCv0ZX2Oc1xQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+kgav7W; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a7a23f5915so674795ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768949469; x=1769554269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/Dd0xh1gfWjuvre+xilVtLvWEGGd/sbtJJWjhlTMHY=;
        b=J+kgav7WTlB7XEIr8bX7RjECppNWnFmf8ErcmOZFH1Zz1O6AP/zYt8+w1tqdqrHdqH
         SoUrvzlzAMlhnz6UoCD6JO7s9+DnUdwTsqO2m3Cz8eDq6aJ9Y7L5bM16wsIuKGqnr7bU
         r3nUlvI8wgCBmtju25PzFEsp1y6actMNgUvnyy9xAs/p4XQ4DRs7g2BrkDGqbB7DbmLx
         413Gjm+F60GPyGw4YVOLXBpz5ZPDsG4EN3jJ7xr93liDLhlGADAHT1jwGVYWdLA4bOhl
         UFhy/Fv8DnCemVvJOoUpJEpsHPU53lfbXNIPi27toRkG77WwgTWUnjtbeVjZOPu2GmW1
         ZyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949469; x=1769554269;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/Dd0xh1gfWjuvre+xilVtLvWEGGd/sbtJJWjhlTMHY=;
        b=LAYxvvT6TFrSuWMEDL0dKBAN/7UlhxiW3yxbPhDzyUCbHKAzPvC4uk2jrCDLotTsFb
         81riVCarx9sDSOm1owIV2xyB4p1end4uDWErzkne42BcDhw0wDQEex1LrgC/q0rcnXz5
         +gGlrdYwdZzh0SFuQxZhXRzj3CKtlY/oCts8rP6Y13KmT6lvRtxm0Lb0jN9AYz0UCHBF
         oQEQWqpR8XeBuA5H8c/9FzYXvsZdWPYZdKERYb5xM0jrFLAKH4QsMsfYm5nkCK1yl+V8
         XJj4tn1IxIx4EFD+VXVNb5ON7NRLKhGF8pyDlW0S4ru38KVm42dkcdRi+PEnLBQB1+3y
         t35w==
X-Forwarded-Encrypted: i=1; AJvYcCWs/9MpjWZPcK+vwcYoqD+txZOjNodNTNXpFIDEloPJ1WRw0g2orYYwH2W4j1/CRm/IdcKyorreLjgEc3xn@vger.kernel.org
X-Gm-Message-State: AOJu0YyBhJAUqX1HiWrQYxEoCgkuxsuQKI2+OPz9ek1RR5cRxySwPNbU
	msn5ZX0fgVu4ddAVrk15J36MBOgX/+ULnU1e5rX+d/x/TVVsQSZOBqQh
X-Gm-Gg: AZuq6aIM5Yxfvk+VqcKuaMZ7sguhg6qRowO+qHgG6dsdOb3Gl1CucXJoTZOLoGyt1f4
	WCIRnqcUdws4gBH01nm7W5epVpbyOIOJDvUkf0uKtIgWovjY3c/+kG/kHjsQ1b59zp8zQ+PuAUF
	pp/Nq6nOKfjZzDadu/mf3PfRbtjh0zK95G3tzrF+ux2E4CHtCQZY/O4JbF8Uollki8melgmN5zz
	WHaRLEwFpJjOYxWL3jIWOZwXpNwth+kdl8MDuKhpFzEDwV1yY4IxQadu7roAv385/1xCDoxwxHE
	z38HvoNmJzNgUQRKbaAIff9y2bd98IzSCe0zeI+IvGfPBFVyZn6W6yvtMDTyiwFgpGatWSdV0mi
	qHqOa/heu006InJOCVE7YlOhdWTX87Nmca0sRZRh+hni10v9zOw3jVvO2CilyjqIDIEyJoa+NQU
	C1jwFaDI75s6ngeuY=
X-Received: by 2002:a17:902:f54b:b0:29d:584e:6349 with SMTP id d9443c01a7336-2a717533786mr140455895ad.13.1768949469007;
        Tue, 20 Jan 2026 14:51:09 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbebasm135739525ad.55.2026.01.20.14.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:51:08 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: jefflexu@linux.alibaba.com,
	luochunsheng@ustc.edu,
	djwong@kernel.org,
	horst@birthelmer.de,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] fuse: clean up offset and page count calculations
Date: Tue, 20 Jan 2026 14:44:45 -0800
Message-ID: <20260120224449.1847176-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74748-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CCEF04DAB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset aims to simplify the folio parsing logic in fuse_notify_store()
and fuse_retrieve() and use standard kernel helper macros for common
calculations:
 * offset_in_folio() for large folio offset calculations
 * DIV_ROUND_UP() for page count calculations
 * offset_in_page() for page offset calculations

The 1st patch (outarg offset and size validation) is needed for the 2nd patch
(simplify logic in fuse_notify_store()/fuse_retrieve()) in order to use
"loff_t pos" for file position tracking.

No functional changes intended.

This patchset is on top of Jingbo's patch in [1].

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260115023607.77349-1-jefflexu@linux.alibaba.com/

Changelog
---------
v1: https://lore.kernel.org/linux-fsdevel/20260116235606.2205801-1-joannelkoong@gmail.com/
v1 -> v2:
* Replace offset_in_folio() patch with patch that restructures
  fuse_notify_store() and fuse_retrieve() logic (Jingbo)
* Add outarg validation patch (patch 1)

Joanne Koong (4):
  fuse: validate outarg offset and size in notify store/retrieve
  fuse: simplify logic in fuse_notify_store() and fuse_retrieve()
  fuse: use DIV_ROUND_UP() for page count calculations
  fuse: use offset_in_page() for page offset calculations

 fs/fuse/dev.c     | 52 +++++++++++++++++++++++------------------------
 fs/fuse/file.c    |  2 +-
 fs/fuse/readdir.c |  8 ++++----
 3 files changed, 30 insertions(+), 32 deletions(-)

-- 
2.47.3


