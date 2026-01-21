Return-Path: <linux-fsdevel+bounces-74927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FqXMhBLcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:54:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 379BE5E5A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3D684EAFDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163A33F0742;
	Wed, 21 Jan 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="myTDqN+l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE693EFD2C;
	Wed, 21 Jan 2026 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032455; cv=none; b=bvBG85FFkfe+UUsRLWdvyeDW+tlM2k7/6tFWqkgnc4GlSLMLC3+hN+SyEDaC79rZKhSrnha5j4v1FYLvlV1UU7MGXwxwlmI3n6lXC21l5UOG9LHK95Bs5BQJvQ4K3xE9rI5tiCFKOlZrL1Gr2K99hRLD7Z/Wlj8DX43nHce8hDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032455; c=relaxed/simple;
	bh=NnvbK3PAc4UMgW8vHQdi+Lr6tJQf9tha+gkNNJV9alA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/UsA2EfFHqzwcA+Dj/zmc+76KyNpc2IMeI2iHrryeCPlpmJOHy87WJCdSLhH20qG3lxWrKJH3u5H9CmvAnpBamStIo1WtMxu+U52YaiD02MQEne8iA/BeC7wbzkFxsv4L3w9nKQvXuoG69nczabf1v46Mt8fkxfJJlwp4ajEdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=myTDqN+l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rQtHv23fO6l9J3nm7gG7yaHEiEPtGuPAIocQFBt16JQ=; b=myTDqN+lwFMxtcXME04q8KCkBB
	Sn2PKpVs/jyQTKAk7d/t+NhCgMhiD4itpmXFSunyApsyTDhgwa1ACvWLGeaM34TrXFHbB6eGFqPFO
	Ao+vvUUDPiqA9NfrdqABdCiah1ZY1mRw0kdh6ewvE3g/BZFOWrOWPSlDDIKzNF3JN1PHxtDydOaaq
	RtzPFX3P5jU1M/dycn9HTlVUA0RYM+kcnjhue9kouSuoSARaVVnBhiIMF9HD1i9J39zPyE/HjtOCc
	wjQrHaLXUiDWeCrNz2r8p+Bg3DzOwHmpvcwagnLWBvqBNmA334NfRhlVBdF+zrEjEsG4igMtFrvfj
	UzCRAfgQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vigB4-00000009zPA-1IWv;
	Wed, 21 Jan 2026 21:55:50 +0000
Date: Wed, 21 Jan 2026 21:55:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20260121215550.GD3183987@ZenIV>
References: <CAKPOu+8kLwwG4aKiArX2pKq-jroTgq0MSWW2AC1SjO-G9O_Aog@mail.gmail.com>
 <20250707204918.GK1880847@ZenIV>
 <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
 <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV>
 <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
 <20250707221917.GO1880847@ZenIV>
 <20250707223753.GQ1880847@ZenIV>
 <CAKPOu+9=AV-NxJYXjwiUL4iXPH=oUSF25+6t25M8ujfj2OvHVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKPOu+9=AV-NxJYXjwiUL4iXPH=oUSF25+6t25M8ujfj2OvHVQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74927-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[zeniv.linux.org.uk,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 379BE5E5A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jul 08, 2025 at 06:45:14AM +0200, Max Kellermann wrote:

> I believe the busy-wait was accidental.
> I've been trying to make you aware that this is effectively a
> busy-wait, one that can take a long time burning CPU cycles, but I
> have a feeling I can't reach you.
> 
> Al, please confirm that it was your intention to busy-wait until dying
> dentries disappear!

It's not so much an intention as having nothing good to wait on.

Theoretically, there's a way to deal with that - dentry in the middle
of stuck iput() from dentry_unlink_inode() from __dentry_kill() is
guaranteed to be
	* negative
	* unhashed
	* not in-lookup

What we could do is adding an hlist_head aliased with ->d_alias, ->d_rcu
and ->d_in_lookup_hash.  Then select_collect2() running into a dentry
with negative refcount would set _that_ as victim and bugger off, same
as we do for ones on shrink lists.

shrink_dcache_parent() would do this:
                if (data.victim) {
			struct dentry *v = data.victim;

			spin_lock(&v->d_lock);
			if (v->d_lockref.count < 0 &&
			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
				init_completion(&data.completion);
				hlist_add_head(&data.node, &v->d_new_field);
				spin_unlock(&v->d_lock);
				rcu_read_unlock();
				wait_for_completion(&data.completion);
			} else if (!lock_for_kill(data.victim)) {  
				spin_unlock(&data.victim->d_lock);
				rcu_read_unlock();
			} else {
				shrink_kill(data.victim); 
		}

and dentry_unlist() -
        dentry->d_flags |= DCACHE_DENTRY_KILLED;
	while (unlikely(dentry->d_new_field.first)) {
		struct select_data *p;

		p = hlist_entry(dentry->d_new_field.first,
				struct select_data,
				node);
		hlist_del_init(&p->node);
		complete(&p->complete);
	}
	...

AFAICS, that ought to be safe and would guaratee progress on each
iteration in shrink_dcache_parent() (note that finding negative
refcount and seeing that it had already been past dentry_unlist()
would mean falling through to lock_for_kill() and instantly
failing there; in any case, that dentry definitely won't be
found on any subsequent d_walk(), so we still get progress there).

Comments?

