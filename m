Return-Path: <linux-fsdevel+bounces-24790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94020944D2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498A328BB3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410EA19FA7B;
	Thu,  1 Aug 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qC7u8fjT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tGk/d7ci";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qC7u8fjT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tGk/d7ci"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7F71A2C20
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519011; cv=none; b=LiHg4DgGygvqITltd2HEqQjk6o4ydYTNznsBP3LUaYOumXHxQkR8jCHg5/8hUTiTnEVLjN5T0kZ+e78BYEM9H3BM15p7rP4tYStV3TyT+OmpBSV7FsJsNbaTOhjFD3AWQhsxX0icEEmWdwTtnQr1BqAPsVYH3qeN67LtA6JRI28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519011; c=relaxed/simple;
	bh=UVhMbrpg/C9wIcR67aXCPEYWFBywaxi5kkEawMCsEfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEk5Dsszcy3IT2lKYxyGqe6bRuTvQxRCgyWM7t659a24YiZvjavAYcxC4/nv01J8vqGPQlkffHTmKxO1ChRxsjJHYpwnDw5zHGKz0yMXKFrnloaVlxo82meodyowlQW3FU1hI6/ZCVio4zL/H2HWWTts9jEyL6KLUgWJ/4dlaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qC7u8fjT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tGk/d7ci; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qC7u8fjT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tGk/d7ci; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCE1D219F9;
	Thu,  1 Aug 2024 13:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722519007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXiIJTWZEIl7vR9DhU1w6IJRUW9JpFHNQs0JlIhUbAw=;
	b=qC7u8fjTT+tFNUV6IUPCTYeN/02Z8SRsmzO75UaFsIvX/n+J11jfGHcBAP+C5ORbxKyr4Y
	cZeogKAZ+Jdo1pfojKN1bQ6p51MBE+oN0O6Kpt0iz1T6BGSxYp0ssseedtjzfqjqgiXHRs
	oZ9AU0X3yTxYVapFUqpAKPQruf7VEJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722519007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXiIJTWZEIl7vR9DhU1w6IJRUW9JpFHNQs0JlIhUbAw=;
	b=tGk/d7ciKdZqLYFMNwapCmfu8/kphu5jgNGDM6VFlt+zhpJypGnv+l1wTlAIEorhP7MJUY
	iuWfMsiBhsWaHrDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qC7u8fjT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tGk/d7ci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722519007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXiIJTWZEIl7vR9DhU1w6IJRUW9JpFHNQs0JlIhUbAw=;
	b=qC7u8fjTT+tFNUV6IUPCTYeN/02Z8SRsmzO75UaFsIvX/n+J11jfGHcBAP+C5ORbxKyr4Y
	cZeogKAZ+Jdo1pfojKN1bQ6p51MBE+oN0O6Kpt0iz1T6BGSxYp0ssseedtjzfqjqgiXHRs
	oZ9AU0X3yTxYVapFUqpAKPQruf7VEJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722519007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXiIJTWZEIl7vR9DhU1w6IJRUW9JpFHNQs0JlIhUbAw=;
	b=tGk/d7ciKdZqLYFMNwapCmfu8/kphu5jgNGDM6VFlt+zhpJypGnv+l1wTlAIEorhP7MJUY
	iuWfMsiBhsWaHrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FE8F136CF;
	Thu,  1 Aug 2024 13:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HLmaJt+Nq2Z9cAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Aug 2024 13:30:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 41728A08CB; Thu,  1 Aug 2024 15:30:07 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:30:07 +0200
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>, chuck.lever@oracle.com,
	jack@suse.cz, yangerkun <yangerkun@huawei.com>, hughd@google.com,
	zlang@kernel.org, fdmanana@suse.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <20240801133007.jf6m223mszye66e5@quack3>
References: <20240731043835.1828697-1-yangerkun@huawei.com>
 <20240731-pfeifen-gingen-4f8635e6ffcb@brauner>
 <9107aa4d-c888-3a73-0a07-a9d49f5ec558@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9107aa4d-c888-3a73-0a07-a9d49f5ec558@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: BCE1D219F9

On Thu 01-08-24 11:32:25, yangerkun wrote:
> Hi!
> 
> 在 2024/7/31 22:16, Christian Brauner 写道:
> > On Wed, 31 Jul 2024 12:38:35 +0800, yangerkun wrote:
> > > After we switch tmpfs dir operations from simple_dir_operations to
> > > simple_offset_dir_operations, every rename happened will fill new dentry
> > > to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> > > key starting with octx->newx_offset, and then set newx_offset equals to
> > > free key + 1. This will lead to infinite readdir combine with rename
> > > happened at the same time, which fail generic/736 in xfstests(detail show
> > > as below).
> > > 
> > > [...]
> > 
> > @Chuck, @Jan I did the requested change directly. Please check!
> 
> Thanks for applied this patch, the suggestions from Jan and Chuck will
> be a separates patch!

Christian already updated the patch as I've suggested so no need for you
to send anything.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

