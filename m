Return-Path: <linux-fsdevel+bounces-76897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nQWYCeGvi2mEYgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:23:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706D411FBC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D8A30474DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4793321AA;
	Tue, 10 Feb 2026 22:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BLp4zhya"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74B82C11EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770762197; cv=none; b=sowdmUrXCm3WWIvMMgE7+onn60xNJkCw4m6g5kwIuJ1x3o3OYvypPDNK1ZeV3SIkMGnRkbtSsTdjirB5jQJ+n8Y1yAlQzxkpEpshR8kG08TMnQtI5VtAi/AB3znULtx4pP8yS2ahmEGSfBNzKwSzS0jFu4FNhAdVxRQO4/eS1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770762197; c=relaxed/simple;
	bh=AE271BRYTVD7ZCTaWiwiFieoLQK3AmyXZjd77pQFUFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fL1j27lEx5p82aGZb+OK4fSTVggEWhPazA5t64s3xRKlBZy+juxCKVZzLqNxWbBE4RAcMB905rORTD2okbV9K2d1VGEVCDEmE23b6sj/YQKzxDrxm3UqInNySL2UXbn19Iha93Zs7UoNqr5h9Cxve7HCYPS8d4ou+Mrhy8ceBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BLp4zhya; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50145d27b4cso70566571cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1770762195; x=1771366995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DgrVwEXNYnHYlWUOo4mE7YuEDIS00baasNmXYGvbq4Q=;
        b=BLp4zhyabLys63ECY2qp42cPxG1wWwV/OIehkvmWyQVX8cG0/mNNz5v90iYcVNAbaC
         3zr+069hMXSBZPOEZRYxjgiruBqVvLls3svyTq6OzFwuZ7TXBdnMVxva48S/f4J8Cxnh
         5eGKorAtGH4t/V29slgLSrLN8PWNqWn8rVrtylttc7tt9NlzlcY9eiPqVpxe15eMyJpz
         nbnC7go9J/Ah1Wq9Mmtekk8aWsWEXaTpDOxbtGsRw3HUcETKZDHw26igJ+W5LLzCZiJB
         tvL6a8RUozQtwUU2ic5k0FMoCImWgGDs9qo1B2Ae+jYtadqyvESdyVZ82s/0SQd6atNN
         ctiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770762195; x=1771366995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgrVwEXNYnHYlWUOo4mE7YuEDIS00baasNmXYGvbq4Q=;
        b=FWiSSfIZXWqdoeB10bU5BKgj0ndSkhSA4UdDiXpr9CJjbHOLJ6U/bdWgehiX2C6aei
         mVWDNg9Qhdo8b2DGetVDlkx5MAao8tdtGYJ2A4LTLnRHdptxNzSavgB4HKbxXfRGylm5
         7vZD3xJfp6zX6rFhs7zw0YP5w03R9FFu/NRW8mXcVzrn+QYYSP5xLXyjboavtD5S7doX
         WTjfzZhqlW6pM0x8rzXUkg+cgey5TAbpZn/PDlSrvvBYpBbK+N2GUGJ3QupUPKPMMVci
         Rcit3WTyMd6IjKNJ+08gwP2nMW2jvIrAq8S2LQuUzkjq+ti+k1Zkr7BXpbI8vNQgKBQq
         v5Gg==
X-Gm-Message-State: AOJu0YytLZW4ndBot6gg8q5wVNpT3xdpsDZTYQf58Vmpnged9KNOauIs
	z0h6dmP4ckLw8suxfz36Rqce9FQtCeKaBkaWYkM4Tj1S+25VhvDftXfdbMLbdWF8HzE=
X-Gm-Gg: AZuq6aJv4yX8mnNvMGnPchiuJ70ldIeShmCR1Gpo+cGYeyICDZy9rJ6ZvKR7b6f+uM6
	stVH4twruhxSvpGwoxWE+d/gvlqRO5biH5PGGb4JxIr/QD97mPBIDui9OeQPuoIzUsP36NuwPAp
	Gkg+zrAQXiZWSBNqgvZUgAI2mUYKDZXdO93vpW7JKneFTDK9uBeZHS7lIkxEznC8snnSXRSRDLO
	ew0PGpBakXKCTKZsKqIFDLbAJN3+Voy/V5RWfuNjf2DK4+lp6QY4XnOhtCBLz3nCA8o7jAY6Op4
	isz9pv0X0796/Dntcgh8peHKA93koNHz2gbDhpId014tRyzWrUrIDMES6qc3PgJ1wZe7V33mQ7m
	3y/M0f9SAdhUcYvtR7bpUOo62rik4Fxmdh9ck9U0qsl3WuU7rVXuh+s8H0L5a3yC01vyus2+yfg
	uEHc4uu0m6qe/KzKEgucHaym93rr17LQSSnjSljH/UV56asd56uo3GScFdnWOPMIp98nt3dBFz0
	NVF
X-Received: by 2002:a05:622a:18a6:b0:506:2041:13d6 with SMTP id d75a77b69052e-506831f04d6mr902741cf.50.1770762195508;
        Tue, 10 Feb 2026 14:23:15 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682edead7sm646801cf.7.2026.02.10.14.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 14:23:14 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: hirofumi@mail.parknet.co.jp
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/2] fat: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
Date: Tue, 10 Feb 2026 17:23:08 -0500
Message-ID: <20260210222310.357755-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76897-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim]
X-Rspamd-Queue-Id: 706D411FBC7
X-Rspamd-Action: no action

Add support for reading / writing to the volume label of a FAT filesystem
via the FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Volume label changes are persisted in the volume label dentry in the root
directory as well as the bios parameter block.

Some notes about possile deficiencies with this patch:
1. If there is no current volume label directory entry present, one is not
created.
2. Changes to the volume label are not checked for validity against the
current codepage.

Ethan Ferguson (2):
  fat: Add FS_IOC_GETFSLABEL ioctl
  fat: Add FS_IOC_SETFSLABEL ioctl

 fs/fat/dir.c   | 22 ++++++++++++++++++++++
 fs/fat/fat.h   |  2 ++
 fs/fat/file.c  | 28 ++++++++++++++++++++++++++++
 fs/fat/inode.c | 26 ++++++++++++++++++++++++--
 4 files changed, 76 insertions(+), 2 deletions(-)


base-commit: 9f2693489ef8558240d9e80bfad103650daed0af
-- 
2.53.0


