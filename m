Return-Path: <linux-fsdevel+bounces-14505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3348387D20F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651ED1C2099B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878E45D8EA;
	Fri, 15 Mar 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA0JHACJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B4346444;
	Fri, 15 Mar 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521642; cv=none; b=oq7K+ZeAiJBFoc2G1KaC0/lLkeRU0t3EsAX7IMAZARpOBpS/hOzK1uE9+Gv++U2WkcZkDRf5wIC+FD7+7hp8WDhUQF9Cg8Q7iuEIIZD7qoen9bI/gRY2z9p0Wpi812NTUW7ua8JeYRfZXYrlSci+C3Hkj1QVCO7WulCDjXbhL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521642; c=relaxed/simple;
	bh=P3P+nenUv6VvukNKiPfmxlsB6i7HdvY08p8t+ZTGZvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrOqPBHMecBfmxYp/3RHpfZub/Rj96+BWHjHv/0H+XNouftnEWpgkC23GQC9hKIDf4p6YZAe9FqyC5cAqVIpmB8SDqOSscGyud95mAlw8t748isH0b47ub4F2mPMmViZA9NlujsobM54RNjnTt16R5pgSrKkMBGA1c5tTGNylnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA0JHACJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B4C433C7;
	Fri, 15 Mar 2024 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521641;
	bh=P3P+nenUv6VvukNKiPfmxlsB6i7HdvY08p8t+ZTGZvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bA0JHACJ4ODIfzBcjkQNec/1i3GwGfPX1XO4vav7s1TnyjdlA3Ai7XJBTetakBPIi
	 IDeYNJpPufcNi2bhKyQjNL8PnbNlpwqXcIaVejSxLrpp8s+x/ARHSBZ3s05qZKCAC4
	 BxrxURM+BIWz9InwPb8QNgVIkfmGuDFQ8+dkU0JOpWyNz6bD746s+rXg+ySz3hNwr+
	 vVS5NMLoD4yBzXbzcK+N+vK8aRz2rv9+9QWdtOlezW9105CArD4duChX13QkCTVqa4
	 ufi0ideAIXlaDVahH6wsWH5BgbrHskAZu4bRpFhAv5M4FxurCn8+BNzxEEMP2VW0x+
	 O+apPmFY+MZTg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:08 -0400
Subject: [PATCH RFC 17/24] nfs: add cache_validity to the nfs_inode_event
 tracepoints
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-17-a1d6209a3654@kernel.org>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
In-Reply-To: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Howells <dhowells@redhat.com>, Tyler Hicks <code@tyhicks.com>, 
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, netfs@lists.linux.dev, 
 ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P3P+nenUv6VvukNKiPfmxlsB6i7HdvY08p8t+ZTGZvQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzuw88TNqkwCTRIrEoLMgta3Sg0NHy64s1yu
 mjRVl3KkxWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FasaEACuCD1+QHJLojJYk7/ZwEUGejIPwEWap+++JOPIdRPuGRKC8aDvaOaQD2V1gAoWvZ47y8a
 I9XxuUjcpfkniTYoJb1Vvy7rz/6uTRGV/91UFdLPY/N19gjH5ZdvP+ZgKpcxsTpscRCyZNSj4br
 PKYcfDpjLymWsxaQZAvoEq5CGJOJjij+oJwTwXG04n0+hBXAdsDGS0oeUQG3A3FWr5Q2QjsYPfa
 cQ+G1aoNF1dw88GvPPXh3X2N8hGu/gmDyKXXhzD4jCp1spW+3ffSBQ6dhOXhLOQyUmAS0IWeWB3
 nujqVPjSUgjK0yaE/SIII5RNggdSMIZXCgg6XSBGt3rxjvLIpw4XHOfk44ZXnYKzvpwMBfqszdF
 VrGm4HFamuj+O9HHv+VSd4140KbfULTBr3txJviII7n2ri9V3BnbXUCPmiLnMQmjs26Qe91ZRnp
 +ZTOdmV1IM/LR4xnXjCPPAYO2cSU+gZVb7mnDd5i30nCWGZhQDSiW6TnYeHU+w+EU0eXMNvIxcx
 fwEWWo/uy8U0gwJC/N6ZHz4rM2e3KylUA5GQVvUmLzn0l75LRWYvAC3F0LK7lxcxK3P/QawY2Ym
 Ztm7wFSUOQZjAsx2PwIqKSBubWclBpFRn3KXQyMmp7xX/TZ9TB9Z2hxLH7+2hy7DUTFixYnKOY1
 LAsxr375bCYSywg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Managing the cache_validity flags is the deep voodoo of NFS cache
coherency. Let's have a little extra visibility into that value via the
nfs_inode_event tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfstrace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index afedb449b54f..e0cd3601d1f7 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -56,6 +56,7 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 			__field(u32, fhandle)
 			__field(u64, fileid)
 			__field(u64, version)
+			__field(unsigned long, cache_validity)
 		),
 
 		TP_fast_assign(
@@ -64,14 +65,17 @@ DECLARE_EVENT_CLASS(nfs_inode_event,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->cache_validity = nfsi->cache_validity;
 		),
 
 		TP_printk(
-			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu ",
+			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu cache_validity=0x%lx (%s)",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle,
-			(unsigned long long)__entry->version
+			(unsigned long long)__entry->version,
+			__entry->cache_validity,
+			nfs_show_cache_validity(__entry->cache_validity)
 		)
 );
 

-- 
2.44.0


