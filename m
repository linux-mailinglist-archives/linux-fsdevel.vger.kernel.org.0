Return-Path: <linux-fsdevel+bounces-57096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE146B1EA46
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B2418C76F1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4427EFEF;
	Fri,  8 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BY+UU3kV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EUpApfVD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BY+UU3kV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EUpApfVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B64274651
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662906; cv=none; b=g6e2Q/L+0Oj8XEOJTareQkqxhRIWhebUhUACdYv6SNyyxxh5o0AwWZfjtUpMWerGucAx1u0SC4dxzB8IprpKZl6D8PL9liaW1fb6GRBw/qLNxnWeEhfsI5JmqFph4LrcaMgb6XYT4RfNT+l/rZKNpXSOy7ZbB3JXrXjTgy30LWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662906; c=relaxed/simple;
	bh=0t3BvGcnRP9QJqdv5w8A+HaS5U6+B1FN9wSXpLnAjak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PXyqBnnBnx0plzN3VKEvExuJvU9rZ647l6TEcKPKwAsvYmp8+SK7AlM2uZmJ5CAoXot0nDe6bgNTMdpgcpEXU2ouzwDX+wRzpJgjUtph4KuxsZ/fqvIClHcei4PxEvx9A+R4Xlm2rdz5TRMKXMmoae48Wr43TpbhQu1SvRejQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BY+UU3kV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EUpApfVD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BY+UU3kV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EUpApfVD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6187E1FF32;
	Fri,  8 Aug 2025 14:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754662902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sSFUKGhQ+gyTPraQB4FRQriyGlejlb3t0+1bXFjxIY=;
	b=BY+UU3kVIgO7P9q4yTVIoTNja5pqUl5hFuAwaOzBDMYJDf1jOjM3ixrkVfBqkGjLmMCuZg
	BZFBg2xDf7oOBSoxcwe8duRlnsU9xQpc6mLILiy9iu3x0WlPqFHXVSoIaN3E4dsP6BSHB5
	9FI8/L7uu9KcKXUAulzOCZbgs5WhEF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754662902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sSFUKGhQ+gyTPraQB4FRQriyGlejlb3t0+1bXFjxIY=;
	b=EUpApfVDIddVVXGI9R2wexUUO38wq13gViWDN/oCMJzr8dce3ZWA1Eqrt7HLCezr330sXq
	Sn7PL7h5AeCC7ZDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BY+UU3kV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EUpApfVD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754662902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sSFUKGhQ+gyTPraQB4FRQriyGlejlb3t0+1bXFjxIY=;
	b=BY+UU3kVIgO7P9q4yTVIoTNja5pqUl5hFuAwaOzBDMYJDf1jOjM3ixrkVfBqkGjLmMCuZg
	BZFBg2xDf7oOBSoxcwe8duRlnsU9xQpc6mLILiy9iu3x0WlPqFHXVSoIaN3E4dsP6BSHB5
	9FI8/L7uu9KcKXUAulzOCZbgs5WhEF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754662902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4sSFUKGhQ+gyTPraQB4FRQriyGlejlb3t0+1bXFjxIY=;
	b=EUpApfVDIddVVXGI9R2wexUUO38wq13gViWDN/oCMJzr8dce3ZWA1Eqrt7HLCezr330sXq
	Sn7PL7h5AeCC7ZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9E311392A;
	Fri,  8 Aug 2025 14:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CbPlJvUHlmilMgAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Fri, 08 Aug 2025 14:21:41 +0000
Date: Fri, 8 Aug 2025 11:21:39 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Wang Zhaolong <wangzhaolong@huaweicloud.com>, Stefan Metzmacher <metze@samba.org>, 
	Mina Almasry <almasrymina@google.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 18/31] cifs: Pass smb_message structs down into the
 transport layer
Message-ID: <szoca3d62awqbjdc7mwxkckhqpqumpkznyaomfq6ol34ib3eew@hejb2zgnxctn>
References: <20250806203705.2560493-1-dhowells@redhat.com>
 <20250806203705.2560493-19-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250806203705.2560493-19-dhowells@redhat.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6187E1FF32
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.01

Hi David,

On 08/06, David Howells wrote:
> ...
> 
> static int
>-receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
>+receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **mid,
> 		       int *num_mids)
> {
>+	WARN_ON_ONCE(1);
>+	return -ENOANO; // TODO
>+#if 0
> 	char *buf = server->smallbuf;
> 	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
> 	struct iov_iter iter;
>@@ -4753,8 +4758,8 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
> 	dw->server = server;
>
> 	*num_mids = 1;
>-	len = min_t(unsigned int, buflen, server->vals->read_rsp_size +
>-		sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
>+	len = umin(buflen, server->vals->read_rsp_size +
>+		   sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
>
> 	rc = cifs_read_from_socket(server, buf + HEADER_SIZE(server) - 1, len);
> 	if (rc < 0)
>@@ -4836,6 +4841,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct smb_message **smb,
> discard_data:
> 	cifs_discard_remaining_data(server);
> 	goto free_pages;
>+#endif
> }

I don't quite get why this was commented out (and also seems unrelated
to patch subject).

What problems did you have here?  Does it not work?

