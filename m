Return-Path: <linux-fsdevel+bounces-75680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBp3NfleeWkXwwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:57:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC719BC9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 01:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 024AF302A7CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7776C219303;
	Wed, 28 Jan 2026 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijPQUzsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D821A2545;
	Wed, 28 Jan 2026 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769561838; cv=none; b=tldbcezW5dN7VZbLu3k4XDYCeaPdGQKNRRCDSuu1LDXIOr/yDcLIohkvV9/RsFVBQ8q5hnfqLEdYbVqfCRpUjVeyuXj0Ed2ZyCojGBt+MHrDU4UNezC9hVhaqDzgnQ9V0Nl9Ku/ZpFJXZa9FtkEeKJWEkSaomxepa5UgPD+bsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769561838; c=relaxed/simple;
	bh=LsHCD/RWZwU2P+vYKyBFSjWLqYN/hWAmZsoM1SJuARs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMKhA0XTBYuUlfrddzZyQu+86uYh/lCx8CNZKgEIZbC2+hVn3kz0ibJdzp0WCvC0yaao0wvhepHbDm3Kn0MwzsI5LNSFVrnP0RQK2yW+S+xamOa1X+S3KDQeeOhTVf9HBzWvnv/NFIyIVOCIAmr1trTz346ibrrSFBz1np4tXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijPQUzsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618B5C116C6;
	Wed, 28 Jan 2026 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769561837;
	bh=LsHCD/RWZwU2P+vYKyBFSjWLqYN/hWAmZsoM1SJuARs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijPQUzsn57rThaZRqcmFhoVO73D+kTDrD8EsvPyEs9JHuvS7Loc9mswy1HITsW9+r
	 laBs5lxnXVNbput2XlCspPMWdG04sLY78Wl2Rb3aYVFHKZ86mn5bG1PItmuqLbqVuI
	 vrOPP0DYKt8czP9HxADzduOGgAKP/A8nUtOcyG+ovV0KrvizpBSYRl7M21A+fs+fgJ
	 kQgwDXsySS8LuDGANV2a5ciWoiG7zGYZnlCIeuYNVPlYOG7mXa0Vrlo35p8NPddvFr
	 LDHvtiFWYISEWtr+zpP3L+O/ccE78AYK4p7+KPnNU3lNmrwR6e3NihwPXNU1fZ5Ke5
	 wgYY1xdq6MJtQ==
Date: Tue, 27 Jan 2026 16:57:15 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, fsverity@lists.linux.dev
Subject: Re: [PATCH 07/16] fsverity: don't issue readahead for non-ENOENT
 errors from __filemap_get_folio
Message-ID: <20260128005715.GB2127@quark>
References: <20260126045212.1381843-1-hch@lst.de>
 <20260126045212.1381843-8-hch@lst.de>
 <20260126191102.GO5910@frogsfrogsfrogs>
 <20260126205301.GD30838@quark>
 <20260127060039.GA25321@lst.de>
 <20260127062055.GA90735@sol>
 <20260127062849.GX5966@frogsfrogsfrogs>
 <20260127063809.GB25894@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127063809.GB25894@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75680-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BC719BC9C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 07:38:09AM +0100, Christoph Hellwig wrote:
> PTR_ERR(ptr) == -EFOO checks if ptr is an error pointer for the errno
> value -EFOO.

To reiterate (again): when ptr may or may not be an error pointer, it
should be written as ptr == ERR_PTR(-EFOO), as is normally done.
Otherwise an error code is being extracted from something that doesn't
have an error code, which is nonsense, even if it works by accident.

- Eric

