Return-Path: <linux-fsdevel+bounces-21425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24D69039C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 13:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C81C1F2190A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6E17B402;
	Tue, 11 Jun 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nqm19qzn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eb/6ZUfB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nqm19qzn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Eb/6ZUfB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A9D13E8AE;
	Tue, 11 Jun 2024 11:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718104553; cv=none; b=OH0unHqU2Qsymn7SVJPKZvCq7lbLtqbPzKm1GL9av36lkjCmIx71pCDNBBaDcw++YrwzcIqa2uoink9CwNfRn+WGrzjM6qlDmn6iqNKFhc9xsEccBb69x5ZjpxcisSA862ZD36B/IH/TgutN8zErR0sPmh4PLQ1EGmEWLg6senI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718104553; c=relaxed/simple;
	bh=wLlEjNnzc77MHds09//3ZWA8yzW84d+3berw4cdRI4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U64ci/ZGfgp79JWpGVkPbPPJXIcP9x5aeheM2OvNBxvJLGE1ZlTGFKof9HEVE6gsk9S8sqpVF17hCxqOaxO6aEW6iJn/9Q6MfXhmzuhj13fbA6nVFcghfcg4TaC0Oe4DjLNOy9uy9Avyzq/UlcAOw5g3rNzQZQTS/h+55QrCsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nqm19qzn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eb/6ZUfB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nqm19qzn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Eb/6ZUfB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B42B933703;
	Tue, 11 Jun 2024 11:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718104549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXIgfjlBRvIxj2UUaKKzitcAEWvUbEosp8O96prSVHw=;
	b=Nqm19qznq0BamDdu8undHDhi2aufLJ1iM0EIE6UGrsJ2BHKljszboE8wx4aSNoxtjufoQw
	YHbVSEvwtYQZEkt7eL2EyBeRPrE56sCejuKUG/DjXwsIA6lqEfq5syFMBR4/rDt/HBnSAP
	y5lAgHZO6XpZ/UpwRm8/2p+IWLgeLIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718104549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXIgfjlBRvIxj2UUaKKzitcAEWvUbEosp8O96prSVHw=;
	b=Eb/6ZUfB7XtI5PBZhSOt10RjtD7zulPGqnp+zGp4eTxG2M6lXa5hiwZAg5sezIHPzISArY
	YO/tq9EuDka6emBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nqm19qzn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Eb/6ZUfB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718104549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXIgfjlBRvIxj2UUaKKzitcAEWvUbEosp8O96prSVHw=;
	b=Nqm19qznq0BamDdu8undHDhi2aufLJ1iM0EIE6UGrsJ2BHKljszboE8wx4aSNoxtjufoQw
	YHbVSEvwtYQZEkt7eL2EyBeRPrE56sCejuKUG/DjXwsIA6lqEfq5syFMBR4/rDt/HBnSAP
	y5lAgHZO6XpZ/UpwRm8/2p+IWLgeLIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718104549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bXIgfjlBRvIxj2UUaKKzitcAEWvUbEosp8O96prSVHw=;
	b=Eb/6ZUfB7XtI5PBZhSOt10RjtD7zulPGqnp+zGp4eTxG2M6lXa5hiwZAg5sezIHPzISArY
	YO/tq9EuDka6emBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FC0B13A55;
	Tue, 11 Jun 2024 11:15:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCXwEOUxaGaOFQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Jun 2024 11:15:49 +0000
Date: Tue, 11 Jun 2024 13:15:47 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v1 2/6] fs/proc/task_mmu: don't indicate
 PM_MMAP_EXCLUSIVE without PM_PRESENT
Message-ID: <Zmgx42q2bA7zLSJ-@localhost.localdomain>
References: <20240607122357.115423-1-david@redhat.com>
 <20240607122357.115423-3-david@redhat.com>
 <ZmaFxfQX3AVMIVkp@localhost.localdomain>
 <2b912e12-8289-4ce8-99bb-103a289a23cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b912e12-8289-4ce8-99bb-103a289a23cb@redhat.com>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B42B933703
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Tue, Jun 11, 2024 at 12:50:46PM +0200, David Hildenbrand wrote:
> I *think* we still want that for indicating PM_FILE after patch #1.

Yes, we do, disregard that comment please.


-- 
Oscar Salvador
SUSE Labs

