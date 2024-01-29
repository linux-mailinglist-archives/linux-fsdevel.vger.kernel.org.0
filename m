Return-Path: <linux-fsdevel+bounces-9333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35598840103
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E231C22AEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207EF54F9D;
	Mon, 29 Jan 2024 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HZ6pE+Rt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h09jdlhK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BC2+x4sm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZlwMf79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6E54F8C;
	Mon, 29 Jan 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519493; cv=none; b=AdMsm2fXLWajQqt9dm8E4nbf9hj7jmNjai8xOwpNZ7m+wQ8RayMWpjDDIkmDy2nsmxu3pWS1ZAH6o30vX2LhH+8pDIFAsEuGBKBYUVAEo102Lby71nvFVpwtzA2eJSCSIbfOY3/02iAx/zG2+mpb0vCgQPB/T1v2NfUR9Vw/q1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519493; c=relaxed/simple;
	bh=SkU+4puXs9RlrYoDZRgwJtwVqUJoQoVPHNtzgNj9Kvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHgyQcd34rC1vuEKE8jvmo7+w6wJq85CP4I0xvt9FB5kWwOdcBtTAyjcBwDIVUEiEYhALiNxyqSaLv4q6Ugr/T6lw3U75BNz93Vyfk3OGm3DED8Poh4CU5HcFMl8sOQVguIF6YDRIV2RltGRim7cVmz4RHbtSwMpDqZAoqv66/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HZ6pE+Rt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h09jdlhK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BC2+x4sm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YZlwMf79; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8E5D222B3;
	Mon, 29 Jan 2024 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706519486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8GvLPqduJNitmI5aRLyKcNYHGU+7vaJTqPL4qbrFKw=;
	b=HZ6pE+RteqaZgQZg1veKrD0/wQGt8n5hwiJVscdTGrfs/isLk06BSRTYKv3pYNjUQd697j
	tv4t7QfDZceBEWvzhfqLFIfqk31dIYYCmS6MdHVkh2sy70qTZQUBLhA9jj8V62zPzpsTip
	ofzdSAO1N3hpnW3h0ZKJjzESyT0fK7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706519486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8GvLPqduJNitmI5aRLyKcNYHGU+7vaJTqPL4qbrFKw=;
	b=h09jdlhKn6aA99PiGp1XOL096Rn2AVbgoIKPjACmWHBjOhG/dqMAfEFJ16eVTf8TdxxhDa
	aMc+cFk5RRbyWXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706519484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8GvLPqduJNitmI5aRLyKcNYHGU+7vaJTqPL4qbrFKw=;
	b=BC2+x4smJMaL3TEBpzZrqnRysAAMkY7buB7eJGoMXdZYfroUpXLpMauysBqbaHhGAfMyop
	fBfqkiCrPPxsIyBt5kmotUkBwDHHIAmPePesrCvvKlmzkM5iox0RMAppZP6d8ElG+WnK/4
	8GnU77korjeWVLP0GdGCYequu40Zw0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706519484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A8GvLPqduJNitmI5aRLyKcNYHGU+7vaJTqPL4qbrFKw=;
	b=YZlwMf79pBmijH0L3mj2uH5SRu4Q61fZIS2sdwcsNnOypSGJqHkFe2/nApxOSPTYFTD6sn
	B/p3EoRaK6/xGyBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A960D13911;
	Mon, 29 Jan 2024 09:11:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id s9dOKbxrt2WUPwAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 29 Jan 2024 09:11:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57483A0807; Mon, 29 Jan 2024 10:11:24 +0100 (CET)
Date: Mon, 29 Jan 2024 10:11:24 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Roman Smirnov <r.smirnov@omp.ru>, stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, lvc-project@linuxtesting.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>
Subject: Re: [PATCH 5.10/5.15 v2 0/1 RFC] mm/truncate: fix WARNING in
 ext4_set_page_dirty()
Message-ID: <20240129091124.vbyohvklcfkrpbyp@quack3>
References: <20240125130947.600632-1-r.smirnov@omp.ru>
 <ZbJrAvCIufx1K2PU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbJrAvCIufx1K2PU@casper.infradead.org>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BC2+x4sm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=YZlwMf79
X-Spamd-Result: default: False [-2.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B8E5D222B3
X-Spam-Level: 
X-Spam-Score: -2.81
X-Spam-Flag: NO

On Thu 25-01-24 14:06:58, Matthew Wilcox wrote:
> On Thu, Jan 25, 2024 at 01:09:46PM +0000, Roman Smirnov wrote:
> > Syzkaller reports warning in ext4_set_page_dirty() in 5.10 and 5.15
> > stable releases. It happens because invalidate_inode_page() frees pages
> > that are needed for the system. To fix this we need to add additional
> > checks to the function. page_mapped() checks if a page exists in the 
> > page tables, but this is not enough. The page can be used in other places:
> > https://elixir.bootlin.com/linux/v6.8-rc1/source/include/linux/page_ref.h#L71
> > 
> > Kernel outputs an error line related to direct I/O:
> > https://syzkaller.appspot.com/text?tag=CrashLog&x=14ab52dac80000
> 
> OK, this is making a lot more sense.
> 
> The invalidate_inode_page() path (after the page_mapped check) calls
> try_to_release_page() which strips the buffers from the page.
> __remove_mapping() tries to freeze the page and presuambly fails.

Yep, likely.

> ext4 is checking there are still buffer heads attached to the page.
> I'm not sure why it's doing that; it's legitimate to strip the
> bufferheads from a page and then reattach them later (if they're
> attached to a dirty page, they are created dirty).

Well, we really need to track dirtiness on per fs-block basis in ext4
(which makes a difference when blocksize < page size). For example for
delayed block allocation we reserve exactly as many blocks as we need
(which need not be all the blocks in the page e.g. when writing just one
block in the middle of a large hole). So when all buffers would be marked
as dirty we would overrun our reservation. Hence at the moment of dirtying
we really need buffers to be attached to the page and stay there until the
page is written back.
 
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

