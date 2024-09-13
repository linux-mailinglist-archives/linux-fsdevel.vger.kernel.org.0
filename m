Return-Path: <linux-fsdevel+bounces-29328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89099781ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E8C1F2151D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F211E492D;
	Fri, 13 Sep 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2lIRgow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E61E203F;
	Fri, 13 Sep 2024 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235691; cv=none; b=J/41VkyVNUqrHrZnJba4Avn8MawaqRiRacAQVQ9pQYeb5pJOsAnsB/TCpz2nLp1jOaF/ETAMR+5odqPGR3TLp4w9N/O2emLl/aKcsMpWXP/JdBPCUFB0nPtTLkOIkfhvNPCm/Wti8akV58UhLPL658fdNcIqzaKyD9S7V3Q3wwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235691; c=relaxed/simple;
	bh=gE8r0Qbj4D8u7V9shLCLoJR+0WYqh7zAXrVYnVeHWEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I0uE5Z5iiSH3reWzL7iAekdZR4x5Ii8cbvuqm6cu4uW3o7Fiw2Fn4MQV1jJ1equb4dHhxT11eLi/mNUTMH8EvcjPtOi8VJpcJ/sMPGaQIwYP5E3sPuRXoKlx1AZvkci8KGvk1yz8RTdoYHYrbfj2X3CbeO8wpudi2Y1YdUzQsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2lIRgow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984F9C4CEC5;
	Fri, 13 Sep 2024 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726235691;
	bh=gE8r0Qbj4D8u7V9shLCLoJR+0WYqh7zAXrVYnVeHWEs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f2lIRgowJftwLcQ9w7tVB8oC70HkHxJDGKDyJpADdRiJhqArytVVoHezmLIRgh1/f
	 65MbjSAkLoNmZG0zGJ/4rrxWgBJ/YPPywR3n+kxUaKTBVCq2eXtTEAkBhSzlnY5nCN
	 euY44TXbdqovwOs/hJGQ7akGkV/WNaOUgxxZAkqKnxloZmXkQ3x1EhYrznya4qzj7z
	 xoyEBYwkF1GMT7ILCoL9sMkch1LKDhm/cyPj0K44b3EE079V3JVVwg5vlpSGlre4DQ
	 fdqmY9C9zlDwjaILzHVoAqFRFkO9QniRuw3vFPpz0TCvMxl5tRuRD60P3aW5B2jPhL
	 57+P8nnHpu2iw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 13 Sep 2024 09:54:20 -0400
Subject: [PATCH v7 11/11] tmpfs: add support for multigrain timestamps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-mgtime-v7-11-92d4020e3b00@kernel.org>
References: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
In-Reply-To: <20240913-mgtime-v7-0-92d4020e3b00@kernel.org>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Chandan Babu R <chandan.babu@oracle.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-mm@kvack.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=862; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gE8r0Qbj4D8u7V9shLCLoJR+0WYqh7zAXrVYnVeHWEs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm5EQJHTt+Om9HYRcT2NZhJ5f2mscuIoCqf2gYe
 jhTS7eDZkCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZuRECQAKCRAADmhBGVaC
 FQPaD/9gG6UEiaA7vTuVgqfTbBhigO29yQX61fwL8SVjsS051BMJ8t48j4j1aviqPtTD6+16bWl
 s8DnyvS3b5IVxvqrrku+15cai6PFXW2hpMz6ncOe8hb//hNTQblEKLSar+bKiPqhlaNn6YemdXu
 F18GlMWmkLgQMMAkECO7gvp8yXBZIiqqEwc9uJWH8IytnUkKEJZS9S89pV9CI+atEhSU6OSMC5i
 ZnqIL98cX2Bg+Sq78zhJm0lJgwo20Arvq7B1MVHbp76yS86iKi6p8bpEsD8RwTA5jhomTVt/+UV
 qGiQHCZ+AdxQsrfRU+RPUyhG8uEBY0vrXDwpx2hQr+ouu+BDvjhB3ylkFyWMWaNm1OJuJ7WBv1O
 Loq6TgYL8/bit13EcqxlPIinPON11eRxALoPjA1VtFusW7dKrFrykV6bNy+5e17HXvpP+bCNdHV
 vwN28AVgozIZkBCZTl7j+qu2Ex9KY9cJGLkuRyKrHco62kfy2RUOJpT3M2mx1eW0VdLNLByadcQ
 509HchpbTRFisLAArStgVSrxzAnFIdHyLu2du2y5vCjRHXyoym8UHgUX17Dl8mX3BG268V5pAHG
 7DDpYgszQlnENaUwHlbsTtQsg10Hfi+pUzbv+aJdLRe39lFUd4Tkg7okBANYJaH15piBp6j60MJ
 Ct1p3Evc6o4ymiw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Enable multigrain timestamps, which should ensure that there is an
apparent change to the timestamp whenever it has been written after
being actively observed via getattr.

tmpfs only requires the FS_MGTIME flag.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..5f17eaaa32e2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4804,7 +4804,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 
 void __init shmem_init(void)

-- 
2.46.0


