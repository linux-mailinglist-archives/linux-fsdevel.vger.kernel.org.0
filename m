Return-Path: <linux-fsdevel+bounces-60907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9988B52CC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB77A4E0F91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 09:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597142E8DE6;
	Thu, 11 Sep 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3CV0a3QA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWJUBCYL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JnM72Qqh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lgaZcnRb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BD2BEFF3
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Sep 2025 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581998; cv=none; b=CazjxZ0j3LPAytDqHZc2khpmTP6KM7zBEhkhaZvlwa850wYfLqsh75BdQI6oPbfre723Ci6446bKtXVeOS41tLptTRn27MhRrnvGOR4G3iqUGoqToGtT5lWFDrGVD1c50I3aLUX/SpFfSoqS52uJxURMnQ/F4VnYddMB9Ighuso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581998; c=relaxed/simple;
	bh=adJkNnkvomGHsaIAAAUwgUZws+ZXTGUvcH79bT9o7VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvvaVp9ga5UsQtySDphVmiaTovXDBfJK275reQ3ieiXPjq8tYR5gJeNHboZEnCrMBhp7FCJyAHJLQ0A/LUcND587yoc3grvxI0cUFdrO9hPx+A3FTa6YQrn+sSFn7HpyaAxdT8faWffHBj8P+NRY0p8wq/pTj3Hdr5igfJvlyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3CV0a3QA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yWJUBCYL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JnM72Qqh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lgaZcnRb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 921355FA0E;
	Thu, 11 Sep 2025 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757581995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/CrSwPpBhWI3cIaZq6PAOrOweR+pL5Fslocxw3wlI=;
	b=3CV0a3QAFUCd7EVqNq8w5yBXGUeEcR1XZN1NvEoKgRNc+V0bOr5Thmxsgf7R014eDv4+pZ
	jHLampliLroyn2K3RTVTuzBbpEFCQ2+DgoX5TWjgi8CVQs+WV0zcHQ5wfIkEarwUuARKla
	w3aBeYHHExc0GWTkVT1gHQ4NU554b0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757581995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/CrSwPpBhWI3cIaZq6PAOrOweR+pL5Fslocxw3wlI=;
	b=yWJUBCYLLNaZz83bVEx0k31HEVKqlTh9HNmyF0Yf74DDyuAsWhputYCkQjfxRDwl/hb0hU
	jp2FTfAyS0+15OCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757581994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/CrSwPpBhWI3cIaZq6PAOrOweR+pL5Fslocxw3wlI=;
	b=JnM72QqhzyTz/cLoAb/fUVSN/Odop70DRTeYT8KMS/Wu1eaSNoCk+bv7p9xEjNW7HgQDFh
	0T9fkxAzrNOP7HDshQrPuxxTw5lwlEc6SvfqxWdX6aH1YCFDDVkaODyvDskKJhZhak4c39
	uYPUfitULpAD8w6OGD2p2dJ4wqb4puo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757581994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/CrSwPpBhWI3cIaZq6PAOrOweR+pL5Fslocxw3wlI=;
	b=lgaZcnRbQGMuyyMObI3wHX7rXuUD8ikhSuOQewcPFxkiOZW1jtWJKtaWc5zsq8uf0AcS7q
	kzU3vQvB3uCZBrAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71D2913301;
	Thu, 11 Sep 2025 09:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fm1FG6qSwmg+fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Sep 2025 09:13:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1D912A0A2D; Thu, 11 Sep 2025 11:13:10 +0200 (CEST)
Date: Thu, 11 Sep 2025 11:13:10 +0200
From: Jan Kara <jack@suse.cz>
To: sunyongjian1@huawei.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tytso@mit.edu, jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com, 
	libaokun1@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v4] ext4: increase i_disksize to offset + len in
 ext4_update_disksize_before_punch()
