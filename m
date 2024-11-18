Return-Path: <linux-fsdevel+bounces-35106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B99D136E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 15:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAB61F237CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 14:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F51B85FA;
	Mon, 18 Nov 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FoW/MwKZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5k7U3VH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FoW/MwKZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5k7U3VH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9741AA786;
	Mon, 18 Nov 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940869; cv=none; b=hvoRLBA30ACUoQYbihFfir5V2gGntU7xfHkwBh9DxJfjHn8D4chXJ/CKW0TjchBnqJffEppfIgTdNwwOTkxV/0TDNSjKb/aljTwzIKLyt+A0hGfc193YdK35ggwlBaptMPJTa0por2Je3QLKypF1MTg85zsuTol7yL39rlGLyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940869; c=relaxed/simple;
	bh=SIuvV3VD2j3G90+eZLIpoq2ZsTLJi+JfgetwI5O2vKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwOwFLmXhwmzKkvZRg8+T7clZ30uyJgjagn7BLzZ8bZ2rWbpT1kVfiYJwx+RweKAHIP/3O/l3tgo9c3XMOtrInpvViJeHGXI0aqL66LBnvcks+oyifcMe/d8bNReDV63aumOYlpizw4dloIzKS/5p3K6mBZfx9C83Eqf4z+nOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FoW/MwKZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5k7U3VH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FoW/MwKZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5k7U3VH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9BE9216E0;
	Mon, 18 Nov 2024 14:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731940864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+qp5UmTXJS4iT0bVhrQ+R9X2mN8vQAiVC4/OWr2qww=;
	b=FoW/MwKZ2TExqmpFJX4cxQdumGLcn1b5lPFHOITYfjSggpl+CQQUY/gVLWTpQXPkJMiXys
	izFNEGxVTdz39HoZ5GnM/htT3fWCHkLTL6MwE+CMaR15qOhoCYaR9CUnBBBCnr/3TszqCN
	5KCKee15SdcVUVWDZfExGFZUP4Li/zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731940864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+qp5UmTXJS4iT0bVhrQ+R9X2mN8vQAiVC4/OWr2qww=;
	b=V5k7U3VHtThbNP8MaNNlVPE0yM4vynIWceWwMnTjCgWDqPrIq9wE7/J9gzElRwH7Dj5Low
	yoHzcWLndCcvQHBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731940864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+qp5UmTXJS4iT0bVhrQ+R9X2mN8vQAiVC4/OWr2qww=;
	b=FoW/MwKZ2TExqmpFJX4cxQdumGLcn1b5lPFHOITYfjSggpl+CQQUY/gVLWTpQXPkJMiXys
	izFNEGxVTdz39HoZ5GnM/htT3fWCHkLTL6MwE+CMaR15qOhoCYaR9CUnBBBCnr/3TszqCN
	5KCKee15SdcVUVWDZfExGFZUP4Li/zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731940864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+qp5UmTXJS4iT0bVhrQ+R9X2mN8vQAiVC4/OWr2qww=;
	b=V5k7U3VHtThbNP8MaNNlVPE0yM4vynIWceWwMnTjCgWDqPrIq9wE7/J9gzElRwH7Dj5Low
	yoHzcWLndCcvQHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 977231376E;
	Mon, 18 Nov 2024 14:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIiwJABSO2ejfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 14:41:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1AF14A0984; Mon, 18 Nov 2024 15:41:04 +0100 (CET)
Date: Mon, 18 Nov 2024 15:41:04 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
Message-ID: <20241118144104.wjoxtdumjr4xaxcv@quack3>
References: <20241118085357.494178-1-mjguzik@gmail.com>
 <20241118115359.mzzx3avongvfqaha@quack3>
 <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 18-11-24 13:20:09, Mateusz Guzik wrote:
> On Mon, Nov 18, 2024 at 12:53 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 18-11-24 09:53:57, Mateusz Guzik wrote:
> > > This gives me about 1.5% speed up when issuing readlink on /initrd.img
> > > on ext4.
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > > ---
...
> > > I would leave something of that sort in if it was not defeating the
> > > point of the change.
> > >
> > > However, I'm a little worried some crap fs *does not* fill this in
> > > despite populating i_link.
> > >
> > > Perhaps it would make sense to keep the above with the patch hanging out
> > > in next and remove later?
> > >
> > > Anyhow, worst case, should it turn out i_size does not work there are at
> > > least two 4-byte holes which can be used to store the length (and
> > > chances are some existing field can be converted into a union instead).
> >
> > I'm not sure I completely follow your proposal here...
> >
> 
> I am saying if the size has to be explicitly stored specifically for
> symlinks, 2 options are:
> - fill up one of the holes
> - find a field which is never looked at for symlink inodes and convert
> into a union
> 
> I'm going to look into it.

I guess there's limited enthusiasm for complexity to achieve 1.5% improvement
in readlink which is not *that* common. But I haven't seen the patch and
other guys may have different opinions :) So we'll see.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

