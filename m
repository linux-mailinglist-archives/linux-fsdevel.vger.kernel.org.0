Return-Path: <linux-fsdevel+bounces-63490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD3BBE092
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27711895B4B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E07927FB03;
	Mon,  6 Oct 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="su7O18C6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jhIMcKH0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="su7O18C6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jhIMcKH0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B835898
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759753946; cv=none; b=T4goKTFD2tPqoV+oHE6AxZ1S4zIM05uzibDGIEzZNlWQbkMXEvt32h/yInD0z6NtEBRjOtVe/HReogURUzvFct2R5KSoFtFUMj8fN8P+aFAiUAfuWjjTPobEzSARHd+RxUfWrLr3O818zqnxBBVI4JKs2n7qVnVuDdsjMZJPkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759753946; c=relaxed/simple;
	bh=XJYntQAxh2nbIo08x/V1ydJNtTz8bw9uw/WScv/p590=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBcE1RRMnnTXDzIy+Hln8pqzu3N1W8Zg8/A1lhW+jVI1XNvC7oki30bzUWmWq3iWKfUhF0x+BU/l1KxIlMtFhfk/0pMWltrjstFYLWvMiUgQiNrdvdJzOYZ+V9335IN+2Lfk/EP317WQn02xaoQwGEMZuWZgx5D8CFktsatpZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=su7O18C6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jhIMcKH0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=su7O18C6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jhIMcKH0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 44EA31F451;
	Mon,  6 Oct 2025 12:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759753943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOGN6/92veWPJfNl1qSsRS9namz3eLYjXId15kwBES4=;
	b=su7O18C6jDtHyaqHYoGrDm4fezl3V1nrlzj03BEf+ZeSZ9U1qX5xs4nftAYSVK69AH/xMs
	Z88Zlq0KEvD+x/j2fYVc4ZQMzk4PQyOr1Yc+cBP0XLy/WHgHpLgECqxLahV7ipgABSKDNW
	HM2/4OcUYWr2Ba5Sje+sFPwXfk1hyYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759753943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOGN6/92veWPJfNl1qSsRS9namz3eLYjXId15kwBES4=;
	b=jhIMcKH08kKdGhtQVLA/AI0mOKrlNYblvOgKdm4J8WZXXWIxQnclR1qie9fR3HrwWxIj9n
	VkXj4gmgHBvYsnCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=su7O18C6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jhIMcKH0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759753943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOGN6/92veWPJfNl1qSsRS9namz3eLYjXId15kwBES4=;
	b=su7O18C6jDtHyaqHYoGrDm4fezl3V1nrlzj03BEf+ZeSZ9U1qX5xs4nftAYSVK69AH/xMs
	Z88Zlq0KEvD+x/j2fYVc4ZQMzk4PQyOr1Yc+cBP0XLy/WHgHpLgECqxLahV7ipgABSKDNW
	HM2/4OcUYWr2Ba5Sje+sFPwXfk1hyYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759753943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WOGN6/92veWPJfNl1qSsRS9namz3eLYjXId15kwBES4=;
	b=jhIMcKH08kKdGhtQVLA/AI0mOKrlNYblvOgKdm4J8WZXXWIxQnclR1qie9fR3HrwWxIj9n
	VkXj4gmgHBvYsnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39DC613995;
	Mon,  6 Oct 2025 12:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 268ZDte242gbeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Oct 2025 12:32:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E10D0A0ABD; Mon,  6 Oct 2025 14:32:14 +0200 (CEST)
Date: Mon, 6 Oct 2025 14:32:14 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
Message-ID: <v2bklzsfbqerlpbuqb5yjk66h2yldoxjfauixu5amlyfi3ayfg@fd5zqbptgbmv>
References: <20251005231526.708061-1-mjguzik@gmail.com>
 <3ectwcds3gwiicciapcktvrmxhau3t7ans5ipzm5xkhpptc2fc@td2jicn5kd5s>
 <CAGudoHFU7F07kavPxpEo7dxF1aWofu2i1xK_FENFhCRawK0s4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFU7F07kavPxpEo7dxF1aWofu2i1xK_FENFhCRawK0s4g@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 44EA31F451
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Mon 06-10-25 14:20:25, Mateusz Guzik wrote:
> On Mon, Oct 6, 2025 at 2:15 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 06-10-25 01:15:26, Mateusz Guzik wrote:
> > > diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> > > index 22dd4adc5667..e1e1231a6830 100644
> > > --- a/include/linux/writeback.h
> > > +++ b/include/linux/writeback.h
> > > @@ -194,6 +194,10 @@ static inline void wait_on_inode(struct inode *inode)
> > >  {
> > >       wait_var_event(inode_state_wait_address(inode, __I_NEW),
> > >                      !(READ_ONCE(inode->i_state) & I_NEW));
> > > +     /*
> > > +      * Pairs with routines clearing I_NEW.
> > > +      */
> > > +     smp_rmb();
> >
> > ... smp_load_acquire() instead if READ_ONCE? That would seem like a more
> > "modern" way to fix this?
> >
> 
> Now that the merge window flurry has died down I'll be posting an
> updated i_state accessor patchset.
> 
> Then I would need to add inode_state_read_once_acquire() and
> inode_state_clear_release() to keep up with this.
> 
> I figured I'll spare it for the time being, worst case can be added later.
> 
> That aside I have a wip patch to not require fences here and instead
> take advantage of the i_lock held earlier, so I expect this to go away
> anyway.

Fair enough, I was just wondering :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

