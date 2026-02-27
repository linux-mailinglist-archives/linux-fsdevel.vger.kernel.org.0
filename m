Return-Path: <linux-fsdevel+bounces-78742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKWRIOK8oWmswAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:48:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D925C1BA405
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF5AA3029A5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841943E499;
	Fri, 27 Feb 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xYUAN8sr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQZoXb8e";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xYUAN8sr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iQZoXb8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02FA43DA32
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206905; cv=none; b=I/+w6rJzwjuioPYNhYWaQK121j1tMtx57HYxHb7XARcKZpPJ/9Ly1BDXZXDy9DeZ4tgKNpoDcV8AP1ZRZBKJJWnoPr+Bf6tS+7mPRhxzo4C1dWr+7GfUy3oaVjy76pWTThvVJuwBUbUxoBoGo8TePLYhxPGGPgSGaoIRQim2GeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206905; c=relaxed/simple;
	bh=5cIiKo/fQLPVCAfUeXRXs1YmF8ZcPiWmYt8R2yggZAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi3YLSMgzmwl/0f6PRVyLusNJO2Dmz3LRkbiOoJj7SQvd7HnfHa2STcw4fWpKY5DCXcOYW8guXXSM/XhvroBN5GIntikPJGMY2DKCACM3UwMgGGHt13Kdrye3Ap4QGzopVB1OA4uMjaaFlnKeSJg3NTTTv07Nf+GzBvdC2nMbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xYUAN8sr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQZoXb8e; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xYUAN8sr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iQZoXb8e; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 074CC4DA95;
	Fri, 27 Feb 2026 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhF2G6Z5061vbfNwfyrCX/8unOXEc30npSiOmm4lEgA=;
	b=xYUAN8srxLRGa/bNI0WCBpvF+iH0q5DJ8KSuFs5//Z2BkGUc/FaNEzqV++RY5kptyzgbem
	qO59OJjlKEZQ67FJKJwPouaVeYtRMidR55dqtbDfqsXcfQqXxDXK8KhRXRq0WQNCL/MhII
	muzsRDQzwa17492n2QZk7K8HaT9TuIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhF2G6Z5061vbfNwfyrCX/8unOXEc30npSiOmm4lEgA=;
	b=iQZoXb8em8jRoviVgVy2a5NyIS1QO3owbeG8/9L2ET+vMeK8LjjaTFAN6uZXosTqKy5fNG
	cScUtxEEveMe2LBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772206901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhF2G6Z5061vbfNwfyrCX/8unOXEc30npSiOmm4lEgA=;
	b=xYUAN8srxLRGa/bNI0WCBpvF+iH0q5DJ8KSuFs5//Z2BkGUc/FaNEzqV++RY5kptyzgbem
	qO59OJjlKEZQ67FJKJwPouaVeYtRMidR55dqtbDfqsXcfQqXxDXK8KhRXRq0WQNCL/MhII
	muzsRDQzwa17492n2QZk7K8HaT9TuIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772206901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VhF2G6Z5061vbfNwfyrCX/8unOXEc30npSiOmm4lEgA=;
	b=iQZoXb8em8jRoviVgVy2a5NyIS1QO3owbeG8/9L2ET+vMeK8LjjaTFAN6uZXosTqKy5fNG
	cScUtxEEveMe2LBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F274C3EA69;
	Fri, 27 Feb 2026 15:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VtgsOzS7oWnRNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 15:41:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B98BFA06D4; Fri, 27 Feb 2026 16:41:40 +0100 (CET)
Date: Fri, 27 Feb 2026 16:41:40 +0100
From: Jan Kara <jack@suse.cz>
To: Yuto Ohnuki <ytohnuki@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] fs: remove stale and duplicate forward declarations
Message-ID: <tzjqeyms46zvrcl4ai7hes4unshkdqnr4kcbj4hjfmrj7nlpve@ujg2satvhk4u>
References: <20260226201857.27310-2-ytohnuki@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226201857.27310-2-ytohnuki@amazon.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-78742-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:email,suse.cz:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D925C1BA405
X-Rspamd-Action: no action

On Thu 26-02-26 20:18:58, Yuto Ohnuki wrote:
> Remove the following unnecessary forward declarations from fs.h, which
> improves maintainability.
> 
> - struct hd_geometry: became unused in fs.h when
>   block_device_operations was moved to blkdev.h in commit 08f858512151
>   ("[PATCH] move block_device_operations to blkdev.h"). The forward
>   declaration is now added to blkdev.h where it is actually used.
> 
> - struct iovec: became unused when aio_read/aio_write were removed in
>   commit 8436318205b9 ("->aio_read and ->aio_write removed")
> 
> - struct iov_iter: duplicate forward declaration. This removes the
>   redundant second declaration, added in commit 293bc9822fa9
>   ("new methods: ->read_iter() and ->write_iter()")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512301303.s7YWTZHA-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302139.Wl0soAlz-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302105.pmzYfmcV-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302125.FNgHwu5z-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512302108.nIV8r5ES-lkp@intel.com/
> Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>

Makes sense. Thanks. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Add forward declaration of struct hd_geometry to blkdev.h to fix
>   build errors reported by kernel test robot.
> - Verified with allmodconfig build and all configs reported by 
>   kernel test robot.
> 
> v1: https://lore.kernel.org/lkml/20251229071401.98146-1-ytohnuki@amazon.com/
> ---
>  include/linux/blkdev.h | 1 +
>  include/linux/fs.h     | 3 ---
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index d463b9b5a0a5..0b5942e08754 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -38,6 +38,7 @@ struct blk_flush_queue;
>  struct kiocb;
>  struct pr_ops;
>  struct rq_qos;
> +struct hd_geometry;
>  struct blk_report_zones_args;
>  struct blk_queue_stats;
>  struct blk_stat_callback;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 8b3dd145b25e..75c97faf8799 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -55,8 +55,6 @@ struct bdi_writeback;
>  struct bio;
>  struct io_comp_batch;
>  struct fiemap_extent_info;
> -struct hd_geometry;
> -struct iovec;
>  struct kiocb;
>  struct kobject;
>  struct pipe_inode_info;
> @@ -1917,7 +1915,6 @@ struct dir_context {
>   */
>  #define COPY_FILE_SPLICE		(1 << 0)
>  
> -struct iov_iter;
>  struct io_uring_cmd;
>  struct offset_ctx;
>  
> -- 
> 2.50.1
> 
> 
> 
> 
> Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284
> 
> Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

