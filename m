Return-Path: <linux-fsdevel+bounces-12577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ECB861342
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456D1280A0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141B7F7EB;
	Fri, 23 Feb 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybmeF5ON";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="33peNjSQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybmeF5ON";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="33peNjSQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B7115AE0;
	Fri, 23 Feb 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696195; cv=none; b=qp/5bxPaFRbRVyB1E0irHUZ6VQYMsKKmgppsICPNrB2yfBwU61p2Ckib98LY0lrK+Bw8/H6wW2UPtmGSTaVQ1ejXcuFVmw8EEpC5UZ7YcflXAK5qdmCHcf2ucN5kDV3tumt0uzqC0hgx5Exybiqj1fxq3rEyrPfCptyeRYvFgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696195; c=relaxed/simple;
	bh=Bci/ri0KGbn77LWCEi8X8HiO7XovISCOHXtLf1X3y28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBDroKwPhvpouD9zjAbHaQ/6H5LLZv7xCAd1soQ820iYvNCbPx/mn/hV0j/Q2DjDw4ojQXNVqyl+XY/s6NCcPqs0jMmqdHouk4MAr2un5korojJ+cq9ZTmE0LGlbVB27YE6ru4ftHAIqxde0oJLJyDHrVWGORVj0NrNVsQcqtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybmeF5ON; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=33peNjSQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybmeF5ON; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=33peNjSQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00D251FC0A;
	Fri, 23 Feb 2024 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgCt7+lwHq+iVbnoG6vOwvCIhtYHluaSv2Rtn1WCIzU=;
	b=ybmeF5ONNvbGwF6xFMEz5XaFAaRWR8ODZPNJWs0sV09QJge60LUHBTPM7OjkoN1TbaqYpH
	pjdEv3l96qxNaV7CgWYzAmMLZ3bv89QsPivPnzQ6gSO4knnjXU22xmB8YKsKv6DYpsY2dz
	4bHuI0/dOJovEnR6KvlMxDaHT+PYDxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgCt7+lwHq+iVbnoG6vOwvCIhtYHluaSv2Rtn1WCIzU=;
	b=33peNjSQbDsy78c1ZtNgZH31O/zn3OufT9ywgTCcQ+iz/HNqtCx8+zQdBaM5j2+lFZ+QVj
	mH3xzwwXIxRSRLDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708696192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgCt7+lwHq+iVbnoG6vOwvCIhtYHluaSv2Rtn1WCIzU=;
	b=ybmeF5ONNvbGwF6xFMEz5XaFAaRWR8ODZPNJWs0sV09QJge60LUHBTPM7OjkoN1TbaqYpH
	pjdEv3l96qxNaV7CgWYzAmMLZ3bv89QsPivPnzQ6gSO4knnjXU22xmB8YKsKv6DYpsY2dz
	4bHuI0/dOJovEnR6KvlMxDaHT+PYDxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708696192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hgCt7+lwHq+iVbnoG6vOwvCIhtYHluaSv2Rtn1WCIzU=;
	b=33peNjSQbDsy78c1ZtNgZH31O/zn3OufT9ywgTCcQ+iz/HNqtCx8+zQdBaM5j2+lFZ+QVj
	mH3xzwwXIxRSRLDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E6E9413776;
	Fri, 23 Feb 2024 13:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id URBiOH+i2GVkfAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 13:49:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2BC2A07D1; Fri, 23 Feb 2024 14:49:51 +0100 (CET)
Date: Fri, 23 Feb 2024 14:49:51 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] fs/writeback: remove unused parameter wb of
 finish_writeback_work
Message-ID: <20240223134951.cym6bttyfto42zvz@quack3>
References: <20240208172024.23625-1-shikemeng@huaweicloud.com>
 <20240208172024.23625-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172024.23625-4-shikemeng@huaweicloud.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ybmeF5ON;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=33peNjSQ
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 00D251FC0A
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Fri 09-02-24 01:20:20, Kemeng Shi wrote:
> Remove unused parameter wb of finish_writeback_work.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index edb0cff51673..2619f74ced70 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -166,8 +166,7 @@ static void wb_wakeup_delayed(struct bdi_writeback *wb)
>  	spin_unlock_irq(&wb->work_lock);
>  }
>  
> -static void finish_writeback_work(struct bdi_writeback *wb,
> -				  struct wb_writeback_work *work)
> +static void finish_writeback_work(struct wb_writeback_work *work)
>  {
>  	struct wb_completion *done = work->done;
>  
> @@ -196,7 +195,7 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  		list_add_tail(&work->list, &wb->work_list);
>  		mod_delayed_work(bdi_wq, &wb->dwork, 0);
>  	} else
> -		finish_writeback_work(wb, work);
> +		finish_writeback_work(work);
>  
>  	spin_unlock_irq(&wb->work_lock);
>  }
> @@ -2285,7 +2284,7 @@ static long wb_do_writeback(struct bdi_writeback *wb)
>  	while ((work = get_next_work_item(wb)) != NULL) {
>  		trace_writeback_exec(wb, work);
>  		wrote += wb_writeback(wb, work);
> -		finish_writeback_work(wb, work);
> +		finish_writeback_work(work);
>  	}
>  
>  	/*
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

