Return-Path: <linux-fsdevel+bounces-67718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA70C47B30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 16:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBCE44F189E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE902741B6;
	Mon, 10 Nov 2025 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXaG3Q68";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="720y12/j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yXaG3Q68";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="720y12/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E8025B663
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789246; cv=none; b=WuUhYN9sJ5U35KMPsYfAzgPfRH03iJbUu2nsxHMeslCU5zLCfpcEShJVSNsgaFdjQxg97fB7yyY3WyF4rLJZVYCBVZV2Yu+ezrdccx5CPaG5385OAk3EMvDto57tsMk2TfLay5KrNci3dGypt6cqxoJJv7FyQaWbsR8bxQIFP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789246; c=relaxed/simple;
	bh=bakk/x+7ivr5WFpTz4ZoP8PZs34SMamXYUTpTCCzxQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB+MxZF5gAwW8dY52C34bP6zUIKyxhDN9EosO6GGBaUme+LalJcDz45Hp0OK5ZOg5v9SJRyfojvizsrltmsoxxB9NeBqkMXskBqESWfjRQJ5egqEHg03164wT3rb6hSDLCkVPUIo0wtwwKJ0vIIT0tk8Tux6djzhWrlJeKJzu/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yXaG3Q68; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=720y12/j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yXaG3Q68; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=720y12/j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C982333808;
	Mon, 10 Nov 2025 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762789241;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlrsgtG09qGxjpAiJIYhoUiJYVdUj4Y2K3a+i4ch7w8=;
	b=yXaG3Q68faWw+PJet4VjKz/N90j3Zyv0h81QrYibJsWUhPlHNlVWU040Ag7+BcJvZYctUv
	ILapRWLX0HSFR28/hjWTu/qIl9CkRypv11TWs1SF+ViB/uVnJaBnp/tO83IDqcDOj9a3gF
	K61iM7Rvu6dRCe/mKC3G17NW+Nadjz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762789241;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlrsgtG09qGxjpAiJIYhoUiJYVdUj4Y2K3a+i4ch7w8=;
	b=720y12/jGmSEA4LtosPDCijz87kMQDrMdien6pV8aJ/CNH47ouqvxo5Qwken1WQZcxsqWk
	A1Zt3q807NRUGJDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762789241;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlrsgtG09qGxjpAiJIYhoUiJYVdUj4Y2K3a+i4ch7w8=;
	b=yXaG3Q68faWw+PJet4VjKz/N90j3Zyv0h81QrYibJsWUhPlHNlVWU040Ag7+BcJvZYctUv
	ILapRWLX0HSFR28/hjWTu/qIl9CkRypv11TWs1SF+ViB/uVnJaBnp/tO83IDqcDOj9a3gF
	K61iM7Rvu6dRCe/mKC3G17NW+Nadjz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762789241;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlrsgtG09qGxjpAiJIYhoUiJYVdUj4Y2K3a+i4ch7w8=;
	b=720y12/jGmSEA4LtosPDCijz87kMQDrMdien6pV8aJ/CNH47ouqvxo5Qwken1WQZcxsqWk
	A1Zt3q807NRUGJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACA131447D;
	Mon, 10 Nov 2025 15:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /DP5KXkHEmlfVwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Nov 2025 15:40:41 +0000
Date: Mon, 10 Nov 2025 16:40:32 +0100
From: David Sterba <dsterba@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, tytso@mit.edu,
	torvalds@linux-foundation.org, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: utilize IOP_FASTPERM_MAY_EXEC
Message-ID: <20251110154032.GY13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251107142149.989998-1-mjguzik@gmail.com>
 <20251107142149.989998-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107142149.989998-3-mjguzik@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.com:email,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Fri, Nov 07, 2025 at 03:21:48PM +0100, Mateusz Guzik wrote:
> Root filesystem was ext4, btrfs was mounted on /testfs.
> 
> Then issuing access(2) in a loop on /testfs/repos/linux/include/linux/fs.h
> on Sapphire Rapids (ops/s):
> 
> before: 3447976
> after:	3620879 (+5%)
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Thanks.

Acked-by: David Sterba <dsterba@suse.com>

