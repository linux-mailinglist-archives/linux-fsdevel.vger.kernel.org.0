Return-Path: <linux-fsdevel+bounces-34892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D019CDD5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 12:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0590283AB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 11:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB91B85E2;
	Fri, 15 Nov 2024 11:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqB1BP1x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kN03Zm3u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HqB1BP1x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kN03Zm3u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0531A9B43;
	Fri, 15 Nov 2024 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731669559; cv=none; b=JB0NNUNT2tJmkMjFI/+SLChkNJxGQrpcjWBpIwFDAyeEebMMACkEpsGRPi1BVI56q0ebzlfw2a+ChwgV/2R9DyMsrHUz0OUfKQX/fcGWVoRCJYw5R6CTZb4h0crDbTCZEoGPuCnTLtI+oXMiy7+Mi5fmohqYVlNBdl+HF9+T+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731669559; c=relaxed/simple;
	bh=HePw0MhTX+2YKPo/iddO/0Ka/yHkSPd7A7ISGLWLO/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSwFOZ84r286Uljuy9Jip6ZrvB0BlJmr40ccQbSW5cQ4jki8f01hfLscZAICb2eSVMqBbbEabLp37O1O6gi7eDx4Qp9+cZK/VCAmI2TPi9/55ldYd72KswjTAGbrhkXyC0jldaT1j+CwzK9S6tY9OryjojKthMXz/yL875k1XvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqB1BP1x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kN03Zm3u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HqB1BP1x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kN03Zm3u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 66D4D1F78E;
	Fri, 15 Nov 2024 11:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731669555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2hitBIn/xJ/t6vXV9cjGhmEmqYY65JSS4l5iwoyulE=;
	b=HqB1BP1xoRavXLQZ10yzG5Jz95Rxvyz0olma1J6dqoOHKNSzB5h7AijiZCUQSN7xytAVGT
	EyeUpdI9mp8bVZfgoVg0I1T3WrF8CjSrbRObRU+PdJUG+cGmTBGmY7ppnfTpQ3qciQ6Ami
	RrjbDej1r1vzTIIpK3PkcP6jI3hLAks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731669555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2hitBIn/xJ/t6vXV9cjGhmEmqYY65JSS4l5iwoyulE=;
	b=kN03Zm3uq8j++R+E7iMTpLyDYip5aPZ3wpc7polciyLkdruD6FsrHMpcBVW6+tgqnfppb2
	xyip8F1RpLBa9VCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731669555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2hitBIn/xJ/t6vXV9cjGhmEmqYY65JSS4l5iwoyulE=;
	b=HqB1BP1xoRavXLQZ10yzG5Jz95Rxvyz0olma1J6dqoOHKNSzB5h7AijiZCUQSN7xytAVGT
	EyeUpdI9mp8bVZfgoVg0I1T3WrF8CjSrbRObRU+PdJUG+cGmTBGmY7ppnfTpQ3qciQ6Ami
	RrjbDej1r1vzTIIpK3PkcP6jI3hLAks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731669555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I2hitBIn/xJ/t6vXV9cjGhmEmqYY65JSS4l5iwoyulE=;
	b=kN03Zm3uq8j++R+E7iMTpLyDYip5aPZ3wpc7polciyLkdruD6FsrHMpcBVW6+tgqnfppb2
	xyip8F1RpLBa9VCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 596C613485;
	Fri, 15 Nov 2024 11:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HyjRFTMuN2eIaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 15 Nov 2024 11:19:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0879FA0986; Fri, 15 Nov 2024 12:19:14 +0100 (CET)
Date: Fri, 15 Nov 2024 12:19:14 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <songliubraving@meta.com>
Cc: Christian Brauner <brauner@kernel.org>, Song Liu <song@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"eddyz87@gmail.com" <eddyz87@gmail.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"mattbobrowski@google.com" <mattbobrowski@google.com>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"repnop@google.com" <repnop@google.com>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"mic@digikod.net" <mic@digikod.net>,
	"gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
Message-ID: <20241115111914.qhrwe4mek6quthko@quack3>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86C65B85-8167-4D04-BFF5-40FD4F3407A4@fb.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,meta.com,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com,toxicpanda.com,digikod.net];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi Song!

