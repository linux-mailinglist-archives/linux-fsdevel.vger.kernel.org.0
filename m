Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB1464C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348944AbhLALfO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 06:35:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43030 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbhLALed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:34:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38CB7CE1DCD;
        Wed,  1 Dec 2021 11:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C9DC53FAD;
        Wed,  1 Dec 2021 11:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638358262;
        bh=SFJv5JYjSLjoGYc7k8E7Eesrid3Zjiv3lcuqMttziv0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PXj7WXvPyaF0snbP/z9+WG3XAn5AcWXfVNXu/busVobCyJqG3MKzKnroF2q53e0Lq
         rjcm6TtAD97jNoVaYUUnR5LkjuseHfenVIALYu817q76ZOqaTFNm7FKUukw9Don7x4
         XgVF0Y07i+laSmAnmSptjdG4/YsdvNuq38arpHGBYQEL338D3FGufXO6lSYEbm3B+O
         LMOJw8oEGh57iFL/JqwPjm9621d65iDmOiPADJswS8hECqnsK8gJjxf9mmWwbmI7bw
         d4NO3ZxJNb8XnT84SWjnDbCgRc9b5C+ClS8aJs+HJTrLF0jX1iKx8zI2G/tGvSfcfs
         y+CUzUOPdipOQ==
Message-ID: <06e4f9955ee9e964724ecc2047fef6e4c9606b14.camel@kernel.org>
Subject: Re: [PATCH 1/2] ceph: conversion to new fscache API
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 01 Dec 2021 06:31:00 -0500
In-Reply-To: <278917.1638204396@warthog.procyon.org.uk>
References: <20211129162907.149445-2-jlayton@kernel.org>
         <20211129162907.149445-1-jlayton@kernel.org>
         <278917.1638204396@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-11-29 at 16:46 +0000, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
> 
> > +void ceph_fscache_unregister_inode_cookie(struct ceph_inode_info* ci)
> >  {
> > -	return fscache_register_netfs(&ceph_cache_netfs);
> > +	struct fscache_cookie* cookie = xchg(&ci->fscache, NULL);
> > +
> > +	fscache_relinquish_cookie(cookie, false);
> >  }
> 
> xchg() should be excessive there.  This is only called from
> ceph_evict_inode().  Also, if you're going to reset the pointer, it might be
> worth poisoning it rather than nulling it.
> 

Ok, makes sense. I'll make that change soon.
-- 
Jeff Layton <jlayton@kernel.org>
