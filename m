Return-Path: <linux-fsdevel+bounces-3474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB27F51B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D8B20CD9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E035CD01;
	Wed, 22 Nov 2023 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KKYvlDuk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E191BF;
	Wed, 22 Nov 2023 12:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xr3fIxd6ShAqICy5ksdIon7PqrY/ojAeg18qArUzk6A=; b=KKYvlDukgHRf+nguuPK0ae5+u/
	OXrvbkccPXPLZCxlORrI9UqhuEUvOYRWn+F9MhvJc4Ic7blUtkdu1r8/jTDdQyMPMKiWdhPZDb9CR
	dcYg0VJIEp/M3HQi110IkSjsgjwm1ccfgdiaMFFOblx8vPI23bvEfoiR/5ACeI+kstejVCcs0UCrq
	GpH/GFfTuSBtUpQKzIZcwSPGBDe5b9WB5WgcYwTYDHEZIXac8c+thhN6wMON9gqSl9+3T7XuiCjWK
	AUBG7pM9Ohz2Ho50hJaYLiCIDdB5hqsZbk2a5KH2RBVXRyVkGG48s77Xkfq0/Y5KqdUdX2DDFAWEs
	GdtwzRng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5tts-001m5b-0v;
	Wed, 22 Nov 2023 20:32:44 +0000
Date: Wed, 22 Nov 2023 20:32:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: brauner@kernel.org, tytso@mit.edu, ebiggers@kernel.org,
	jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH v6 4/9] fs: Add DCACHE_CASEFOLDED_NAME flag
Message-ID: <20231122203244.GG38156@ZenIV>
References: <20230816050803.15660-1-krisman@suse.de>
 <20230816050803.15660-5-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816050803.15660-5-krisman@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 16, 2023 at 01:07:58AM -0400, Gabriel Krisman Bertazi wrote:
> From: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> This flag marks a negative or positive dentry as being created after a
> case-insensitive lookup operation.  It is useful to differentiate
> dentries this way to detect whether the negative dentry can be trusted
> during a case-insensitive lookup.

What should happen to that flag when d_splice_alias() picks an existing
alias?  AFAICS, you set it in ->lookup() for the dentry passed to ->lookup(),
but the alias picked by that sucker won't see anything of that sort, will
it?

