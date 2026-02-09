Return-Path: <linux-fsdevel+bounces-76713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJZgJZn9iWluFQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 16:30:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2CF111EC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 307A5304E0DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF937F108;
	Mon,  9 Feb 2026 15:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Z9HS0wFA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAFA37F0E4;
	Mon,  9 Feb 2026 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770650691; cv=none; b=DF4PBbgmJOcy1MsbeB5EcbVUccHd0kbCNNvVKLWhaLgCQhNpR0QTHtHAzLWILqt7XefqLH5ATZk8bjgfm+mUDOrUd08UQqlhR9TKFNZ3ZLFqFJBMHYLxP20UAqNoCXvFVcREdFaphWRnvAfgLkaBZ1vNLWG+WTOUOVlex4dA1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770650691; c=relaxed/simple;
	bh=FFXCc43I3tk/mxj/aCNjnGC7RY/QzOM1guMiQf3LESk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuvmSvT63wg9xXh0n0DJMPWERanmcyMz3ZJLfCefj7Yivl+BmWg6yYblGZOYCdSY5iQrzjyfB5GBIOlzV4zodE8+rs+wp1t3chL8lR47OpmQtwUBHJUqjP2ORMfo3WSm7PqeGxrkQwyut9ikFKo7Afy5x39Z0tfPX2qZDiODaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Z9HS0wFA; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BB239241;
	Mon,  9 Feb 2026 15:22:42 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=Z9HS0wFA;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B28442187;
	Mon,  9 Feb 2026 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1770650689;
	bh=CYd5rcNnOaKSh23TI/e5OE/xbQ5AsdzUoPUlc04ix/w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Z9HS0wFAFZ5byhJiHI/hGpRC4cxccP3znXOIYk90DbpxyqUjIXkfLI4e51fB9e7EF
	 5zL+rPFI3YEc65pMSNQMDYoJAlA1NOIL8XIECn+84PmKt0ANJYTlYzcHA2ttPoQvSE
	 ui7ImzYVNinQdVwQReSFlMqT1gcLPXqmmSO/oI18=
Received: from localhost.localdomain (172.30.20.159) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 9 Feb 2026 18:24:48 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, kernel test
 robot <lkp@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] fs/ntfs3: avoid calling run_get_entry() when run == NULL in ntfs_read_run_nb_ra()
Date: Mon, 9 Feb 2026 16:24:40 +0100
Message-ID: <20260209152440.9832-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20210824075819.GA13628@kili>
References: <20210824075819.GA13628@kili>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76713-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,paragon-software.com:mid,paragon-software.com:dkim,paragon-software.com:email]
X-Rspamd-Queue-Id: 0D2CF111EC9
X-Rspamd-Action: no action

When ntfs_read_run_nb_ra() is invoked with run == NULL the code later
assumes run is valid and may call run_get_entry(NULL, ...), and also
uses clen/idx without initializing them. Smatch reported uninitialized
variable warnings and this can lead to undefined behaviour. This patch
fixes it.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512230646.v5hrYXL0-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/fsntfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index e9c39c62aea4..2ef500f1a9fa 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1256,6 +1256,12 @@ int ntfs_read_run_nb_ra(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 
 		} while (len32);
 
+		if (!run) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		/* Get next fragment to read. */
 		vcn_next = vcn + clen;
 		if (!run_get_entry(run, ++idx, &vcn, &lcn, &clen) ||
 		    vcn != vcn_next) {
-- 
2.43.0


