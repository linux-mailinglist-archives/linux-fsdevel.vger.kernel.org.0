Return-Path: <linux-fsdevel+bounces-895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B76B37D298B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E843C1C20852
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 05:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF1C5240;
	Mon, 23 Oct 2023 05:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J+nJfNz8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+2ztQzXb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62855221
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 05:03:44 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3792B9;
	Sun, 22 Oct 2023 22:03:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 470901FD6D;
	Mon, 23 Oct 2023 05:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698037421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3FiI24Lz0BDoFAv2KmmVJyfmQQdLhLTKq1sMxVk3sI=;
	b=J+nJfNz8B9kuGroRmoRdSzMzTfD6Gth7HIFXiCv0CBcXo89rdVvW0YyPBkMVn6mCFSfNf5
	Q3ROPiQcfeCpEtld3TapK7bb0p9fGG23vCltQUb63s9Idxqc2iemFLOLAG4e3eWoYaHti0
	4PQ7zgTriYaSzxb4lRfg4oE5ZoCU2jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698037421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3FiI24Lz0BDoFAv2KmmVJyfmQQdLhLTKq1sMxVk3sI=;
	b=+2ztQzXbrsFLw1W2hJ9hWXtV9BMqrX6tux1fQSZkK7Wud2n83rwqfaI7mpHDPAotjxtISu
	IDYIXYpuZDtTY0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1788D133E5;
	Mon, 23 Oct 2023 05:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id VHQZBK3+NWXDMwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 23 Oct 2023 05:03:41 +0000
Message-ID: <af5e4736-5b24-4cff-a843-de54a269fed1@suse.de>
Date: Mon, 23 Oct 2023 07:03:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] fs/buffer.c: use accessor function to translate
 page index to sectors
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Pankaj Raghav <p.raghav@samsung.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-5-hare@suse.de> <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZTLW9jOJ0Crt/ZD3@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.79
X-Spamd-Result: default: False [-6.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.70)[98.70%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]

On 10/20/23 21:37, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 01:04:56PM +0200, Hannes Reinecke wrote:
>> Use accessor functions block_index_to_sector() and block_sector_to_index()
>> to translate the page index into the block sector and vice versa.
> 
> You missed two in grow_dev_page() (which I just happened upon):
> 
>          bh = folio_buffers(folio);
>          if (bh) {
>                  if (bh->b_size == size) {
>                          end_block = folio_init_buffers(folio, bdev,
>                                          (sector_t)index << sizebits, size);
>                          goto done;
>                  }
> ...
>          spin_lock(&inode->i_mapping->private_lock);
>          link_dev_buffers(folio, bh);
>          end_block = folio_init_buffers(folio, bdev,
>                          (sector_t)index << sizebits, size);
> 
> Can UBSAN be of help here?  It should catch shifting by a negative
> amount.  That sizebits is calculated in grow_buffers:
> 
>          sizebits = PAGE_SHIFT - __ffs(size);
> 
Ah, thanks. I'm currently working with Luis and Pankay to get a combined 
patchset; I'll make sure to have that included.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


