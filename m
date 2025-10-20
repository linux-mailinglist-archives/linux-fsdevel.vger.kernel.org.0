Return-Path: <linux-fsdevel+bounces-64705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 017CDBF1919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 15:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DD3C4F5710
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 13:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9D3191D3;
	Mon, 20 Oct 2025 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S3mOaGB0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rsFaY7CX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dWa3K2mp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B++jNjrE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4177E2571A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967538; cv=none; b=gG84j0/ESgTudg5E5IZ9wbA+SBntMKMDaH7Ouh6kiUEfIFY7N1bpTch0DEyyYM9s0KrfL3pfVmnHVc00S2y9kTuPHZKJqS08QyKkbzQD3lmVwXsTU6UCCEic/DzthALjhA72C0Nkrwj0yhkTW0m4SkZrqmmAR/AzNhA0snuJTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967538; c=relaxed/simple;
	bh=9wQ2bND1mPIM6ed87fe7TH8lrL7VZNaGcj1Do/D1NgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgtIp2AoMvlynwg0kZAPwWg24yjksRTg9HuEBxCl2Kr8L1lwBY7OyMuPmjumG7JrptXG30Nc35+Lul7FMTrh4LMcDXaG7Ko7U811YGH7yWMf/vbudAL42tVkCZH5dreN6zCdIkfq8Bmx7jU4hof0BwncabxAs/Yh+etUTMLySQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S3mOaGB0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rsFaY7CX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dWa3K2mp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B++jNjrE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51AC62117C;
	Mon, 20 Oct 2025 13:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760967529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/UVD2xs0kDh9chtUCmfxdpnmbvjWHUT1V9m6yQzLO4=;
	b=S3mOaGB0jNO4C0J0XRF5qVzVHjCFjIiI/nmm1BCQ8d1G6cIi6MbrKAQ/VIyFC/4OzD3Wb9
	poIpHkReq6Um2MFhHM1H8B6cZgv42u3l2GMME3XeZFbOw8/XyAOTxwCKdbW7pU/zcWZAnj
	CehRbGGlnbg8Jwi5It3ZWvH6WAIi2HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760967529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/UVD2xs0kDh9chtUCmfxdpnmbvjWHUT1V9m6yQzLO4=;
	b=rsFaY7CXoyArNv+KymKvCp4BHUDuzfre1A0Rp8tQFoJj7bCcgyzZgEGITwzTsXYmfCIXdK
	BT2r8zkZb5LuLBAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dWa3K2mp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B++jNjrE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760967525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/UVD2xs0kDh9chtUCmfxdpnmbvjWHUT1V9m6yQzLO4=;
	b=dWa3K2mpxO3qeBG/SxmVBHg79iHpPabFnHMOR7wY+R7pACNeu/3qtTcFzRDlcK9WH3XvBN
	UCKBGvxV4JKmThVwu09IWaAtONgMgov5izDR3LuiEjjGqQCa4Kh/Z8BKfQoWG5mKDqMvmM
	JQs+ougGIcbc3v/mm34YTRQ7s4JMg0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760967525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N/UVD2xs0kDh9chtUCmfxdpnmbvjWHUT1V9m6yQzLO4=;
	b=B++jNjrEq2csaT1voFzTlIL4Ch5NzKgfvgbXR1w+x1DKsVwBnsAr6KD2T42r+hcUPSGhzf
	COQ+LOhmrQNYm6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D377D13AAC;
	Mon, 20 Oct 2025 13:38:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9j5RJmQ79mhFcgAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Mon, 20 Oct 2025 13:38:44 +0000
Date: Mon, 20 Oct 2025 10:38:42 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Call the calc_signature functions directly
Message-ID: <jf5k4w47cw3jhc3nfmhwtaqtqxrqd5ufg4agpagacbxejyuhb7@udi3ed54kf3m>
References: <1090391.1760961375@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1090391.1760961375@warthog.procyon.org.uk>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 51AC62117C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

Hi David,

