Return-Path: <linux-fsdevel+bounces-63099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A58BABF00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 09:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021C51C77A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE512D6E7E;
	Tue, 30 Sep 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u0p1Q8gS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NdPYsCdH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u0p1Q8gS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NdPYsCdH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57982D2390
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219086; cv=none; b=VBF/PiqBTEDAMisAaveYiar1vxgBF4k8cke8gbLZTMZiOnF0EYpeeUIntOrpxnUD6pY/DZSZwnggnWf4JUc8J/xgiSD9TyAgYaWV6Nro++1Fz2CCGUpXheDFrS2LSlwdDMHoc4GAkMxH/eE68pWG2nv/JZdAtP1UnREz6b93Owo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219086; c=relaxed/simple;
	bh=dyHrNKhlaGEqKnZIkxKIKpqw/oxL+OlmCmlVUELNwtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrE5V6m2qqW/GfBhCDo7QaLctZT+zcszcLLBqlCXLKxgYs21F4wa+3C5ibSIO1MHA15syq8KcOnc4kHdWS0MLSAYXrPgDNhC0jQB6sjHkUaW75maOlvwTlKhPRjNEzpZ3wYoLWT2v45Q40io4orW2DAR7/ffXPlzMnndpaAYKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u0p1Q8gS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NdPYsCdH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u0p1Q8gS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NdPYsCdH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D7731F7CD;
	Tue, 30 Sep 2025 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759219082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk1gsMk0QelnoO6w1JKGM4UTxDkJoTyWgBsg6//Qo9M=;
	b=u0p1Q8gS4nMRjOnr/+DAF3rX41IhFA7l5jjI3PntQpeIlfYEH9+CF8ba6NlOsviSPJIKQv
	jLUesd/x5OJVjxLqSv6AFWEZNXrkmsFkYSMDNTuNYu7uMMT3fucKPGQUDqLPldjJnu1Vtv
	7D7x/M2SByB17ZY2aAL/Z27IsVdVMN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759219082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk1gsMk0QelnoO6w1JKGM4UTxDkJoTyWgBsg6//Qo9M=;
	b=NdPYsCdHhcGYmJ233LBom0yCvp69T9kCdhSDrNO4vbbOjd+mXnCmJcmiNTmP+FsfgpT1ZC
	CSbeAtXApLzxJhAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u0p1Q8gS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NdPYsCdH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759219082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk1gsMk0QelnoO6w1JKGM4UTxDkJoTyWgBsg6//Qo9M=;
	b=u0p1Q8gS4nMRjOnr/+DAF3rX41IhFA7l5jjI3PntQpeIlfYEH9+CF8ba6NlOsviSPJIKQv
	jLUesd/x5OJVjxLqSv6AFWEZNXrkmsFkYSMDNTuNYu7uMMT3fucKPGQUDqLPldjJnu1Vtv
	7D7x/M2SByB17ZY2aAL/Z27IsVdVMN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759219082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nk1gsMk0QelnoO6w1JKGM4UTxDkJoTyWgBsg6//Qo9M=;
	b=NdPYsCdHhcGYmJ233LBom0yCvp69T9kCdhSDrNO4vbbOjd+mXnCmJcmiNTmP+FsfgpT1ZC
	CSbeAtXApLzxJhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 815EB1342D;
	Tue, 30 Sep 2025 07:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0fdLH4qN22jYWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 30 Sep 2025 07:58:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 391D2A0AB8; Tue, 30 Sep 2025 09:58:02 +0200 (CEST)
Date: Tue, 30 Sep 2025 09:58:02 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: EXPORT_FH_FID not working properly?
Message-ID: <r5dqm4nzw7jcowu6gsyreh4wpaton34uurqgfaywvqjf47cg5l@gxlegqf6bg2n>
References: <lhqfyklsgrcabcgduwmycv26ljt4u4ttj2jzf24rjf2rdvbjmn@ei4jfb66h7yg>
 <CAOQ4uxhdE_djxgp-4vy16+6pfPW0ufR3yqh7i1BbRG4theTDXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhdE_djxgp-4vy16+6pfPW0ufR3yqh7i1BbRG4theTDXg@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8D7731F7CD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On Mon 29-09-25 19:19:12, Amir Goldstein wrote:
> On Mon, Sep 29, 2025 at 5:59 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello Amir!
> >
> > I was looking into exportfs_can_encode_fh() today and after commit
> > 5402c4d4d200 ("exportfs: require ->fh_to_parent() to encode connectable
> > file handles") we immediately return false if the filesystem has no
> > export_operations. However for the case with EXPORT_FH_FID I suppose we
> > want to allow !nop case as well and use the default encoding function? At
> > least that's what all the other code seems to be doing... Am I missing
> > something?
> 
> I don't think you are missing anything.

Thanks for confirmation. I'll send a fix.

> That's probably a regression, but a regression in a use case that is
> not tested by LTP.
> I think that all the filesystems that LTP tests do have export_operations?

Yes, we'll need to find some fs without export ops that's convenient to
test in LTP :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

