Return-Path: <linux-fsdevel+bounces-79288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN5WDl1ip2lvhAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:36:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA401F80B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 23:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BC6F310F029
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 22:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA4363090;
	Tue,  3 Mar 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAUR2HdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D02EE611;
	Tue,  3 Mar 2026 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577310; cv=none; b=KdQxFW9oxR42odVYyENQSlVnsTo7cTOvQ0I11qLk1R2WmA/TRtjlY2rT4N+I1Hfjg22aXkOsTHHCtGo2bzMGLxQaRKEWIDT7Vrbm8XE4ZgxOiwf3sFU5Jx/iVBdMgqwCSCHg9oLxNBR0pEc6pYaWOmGZEMh0H2FZv4FSkhaobEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577310; c=relaxed/simple;
	bh=hLW2gogLkMlcBSOVfuRQe+4qJ4OCx+t0Wq24NyTkByk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1AMqmdKfIwo5Wk28MS/6wxIQ/Zu+bk2RRJ7LHeVPU9L2UZwy/5frYS8Mqn60CLuGz+BkVJAXJCRXKmWdmsPkN2qb0dRc0dhWKNzuVz3XH209wxB3crQwd2gLfMZSnY/V3P36RyMGHb6eC1ed/qWR6XGF696AKesZTf4C6Kyjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAUR2HdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC8BC116C6;
	Tue,  3 Mar 2026 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772577310;
	bh=hLW2gogLkMlcBSOVfuRQe+4qJ4OCx+t0Wq24NyTkByk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAUR2HdNV2dYGUW1Gp2H6pGWUeqFYY3HraLaasw6Ye5WeMS7pBk7RiASmFOVI+kYo
	 LQ146BxJ57YBeCfZnPIq4HjCq/pLTAc+LsVeQneCmVcKzn1wNxkyArwOF4/8g1zWsN
	 MGcDEDIxWOJB3sbw5hJld1pIeDsdTH+Gja44neawvGUsHTdat0f1k3G8KQ5AeFcw0m
	 MGiZQb7RBm8GvrhX5HTW7onWMmYmLy7ZKK30ycsd3jfLNN4tS8BmkCG3Exf3VvZewo
	 dKn+DJXgfIqrK/VFFAGMvf5JI3rsGjE6kB8AjEatFX7qlIl34T3HH4nSZIKHMKs88l
	 dyhe1JTbMJy/Q==
Date: Tue, 3 Mar 2026 14:35:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Chao Yu <chao@kernel.org>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: fscrypt API cleanups v3
Message-ID: <20260303223507.GA56397@quark>
References: <20260302141922.370070-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302141922.370070-1-hch@lst.de>
X-Rspamd-Queue-Id: CCA401F80B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79288-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:18:05AM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up various fscrypt APIs to pass logical offsets in
> and lengths in bytes, and on-disk sectors as 512-byte sector units,
> like most of the VFS and block code.
> 
> Changes since v2:
>  - use the local bio variable in io_submit_init_bio
>  - use folio instead of io_folio (and actually test the noinline mode,
>    which should have cought this for the last round)
>  - add an extra IS_ENABLED(CONFIG_FS_ENCRYPTION) to safeguard
>    against potentially stupid compilers
>  - document the byte length needs to be a multiple of the block
>    size
>  - case to u64 when passing the byte length
>  - move a hunk to an earlier patch
> Changes since v1:
>  - remove all buffer_head helpers, and do that before the API cleanups
>    to simplify the series
>  - fix a bisection hazard
>  - spelling fixes in the commit logs
>  - use "file position" to describe the byte offset into an inode
>  - add another small ext4 cleanup at the end

This looks good now.  I'll plan to apply this to fscrypt.git#for-next in
a bit.  Other reviews and acks appreciated.

- Eric

