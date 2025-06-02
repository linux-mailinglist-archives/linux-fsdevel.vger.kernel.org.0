Return-Path: <linux-fsdevel+bounces-50358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B9ACB123
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 16:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2182C3A5A89
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0910241686;
	Mon,  2 Jun 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4O0muln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FDF2405FD;
	Mon,  2 Jun 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873002; cv=none; b=TIoc6I/ZzqkYEKwje6n3Cz1wbi7ayECZmVejbztFer6fZFwy4cJJIcevudxMdr248sGx6bj9gH16sXsXJavgTOA7uQMbtkI70oTwJEf8LJZK3GPTKarBRbXyzlb45s5XsSQeUoWqRlRo11Cn8/xghapa0smATkGgNkvHMOvEer4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873002; c=relaxed/simple;
	bh=WRTUFe5zAa4ehyUDpuZU2A396vCsORsejbqIXvfw4eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nb4VGUEJAOHQsg0VsNjeVJzcSPxpOMThnFWWyHJPBYLXv0wejvSm86t9Qig5FEpSPbY0i2Ddx2eYsMUPzS9h61h+o+TV04cVaV8MUVcz+wlIj1ZGvExfvk8A5auFY3hl9bmHLtdG0uyr+DsxbinAAHR9BtfEGn7t8TedRlu/Rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4O0muln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54F5C4CEF6;
	Mon,  2 Jun 2025 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748873001;
	bh=WRTUFe5zAa4ehyUDpuZU2A396vCsORsejbqIXvfw4eM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d4O0mulna5zpsC6abaqW7ZzC6op2McHxHnBQVPqnQwhFOlxMsWRGVVWKLUXcf8a9c
	 ohFTvdxrxc7Mw85ldB9a5qQBhmlJxwyhnI3A2zQS2IwOxh1AqxlItPsdXlfHF9ulzu
	 yZjj/k8bPLr0m9dlKgzUOFoIHWUg7nPX5mPdQam6R5qUbEsyJjbdzRH7Kd5fCmDO1g
	 ImOxd8OSI1VJKt5JelTrmpxO82lN+wO7Ddskf308gJgCtkZWMUf40TMHO5LBvSdWXa
	 n88yEb3aCDXEDuEH26sbPdu8rmrtCoVVIHmhmaMURopXs2VOEuq283oc1xJH5V32Yj
	 8ardsieZOx80w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 02 Jun 2025 10:02:11 -0400
Subject: [PATCH RFC v2 28/28] nfsd: add support for NOTIFY4_RENAME_ENTRY
 events
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-dir-deleg-v2-28-a7919700de86@kernel.org>
References: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
In-Reply-To: <20250602-dir-deleg-v2-0-a7919700de86@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
 Bharath SM <bharathsm@microsoft.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Jonathan Corbet <corbet@lwn.net>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 samba-technical@lists.samba.org, linux-doc@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2877; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WRTUFe5zAa4ehyUDpuZU2A396vCsORsejbqIXvfw4eM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPa7rYWh5WPyBqmd/mpYouoAaeCmO7iYpghNrL
 2FZXSv49syJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD2u6wAKCRAADmhBGVaC
 FRLAD/9Nrz7K/6BZh3J7GzB7TSD3Iu8DHCsSAkiig2bJ4KYuyJdr/v9vr7B1pSdCR+UN7OFPToX
 Cm6Lbv3HaVp1569JJ5aYfDQoaZhxDg0IQIajjWvorce9w+r9GbvoOvWAAe5BWBJugD1asZSxQqI
 wiB9z2fvE0r2MQwvvooV7GfDANY0anAIEkbYzEWIN4fecGqDWn9Frk/3sichSwRgrrOQuYz+o5d
 zVb+QPivMvVfFmkfe9v8NbGkSFuB40v84Ab3uWvui0QTRbag79oAdWGoo+EYsACgW8fPGxMiPad
 byakNt0nXAuGnwBKf8zV3emFCUt/PcIcK7soVpY1b5UAXn7lJ2Rn3TKIORKcLJEtIZwXmRxG78a
 WzbYtyBOGJie63ytKV43ixhN0S8UghXP0Spi7OB2nn7NxwqjT3E52Cb23yNABtf4fbkVKqd0aMm
 GEnYGTeTvDnC6gzAOYqd0lBVRwPURcrqbWe1kKqJ8fqTjRjJNTJQYtpEyKGWwGrsdpYMtG0AaFj
 QxE+AnC27WCcQlSJ6dk00isFmg8Sl9aFtZ/anoVk75oIoztNAr+3gbhRNzEs/XNEQV5iIfwWD07
 P4nOoepshUDmBrvKd/rsdpJLAH/J8sdZqByh/vnJfaGnhpB5RhXUSakmBErmo95bsnfmRExVT1j
 IS0rm0gaUtKGXmA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add support for RENAME events. Marshal the event into the notifylist4
