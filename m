Return-Path: <linux-fsdevel+bounces-47332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AB7A9C30D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58B6921E7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAAD21D59B;
	Fri, 25 Apr 2025 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uQKULTGS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zQOWKp0D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uQKULTGS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zQOWKp0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5482153C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 09:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745572422; cv=none; b=TJ8xsNmxJx21Z2adx+EOpvO+ZhYB7JbfXJduTyqnsvKZP5mROwkq2ka9/n1eyY89cnJ9BRIuiarR1x0tZNSWHNmaDk0UFvkePuqa6u5+BU7C3nBaqibrmeyMG97RfBqWLuUE3ivAXClg2nDDXAWcHwdUoVOWuL+71Bi66dYiFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745572422; c=relaxed/simple;
	bh=hbAsa/ABnFkF+UFHf8+iOuqOHC4Cxk/Fhu3FtxRmOOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2YXctPFAB7BZrt7TIztSwpD/LQUwkKhJaPuYnMX6VT+gNn3WHqCi9of9Pzf7nXD38b2CqNqM20/oESBwvIDvhDv5S7GQHLrFRq62TCUwPY+6CYHqULl9HmdJY2bo7S1jCQBXMhRe6MUUC9c3cDhO3zG3TWqM1s4JK8X0PCwZvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uQKULTGS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zQOWKp0D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uQKULTGS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zQOWKp0D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C0980210F4;
	Fri, 25 Apr 2025 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745572417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXUDXhw17net05lqqHisrXbeaS6mPgXHDC3B6OTn9Tw=;
	b=uQKULTGSfxBxxB8sSbNAYciYun+rFVkSX6rXzJ8igjByBX01eMidEmRR40uhfsFv1F8GPE
	77pTqS0iKjs1QE3zw+8ZIB7tslPw+G3PRyqcUR7UaMvBTHhyPI0+wou9XaU/uFA0CInn27
	4MJoMv5bDypIB50eyf1GSYN7ZN2Ov2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745572417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXUDXhw17net05lqqHisrXbeaS6mPgXHDC3B6OTn9Tw=;
	b=zQOWKp0DzcJkhbXLeDO/rAe5OOcrVMOP+bV0DVJohyogkox4dVZTSi6MeVCRUv2M0Km7V1
	qrT0yum3abR2IJAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745572417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXUDXhw17net05lqqHisrXbeaS6mPgXHDC3B6OTn9Tw=;
	b=uQKULTGSfxBxxB8sSbNAYciYun+rFVkSX6rXzJ8igjByBX01eMidEmRR40uhfsFv1F8GPE
	77pTqS0iKjs1QE3zw+8ZIB7tslPw+G3PRyqcUR7UaMvBTHhyPI0+wou9XaU/uFA0CInn27
	4MJoMv5bDypIB50eyf1GSYN7ZN2Ov2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745572417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mXUDXhw17net05lqqHisrXbeaS6mPgXHDC3B6OTn9Tw=;
	b=zQOWKp0DzcJkhbXLeDO/rAe5OOcrVMOP+bV0DVJohyogkox4dVZTSi6MeVCRUv2M0Km7V1
	qrT0yum3abR2IJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B43BC13A79;
	Fri, 25 Apr 2025 09:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cc20KEBSC2jrDAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 25 Apr 2025 09:13:36 +0000
Date: Fri, 25 Apr 2025 10:13:35 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: move dup_mmap() to mm
Message-ID: <i4g4glnafku73cfsj6yrrkkjxe2yape2eeamqkaqrw3zs7q2wq@f3oa6qkumuer>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <4ee8edd6e54445b8af6077e6961543df6a639418.1745528282.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee8edd6e54445b8af6077e6961543df6a639418.1745528282.git.lorenzo.stoakes@oracle.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Apr 24, 2025 at 10:15:28PM +0100, Lorenzo Stoakes wrote:
> This is a key step in our being able to abstract and isolate VMA allocation
> and destruction logic.
> 
> This function is the last one where vm_area_free() and vm_area_dup() are
> directly referenced outside of mmap, so having this in mm allows us to
> isolate these.
> 
> We do the same for the nommu version which is substantially simpler.
> 
> We place the declaration for dup_mmap() in mm/internal.h and have
> kernel/fork.c import this in order to prevent improper use of this
> functionality elsewhere in the kernel.
> 
> While we're here, we remove the useless #ifdef CONFIG_MMU check around
> mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
> CONFIG_MMU is set.
> 
> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Have I told you how awesome you are? Thank you so much for the series!

-- 
Pedro

