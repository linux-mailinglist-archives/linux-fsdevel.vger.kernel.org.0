Return-Path: <linux-fsdevel+bounces-79368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN2rAzo2qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:40:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B542008BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A26F03035E13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E713988F7;
	Wed,  4 Mar 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxHpF5jF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE537FF66;
	Wed,  4 Mar 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631600; cv=none; b=G5kYA5jo/DhmNTxr8SB5Oki1zMyWrT+JMLLjHl3It58GG4yrTE6xOMVsVQuAjnp/HSRFs9aYk2Fqibls57xYqnyd8O+3JTamjinlYlCBFyjCH6Vbbhw1pRxqNpgJAmAYWrN50L7BWDcTTxKhAlo7iWnq2FpiIq1DWOJQNNX8DMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631600; c=relaxed/simple;
	bh=IgVErusGbBVUvuBX5aaGbT+VBaSMQ9ieeAk3Mhvg7ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THQqt5PNfa92P0+52/UGjR/d7x53E1FkSfud30TFA4z7nUzuZOinkkXfgTZLcmtK5L1nV0AsZCAwVea9whXxZJZSUBRUysR1d2429xYjpQFl91/69k2jAwhQSBz+h5UOip3KoyhHxnSYsaeR5f+WfV/qGZqYYUHQtpWKcyVt/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxHpF5jF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79464C19423;
	Wed,  4 Mar 2026 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772631600;
	bh=IgVErusGbBVUvuBX5aaGbT+VBaSMQ9ieeAk3Mhvg7ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxHpF5jF632zcGOUPVYUAwPxtaLg9GeT4g9b8AGgvI/Zf/6MLbRx0eOYaqs/Tz2rX
	 WoDEX6icwQJ1AHKZfguDJaIB5cRqgN1uNpOv4nw+AYXXvVUCpbmoMjrLnMIhhOnQAJ
	 ixhvNXxrQ81HxbnMc+0ijk9fkkvUodWYyN2hDg4t0D2BLcdjZjB1xUPcC220usP4K5
	 kDlhOs/7zTcneZ5s7xZHMkkhmUYqSA5oFrsG/nXHoGJs4jaz9M9poyaP5RQ/6MPFlF
	 MFFV70+MuyvqSNLnJjWu3+ok2FdzzAItsx9wpeoCzA8GpbDpOahu3g0wyN6Baqx8Kv
	 2jiP7V/X8SUig==
Date: Wed, 4 Mar 2026 14:39:54 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 21/32] bdev: Drop pointless invalidate_mapping_buffers()
 call
Message-ID: <20260304-dachboden-minibar-620c6f7d69fc@brauner>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-53-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303103406.4355-53-jack@suse.cz>
X-Rspamd-Queue-Id: 94B542008BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79368-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org,kernel.dk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:34:10AM +0100, Jan Kara wrote:
> Nobody is calling mark_buffer_dirty_inode() with internal bdev inode and
> it doesn't make sense for internal bdev inode to have any metadata
> buffer heads. Just drop the pointless invalidate_mapping_buffers() call.

s/invalidate_mapping_buffers/invalidate_inode_buffers/g?

> 
> CC: Jens Axboe <axboe@kernel.dk>
> CC: linux-block@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/bdev.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index ed022f8c48c7..ad1660b6b324 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -420,7 +420,6 @@ static void init_once(void *data)
>  static void bdev_evict_inode(struct inode *inode)
>  {
>  	truncate_inode_pages_final(&inode->i_data);
> -	invalidate_inode_buffers(inode); /* is it needed here? */
>  	clear_inode(inode);
>  }
>  
> -- 
> 2.51.0
> 

