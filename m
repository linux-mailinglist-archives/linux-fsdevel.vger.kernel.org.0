Return-Path: <linux-fsdevel+bounces-63268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B47FABB34AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F6819E658A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDD12F5492;
	Thu,  2 Oct 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lc/6wD/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcHAxREc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lc/6wD/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tcHAxREc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7701D2F546E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394470; cv=none; b=fU4e2jQZ0/GPKZq7dTjd/ncMx3apIDWAUx0GSJgaX0P9HIJUlhyhGMLdKxMBTbTotbbGllgNa3h4KoexF2v90iuA4dSubDZlyAdh7y8QoJ/fjY8BpT5YlZoBC7x5GL9OmrCFTVqk/5S4cavtu44PA3yLiHJno0Yw1RMf1VhDTKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394470; c=relaxed/simple;
	bh=/E6rhITb/cjoI1ukvXjl3cvtzThBqqtGQTWZo1ZqgVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atUm7nYydP2nrE4q2iw9BU6qDt+dHfcXqTgcSKNPqqXomNdH5hCo0TCqX/LZ7GMry9xLSmJ1jQ/iGw2uS8V+eG8jGUpA9KLeBJecLTLY/1hQaXJz0ov0PV1J3fh6oFwjxr2qGDFpbofi+ytA3+0U5qLGPWJXrRxd9CS19GLQLAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lc/6wD/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcHAxREc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lc/6wD/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tcHAxREc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 822D81F74C;
	Thu,  2 Oct 2025 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759394464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eH9XbwduDIGri+NeNAU5ni9kwX6UbbeLjDQ6VnltoGs=;
	b=Lc/6wD/ntXWlBNi5/ZRhd/7YAZ8sznPJBX5RHRHKfwGfFA7B1tTT3QywcSDV1sOk0siYjH
	R6hTmmAXBQb5d50njznYKxwYtXyLHanI1MbzPdd8LE2n2yQwo3SWXoEcpG3z9stQ7qfbpm
	x4wQvipkO62kRiyy+xPyT3Whtjqjc5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759394464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eH9XbwduDIGri+NeNAU5ni9kwX6UbbeLjDQ6VnltoGs=;
	b=tcHAxREcGQBo6JX8Gtg5ds/wKcoNyYsuRu/FipYhTxV6aRrGhQF7GO85yTn7yHDEWd2ZQa
	dfY0rdGFcBMCunAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759394464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eH9XbwduDIGri+NeNAU5ni9kwX6UbbeLjDQ6VnltoGs=;
	b=Lc/6wD/ntXWlBNi5/ZRhd/7YAZ8sznPJBX5RHRHKfwGfFA7B1tTT3QywcSDV1sOk0siYjH
	R6hTmmAXBQb5d50njznYKxwYtXyLHanI1MbzPdd8LE2n2yQwo3SWXoEcpG3z9stQ7qfbpm
	x4wQvipkO62kRiyy+xPyT3Whtjqjc5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759394464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eH9XbwduDIGri+NeNAU5ni9kwX6UbbeLjDQ6VnltoGs=;
	b=tcHAxREcGQBo6JX8Gtg5ds/wKcoNyYsuRu/FipYhTxV6aRrGhQF7GO85yTn7yHDEWd2ZQa
	dfY0rdGFcBMCunAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F4EF13A85;
	Thu,  2 Oct 2025 08:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id REPWGqA63mjbWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Oct 2025 08:41:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 15965A0A56; Thu,  2 Oct 2025 10:40:56 +0200 (CEST)
Date: Thu, 2 Oct 2025 10:40:56 +0200
From: Jan Kara <jack@suse.cz>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com, 
	torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org, 
	joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com, 
	johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu, willy@infradead.org, 
	david@fromorbit.com, amir73il@gmail.com, gregkh@linuxfoundation.org, 
	kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
	minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
	jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
	rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, linux-block@vger.kernel.org, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
	dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
	dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com, 
	hamohammed.sa@gmail.com, harry.yoo@oracle.com, chris.p.wilson@intel.com, 
	gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com, boqun.feng@gmail.com, 
	longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, yeoreum.yun@arm.com, 
	netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com, corbet@lwn.net, 
	catalin.marinas@arm.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, gustavo@padovan.org, 
	christian.koenig@amd.com, andi.shyti@kernel.org, arnd@arndb.de, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, 
	petr.pavlu@suse.com, da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
	josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
	jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, okorniev@redhat.com, 
	Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, anna@kernel.org, 
	kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
	mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
	wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, dwmw@amazon.co.uk, 
	shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, yuzhao@google.com, 
	baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, joel.granados@kernel.org, 
	richard.weiyang@gmail.com, geert+renesas@glider.be, tim.c.chen@linux.intel.com, 
	linux@treblig.org, alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
	chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, link@vivo.com, 
	jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
	thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, andrii@kernel.org, 
	wangfushuai@baidu.com, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, rcu@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v17 30/47] fs/jbd2: use a weaker annotation in journal
 handling
