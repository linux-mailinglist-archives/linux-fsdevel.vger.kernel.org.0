Return-Path: <linux-fsdevel+bounces-52333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353CAAE1E62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 17:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05603AF86D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 15:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729912C030B;
	Fri, 20 Jun 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FF248BNa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNlz2wbm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FF248BNa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNlz2wbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6A2980A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432874; cv=none; b=lCKvATOXpRhJ4pVOK3JlwkKFPA6AfoFeZRafHpdErBuyFMujYBo8dnJxiXl6zH31cPYO+XB3YrKs5W4CnH0VfK7DcMPgN8psKSTO2vPbz7GLSCsp4HaT1vN4gCKJgW+uLrBzYmuHB9yToOFdOYOWV6JEB7VRu8v03RtybIZWg/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432874; c=relaxed/simple;
	bh=iomTu1xs83r/cYqzkuUR2FRi5imAYOOPdLaTWbfrsn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T49uN6XnvRaACUu/OeXFpV+TyYwm8GVMeYuX7kvdkXzSdpknicKNypeNJk/TTmj9974JoG4U/Mb2rQC2zaZQpliHKZ4a5nzoANIALYTXmpCilj3rF743o8qRQqgU4YLtdC1nUpFzkym8QgClen/L68+CahlZQ1s8r37gkuD8cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FF248BNa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNlz2wbm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FF248BNa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNlz2wbm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8417621228;
	Fri, 20 Jun 2025 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750432870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNdbnPCpie2X1ncI1WlTRB4blHLCzrzEd53jwoytgqg=;
	b=FF248BNadQhU/Dk+1b5SWRQZr4ATLNFsu4xvp7PRleqj7BX/LtcTJOHFj53SObQsU8AgY5
	tZ1gakhncqPFy1+O/W7+S451RO1emY9tTEb0dUDmVAviRpo4+phA2JikMEqV6iqBmeg9gl
	jD8w4mQM/AOjHIbgUpAnCbzpwbIo5TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750432870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNdbnPCpie2X1ncI1WlTRB4blHLCzrzEd53jwoytgqg=;
	b=QNlz2wbmwaLgFNdI8lTg8WkC8Wld1j1fWlE+HC/e6ftQRHo4aNflEKEK19CWrpn84WKS2k
	se0piMA+h/oHwdCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FF248BNa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QNlz2wbm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750432870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNdbnPCpie2X1ncI1WlTRB4blHLCzrzEd53jwoytgqg=;
	b=FF248BNadQhU/Dk+1b5SWRQZr4ATLNFsu4xvp7PRleqj7BX/LtcTJOHFj53SObQsU8AgY5
	tZ1gakhncqPFy1+O/W7+S451RO1emY9tTEb0dUDmVAviRpo4+phA2JikMEqV6iqBmeg9gl
	jD8w4mQM/AOjHIbgUpAnCbzpwbIo5TM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750432870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jNdbnPCpie2X1ncI1WlTRB4blHLCzrzEd53jwoytgqg=;
	b=QNlz2wbmwaLgFNdI8lTg8WkC8Wld1j1fWlE+HC/e6ftQRHo4aNflEKEK19CWrpn84WKS2k
	se0piMA+h/oHwdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6857513736;
	Fri, 20 Jun 2025 15:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5NxxGWZ8VWgTXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Jun 2025 15:21:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C18D6A08DD; Fri, 20 Jun 2025 17:21:05 +0200 (CEST)
Date: Fri, 20 Jun 2025 17:21:05 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 2/6] ext4: fix stale data if it bail out of the
 extents mapping loop
