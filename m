Return-Path: <linux-fsdevel+bounces-5099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616078080C0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 07:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED03281759
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AD18AE6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbA7IPBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1249D5E;
	Wed,  6 Dec 2023 21:03:57 -0800 (PST)
Date: Thu, 7 Dec 2023 00:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701925436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+VAtdw+VBXAf4egJulQBl5F+jTniBZVDEdNWU+PevM=;
	b=jbA7IPByemD/cql2BiX6j7iBa9QLHJMtHJVuGstf9MSlWE9JOEjKXyhrh7iLfZfKFgS3LZ
	mfLfdxAOUw7H5nxtn4jTY/0cJJ93iah32/r7tTObyMpuDY3DgEIj4tv9duHXd5joiAaGUZ
	/R990PcU4rYx83ds2Q+QUu0pq3QZQhI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cachefs@redhat.com,
	dhowells@redhat.com, gfs2@lists.linux.dev, dm-devel@lists.linux.dev,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 03/11] vfs: Use dlock list for superblock's inode list
Message-ID: <20231207050351.gg74kg6jumik36gs@moria.home.lan>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-4-david@fromorbit.com>
 <20231207024024.GU1674809@ZenIV>
 <ZXFRHo3mcbKfoC8v@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXFRHo3mcbKfoC8v@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 07, 2023 at 03:59:10PM +1100, Dave Chinner wrote:
> On Thu, Dec 07, 2023 at 02:40:24AM +0000, Al Viro wrote:
> > On Wed, Dec 06, 2023 at 05:05:32PM +1100, Dave Chinner wrote:
> > 
> > > @@ -303,6 +303,7 @@ static void destroy_unused_super(struct super_block *s)
> > >  	super_unlock_excl(s);
> > >  	list_lru_destroy(&s->s_dentry_lru);
> > >  	list_lru_destroy(&s->s_inode_lru);
> > > +	free_dlock_list_heads(&s->s_inodes);
> > >  	security_sb_free(s);
> > >  	put_user_ns(s->s_user_ns);
> > >  	kfree(s->s_subtype);
> > 
> > Umm...  Who's going to do that on normal umount?
> 
> Huh. So neither KASAN nor kmemleak has told me that s->s-inodes was
> being leaked.  I'm guessing a rebase sometime in the past silently
> dropped a critical hunk from deactivate_locked_super() in the bit
> bucket, but as nothing since whenever that happened has failed or
> flagged a memory leak I didn't notice.
> 
> Such great tools we have......

kmemleak has always seemed flakey to me (as one would expect, it's
difficult code to test). If we can ever get memory allocation profiling
merged - it won't be a direct replacement but it'll be more reliable.

