Return-Path: <linux-fsdevel+bounces-49458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3063ABC841
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 22:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5324A17C2F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2051F3BA9;
	Mon, 19 May 2025 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqYWIb4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0eMdyyE1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XqYWIb4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0eMdyyE1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D004B1E7F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747685814; cv=none; b=BKZrDDkh0RppPQuRvT6hh/2adrOnAflxQxIL5f29FSQ06mW/0GwWAS5Vb88PCmcdMweX80kmqgEbeIPEiU/R6W5iyU2SjQ8Un2KT/Q9GjWUBPJFPlgsio91B/6U0+UUJuQU4FJEzOa4NVM/5T7VF+UkKfRc6/xRzWvJGIzIak04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747685814; c=relaxed/simple;
	bh=ZmMZk2TINwxlV2GwsQa+h6FX3HGztklDF0EzsPIVnts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0iPt86adXWpQvgW7+BNKFI8H46Sqpa/jYBvJ6DTOnF2TgyPRz3yOl6ZkgmGYkCtMkuXhzERKvZ2M2UV/04ipu0PyKMbHEap/HmTOC2eNwJrFX9jEHdS0aGLLk3NTOeb6gBOKLAcRWibFKPpjwXAAYK6vLm90s5sRY5v6WZVvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqYWIb4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0eMdyyE1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XqYWIb4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0eMdyyE1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 69FC4204CA;
	Mon, 19 May 2025 20:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747685810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7aYnJRcoWwpfTUaDrWnQNrPa8O1N9QGhPSYb+LgsaY=;
	b=XqYWIb4zCmfErsfwhc5PZhiPBp6ngFBIR7YZoe1hn6NyzUYvZd2gRnRvZMvbEo7dcczs8u
	EZ80LkltPTmP+u3bZvcwifYArBu0UTxv6sDZBSV17uzV4Bu/OQTeDpCuzgrPnXtT+bSDY3
	Iz7WWIqCYUfmEpW9550LBkKZhzRdMEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747685810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7aYnJRcoWwpfTUaDrWnQNrPa8O1N9QGhPSYb+LgsaY=;
	b=0eMdyyE1fECglXh3JP91e6k9KGaExByo77pqSoOIQV0ykDCQ9HtCNh93VJIgcxx2Qd71lv
	AgJ8ifVI1hssRPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747685810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7aYnJRcoWwpfTUaDrWnQNrPa8O1N9QGhPSYb+LgsaY=;
	b=XqYWIb4zCmfErsfwhc5PZhiPBp6ngFBIR7YZoe1hn6NyzUYvZd2gRnRvZMvbEo7dcczs8u
	EZ80LkltPTmP+u3bZvcwifYArBu0UTxv6sDZBSV17uzV4Bu/OQTeDpCuzgrPnXtT+bSDY3
	Iz7WWIqCYUfmEpW9550LBkKZhzRdMEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747685810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m7aYnJRcoWwpfTUaDrWnQNrPa8O1N9QGhPSYb+LgsaY=;
	b=0eMdyyE1fECglXh3JP91e6k9KGaExByo77pqSoOIQV0ykDCQ9HtCNh93VJIgcxx2Qd71lv
	AgJ8ifVI1hssRPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 606151372E;
	Mon, 19 May 2025 20:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SZqFF7KRK2gAFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 May 2025 20:16:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2429BA0A31; Mon, 19 May 2025 22:16:50 +0200 (CEST)
Date: Mon, 19 May 2025 22:16:50 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, 
	yangerkun@huawei.com
Subject: Re: [PATCH v2 4/8] ext4/jbd2: convert jbd2_journal_blocks_per_page()
 to support large folio
Message-ID: <ht54j6bvjmiqt62xmcveqlo7bmrunqs4ji7wikfteftdjijzek@7tz5gpejaoen>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512063319.3539411-5-yi.zhang@huaweicloud.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 12-05-25 14:33:15, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> jbd2_journal_blocks_per_page() returns the number of blocks in a single
> page. Rename it to jbd2_journal_blocks_per_folio() and make it returns
> the number of blocks in the largest folio, preparing for the calculation
> of journal credits blocks when allocating blocks within a large folio in
> the writeback path.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
...
> @@ -2657,9 +2657,10 @@ void jbd2_journal_ack_err(journal_t *journal)
>  	write_unlock(&journal->j_state_lock);
>  }
>  
> -int jbd2_journal_blocks_per_page(struct inode *inode)
> +int jbd2_journal_blocks_per_folio(struct inode *inode)
>  {
> -	return 1 << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
> +	return 1 << (PAGE_SHIFT + mapping_max_folio_order(inode->i_mapping) -
> +		     inode->i_sb->s_blocksize_bits);
>  }

FWIW this will result in us reserving some 10k transaction credits for 1k
blocksize with maximum 2M folio size. That is going to create serious
pressure on the journalling machinery. For now I guess we are fine but
eventually we should rewrite how credits for writing out folio are computed
to reduce this massive overestimation. It will be a bit tricky but we could
always reserve credits for one / couple of extents and try to extend the
transaction if we need more. The tricky part is to do the partial folio
writeout in case we cannot extend the transaction...

								Honza
>  /*
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 023e8abdb99a..ebbcdab474d5 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1723,7 +1723,7 @@ static inline int tid_geq(tid_t x, tid_t y)
>  	return (difference >= 0);
>  }
>  
> -extern int jbd2_journal_blocks_per_page(struct inode *inode);
> +extern int jbd2_journal_blocks_per_folio(struct inode *inode);
>  extern size_t journal_tag_bytes(journal_t *journal);
>  
>  static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

