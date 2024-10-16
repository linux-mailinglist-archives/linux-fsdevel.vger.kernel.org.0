Return-Path: <linux-fsdevel+bounces-32116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310D89A0BEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07091F2595F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2E920C007;
	Wed, 16 Oct 2024 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AsiOM4mf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBghvIRd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AsiOM4mf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qBghvIRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110720820A;
	Wed, 16 Oct 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086719; cv=none; b=PejVbARBgVWlbS1V3/PRLBsgX0aiXiStVc8lLAprlVqYYSnhyJSiKQcMbkNqh84ohl4CRbCUTFKX9SrM2lIDdDAXjgkI7ZBvvcJfmlqZJMtbXz3dGZsTQ/p5UQEuNocmMbYPCsCF8IERgQdgaPN/sJP1N6KMI7j5yqcYaNFGfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086719; c=relaxed/simple;
	bh=DWQ7RdvxMh79BGxRz+YxrTb7/Lx9P6586w9IrLq2x8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW4IO2bV0rMsHGaxBpw/Q9anPvRYFcRXyaVf0Bery4Ob+y206024MVYbcWHSFGGXjYSu1NKSKfiR0pxJPi/BF7EX2YjD9P/uf4EPFfZXXzdU8i4a/PzJig9cKD9XpjyStZgQdTxBc5PcbjEy4XpRm4HA9QfmJ29o/kXofIa/9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AsiOM4mf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBghvIRd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AsiOM4mf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qBghvIRd; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2A5321EAA;
	Wed, 16 Oct 2024 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729086715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3wv4yqacmb75aYc5wEkO0vOWfKEn8YYdrxO0bffVo8=;
	b=AsiOM4mfG3BL6xi564bu83wyPjpSB8RATC3GouGs4STKw9tQIm+0FI6suKceGWDSTFRmjC
	hV2e2ZORH0O4nAUGtmq+LWtrUuMC1HkqPCXDHVQAzyznRHS//5IGXA4/s/kIDn4DWiIal0
	Pnrh9YenuWQyFqnSuCSuFQt2Aq19E7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729086715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3wv4yqacmb75aYc5wEkO0vOWfKEn8YYdrxO0bffVo8=;
	b=qBghvIRdzWmWKMrGwmhkVKanR2h0VTiXyM0ydZXrcIDyjYaSLaCVnkO2wSS0PAx0kCIyKD
	y3uAfnOUHKa7laCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729086715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3wv4yqacmb75aYc5wEkO0vOWfKEn8YYdrxO0bffVo8=;
	b=AsiOM4mfG3BL6xi564bu83wyPjpSB8RATC3GouGs4STKw9tQIm+0FI6suKceGWDSTFRmjC
	hV2e2ZORH0O4nAUGtmq+LWtrUuMC1HkqPCXDHVQAzyznRHS//5IGXA4/s/kIDn4DWiIal0
	Pnrh9YenuWQyFqnSuCSuFQt2Aq19E7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729086715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3wv4yqacmb75aYc5wEkO0vOWfKEn8YYdrxO0bffVo8=;
	b=qBghvIRdzWmWKMrGwmhkVKanR2h0VTiXyM0ydZXrcIDyjYaSLaCVnkO2wSS0PAx0kCIyKD
	y3uAfnOUHKa7laCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A10801376C;
	Wed, 16 Oct 2024 13:51:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w6hGJ/vED2f8EQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 16 Oct 2024 13:51:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A177A083E; Wed, 16 Oct 2024 15:51:55 +0200 (CEST)
Date: Wed, 16 Oct 2024 15:51:55 +0200
From: Jan Kara <jack@suse.cz>
To: Song Liu <songliubraving@meta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Extend test fs_kfuncs to
 cover security.bpf xattr names
Message-ID: <20241016135155.otibqwcyqczxt26f@quack3>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-3-song@kernel.org>
 <Zw34dAaqA5tR6mHN@infradead.org>
 <0DB83868-0049-40E3-8E62-0D8D913CB9CB@fb.com>
 <Zw384bed3yVgZpoc@infradead.org>
 <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BF0CD913-B067-4105-88C2-B068431EE9E5@fb.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,meta.com,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 15-10-24 05:52:02, Song Liu wrote:
> > On Oct 14, 2024, at 10:25 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, Oct 15, 2024 at 05:21:48AM +0000, Song Liu wrote:
> >>>> Extend test_progs fs_kfuncs to cover different xattr names. Specifically:
> >>>> xattr name "user.kfuncs", "security.bpf", and "security.bpf.xxx" can be
> >>>> read from BPF program with kfuncs bpf_get_[file|dentry]_xattr(); while
> >>>> "security.bpfxxx" and "security.selinux" cannot be read.
> >>> 
> >>> So you read code from untrusted user.* xattrs?  How can you carve out
> >>> that space and not known any pre-existing userspace cod uses kfuncs
> >>> for it's own purpose?
> >> 
> >> I don't quite follow the comment here. 
> >> 
> >> Do you mean user.* xattrs are untrusted (any user can set it), so we 
> >> should not allow BPF programs to read them? Or do you mean xattr 
> >> name "user.kfuncs" might be taken by some use space?
> > 
> > All of the above.
> 
> This is a selftest, "user.kfunc" is picked for this test. The kfuncs
> (bpf_get_[file|dentry]_xattr) can read any user.* xattrs. 
> 
> Reading untrusted xattrs from trust BPF LSM program can be useful. 
> For example, we can sign a binary with private key, and save the
> signature in the xattr. Then the kernel can verify the signature
> and the binary matches the public key. If the xattr is modified by
> untrusted user space, the BPF program will just deny the access. 

So I tend to agree with Christoph that e.g. for the above LSM usecase you
mention, using user. xattr space is a poor design choice because you have
to very carefully validate any xattr contents (anybody can provide
malicious content) and more importantly as different similar usecases
proliferate the chances of name collisions and resulting funcionality
issues increase. It is similar as if you decided to store some information
in a specially named file in each directory. If you choose special enough
name, it will likely work but long-term someone is going to break you :)

I think that getting user.* xattrs from bpf hooks can still be useful for
introspection and other tasks so I'm not convinced we should revert that
functionality but maybe it is too easy to misuse? I'm not really decided.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