Message-ID: <bmthlv2tsd76mgzaoy5gspzdkved6le5xv23xjsc3yafkhrsgh@vvmjdwygm7gn>
References: <20251002081247.51255-1-byungchul@sk.com>
 <20251002081247.51255-31-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002081247.51255-31-byungchul@sk.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	FORGED_RECIPIENTS(2.00)[m:torvalds@linux-foundation.org,m:adilger.kernel@dilger.ca,m:peterz@infradead.org,m:will@kernel.org,m:tglx@linutronix.de,m:rostedt@goodmis.org,m:joel@joelfernandes.org,m:sashal@kernel.org,m:daniel.vetter@ffwll.ch,m:duyuyang@gmail.com,m:johannes.berg@intel.com,m:tj@kernel.org,m:willy@infradead.org,m:david@fromorbit.com,m:amir73il@gmail.com,m:kernel-team@lge.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:mhocko@kernel.org,m:minchan@kernel.org,m:hannes@cmpxchg.org,m:vdavydov.dev@gmail.com,m:sj@kernel.org,m:dennis@kernel.org,m:cl@linux.com,m:penberg@kernel.org,m:rientjes@google.com,m:jlayton@kernel.org,m:dan.j.williams@intel.com,m:hch@infradead.org,m:djwong@kernel.org,m:rodrigosiqueiramelo@gmail.com,m:melissa.srw@gmail.com,m:hamohammed.sa@gmail.com,m:chris.p.wilson@intel.com,m:gwan-gyeong.mun@intel.com,m:max.byungchul.park@gmail.com,m:boqun.feng@gmail.com,m:yunseong.kim@ericsson.com,m:ysk@kzalloc.com,m:yeoreum.yun@arm.com,m:matthew.brost@intel.com,m:her0g
 yugyu@gmail.com,m:catalin.marinas@arm.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:luto@kernel.org,m:sumit.semwal@linaro.org,m:christian.koenig@amd.com,m:andi.shyti@kernel.org,m:arnd@arndb.de,m:rppt@kernel.org,m:surenb@google.com,m:mcgrof@kernel.org,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:josh@joshtriplett.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:bsegall@google.com,s:linux-arm-kernel@lists.infradead.org,s:linaro-mm-sig@lists.linaro.org,s:linux-rt-devel@lists.linux.dev,s:ziy@nvidia.com,s:Dai.Ngo@oracle.com,s:okorniev@redhat.com,s:oleg@redhat.com,s:lillian@star-ark.net,s:tom@talpey.com,s:linux@treblig.org,s:francesco@valla.it,s:linux-arch@vger.kernel.org,s:linux-doc@vger.kernel.org,s:linux-i2c@vger.kernel.org,s:linux-media@vger.kernel.org,s:linux-modules@vger.ke
 rnel.org,s:linux-nfs@vger.kernel.org,s:rcu@vger.kernel.org,s:link@vivo.com];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	FREEMAIL_CC(0.00)[vger.kernel.org,skhynix.com,linux-foundation.org,opensource.wdc.com,dilger.ca,redhat.com,infradead.org,kernel.org,linutronix.de,goodmis.org,joelfernandes.org,ffwll.ch,gmail.com,intel.com,mit.edu,fromorbit.com,linuxfoundation.org,lge.com,kvack.org,cmpxchg.org,linux.com,google.com,suse.cz,vflare.org,toxicpanda.com,lists.freedesktop.org,oracle.com,ericsson.com,kzalloc.com,arm.com,lwn.net,alien8.de,linux.intel.com,zytor.com,linaro.org,padovan.org,amd.com,arndb.de,suse.com,nvidia.com,joshtriplett.org,efficios.com,linux.dev,suse.de,brown.name,talpey.com,huawei.com,amazon.co.uk,linux.alibaba.com,glider.be,treblig.org,star-ark.net,valla.it,vivo.com,baidu.com,lists.infradead.org,lists.linaro.org,lists.linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLzt4hq9gcka5b6gad13h5baos)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[150];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,sk.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -0.30

On Thu 02-10-25 17:12:30, Byungchul Park wrote:
> jbd2 journal handling code doesn't want jbd2_might_wait_for_commit()
> to be placed between start_this_handle() and stop_this_handle().  So it
> marks the region with rwsem_acquire_read() and rwsem_release().
> 
> However, the annotation is too strong for that purpose.  We don't have
> to use more than try lock annotation for that.
> 
> rwsem_acquire_read() implies:
> 
>    1. might be a waiter on contention of the lock.
>    2. enter to the critical section of the lock.
> 
> All we need in here is to act 2, not 1.  So trylock version of
> annotation is sufficient for that purpose.  Now that dept partially
> relies on lockdep annotaions, dept interpets rwsem_acquire_read() as a
> potential wait and might report a deadlock by the wait.
> 
> Replace it with trylock version of annotation.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Indeed. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/transaction.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index c7867139af69..b4e65f51bf5e 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -441,7 +441,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
>  	read_unlock(&journal->j_state_lock);
>  	current->journal_info = handle;
>  
> -	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 0, _THIS_IP_);
> +	rwsem_acquire_read(&journal->j_trans_commit_map, 0, 1, _THIS_IP_);
>  	jbd2_journal_free_transaction(new_transaction);
>  	/*
>  	 * Ensure that no allocations done while the transaction is open are
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

