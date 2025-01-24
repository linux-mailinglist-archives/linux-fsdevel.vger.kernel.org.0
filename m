Return-Path: <linux-fsdevel+bounces-40095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2846EA1BEBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 23:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13083A1268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 22:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8761EEA32;
	Fri, 24 Jan 2025 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7zF2oHG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IEqLlSww";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k7zF2oHG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IEqLlSww"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F281E7C28
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jan 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759421; cv=none; b=nlYBdIW3vdBhQRi37/rhAVHYr8dCAAg/jtvTnGZGVu+ZUoPeQC/cjdivdz1dS0a7K2hyVIshpfbVMaSwmdflfvLzdhjU+KGrWzXW1PF12tSuGcmwYwF94FnHLDAHm+GvoneW0tQrsa6wW/M2Zl46gdRinOPqGIVI2RKL3nMwKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759421; c=relaxed/simple;
	bh=jmzOuXG2rNjKbyuG7xdRA2xxij+8FfnciAZGTJsFflE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gUaqh1XP8GHa9P8m7fVcCFtQdMdxvZeKZNxVzHGSyMJbip9nlx0pAE8wOP1wVH3HaBHKa7/vxfRzog1T00z/gKJGll7mN/aYMNz8GpDiAO6sOSdCMWDPiGrSQE6f4VWZrwUYa5VQevt59ZLYtwVKInuvNCCV39ZZDoxaS71UeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7zF2oHG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IEqLlSww; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k7zF2oHG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IEqLlSww; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B7B221176;
	Fri, 24 Jan 2025 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737759417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3K4AJIa200keHH0QoxzQzUKcTn22qzmok+HQaOIlzY=;
	b=k7zF2oHGCetbyFU3BLEjGDvtyyrSNbVBziEgoPema1Qpkip8YPUhMVImGmYLuSASoM7gE9
	uhwNF4DoOStfkJl9OHhizCElITt0GpxMOI9qzVt60xpOPLvBTqCOEzDVPe+GIxCwJ+UzD5
	qy6wA2gSOg28atRKY7GwUo10diJyW8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737759417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3K4AJIa200keHH0QoxzQzUKcTn22qzmok+HQaOIlzY=;
	b=IEqLlSww+jW/XGW/JuXNr/XXDR3Y0uanMy6ZxEzG/a8G0MHzd8KmGQGuV/Pzb8y94TM+L9
	1ophYWk9sAtlQdBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=k7zF2oHG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IEqLlSww
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737759417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3K4AJIa200keHH0QoxzQzUKcTn22qzmok+HQaOIlzY=;
	b=k7zF2oHGCetbyFU3BLEjGDvtyyrSNbVBziEgoPema1Qpkip8YPUhMVImGmYLuSASoM7gE9
	uhwNF4DoOStfkJl9OHhizCElITt0GpxMOI9qzVt60xpOPLvBTqCOEzDVPe+GIxCwJ+UzD5
	qy6wA2gSOg28atRKY7GwUo10diJyW8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737759417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W3K4AJIa200keHH0QoxzQzUKcTn22qzmok+HQaOIlzY=;
	b=IEqLlSww+jW/XGW/JuXNr/XXDR3Y0uanMy6ZxEzG/a8G0MHzd8KmGQGuV/Pzb8y94TM+L9
	1ophYWk9sAtlQdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01ED213999;
	Fri, 24 Jan 2025 22:56:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S6xdKrYalGe3dQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Jan 2025 22:56:54 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Matthew Wilcox" <willy@infradead.org>
Cc: "Day, Timothy" <timday@amazon.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "jsimmons@infradead.org" <jsimmons@infradead.org>,
 "Andreas Dilger" <adilger@ddn.com>
Subject: Re: [LSF/MM/BPF TOPIC] Lustre filesystem upstreaming
In-reply-to: <Z5QBiMvc-A2bJXwh@casper.infradead.org>
References: <5A3D5719-1705-466D-9A86-96DAFD7EAABD@amazon.com>,
 <Z5QBiMvc-A2bJXwh@casper.infradead.org>
Date: Sat, 25 Jan 2025 09:56:47 +1100
Message-id: <173775940732.22054.17125851881123194733@noble.neil.brown.name>
X-Rspamd-Queue-Id: 1B7B221176
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 25 Jan 2025, Matthew Wilcox wrote:
> 
> Ultimately, I think you'll want to describe the workflow you see Lustre
> adopting once it's upstream -- I've had too many filesystems say to me
> "Oh, you have to submit your patch against our git tree and then we'll
> apply it to the kernel later".  That's not acceptable; the kernel is
> upstream, not your private git tree.
> 
> 

While I generally agree with your sentiment, I think there is more
nuance in the details than you portray.
With nfsd, for example, I can sometimes submit patches against mainline
but sometimes need to submit against nfsd-next or even nfsd-testing if
someone else has been working in the same area.  And it may well be a
couple of releases "later" that it lands in Linus' kernel - though that
isn't the norm.

But certainly we need to be clear about the workflow - not least within
the lustre community who are used to a very different work-flow and will
need to learn.

Thanks,
NeilBrown

