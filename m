Return-Path: <linux-fsdevel+bounces-61674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD9B58C85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 05:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C696488102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBF28D8D0;
	Tue, 16 Sep 2025 03:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Gya+LUhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6AD233D9C;
	Tue, 16 Sep 2025 03:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995001; cv=none; b=VG94qzn+1A/vVdsZQSezcEOz34MehkuiS0cULOlumTGOGAxshqbEYKoWs5PnFjEHGxnRZPxb1dRQbHp/zJH4Ze75FFKZ6QLj6B/wJNhSs1pYLKMDx/FsOBg8yQhc93+H6eBIBQUCJJH8HV2cp5Rw3Ew0JYNhVL+2Xcr3XPnEJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995001; c=relaxed/simple;
	bh=IhRqGH+mDSxYQwGsnSKG7Q7bcY4B8OSLGwI4BLjoXds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkN9zdTC4T7KbClo50T5n+xoL+ekXvBtmVtCWevcRR/d2vYcxAtrWbuQoUAIxHBS01SsDLhPdI9M/4ttdTlPkiXNj5uxkXu1LpwVdwfA0UA2xe+UPN/RM/61S4VAgIK+ayaDUkVFHzlEK473SuwvsfZmKl1DstmDoblZqkDwGNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Gya+LUhD; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uph5aHv/n19lelcCRPrreyQYMbwW8KOpqDyim4t/BPk=; b=Gya+LUhDiz9ftcN0dbd/HhuUQo
	ntihO4DCc5n0VF8c+PywSJOYWabQMP73o8D4mHFGcJwmDsSfxLF3G4GZ5LVlr5x0NBPQVFo51oovl
	gTiNraq8tkrigsDQRtDTjmxmOtpb1EFxGvpXuVcOKs+ApFEbGKdXGYJqNQ7DIH4RG+X/dn1C4dyOq
	hWJZoSAP6NQCk+pLsvPj3CHOFLITXeIQKF3yTxmT7PF1YU/qQfWQnaHXuwpLEBCKbUoOcLjsoSwp2
	3cOF92p/AAqvX7yXn+9c5C6RZFfTJuce2iLbMsaJu8KPl58wNGkf9wGcCetbDhzM9p6pOwXS53v3j
	U2GFM43g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyMnx-00000005nOq-14tn;
	Tue, 16 Sep 2025 03:56:33 +0000
Date: Tue, 16 Sep 2025 04:56:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 18/33] mnt: support ns lookup
Message-ID: <20250916035633.GM39973@ZenIV>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
 <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912-work-namespace-v2-18-1a247645cef5@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 12, 2025 at 01:52:41PM +0200, Christian Brauner wrote:
> Move the mount namespace to the generic ns lookup infrastructure.
> This allows us to drop a bunch of members from struct mnt_namespace.

>  static void mnt_ns_tree_remove(struct mnt_namespace *ns)
>  {
>  	/* remove from global mount namespace list */
> -	if (!is_anon_ns(ns)) {
> -		mnt_ns_tree_write_lock();
> -		rb_erase(&ns->mnt_ns_tree_node, &mnt_ns_tree);
> -		list_bidir_del_rcu(&ns->mnt_ns_list);
> -		mnt_ns_tree_write_unlock();
> -	}
> -
> -	call_rcu(&ns->mnt_ns_rcu, mnt_ns_release_rcu);
> -}
> -
> -static int mnt_ns_find(const void *key, const struct rb_node *node)
> -{
> -	const u64 mnt_ns_id = *(u64 *)key;
> -	const struct mnt_namespace *ns = node_to_mnt_ns(node);
> +	if (!is_anon_ns(ns))
> +		ns_tree_remove(ns);

Conflicts with "mnt_ns_tree_remove(): DTRT if mnt_ns had never been
added to mnt_ns_list".

FWIW, the right thing to do here is

	if (!RB_EMPTY_NODE(to_ns_common(ns)->ns_tree_node))
		ns_tree_remove(ns);


