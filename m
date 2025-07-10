Return-Path: <linux-fsdevel+bounces-54497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0226CB0032B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2053B9752
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488D22538F;
	Thu, 10 Jul 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ps4JuEGI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="S3rXCAZ0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DEawNO0+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dGivfsD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D82253A4
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153565; cv=none; b=dPooUwyPlC/KjjzrrtbOB3E19tHUUbO/OyYdrVJFZGLAcIPEDMKEi5DzLlbCTR8CvOABeXYt7DuTXg+f9WXAOv0goHx72eO4GFRDv8edQDqPKvyl8z/E6o0OnUnXtRm29tFB9RtqhQgUR8wm1e5BOsJk2Ji2ih0+y7zQc+XNRUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153565; c=relaxed/simple;
	bh=AF6+2zX8wb1MUyKUf0RHPK9Mqhph+YSgFjyITRnNUNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjq4+yqXqX2xJYbIs/9Mvn0lVVrcZxsya26w2ER5FPoiQU21zExT62pFTdXO/5tgzmYs9SYQOUr6K+i1HMj8btpbPlTrisDintQUPucOmwBqHyHj0lCtMCWzhRsCc4gP+AzzUh33zPEj6SHxNqps9jn5vBvwTL/mCiwBsy2sPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ps4JuEGI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=S3rXCAZ0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DEawNO0+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dGivfsD+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 210841F785;
	Thu, 10 Jul 2025 13:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752153562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDESiVf559zx0p6jexviCKkR6yPH61rymkbr1Slyd2Y=;
	b=Ps4JuEGINlI33trM5Ptqi7eTQ7ry5+/JxYWCxSkEq5LmK0GxwA2mqfhKcCLhumh4+VLMso
	kjWkrto2OGVhJAjg+SH5L5nNtWFhIJ0VRaF532mrHm7OiHgIQM31XueQHf5iUbeIvaS2ra
	ln+/eGnbM+9KN0yYlsSXoOATjDUg/Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752153562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDESiVf559zx0p6jexviCKkR6yPH61rymkbr1Slyd2Y=;
	b=S3rXCAZ0SSALYbMtmf5cP3SASLHmbVMa/m4Q7bihM3xb4WyeWi/r8A8hhNTiepL9f3nOXr
	pWTSKa1pErmvHXDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752153561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDESiVf559zx0p6jexviCKkR6yPH61rymkbr1Slyd2Y=;
	b=DEawNO0+5fN6YergZYd60ol9k4gU0EDqspKjamOQCY3nr10gpwh640mx/iT9a+Tuusumu1
	d+wh6BZTroiv/nuHV+DrHyMv1mwdDu4diS9NXLxyD3MDeW81LdxUGKTKnN3ZCilfhTskmD
	Jrx24jQXnYSIGXYUE4pUEnWO6ZdiCXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752153561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDESiVf559zx0p6jexviCKkR6yPH61rymkbr1Slyd2Y=;
	b=dGivfsD+1/yLNQLlYj9jZ8H9/SHJU/kZjVvITOjeIgy8mnmQlw99m6hSscKKc0peO+Iq7+
	EssY3J88jK5frBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15018136CB;
	Thu, 10 Jul 2025 13:19:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qPIcBdm9b2joHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Jul 2025 13:19:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BAB94A098F; Thu, 10 Jul 2025 15:19:20 +0200 (CEST)
Date: Thu, 10 Jul 2025 15:19:20 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] isofs: Verify inode mode when loading from disk
Message-ID: <w5v5cu3ljogzkck7hhyff5h3r3pfsgqxnryy3onwlvzug57sz5@wdfr4pzvphjc>
References: <20250709095545.31062-2-jack@suse.cz>
 <20250710-milchglas-entzaubern-17d9e0440a55@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-milchglas-entzaubern-17d9e0440a55@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[895c23f6917da440ed0d];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,appspotmail.com:email,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.30

On Thu 10-07-25 13:28:42, Christian Brauner wrote:
> On Wed, Jul 09, 2025 at 11:55:46AM +0200, Jan Kara wrote:
> > Verify that the inode mode is sane when loading it from the disk to
> > avoid complaints from VFS about setting up invalid inodes.
> > 
> > Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> 
> Thanks! You want me to throw that in vfs.fixes for this week?
> Acked-by: Christian Brauner <brauner@kernel.org>

OK, please go ahead. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

