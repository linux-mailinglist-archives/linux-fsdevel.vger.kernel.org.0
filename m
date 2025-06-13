Return-Path: <linux-fsdevel+bounces-51581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA5AD88B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 12:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA2343A5F57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03572D238B;
	Fri, 13 Jun 2025 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AUxQTGpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McazfDgL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AUxQTGpH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="McazfDgL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175B2D2387
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809154; cv=none; b=Mkw0GqNLKwg2u9B7OSpsBeBWxBl+ocvD7ZcohlfWfdvYRLJs4N55+47xigDxaTOYwuluvcvxVyOUbgCSSnnLZBYYgxxl5yabLCGrpn6JnENzoxKj5QAIRSaNlbKcgcxgHkWObTKkHOk0YyPwK6mcRiyyqw9Gq5qYjhn6Qalywyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809154; c=relaxed/simple;
	bh=rhDLxmUzdOZYUfItTP8OK56cRWXrFwbW9geC0CFGdP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQQ4d1bP4BEZ+Jhctyok5wQJdkiDDSiLet6Xq2QHpwQk3xBoVAl1nNhG9iQAotAPIgy6E+DpntoXIVBBqU54W5zEaTwCs/abhFGlMStKLR+KKorTBEDRX701OACxgLsyd/fx9OYEIPzTpGQlAxe5xKpnzukxn0hxOoE3Kga/Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AUxQTGpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McazfDgL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AUxQTGpH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=McazfDgL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1EBB211A3;
	Fri, 13 Jun 2025 10:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749809150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yylb4hQBQz+313tMAgSXb+o5BrsghwEgTj4lXT/ErSM=;
	b=AUxQTGpHfDmyp6nP8y3adCtgnnmgQLgsrXD2thiHYWJAs13uk4cz2sw7w6mwcmf6xlFE/x
	78ZHtKvcri9X3Jzfb9Uph3W2rke/No4PPqndm36DJ8cqneHHFP6F/JlMhEDRGJGiRF69vY
	aG9Vt4YyZTaAGbODExfACESncYY9H34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749809150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yylb4hQBQz+313tMAgSXb+o5BrsghwEgTj4lXT/ErSM=;
	b=McazfDgLm2nyQWLrw7vZrxeMy0PGWiIrxr560pkIfWN9+E4Q/VMaJXWKBMWUI3BanlXLyY
	kE3AOjw42CVPHQBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749809150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yylb4hQBQz+313tMAgSXb+o5BrsghwEgTj4lXT/ErSM=;
	b=AUxQTGpHfDmyp6nP8y3adCtgnnmgQLgsrXD2thiHYWJAs13uk4cz2sw7w6mwcmf6xlFE/x
	78ZHtKvcri9X3Jzfb9Uph3W2rke/No4PPqndm36DJ8cqneHHFP6F/JlMhEDRGJGiRF69vY
	aG9Vt4YyZTaAGbODExfACESncYY9H34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749809150;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yylb4hQBQz+313tMAgSXb+o5BrsghwEgTj4lXT/ErSM=;
	b=McazfDgLm2nyQWLrw7vZrxeMy0PGWiIrxr560pkIfWN9+E4Q/VMaJXWKBMWUI3BanlXLyY
	kE3AOjw42CVPHQBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A87D013782;
	Fri, 13 Jun 2025 10:05:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8rEeKf73S2idRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Jun 2025 10:05:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65B90A09B0; Fri, 13 Jun 2025 12:05:50 +0200 (CEST)
Date: Fri, 13 Jun 2025 12:05:50 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Luis Henriques <luis@igalia.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
Message-ID: <rkbycxlik4jcgyebnxqgxues5c4m44rthezk3rqot7ti4mlzkb@dttwxxk7kehk>
References: <87tt4u4p4h.fsf@igalia.com>
 <20250612094101.6003-1-luis@igalia.com>
 <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
 <3gvuqzzyhiz5is42h4rbvqx43q4axmo7ehubomijvbr5k25xgb@pwjvfuttjegk>
 <87v7p06dgv.fsf@igalia.com>
 <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGfa28YwprFpTOd6JnuQ7KAP=j36et=u5VrEhTek0HFtQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:email,suse.com:email]
X-Spam-Level: 

On Thu 12-06-25 23:35:09, Mateusz Guzik wrote:
> On Thu, Jun 12, 2025 at 8:07 PM Luis Henriques <luis@igalia.com> wrote:
> > > I guess the commit message could be improved. Something like:
> > >
> > > The assert in function file_seek_cur_needs_f_lock() can be triggered very
> > > easily because there are many users of vfs_llseek() (such as overlayfs)
> > > that do their custom locking around llseek instead of relying on
> > > fdget_pos(). Just drop the overzealous assertion.
> >
> > Thanks, makes more sense.
> >
> > Christian, do you prefer me to resend the patch or is it easier for you to
> > just amend the commit?  (Though, to be fair, the authorship could also be
> > changed as I mostly reported the issue and tested!)
> >
> 
> How about leaving a trace in the code.
> 
> For example a comment of this sort in place of the assert:
> Note that we are not guaranteed to be called after fdget_pos() on this
> file obj, in which case the caller is expected to provide the
> appropriate locking.

I'm not opposed to that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

