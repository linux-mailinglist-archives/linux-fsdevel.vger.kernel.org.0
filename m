Return-Path: <linux-fsdevel+bounces-36105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FA9DBBA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4201640F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016001C07EA;
	Thu, 28 Nov 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNT7+kf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LmQcOHXA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNT7+kf+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LmQcOHXA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113C9463;
	Thu, 28 Nov 2024 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732813810; cv=none; b=s6Qb9bkDiK6TjX7Y5rCQy3v074mbdM+5fybZ/P7hCjS8H3t4o6oakiZeBCYUJuzHWmypk9g/9feW4hAG3EwuC2QOdw55ZRVhOq4WpIm2TV0SafDWvd9ZcZ8fmLVrQdQQx3XrNCt3XHbpJrmwp1x2rbXIE24j+ybsqAjpS78TuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732813810; c=relaxed/simple;
	bh=KUzfRDAw+eKIdbSDnrFEicUiHLYpy+wYbsQCTwmp2Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ch4mYjcnuPu3sUK6NdIFqqO4rrC4AFt92izkIHv+jv8+7+hvRQbPXJeBPKZObKWfloMMPSqmQqAcPYu/2SazofYsxO2ngifySJLUro4BCz1h92Pm55TytH9tg0jiErptxLi7EklmqtKXifNghXv/ABFaA5DAd3cbtURmW/ghJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNT7+kf+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LmQcOHXA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNT7+kf+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LmQcOHXA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E9F31F79F;
	Thu, 28 Nov 2024 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732813806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eumxKd+aZ1ilHfhhp/xj0zyfdCtmWTUoslPwSRI+7lk=;
	b=rNT7+kf+c4whS7Ersp6pzCq5sH1bNKadavpZ7JcdPSX/T2nGBrfakfdd/36moybua5Mc8t
	nlQx64ILVXBAx37kGDgvmoH469kyjWI24Z5smG7Wo6iS5BTUfn8DYR64uROJ7JCDadlOmD
	unfkT+mOQyfKnHrrfxx9kdvL+RjJc60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732813806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eumxKd+aZ1ilHfhhp/xj0zyfdCtmWTUoslPwSRI+7lk=;
	b=LmQcOHXAEYLMJR6vdXY3s14HZb+8txfTm7o4gPaUnHVf1nz1LUghV5dKbECIA20tvb4MMw
	oFmG6J8CKf4nIfBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732813806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eumxKd+aZ1ilHfhhp/xj0zyfdCtmWTUoslPwSRI+7lk=;
	b=rNT7+kf+c4whS7Ersp6pzCq5sH1bNKadavpZ7JcdPSX/T2nGBrfakfdd/36moybua5Mc8t
	nlQx64ILVXBAx37kGDgvmoH469kyjWI24Z5smG7Wo6iS5BTUfn8DYR64uROJ7JCDadlOmD
	unfkT+mOQyfKnHrrfxx9kdvL+RjJc60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732813806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eumxKd+aZ1ilHfhhp/xj0zyfdCtmWTUoslPwSRI+7lk=;
	b=LmQcOHXAEYLMJR6vdXY3s14HZb+8txfTm7o4gPaUnHVf1nz1LUghV5dKbECIA20tvb4MMw
	oFmG6J8CKf4nIfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AC1C13690;
	Thu, 28 Nov 2024 17:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TcNNDu6jSGc2SgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 Nov 2024 17:10:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DFCCDA075D; Thu, 28 Nov 2024 18:10:01 +0100 (CET)
Date: Thu, 28 Nov 2024 18:10:01 +0100
From: Jan Kara <jack@suse.cz>
To: Song Liu <songliubraving@meta.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Amir Goldstein <amir73il@gmail.com>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LSM List <linux-security-module@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	"repnop@google.com" <repnop@google.com>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	"gnoack@google.com" <gnoack@google.com>
Subject: Re: [PATCH v3 fanotify 2/2] samples/fanotify: Add a sample fanotify
 fiter
