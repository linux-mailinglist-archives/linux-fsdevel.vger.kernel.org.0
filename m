Return-Path: <linux-fsdevel+bounces-47558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DA1AA0404
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B291E1667B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450042741DD;
	Tue, 29 Apr 2025 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N3+eLKPi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e0PycWnI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CaoR+gbv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQZf30C+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC62211460
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910291; cv=none; b=d9Rh+wehWG/QC29mnMRBlPpllYXTQuufIJs3yGyCcSaqbvcZomDC9WD+6vbMtHSJFiI1jRTCE55qS7dSv2EaqSm7Bqk8C1iKdvUhLDVxxcxyM8BGsoIiNwyA/MwouqvGTsQRTesTZ5ufjN8Dn0O+dzeKLfrBjtuqmCuK5qTFS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910291; c=relaxed/simple;
	bh=JtxlWTYotSvpVGuvio3XfF65pDQc1HIbrVH0hrdHEgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8R0SBe+pcAJbmQ0Q00fE0idpvhIV4RcpRzDjuR/FRVYN11iJaorLiSy4Z23x99MTUErYPoPsC/+/CkD+sIwuQ7gVigfsGkVzNfKGWY+msGDDUwLwg4Orao0Tjv9wWd1x1qgvZH0LraeBAjOP1skrT6SpkvYrbWYeNWZKOO06aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N3+eLKPi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e0PycWnI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CaoR+gbv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQZf30C+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BFC91F7C4;
	Tue, 29 Apr 2025 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745910288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqvsRhjnn+RZGEpmIR369oMtuYilqQjlvxG48FFcaPc=;
	b=N3+eLKPiHk+6Z1e5/cZ1jhgoqKXxatQKwKNT8jA4UzXpe2DGq2pKdbNoL54ht2lEGYn6s4
	Ojt4KsbNww3y16a+CFGTGZtp0AkyHBI8xQAvHGEwFacIXTuxOhRguokKYrObbNFUFDOfKr
	OAANUh2eMJ2Dp6xtJnCXCHg6Labun+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745910288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqvsRhjnn+RZGEpmIR369oMtuYilqQjlvxG48FFcaPc=;
	b=e0PycWnI+wqPkcJO95uWgA7G1ItlpnUjgTq8URK12OmFmdx8loJWhlLqvkMdu+SGLu1uft
	anbK4xz93mN4cQBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CaoR+gbv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OQZf30C+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745910287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqvsRhjnn+RZGEpmIR369oMtuYilqQjlvxG48FFcaPc=;
	b=CaoR+gbvIsfOyUE0JKLCpqlSd2oYalS+iwyL1yakadg+eXwtiZp3dixF0vNoIK/pQvM1CP
	ZAmLSRP7drWuJq5WRAaTVpBkZqZ4dfqBrSCyeIoHnmIBVm6ZOyX5qCkdtIo1G1NgO9omEh
	VsqqVNAMKcwOp61+wVDeb5Mzutwg78M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745910287;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MqvsRhjnn+RZGEpmIR369oMtuYilqQjlvxG48FFcaPc=;
	b=OQZf30C+m3KDGiZnMver31eip7JBc7O5UeqRfyhJGFgO07TBi9j3O/VlIMUcAi+4TvafQu
	ZvO3Mb68Lm9EBsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AA671340C;
	Tue, 29 Apr 2025 07:04:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1q05GQ96EGg6agAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 29 Apr 2025 07:04:47 +0000
Message-ID: <d1fbd13b-b2a4-4725-9676-7c7081230fb2@suse.cz>
Date: Tue, 29 Apr 2025 09:04:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm: abstract initial stack setup to mm subsystem
Content-Language: en-US
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
 <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8BFC91F7C4
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/28/25 17:28, Lorenzo Stoakes wrote:
> There are peculiarities within the kernel where what is very clearly mm
> code is performed elsewhere arbitrarily.
> 
> This violates separation of concerns and makes it harder to refactor code
> to make changes to how fundamental initialisation and operation of mm logic
> is performed.
> 
> One such case is the creation of the VMA containing the initial stack upon
> execve()'ing a new process. This is currently performed in __bprm_mm_init()
> in fs/exec.c.
> 
> Abstract this operation to create_init_stack_vma(). This allows us to limit
> use of vma allocation and free code to fork and mm only.
> 
> We previously did the same for the step at which we relocate the initial
> stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> establishment too.
> 
> Take the opportunity to also move insert_vm_struct() to mm/vma.c as it's no
> longer needed anywhere outside of mm.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


