Return-Path: <linux-fsdevel+bounces-56333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85DB16169
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1189D5A754A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 13:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC729B206;
	Wed, 30 Jul 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwrnLotv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2929AAF3;
	Wed, 30 Jul 2025 13:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881900; cv=none; b=je2+9D96tAjTcWIMOhF2L8qm4Pd2mMA5X77C9uwsbyVqCSwTaMaYs+Fks53Ei+Z/8k8xVM2kZwVRqdO8uR4fO/AZZZeTDTJ74ikQis1UBkBlbGjIel+/ksdmYy7pQ85EkwyqwY2azau/HvHhd4zG4LNBa08RArE4Q0tU/4MSy84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881900; c=relaxed/simple;
	bh=wX+jZhM05ADBnfHIbs04wC7/mLDtqIQ+H+KgWBk6ve0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAURBgRDBOhAEor/jolVZJF+jjfG7polx/QuepjLHFffHwuMFZKNKqAUFVuPNAZ9+Rx9PY03CzdPWtZUDAf4ptc0D8l8VU18QLQhwVeJt1NCJHCuZ4WA3zPq2hw6JBxAQTSH8TNQbwOY1W1/U+L+hJ7LB4gHXU+fTf5YfCV6pDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwrnLotv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809AFC4CEF9;
	Wed, 30 Jul 2025 13:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753881899;
	bh=wX+jZhM05ADBnfHIbs04wC7/mLDtqIQ+H+KgWBk6ve0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HwrnLotvAbiroqMdrmH9wxfZ8UwqMKbP0JzN1uIc2s3v6cjOhWvEP33jFR8LauYAe
	 ypfSXm4Izqp6L2ZgVjZAQ1VI46W+Ri8yKhX7EG5tmmtsn9zj9v/1RmW+dpm/lvjZQV
	 XIaJnl9ZKXjO+Sdt5/WKNsTAN/PyUg/mp1OgOgCdtybpnHxT7XdeT1/Qimq+ESYXF7
	 Q7NoHx+zxFWtWUCCX7Tv8je1tidweWSGo1GubLmPoWfygF36ouln3ROh6iZiANuceo
	 9yG9MJWsu1nvIh+LkHcYGnB2l8C4mWrImsaWaxXFGwTmP3JrLY1RDYN6r/nqdzYh5H
	 nwwCKBrSd4aVQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Jul 2025 09:24:30 -0400
Subject: [PATCH v4 1/8] nfsd: fix assignment of ia_ctime.tv_nsec on
 delegated mtime update
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-nfsd-testing-v4-1-7f5730570a52@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wX+jZhM05ADBnfHIbs04wC7/mLDtqIQ+H+KgWBk6ve0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoih0nVi5foMtUBA2+R641YJDWrZfKZbxje82aU
 ZVtbvTqLcKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaIodJwAKCRAADmhBGVaC
 FWrnD/9JBYZ1l7YYEHwKJznIB7O2LFzhfkxMN5BRF5akaTaBMPMHcO7Ez9eH1fZ5/bML1TH2XrL
 bcsjLpZqt3W+bRU1dCO4N2lSZu7DYgFyw4GSYwoid8nb23KwKWYBSTbUSYjz+HX6C66KQgArT4Q
 s7M7awGQXZXx3dSxT89lwVQYcHiwPXIioDpgporfgF3SyrlQcrzwo61oFvU6j9r0yCUgYAW/tMN
 QfcNUdadfGoBJw6h21t496JLXBMhCN23qSGKGkZ7wkQdf2afG27vdavmqJDI4OXBE0hBLt81jbz
 +zCC7P80FY6Uh1aGmyDRPedJN2/h7Ihqk1EWRTTpTbYVav5Kvb/QoTU5JFggKV0Q+PLpScvUcyk
 V/nb7PevC5hYXDqmJKN/1rGsZ0HeQHpKMaR+yDCUCR+P26Rdjs4/Ep104aLlrHtEY7e27h+ZQtn
 zGfeapsymnOWxxLmQqQQPU0Grq5BnGDCbQ3YDP901xN1yAO1rmJxKSpnHI/zowCcvsTe3RKWFwr
 /iEQhoI+thdqiJcwzFRTfYyzLDfiUGrTf0cCea4BUx1fnH8j4122URFogO9CbruKSYXmwNvVyQa
 5Gyi5xyCoQYE7sJIpkdoMsjGLZAYLnbJU6RFt8AtJvFqE7gzMnpPJz8HBtO6vwmCA+u277X/hNl
 e31dYbQcY3lSZ6A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The ia_ctime.tv_nsec field should be set to modify.nseconds.

Fixes: 7e13f4f8d27d ("nfsd: handle delegated timestamps in SETATTR")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..52033e2d603eb545dda781df5458da7d9805a373 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -538,7 +538,7 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
 		iattr->ia_mtime.tv_sec = modify.seconds;
 		iattr->ia_mtime.tv_nsec = modify.nseconds;
 		iattr->ia_ctime.tv_sec = modify.seconds;
-		iattr->ia_ctime.tv_nsec = modify.seconds;
+		iattr->ia_ctime.tv_nsec = modify.nseconds;
 		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
 	}
 

-- 
2.50.1


