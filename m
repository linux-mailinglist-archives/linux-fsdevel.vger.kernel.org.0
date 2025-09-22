Return-Path: <linux-fsdevel+bounces-62386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A4CB906EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A0416D9F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F73305E33;
	Mon, 22 Sep 2025 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IS9jDZb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3VfEr7r0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IS9jDZb7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3VfEr7r0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C48304BB7
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541002; cv=none; b=ik5YqlUOIlpa4x3+D57B2izP7KCtIGm2uSUZn2Yqtgi11XfEvD+TbI4UihaVVJl3Q37uAoQh3X95mLYqAogMVUsuER7ruKQvcGyFI2eJj8T5xmrsJ4KlZ17/ToDBaZmyt07Q53kUtV8x5SburdpeATzPnKPIPbfxItiwv7CETKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541002; c=relaxed/simple;
	bh=kkNhVeZpRse5oW7veI0pE7fHvKzqf64GeObKpVskqYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DayxuKLAih2TxgXIKkymN5C6vBXBp13c+8CeDZezgLLAb9eslXdUNOn4A5dfZrmvnVEo1OTHE6LBYf425VOo8f1PZ1Uk/GdUBoeL7DaDz9HRbh34YjXRGoQPm0gsVVPoib1uCeO7bu6bY6yoDnHzeKiLYDphSRI4Stak+epiTXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IS9jDZb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3VfEr7r0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IS9jDZb7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3VfEr7r0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB5D63376E;
	Mon, 22 Sep 2025 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758540998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0RJyZZPvFp9TX9buI7nY53vpzwr3HwAsT0O6tYQKA=;
	b=IS9jDZb7QlC8Vhj30PPYZknp0EPRAO8alpWW/GgEiIeIsJ7kYMvm9nW0oFxeuNqglnvDBl
	nQQz6Ie87uCJWtiKh/QJdBePopBlRN+MCvj4qBGnCxNZteOAcVUEROgkmr3TGwyhT0svIr
	hi/zB40EDoaBCj2AMBh3JznMabTDM3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758540998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0RJyZZPvFp9TX9buI7nY53vpzwr3HwAsT0O6tYQKA=;
	b=3VfEr7r0A4ZmP3zGguAMZC4lYTJAM6/F9x+kvmPZvZUGowqk6ptdCFKU7zuVCEQY8PCpRr
	5ZIsNwW4v7WsQnAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758540998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0RJyZZPvFp9TX9buI7nY53vpzwr3HwAsT0O6tYQKA=;
	b=IS9jDZb7QlC8Vhj30PPYZknp0EPRAO8alpWW/GgEiIeIsJ7kYMvm9nW0oFxeuNqglnvDBl
	nQQz6Ie87uCJWtiKh/QJdBePopBlRN+MCvj4qBGnCxNZteOAcVUEROgkmr3TGwyhT0svIr
	hi/zB40EDoaBCj2AMBh3JznMabTDM3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758540998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9O0RJyZZPvFp9TX9buI7nY53vpzwr3HwAsT0O6tYQKA=;
	b=3VfEr7r0A4ZmP3zGguAMZC4lYTJAM6/F9x+kvmPZvZUGowqk6ptdCFKU7zuVCEQY8PCpRr
	5ZIsNwW4v7WsQnAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9366A13A63;
	Mon, 22 Sep 2025 11:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Te/4I8Y00Wj0UwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Sep 2025 11:36:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 267FBA07C4; Mon, 22 Sep 2025 13:36:38 +0200 (CEST)
Date: Mon, 22 Sep 2025 13:36:38 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Russell Haley <yumpusamongus@gmail.com>, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v5 0/4] hide ->i_state behind accessors
Message-ID: <ui5ek5me3j56y5iw3lyckwmf7lag4du5w2axfomy73wwijnf4n@rudaeiphf5oi>
References: <20250919154905.2592318-1-mjguzik@gmail.com>
 <73885a08-f255-4638-8a53-f136537f4b4c@gmail.com>
 <CAGudoHHnhej-jxkSBG5im+QXh5GZfp1KsO40EV=PPDxuGbco8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHnhej-jxkSBG5im+QXh5GZfp1KsO40EV=PPDxuGbco8Q@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 20-09-25 07:47:46, Mateusz Guzik wrote:
> On Sat, Sep 20, 2025 at 6:31 AM Russell Haley <yumpusamongus@gmail.com> wrote:
> >
> > On 9/19/25 10:49 AM, Mateusz Guzik wrote:
> > > This is generated against:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries
> > >
> > > First commit message quoted verbatim with rationable + API:
> > >
> > > [quote]
> > > Open-coded accesses prevent asserting they are done correctly. One
> > > obvious aspect is locking, but significantly more can checked. For
> > > example it can be detected when the code is clearing flags which are
> > > already missing, or is setting flags when it is illegal (e.g., I_FREEING
> > > when ->i_count > 0).
> > >
> > > Given the late stage of the release cycle this patchset only aims to
> > > hide access, it does not provide any of the checks.
> > >
> > > Consumers can be trivially converted. Suppose flags I_A and I_B are to
> > > be handled, then:
> > >
> > > state = inode->i_state        => state = inode_state_read(inode)
> > > inode->i_state |= (I_A | I_B)         => inode_state_add(inode, I_A | I_B)
> > > inode->i_state &= ~(I_A | I_B)        => inode_state_del(inode, I_A | I_B)
> > > inode->i_state = I_A | I_B    => inode_state_set(inode, I_A | I_B)
> > > [/quote]
> >
> > Drive-by bikeshedding: s/set/replace/g
> >
> > "replace" removes ambiguity with the concept of setting a bit ( |= ). An
> > alternative would be "set_only".
> >
> 
> I agree _set may be ambiguous here. I was considering something like
> _assign or _set_value instead.

I agree _assign might be a better option. In fact my favorite variant would
be:

inode_state_set() - setting bit in state
inode_state_clear() - clearing bit in state
inode_state_assign() - assigning value to state

But if you just rename inode_state_set() to inode_state_assign() that would
be already good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

