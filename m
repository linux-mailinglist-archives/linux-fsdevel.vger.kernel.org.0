Return-Path: <linux-fsdevel+bounces-63983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B83BD3BE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C43834DA59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9D430E847;
	Mon, 13 Oct 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOkbwNpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C1530E0EE;
	Mon, 13 Oct 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366934; cv=none; b=QfHfGzbQUSLjL4T+x2FMRyZGF/861eV/oNLlU6EoDtNIOpLqOSiAFGfG0dyZI+L9FdLJmmSn8AYb4dsMcBOROFWgSa09jwndUMBPRc9birvMXPqNUvctbsGIcBRP/U3UqRfCvdgh5JUb5Ge4B9iUFIPpg9Ynd5Jsl9NHNkgPM4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366934; c=relaxed/simple;
	bh=J5we6Oj9umwD8eK5iokfF/EbyCh2/ylz1MJttYCYqeQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giJGmuJr56zoaseQCHOi1mR0n/sr9e6328RMQvsq48urX2mogquyTm/HocWZMr3oPXZwD8fGu68Ek23UMJide0YH3aGWI/qJlf8F+0rQU+K00+zfT7jcdJP3zJKH1PloeMeynrYONGmzhs4kc5vWfyGM2xzpHzVeIBb3lGwyqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOkbwNpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872F7C113D0;
	Mon, 13 Oct 2025 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760366933;
	bh=J5we6Oj9umwD8eK5iokfF/EbyCh2/ylz1MJttYCYqeQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZOkbwNpcnQVZiwE/+1OP9mym6fOiHl24qMW9xYOYi3jifFxtYd0S5oqgUCVQGW5zT
	 f12Ahu/yt8XfdGBrnnGxGSMd72XkRBrMRq9+5mPxr8cGPp2Te1RTNKAvHiJt6Eu1PP
	 ZfRAz4P4VqNcQF5c9W6TW4RSsWHjgpyH8SNBLhERQ9eo28qLqXpeN82PZuOvIt1Fyj
	 vWJHDMda9Z391xuPDziTvdm21CG9hMzZ5v2tHejb3G9a+LzmLl9k4M1/B/4N83rPrm
	 VVLGu6HhJFP9ca3PU0WkbPaVlDJ7xhz0Om1t2JzIpO9Qapq6U9hJvPdcLyv42jJw+o
	 EfLla4fxe9EAQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 13 Oct 2025 10:48:09 -0400
Subject: [PATCH 11/13] nfsd: allow DELEGRETURN on directories
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-dir-deleg-ro-v1-11-406780a70e5e@kernel.org>
References: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
In-Reply-To: <20251013-dir-deleg-ro-v1-0-406780a70e5e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Amir Goldstein <amir73il@gmail.com>, 
 Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Carlos Maiolino <cem@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 linux-xfs@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=J5we6Oj9umwD8eK5iokfF/EbyCh2/ylz1MJttYCYqeQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBo7REsV/K5Cbac42DCmO0U6VglrS6hK2MFAgCKX
 UORwXDqyRmJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaO0RLAAKCRAADmhBGVaC
 FXsND/9IwMUpKeKrXyaAVdscFyvOXADkgIXB6MhKk40rjoQr3GuolCGQvgHm4afZrUxX8wtSQFs
 DUS8ANvvaRlerYhiFAFWM2vQA16Urqhusp22d6aQR1bAWiBsPcRm6FDsjuqYCoz4Sx8Y5j/nw1G
 /Mk/8dC08BY0cII7i7XREdLlSmELt3uWaSM76bwhylscd4PdfOUyQS5l3zuhs+N7aQn3QsFV5C+
 JbSsbKuTAQ7u67LPd9F0M0bRIpujddFYeTxnWHEuoq0j9eya4hN7zf85uCLHjXiJLy3p8Tlyrum
 qGjpOkpXBbaUsWZ8gSdWf6s+RBEbIFUWQtXuI7foCN6EeqxQMJACkWzyT5MSHrUaadRFZA4M+3e
 St05oeWyRQBHyBcZ297hZwC0Widpuz+SrsVATH1cy0aKbG46JHlA7vsbpy+W+fUntUHZWQbdBRh
 2z/6qmqE121253Q+m+p1uD6BFoG+pjptTQjC2GuBamzTbLU/CYwrCU11IylVKtmmjK9L0jJ1i6F
 d340wgHHu0FgK23WtQPS/5mQIMiglbrGCtQVkbeLWPDeJXeZhZ0keEmCwIfbKtt/O2mGLIvrX6w
 B5oe8WPHdhInYeV8x4O5mfzPdDalpVH6Jv7QixlNuQcL1BKsDggjsi8urTghbWxRycLQVwfY4Q3
 5i61rfj+1Tm/I9A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Trond pointed out: "...provided that the presented stateid is
actually valid, it is also sufficient to uniquely identify the file to
which it is associated (see RFC8881 Section 8.2.4), so the filehandle
should be considered mostly irrelevant for operations like DELEGRETURN."

Don't ask fh_verify to filter on file type.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c9053ef4d79f074f49ecaf0c7a3db78ec147136e..b06591f154aa372db710e071c69260f4639956d7 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7824,7 +7824,8 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 
-	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
+	status = fh_verify(rqstp, &cstate->current_fh, 0, 0);
+	if (status)
 		return status;
 
 	status = nfsd4_lookup_stateid(cstate, stateid, SC_TYPE_DELEG, SC_STATUS_REVOKED, &s, nn);

-- 
2.51.0