buffer and kick the callback handler.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  |  2 +-
 fs/nfsd/nfs4state.c | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index a2996343fa0db33e014731f62aaa4e7c72506a76..4573c0651aa49df6089bcc4e5d40f45d46b1c499 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2292,7 +2292,7 @@ nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status == nfserr_same ? nfs_ok : status;
 }
 
-#define SUPPORTED_NOTIFY_MASK BIT(NOTIFY4_REMOVE_ENTRY|NOTIFY4_ADD_ENTRY)
+#define SUPPORTED_NOTIFY_MASK BIT(NOTIFY4_REMOVE_ENTRY|NOTIFY4_ADD_ENTRY|NOTIFY4_RENAME_ENTRY)
 
 static __be32
 nfsd4_get_dir_delegation(struct svc_rqst *rqstp,
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9dc607e355d5839d80946d4983205c15ece6a71e..6333e95c075259af0c160eb130149c776e55f5a8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9722,6 +9722,45 @@ nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
 			ent->notify_vals.data = p;
 			++nns->nns_idx;
 		}
+		if (mask & FS_RENAME) {
+			struct dentry *new_dentry = fsnotify_data_dentry(data, data_type);
+			static uint32_t notify_rename_bitmap = BIT(NOTIFY4_RENAME_ENTRY);
+			struct notify4 *ent = &nns->nns_ent[nns->nns_idx];
+			struct notify_rename4 nr = { };
+			u8 *p = (u8 *)(stream->p);
+			struct name_snapshot n;
+			bool ret;
+
+			if (!(flc->flc_flags & FL_IGN_DIR_RENAME))
+				continue;
+
+			/* FIXME: warn? */
+			if (!new_dentry)
+				continue;
+
+			nr.nrn_old_entry.nrm_old_entry.ne_file.len = name->len;
+			nr.nrn_old_entry.nrm_old_entry.ne_file.data = (char *)name->name;
+			nr.nrn_old_entry.nrm_old_entry.ne_attrs.attrmask.count = 1;
+			nr.nrn_old_entry.nrm_old_entry.ne_attrs.attrmask.element = &zerobm;
+			take_dentry_name_snapshot(&n, new_dentry);
+			nr.nrn_new_entry.nad_new_entry.ne_file.len = n.name.len;
+			nr.nrn_new_entry.nad_new_entry.ne_file.data = (char *)n.name.name;
+			nr.nrn_new_entry.nad_new_entry.ne_attrs.attrmask.count = 1;
+			nr.nrn_new_entry.nad_new_entry.ne_attrs.attrmask.element = &zerobm;
+			ret = xdrgen_encode_notify_rename4(stream, &nr);
+			release_dentry_name_snapshot(&n);
+			if (!ret) {
+				pr_warn("nfsd: unable to marshal notify_rename4 to xdr stream\n");
+				continue;
+			}
+
+			/* grab a notify4 in the buffer and set it up */
+			ent->notify_mask.count = 1;
+			ent->notify_mask.element = &notify_rename_bitmap;
+			ent->notify_vals.len = (u8 *)stream->p - p;
+			ent->notify_vals.data = p;
+			++nns->nns_idx;
+		}
 
 		if (nns->nns_idx)
 			nfsd4_run_cb_notify(ncn);

-- 
2.49.0