On Thu 14-11-24 21:11:57, Song Liu wrote:
> > On Nov 13, 2024, at 2:19 AM, Christian Brauner <brauner@kernel.org> wrote:
> >> static inline void bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
> >>   bpf_func_t *bpf_func)
> >> {
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index 3559446279c1..479097e4dd5b 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -79,6 +79,7 @@ struct fs_context;
> >> struct fs_parameter_spec;
> >> struct fileattr;
> >> struct iomap_ops;
> >> +struct bpf_local_storage;
> >> 
> >> extern void __init inode_init(void);
> >> extern void __init inode_init_early(void);
> >> @@ -648,6 +649,9 @@ struct inode {
> >> #ifdef CONFIG_SECURITY
> >> void *i_security;
> >> #endif
> >> +#ifdef CONFIG_BPF_SYSCALL
> >> + struct bpf_local_storage __rcu *i_bpf_storage;
> >> +#endif
> > 
> > Sorry, we're not growing struct inode for this. It just keeps getting
> > bigger. Last cycle we freed up 8 bytes to shrink it and we're not going
> > to waste them on special-purpose stuff. We already NAKed someone else's
> > pet field here.
> 
> Per other discussions in this thread, I am implementing the following:
> 
> #ifdef CONFIG_SECURITY
>         void                    *i_security;
> #elif CONFIG_BPF_SYSCALL
>         struct bpf_local_storage __rcu *i_bpf_storage;
> #endif
> 
> However, it is a bit trickier than I thought. Specifically, we need 
> to deal with the following scenarios:
>  
> 1. CONFIG_SECURITY=y && CONFIG_BPF_LSM=n && CONFIG_BPF_SYSCALL=y
> 2. CONFIG_SECURITY=y && CONFIG_BPF_LSM=y && CONFIG_BPF_SYSCALL=y but 
>    bpf lsm is not enabled at boot time. 
> 
> AFAICT, we need to modify how lsm blob are managed with 
> CONFIG_BPF_SYSCALL=y && CONFIG_BPF_LSM=n case. The solution, even
> if it gets accepted, doesn't really save any memory. Instead of 
> growing struct inode by 8 bytes, the solution will allocate 8
> more bytes to inode->i_security. So the total memory consumption
> is the same, but the memory is more fragmented. 

I guess you've found a better solution for this based on James' suggestion.

> Therefore, I think we should really step back and consider adding
> the i_bpf_storage to struct inode. While this does increase the
> size of struct inode by 8 bytes, it may end up with less overall
> memory consumption for the system. This is why. 
>
> When the user cannot use inode local storage, the alternative is 
> to use hash maps (use inode pointer as key). AFAICT, all hash maps 
> comes with non-trivial overhead, in memory consumption, in access 
> latency, and in extra code to manage the memory. OTOH, inode local 
> storage doesn't have these issue, and is usually much more efficient: 
>  - memory is only allocated for inodes with actual data, 
>  - O(1) latency, 
>  - per inode data is freed automatically when the inode is evicted. 
> Please refer to [1] where Amir mentioned all the work needed to 
> properly manage a hash map, and I explained why we don't need to 
> worry about these with inode local storage. 

Well, but here you are speaking of a situation where bpf inode storage
space gets actually used for most inodes. Then I agree i_bpf_storage is the
most economic solution. But I'd also expect that for vast majority of
systems the bpf inode storage isn't used at all and if it does get used, it
is used only for a small fraction of inodes. So we are weighting 8 bytes
per inode for all those users that don't need it against more significant
memory savings for users that actually do need per inode bpf storage. A
factor in this is that a lot of people are running some distribution kernel
which generally enables most config options that are at least somewhat
useful. So hiding the cost behind CONFIG_FOO doesn't really help such
people.
 
I'm personally not *so* hung up about a pointer in struct inode but I can
see why Christian is and I agree adding a pointer there isn't a win for
everybody.

Longer term, I think it may be beneficial to come up with a way to attach
private info to the inode in a way that doesn't cost us one pointer per
funcionality that may possibly attach info to the inode. We already have
i_crypt_info, i_verity_info, i_flctx, i_security, etc. It's always a tough
call where the space overhead for everybody is worth the runtime &
complexity overhead for users using the functionality...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

