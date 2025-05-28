Return-Path: <linux-fsdevel+bounces-50008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4817FAC73E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 00:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2038F1C03015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67534221721;
	Wed, 28 May 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ty8+naf1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kd4qRZnn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ty8+naf1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kd4qRZnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4571D7E5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 May 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748470887; cv=none; b=NMHEcmqyuseUqKRReOiRnUydQhfLb9DPeEs6itjWcqhrqvHvrch7ZweoHFtmi1HmPArEWlgsscXwDO/FurcZY4wEMmP7zayrWVIwshGmPldv3sySJ7VRHUO4QX06YQbPKc9kOHWXrMoEtQml9kFJWJ02Xi6lg60/eQdWl8zcGjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748470887; c=relaxed/simple;
	bh=FnR+4+b/l1nZeDzTpvOnJTe+qz9W/iK7frMcm2M2Rb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lip/RuLWLxuC3QOQO8elHiDMFb9Dfg3KIb5M9nPtkq84+tjTf+TLwoQTUCCI16WnfD59onyYdw2fR5ho8y/kNlg6mKendT4DhciETfpbWwI9Q6xEzVWOJh27JiAtq3fg1JgpTNlTxfh+vJZ74eMXORgDoI07o6g7t4x7gdpanY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ty8+naf1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kd4qRZnn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ty8+naf1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kd4qRZnn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BDD21F79C;
	Wed, 28 May 2025 22:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748470884;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcs6PeQ5LYK8Vz7ip+tNDGCLt/08EZqVgWOSZJmlnm4=;
	b=Ty8+naf1waxXzboVdgyIaQT20cGyhy6jvPGdFrqc5BIIeeZjErFLbxTn+is+Ni/EA/AuJF
	l9qI2Cr0W8pcQxUxxyEfnLQlx+oqNo3hRoPvBeTGR8AbbFnRtEmlp6Fbquk0VKtfuQqs3M
	g4GWLSVv2/OqUyRT5BgaoyPz0bIqu3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748470884;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcs6PeQ5LYK8Vz7ip+tNDGCLt/08EZqVgWOSZJmlnm4=;
	b=Kd4qRZnnVFKEQzm3Fw5IEFy/nyoLoZlG3aPLOcUJx/3Nlejw2sKSBPu4Gfqeq5QoKbhpOz
	aSEM4K0jRookwpAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748470884;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcs6PeQ5LYK8Vz7ip+tNDGCLt/08EZqVgWOSZJmlnm4=;
	b=Ty8+naf1waxXzboVdgyIaQT20cGyhy6jvPGdFrqc5BIIeeZjErFLbxTn+is+Ni/EA/AuJF
	l9qI2Cr0W8pcQxUxxyEfnLQlx+oqNo3hRoPvBeTGR8AbbFnRtEmlp6Fbquk0VKtfuQqs3M
	g4GWLSVv2/OqUyRT5BgaoyPz0bIqu3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748470884;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kcs6PeQ5LYK8Vz7ip+tNDGCLt/08EZqVgWOSZJmlnm4=;
	b=Kd4qRZnnVFKEQzm3Fw5IEFy/nyoLoZlG3aPLOcUJx/3Nlejw2sKSBPu4Gfqeq5QoKbhpOz
	aSEM4K0jRookwpAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D31D136E3;
	Wed, 28 May 2025 22:21:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGGcBmSMN2hxTQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 22:21:24 +0000
Date: Thu, 29 May 2025 00:21:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Ming Lei <ming.lei@redhat.com>,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [Bug] v6.15+: kernel panic when mount & umount btrfs
Message-ID: <20250528222122.GH4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CAFj5m9LWYk4OX8UijOutKFV-Hgga_w7KPT=MRLLyOscKBwCA-g@mail.gmail.com>
 <5e7d42e4-7d77-4926-b2fd-593ea581477d@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e7d42e4-7d77-4926-b2fd-593ea581477d@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, May 27, 2025 at 02:51:33PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/27 13:36, Ming Lei 写道:
> > Hello,
> > 
> > Just try the latest linus tree by running `rublk` builtin test on
> > Fedora, and found
> > the following panic:
> > 
> > git clone https://github.com/ublk-org/rublk
> > cd rublk
> > cargo test
> 
> There is a bug in commit 5e121ae687b8 ("btrfs: use buffer xarray for 
> extent buffer writeback operations"), and there is already a fix queued 
> for the next pull request:
> 
> https://lore.kernel.org/linux-btrfs/b964b92f482453cbd122743995ff23aa7158b2cb.1747677774.git.josef@toxicpanda.com/

Now merged to master.

