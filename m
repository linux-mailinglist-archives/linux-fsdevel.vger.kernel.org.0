Return-Path: <linux-fsdevel+bounces-66515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438EFC21BE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6843188ED5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA83081CB;
	Thu, 30 Oct 2025 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j/xDpomi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BgUnj8Qj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cCgp4+xR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y02q4QQG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74D36996C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848469; cv=none; b=d+PUutHxObnzGQXLCCjRLDJXriPLi8YVC3lePgNpby3xdPuEGkUUkitRUwovbDYhMLTRzTYrZz5m/yFpBUGe8cZNqUP/XwkibP/sHB1qa4hb4vZT/v4ial4d+XVzPWPSWsq8xyFpHGwx/8/xpE0ZObi2vn77GSE5Uzchr0bhWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848469; c=relaxed/simple;
	bh=MHjPd3cIr9Ro8JvYM4wscOP1KLV2+IEH+OrZHKIv/+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JujNFabsJSPjegcpG52iWKiTnNQsY5rJ9pZUIGFeSUZjo99iGO/RkAo6i0vEBiKdaECzRpQs4Qpt41/9b1Kri+A/lQtUH9W71ljxIOUzzjuhxHkB/4QakKtgj6M4WW6ytzxDwZQRcM/Tgeyb/CBFX1WY/W9HbPn5H6hKljjnsSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j/xDpomi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BgUnj8Qj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cCgp4+xR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y02q4QQG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0559D3377A;
	Thu, 30 Oct 2025 18:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848466;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35Rgq9aWXXCYtegCi5Nd8FkRSQcbW288tXIHMGLSzos=;
	b=j/xDpomipRi27Xvy5GBORux7vuiP/KIQypNiMxJ8XY5CAbXUZwuZU26mxFjInTO+/6/9Az
	yp4Zk/5YrAK9vfNS0FBWYcF1k/XIUs+WnhQtbidqXPDPPSHgwIfBn/uKBM9DiMXh76p25L
	QfOM3INTM8rTbEHkNjI+ohNh/JXVzxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848466;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35Rgq9aWXXCYtegCi5Nd8FkRSQcbW288tXIHMGLSzos=;
	b=BgUnj8Qjc9JEkRhbNm9umHTuI9hdu2AQHZAeqr0cUg5Ti1fHlpDUPAO2VvjgWm+mkJeEB7
	bh0sjWg6UEJwvqCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cCgp4+xR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y02q4QQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761848465;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35Rgq9aWXXCYtegCi5Nd8FkRSQcbW288tXIHMGLSzos=;
	b=cCgp4+xRw5fM4joQmxNWc82CsEDmpI8WHpVjHkG7LIHe5MO5lOaHu6CJRJPph59idlGVSo
	1GEifCUC/UXW3iHjs+dN0oy9hpXC3sev/rDh51NDLoFJZ4y22TYsuPgNZzxHlmVyOE3yMt
	eR70wdyU9CS8HtyYY/REg7rgXoaEcgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761848465;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35Rgq9aWXXCYtegCi5Nd8FkRSQcbW288tXIHMGLSzos=;
	b=Y02q4QQGUEocIdhPkNnWmwYmiyhHHVVYkXfo4ejKJow+PUEPO/8nr0WoTihHxbaNeNEJOT
	4BEYFr6dQxGabwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D15001396A;
	Thu, 30 Oct 2025 18:21:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id njTnMpCsA2lrBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 Oct 2025 18:21:04 +0000
Date: Thu, 30 Oct 2025 19:21:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org, v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 05/10] btrfs: push struct writeback_control into
 start_delalloc_inodes
Message-ID: <20251030182103.GC13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251024080431.324236-1-hch@lst.de>
 <20251024080431.324236-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024080431.324236-6-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0559D3377A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[to_ip_from(RL9qow8fch3pfgh43469ius4rs)];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.21

On Fri, Oct 24, 2025 at 10:04:16AM +0200, Christoph Hellwig wrote:
> In preparation for changing the filemap_fdatawrite_wbc API to not expose
> the writeback_control to the callers, push the wbc declaration next to
> the filemap_fdatawrite_wbc call and just pass the nr_to_write value to
> start_delalloc_inodes.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Acked-by: David Sterba <dsterba@suse.com>

