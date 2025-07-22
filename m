Return-Path: <linux-fsdevel+bounces-55719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C14B0E3B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1B14E54A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C478B283CB0;
	Tue, 22 Jul 2025 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mell/UAH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B0280CD5;
	Tue, 22 Jul 2025 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753210361; cv=none; b=XpESH9lTMabKgbam4ZOKQGLh0xAyIDuOFL5t1tlJ19hh+dY1OvZpKhBEWtqyjlpXFADtdV3mELcfq2muv3Wu08thEgA4K8ZHaMiqAxirHAm9bUcNT/aDuBud19cDiqoP+hBp9EwxqQEjMiCG0pXJjxVfeEEI1tabXVhwoYbWmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753210361; c=relaxed/simple;
	bh=0bqNmtkfCsYAScjWaHpJG8KA1tQSPtNgsYNa1N1PLBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tFmH9pVrX5rLfmcVlf2aFFxMVj+6bLycVvlFvc/zgAEnbsfHEZPS6hn1S1aRGAiOfLfDGxVk8bhdDCpGxmtAn+RH2O0nWe/QPUleLsG0uyKpjJY+Cjpce8KgFKqQYHjgnW6BNTya2gtQh6B6LQPFjhitkyj5QTF+f9NyqLlEYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mell/UAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FD2C4CEEB;
	Tue, 22 Jul 2025 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753210360;
	bh=0bqNmtkfCsYAScjWaHpJG8KA1tQSPtNgsYNa1N1PLBc=;
	h=From:Subject:Date:To:Cc:From;
	b=mell/UAHhEupqN1ihr8wD2p+a66P894U7xosZGiCFUFhI/gqe6gCdspjjfLESve+4
	 K7aJUAF9YrfIr6sFDtwVljCtWvDk9VyrWRIR7BshauRwqBnq14DrlMw8cittZW6aDQ
	 8ZevBhSkkfxnqgEoN0UpNLEM7mkGjhMnQ5vAYXnIMb0aqseKmdAUyhfjoFZLmJDts+
	 fJfvBytXGLRFX+ei+gFfHrKd72p9xKhjF0EfrAKeL+kXkmlXNsS9rbzO6R+YphDh/n
	 vVhf/SUJfAeInkxNgsMWWdEUV1Jt+/D8jB4XwGlIDayDAw0tiBUgXQ5L0VJJbps28w
	 6JAk2CHVkAFHQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 0/2] vfs: fix delegated timestamp updates
Date: Tue, 22 Jul 2025 14:52:26 -0400
Message-Id: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOrdf2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyMj3by04hTdktTiksy8dF3TVAszw0Tj5DTjRAMloJaCotS0zAqwcdG
 xtbUARkr6rV4AAAA=
X-Change-ID: 20250722-nfsd-testing-5e861a3cf3a0
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=0bqNmtkfCsYAScjWaHpJG8KA1tQSPtNgsYNa1N1PLBc=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBof93wGhlWpmqTHkzCVVjiwNm1iAoAltacYDp32
 Vm/gjLcF9SJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaH/d8AAKCRAADmhBGVaC
 FT5AD/0Rx12McPNE4b5aGc9AGUIGbtrY77+YpbumA/EcSrCy80NEeLNvwJfKTNuxCmbIeloOOSa
 vjPnB8bc90nWQ60oDLHuEBMpVEKt6lApjbvUQLjlrbdFpm5oTCqlxeby2oWAunG7evpBzYpaEM6
 5kIw58XIUBWqWkjtNdhaHt8oSvLomvV/rNoa2tkdAUekuOyU6P+93SKt3E3lekA2p9YYeJndRXN
 JVlqGvnwYbyWfSBmikTy516CbtGEUxaT9oIdzMqZT2FYsM+VvJnhBUHN1taUMn8f4ThYqZRU0DS
 VxbRicmMgB1o3PEftEmqLMSYaL/8mCz60trN339kBdzTk/BIJRzhpYVjzM4ccFJQqHsDJUIzWrz
 SODxO6oLVPw/qcXVyimeuO/z/k5+RnoSAKraCH8Fhjf3UIQpRB1uzdG6PtlBw2gFQzkZL94atXN
 BuBqDt/CEtfi2vpCJAYhhak3U97v3b7lZ4MX/kHfcROSU/isjoFoOE4lNsL8zNCDYgfR6XHspNV
 qg1kTpG0VdmLGn+A2HQk5qZ9p6QSwCNKmE27xKuIaBlJu5TeqmHqVhd1blgLQgUvd90RwRU4R0R
 jVq6g8nNI2unchG4r8Ne93S7oUngDJBwZ8bmUZu5dJ8afk44kRS59uB2Mp0IVZDafujcBLHLsaO
 7cyCjK9XTVKApLA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

We had been seeing some failures in the git regression testsuite when
run on NFS with delegated timestamps enabled. The first patch adds a
tracepoint that was helpful for tracking down the problem. The second
patch _mostly_ fixes the actual issue. With this, the git regression
testsuite is passing a lot more often for me, even when run in the
"stress" configuration under kdevops.

That said, I'm still seeing an occasional failure that I think may be a
problem on the client. I'll send email about that separately.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (2):
      vfs: add tracepoints in inode_set_ctime_deleg
      vfs: fix delegated timestamp handling in setattr_copy()

 fs/attr.c                        | 52 +++++++++++++++++++++++++++++-----------
 fs/inode.c                       |  5 +++-
 fs/nfsd/nfs4xdr.c                |  4 +---
 include/trace/events/timestamp.h | 40 +++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 18 deletions(-)
---
base-commit: bab771b8eba6f3b13446ced52751be122af0d3b7
change-id: 20250722-nfsd-testing-5e861a3cf3a0

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


