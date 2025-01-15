Return-Path: <linux-fsdevel+bounces-39294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C030BA124A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6255F3A685D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BEC242260;
	Wed, 15 Jan 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="NLM66VuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90C2419FB;
	Wed, 15 Jan 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947351; cv=none; b=L7QmPqGYSkGUXTT9atZTMpxftAtKn2PUZmP/W0mWPJPboBRGwAnytZyGBUD2qu63bvUrsmvDK1GLCf+3yN68No7T4dqCbQHR2bHRTgYxANxN8xiuH9FKFDmj87PEjBb/jeWYBqdctq9Lsy5YhCtgtT7e0ggmnMxD4QL7qjxcyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947351; c=relaxed/simple;
	bh=8FT+T8aU3TftfixxJmtraKKBFWBo6FJdmCrAxVUyt3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQW1W4K6VqY9uMjFJ2AHdPXDCoHxqK0aO6wTDjqJzN9UOM294p3pa/RMNZAM4w7SZFZLS+0DlHWE8hJMOArydXSF9aF0eNqE4U4HFan1r3P08A+2pZaMxWIMCxqz+6vkt38bQP8c5Oyp/XywKSTboohq13tXR95+IxKNdH3ygWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=NLM66VuF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7A4311C0004;
	Wed, 15 Jan 2025 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1736947341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeXdXRsq+WRoF78VssCvRBo8D6FOZGZKSuRnY8YcCBM=;
	b=NLM66VuFwyJTiqzfxgqPbIxfTG7LNO3iYJ/vH4P7GBVDVnDOw5Ff+BCGBwZ64NwAM2Uhjr
	osJjHsU0u/R01n9/RlglLZmUuGvyxqQHim1GmSmDxLeFqqfC3BCYvabnYOhHurXov8HZel
	dHdOY4k4qoTY2SMUMFd2BY3PJvcAsDh1rr5HGIhk0TC4wjwpTn9o9CytDHPSSgsdL7UrQz
	qWAHs6LLcK0KK7eM8Ez9Mf87FLFCvMzTV7CzUJZ01SK1QkipW9ggdhGB1AUT0B/Sr0g+pX
	LsOG4yswfd1+jQnYUaWwA0Inni0/kTmdam6ak1F5tZcp7WWZBSR5Nb0qCg4daA==
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
Subject: [PATCH v4 1/2] coredump: Fixes core_pipe_limit sysctl proc_handler
Date: Wed, 15 Jan 2025 14:22:08 +0100
Message-ID: <20250115132211.25400-2-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
References: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/coredump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d48edb37bc35c..9239636b8812a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1015,7 +1015,9 @@ static struct ctl_table coredump_sysctls[] = {
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
2.48.1


