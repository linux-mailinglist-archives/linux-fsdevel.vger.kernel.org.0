Return-Path: <linux-fsdevel+bounces-75016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEz3LwwDcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:59:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B8659F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FE716C4FF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CE63B9607;
	Thu, 22 Jan 2026 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHMdEmYH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DF840FDAC
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078950; cv=none; b=GT8jGkYSS304leI0G49hdRIM5XQgC6RpGCihSZZcatAzLMHP8TBHf7iwC9FZGEJQgYe8Ugy+AV2YfniSUByfL3SZu44wiMvYQbtGI6D33C1AbXHHnPaP47LRT8KX/NqSpaqTWl7oj6TEwmtkns6Irk0/ubzjk0qeLHStk1dmUPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078950; c=relaxed/simple;
	bh=LWskL1A3nznQ+ge8FZCbhAjaOytwB6AgbR+QRYw1foQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZWQEwGMqHlTIKpzWIb6RDNtqjlHd8p455WNpk/zNEFa9NUPWJ5jjokYsMvb/SIdN7LSrOfSlDdTJIBADYBYr4E83LniRwczty4ShhJYqAXvpjOlKL3S4/WSZIcHdpj+eMm9BEzELTKMVIATXTrWJ+IAISIqW8LISulB/ustIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHMdEmYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13FBC2BC87;
	Thu, 22 Jan 2026 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078950;
	bh=LWskL1A3nznQ+ge8FZCbhAjaOytwB6AgbR+QRYw1foQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BHMdEmYHgHniqbgb4Up/JpmP/kgrd34eXY1GGti7Z9Ko5r4fCGXiVesipYlqdjKes
	 fa7oE8hwSpu/EgExEQYSiOnBu88Ep/36ZvWW6R7Vm1taUMFjgw+NISJeonfWURKujq
	 fP59NsxIaj2n49FTrM6q6OSfFEzotdhB4uGrzKybNVFb8FWrTXYlkYWzdjdMy68OhX
	 +NXP67vVeFv9MVvJ/mZxV5JE7OWP9mh7ByWq1uhYaf2JTfTBUcXY8QkfYA7JnloN50
	 YnAheP0B4OFMtejEJPALlUDb3LEhPSFaBAaLRfpbhlkJqeLOMFPryyJEr3R+kchuqq
	 b8FN8mMMzacRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Jan 2026 11:48:50 +0100
Subject: [PATCH 5/7] selftests/statmount: add statmount_alloc() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-work-fsmount-namespace-v1-5-5ef0a886e646@kernel.org>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
In-Reply-To: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LWskL1A3nznQ+ge8FZCbhAjaOytwB6AgbR+QRYw1foQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMczUOnjPXChGf67k4+YUr6r8C4zpmVtN5MWUv39PS
 Pecdce3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ7DzMyvDPI1gk4+N734zy+
 tHWTY3av+1Cy+EPeHnaNDwl/iqLfzWP4p73c6aVM5U3mm3Oiul/cL65p4zZZ0OaTtKPFOnDt8fp
 3fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,toxicpanda.com,cyphar.com];
	TAGGED_FROM(0.00)[bounces-75016-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 894B8659F5
X-Rspamd-Action: no action

Add a helper to allocate a statmount buffer and call statmount(). This
helper will be shared by multiple test suites that need to query mount
information via statmount().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/statmount/statmount.h    | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
index e1cba4bfd8d9..4ef23e54212c 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount.h
+++ b/tools/testing/selftests/filesystems/statmount/statmount.h
@@ -3,10 +3,14 @@
 #ifndef __STATMOUNT_H
 #define __STATMOUNT_H
 
+#include <errno.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <linux/mount.h>
 #include <asm/unistd.h>
 
+#define STATMOUNT_BUFSIZE (1 << 15)
+
 #ifndef __NR_statmount
 	#if defined __alpha__
 		#define __NR_statmount 567
@@ -84,4 +88,27 @@ static inline ssize_t listmount(uint64_t mnt_id, uint64_t mnt_ns_id,
 	return syscall(__NR_listmount, &req, list, num, flags);
 }
 
+static inline struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask)
+{
+	struct statmount *buf;
+	size_t bufsize = STATMOUNT_BUFSIZE;
+	int ret;
+
+	for (;;) {
+		buf = malloc(bufsize);
+		if (!buf)
+			return NULL;
+
+		ret = statmount(mnt_id, mnt_ns_id, 0, mask, buf, bufsize, 0);
+		if (ret == 0)
+			return buf;
+
+		free(buf);
+		if (errno != EOVERFLOW)
+			return NULL;
+
+		bufsize <<= 1;
+	}
+}
+
 #endif /* __STATMOUNT_H */

-- 
2.47.3


