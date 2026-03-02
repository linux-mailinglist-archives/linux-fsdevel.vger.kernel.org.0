Return-Path: <linux-fsdevel+bounces-78877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPHyAhVipWmx+wUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:10:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 847D81D6192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9BF8307A3E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45834399009;
	Mon,  2 Mar 2026 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0Q8e7CK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C412C396B7F;
	Mon,  2 Mar 2026 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445891; cv=none; b=szuqYrTWIfKaWskv23TMjJfyKd6UGqjyMYe201Su8NkxfGpYOViVh9l7Bj+tNBM5I+IBLFKk3LHnfVQwtZa7WrrFbO2qhjUTV5YqKm5BTUoGf/tsfYK7aydzpxBjEPeNtgwP9lHxyKM+f9/fGQ8YEDiQ1uT1UOWS+UWkePEQ8fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445891; c=relaxed/simple;
	bh=YlrMc651ElVPFy+ALZ1qaxHylbkJUWPRrT+8qQNXZks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFU2DXs5xtZp3hMKuiUsx4xj4AOmGDu7I9jXlOZ1a9l5KFWYG5tWPRSH+DTGLCFT0gOJH5mrQcoHvWuAupVpO03uG+7qZ2Ievk5ugx+a21W7Jw41iWDVWKNy2URs4osKV++NTlwlHK57fk8hp6p+q44wk5GbbD7VKRB+rzj3A1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0Q8e7CK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519B2C19425;
	Mon,  2 Mar 2026 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445891;
	bh=YlrMc651ElVPFy+ALZ1qaxHylbkJUWPRrT+8qQNXZks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u0Q8e7CKsEn/a60JV002qxWB2l69VuYXorh6IfMmeBVHbfr5GrTDAAkcgOCUyQQWt
	 oZxFKSOZeZ2bTQRp7FCCx6FfA6ChKrC8lvdp7ByLF388fEO6/uheVmJkUk7B4xmuTN
	 PYPDJBVMJXs+8Rp0PT+LsbGeZdzu9MX0yEXBVNOgbRRz4I40ppNh8PFA85DxiVE86S
	 iJZabuTmozla4F7z/mpPfuOUIMgXRCH4QRnlqt5sWO6YgPR8NsD3FHd/F36dkSu9v8
	 D9vGpYM43c32kFImaEY8WpiWFlCs1p9HVefJqBYr2RUO3UkcBrOXQ6WBWV8NYAYGaf
	 QxovkfntqnONQ==
Date: Mon, 2 Mar 2026 11:04:45 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, linux-mm@kvack.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 05/14] pidfs: adapt to rhashtable-based simple_xattrs
Message-ID: <20260302-teilzeit-zuallererst-99c820d6a6f0@brauner>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
 <20260216-work-xattr-socket-v1-5-c2efa4f74cb7@kernel.org>
 <qxctwu77wp7gv4ua3hn6kg7r2vt57laomn3ebjisemzzaybagy@mvoo2wpvu2ux>
 <zfwhp3c4mtf4b7gw4qmxayfqrzf4h723s2vfjpfid62yfjz2zt@6ali24hx3ihp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <zfwhp3c4mtf4b7gw4qmxayfqrzf4h723s2vfjpfid62yfjz2zt@6ali24hx3ihp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78877-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.474];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 847D81D6192
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 04:16:04PM +0100, Jan Kara wrote:
> On Fri 27-02-26 16:09:15, Jan Kara wrote:
> > On Mon 16-02-26 14:32:01, Christian Brauner wrote:
> > > Adapt pidfs to use the rhashtable-based xattr path by switching from a
> > > dedicated slab cache to simple_xattrs_alloc().
> > > 
> > > Previously pidfs used a custom kmem_cache (pidfs_xattr_cachep) that
> > > allocated a struct containing an embedded simple_xattrs plus
> > > simple_xattrs_init(). Replace this with simple_xattrs_alloc() which
> > > combines kzalloc + rhashtable_init, and drop the dedicated slab cache
> > > entirely.
> > > 
> > > Use simple_xattr_free_rcu() for replaced xattr entries to allow
> > > concurrent RCU readers to finish.
> > > 
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > 
> > One question below:
> > 
> > > +static LLIST_HEAD(pidfs_free_list);
> > > +
> > > +static void pidfs_free_attr_work(struct work_struct *work)
> > > +{
> > > +	struct pidfs_attr *attr, *next;
> > > +	struct llist_node *head;
> > > +
> > > +	head = llist_del_all(&pidfs_free_list);
> > > +	llist_for_each_entry_safe(attr, next, head, pidfs_llist) {
> > > +		struct simple_xattrs *xattrs = attr->xattrs;
> > > +
> > > +		if (xattrs) {
> > > +			simple_xattrs_free(xattrs, NULL);
> > > +			kfree(xattrs);
> > > +		}
> > > +		kfree(attr);
> > > +	}
> > > +}
> > > +
> > > +static DECLARE_WORK(pidfs_free_work, pidfs_free_attr_work);
> > > +
> > 
> > So you bother with postponing the freeing to a scheduled work because
> > put_pid() can be called from a context where acquiring rcu to iterate
> > rhashtable would not be possible? Frankly I have hard time imagining such
> > context (where previous rbtree code wouldn't have issues as well), in
> > particular because AFAIR rcu is safe to arbitrarily nest. What am I
> > missing?
> 
> Ah, I've now found out rhashtable_free_and_destroy() can sleep and that's
> likely the reason. OK. Feel free to add:

Yeah, it was a surprise to me too. :)

