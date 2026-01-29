Return-Path: <linux-fsdevel+bounces-75821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE6tNLakemmN8wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:07:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0276AA172
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 01:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4CF3007B1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jan 2026 00:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693C72A1BF;
	Thu, 29 Jan 2026 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKz8kFRQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC3B67E;
	Thu, 29 Jan 2026 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645226; cv=none; b=GU/YE17te/AFqlzT3QBTP5J6J1KQPlWoJtbHVhZj2uKTM9LuOnG2GHHfDPEragRGHCgt9cT8M/2McqROgEZ8+r1rK+lzf/8sI/H3l7tr2ae8/7B53sAQZ3lCYfI4INUuI+m+TxolUXS9MSorJeVmJjBR3KU6K6n7h+WWyHj3f0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645226; c=relaxed/simple;
	bh=lfyZ4POXsdioqMKuqaRNweLV2tFbTPixspZnM/3+dX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsI6up3GzFjcnTpibN/bPLO2gUdNOTbOXozm7K47QZ8ofcZ+PKkF6mer03FQuVYusc0pCDUfkNZ/ZuDX04lZnqMHDJw6a2j9oCi0x0Gdgw1V1zoRM70rlPkRBTpM2/LcjdjFZPjsgYvxW+CRS/Y4IGnNR2Lg7jBxieQmghLaaqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKz8kFRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14440C4CEF1;
	Thu, 29 Jan 2026 00:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769645225;
	bh=lfyZ4POXsdioqMKuqaRNweLV2tFbTPixspZnM/3+dX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKz8kFRQJBfdfvCfeA6cBhYEmtB1jXZX00j6mhJEQDXw1lRBo20fCwU/y/V/bqbSb
	 /jDa6Vi+dDa1h2NX3tKbReT6YMIxAwbcKFeCa4XMZKZc6LzRBWNGZN2XnNjmOIcNAX
	 bkbBryG3mygwRoGxdjBG2xpw7K+RSg3eLDEaRG6rQbG3JVCo5xQYAikEY0soDafviF
	 pMCltZTWO2X32rPUaXHsQsg00jKqqvzf35SU+geNxGNUNKcs4xA3iQboEHx1U/R0cw
	 bG5tvNdATouuDeiMxQdNyHhvOfuYs3LfkFZIqbORMTNmsyQM8HQZRrlY9UanKM8dQQ
	 4BQxOFUO2BlFw==
Date: Wed, 28 Jan 2026 16:07:02 -0800
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
Subject: Re: fsverity cleanups, speedup and memory usage optimization v4
Message-ID: <20260129000702.GD2024@quark>
References: <20260128152630.627409-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128152630.627409-1-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75821-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E0276AA172
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 04:26:12PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series has a hodge podge of fsverity enhances that I looked into as
> part of the review of the xfs fsverity support series.
> 
> The first part calls fsverity code from VFS code instead of requiring
> boilerplate in the file systems.
> 
> The first patch fixes a bug in btrfs as part of that, as btrfs was missing
> a check.  An xfstests test case for this was submitted already.
> Can we expedite this fix?
> 
> The middle part optimizes the fsverity read path by kicking off readahead
> for the fsverity hashes from the data read submission context, which in my
> simply testing showed huge benefits for sequential reads using dd.
> I haven't been able to get fio to run on a preallocated fio file, but
> I expect random read benefits would be significantly better than that
> still.

To get things going, I've applied patches 1-6 to
https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

I couldn't go further, due to the bugs in patches 7 and 8.

- Eric

