Return-Path: <linux-fsdevel+bounces-37631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D69F4C79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 14:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 642CE170A99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 13:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F41F4715;
	Tue, 17 Dec 2024 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="G8yu90Zz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F8416ABC6;
	Tue, 17 Dec 2024 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442270; cv=none; b=uEcKJNJ11UfGYBuBu/5EwRo/012pSBe30iUPW7Txth4GZ2VuGj8owX55RKNrFWYIzZAaAOGBraWC8CzidyR17l2Rusk6kJ7ZMjs93YD8clYTN+9kiNw1SHYUCoXcLN1z5CCq63boVuBd0TJFw9ofufVzIMNbZfa0yY6axHdnqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442270; c=relaxed/simple;
	bh=e6SbwgJYSQ9CJ0SBN51OGQlynKS9oYHjF7MzTzuVEzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJaWNtE0CTjVGyZPTMviFK/zkeIWngKuzHna3plV3PkGQ79CBAhoeQ0cSHUnI+wtx0XNRsjlsHMr/8nJORgcHRFTGAL9ADSAfcY4fTJtoKYq/CGw6QG4wqlcIf/zd6ny4zkzQAkfwscyjEp0N4mc9gyOkiPIF64mm23eBruQI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=G8yu90Zz; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00DE7C000C;
	Tue, 17 Dec 2024 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1734442266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWxfRKScvsoqp1CSGAFmke7D2A2VQHOyiGrAXtvWMPA=;
	b=G8yu90Zzzg1+RM4aSogL7TPjyQH34mA6/C7U0BPpWYduOKGCDpjvrm0XIiAc6StXiRgj/c
	dhwfWw67iiaZW17lHmWSJNMQ7/3RRuNiu+aqP9CCCL6DjIHwE8C+rVpfizQHarGR8gyT6h
	zEu4Tx1KeUhxU1OMquWZ2uJz47qZl4JalPUo6n0Lf/Hb9qHfDevZtMQ3eMkbhzL9wZfMzt
	FjMRkXYcYoJbk8i5kVnySwQavJv/Lr4mtO2vEnsyNTbkowbGdiacDbqr8O5+Tal5TuFaLt
	lXykkmn06YyIHAVKtGe7Ltjf4yHPGGqJ7NJ7Kr5LjD5eREpJIDY+4T7I8GlZ3A==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>,
	Lin Feng <linf@wangsu.com>,
	"Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH v3 1/2] coredump: Fixes core_pipe_limit sysctl proc_handler
Date: Tue, 17 Dec 2024 14:29:06 +0100
Message-ID: <20241217132908.38096-2-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
References: <20241217132908.38096-1-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

proc_dointvec converts a string to a vector of signed int, which is
stored in the unsigned int .data core_pipe_limit.
It was thus authorized to write a negative value to core_pipe_limit
sysctl which once stored in core_pipe_limit, leads to the signed int
dump_count check against core_pipe_limit never be true. The same can be
achieved with core_pipe_limit set to INT_MAX.

Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
hypothetically allow a user to create very high load on the system by
running processes that produces a coredump in case the core_pattern
sysctl is configured to pipe core files to user space helper.
Memory or PID exhaustion should happen before but it anyway breaks the
core_pipe_limit semantic.

This commit fixes this by changing core_pipe_limit sysctl's proc_handler
to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
SYSCTL_INT_MAX.

Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 fs/coredump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7f12ff6ad1d3e..c3a74dd194e69 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1024,7 +1024,9 @@ static struct ctl_table coredump_sysctls[] = {
 		.data		= &core_pipe_limit,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname       = "core_file_note_size_limit",
-- 
2.47.1


