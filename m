Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DB1300A2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbhAVRli (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbhAVRdl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:33:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4494F239D4;
        Fri, 22 Jan 2021 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611336777;
        bh=Ur7upKT7YbgDOcapu/JArHDsI4zcwel1UvVwI6HDudw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uWcq7n1E8sK28Avr7NVza87ZyLg4/ZmAVhy1gNoSQOuPvkK9zK1qmj/Bjky3AxMCR
         jMU4V4a5nsHWRRr3YCnD2hLI+J8vgScO+X3xMKzSwqHuXfrKpQrvcUMgxlHDmMXoxw
         QbuLMhW+93CbXJ16nZ8hHMR5S3wIfkcF5nzj81Ywc7s6J4zDc3A6mWl2aA2KBMZuHB
         dFEZyT2rHCHg+GnyiDLBxl/Z307mhiEpOEtsQ2gw61u6plI/KNTVuHgoblcN33V7BX
         93JERb6fk6nS+EHKWkJkClJE1lELvcivN2G5wqy4IO1hFSgiRGdGk2FF2rBA14Xk9f
         scpfGzKrp3ZEw==
Message-ID: <d4f84211f017280cd1dd98bcdee99d11621c5d7f.camel@kernel.org>
Subject: Re: [RFC PATCH v4 08/17] ceph: add routine to create fscrypt
 context prior to RPC
From:   Jeff Layton <jlayton@kernel.org>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 22 Jan 2021 12:32:56 -0500
In-Reply-To: <87tur8532c.fsf@suse.de>
References: <20210120182847.644850-1-jlayton@kernel.org>
         <20210120182847.644850-9-jlayton@kernel.org> <87tur8532c.fsf@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-01-22 at 16:50 +0000, Luis Henriques wrote:
> Jeff Layton <jlayton@kernel.org> writes:
> 
> > After pre-creating a new inode, do an fscrypt prepare on it, fetch a
> > new encryption context and then marshal that into the security context
> > to be sent along with the RPC.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/crypto.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ceph/crypto.h | 12 ++++++++++
> >  fs/ceph/inode.c  |  9 +++++--
> >  fs/ceph/super.h  |  3 +++
> >  4 files changed, 83 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 879d9a0d3751..f037a4939026 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -46,3 +46,64 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
> >  {
> >  	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
> >  }
> > +
> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
> > +				 struct ceph_acl_sec_ctx *as)
> > +{
> > +	int ret, ctxsize;
> > +	size_t name_len;
> > +	char *name;
> > +	struct ceph_pagelist *pagelist = as->pagelist;
> > +	bool encrypted = false;
> > +
> > +	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
> > +	if (ret)
> > +		return ret;
> > +	if (!encrypted)
> > +		return 0;
> > +
> > +	inode->i_flags |= S_ENCRYPTED;
> > +
> > +	ctxsize = fscrypt_context_for_new_inode(&as->fscrypt, inode);
> > +	if (ctxsize < 0)
> > +		return ctxsize;
> > +
> > +	/* marshal it in page array */
> > +	if (!pagelist) {
> > +		pagelist = ceph_pagelist_alloc(GFP_KERNEL);
> > +		if (!pagelist)
> > +			return -ENOMEM;
> > +		ret = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
> > +		if (ret)
> > +			goto out;
> > +		ceph_pagelist_encode_32(pagelist, 1);
> > +	}
> > +
> > +	name = CEPH_XATTR_NAME_ENCRYPTION_CONTEXT;
> > +	name_len = strlen(name);
> > +	ret = ceph_pagelist_reserve(pagelist, 4 * 2 + name_len + ctxsize);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (as->pagelist) {
> > +		BUG_ON(pagelist->length <= sizeof(__le32));
> > +		if (list_is_singular(&pagelist->head)) {
> > +			le32_add_cpu((__le32*)pagelist->mapped_tail, 1);
> > +		} else {
> > +			struct page *page = list_first_entry(&pagelist->head,
> > +							     struct page, lru);
> > +			void *addr = kmap_atomic(page);
> > +			le32_add_cpu((__le32*)addr, 1);
> > +			kunmap_atomic(addr);
> > +		}
> > +	}
> > +
> 
> I've been staring at this function for a bit.  And at this point I would
> expect something like this:
> 
> 	} else
> 		as->pagelist = pagelist;
> 
> as I'm not seeing pagelist being used anywhere if it's allocated in this
> function.
> 

It gets used near the end, in the ceph_pagelist_append calls. Once we've
appended the xattr, we don't need the pagelist anymore and can free it.

That said, the whole way the ceph_pagelist stuff is managed is weird.
I'm not clear why it was done that way, and maybe we ought to rework
this, SELinux and ACL handling to not use them.

I think that's a cleanup for another day.
-- 
Jeff Layton <jlayton@kernel.org>

