Return-Path: <linux-fsdevel+bounces-18540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4D8BA390
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B20E283190
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54321360;
	Thu,  2 May 2024 22:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXFR8b+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNqahZD0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vXFR8b+4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HNqahZD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3D71C2AD;
	Thu,  2 May 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690646; cv=none; b=iJGP6xGPpgMl5ojVXS0srlWeewAw4xpVjxvHxWZjFlmM5TnnwiIsQPc5j5X7P55/6I2MoSkn2UO0ejEXUCvUUVlFgqF9zxsEWXpjpX5DxYkwmAgNwrcBUKl0D6fd9oCsPvrt9ThDQLimmlR7kVKOvLDjPXilcPuufVY3pjdL2og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690646; c=relaxed/simple;
	bh=KNuj+zPw1itV3KkMBcKodkx4OvddR49LGBRoZuKC0jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAtxZuLuvlYhcytpkBcwSWiWgr8dKLatm7G8A7EmXwEGa+Qevtf1OWoXEEJZIV/EpFwSa13SHfFiDBVN+WGu891d0dejgkrZBpSAITZ29yhwTDrNGS/v20mkx/3ZdpTGFMvgoyKdReSmorHh87HYCvMQzhmryAuOaiH6alUBono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXFR8b+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNqahZD0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vXFR8b+4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HNqahZD0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA8521B6D;
	Thu,  2 May 2024 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=vXFR8b+47fVienxCNHPpZEgaFl8IRR1Mv71xdUtU2622Csxiucd04oEJVudXAF/3dZZNOL
	5qNcdcB9sSojwmpUriiCZRok+GGh4OGmhrQ7fE2dhTP1etELCXv80VumvTxLCy0EOxtpo/
	H8bcJ9lxrkFjfxAvCydRKS1OSGHKjno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=HNqahZD0v59hLZv9836klkwGH5Zx+9048K1YzBWruiSenefzAMz0+ei9HFfuJv8vmMbSVh
	rve/oT7LivploiAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vXFR8b+4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HNqahZD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=vXFR8b+47fVienxCNHPpZEgaFl8IRR1Mv71xdUtU2622Csxiucd04oEJVudXAF/3dZZNOL
	5qNcdcB9sSojwmpUriiCZRok+GGh4OGmhrQ7fE2dhTP1etELCXv80VumvTxLCy0EOxtpo/
	H8bcJ9lxrkFjfxAvCydRKS1OSGHKjno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=HNqahZD0v59hLZv9836klkwGH5Zx+9048K1YzBWruiSenefzAMz0+ei9HFfuJv8vmMbSVh
	rve/oT7LivploiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D3EC1386E;
	Thu,  2 May 2024 22:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XE/sClIaNGauegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 22:57:22 +0000
Date: Fri, 3 May 2024 00:50:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/4] btrfs: Remove duplicate included header
Message-ID: <20240502225006.GU2585@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.17 / 50.00];
	BAYES_HAM(-2.96)[99.83%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,toxicpanda.com,suse.com,redhat.com,kernel.org,szeredi.hu,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4BA8521B6D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.17

On Thu, May 02, 2024 at 11:26:28PM +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/blkdev.h
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Added to for-next, thanks.

