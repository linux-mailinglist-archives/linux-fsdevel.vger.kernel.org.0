Return-Path: <linux-fsdevel+bounces-75229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOa3Cfchc2mUsgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:23:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F22671A93
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 08:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0425D301914E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE45E35CB62;
	Fri, 23 Jan 2026 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sz+tzjHg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894133C1B9;
	Fri, 23 Jan 2026 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153010; cv=none; b=PJ7IXiI4PzpS6dAIo8NzrnTuHEGexz2Q5BqjwpHg7GbqdclEUdScgfbuwLM3MB4KIEUvtvEDQ+I+7Je3WngkrMXSF9sPb7fdXqWMDUZRVhM+/BzhHyFf0CH5BsI1irNtFw4iVWSrsViiMhrqy223H/TvBp/ivUg2tPqyM9MAvh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153010; c=relaxed/simple;
	bh=9WSu0IShfB8L33nlGdfGlGnVbVsdHwxggXUIvcPUkfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufeGr3v5dBIxQb3ZcDDl99BmPyxJq3cVA+lqMNP3vQEmXFPbgKgR56CuyBFdg7TjllYC4K4thgU0uEK8Lld78liyFIUgmOG1pRdb/1IM+AqCng4MqRWVL1GlaOaShCTlYNabcIROj8vcsOEX3O5xiBvfgse3x/gOJWTp2sXmpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sz+tzjHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7360C4CEF1;
	Fri, 23 Jan 2026 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769153009;
	bh=9WSu0IShfB8L33nlGdfGlGnVbVsdHwxggXUIvcPUkfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sz+tzjHgSoGj68dWGCbxnG7wcFHUG1sGFGWKjsbQ/1x7HSKc5fJNRTcRC9Od2hckn
	 naES6wfe0DYNlM1sr7uZj2Y657/PL/BObMRodBGNhJIFWij85Qti4tVTs0PdkQ4xpU
	 IFW2dANl8T8sHv/DJMJS1GkN0olprh61KoB7iNREK+3wTtLWxJUwbjypyc8/adli/J
	 s6BB3xJBuuNvU4NCwykwSCs5KcbYdC6Ks4YnYRmQTKuPaXqtfC/91C4K0NtI0z+o1/
	 +QO59h0EiDTF+LLjacD30R+GU7/IVvcKb1fdVjBsiUk8XCgJ41Epg8k2yOgsyFeY3/
	 MU1BEeBUnyEhA==
Date: Thu, 22 Jan 2026 23:23:29 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Eric Biggers <ebiggers@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: [PATCH 07/11] fs: consolidate fsverity_info lookup in buffer.c
Message-ID: <20260123072329.GL5910@frogsfrogsfrogs>
References: <20260122082214.452153-1-hch@lst.de>
 <20260122082214.452153-8-hch@lst.de>
 <20260122214958.GG5910@frogsfrogsfrogs>
 <20260123051556.GC24123@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123051556.GC24123@lst.de>
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
	TAGGED_FROM(0.00)[bounces-75229-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F22671A93
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 06:15:56AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 22, 2026 at 01:49:58PM -0800, Darrick J. Wong wrote:
> > Well this is no longer a weird ext4ism, since f2fs also needs this,
> > right?  Maybe this comment should read:
> 
> f2fs doesn't use buffer heads.  So this is just because ext4 only
> implements the easy parts of ->read_folio and ->readahead itself and
> falls back onto the generic code for the rest, which then had to be
> grow hacky ext4-specific bits like this for it :(

Yikes.  So I guess we shouldn't genericise the comment to encourage more
people to do the same thing ext4 did?

--D

