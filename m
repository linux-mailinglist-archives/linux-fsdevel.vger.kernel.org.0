Return-Path: <linux-fsdevel+bounces-34448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5789C58BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451332823D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4040143C4C;
	Tue, 12 Nov 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="aUKmRdWq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A381DFF7;
	Tue, 12 Nov 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417363; cv=none; b=cww9JO9SaTdCD8dAiilvxecLVb+Mm0qNcSpel/yHmInAl4bag0aOG0us4MqmRZtWqwZdODj0Q8XeOff1lCQwXi4+Z5eFkjsmpHEFzKylpiaRvEwGVItFC1zNQCcaZ8XXdIguSGHsJGD9cWDttH+bLTc1emuHzIXvM3X4JAXhoQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417363; c=relaxed/simple;
	bh=qfOxXZl3i+Y1oYo8sGRDtKZMnRF7XlS1req/aH6k6aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjVwdPXCqdcSFxSc9w/cVv/Jf7yQpxwBi9ShS5ztfXZyataZh/t4JX8dbXZO67VAF+Wi78JcNC83QwJdFqOYOPSWaUofEwomISVHTbFClsbAmturTYMrYoY6bhhlWy6IVeUYnHDir+YazUGxLA4IjMnnQA0axJqKvpz76iC4Vd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=aUKmRdWq; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1274540009;
	Tue, 12 Nov 2024 13:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731417358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q32Mu1dm6Jq7pbi1U+EvpEksk9Tb+6KgFIz94SMpnwA=;
	b=aUKmRdWq8Mi5vXx2PojitY93MZJ+cElBXrTD0ft9KyK9YACwU/IDVOWZv9ah9uv569g3su
	l1NVQw1nO9HwagKTJuAyBsWzoaK/FhjbDvt7fY9gdaYSlhHLcqtrPG0l4lWRk5teTPKBv2
	IGXWbuSmYd9Mexk1hdAaz4DTytFF0kKMLjZ1Qi5JjfamTcuHcFkwYZ5PqZNudtZ1zTKLBl
	HMxjIqwFiuPnflFvVVzbdFuIZVsXyQzz7M5ClcuQ6dl4/T5qqix4+kCuntWzo1mE803dy1
	SlzOugn5G5D//KxHZg0M7eXPkixQeXSSLC6WiSw874IqRyORA5CZherxmcN0Kg==
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
Subject: [PATCH 1/3] coredump: Fixes core_pipe_limit sysctl proc_handler
Date: Tue, 12 Nov 2024 14:13:29 +0100
Message-ID: <20241112131357.49582-2-nicolas.bouchinet@clip-os.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
References: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
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
 fs/coredump.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7f12ff6ad1d3e..8ea5896e518dd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -616,7 +616,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		cprm.limit = RLIM_INFINITY;
 
 		dump_count = atomic_inc_return(&core_dump_count);
-		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
+		if ((core_pipe_limit && (core_pipe_limit < dump_count)) ||
+		    (core_pipe_limit && dump_count == INT_MAX)) {
 			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
 			       task_tgid_vnr(current), current->comm);
 			printk(KERN_WARNING "Skipping core dump\n");
@@ -1024,7 +1025,9 @@ static struct ctl_table coredump_sysctls[] = {
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


