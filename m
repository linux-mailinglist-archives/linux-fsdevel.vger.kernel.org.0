Return-Path: <linux-fsdevel+bounces-39487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A65A14EDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 12:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99A03A8CA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 11:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857871FECA9;
	Fri, 17 Jan 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UgbRG7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiD4CAmF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3UgbRG7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiD4CAmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B51FC7F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737115021; cv=none; b=Z56IqyWpm5RwOrzYNQRjB4nNHc6ynlOYFikbkzInYCUCABDPyr/2wXuWC9ZXN09wA1YhsSRDtwbxDgf8vEBCQV/Ye7C7t/fzL41bCgjTYV/ENp2PQpvSB+FY4tvzSOPthOOFlol+DwZMPJUAe/bIVbYmlejIdZPcu6jdlD4zuDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737115021; c=relaxed/simple;
	bh=oL/0US8WuTS9MxAkUHDpP7JTX2/DwOgnm22j3AbT1BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQQZgtnB5Hx8sZxkfFHQ/RMTFunGNgzyLlAikp5I6fYkOiz4OU4oi+UnXb1A2oS3XIOMVI2r8VOD1RBRAO/4M6cOLO9vrH5maxa3pzeHFILJGpRxRkO9TwsW2mIMEjUovSyHOkAeYahFUoTQO/2vLvSyHohIXSDDebbMa1ZVSk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UgbRG7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiD4CAmF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3UgbRG7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiD4CAmF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4DA1F387;
	Fri, 17 Jan 2025 11:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737115017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQk416ztu0xlnc04InLVVMHFa3AHVndkY0HLuU+Vwqw=;
	b=3UgbRG7ozwQrSRGX2s3pAQnNfScDVsmftEVqBiwA9Ni904NQJuar+d926T7wQw4IHVajCC
	Q2DmTcWbC7OTOpxKag7Y1PJgFo1cDVm4VWKgKL0CkV0HNVLaj0NJqdATNjxXyryRcHgsZm
	56mH80K2nhfltWg3XXb8eD6qW5JoTQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737115017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQk416ztu0xlnc04InLVVMHFa3AHVndkY0HLuU+Vwqw=;
	b=uiD4CAmF47bmdG4ZC/xj16vFcpnhOKdDhtTCIFTus/0hcRkkNbEPSL+O4jVZdLM6HugoZX
	zrsa/h7jcwXtoyBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737115017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQk416ztu0xlnc04InLVVMHFa3AHVndkY0HLuU+Vwqw=;
	b=3UgbRG7ozwQrSRGX2s3pAQnNfScDVsmftEVqBiwA9Ni904NQJuar+d926T7wQw4IHVajCC
	Q2DmTcWbC7OTOpxKag7Y1PJgFo1cDVm4VWKgKL0CkV0HNVLaj0NJqdATNjxXyryRcHgsZm
	56mH80K2nhfltWg3XXb8eD6qW5JoTQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737115017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WQk416ztu0xlnc04InLVVMHFa3AHVndkY0HLuU+Vwqw=;
	b=uiD4CAmF47bmdG4ZC/xj16vFcpnhOKdDhtTCIFTus/0hcRkkNbEPSL+O4jVZdLM6HugoZX
	zrsa/h7jcwXtoyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EF2E139CB;
	Fri, 17 Jan 2025 11:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w3LPGolFimd+NwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 17 Jan 2025 11:56:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F24D9A08E0; Fri, 17 Jan 2025 12:56:52 +0100 (CET)
Date: Fri, 17 Jan 2025 12:56:52 +0100
From: Jan Kara <jack@suse.cz>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
Message-ID: <t3zhbv6mui56wehxydtzr5mjb5wxqaapy7ndit7gigwrx5v4xf@jvl6jsxtohwd>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <73eb82d2-1a43-4e88-a5e3-6083a04318c1@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73eb82d2-1a43-4e88-a5e3-6083a04318c1@suse.cz>
X-Spam-Score: -7.80
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux-foundation.org,vger.kernel.org,kvack.org,infradead.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 17-01-25 12:40:15, Vlastimil Babka wrote:
> On 1/15/25 01:50, Joanne Koong wrote:
> > Hi all,
> > 
> > I would like to propose a discussion topic about improving large folio
> > writeback performance. As more filesystems adopt large folios, it
> > becomes increasingly important that writeback is made to be as
> > performant as possible. There are two areas I'd like to discuss:
> > 
> > 
> > == Granularity of dirty pages writeback ==
> > Currently, the granularity of writeback is at the folio level. If one
> > byte in a folio is dirty, the entire folio will be written back. This
> > becomes unscalable for larger folios and significantly degrades
> > performance, especially for workloads that employ random writes.
> > 
> > One idea is to track dirty pages at a smaller granularity using a
> > 64-bit bitmap stored inside the folio struct where each bit tracks a
> > smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> > pages), and only write back dirty chunks rather than the entire folio.
> 
> I think this might be tricky in some cases? I.e. with 2 MB and pmd-mapped
> folio, it's possible to write-protect only the whole pmd, not individual 32k
> chunks in order to catch the first write to a chunk to mark it dirty.

Definitely. Once you map a folio through PMD entry, you have no other
option than consider whole 2MB dirty. But with PTE mappings or
modifications through syscalls you can do more fine-grained dirtiness
tracking and there're enough cases like that that it pays off.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

