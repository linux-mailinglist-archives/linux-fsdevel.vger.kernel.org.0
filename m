Return-Path: <linux-fsdevel+bounces-75846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PHuOjAwe2n2CAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:02:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C0AE542
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 11:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6658530292FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934AE3803C1;
	Thu, 29 Jan 2026 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0SQHdJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971EC37C0E5
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680937; cv=none; b=tji9S6G9joA5AovILUSI8tmTNSBMbPwGjV+DuC2fgG7QPPzsjQs9HizsN970KkKO5cOVaGPIJ57vOdSladdJoUskcuPOkXYe6W4pYAqRWueMY5ZsePsNqAlLSnnEz9rf2YQQbhOL3vrYzrfXzruycSUBM9SnXSXqz+5J6vWZbmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680937; c=relaxed/simple;
	bh=/R6zPehcG8kSCTSccnaxmWXL+iN0Hg7FAzOIobDMk+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NhZJFFCYQ0vZWD54t7+UkVphcs+UNycRu3/tL//5jOuHU8HeRYLT8KgUloh/L1uhLb45wgipi5m17mJ2D8OvfxB+b3JL4SILGK1ScjTSxwwYmYgzC0eHI1NzQuq84PQET6kEhqCe3Z9LN3dn9+9EE0CR5h6cO1sQOcbv6C+FCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0SQHdJM; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso1488984a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jan 2026 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769680934; x=1770285734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TGi9TKff2FQIiNpZEU1Gy6dGbKGBKPIZDz2TT0oN7OQ=;
        b=P0SQHdJMFqo8YGB5MqQHbGdjFLLQZ5nrSsoyJi/fEZgm2RfLW1JmNqQXMfC7bzpi2q
         J1UdAp/KCZ3ZsSXk0ePmpADURqrRoB84xy+UmFDd3GQgUU5F5+MpGT2sBxgwVrgbD0qN
         gcBHDH+acj363PBR3XGHndoGsRAc7V45MvXptdYPkBG9xi5eoRxeh13XZH3wD1nBNu/b
         kGPrV3M/DFC2bjlND6LTbjYLL6y5X1443OVRR2ohdKiHGP1vWhIFVQ+PqfwoqU0K5aJA
         tp+C31QQmURJ0qms+Cka+4K/zoltw9OnzPDKC2wg8xsjTQxA3Fha9sJhsXxTB7HQ5bMe
         a39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769680934; x=1770285734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TGi9TKff2FQIiNpZEU1Gy6dGbKGBKPIZDz2TT0oN7OQ=;
        b=cb4XIU8hZdcwDuZKaZzj3OOw3hZ4QXKGpb6Ilg254RwSEyD95UD5whVxiLro+fMCDr
         qZXSOKlJqXqk2r782vQM613r9mkjTY09VaqrrBYxxclCfp/ZopcdUbeES+PXuy5aEOOp
         QC0o9aN70m3pfSqmpYDyTeDcpRQ9lrtwD5IeSsmmWSGmKANyQXaCXUA5nFvGE/x7vn/K
         5NdXTmuwmsOWQi3Im6eDA+h+H03JMACJ8vRMUlHgvDP3gSa+GeLwic6NJKKeJdqMi/eZ
         s0DJg4/pOWnQ2IUFgr74gWb8IBUyG7HYxeM33LPeD3t3YM1MdKuO0wF/fotQZp5B7y6f
         s4/w==
X-Forwarded-Encrypted: i=1; AJvYcCWW8NZUNE24pXcFnTVDlFipe9OZkXBIHIvj2Aed3B69M499ki8OoXymsgTuCl6FDE5/B3LfwHLpKsvzJGV5@vger.kernel.org
X-Gm-Message-State: AOJu0YxJImup7qsyBH5jjLp+iH6u8MOMxa1fqCvw36DNBSREU3poV5X3
	WzSAwFPXoVNcZwIAfLsZVi+4VdogT21EoHpVI4SVToKbgvEgteSv2fwQ
X-Gm-Gg: AZuq6aK+AHHBs8LbVIH8nZqQseO9RKC0045YjIQM8KFfD3QTN8nH24ru+VYkWrpmXXy
	jmBWrgmjZVDT0ZPTS+OO5mBnHuSP8XgK6YJ/++QKdiuK89wQ3koUCKN4Wi2BkibnNPZY/2ezfYg
	8wRa2jymtoP23r1yiWuVIrWGrrRcPgnCOwg4iO55nc/yWm7hdFFhZnsRsr4jXJ3x7hlyeBF81tD
	36KEKdaeKktLw97QVvo4LaqpE8UIDTuS7cmvIA7iaCeFOZEpyg+D15pHA+/zm0ns1h9zzyiBpDS
	kdJgOoMAgz9fSoa5BfimyWa7ZjQj/pess/Sd5Fc8bUZrBxsqvKc/SFlKE98a1oA7UKS5Tak2IQw
	t82NPWfc9Phc7I5h4hRwFVT/T8OBb18CkCwixHIiIFALDea/MpDZpcz5rrsS0t0SLcXCU4/MpRC
	1kZrqqoTzRPo2umA4JoIP2NoXZlOx1e1a6CtwNtOCfHoGgbdu+RKzHu3lRfOdKQRRyamzxI5au4
	5vT/5CKHw+mkaUiy4nSwF86v+g=
X-Received: by 2002:a17:907:c1f:b0:b87:2536:fd9a with SMTP id a640c23a62f3a-b8dab3d22a9mr557819566b.59.1769680933548;
        Thu, 29 Jan 2026 02:02:13 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-983a-6411-8910-8120.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:983a:6411:8910:8120])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeffed15sm237896766b.31.2026.01.29.02.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:02:12 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Neil Brown <neil@brown.name>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 0/2] nfsd and special kernel filesystems
Date: Thu, 29 Jan 2026 11:02:10 +0100
Message-ID: <20260129100212.49727-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-75846-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 676C0AE542
X-Rspamd-Action: no action

Christian,

This v4 addresses Chuck and Jeff's review on v3.

The first doc patch is applicable to the doc update in vfs-7.0.misc.
The 2nd fix patch is independent of the doc changes in vfs-7.0.misc,
so it should be easier to backport.

Thanks,
Amir.

Changes since v3:
- Fix typo and doc comments from Chunk
- Add RVB

Changes since v2:
- Rebase over vfs-7.0.misc
- Split to doc/fix patches
- Remove RVBs

Amir Goldstein (2):
  exportfs: clarify the documentation of open()/permission() expotrfs
    ops
  nfsd: do not allow exporting of special kernel filesystems

 fs/nfsd/export.c         |  8 +++++---
 include/linux/exportfs.h | 21 +++++++++++++++++++--
 2 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.52.0