On 10/20, David Howells wrote:
>As the SMB1 and SMB2/3 calc_signature functions are called from separate
>sign and verify paths, just call them directly rather than using a function
>pointer.  The SMB3 calc_signature then jumps to the SMB2 variant if
>necessary.
>
>Signed-off-by: David Howells <dhowells@redhat.com>
>cc: Steve French <sfrench@samba.org>
>cc: Paulo Alcantara <pc@manguebit.org>
>cc: linux-cifs@vger.kernel.org
>cc: linux-fsdevel@vger.kernel.org
>---
> fs/smb/client/cifsglob.h      |    2 --
> fs/smb/client/smb2ops.c       |    4 ----
> fs/smb/client/smb2proto.h     |    6 ------
> fs/smb/client/smb2transport.c |   18 +++++++++---------
> 4 files changed, 9 insertions(+), 21 deletions(-)
>
>diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
>index b91397dbb6aa..7297f0f01cb3 100644
>--- a/fs/smb/client/cifsglob.h
>+++ b/fs/smb/client/cifsglob.h
>@@ -536,8 +536,6 @@ struct smb_version_operations {
> 	void (*new_lease_key)(struct cifs_fid *);
> 	int (*generate_signingkey)(struct cifs_ses *ses,
> 				   struct TCP_Server_Info *server);
>-	int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *,
>-				bool allocate_crypto);
> 	int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
> 			     struct cifsFileInfo *src_file);
> 	int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *tcon,
>diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
>index 7c392cf5940b..66eee3440df6 100644
>--- a/fs/smb/client/smb2ops.c
>+++ b/fs/smb/client/smb2ops.c
>@@ -5446,7 +5446,6 @@ struct smb_version_operations smb20_operations = {
> 	.get_lease_key = smb2_get_lease_key,
> 	.set_lease_key = smb2_set_lease_key,
> 	.new_lease_key = smb2_new_lease_key,
>-	.calc_signature = smb2_calc_signature,
> 	.is_read_op = smb2_is_read_op,
> 	.set_oplock_level = smb2_set_oplock_level,
> 	.create_lease_buf = smb2_create_lease_buf,
>@@ -5550,7 +5549,6 @@ struct smb_version_operations smb21_operations = {
> 	.get_lease_key = smb2_get_lease_key,
> 	.set_lease_key = smb2_set_lease_key,
> 	.new_lease_key = smb2_new_lease_key,
>-	.calc_signature = smb2_calc_signature,
> 	.is_read_op = smb21_is_read_op,
> 	.set_oplock_level = smb21_set_oplock_level,
> 	.create_lease_buf = smb2_create_lease_buf,
>@@ -5660,7 +5658,6 @@ struct smb_version_operations smb30_operations = {
> 	.set_lease_key = smb2_set_lease_key,
> 	.new_lease_key = smb2_new_lease_key,
> 	.generate_signingkey = generate_smb30signingkey,
>-	.calc_signature = smb3_calc_signature,
> 	.set_integrity  = smb3_set_integrity,
> 	.is_read_op = smb21_is_read_op,
> 	.set_oplock_level = smb3_set_oplock_level,
>@@ -5777,7 +5774,6 @@ struct smb_version_operations smb311_operations = {
> 	.set_lease_key = smb2_set_lease_key,
> 	.new_lease_key = smb2_new_lease_key,
> 	.generate_signingkey = generate_smb311signingkey,
>-	.calc_signature = smb3_calc_signature,
> 	.set_integrity  = smb3_set_integrity,
> 	.is_read_op = smb21_is_read_op,
> 	.set_oplock_level = smb3_set_oplock_level,
>diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
>index b3f1398c9f79..7e98fbe7bf33 100644
>--- a/fs/smb/client/smb2proto.h
>+++ b/fs/smb/client/smb2proto.h
>@@ -39,12 +39,6 @@ extern struct mid_q_entry *smb2_setup_async_request(
> 			struct TCP_Server_Info *server, struct smb_rqst *rqst);
> extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *server,
> 						__u64 ses_id, __u32  tid);
>-extern int smb2_calc_signature(struct smb_rqst *rqst,
>-				struct TCP_Server_Info *server,
>-				bool allocate_crypto);
>-extern int smb3_calc_signature(struct smb_rqst *rqst,
>-				struct TCP_Server_Info *server,
>-				bool allocate_crypto);
> extern void smb2_echo_request(struct work_struct *work);
> extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
> extern bool smb2_is_valid_oplock_break(char *buffer,
>diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
>index 33f33013b392..916c131d763d 100644
>--- a/fs/smb/client/smb2transport.c
>+++ b/fs/smb/client/smb2transport.c
>@@ -247,9 +247,9 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, __u64 ses_id, __u32  tid)
> 	return tcon;
> }
>
>-int
>+static int
> smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
>-			bool allocate_crypto)
>+		    bool allocate_crypto)
> {
> 	int rc;
> 	unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
>@@ -576,9 +576,9 @@ generate_smb311signingkey(struct cifs_ses *ses,
> 	return generate_smb3signingkey(ses, server, &triplet);
> }
>
>-int
>+static int
> smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
>-			bool allocate_crypto)
>+		    bool allocate_crypto)
> {
> 	int rc;
> 	unsigned char smb3_signature[SMB2_CMACAES_SIZE];
>@@ -589,6 +589,9 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
> 	struct smb_rqst drqst;
> 	u8 key[SMB3_SIGN_KEY_SIZE];
>
>+	if ((server->vals->protocol_id & 0xf00) == 0x200)

Please use:

   if (server->vals->protocol_id <= SMB21_PROT_ID)

Other than that

Acked-by: Enzo Matsumiya <ematsumiya@suse.de>

>+		return smb2_calc_signature(rqst, server, allocate_crypto);
>+
> 	rc = smb3_get_sign_key(le64_to_cpu(shdr->SessionId), server, key);
> 	if (unlikely(rc)) {
> 		cifs_server_dbg(FYI, "%s: Could not get signing key\n", __func__);
>@@ -657,7 +660,6 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
> static int
> smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
> {
>-	int rc = 0;
> 	struct smb2_hdr *shdr;
> 	struct smb2_sess_setup_req *ssr;
> 	bool is_binding;
>@@ -684,9 +686,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
> 		return 0;
> 	}
>
>-	rc = server->ops->calc_signature(rqst, server, false);
>-
>-	return rc;
>+	return smb3_calc_signature(rqst, server, false);
> }
>
> int
>@@ -722,7 +722,7 @@ smb2_verify_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server)
>
> 	memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
>
>-	rc = server->ops->calc_signature(rqst, server, true);
>+	rc = smb3_calc_signature(rqst, server, true);
>
> 	if (rc)
> 		return rc;
>
>

