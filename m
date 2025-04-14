Return-Path: <linux-fsdevel+bounces-46402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61AA88883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 18:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64EF3B4297
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7282820AE;
	Mon, 14 Apr 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YVVRwPEC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+btaYtm/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YVVRwPEC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+btaYtm/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F227F721
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647817; cv=none; b=Y3oa68bEtvqFtMRI6zikWy1pOx6yT8n+Z9lFxCkXEhp2yzw5gh0DLH/6okceHXIlu7qTmM2WTZGMUh4kbTTZLP0y7TxY+lHgt8aFTjm0U6ZobRVpjkrQEegYWojDlVZg40VPssIHUWIm0bbbBxOTgzaaTbXziMsQcf6+mSO3FZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647817; c=relaxed/simple;
	bh=irp9PXJtIIx2teIMnPiDImHx5G/IpFENzHfE8+kY8bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VI43WHks08CR7sf8C9nYiVPdHMoPa7S0olMdG3yATwqd5DZXnmGJtWdhNzuRV6X5D87Qqejw3JH2Z60mwiKUmEsWFNxMI6vufDYiYLeBQolnfQ1E5GnRtujS8+uevI9xTdBfT4zd3BMSEJDHqtMJw0fEtdfJQqLXly7SLN1qzG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YVVRwPEC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+btaYtm/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YVVRwPEC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+btaYtm/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6659C1F7D6;
	Mon, 14 Apr 2025 16:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744647813;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d+JQuTBW77bWtfE5+W53YaiupIeeFOBZnWOzf0kq4/c=;
	b=YVVRwPECQmftqbDS5SLIeArNCXOHrD34/qEN8aRNBPRPUHFgGlN4QFQ5VmNeMy2cOE0Uu6
	cHR/mjKwbfeVHn7IWQBdyKOQS6xrkD+GsapGO8L9zArbBFoa0goUCli6F8ExykDolAATof
	EK1w2apUYDynErIcaZPtbJlpnZP1Suk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744647813;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d+JQuTBW77bWtfE5+W53YaiupIeeFOBZnWOzf0kq4/c=;
	b=+btaYtm/9AWveh+lTgvB8gdsjOn85Q4qHcinpVrGz4+srtVGTDRA6prKpO80Wb8u+axE7O
	CaxPKNkMSXDz3+Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YVVRwPEC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="+btaYtm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744647813;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d+JQuTBW77bWtfE5+W53YaiupIeeFOBZnWOzf0kq4/c=;
	b=YVVRwPECQmftqbDS5SLIeArNCXOHrD34/qEN8aRNBPRPUHFgGlN4QFQ5VmNeMy2cOE0Uu6
	cHR/mjKwbfeVHn7IWQBdyKOQS6xrkD+GsapGO8L9zArbBFoa0goUCli6F8ExykDolAATof
	EK1w2apUYDynErIcaZPtbJlpnZP1Suk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744647813;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d+JQuTBW77bWtfE5+W53YaiupIeeFOBZnWOzf0kq4/c=;
	b=+btaYtm/9AWveh+lTgvB8gdsjOn85Q4qHcinpVrGz4+srtVGTDRA6prKpO80Wb8u+axE7O
	CaxPKNkMSXDz3+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CB211336F;
	Mon, 14 Apr 2025 16:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yCuYDoU2/We6MwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Apr 2025 16:23:33 +0000
Date: Mon, 14 Apr 2025 18:23:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>,
	Viro <viro@zeniv.linux.org.uk>, Bacik <josef@toxicpanda.com>,
	Stone <leocstone@gmail.com>, Sandeen <sandeen@redhat.com>,
	Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Message-ID: <20250414162328.GD16750@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
 <Z_0aBN-20w20-UiD@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_0aBN-20w20-UiD@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 6659C1F7D6
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[foxmail.com,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,suse.com,zeniv.linux.org.uk,toxicpanda.com,gmail.com,redhat.com,oss.qualcomm.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 14, 2025 at 03:21:56PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 14, 2025 at 04:18:27PM +0200, Christian Brauner wrote:
> > On Mon, Apr 14, 2025 at 09:45:25PM +0800, now4yreal wrote:
> > > Dear Linux Security Maintainers,
> > > I would like to report a OOB-read vulnerability in the HFS+ file
> > > system, which I discovered using our in-house developed kernel fuzzer,
> > > Symsyz.
> > 
> > Bug reports from non-official syzbot instances are generally not
> > accepted.
> > 
> > hfs and hfsplus are orphaned filesystems since at least 2014. Bug
> > reports for such filesystems won't receive much attention from the core
> > maintainers.
> > 
> > I'm very very close to putting them on the chopping block as they're
> > slowly turning into pointless burdens.
> 
> I've tried asking some people who are long term Apple & Linux people,
> but haven't been able to find anyone interested in becoming maintainer.
> Let's drop both hfs & hfsplus.  Ten years of being unmaintained is
> long enough.

Agreed. If needed there are FUSE implementations to access .dmg files
with HFS/HFS+ or other standalone tools.

https://github.com/0x09/hfsfuse
https://github.com/darlinghq/darling-dmg

