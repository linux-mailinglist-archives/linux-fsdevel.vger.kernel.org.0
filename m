Return-Path: <linux-fsdevel+bounces-36533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B099E55E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 13:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39908164E21
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B592218AA9;
	Thu,  5 Dec 2024 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3VgvCjl0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGcc631f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3VgvCjl0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QGcc631f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB925765
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403353; cv=none; b=BEEwWOKuhf4/hPPMBf0wCtSxG9XIMC4O8bHQ9qvjpJDp06i8amMDLZgFtcSR9eS4YjnVvZqxxis5mRTpiG1LaViDA8X3AgcovCjGkbGPqmgoj5M6K1cEbq3zTXQMNt6cYQiirYNJDLSWwTZIWwDFlisvrOr4cx9PNjvQf455+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403353; c=relaxed/simple;
	bh=71VRvG1RV3pm+pr/PEQYovm9Kb5rkyNyaoca8NLuPP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9aFay2W6PSnDXJ0/kXmJ/+HDyiqqmy4MDDEfruZZrpohg5obbDNcRtxfkh9prz9KnAsB7qw+UJAyTkwXL4Av4JVm6GiblZKcWrpnr+3MVtid1D5WRvrKaYf4j3uvqVoehsbyN2cAr/LAMjVxKCBRkxxPm3oaFcsNp793thgjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3VgvCjl0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGcc631f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3VgvCjl0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QGcc631f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23D9E1F38F;
	Thu,  5 Dec 2024 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733403344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoyanajC1An/6EPnCMIi+QIBpBQwG28TfmpKAigSeOY=;
	b=3VgvCjl05tDgDe9WbFnMf8uDT465wm0ehKj0VgcUbSU1vMKhtbJpO3nKIciZMaq9Nx5RPy
	fVhaZqC+u85S/gywz7tHVVcMCE9ENhtTa+YnS0Z7EKDd2SbBESoyNkX5KGcrUK/AH/82mq
	4SwKqDk8RuShyXJWxpeTBxeR2LE19KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733403344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoyanajC1An/6EPnCMIi+QIBpBQwG28TfmpKAigSeOY=;
	b=QGcc631fbO0ApUAei8rp1M24wAWZShcjr6g76l/YV7awN7VUvhMTuczJirp/iHxLwBost9
	px9aKUu648PsCADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733403344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoyanajC1An/6EPnCMIi+QIBpBQwG28TfmpKAigSeOY=;
	b=3VgvCjl05tDgDe9WbFnMf8uDT465wm0ehKj0VgcUbSU1vMKhtbJpO3nKIciZMaq9Nx5RPy
	fVhaZqC+u85S/gywz7tHVVcMCE9ENhtTa+YnS0Z7EKDd2SbBESoyNkX5KGcrUK/AH/82mq
	4SwKqDk8RuShyXJWxpeTBxeR2LE19KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733403344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YoyanajC1An/6EPnCMIi+QIBpBQwG28TfmpKAigSeOY=;
	b=QGcc631fbO0ApUAei8rp1M24wAWZShcjr6g76l/YV7awN7VUvhMTuczJirp/iHxLwBost9
	px9aKUu648PsCADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 192CA132EB;
	Thu,  5 Dec 2024 12:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UrkeBtCiUWcCQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Dec 2024 12:55:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 55EF5A08CF; Thu,  5 Dec 2024 13:55:43 +0100 (CET)
Date: Thu, 5 Dec 2024 13:55:43 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: don't block write during exec on pre-content watched
 files
Message-ID: <20241205125543.gxqjzyeakwbugqwk@quack3>
References: <20241128142532.465176-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128142532.465176-1-amir73il@gmail.com>
X-Spam-Level: 
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 28-11-24 15:25:32, Amir Goldstein wrote:
> Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
> the legacy behavior of getting ETXTBSY on attempt to open and executable
> file for write while it is being executed.
> 
> This commit was reverted because an application that depends on this
> legacy behavior was broken by the change.
> 
> We need to allow HSM writing into executable files while executed to
> fill their content on-the-fly.
> 
> To that end, disable the ETXTBSY legacy behavior for files that are
> watched by pre-content events.
> 
> This change is not expected to cause regressions with existing systems
> which do not have any pre-content event listeners.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

OK, I've picked up the patch to fsnotify_hsm branch with Christian's ack
and updated comments from Amir. Still waiting for Josef to give this a
final testing from their side but I've pulled the branch into for_next so
that it gets some exposure in linux-next as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

