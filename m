Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E5A3049C4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbhAZFXv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:23:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:48252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbhAYKQJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:16:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18B10AD8C;
        Mon, 25 Jan 2021 10:13:57 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 2dfa81f0;
        Mon, 25 Jan 2021 10:14:49 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v4 08/17] ceph: add routine to create fscrypt
 context prior to RPC
References: <20210120182847.644850-1-jlayton@kernel.org>
        <20210120182847.644850-9-jlayton@kernel.org> <87tur8532c.fsf@suse.de>
        <d4f84211f017280cd1dd98bcdee99d11621c5d7f.camel@kernel.org>
Date:   Mon, 25 Jan 2021 10:14:49 +0000
In-Reply-To: <d4f84211f017280cd1dd98bcdee99d11621c5d7f.camel@kernel.org> (Jeff
        Layton's message of "Fri, 22 Jan 2021 12:32:56 -0500")
Message-ID: <87zh0xuxuu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Fri, 2021-01-22 at 16:50 +0000, Luis Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > After pre-creating a new inode, do an fscrypt prepare on it, fetch a
>> > new encryption context and then marshal that into the security context
>> > to be sent along with the RPC.
>> > 
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/ceph/crypto.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++
>> >  fs/ceph/crypto.h | 12 ++++++++++
>> >  fs/ceph/inode.c  |  9 +++++--
>> >  fs/ceph/super.h  |  3 +++
>> >  4 files changed, 83 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> > index 879d9a0d3751..f037a4939026 100644
>> > --- a/fs/ceph/crypto.c
>> > +++ b/fs/ceph/crypto.c
>> > @@ -46,3 +46,64 @@ void ceph_fscrypt_set_ops(struct super_block *sb)
>> >  {
>> >  	fscrypt_set_ops(sb, &ceph_fscrypt_ops);
>> >  }
>> > +
>> > +int ceph_fscrypt_prepare_context(struct inode *dir, struct inode *inode,
>> > +				 struct ceph_acl_sec_ctx *as)
>> > +{
>> > +	int ret, ctxsize;
>> > +	size_t name_len;
>> > +	char *name;
>> > +	struct ceph_pagelist *pagelist = as->pagelist;
>> > +	bool encrypted = false;
>> > +
>> > +	ret = fscrypt_prepare_new_inode(dir, inode, &encrypted);
>> > +	if (ret)
>> > +		return ret;
>> > +	if (!encrypted)
>> > +		return 0;
>> > +
>> > +	inode->i_flags |= S_ENCRYPTED;
>> > +
>> > +	ctxsize = fscrypt_context_for_new_inode(&as->fscrypt, inode);
>> > +	if (ctxsize < 0)
>> > +		return ctxsize;
>> > +
>> > +	/* marshal it in page array */
>> > +	if (!pagelist) {
>> > +		pagelist = ceph_pagelist_alloc(GFP_KERNEL);
>> > +		if (!pagelist)
>> > +			return -ENOMEM;
>> > +		ret = ceph_pagelist_reserve(pagelist, PAGE_SIZE);
>> > +		if (ret)
>> > +			goto out;
>> > +		ceph_pagelist_encode_32(pagelist, 1);
>> > +	}
>> > +
>> > +	name = CEPH_XATTR_NAME_ENCRYPTION_CONTEXT;
>> > +	name_len = strlen(name);
>> > +	ret = ceph_pagelist_reserve(pagelist, 4 * 2 + name_len + ctxsize);
>> > +	if (ret)
>> > +		goto out;
>> > +
>> > +	if (as->pagelist) {
>> > +		BUG_ON(pagelist->length <= sizeof(__le32));
>> > +		if (list_is_singular(&pagelist->head)) {
>> > +			le32_add_cpu((__le32*)pagelist->mapped_tail, 1);
>> > +		} else {
>> > +			struct page *page = list_first_entry(&pagelist->head,
>> > +							     struct page, lru);
>> > +			void *addr = kmap_atomic(page);
>> > +			le32_add_cpu((__le32*)addr, 1);
>> > +			kunmap_atomic(addr);
>> > +		}
>> > +	}
>> > +
>> 
>> I've been staring at this function for a bit.  And at this point I would
>> expect something like this:
>> 
>> 	} else
>> 		as->pagelist = pagelist;
>> 
>> as I'm not seeing pagelist being used anywhere if it's allocated in this
>> function.
>> 
>
> It gets used near the end, in the ceph_pagelist_append calls. Once we've
> appended the xattr, we don't need the pagelist anymore and can free it.

Doh!  Sorry for the noise ;-)

Cheers,
-- 
Luis

> That said, the whole way the ceph_pagelist stuff is managed is weird.
> I'm not clear why it was done that way, and maybe we ought to rework
> this, SELinux and ACL handling to not use them.
>
> I think that's a cleanup for another day.
> -- 
> Jeff Layton <jlayton@kernel.org>
>
