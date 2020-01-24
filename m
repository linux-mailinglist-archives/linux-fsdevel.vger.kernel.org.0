Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2FF148D9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 19:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403863AbgAXSM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 13:12:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390883AbgAXSM4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:12:56 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C7E2075D;
        Fri, 24 Jan 2020 18:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579889575;
        bh=RR2pEgv3AfYWVyNbNfZQfKlvW//2Y1NRPRw8qbA0Nc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEr5lh3+1n6E4bqy9kbISKA2APd/H/Ot2U3wNw1gGv4tc6Z3SKgWHNisVVAb4u2by
         KOXjFlBBuu7uIWet+S74eqkm/g+GRwFaImTrPKFc1MTlSkw3Rjdc5EeY7AEs8tvCWJ
         Ra31+bwo2ahiCxnm22pgLTpn+4fR34xcvM3ODq9c=
Date:   Fri, 24 Jan 2020 10:12:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124181253.GA41762@gmail.com>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
 <20200124053415.GC31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124054256.GC832@sol.localdomain>
 <20200124061525.GA2407@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124061525.GA2407@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 02:15:31PM +0800, Gao Xiang wrote:
> On Thu, Jan 23, 2020 at 09:42:56PM -0800, Eric Biggers wrote:
> > On Fri, Jan 24, 2020 at 01:34:23PM +0800, Gao Xiang wrote:
> > > On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:
> > > 
> > > []
> > > 
> > > > So we need READ_ONCE() to ensure that a consistent value is used.
> > > 
> > > By the way, my understanding is all pointer could be accessed
> > > atomicly guaranteed by compiler. In my opinion, we generally
> > > use READ_ONCE() on pointers for other uses (such as, avoid
> > > accessing a variable twice due to compiler optimization and
> > > it will break some logic potentially or need some data
> > > dependency barrier...)
> > > 
> > > Thanks,
> > > Gao Xiang
> > 
> > But that *is* why we need READ_ONCE() here.  Without it, there's no guarantee
> > that the compiler doesn't load the variable twice.  Please read:
> > https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE
> 
> After scanning the patch, it seems the parent variable (dentry->d_parent)
> only referenced once as below:
> 
> -	struct inode *inode = dentry->d_parent->d_inode;
> +	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> +	const struct inode *inode = READ_ONCE(parent->d_inode);
> 
> So I think it is enough as
> 
> 	const struct inode *inode = READ_ONCE(dentry->d_parent->d_inode);
> 
> to access parent inode once to avoid parent inode being accessed
> for more time (and all pointers dereference should be in atomic
> by compilers) as one reason on
> 
> 	if (!inode || !IS_CASEFOLDED(inode) || ...
> 
> or etc.
> 
> Thanks for your web reference, I will look into it. I think there
> is no worry about dentry->d_parent here because of this only one
> dereference on dentry->d_parent.
> 
> You could ignore my words anyway, just my little thought though.
> Other part of the patch is ok.
> 

While that does make it really unlikely to cause a real-world problem, it's
still undefined behavior to not properly annotate a data race, it would make the
code harder to understand as there would be no indication that there's a data
race, and it would confuse tools that try to automatically detect data races.
So let's keep the READ_ONCE() on d_parent.

- Eric
