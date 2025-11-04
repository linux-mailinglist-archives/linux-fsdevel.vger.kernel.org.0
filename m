Return-Path: <linux-fsdevel+bounces-66933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54DEC30E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 13:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFED6189B3A5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 12:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7377B2EC56F;
	Tue,  4 Nov 2025 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8kLKt8W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6GHvk5Rr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="x8kLKt8W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6GHvk5Rr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BF2D3755
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Nov 2025 12:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258070; cv=none; b=Gki0tS7PK6/ii6UflzWSgiNazQNNeX/0vJnkfauwLZuGQ1MygkKtvR8Q/Gq6ANFSvEM+UTg7Hyn5caWxj1zwXNLf5wzUEg03O+fQNWmdkCy8YPw4wSmo7dNutJ6V7PeJGFYA0HoZEHBxDBsFkd97Aet0nCb1nSu7gzX3I5iosJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258070; c=relaxed/simple;
	bh=5KKViUfH67hGjyZIaY6c1Cbzg7H3zwLdYENQ75RFh8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiiwQeN8XgWsIOaxEhJIa+K1+vQdGc44iuQTCusg1MVECYPrniNDy0sqpY0C3fWm4qJHHxkeCQ6mQZy52NhO4se14rG50gtnPEsHdc99Gv3x35x9btXSt9phPVPTwfqZWmeYh/hftBrLqIiVWDRtiWtZ0t0TwPTJG+nLhgjh5wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8kLKt8W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6GHvk5Rr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=x8kLKt8W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6GHvk5Rr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 302101F385;
	Tue,  4 Nov 2025 12:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762258067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTEeK5jdKB+UcsLRhaj0JQ7j+e5f0Fy9HeQ8vvFEV1I=;
	b=x8kLKt8WonMswpd3vLncCCAP1oD0hVVSbY92X15Ayi2wSQVpwpvv/ff4DC3a+aWE/k27+W
	PCeZU45kHZ47JGe3MMCdngSHSbmgmPTvv0Att22UVhXyhBM5zPy2LYlHw4oU/42r3xI6Bv
	DpjZdL2FPDXhquWy2+KeXF/qP0iPIeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762258067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTEeK5jdKB+UcsLRhaj0JQ7j+e5f0Fy9HeQ8vvFEV1I=;
	b=6GHvk5Rrl6OQqjsaWePRqq6DbMjUU25we3yTez5cJcI+jqP5253dVG323ruukebJwiRJmo
	ScWFuiBj2SqVA8Cw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x8kLKt8W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6GHvk5Rr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762258067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTEeK5jdKB+UcsLRhaj0JQ7j+e5f0Fy9HeQ8vvFEV1I=;
	b=x8kLKt8WonMswpd3vLncCCAP1oD0hVVSbY92X15Ayi2wSQVpwpvv/ff4DC3a+aWE/k27+W
	PCeZU45kHZ47JGe3MMCdngSHSbmgmPTvv0Att22UVhXyhBM5zPy2LYlHw4oU/42r3xI6Bv
	DpjZdL2FPDXhquWy2+KeXF/qP0iPIeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762258067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XTEeK5jdKB+UcsLRhaj0JQ7j+e5f0Fy9HeQ8vvFEV1I=;
	b=6GHvk5Rrl6OQqjsaWePRqq6DbMjUU25we3yTez5cJcI+jqP5253dVG323ruukebJwiRJmo
	ScWFuiBj2SqVA8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F895136D1;
	Tue,  4 Nov 2025 12:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ww1qB5PsCWl4PQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 12:07:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 80944A28E6; Tue,  4 Nov 2025 13:07:46 +0100 (CET)
Date: Tue, 4 Nov 2025 13:07:46 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] fs: push list presence check into inode_io_list_del()
Message-ID: <qajqa3mduefflh3ki522gpmhb5kunreidbj2rsfzjntec3ur5k@epwgj76rbam5>
References: <20251103230911.516866-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103230911.516866-1-mjguzik@gmail.com>
X-Rspamd-Queue-Id: 302101F385
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 04-11-25 00:09:11, Mateusz Guzik wrote:
> For consistency with sb routines.
> 
> ext4 is the only consumer outside of evict(). Damage-controlling it is
> outside of the scope of this cleanup.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

One note below:

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index f784d8b09b04..e2eed66aabf8 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1349,6 +1349,13 @@ void inode_io_list_del(struct inode *inode)
>  {
>  	struct bdi_writeback *wb;
>  
> +	/*
> +	 * FIXME: ext4 can call here from ext4_evict_inode() after evict() already
> +	 * unlinked the inode.
> +	 */

This is in fact due to a possible race between __mark_inode_dirty() called
from ending page writeback (which is perfectly legal for a filesystem to
do) and iput_final() + evict(). See bc12ac98ea2e ("ext4: silence the
warning when evicting inode with dioread_nolock") for details. So proper
solution should be in the generic code... E.g. checking emptiness of
i_io_list under i_lock should be enough to close the race but it's a bit
tricky to avoid the unnecessary lock roundtrip for clean inodes.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

