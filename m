Return-Path: <linux-fsdevel+bounces-79366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBVGAO42qGm+pQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:43:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEEC2009B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E81B3311B86D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8CF3988FB;
	Wed,  4 Mar 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOmZC+qm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB7389101;
	Wed,  4 Mar 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631533; cv=none; b=B05UE9VIxHeBOUhlvGNV7wIEhXldRGrTQ1DrCO/hvu9SdSI+g6b4irgTbYLz6AWcXFhVH6O/3oKCaVWEHgvXO64ry5hN/VzRGTVn72cA7U4C03/JLzftlPwOQIheqVZrq14PCwMzuB1I7dd5oKThj/1Q6N1Mp4Jiep25zFzQS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631533; c=relaxed/simple;
	bh=9Gu41Q7tWvFsmLiy2GzG+FeazMjJOugDDDVf94ibiOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnZyWhVrD6j0nwXP8Y8iPTcHXte0l/s4FhwexxXQ27X0Gqw4CVZIe37XD1vZwx70dd76wpwM544mMsnkdRo6HXITalhSqnqqO6Zsxtb45KVtTwLiRCXoWLFYGAefyph7WejUu7u6l5fICnBKNOjpXvSM7b9saaLCkiIJKOXHTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOmZC+qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609B9C19423;
	Wed,  4 Mar 2026 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772631532;
	bh=9Gu41Q7tWvFsmLiy2GzG+FeazMjJOugDDDVf94ibiOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOmZC+qmGcMNUWoK1VMUGr6qSifG9f+/P/l07kDDW+5tFJVzCIb5FjTTwHh7tRNb8
	 MmdTjNQI3NcWEDgEh2opMdW5fc+YvW1uSibKvrtH+1rSxYMX19tqC95uPTFVwxno2C
	 YX/K4cLc5NCZpey966c88ikl9JrXUCb6D9MAIiITidXt8NKo/I87KSVDp4bIlwpeE8
	 wKgrtHScCsZpt//F3pLzblKhRQX+Tx0rVHfhxOz5l5N0eNIEZ/Obj4g31eDmtAWdS1
	 pBVsn8rCgw5ArWEAjz2DV1UNSPfHtuPMx5G6bEZssIyJRkZ3WFDmA3b2gmDtDfHJU3
	 F9S64NMbnc9kw==
Date: Wed, 4 Mar 2026 14:38:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, David Sterba <dsterba@suse.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-aio@kvack.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [PATCH 16/32] fs: Fold fsync_buffers_list() into
 sync_mapping_buffers()
Message-ID: <20260304-bildmaterial-deckname-1995a115de52@brauner>
References: <20260303101717.27224-1-jack@suse.cz>
 <20260303103406.4355-48-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303103406.4355-48-jack@suse.cz>
X-Rspamd-Queue-Id: 6FEEC2009B8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79366-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,mit.edu,gmail.com,suse.com,mail.parknet.co.jp,linux.dev,suse.de,kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:34:05AM +0100, Jan Kara wrote:
> There's only single caller of fsync_buffers_list() so untangle the code
> a bit by folding fsync_buffers_list() into sync_mapping_buffers(). Also
> merge the comments and update them to reflect current state of code.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/buffer.c | 180 +++++++++++++++++++++++-----------------------------
>  1 file changed, 80 insertions(+), 100 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 1c0e7c81a38b..18012afb8289 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -54,7 +54,6 @@
>  
>  #include "internal.h"
>  
> -static int fsync_buffers_list(spinlock_t *lock, struct list_head *list);
>  static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  			  enum rw_hint hint, struct writeback_control *wbc);
>  
> @@ -531,22 +530,96 @@ EXPORT_SYMBOL_GPL(inode_has_buffers);
>   * @mapping: the mapping which wants those buffers written
>   *
>   * Starts I/O against the buffers at mapping->i_private_list, and waits upon
> - * that I/O.
> + * that I/O. Basically, this is a convenience function for fsync().  @mapping
> + * is a file or directory which needs those buffers to be written for a
> + * successful fsync().
>   *
> - * Basically, this is a convenience function for fsync().
> - * @mapping is a file or directory which needs those buffers to be written for
> - * a successful fsync().
> + * We have conflicting pressures: we want to make sure that all
> + * initially dirty buffers get waited on, but that any subsequently
> + * dirtied buffers don't.  After all, we don't want fsync to last
> + * forever if somebody is actively writing to the file.
> + *
> + * Do this in two main stages: first we copy dirty buffers to a
> + * temporary inode list, queueing the writes as we go. Then we clean
> + * up, waiting for those writes to complete. mark_buffer_dirty_inode()
> + * doesn't touch b_assoc_buffers list if b_assoc_map is not NULL so we
> + * are sure the buffer stays on our list until IO completes (at which point
> + * it can be reaped).
>   */
>  int sync_mapping_buffers(struct address_space *mapping)
>  {
>  	struct address_space *buffer_mapping =
>  				mapping->host->i_sb->s_bdev->bd_mapping;
> +	struct buffer_head *bh;
> +	int err = 0;
> +	struct blk_plug plug;
> +	LIST_HEAD(tmp);
>  
>  	if (list_empty(&mapping->i_private_list))
>  		return 0;
>  
> -	return fsync_buffers_list(&buffer_mapping->i_private_lock,
> -					&mapping->i_private_list);
> +	blk_start_plug(&plug);
> +
> +	spin_lock(&buffer_mapping->i_private_lock);
> +	while (!list_empty(&mapping->i_private_list)) {
> +		bh = BH_ENTRY(list->next);


Stray "list" reference? Shouldn't this be
BH_ENTRY(mapping->i_private_list.next)?