Message-ID: <ygdwliycwt52ngkl2o4lia3hzyug3zzvc2hdacbdi3lvbzne7l@l7ub66fvqym6>
References: <20250611111625.1668035-1-yi.zhang@huaweicloud.com>
 <20250611111625.1668035-3-yi.zhang@huaweicloud.com>
 <m5drn6xauyaksmui7b3vpua24ttgmjnwsi3sgavpelxlcwivsw@6bpmobqvpw7f>
 <14966764-5bbc-48a9-9d56-841255cfe3c6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14966764-5bbc-48a9-9d56-841255cfe3c6@huaweicloud.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8417621228
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 20-06-25 12:57:18, Zhang Yi wrote:
> On 2025/6/20 0:21, Jan Kara wrote:
> > On Wed 11-06-25 19:16:21, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> During the process of writing back folios, if
> >> mpage_map_and_submit_extent() exits the extent mapping loop due to an
> >> ENOSPC or ENOMEM error, it may result in stale data or filesystem
> >> inconsistency in environments where the block size is smaller than the
> >> folio size.
> >>
> >> When mapping a discontinuous folio in mpage_map_and_submit_extent(),
> >> some buffers may have already be mapped. If we exit the mapping loop
> >> prematurely, the folio data within the mapped range will not be written
> >> back, and the file's disk size will not be updated. Once the transaction
> >> that includes this range of extents is committed, this can lead to stale
> >> data or filesystem inconsistency.
> >>
> >> Fix this by submitting the current processing partial mapped folio and
> >> update the disk size to the end of the mapped range.
> >>
> >> Suggested-by: Jan Kara <jack@suse.cz>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> >> ---
> >>  fs/ext4/inode.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 48 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> >> index 3a086fee7989..d0db6e3bf158 100644
> >> --- a/fs/ext4/inode.c
> >> +++ b/fs/ext4/inode.c
> >> @@ -2362,6 +2362,42 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
> >>  	return 0;
> >>  }
> >>  
> >> +/*
> >> + * This is used to submit mapped buffers in a single folio that is not fully
> >> + * mapped for various reasons, such as insufficient space or journal credits.
> >> + */
> >> +static int mpage_submit_buffers(struct mpage_da_data *mpd, loff_t pos)
> >> +{
> >> +	struct inode *inode = mpd->inode;
> >> +	struct folio *folio;
> >> +	int ret;
> >> +
> >> +	folio = filemap_get_folio(inode->i_mapping, mpd->first_page);
> >> +	if (IS_ERR(folio))
> >> +		return PTR_ERR(folio);
> >> +
> >> +	ret = mpage_submit_folio(mpd, folio);
> >> +	if (ret)
> >> +		goto out;
> >> +	/*
> >> +	 * Update first_page to prevent this folio from being released in
> >> +	 * mpage_release_unused_pages(), it should not equal to the folio
> >> +	 * index.
> >> +	 *
> >> +	 * The first_page will be reset to the aligned folio index when this
> >> +	 * folio is written again in the next round. Additionally, do not
> >> +	 * update wbc->nr_to_write here, as it will be updated once the
> >> +	 * entire folio has finished processing.
> >> +	 */
> >> +	mpd->first_page = round_up(pos, PAGE_SIZE) >> PAGE_SHIFT;
> > 
> > Well, but there can be many folios between mpd->first_page and pos. And
> > this way you avoid cleaning them up (unlocking them and dropping elevated
> > refcount) before we restart next loop. How is this going to work?
> > 
> 
> Hmm, I don't think there can be many folios between mpd->first_page and
> pos. All of the fully mapped folios should be unlocked by
> mpage_folio_done(), and there is no elevated since it always call
> folio_batch_release() once we finish processing the folios.

Indeed. I forgot that mpage_map_one_extent() with shorten mpd->map->m_len
to the number of currently mapped blocks.

> mpage_release_unused_pages() is used to clean up unsubmitted folios.
> 
> For example, suppose we have a 4kB block size filesystem and we found 4
> order-2 folios need to be mapped in the mpage_prepare_extent_to_map().
> 
>        first_page             next_page
>        |                      |
>       [HHHH][HHHH][HHHH][HHHH]              H: hole  L: locked
>        LLLL  LLLL  LLLL  LLLL
> 
> In the first round in the mpage_map_and_submit_extent(), we mapped the
> first two folios along with the first two pages of the third folio, the
> mpage_map_and_submit_buffers() should then submit and unlock the first
> two folios, while also updating mpd->first_page to the beginning of the
> third folio.
> 
>                   first_page  next_page
>                   |          |
>       [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
>        UUUU  UUUU  LLLL  LLLL               W: mapped  U: unlocked
> 
> In the second round in the mpage_map_and_submit_extent(), we failed to
> map the blocks and call mpage_submit_buffers() to submit and unlock
> this partially mapped folio. Additionally, we increased mpd->first_page.
> 
>                      first_page next_page
>                      |        /
>       [WWWW][WWWW][WWHH][HHHH]              H: hole    L: locked
>        UUUU  UUUU  UUUU  LLLL               W: mapped  U: unlocked

Good. But what if we have a filesystem with 1k blocksize and order 0
folios? I mean situation like:

        first_page             next_page
        |                      |
       [HHHH][HHHH][HHHH][HHHH]              H: hole  L: locked
        L     L     L     L

Now we map first two folios.

                   first_page  next_page
                   |           |
       [MMMM][MMMM][HHHH][HHHH]              H: hole  L: locked
                    L     L

Now mpage_map_one_extent() maps half of the folio and fails to extend the
transaction further:

                   first_page  next_page
                   |           |
       [MMMM][MMMM][MMHH][HHHH]              H: hole  L: locked
                    L     L

and mpage_submit_folio() now shifts mpd->first page like:

                          first_page
                          |    next_page
                          |    |
       [MMMM][MMMM][MMHH][HHHH]              H: hole  L: locked
                    L     L

and it never gets reset back?

I suspect you thought that the failure to extend transaction in the middle
of order 0 folio should not happen because you reserve credits for full
page worth of writeback? But those credits could be exhaused by the time we
get to mapping third folio because mpage_map_one_extent() only ensures
there are credits for mapping one extent.

And I think reserving credits for just one extent is fine even from the
beginning (as I wrote in my comment to patch 4). We just need to handle
this partial case - which should be possible by just leaving
mpd->first_page untouched and leave unlocking to
mpage_release_unused_pages(). But I can be missing some effects, the
writeback code is really complex...

BTW long-term the code may be easier to follow if we replace
mpd->first_page and mpd->next_page with logical block based or byte based
indexing. Now when we have large order folios, page is not that important
concept for writeback anymore.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

