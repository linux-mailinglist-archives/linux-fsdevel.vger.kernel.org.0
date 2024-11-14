Return-Path: <linux-fsdevel+bounces-34826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FBB9C8FBB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A5A289345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8E218C022;
	Thu, 14 Nov 2024 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="dNtHYrqO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6AF13BADF;
	Thu, 14 Nov 2024 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601646; cv=none; b=imkm+tp7JWiPSBn0d8cGPm0mNY4uT5P6kGVQcQHvWJkYNK5YOELUmvjROMH4N1aCnKtDMk1Y/jHFOu2oSZ1EoYC/OLPj/7qjznTWOYOSRFHtD/32eK++FBw2tHf57nDCyLafYCV7Zo/nKceDs5OMdIdPj4A3LTajh9pOcA3SZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601646; c=relaxed/simple;
	bh=zTooz16rY3AfF/eTpeq17JpgvY9acOw5qHh3CbP/p3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unpKtqI/zDCtR3t4dg+yavjhys/+N7t6Cf2aQqW6hlJnoluv/8gbW371xvJK02otKy2zUYax5lhYlJUy466zGowfbl3RiZkcdLQWi18NC9YlemHKd4eqzS4Ub+g+ZM3IEXfKWL+cFtXMjwLZOehM3k+nkPIOFTi99QPEs662NpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=dNtHYrqO; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3563A1C0003;
	Thu, 14 Nov 2024 16:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731601641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4pkqaS9pZOOkHA59eOasRPM/zB+ZaOpCZ3WyTxPANo=;
	b=dNtHYrqOnStkonMLIS11J9mLWRRZQX/Kkgd0JktCdBylxRqiw1p0b/ploudVPFrhgpCHxJ
	PBi8tj0MtSZ37H/X6UbgMNGxT+mcavG+lMffwzOjIMtsQ0lKkvluUPUthHgRAYXMHB1nKp
	p9qzMJMtI99h3eApzkS3fkZ9MGYnwUFYRt3d/V2lMfiJOWJbVhy9Sb71KrvqifI4y9iiZD
	zreuossdPqB0bziAOJ7vNPoH0m3OzUVJ4bYuAyNmYDBn8dCkBkZhT743BgohSvz4L/KRRQ
	FafmgvVaR4GPRTtYbCHn543NEBXPpxsCxwtvppRAO28KDUHyft/DpxC/u91lxQ==
From: nicolas.bouchinet@clip-os.org
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: nicolas.bouchinet@clip-os.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
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
Subject: [PATCH v2 1/3] coredump: Fixes core_pipe_limit sysctl proc_handler
Date: Thu, 14 Nov 2024 17:25:50 +0100
Message-ID: <20241114162638.57392-2-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
References: <20241114162638.57392-1-nicolas.bouchinet@clip-os.org>
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
core_pipe_limit semantic

This commit fixes this by changing core_pipe_limit sysctl's proc_handler
to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
SYSCTL_INT_MAX.

Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
Changes since v1:
https://lore.kernel.org/all/20241112131357.49582-2-nicolas.bouchinet@clip-os.org/

* Remove test condition as suggested by Lin Feng.
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
2.47.0


