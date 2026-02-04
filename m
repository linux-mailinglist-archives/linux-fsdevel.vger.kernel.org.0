Return-Path: <linux-fsdevel+bounces-76325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFllBbRdg2mJlQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:54:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93019E7906
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D7004300DEDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C6E41B372;
	Wed,  4 Feb 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oxZnN3K5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6F23D413D;
	Wed,  4 Feb 2026 14:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216865; cv=none; b=h2JROxLbn1arHzLTEnxhlRoDbDxoryWG2D5r7qHet44/9pWvFMnSorHp6BxdhITx0jra9ljAkCOQv3lRCu7CjMC1/Z1EN+wypXFZWA0+NPAxRqMw/8rGnnD4wKxOljXyKdJWlvsF4kkzHYT6ej+JB7prJrOPcWx3hEFYqx+d218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216865; c=relaxed/simple;
	bh=bQJBM1CzMKaGOt+OTMHIALAKEUrXTLnZcnSE9Mi8+BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl8vfzYQCDXdPhxfO7aIHCPrmU0CFJ9kKQk3Nal/VJsXWv9YRERO9WCe/bXFUTWzyu8PFygvmpMqo5JuLqnU/HSc2m5bgJgRBNpH7AB85OxZ5elq4sJldK7eusmOCKuFwWcrOctGFxBv7VZSfLWb9/Yv7nLrWc8m5EzFpypl9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oxZnN3K5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NSFwipYtJGppFo1niPpuRr+jtuErqeP9kDtjaWPeRb4=; b=oxZnN3K5faDjoL5v5OXKHO0/5B
	ALVraMASeOdO1r04MRFOfO4rurUs6RmI865xOx4yso0ar7+P20MsCkTabs1ya5R7FJMXs0ce/Ez/q
	rbw7GcQz34Rv1Uu4uCXSYS/vjKmtDX7MWB90vI8Y6XrnLPQCQXb9VQLbaHpe2XJ1FOsYrzz4EAtTD
	0pejcPBsHfrRajM4IfKrqCUr02C6nMxD982pRJhIo8toILLn2rYjgRPmHchK/LCdN/5qjKs6HNCj7
	f/o5jziZ7q20pft0KQB2Xb21eynAKosZ7IXbGzJcIEHSVLJzQUdCffAiCsqVd3oLW659nU25c/4ST
	czQtWaFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vneGo-00000002DxS-1MWR;
	Wed, 04 Feb 2026 14:54:18 +0000
Date: Wed, 4 Feb 2026 14:54:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	fsverity@lists.linux.dev
Subject: Re: fsverity speedup and memory usage optimization v5
Message-ID: <aYNdmk1EE5etfUYE@casper.infradead.org>
References: <20260202060754.270269-1-hch@lst.de>
 <20260202211423.GB4838@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202211423.GB4838@quark>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76325-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,casper.infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 93019E7906
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 01:14:23PM -0800, Eric Biggers wrote:
> - Used the code formatting from 'git clang-format' in the cases where it
>   looks better than the ad-hoc formatting

clang-format makes some bad choices.

>  static int ext4_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
> -		struct readahead_control *rac, struct folio *folio)
> +				struct readahead_control *rac,
> +				struct folio *folio)

Aligning to the opening bracket is one of them.  If anything changes
in a subsequent patch (eg function name, whether or not it's static,
adding a function attribute like __must_check, converting the return
type from int to bool), you have to eitheer break the formatting or
needlessly change the lines which have the subsequent arguments.

Also, you've consumed an extra line in this case.  Just leave the
two tab indent, it's actually easier to read.


