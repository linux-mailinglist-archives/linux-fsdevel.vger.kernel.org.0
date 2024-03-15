Return-Path: <linux-fsdevel+bounces-14503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEF87D202
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D22BAB237FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85335D490;
	Fri, 15 Mar 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRG9xjFq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99E5D463;
	Fri, 15 Mar 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521635; cv=none; b=ZYFCDR2dzusmrqKJL7rYMYKvKr1efm8EbjB+4fB/+R1vAiX/Nc0jNQBWXH4zn5/v2LXocKx+KAOUKSiB+a9g2ass7l6HiKshCQ8Tvz+suRg5r5G45RaSXDpItU+5vIQLY61FH8VexS0VoYWJNMMWGfbfGUQWVPuqb9MHQpSD3HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521635; c=relaxed/simple;
	bh=Unfgd+Xo7evIfZLg6ZS/YCO4C8AeO+s1DYe1G/oc9jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SrXcHophNhW1jJo52Ln4wApssohyTXKVWlZQmDh7OF4sX4TtQsDB9m31deP1vXSB2blU7iNySomv5TnDxJVAd3LVtvAfHOn0FxLc5ty3amvLJxJTxyDT2DyhPTPhhXwuPbwAc0/exT+oD39oDaeF0nkWryRgzV3LzOeSMzs3g8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRG9xjFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC13C433F1;
	Fri, 15 Mar 2024 16:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521635;
	bh=Unfgd+Xo7evIfZLg6ZS/YCO4C8AeO+s1DYe1G/oc9jk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WRG9xjFq5lq1t4ya5wUUvSRDISmfJwnGyNAwNuwKwZ3w1S8MRE0g9Dgt2LLUboKgK
	 4l8PsohndrCH9u+hcXWxKhY+K/ctoG6UmTaQlj428p3IUHB8d6fTnTDLoAnAzDhcuj
	 qbe8nlQ6a/JbSmFkE7tWVTfwJi8RLfqqLaQbg2ziVArNTge2yxoQhguribCNBwOV6w
	 9NKrVODl12GhcU8+ivcbkmA49HGkCx28AvlES3LIpmUURQRsxYc2WjBMqGfQ3oZzEn
	 FgUwRXEmbH+IIwmqns6mgcqYj5R60qqV4DOM19XZDcW1TiM5XjBlfRJP7axaB1Gv7n
	 saY+9LKKzZziA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:06 -0400
Subject: [PATCH RFC 15/24] nfs: fix nfs_stateid_hash prototype when
 CONFIG_CRC32 isn't set
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-15-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=647; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Unfgd+Xo7evIfZLg6ZS/YCO4C8AeO+s1DYe1G/oc9jk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzu6GGwi+3pppCEg0zxTXFkEQi6CqOj2kP0i
 Yw1YrlLkLGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FUJfD/wOsHEBcEpCyDNgQJJp58wR6PtoKRtA0ZFwKb4I6wyAGH3nQer6Hzf/wHpuzW75Hz0DF2B
 ViYoZwUKCh20Ae7hHgQtB4pL+qcRKbNeC9sAyOnWUCegkf66tr66RZ+8hpYh2xk5qBA4aU7f8/r
 7k1Jy7/dEYe2gX4AuM8p4eBf23g438LQWSM6MWKVV1VYSYjQIL5Hl6RO1FNMjwxXOKCgHk2sKtf
 urxXibgGb0pdxb4hn/8Wq3KuJFpg2hdUE4NJ3S7pLrv/5bpO3jURHaFCZMl8vD1Yt8K7H7rxXwx
 9cEAnpvHafcCLljmu50L+90Jx5mf9tm9VXO5Vr3JFMjdSJocBO32/cv30Ez7Sxd7WZEQA7E5I9K
 N7zcXTGvVFl9+0pQyXwz8y+PznNYkEva8I6qe2iwwgf8/J1HNG7PrCZN25oaUpCpgiQiz3Ir1Lf
 iOJhS6Vv2RMtO/R2qEhLzogWWgS+dzKpFNLN0Wp51xhOqbfPjxBD3XOKZk2avRrXB3Ry8B5GpKo
 SSQzsvq6qiBSGiYCjSN96AnwzXodCyVw5v722mpye66XDRMdtycJN749JWFZsJKy1VCVamrcCrc
 E39rksN7CTbXPNFgl11TzIsNMgehQG1za+hB5tmSmwMpdUM+LKJEtQe9TiVoDCdDWHl5iCyTZA5
 4UIAnEMzddkQeNg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The alternate version without CONFIG_CRC32 should have the argument as
const.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e3722ce6722e..9203b3bb78b3 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -868,7 +868,7 @@ static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 				NFS4_STATEID_OTHER_SIZE);
 }
 #else
-static inline u32 nfs_stateid_hash(nfs4_stateid *stateid)
+static inline u32 nfs_stateid_hash(const nfs4_stateid *stateid)
 {
 	return 0;
 }

-- 
2.44.0


