Return-Path: <linux-fsdevel+bounces-47557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0EAA0401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68B3E48515B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CBA27604B;
	Tue, 29 Apr 2025 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZxKCraKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1y2b8hI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZxKCraKE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q1y2b8hI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2069275846
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909959; cv=none; b=Rnjdkwek9S74Bb2Ab1JgtZ1fQfN8RSYIurwYU/1+xEjER/SfHLbi/T5RBkzclg1tK/MwvwrOm/MSEDq3ZbOImVk5Vl69mWcL4uZ115xHo7YwgLvdoVxOi13HrEtwLaTFXnOwVBQj7L2fIoJak1kE1IPC83aKV4vJm4uyhDD0iRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909959; c=relaxed/simple;
	bh=WOOyR4H0WnOYLM04Sl1itjyZQdW7uOdWOdVx8PZrvME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZxAxzEYiSDF8hx/uoEyo90aavdDDbNu2lFxIA3ISQhIhKWSpxNo5t8xCYCusnZPsUdAFUuHTjV7imjZPlpGbs8K66h1HxBSJsm2JQgM0FS3MA9OVgjowgwNFo7y7A5A9FxDUuD+knp2KuHfhvT4FaiP3I3aKaLw/6l304PtEK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZxKCraKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q1y2b8hI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZxKCraKE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q1y2b8hI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A801F2174B;
	Tue, 29 Apr 2025 06:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745909953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrY9S7xjh97WVpYkr83+XLRZH2f8/RjGDBcWGtaiBpA=;
	b=ZxKCraKE1fUd5mSw+nlypw9VlzuC0no11dmrkV0Rri38Bn+7dxp52gyF5DyiZ5mhbYwmFX
	RPC0fKxrWdWvwCiHVeoPrgI+6xcVpi3cdNYKbjTjbjtzxpvXKdeAN/IJjZVZ8NxouEH3Le
	pb7/sVpWVa2HRS90iQMCQGdmr5cpUp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745909953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrY9S7xjh97WVpYkr83+XLRZH2f8/RjGDBcWGtaiBpA=;
	b=Q1y2b8hIDhooI8d/dA6qq9UWHdRH/6AuLrWADtZVBsz8wmDwbgzztpF/TEvZLWu81xkOku
	AwyE3xDSnCKcYRDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745909953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrY9S7xjh97WVpYkr83+XLRZH2f8/RjGDBcWGtaiBpA=;
	b=ZxKCraKE1fUd5mSw+nlypw9VlzuC0no11dmrkV0Rri38Bn+7dxp52gyF5DyiZ5mhbYwmFX
	RPC0fKxrWdWvwCiHVeoPrgI+6xcVpi3cdNYKbjTjbjtzxpvXKdeAN/IJjZVZ8NxouEH3Le
	pb7/sVpWVa2HRS90iQMCQGdmr5cpUp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745909953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrY9S7xjh97WVpYkr83+XLRZH2f8/RjGDBcWGtaiBpA=;
	b=Q1y2b8hIDhooI8d/dA6qq9UWHdRH/6AuLrWADtZVBsz8wmDwbgzztpF/TEvZLWu81xkOku
	AwyE3xDSnCKcYRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BA881340C;
	Tue, 29 Apr 2025 06:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mPl+IcF4EGiQaAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Apr 2025 06:59:13 +0000
Message-ID: <966924c1-54f7-45c9-9e5a-649d08ea3655@suse.cz>
Date: Tue, 29 Apr 2025 08:59:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] mm: establish mm/vma_exec.c for shared exec/mm VMA
 functionality
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn
 <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <91f2cee8f17d65214a9d83abb7011aa15f1ea690.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/28/25 17:28, Lorenzo Stoakes wrote:
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

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


