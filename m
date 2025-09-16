Return-Path: <linux-fsdevel+bounces-61799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C75FB59F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 19:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B46C4E4F4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 17:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4C6246BB7;
	Tue, 16 Sep 2025 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pvFHTJTJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7f+V+D0R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pvFHTJTJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7f+V+D0R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918C26E6F4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043774; cv=none; b=byyd2UFvaBIPU0+OkxFBC+dufmRRoBLkE49t9haVO+fz+SZQ1zPRH71ZigTooEG19sucjnwj6UQ8zwVr6BQDx0nED7VHmBlDKbk/l3BGA/S3kaX4ikh7IaBBbGoGJbPawECqRXGux/aztfIJonFH6FUIqxUxgM/6PHOkv+4pIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043774; c=relaxed/simple;
	bh=DUhd/YyCaZGHc5TlXFroXO7WR7cEGAD5ivioK4Rd+nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXGMJAwdRyi3HkGlMD8bt7IoXKBNN1IYMMnjo7kXsh+LsYba6uHRkPY1mgPAPcySHEhClHG6GgIMNaVSqxFMmr/qlK9x2vG6qKUGS4aPUNPzJYYvVDEB/6O+sXkhcDiIa/Kqg3Kje6DOK6vHGIwIoALFoSj/b4x9GtsJ/AZsAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pvFHTJTJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7f+V+D0R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pvFHTJTJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7f+V+D0R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2204A22678;
	Tue, 16 Sep 2025 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758043769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQZUiiOKNAqUAvMt6unAWfm+QcDfr4cjlxIZGHRV7Cc=;
	b=pvFHTJTJD1T1aKajBJwY0aV0B4a0qABOR5Tl4CEJQdx8AiiGZaGTCOxaXLnAIFJOOw8HgY
	EjYgCob2tMN3MPhjsOBLNnZp16TderOBQKQ6RoptO9S7RwokQFoaa9uVGQuqC6gfsGKgO7
	jTKf+BHC6qDrL7kOq4BHHJDWobcFv7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758043769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQZUiiOKNAqUAvMt6unAWfm+QcDfr4cjlxIZGHRV7Cc=;
	b=7f+V+D0REjxwrKGdY9trehSQU3sWApzaoCa91hl9MDtOwlzoZoEA1Pk+JV+QbC58HGQ/Ty
	lRjlXLli4wYDuvAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pvFHTJTJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7f+V+D0R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758043769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQZUiiOKNAqUAvMt6unAWfm+QcDfr4cjlxIZGHRV7Cc=;
	b=pvFHTJTJD1T1aKajBJwY0aV0B4a0qABOR5Tl4CEJQdx8AiiGZaGTCOxaXLnAIFJOOw8HgY
	EjYgCob2tMN3MPhjsOBLNnZp16TderOBQKQ6RoptO9S7RwokQFoaa9uVGQuqC6gfsGKgO7
	jTKf+BHC6qDrL7kOq4BHHJDWobcFv7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758043769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eQZUiiOKNAqUAvMt6unAWfm+QcDfr4cjlxIZGHRV7Cc=;
	b=7f+V+D0REjxwrKGdY9trehSQU3sWApzaoCa91hl9MDtOwlzoZoEA1Pk+JV+QbC58HGQ/Ty
	lRjlXLli4wYDuvAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A17DE139CB;
	Tue, 16 Sep 2025 17:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OHYNGnieyWjvAQAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Tue, 16 Sep 2025 17:29:28 +0000
Date: Tue, 16 Sep 2025 14:29:18 -0300
From: Enzo Matsumiya <ematsumiya@suse.de>
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix oops due to uninitialised variable
Message-ID: <vmavmpfosqg2fiwc3z4x53c64ueoocd2p43u2k2bkktcinr3xz@htqyifxcrsah>
References: <1977959.1755617256@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1977959.1755617256@warthog.procyon.org.uk>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2204A22678
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
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
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

Hi David, Steve,

On 08/19, David Howells wrote:
>Fix smb3_init_transform_rq() to initialise buffer to NULL before calling
>netfs_alloc_folioq_buffer() as netfs assumes it can append to the buffer it
>is given.  Setting it to NULL means it should start a fresh buffer, but the
>value is currently undefined.

This patch was based on David's RFC series
"netfs: [WIP] Allow the use of MSG_SPLICE_PAGES and use netmem
allocator", specifically patch 15/31 "cifs: Use
netfs_alloc/free_folioq_buffer()", which were never merged.

Current code in smb3_init_transform_rq() initializes buffer with
cifs_alloc_folioq_buffer() and NULL-checked right after:

> ...
>                 struct folio_queue *buffer;
>                 size_t size = iov_iter_count(&old->rq_iter);
> 
>                 orig_len += smb_rqst_len(server, old);
>                 new->rq_iov = old->rq_iov;
>                 new->rq_nvec = old->rq_nvec;
> 
>                 if (size > 0) {
>                         buffer = cifs_alloc_folioq_buffer(size);
>                         if (!buffer)
>                                 goto err_free;
> ...

Sorry not catching this earlier, but this just got my attention because
there's now a CVE for this non-bug/vulnerability
https://nvd.nist.gov/vuln/detail/CVE-2025-38737

I don't know what exactly can/should be done, but I thought I'd let you
know.


Cheers,

Enzo

>Fixes: a2906d3316fc ("cifs: Switch crypto buffer to use a folio_queue rather than an xarray")
>Signed-off-by: David Howells <dhowells@redhat.com>
>cc: Steve French <sfrench@samba.org>
>cc: Paulo Alcantara <pc@manguebit.org>
>cc: linux-cifs@vger.kernel.org
>cc: linux-fsdevel@vger.kernel.org
>---
> fs/smb/client/smb2ops.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
>index ad8947434b71..cd0c9b5a35c3 100644
>--- a/fs/smb/client/smb2ops.c
>+++ b/fs/smb/client/smb2ops.c
>@@ -4487,7 +4487,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
> 	for (int i = 1; i < num_rqst; i++) {
> 		struct smb_rqst *old = &old_rq[i - 1];
> 		struct smb_rqst *new = &new_rq[i];
>-		struct folio_queue *buffer;
>+		struct folio_queue *buffer = NULL;
> 		size_t size = iov_iter_count(&old->rq_iter);
>
> 		orig_len += smb_rqst_len(server, old);
>
>

