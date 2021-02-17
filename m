Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95F631DCA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 16:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhBQPrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 10:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233866AbhBQPrR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:47:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43AD664E15;
        Wed, 17 Feb 2021 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613576797;
        bh=Pg+GO0bPjFekcc9zfNQWFL+0WnrreYqxjb2uX6xfVeE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d/GZMnwFy2r2fMDmDyiPB1FF1vKM95NmzKEfwQvbGsWlT2VKzHHrCRNY5Hl8qrmfG
         sgNLInpuKrJ3F9g8aBm1I8mbftFoGADDUbAMC2K6y2KANcNJqfPa2P/Wda5w5Fw4gN
         u118VSgBwgJeykRTrB/vFUcA58boNrWJ85JJZMd2qDWR40+sHBP6YL7tfv+efo3ADe
         QaGyc5fwN8E5FqVxhScEQZseDSXBv5rIgbTUVUJvNoncwhfSUGGRBgoMgfLwVQjubc
         8l9cYjsBQ8FmuvZi/Imh+fy1nwDYQCIwQCAJ9S+0NAslvnKRLyvMZn7kQnR3ddXrwB
         8mTq9Winwbvbw==
Message-ID: <c15e08fdf282b7775e0c3cc7f9139659836a065f.camel@kernel.org>
Subject: Re: [PATCH v2 6/6] ceph: convert ceph_readpages to ceph_readahead
From:   Jeff Layton <jlayton@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, idryomov@gmail.com, xiubli@redhat.com,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Wed, 17 Feb 2021 10:46:35 -0500
In-Reply-To: <20210217151548.GL2858050@casper.infradead.org>
References: <20210217125845.10319-1-jlayton@kernel.org>
         <20210217125845.10319-7-jlayton@kernel.org>
         <20210217151548.GL2858050@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-02-17 at 15:15 +0000, Matthew Wilcox wrote:
> On Wed, Feb 17, 2021 at 07:58:45AM -0500, Jeff Layton wrote:
> > +static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
> >  {
> > +	struct inode *inode = mapping->host;
> >  	struct ceph_inode_info *ci = ceph_inode(inode);
> > +	int got = (int)(uintptr_t)priv;
> >  
> > 
> > 
> > 
> >  	if (got)
> >  		ceph_put_cap_refs(ci, got);
> >  }
> > +const struct netfs_read_request_ops ceph_readahead_netfs_ops = {
> > +	.init_rreq		= ceph_init_rreq,
> > +	.is_cache_enabled	= ceph_is_cache_enabled,
> > +	.begin_cache_operation	= ceph_begin_cache_operation,
> > +	.issue_op		= ceph_netfs_issue_op,
> > +	.expand_readahead	= ceph_netfs_expand_readahead,
> > +	.clamp_length		= ceph_netfs_clamp_length,
> > +	.cleanup		= ceph_readahead_cleanup,
> > +};
> 
> It looks to me like this netfs_read_request_ops is the same as the
> ceph_readpage_netfs_ops except for the addition of ceph_readahead_cleanup.
> If so, since readpage passes NULL as 'priv', the two read_request_ops
> can be the same ... right?
> 

Yeah. I can also do the same for the write_begin one. The only
difference there is check_write_begin op, and it's only called in the
write_begin helper.

> also, you don't need that '(int)' cast -- can be just:
> 
> 	int got = (uintptr_t)priv;

Got it, fixed. I'll do some testing with this and re-post in a few days
if it all looks good.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

