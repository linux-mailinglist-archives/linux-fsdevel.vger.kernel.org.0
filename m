Return-Path: <linux-fsdevel+bounces-11365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F2853155
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D35E1F24303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A6351039;
	Tue, 13 Feb 2024 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XWMtBOKN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JpVtSt3g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ULMXA+zd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0LMl4fxq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2694F21C;
	Tue, 13 Feb 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829643; cv=none; b=NPqHoj2fkeF/GyQlpzLUeZvSb1tjHl3csaWNPUki57RpZMgwCuwC3pJ9RuLWgM209mAWvoQgMyu4yM0Ev5imXY7BRwoV1OJwnjgNxDshbNk5iNuTSKFEmbb8oJ0VWZkQzuNvRsWE+9qbDfuxUR/6jUdA4jyd9pQGodGFzSVYdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829643; c=relaxed/simple;
	bh=xfLzTtWr0zy4eVlJ9PAOvXwQ0pAQaXBAK+VvjTyHsJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYXLUjq3vtZyVigGSNl1rZexDCGRSuCbnkXOMKyrarU6+4HZdbLzuX5EvyMTIW+xIdT0BTROmKtW1Sac1pNEih9IiFP4JURkwQKE8UvWpDYGSRrLy9wCYoWQRn9Pdu8/C3FDpVOGafXJ2bUcQq5eY1RBXjVDzzGB62hm/fyBnk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XWMtBOKN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JpVtSt3g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ULMXA+zd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0LMl4fxq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 154C821E35;
	Tue, 13 Feb 2024 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707829640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5FJCSnLqnNyazb+BdbAUm/bf4ECqcxsT2qE0k5mX/c=;
	b=XWMtBOKNIeNJMb2mgTxA4UoWNskoWJiTfREaiC95jKCr/cb3EIzfhUvNAm/Uo16tvEsIde
	4Gs48tOX77u0gyTtHpvWaOBFScI7O6pgYaeQvP76SWg0x/lyHwjSKrI0gQ+wlxWOFaXPDL
	wj9kSGuLKWcdapctg+1uK6DAx2jmt60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707829640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5FJCSnLqnNyazb+BdbAUm/bf4ECqcxsT2qE0k5mX/c=;
	b=JpVtSt3gbscUGCnQqvcUcRC5D37KNyCtUoZLMczltRHtw4DRPIQxefOOo8kgqgqdQMigLW
	097Uf/NP2iJNCECw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707829638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5FJCSnLqnNyazb+BdbAUm/bf4ECqcxsT2qE0k5mX/c=;
	b=ULMXA+zdkocVYYu1UI2zhOep75kcTa2IWlj//PfYF2Gjn8XtDFZsB03KOQEETuGHNkGXas
	dkI0Cf284yNQzN5lggJt9Z5/tkJmJqLi9+1X8nhfJipZQPBMDCMLDcWJ+9iWbA32HmGLTb
	4f2SZIDVwStFOtDa7gtuaBvEqZQ7L4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707829638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5FJCSnLqnNyazb+BdbAUm/bf4ECqcxsT2qE0k5mX/c=;
	b=0LMl4fxqR8Qt/QcZ8GwQUEanxEY6zIgY20z3Z1CqU71N/t1bzNTuqlVX0Ws440/WgkVPtx
	tmbfr/F3C9Za4yAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0546E13A0E;
	Tue, 13 Feb 2024 13:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SPX0AIZpy2UoWwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 13:07:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 930DBA0809; Tue, 13 Feb 2024 14:07:13 +0100 (CET)
Date: Tue, 13 Feb 2024 14:07:13 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] writeback: don't call mapping_set_error in
 writepage_cb
Message-ID: <20240213130713.ysuxaqcwizqwjke2@quack3>
References: <20240212071348.1369918-1-hch@lst.de>
 <20240212071348.1369918-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212071348.1369918-2-hch@lst.de>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ULMXA+zd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0LMl4fxq
X-Spamd-Result: default: False [-1.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 154C821E35
X-Spam-Level: 
X-Spam-Score: -1.31
X-Spam-Flag: NO

On Mon 12-02-24 08:13:35, Christoph Hellwig wrote:
> writepage_cb is the iterator callback for write_cache_pages, which
> already tracks all errors and returns them to the caller.  There is
> no need to additionally cal mapping_set_error which is intended
                          ^^^ call

> for contexts where the error can't be directly returned (e.g. the
> I/O completion handlers).
> 
> Remove the mapping_set_error call in writepage_cb which is not only
> superfluous but also buggy as it can be called with the error argument
> set to AOP_WRITEPAGE_ACTIVATE, which is not actually an error but a
> magic return value asking the caller to unlock the page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Our error handling in writeback has always been ... spotty. E.g.
block_write_full_page() and iomap_writepage_map() call mapping_set_error()
as well so this seems to be a common way to do things, OTOH ext4 calls
mapping_set_error() only on IO completion. I guess the question is how
an error in ->writepages from background writeback should propagate to
eventual fsync(2) caller? Because currently such error propagates all the
way up to writeback_sb_inodes() where it is silently dropped...

								Honza

> ---
>  mm/page-writeback.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3f255534986a2f..62901fa905f01e 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2534,9 +2534,8 @@ static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
>  		void *data)
>  {
>  	struct address_space *mapping = data;
> -	int ret = mapping->a_ops->writepage(&folio->page, wbc);
> -	mapping_set_error(mapping, ret);
> -	return ret;
> +
> +	return mapping->a_ops->writepage(&folio->page, wbc);
>  }
>  
>  int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

