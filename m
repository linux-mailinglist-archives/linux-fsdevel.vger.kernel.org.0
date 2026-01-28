Return-Path: <linux-fsdevel+bounces-75692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULyYFDKGeWnjxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:44:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F229CD2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 355E93012EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36032FA3D;
	Wed, 28 Jan 2026 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P201+ebc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9281A3029;
	Wed, 28 Jan 2026 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571879; cv=none; b=QAukOcdtFnWWuIJJ4vlNkIDO4e0PbhrssMajXb1Me8ncZQgHjFZjfrawqQb3Qt97a4nfLoD0xL7ICd5kaU1IoJt0E2WtiicWXyh+ifAVYNrbZ8WlBMzjSsVJN/x2GesYr59FrCD6qTB6Nl5Qu2KVrt9uNnp09Yqae58/GQkoyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571879; c=relaxed/simple;
	bh=AxsbRiz6g5OHmI8dfGU8IScrv9tHBdspZu1p6bmeGBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf1kOo60kSC23J4fZhbRHcrJ149oZkR1+W2ehDNVDN8QM2+eb2IRGQlNPfQupiKernc1xKnLzWGbg9xXWfKctcvbbZ9K3CskJsD3uDxdkKpXvpfgdMYIYlAcX73i7+DgGJB0ddlI9bUawB/K4ZdQ97eKbHdYwDu7OXGCf7Xhw0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P201+ebc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388A4C4CEF1;
	Wed, 28 Jan 2026 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769571878;
	bh=AxsbRiz6g5OHmI8dfGU8IScrv9tHBdspZu1p6bmeGBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P201+ebcahtveats5bhW2VJNT2y5qzZhA5UQq4K1H1t4r3j8dB204ErQtUZ4OVk7N
	 YnWXZUkXX1CbW8uko3pPh+QLq4pWZLsSBJA9PvkIniP9ouFclwLqq3s7rzdJdnahiv
	 F8uNjLjPV7RhubK6C9IlB690qAzIOrBIS168z1Jj9DAw594M2kV1u1lIAtTaU6frsL
	 YVjDJT63xqbvutBpXCtTvsieBy0dKR44T1c1fyeRrNuX51xye8cn2hCQKzBf/PGuN2
	 y3G1FufZ7pMbsRJS+GieYovcevovNHI/9hjK7cqJDIpSxdqJz1BNQ/LggEt/fIz2Yr
	 VqO+Ot3ttWEuA==
Date: Tue, 27 Jan 2026 19:44:05 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 16/16] fsverity: use a hashtable to find the fsverity_info
Message-ID: <20260128034405.GD2718@sol>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-17-hch@lst.de>
 <20260128032817.GB2718@sol>
 <20260128033519.GB30830@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128033519.GB30830@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75692-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9F229CD2E
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:35:19AM +0100, Christoph Hellwig wrote:
> > Is there a reason for this function in particular to be __always_inline?
> > fsverity_get_info() is just inline.
> 
> Without the __always_inline some gcc versions on sparc fail to inline it,
> and cause a link failure due to a reference to fsverity_readahead in
> f2fs_mpage_readpages for non-verity builds.  (reported by the buildbot)

The relevant code is:

    vi = f2fs_need_verity(inode, folio->index);              
    if (vi)                                                  
            fsverity_readahead(vi, folio, nr_pages); 

Where:

    f2fs_need_verity()
        => fsverity_get_info()
            => fsverity_active()

If fsverity_active() needs __always_inline, why don't the other two
functions in the call chain need it?

- Eric

