Return-Path: <linux-fsdevel+bounces-21867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739CB90C72B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 12:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C58C1C21690
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147C91AC420;
	Tue, 18 Jun 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pdlMEW1V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pdlMEW1V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1813B5B5;
	Tue, 18 Jun 2024 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699728; cv=none; b=VG1J9JWHTRwOC9+FK+mVUFexkwTRP59oEYbajuKxBpnmbsYVCYKeSd/YiWpGMVWhiDWAuGWWEEt2yvtQ6op5lGeMlOILHecxD/dQReNoeBWHN92PcakMcx/78XKcOkPQEZDA7gBM+34t9XWYlj7SyYN+g0ZilbT4Yq3rPSbHCo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699728; c=relaxed/simple;
	bh=qnTGA3t+pZ+nh0aZAynmbaV7VbCEqz9aJjGtpnTcg1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgmUoCuGaoeqWzx5yPupdcY8xgZqk5UgNLl2jhasudaE5i7J/E1qTMKIK2ykYFXdbxgo5I/uKhrwxQDcNgaStRN0UTKmaXRV47R8LaYgYGTbkANtmi46RHZGKG9ycRSxvjOFn9ggdXz1W30cy/CZoACdsJJRLh7QjtbWwnZliT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pdlMEW1V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pdlMEW1V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 329661F458;
	Tue, 18 Jun 2024 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718699724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0U9CGlVSI1JeEsrMqZfn0xKjDwE4c1YMWoj8UyAw2XI=;
	b=pdlMEW1V3Yuk9jtLisNSVO2grecddwP5pO+CjIq7/fpbkvMOnY1qARHyEaeMBS39GmhU16
	+PYAOPFQOxPEu+bMjfOEPTEybsDq9YdvW3zJEkU3adfHMl+z18aT4vZWwAPhGuVhDpB4se
	1hHjEnmBxIYYpdrtpW6EG5RkVFnHV20=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718699724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0U9CGlVSI1JeEsrMqZfn0xKjDwE4c1YMWoj8UyAw2XI=;
	b=pdlMEW1V3Yuk9jtLisNSVO2grecddwP5pO+CjIq7/fpbkvMOnY1qARHyEaeMBS39GmhU16
	+PYAOPFQOxPEu+bMjfOEPTEybsDq9YdvW3zJEkU3adfHMl+z18aT4vZWwAPhGuVhDpB4se
	1hHjEnmBxIYYpdrtpW6EG5RkVFnHV20=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1512A1369F;
	Tue, 18 Jun 2024 08:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 230aAsxGcWavBwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 18 Jun 2024 08:35:24 +0000
Date: Tue, 18 Jun 2024 10:35:23 +0200
From: Michal Hocko <mhocko@suse.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Yu Ma <yu.ma@intel.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
Message-ID: <ZnFGy2nYI9XZSvMl@tiehlicka>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
 <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
 <fd4eb382a87baed4b49e3cf2cd25e7047f9aede2.camel@linux.intel.com>
 <8fa3f49b50515f8490acfe5b52aaf3aba0a36606.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa3f49b50515f8490acfe5b52aaf3aba0a36606.camel@linux.intel.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 17-06-24 11:04:41, Tim Chen wrote:
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 3a2df1bd9f64..b4e523728c3e 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1471,6 +1471,7 @@ static int do_prlimit(struct task_struct *tsk, unsigned int resource,
>                 return -EINVAL;
>         resource = array_index_nospec(resource, RLIM_NLIMITS);
>  
> +       task_lock(tsk->group_leader);
>         if (new_rlim) {
>                 if (new_rlim->rlim_cur > new_rlim->rlim_max)
>                         return -EINVAL;

This is clearly broken as it leaves the lock behind on the error, no?
-- 
Michal Hocko
SUSE Labs

