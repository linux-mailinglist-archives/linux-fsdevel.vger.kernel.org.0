Return-Path: <linux-fsdevel+bounces-56079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A5B12AF5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE756546140
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03128751D;
	Sat, 26 Jul 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODELNqKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA32874E1;
	Sat, 26 Jul 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753540326; cv=none; b=d1U0jVx6eHufaw13V1WSiGa/1efKpv7A41JYFoG4ep40691fPoonaYg00DAgcBaV4eNfu19nWfeXyoCFzhwio9Epozdc8fLe0HuMKbH00n/dPfbLV9vZOBVztwEZb5TSnZ+4kfvOv3kujvSIf+kJMv5UFwCjycCTwaHT1kR+Uhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753540326; c=relaxed/simple;
	bh=HlUFhtJZ0QZjUdN5XDHoZHQfPM0ewGEXkaJbOvSrW3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhB3MxnD4b+Ln0lh/zBTsjpc1utm6QnB62glXmxDezkX4C9yYQj81rgyDpdiFPTdWj7Ck64aTzrlbFPRdOUGTSHydLFv1wSZjQ2y+4EPgiVBYvU0Iye0qbbPUA1Dv3wT6weV+X8Mei/Tx4KvDRm3vAdpUuZyH4Zc8R6N9NX8hVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODELNqKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D59C4CEF7;
	Sat, 26 Jul 2025 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753540324;
	bh=HlUFhtJZ0QZjUdN5XDHoZHQfPM0ewGEXkaJbOvSrW3A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ODELNqKzDv4k18PmhxMnuftK9xVutbUYjL+l0rZsov53lPkqFsnogy0ceQTQIFIer
	 mDqSuZEEpI6cmK2bf2yU3fHP3MOrfygfs/cwHtTKEcF6O5+wR1hzO0KxKPTEp18H6F
	 9Uq3cFPmYZGuxUrBW1SoDGzOTmHxuLyDySPrAe/iwGZAdESOD7gc7OZcn+gpQSB9Uh
	 fcOv9McqoUnYF7llzgKYqKpW31Xc/QzyF0sq74e7CKa7jkBsIWKvfBEoKenJgrqGOr
	 ETB/1UIei9kD0Yho9olap2W/IAMUzc6JkpRofInwJn5PAmBj1/Wmob7xYFLIwoWGwA
	 7cyt1Zn+nD+0w==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 26 Jul 2025 10:31:56 -0400
Subject: [PATCH v2 2/7] nfsd: ignore ATTR_DELEG when checking ia_valid
 before notify_change()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250726-nfsd-testing-v2-2-f45923db2fbb@kernel.org>
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
In-Reply-To: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=605; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HlUFhtJZ0QZjUdN5XDHoZHQfPM0ewGEXkaJbOvSrW3A=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBohObftY4nPoGSZnyvzLMt13ECsvcxlNPD07/B+
 +RFdhXKunCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaITm3wAKCRAADmhBGVaC
 Fb9wD/9UZ8o3InKxb78teIh7hrZuyp+dJ4JGBxt0e6Ca5TCxQflbGRfeZ+izCLpjNSC+Wd8yD8f
 mrk0oYz5cwB/p4jnbbBQE1LOr5uhDc5D9fnd1O054eH9Hnoxfxhwqq1xMe5NrZi+qnTfdXlenTx
 /sjoSA2IVijDS+J0WMAkKge4qd9yjDIGzO/aDdvOravjK0H7XHLYex120/PHRHF7jgDvVlXhQfn
 HsO99pfRIv3K4Xrp5IVHo9HbL+7BihKEzJH93wb6bkfels6ru9lqk4qcjYKXjl34lw+cBTylWqW
 I7pVAylpflrQCfVtIx34hCBJa6qaEPpRJ/jalTfcBc0sFakYNO2pfNJbx8zoBToMWgn4zwF00zF
 mz56uMQCMB/BU14MpDhBnPgLhX71MkxAPf0t5F8uAH3WXrtk66TQtjmFVxc9KZ7/spx7qZojU0t
 +a/8wp42HWsGy4Ljw3o1wZXZAgUvw76kHeSe3XT9d8LUoZ1l3JGaIFDLZaQSTYaLE44plyyO2X/
 O8b1ry/7dMpnPFoVILkumoNx09yt1MuaHG5naKSXhtryJsWAE8Cv1Wj3kvGqlb7KtFT6gsf8A+K
 chKlTKaZ+n2mWXaoYx2uX2bIPodlXo9IZsKA2NxgXblMsrhVBy33yjZNkprq+EJvpmR21yFacmm
 GghTSrVgGe1R6vQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the only flag left is ATTR_DELEG, then there are no changes to be
made.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index eaf04751d07fe9be4d1dd08477bc5a38ac99be3a..68d42fc5504d8750174b9a2aef10886ed92f528b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -467,7 +467,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct iattr *iap)
 			return 0;
 	}
 
-	if (!iap->ia_valid)
+	if ((iap->ia_valid & ~ATTR_DELEG) == 0)
 		return 0;
 
 	/*

-- 
2.50.1


