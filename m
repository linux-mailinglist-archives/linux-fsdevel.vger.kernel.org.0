Return-Path: <linux-fsdevel+bounces-24899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC50794654C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 23:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B761C20C46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF313AD1C;
	Fri,  2 Aug 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWKEWzVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE113210A;
	Fri,  2 Aug 2024 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635123; cv=none; b=eKt+urKv6ppS4Dy/30EItipDq0hEJWhqhXJGrT7TYawcM+Ds4Wj0Xk7PZurqZQYgGCZPhirTEv1hVTnRDfDO/oc/253jWpTH6KkAwp4Xd77+NcRO7e/b7Z00gWdxmNEnjc5iqTHsR6OKFBzVu4cusR/AlZg2TIjMHfnOhJk1JMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635123; c=relaxed/simple;
	bh=6qKot8nTK1kvBUPPUsJ5bWUIp/afDZuPfPxM/tjbhpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V48Z+Q1V9FUavR6Qlk6wVJodM9+kPHLZr0q51DUMWb4Cg18qbrSkEwI1a0R8xBlMzTo5R/g/v/vgwFxY+djwtrcuf+uMVxjU+wQjX9q/64I4BMdk8yMHDMWIYlIkPwUg854yR57USL0nGuxQ3J0CkKIvhAvqGWCh7tdhzxrrFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWKEWzVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B7EC4AF15;
	Fri,  2 Aug 2024 21:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635123;
	bh=6qKot8nTK1kvBUPPUsJ5bWUIp/afDZuPfPxM/tjbhpU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BWKEWzVP/ZIFtrn5ML4cPyXOuqfvQqCfOtPpOMySN4oAl6Yp0fUUEDgxqYVi7946f
	 T3pi24I9YcnmaMjkjPqZqdTZTM4I6RuRu3Z4EABVlNoJTOz9YVinUPotfLfX49A9T1
	 z3FbiGRiwhrUXeY4XfZVCmLHq75thjrB5Q64GU9CoC/R9zacERfcsS+b1xvzusGLFJ
	 sJHfllE0xet9HYbxsnNJAWemsDjW9F99XlAVuorGxS6uBEPoCppfqh5UuebELMfo0h
	 rE48/2ExLf2Do+RsKCVpHVTJqGXaM3qkr5rtFU2fhmuVVejDuyZ/JGngRSoB5SxmMo
	 i+Ontze2ziRhA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 02 Aug 2024 17:45:02 -0400
Subject: [PATCH RFC 1/4] fs: remove comment about d_rcu_to_refcount
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-openfast-v1-1-a1cff2a33063@kernel.org>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
In-Reply-To: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6qKot8nTK1kvBUPPUsJ5bWUIp/afDZuPfPxM/tjbhpU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmrVNx1Qd5+YGDWT97thq4Zi5gvv7eYPURZHz09
 VJMSSllcD+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZq1TcQAKCRAADmhBGVaC
 FVqQEADVu9TOnBnlwMuqcTukb1la1Jl6wrXrykpp1D4dAXQpt7PgGPee1AXM3B5UVsV5HOcFnaI
 kG+LXKjI8NhtkQxhguH07LUImd9qwjXW+a/G1U1sfZpfY575getD4BRR6WrJUTm5z9kj1jVrSw2
 ApULDwDYLuefh8s/+XKQfbwvbNNz/hg5kJpP+5QN4cSHYfavmy05+lMN8yP+Cq2g7fKHdqfEjo+
 jI+zIy1Nxq5qpOH+nBEL3A0tKDlLykRG3GBrPlLz3PKl5DBb0VnqqVQlBy+s++IdZcSJYVW0b/O
 sMIimOP0THNIax3h3Eptur5JVyk0fxVp+SFIJMgjjEYMV6DU2p9XGZa6T3DOqi7S3fDuxPLzIWx
 FY9Z0JLHEGflw2DxpQWmO7ysbC8rfHhAn2KVA3iFKqU8gAIiErSx41IUoJCqvEEkPD3jQHqsuDS
 knthIiJI61WmnxcsC+u7d+jUn9VgzROD2OiJUqGmo960Ee4ASAor2Y52ieTkYQL/bVBuaS//rrP
 /YKQpNZH/KY312LiB5bhD9+rA+46OEeUSFCPs0Nd1+fTfEVdolsLcEj9G/8y+1zdbT3SMEQIDkn
 SOL4MpQEf7iS65bg4RrzaBdt9W19Z96+wJetMaxi2AZgPcBja2Qt7zlMsI1pB2JE8nRCSdGOUKo
 o8zvPnsOboY8tyw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

This function no longer exists.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/dcache.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 4c144519aa70..474c5205a3db 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2160,9 +2160,6 @@ static noinline struct dentry *__d_lookup_rcu_op_compare(
  * without taking d_lock and checking d_seq sequence count against @seq
  * returned here.
  *
- * A refcount may be taken on the found dentry with the d_rcu_to_refcount
- * function.
- *
  * Alternatively, __d_lookup_rcu may be called again to look up the child of
  * the returned dentry, so long as its parent's seqlock is checked after the
  * child is looked up. Thus, an interlocking stepping of sequence lock checks

-- 
2.45.2