Message-ID: <20241128171001.xamzdpqlumqdqdkl@quack3>
References: <20241122225958.1775625-1-song@kernel.org>
 <20241122225958.1775625-3-song@kernel.org>
 <CAOQ4uxhfd8ryQ6ua5u60yN5sh06fyiieS3XgfR9jvkAOeDSZUg@mail.gmail.com>
 <CAADnVQK-6MFdwD_0j-3x2-t8VUjbNJUuGrTXEWJ0ttdpHvtLOA@mail.gmail.com>
 <21A94434-5519-4659-83FA-3AB782F064E2@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21A94434-5519-4659-83FA-3AB782F064E2@fb.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,meta.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com,toxicpanda.com,digikod.net];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 27-11-24 02:16:09, Song Liu wrote:
> > On Nov 26, 2024, at 4:50 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > 
> 
> [...]
> 
> >>> +
> >>> +static void sample_filter_free(struct fanotify_filter_hook *filter_hook)
> >>> +{
> >>> +       struct fan_filter_sample_data *data = filter_hook->data;
> >>> +
> >>> +       path_put(&data->subtree_path);
> >>> +       kfree(data);
> >>> +}
> >>> +
> >> 
> >> Hi Song,
> >> 
> >> This example looks fine but it raises a question.
> >> This filter will keep the mount of subtree_path busy until the group is closed
> >> or the filter is detached.
> >> This is probably fine for many services that keep the mount busy anyway.
> >> 
> >> But what if this wasn't the intention?
> >> What if an Anti-malware engine that watches all mounts wanted to use that
> >> for configuring some ignore/block subtree filters?
> >> 
> >> One way would be to use a is_subtree() variant that looks for a
> >> subtree root inode
> >> number and then verifies it with a subtree root fid.
> >> A production subtree filter will need to use a variant of is_subtree()
> >> anyway that
> >> looks for a set of subtree root inodes, because doing a loop of is_subtree() for
> >> multiple paths is a no go.
> >> 
> >> Don't need to change anything in the example, unless other people
> >> think that we do need to set a better example to begin with...
> > 
> > I think we have to treat this patch as a real filter and not as an example
> > to make sure that the whole approach is workable end to end.
> > The point about not holding path/dentry is very valid.
> > The algorithm needs to support that.
> 
> Hmm.. I am not sure whether we cannot hold a refcount. If that is a 
> requirement, the algorithm will be more complex. 

Well, for production use that would certainly be a requirement. Many years
ago dnotify (the first fs notification subsystem) was preventing
filesystems from being unmounted because it required open file and it was a
pain.

> IIUC, fsnotify_mark on a inode does not hold a refcount to inode. 

The connector (head of the mark list) does hold inode reference. But we
have a hook in the unmount path (fsnotify_unmount_inodes()) which drops all
the marks and connectors for the filesystem.

> And when the inode is evicted, the mark is freed. I guess this 
> requires the user space, the AntiVirus scanner for example, to 
> hold a reference to the inode? If this is the case, I think it 
> is OK for the filter, either bpf or kernel module, to hold a 
> reference to the subtree root.

No, fsnotify pins the inodes in memory (which if fine) but releases them
when unmount should happen. Userspace doesn't need to pin anything.

> > It may very well turn out that the logic of handling many filters
> > without a loop and not grabbing a path refcnt is too complex for bpf.
> > Then this subtree filtering would have to stay as a kernel module
> > or extra flag/feature for fanotify.
> 
> Handling multiple subtrees is indeed an issue. Since we rely on 
> the mark in the SB, multiple subtrees under the same SB will share
> that mark. Unless we use some cache, accessing a file will 
> trigger multiple is_subdir() calls. 
> 
> One possible solution is that have a new helper that checks
> is_subdir() for a list of parent subtrees with a single series
> of dentry walk. IOW, something like:
> 
> bool is_subdir_of_any(struct dentry *new_dentry, 
>                       struct list_head *list_of_dentry).
> 
> For BPF, one possible solution is to walk the dentry tree 
> up to the root, under bpf_rcu_read_lock().

I can see two possible issues with this. Firstly, you don't have list_head
in a dentry you could easily use to pass dentries to a function like this.
Probably you'll need an external array with dentry pointers or something
like that.

Second issue is more inherent in the BPF filter approach - if there would
be more notification groups each watching for some subtree (like users
watching their home dirs, apps watching their subtrees with data etc.), then
we'd still end up traversing the directory tree for each such notification
group. That seems suboptimal but I have to think how much we care how we
could possibly avoid that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

