Return-Path: <linux-fsdevel+bounces-57099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01557B1EA94
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E8CAA108D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04F27FD6E;
	Fri,  8 Aug 2025 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jijpBWK9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EUKWkl4C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jijpBWK9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EUKWkl4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA74280017
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664282; cv=none; b=AApIrYWExvfxnIuTyWNg+onP4XGMNTvB+S5Ijvc4UPZnboADCi3fpOGEDACLgMR7tFyYgdKeAUXeVOfROnDCj0O312VLloikn3T0dTK8ZoBGci1b5Po23bi79oW8EYZvT8FJRMIgeDTxJ2Yg5lmH2eoYSp4UG2xjSVLRx7wzGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664282; c=relaxed/simple;
	bh=gjrGNANIykDfpf7Wf3pIFM8t1nwf+Duna9YIV3lGNBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9qtOiKiJO78q5VRKnLARFmrain3g6p8pt3chVxjuDWHoMv7nE+Xs4zrw/Mv3slJekUt4s5tqmkQq4NXY/EfQPJEclNCeLJKZ4/cqaf0qAzyvBaeU0rpZqKyFDMnUfu/t9i/n6e7H8vyPWe1oVCZt7vxQ3pM24jafbIfTyz+nWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jijpBWK9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EUKWkl4C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jijpBWK9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EUKWkl4C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 020EE5BE4D;
	Fri,  8 Aug 2025 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754664279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weYf+fL75c7lg2yK6WWI7BLtwoQlL2mdPNNPz/8x2L0=;
	b=jijpBWK9QZaQ4JmLM8UecWrbSSTWtPe9+TuGDC+7Fgb45zLKmam6BL0INKhxXCKG5W1d+x
	NsqXfsWVHhvPioHhAkmtH4MKJxdp0G/xi0iykW9x9UsCXHpbe0mqURLnZNaw5ayOR1hNZ7
	oMlqxHSGkulZtkYTCScjayUE7YpAW4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754664279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weYf+fL75c7lg2yK6WWI7BLtwoQlL2mdPNNPz/8x2L0=;
	b=EUKWkl4C1Qip0HfrlkSPnCCtMy9hpzN1TXaymzoFlJV4i+aUPwVbDU8NuNzQw42nJe5CcH
	4MEjAmWkWWCov0AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jijpBWK9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EUKWkl4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754664279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weYf+fL75c7lg2yK6WWI7BLtwoQlL2mdPNNPz/8x2L0=;
	b=jijpBWK9QZaQ4JmLM8UecWrbSSTWtPe9+TuGDC+7Fgb45zLKmam6BL0INKhxXCKG5W1d+x
	NsqXfsWVHhvPioHhAkmtH4MKJxdp0G/xi0iykW9x9UsCXHpbe0mqURLnZNaw5ayOR1hNZ7
	oMlqxHSGkulZtkYTCScjayUE7YpAW4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754664279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weYf+fL75c7lg2yK6WWI7BLtwoQlL2mdPNNPz/8x2L0=;
	b=EUKWkl4C1Qip0HfrlkSPnCCtMy9hpzN1TXaymzoFlJV4i+aUPwVbDU8NuNzQw42nJe5CcH
	4MEjAmWkWWCov0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7815713A7E;
	Fri,  8 Aug 2025 14:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B2v2D1YNlmidOAAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Fri, 08 Aug 2025 14:44:38 +0000
Date: Fri, 8 Aug 2025 11:44:36 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Wang Zhaolong <wangzhaolong@huaweicloud.com>, Stefan Metzmacher <metze@samba.org>, 
	Mina Almasry <almasrymina@google.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 24/31] cifs: Convert SMB2 Negotiate Protocol request
Message-ID: <zt6f2jl6y5wpiuchryc2vdsmtkiia7s5mligm7helffkanxe3o@2f2ksngn5ekk>
References: <20250806203705.2560493-1-dhowells@redhat.com>
 <20250806203705.2560493-25-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250806203705.2560493-25-dhowells@redhat.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 020EE5BE4D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.01

On 08/06, David Howells wrote:
> ...
> 
>-static unsigned int
>-build_netname_ctxt(struct smb2_netname_neg_context *pneg_ctxt, char *hostname)
>+static size_t smb2_size_netname_ctxt(struct TCP_Server_Info *server)
> {
>+	size_t data_len;
>+
>+#if 0
> 	struct nls_table *cp = load_nls_default();
>+	const char *hostname;
>
>-	pneg_ctxt->ContextType = SMB2_NETNAME_NEGOTIATE_CONTEXT_ID;
>+	/* Only include up to first 100 bytes of server name in the NetName
>+	 * field.
>+	 */
>+	cifs_server_lock(pserver);
>+	hostname = pserver->hostname;
>+	if (hostname && hostname[0])
>+		data_len = cifs_size_strtoUTF16(hostname, 100, cp);
>+	cifs_server_unlock(pserver);
>+#else
>+	/* Now, we can't just measure the length of hostname as, unless we hold
>+	 * the lock, it may change under us, so allow maximum space for it.
>+	 */
>+	data_len = 400;
>+#endif
>+	return ALIGN8(sizeof(struct smb2_neg_context) + data_len);
>+}

Why was this commented out?  Your comment implies that you can't hold
the lock anymore there, but I couldn't find out why (with your patches
applied).

>-static void
>-assemble_neg_contexts(struct smb2_negotiate_req *req,
>-		      struct TCP_Server_Info *server, unsigned int *total_len)
>+static size_t smb2_size_neg_contexts(struct TCP_Server_Info *server,
>+				     size_t offset)
> {
>-	unsigned int ctxt_len, neg_context_count;
> 	struct TCP_Server_Info *pserver;
>-	char *pneg_ctxt;
>-	char *hostname;
>-
>-	if (*total_len > 200) {
>-		/* In case length corrupted don't want to overrun smb buffer */
>-		cifs_server_dbg(VFS, "Bad frame length assembling neg contexts\n");
>-		return;
>-	}
>
> 	/*
> 	 * round up total_len of fixed part of SMB3 negotiate request to 8
> 	 * byte boundary before adding negotiate contexts
> 	 */
>-	*total_len = ALIGN8(*total_len);
>+	offset = ALIGN8(offset);
>+	offset += ALIGN8(sizeof(struct smb2_preauth_neg_context));
>+	offset += ALIGN8(sizeof(struct smb2_encryption_neg_context));
>
>-	pneg_ctxt = (*total_len) + (char *)req;
>-	req->NegotiateContextOffset = cpu_to_le32(*total_len);
>+	/*
>+	 * secondary channels don't have the hostname field populated
>+	 * use the hostname field in the primary channel instead
>+	 */
>+	pserver = SERVER_IS_CHAN(server) ? server->primary_server : server;
>+	offset += smb2_size_netname_ctxt(pserver);

If you're keeping data_len=400 above, you could just drop
smb2_size_netname_ctxt() altogether and use
"ALIGN8(sizeof(struct smb2_neg_context) + 400)" directly here.

