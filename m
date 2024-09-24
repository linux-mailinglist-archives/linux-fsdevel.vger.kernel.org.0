Return-Path: <linux-fsdevel+bounces-29970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91043984332
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 12:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10B971F2361F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01816F8EB;
	Tue, 24 Sep 2024 10:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wH2AhbmJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mpks5XCQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wH2AhbmJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mpks5XCQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05413B780;
	Tue, 24 Sep 2024 10:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172691; cv=none; b=q23DBwrV3GVAfIf6uCmNygWVEvurnatGhUzjLwEw9ken9ecLZuzO04DQ0zJvt9DvoAF9s4OCzF8LWo4t4yLdUjKSW0tm0nHFNV7oKghVvwtt2acG7BZvV/czURThCAKV1VvW9ei1a0vrnW46F1wCflPM7loOzfG0TPe4VOWkpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172691; c=relaxed/simple;
	bh=QUsmLd3zzHcx/v7WmMBRwvO3NBj0nNB5T9UJvBy/D+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Grhm4B6DQ6PvMcCQKx4wFOgfkKDUDCblWaX537+20pMkNbUrEDhZyGifCgWpmL767K32iKjGE3Ad2DSP/zJe1XaFD7lR9sVHEfgeEB8t7WRkZYkZcaR7yJe8XZrxA3Hh6EJFCmI2SRqUTy4QptfEl7v0/bETCsyLUcTkZ0iZ+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wH2AhbmJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mpks5XCQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wH2AhbmJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mpks5XCQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0653021A39;
	Tue, 24 Sep 2024 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727172688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ+ZBbCZ06n6ana7hUvQHivY4XNZ9A8Dw3+YCjAwxj0=;
	b=wH2AhbmJxrZ6+tbnoF972uiKEK8qldYwU5PL3u8tKYLaT3ON1eO8RJaaXuz0RTIPRNA5PQ
	MuSgeodSKxofPb6YVtek+ISc5XXMONKqMOpeboBPDPVa7lbcGx09eFQFYpZfjhjuhI8oZG
	66OiMQna7CSpYeTIQQjvZRC+OdO7RCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727172688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ+ZBbCZ06n6ana7hUvQHivY4XNZ9A8Dw3+YCjAwxj0=;
	b=Mpks5XCQRG+9B0ebU/ZiXreOVQ1yIZhiMhZyDOvzasP9Z8BEmp3iuZ8CHngUaazmo/xEZT
	Sv7QEjV5B2ljv3BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wH2AhbmJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Mpks5XCQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727172688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ+ZBbCZ06n6ana7hUvQHivY4XNZ9A8Dw3+YCjAwxj0=;
	b=wH2AhbmJxrZ6+tbnoF972uiKEK8qldYwU5PL3u8tKYLaT3ON1eO8RJaaXuz0RTIPRNA5PQ
	MuSgeodSKxofPb6YVtek+ISc5XXMONKqMOpeboBPDPVa7lbcGx09eFQFYpZfjhjuhI8oZG
	66OiMQna7CSpYeTIQQjvZRC+OdO7RCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727172688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ+ZBbCZ06n6ana7hUvQHivY4XNZ9A8Dw3+YCjAwxj0=;
	b=Mpks5XCQRG+9B0ebU/ZiXreOVQ1yIZhiMhZyDOvzasP9Z8BEmp3iuZ8CHngUaazmo/xEZT
	Sv7QEjV5B2ljv3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAFC713AA8;
	Tue, 24 Sep 2024 10:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t+RoNU+Q8mbnGAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Sep 2024 10:11:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 879ECA088D; Tue, 24 Sep 2024 12:11:19 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:11:19 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 03/10] ext4: drop ext4_update_disksize_before_punch()
Message-ID: <20240924101119.xzejk3a2rjmgqed7@quack3>
References: <20240904062925.716856-1-yi.zhang@huaweicloud.com>
 <20240904062925.716856-4-yi.zhang@huaweicloud.com>
 <20240920161351.ax3oidpt6w6bf3o4@quack3>
 <5de46c69-74f4-4955-a825-8c8970c0aa09@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de46c69-74f4-4955-a825-8c8970c0aa09@huaweicloud.com>
X-Rspamd-Queue-Id: 0653021A39
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 24-09-24 15:43:22, Zhang Yi wrote:
> On 2024/9/21 0:13, Jan Kara wrote:
> > On Wed 04-09-24 14:29:18, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Since we always write back dirty data before zeroing range and punching
> >> hole, the delalloc extended file's disksize of should be updated
> >> properly when writing back pages, hence we don't need to update file's
> >> disksize before discarding page cache in ext4_zero_range() and
> >> ext4_punch_hole(), just drop ext4_update_disksize_before_punch().
> >>
> >> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > 
> > So when we don't write out before hole punching & company this needs to stay
> > in some shape or form. 
> > 
> 
> Thanks for taking time to review this series!
> 
> I don't fully understand this comment, please let me confirm. Do you
> suggested that we still don't write out all the data before punching /
> zeroing / collapseing(i.e. drop patch 01), so we need to keep
> ext4_update_disksize_before_punch()(i.e. also drop this patch), is
> that right?

Yes, this is what I meant. Sorry for not being clear.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

