Return-Path: <linux-fsdevel+bounces-30864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E798EED5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBD91C2164B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC96816F8E5;
	Thu,  3 Oct 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pc3LaxDP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DWIT8qCG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pc3LaxDP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DWIT8qCG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45D15E5D3;
	Thu,  3 Oct 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957488; cv=none; b=WGdXQJjc0n625xtKrmrsuDguUd1A1GPY9G4/qX1WRXRCSH0u+aAaXUrPpySwUKc/ZQy21e9BtnASN3pCvdCY5OlXDjS0YS0o733NS5BZCHmSqlvttJXCtispwGX/F7gCtwU/gkIJSrF+6Q2Sn/9T7e5ek3c3l+hzyz3MdbJ5O9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957488; c=relaxed/simple;
	bh=YUvdwqywEqXT/rs9DRBzxaDz16TgeXqxMhIN6TCvLeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi/IbmdxKiU96afviTMVzdmupOpKa58knjVbuIJCg7NDxWCVQ4nbhPT1vxTtXeL29IQ/MZCVDB4h+Pos6PCJoQKzEMN9ua6PHgO9upmgIWlDaz/oBnVKituuqRQ7jXcr/NL+qjItC8Fx3AgEI7ASYSgpiDaAC/6lhPLiEF8Afxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pc3LaxDP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DWIT8qCG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pc3LaxDP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DWIT8qCG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1D091FB6C;
	Thu,  3 Oct 2024 12:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXa718mvxoZtEoHrrlnbDE2eswunncKSuvkTSZBqt3I=;
	b=pc3LaxDPajCeSWM9YjzyTbxTLcQANrCSqJr4NBF/bm4DSHSbwPz2mBdLVsF0YLSgFDoJqD
	tQyYSWsou1JCoM7gaU2ISbQqf1TpK9iE43vOkMLEvmLUBP8tv8T7OvF6+ZnIRP/pPoDPhU
	2fmUtl/gDX0L8A++s2YVOFjTddXPR8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXa718mvxoZtEoHrrlnbDE2eswunncKSuvkTSZBqt3I=;
	b=DWIT8qCG+HIrbl5MbCsm4V/nCR9wr8GrAcc6S/EeV+O6Gaps1QixCLdoCmW6XLnXfFu7BJ
	ykzV3QHIu+uoa3Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pc3LaxDP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DWIT8qCG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXa718mvxoZtEoHrrlnbDE2eswunncKSuvkTSZBqt3I=;
	b=pc3LaxDPajCeSWM9YjzyTbxTLcQANrCSqJr4NBF/bm4DSHSbwPz2mBdLVsF0YLSgFDoJqD
	tQyYSWsou1JCoM7gaU2ISbQqf1TpK9iE43vOkMLEvmLUBP8tv8T7OvF6+ZnIRP/pPoDPhU
	2fmUtl/gDX0L8A++s2YVOFjTddXPR8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vXa718mvxoZtEoHrrlnbDE2eswunncKSuvkTSZBqt3I=;
	b=DWIT8qCG+HIrbl5MbCsm4V/nCR9wr8GrAcc6S/EeV+O6Gaps1QixCLdoCmW6XLnXfFu7BJ
	ykzV3QHIu+uoa3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 985DC13882;
	Thu,  3 Oct 2024 12:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bXAzJeyJ/mZLIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:11:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 528B3A086F; Thu,  3 Oct 2024 14:11:20 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:11:20 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/6] mm: Remove PageMappedToDisk
Message-ID: <20241003121120.gdiibqxse3mu63my@quack3>
References: <20241002040111.1023018-1-willy@infradead.org>
 <20241002040111.1023018-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002040111.1023018-4-willy@infradead.org>
X-Rspamd-Queue-Id: A1D091FB6C
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,infradead.org:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 02-10-24 05:01:05, Matthew Wilcox (Oracle) wrote:
> All callers have now been converted to the folio APIs, so remove
> the page API for this flag.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/page-flags.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 1b3a76710487..35d08c30d4a6 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -554,7 +554,7 @@ FOLIO_FLAG(owner_2, FOLIO_HEAD_PAGE)
>   */
>  TESTPAGEFLAG(Writeback, writeback, PF_NO_TAIL)
>  	TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
> -PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
> +FOLIO_FLAG(mappedtodisk, FOLIO_HEAD_PAGE)
>  
>  /* PG_readahead is only used for reads; PG_reclaim is only for writes */
>  PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
> -- 
> 2.43.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

