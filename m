Return-Path: <linux-fsdevel+bounces-14504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6587D208
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51315B23AA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32F5D8F2;
	Fri, 15 Mar 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO5E64OF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6A5D74A;
	Fri, 15 Mar 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521638; cv=none; b=pM0EzXUNQ4bIebjzj45kYj6Snro0GdZg8ToXf2U1gK2FyaMsZgVdUzRt8kePAxUBl3Llq8buaHxtIfoqOopkxFmRCwPKZf/eoid3LZ88JNbYzyIKX6z7/BrEz90Lnuz0/jLrIc/Ukl9gCA/2+FElVA3WD/ZJaZ+8XQ8vWg50ckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521638; c=relaxed/simple;
	bh=P09PKo+whz8zrLueysD1j/ntdbO/a/jX/vfqgwpWye4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+h0iYqtLgJ39dosk5NY21/nyDKUEFauflKrkMh3LzFmX1HXzrBfKh6vQm6r7OBa7w9i/r6ClnOBGgRBm44ZVkkwcd3RFUxb7whI1oVq7hKNpikivHc4b0EEpSQ1vqLg/WVeWl5DqpAhh0ll8BDMD38C57rkrwHu7Br/NvywK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO5E64OF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFDDC43394;
	Fri, 15 Mar 2024 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521638;
	bh=P09PKo+whz8zrLueysD1j/ntdbO/a/jX/vfqgwpWye4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pO5E64OF9eWs53Lx4dQ210ryMhYJEUxDCICazhfEN4JyO6jiNtXbcrfUR+bOAptNE
	 c2lvK7YQE7i/BsS5l+Y4oeknY+3ek8gB7XotCZgiZV7XWlKmLzdc8Wu42l4bY4Md6c
	 lJdCI9jeWITyOvoALl1ZInjyo7zObPSwgSSBEeAfoMiXi++nMqE838TT+cBoaEaIhV
	 yFjyfhqWCr/7q3J+Yd5zHSe6NXfDqr3AUSytPdU9bAfAAV6uo3dlFL8a92ujP/T+4E
	 qtdVkaEbIVlEdo17BaXVy5duvtqNGVraePVRgLBZfU10il2qC7iucXARTbWAiSiKIH
	 jl1n6MJ//rCCQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:07 -0400
Subject: [PATCH RFC 16/24] nfs: remove unused NFS_CALL macro
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-16-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P09PKo+whz8zrLueysD1j/ntdbO/a/jX/vfqgwpWye4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9HzuV4GxWMKhi5EkvV/w/bQyxolJkrNEc3E61
 tLkk1OxdAeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87gAKCRAADmhBGVaC
 FSnZD/9KD+nv25bgMB3Htqx3wHiC2z6De4pIniEkhzlXQTfIHtsacWj7beBSTVjNys4sEsAyPId
 fQD6pjGjKh7qh6MMNeySTeTcgmBdDpz1ajU3MTGM/NxzG7ACRppdSuFBeZRixNDaJSOdFZ/i8tZ
 Il71BpSuE24Fs6S/p4K9h6xMcuiFH7CklYBi+VntZ/SHbVxKy/2s9LlhE5ZDBReKFDkQkFRAe+g
 egZx1PFw4I35meRubEt+4TvQZcIMOzkJp/Xuol7aoRAA2dPUYSqGxRIWlqg1VyQn6SIeYu0qkbk
 4VZu2N8nGCSoj2yg3XHr7bS2zL5dDsP+cZxXzQHpi/vg+K5uhrdJDaucuZosQqY/zcjluQfnctS
 1CD6i0Nz29PBaiTfI5nbxDv7zyzAtZ9q5Jn5LixRPfCMU5FFKcEzPW5qXv8sDGfd33rzYqcI1sD
 nZ2CiEB5Q1b5oqEA+95nxws/2kxi45yQYinUcOfFwF5xVdGW57SzFRjTv0bkezdyzL6kgEHnxzD
 mVPidjI0jJ+EizqMZ2MIepURlJKIB2HNZHZO1ktdBqkzUFiRRfrNIkOWYKqaMuXR8zXOIE2yJKo
 6lsEYhdirnjH+xETbDikyv7IzCzn09RbN2BVADNuLdWeJAqR0+JDNjjir1FGLuM4JYgWptMX822
 +5jGlQ/VG31XYkA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Nothing uses this, and thank goodness as the syntax is horrid.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/nfs_xdr.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 539b57fbf3ce..d09b9773b20c 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1820,13 +1820,6 @@ struct nfs_rpc_ops {
 	void	(*disable_swap)(struct inode *inode);
 };
 
-/*
- * 	NFS_CALL(getattr, inode, (fattr));
- * into
- *	NFS_PROTO(inode)->getattr(fattr);
- */
-#define NFS_CALL(op, inode, args)	NFS_PROTO(inode)->op args
-
 /*
  * Function vectors etc. for the NFS client
  */

-- 
2.44.0


