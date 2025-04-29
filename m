Return-Path: <linux-fsdevel+bounces-47632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD45AA1782
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 19:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3FB4C30AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27972517A6;
	Tue, 29 Apr 2025 17:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I14MUTE2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7GSiurqq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="I14MUTE2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7GSiurqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2DF21ABC1
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948898; cv=none; b=NiP8RbfxtUP0xP8xapfqb+QqKXtierW4/j/Zzum0GC0Zv28nyQFti4WJaK2BThL7SBio0nmxsKQoUoZ/6ikfWhjR6cp+socNa3CfUFka9YYNrZ1ARtKhBzgHFSnhuo37b1AvhhhSkgHz+nwbqbNdjxhVtT4x5PnfUJSG79mzi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948898; c=relaxed/simple;
	bh=mxs4gTn2N125kC/LvbM1uX3xzjERcFtDjgSQkL8bJtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1XoDjrCuFX7nmSi6TroJ3c9TBOXAI36Y6p6SgpBlo5tJQ5l91YP8T+T+eUN6eVdKmcY986FrRxDBebPubtIXZO73gpFJLSj3XrLPPDFaedzIdjQi0vn85mGJtuq2n1McbIA2XGlGVr9m2GjVFjebtTGmG50SAQA5gLaqCz9j5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I14MUTE2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7GSiurqq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=I14MUTE2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7GSiurqq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BA704211F5;
	Tue, 29 Apr 2025 17:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745948894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cZq9dPFSRJYbWR4ZzbhKNrtoDXkEshJ45VJdmC5A6U=;
	b=I14MUTE2YqQpb0jIjfvbMoMwL/Rfc0fZCRA9jg5nW+8nOjwD+LNmX75+5yIGbZ/T7R/QWu
	zTlCx2V9bhhZ2GQFHu3ivCFDsDawqOmz+gcLlKDs9ZuJe6nHSa3RcQ6LGBDrOyceF6sED8
	ZbSOgsYxorVDmWHzD68yjl/102I6XjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745948894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cZq9dPFSRJYbWR4ZzbhKNrtoDXkEshJ45VJdmC5A6U=;
	b=7GSiurqqZDC1fMc5gNecPW6KuOSSG8wGuYY9fM1886Tt5A0ZtQMYJWCyB1MYnqAcApfr/w
	7PqtPDgzXaF8EiCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I14MUTE2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7GSiurqq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745948894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cZq9dPFSRJYbWR4ZzbhKNrtoDXkEshJ45VJdmC5A6U=;
	b=I14MUTE2YqQpb0jIjfvbMoMwL/Rfc0fZCRA9jg5nW+8nOjwD+LNmX75+5yIGbZ/T7R/QWu
	zTlCx2V9bhhZ2GQFHu3ivCFDsDawqOmz+gcLlKDs9ZuJe6nHSa3RcQ6LGBDrOyceF6sED8
	ZbSOgsYxorVDmWHzD68yjl/102I6XjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745948894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/cZq9dPFSRJYbWR4ZzbhKNrtoDXkEshJ45VJdmC5A6U=;
	b=7GSiurqqZDC1fMc5gNecPW6KuOSSG8wGuYY9fM1886Tt5A0ZtQMYJWCyB1MYnqAcApfr/w
	7PqtPDgzXaF8EiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4DA81340C;
	Tue, 29 Apr 2025 17:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KZ7CMN0QEWgcNgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 29 Apr 2025 17:48:13 +0000
Date: Tue, 29 Apr 2025 18:48:12 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm
 VMA functionality
Message-ID: <hz4fm3vw56ql5oewh2o3qszsqbig3bprx37ere7ch6v7pbgymg@lpusxxq2sija>
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Queue-Id: BA704211F5
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon, Apr 28, 2025 at 04:28:14PM +0100, Lorenzo Stoakes wrote:
> There is functionality that overlaps the exec and memory mapping
> subsystems. While it properly belongs in mm, it is important that exec
> maintainers maintain oversight of this functionality correctly.
> 
> We can establish both goals by adding a new mm/vma_exec.c file which
> contains these 'glue' functions, and have fs/exec.c import them.
> 
> As a part of this change, to ensure that proper oversight is achieved, add
> the file to both the MEMORY MAPPING and EXEC & BINFMT API, ELF sections.
> 
> scripts/get_maintainer.pl can correctly handle files in multiple entries
> and this neatly handles the cross-over.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>
-- 
Pedro

