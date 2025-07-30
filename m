Return-Path: <linux-fsdevel+bounces-56334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BD7B1616C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3895E1AA1F07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6E29B782;
	Wed, 30 Jul 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvtoRu35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B629B226;
	Wed, 30 Jul 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881901; cv=none; b=b7tUd0kz5gwTucdokv4IJluxBBFfp++YV2ee7EIFiyEavCQaYYUX/zorKOHqrCD7rgxWequdcJQn0ZVLmQgzj77vt04/d07sEG4OrCwCb7yNiEzOaOuPhrwKX0mNhP4D/g1TUOv7vmZgJ/1gTLUpYC7T20o6aBVYgXuZA4JrtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881901; c=relaxed/simple;
	bh=XDfX4u5DGDNsbxUiLltzn/YVAvj+NJLvOFItEakukpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdpUlI6PLrT7tqsSS3MVYZ+B7F0MM833JQzse4aFBao1voTcT2Zm8JtFixxzZIehxSqbOFObiOI+9ZYinPT3/+DumwyDJLTImPTgnTK8s+t/96Vz14aihxKV05Q74fwinGQUPQImtFpD2U42NcJS+ddH/05cOrg+jCNW3faMmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvtoRu35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15934C4CEE7;
	Wed, 30 Jul 2025 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881901;
	bh=XDfX4u5DGDNsbxUiLltzn/YVAvj+NJLvOFItEakukpE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jvtoRu356/ynVAUlXQcxRjIe5RaslfNZWKPfk/Sh5HEckQ4lHeVpg9Uy6m5TcJ7/6
	 0QqnQdOnt7K5z4Y6RDjS3fVlElqu3NQwAwo5Ek2XRSZ7AKYxvVcKCV8SRw/+26dT/K
	 aPqYpSKGjgtG0rzaqSs7VsZ8K7hCFNGW8VDtfR8AtwixMXL6/TBoWflhOyN9a1nMrF
	 BYzUzF7lefUalMIqjnq5ZD6KZhWGYeGFKJXi5Gl3Yljvq3FZg/Q6DzY9/6X/EKJPbL
	 gWbcysCMN3/0VP/mwLIb/7cLrcXICX+8HrSVHUOorxBo+AadWiWYf9rrqdrazfZc0E
	 fQ0gEsh5u7HFw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:31 -0400
Subject: [PATCH v4 2/8] nfsd: ignore ATTR_DELEG when checking ia_valid
 before notify_change()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-2-7f5730570a52@kernel.org>
References: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
In-Reply-To: <20250730-nfsd-testing-v4-0-7f5730570a52@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=675; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XDfX4u5DGDNsbxUiLltzn/YVAvj+NJLvOFItEakukpE=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGiKHSeidVPkw+iRv5K30CeSW0OmrRUGM6TmaKlwkClrlOsvD
 IkCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJoih0nAAoJEAAOaEEZVoIV3ZYP/jES
 yRqPrCXsdAQU3Rge4ThncTlthN5K2VGIwTZsTAHmPa7KwlUIeP2w00AuL3OJehEfBbYQZhKbNIw
 jM5r6lKYJ83/m5B6a4uUoKbuCxKeMuT47Zm8RpjO6dttzBZIRr7dvYRt4WcrnRCNIQGI4L1ZVtg
 ITrMWzQBkHhU/hltrMK+ZYgTJ3i4MWZAP2vVuZ9HXtkQqSrTp8D5oxpZVvA2wFvwB3mKWoTzgl+
 bZXYw1TjKVm5ONdJ7G98nG9UAzh37ybyBEVGuheU+4Cl/f0YuS5D7afzSsx0hu1h8XUeO2s/54M
 +cyIqXsOJNvxJwTdlM4duHsA7EEqZ5EhqB/h6cPgxxXfoyxtJPPt7gHOMFunX1qTJ5zGZljdxau
 /VmjdjYnWICNqCI3No9my2MOMT0rf7PG8l2Rs748cGZocrbPnNIKgujURLpNF5wpTIyrXl36kUs
 QQsncy1XpOUKD/pmO7UFHJEoPaY5A4mXG3O9yqEbaV1nBxxDfaZku7EwQoZoNuOTKbc+qzWQ+Lt
 OM81lGFUfTWJBgcfTeDA8+mZVK4nN7vYEVyzAw3IzLe5wYsqtIt1LHnMqSj1NAvaWY+UbUFeS2R
 VVii5d+j2upuwtScCGPXgRHfBRNi08zdls/kCGcMhyYm3DWR7A/kE6uhEfGbralWhSEiiO01/le
 Rg9+i
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

If the only flag left is ATTR_DELEG, then there are no changes to be
made.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
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


