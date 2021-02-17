Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68D131DC06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 16:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbhBQPSv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 10:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbhBQPRy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:17:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD87C061574;
        Wed, 17 Feb 2021 07:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gJ07Jm0tFxyel39hlZwJGKUxlaYOn0v0ACSFtt7Nyus=; b=sSrdPxXXer3YDCS3cxP1dNMv/U
        /g19r1qBz9BOfH/ksnqLQAuDJ/AKzrSrgR94+19+PsjjebTnqnygrphqS8PfEFyxrvf0jGmg8mMOD
        xhy6fCL1OQ+OAmyOJibhFslhmFCmZEUtb0Cl9Ycg/JPEGWulctd45GEdLEL9msDYjc0bB2keGiO05
        OirhfE9jkkWX+Io17JoXXV6JpqBe0xLMap+igJwBVLqR5jnjVUu5kv5ymsIr8ELTGISu5+RkQ9C+G
        UoG2zwHqf54oneyas/KsC6Enf2z5O8QQ2MVUQY9QOk/uwpZ8z2+IAuDWo00l0ln2twviDv2RKxBbi
        LGuSQGMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCOYO-000bEQ-Tx; Wed, 17 Feb 2021 15:16:16 +0000
Date:   Wed, 17 Feb 2021 15:15:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, idryomov@gmail.com, xiubli@redhat.com,
        ceph-devel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] ceph: convert ceph_readpages to ceph_readahead
Message-ID: <20210217151548.GL2858050@casper.infradead.org>
References: <20210217125845.10319-1-jlayton@kernel.org>
 <20210217125845.10319-7-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217125845.10319-7-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 07:58:45AM -0500, Jeff Layton wrote:
> +static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
>  {
> +	struct inode *inode = mapping->host;
>  	struct ceph_inode_info *ci = ceph_inode(inode);
> +	int got = (int)(uintptr_t)priv;
>  
>  	if (got)
>  		ceph_put_cap_refs(ci, got);
>  }
> +const struct netfs_read_request_ops ceph_readahead_netfs_ops = {
> +	.init_rreq		= ceph_init_rreq,
> +	.is_cache_enabled	= ceph_is_cache_enabled,
> +	.begin_cache_operation	= ceph_begin_cache_operation,
> +	.issue_op		= ceph_netfs_issue_op,
> +	.expand_readahead	= ceph_netfs_expand_readahead,
> +	.clamp_length		= ceph_netfs_clamp_length,
> +	.cleanup		= ceph_readahead_cleanup,
> +};

It looks to me like this netfs_read_request_ops is the same as the
ceph_readpage_netfs_ops except for the addition of ceph_readahead_cleanup.
If so, since readpage passes NULL as 'priv', the two read_request_ops
can be the same ... right?

also, you don't need that '(int)' cast -- can be just:

	int got = (uintptr_t)priv;
