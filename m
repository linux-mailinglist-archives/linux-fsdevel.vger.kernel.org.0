Return-Path: <linux-fsdevel+bounces-14512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293CA87D247
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2111F2200F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 17:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B64EB22;
	Fri, 15 Mar 2024 16:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk+BlFs/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6745FBB8;
	Fri, 15 Mar 2024 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521664; cv=none; b=AvNcAEhHh5sQ/HsvNoqB5boBaSqCUExkS0ICuGsJbN4l7dOJo/kT7VNCrCeFjSbnyppfyEKWIN9PTMB3vN5ZvDhnsam55ffg/fJKAK41XoKNTfLbtHTcoSHuFijy0WYghxzv3waOGiyMwgYE4utSIBMSuiHWbPVhN4sWn8KG1jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521664; c=relaxed/simple;
	bh=StkPzzZHH/6sgQn/lGKnzt3PeV9NBoE/z0Ovl4GDfww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aH6OrAZik8HVA9aMovi+Q2SMgnz2+eCpORSl8T247mpwbDMVwCUijTzIH40LWeU2/NrGi/QVPJ5u4GcTbqRQi8RB6I01doJW+TBtgMdlyz8PiSQjDIOyN/YVV4zwahmirU2q/gTjxjtHPfn7h0Gml+vQKW8+P/Y92RXMQYSWNec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk+BlFs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62B1C43399;
	Fri, 15 Mar 2024 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710521663;
	bh=StkPzzZHH/6sgQn/lGKnzt3PeV9NBoE/z0Ovl4GDfww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hk+BlFs/46YBuOmmaTEQkfxTZxnnerqXEMm+Xem5ye8UtB1tdpiAgNHDunBA5g8tX
	 xMzHDC9pxO+cN0tsSjEOtLC3r2u2fOrpfR3BYWwTpSMsoHzRwugShAWfxFYIwL4Fbx
	 2PwC/PmPU64fqM+r7W80cE/1eGlC/TIHqNIqWUPvZZSzZTV7h8E+3aAhSATMKmKuY7
	 wmQ9jnP3Cl6opaoLow/Zv4v41dm5J8jCjlvPyIZPfeTxuvf5gKTg3t7kNaVAX0uAuz
	 hcxDc2EFXKgXFYR6VWLS7koCod9Ycxe5HjaeSXVIiLL7MD6RtP5ZycJ702c2x57eZe
	 fcwaUwmp3t4Zg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 15 Mar 2024 12:53:15 -0400
Subject: [PATCH RFC 24/24] nfs: add a module parameter to disable directory
 delegations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-dir-deleg-v1-24-a1d6209a3654@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=StkPzzZHH/6sgQn/lGKnzt3PeV9NBoE/z0Ovl4GDfww=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBl9Hzvnm7j0meGlRrWzgXFZfUMFw6VkWwUuEoG4
 wZ3oi+xA5mJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZfR87wAKCRAADmhBGVaC
 FUYcEADP07H5ISVCANeNprhNf4hZQPgKVBg3xSg77ohhLcb2ru884PWGa4XdW65vfN4NAIfhart
 wRbEXNPv6moeTSg5QUn86pEHa1UCSx0Jo4c+ZXmTqlBTHiHCoPs9UoC0+lKIbgA2+WqQnhruNSw
 ExBSumhHvhDtKfJrDuiPX9Y1+2EGIZ6n3l1zFv4Gvfw4Wp63Ta2lHLgLdXTlfT11hacg0bflVfG
 DYCn3WrpI/jXOYWyIxSv1iVDUMGP61SuF8OAkB90fImIl8yVQM8g1Swz42Qmq1BJIorWlnxBMO/
 SYG38TiIL46dL5C7etD+9kZZlfHRQLFaAnzimJpq9AOhIzC2C1OlTzCyCpkip1Uh+BK2iDlSksh
 PHb4oUnakFjG/tJ4yQI+gMsd0/x3W7pQcLpe+Gghd3RyMxw7v06ZcKVb6DzhwFO7y/Le1Bxv/uh
 igvya5ZrOiRtyD7v4gUx2ICKDQIZrVbbJXTVsWAzthXQBsPbS8d/v9Cwtgpf+68HMuVWv9trceB
 rlfKd7jv+5ciGtBQc7Nj1/quh7QD5GOIFOncB8nPcyNnmc87y6kxn1tJA59WV/XFIFHMq+pWCp7
 j5huGMP0IVakAbwQdmjqnx4kQO5aZ8T0DC2Rd82lm8TaqCgRrXuJnlQB7oTw4ept4UypzTsCxwU
 Zmx1EZYZozo7PFg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

For testing purposes, add a module parameter that will prevent the
client from requesting further directory delegations.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/nfs4proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3dbe9a18c9be..a85a594cad88 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4318,8 +4318,14 @@ static int nfs4_get_referral(struct rpc_clnt *client, struct inode *dir,
 	return status;
 }
 
+static bool nfs_dir_delegation_enabled = true;
+module_param(nfs_dir_delegation_enabled, bool, 0644);
+MODULE_PARM_DESC(nfs_dir_delegation_enabled, "Enable directory delegations?");
+
 static bool should_request_dir_deleg(struct inode *inode)
 {
+	if (!nfs_dir_delegation_enabled)
+		return false;
 	if (!inode)
 		return false;
 	if (!S_ISDIR(inode->i_mode))

-- 
2.44.0