Message-ID: <ghhwtkw6arrrx5ngd3npncitdm5iv3xhkl2rplyccx445wihxp@hxcq5mdljyuk>
References: <20250911025412.186872-1-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911025412.186872-1-sunyongjian@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 11-09-25 10:54:12, Yongjian Sun wrote:
> From: Yongjian Sun <sunyongjian1@huawei.com>
> 
> After running a stress test combined with fault injection,
> we performed fsck -a followed by fsck -fn on the filesystem
> image. During the second pass, fsck -fn reported:
> 
> Inode 131512, end of extent exceeds allowed value
> 	(logical block 405, physical block 1180540, len 2)
> 
> This inode was not in the orphan list. Analysis revealed the
> following call chain that leads to the inconsistency:
> 
>                              ext4_da_write_end()
>                               //does not update i_disksize
>                              ext4_punch_hole()
>                               //truncate folio, keep size
> ext4_page_mkwrite()
>  ext4_block_page_mkwrite()
>   ext4_block_write_begin()
>     ext4_get_block()
>      //insert written extent without update i_disksize
> journal commit
> echo 1 > /sys/block/xxx/device/delete
> 
> da-write path updates i_size but does not update i_disksize. Then
> ext4_punch_hole truncates the da-folio yet still leaves i_disksize
> unchanged(in the ext4_update_disksize_before_punch function, the
> condition offset + len < size is met). Then ext4_page_mkwrite sees
> ext4_nonda_switch return 1 and takes the nodioread_nolock path, the
> folio about to be written has just been punched out, and it’s offset
> sits beyond the current i_disksize. This may result in a written
> extent being inserted, but again does not update i_disksize. If the
> journal gets committed and then the block device is yanked, we might
> run into this. It should be noted that replacing ext4_punch_hole with
> ext4_zero_range in the call sequence may also trigger this issue, as
> neither will update i_disksize under these circumstances.
> 
> To fix this, we can modify ext4_update_disksize_before_punch to
> increase i_disksize to min(offset + len) when both i_size and
> (offset + len) are greater than i_disksize.
> 
> Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

(as Zhang Yi noted you could have added my tag already for this posting but
whatever :).

								Honza

> ---
> Changes in v4:
> - Make the comments simpler and clearer.
> - Link to v3: https://lore.kernel.org/all/20250910042516.3947590-1-sunyongjian@huaweicloud.com/
> Changes in v3:
> - Add a condition to avoid increasing i_disksize and include some comments.
> - Link to v2: https://lore.kernel.org/all/20250908063355.3149491-1-sunyongjian@huaweicloud.com/
> Changes in v2:
> - The modification of i_disksize should be moved into ext4_update_disksize_before_punch,
>   rather than being done in ext4_page_mkwrite.
> - Link to v1: https://lore.kernel.org/all/20250731140528.1554917-1-sunyongjian@huaweicloud.com/
> ---
>  fs/ext4/inode.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 5b7a15db4953..f82f7fb84e17 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4287,7 +4287,11 @@ int ext4_can_truncate(struct inode *inode)
>   * We have to make sure i_disksize gets properly updated before we truncate
>   * page cache due to hole punching or zero range. Otherwise i_disksize update
>   * can get lost as it may have been postponed to submission of writeback but
> - * that will never happen after we truncate page cache.
> + * that will never happen if we remove the folio containing i_size from the
> + * page cache. Also if we punch hole within i_size but above i_disksize,
> + * following ext4_page_mkwrite() may mistakenly allocate written blocks over
> + * the hole and thus introduce allocated blocks beyond i_disksize which is
> + * not allowed (e2fsck would complain in case of crash).
>   */
>  int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  				      loff_t len)
> @@ -4298,9 +4302,11 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
>  	loff_t size = i_size_read(inode);
>  
>  	WARN_ON(!inode_is_locked(inode));
> -	if (offset > size || offset + len < size)
> +	if (offset > size)
>  		return 0;
>  
> +	if (offset + len < size)
> +		size = offset + len;
>  	if (EXT4_I(inode)->i_disksize >= size)
>  		return 0;
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

