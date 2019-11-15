Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3975BFD20F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 01:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfKOArX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 19:47:23 -0500
Received: from sonic313-47.consmr.mail.gq1.yahoo.com ([98.137.65.110]:36791
        "EHLO sonic313-47.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfKOArW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1573778841; bh=a2y6jqLkUnatK91iLJlFJjpg3LEEcm5VqjpkZAkzkDo=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=isNQqD3d/5HQx75lNyGUukVpaRxF7b8Lsf7Rh4pZqqVzACMQKnQ+Zjwers9OUrsOSGm/RUKTaetXFKqGSPcyQ8rF5+lq6Nq8Md4NPsiVJbDNnU6F7MBB7iP9sFQW1bJig59Fb0Q+nQ2Ky2NL0FAHAv6fi3RGeZSVzkONTg9sHsTCR9oBemGpxtk6bhl5I18y7Sii3NX1YebgwkxPS7otAdr0Inigggf242GGJ4obLEgUssjiHbYSgZjs9JL3jji4S1B58qoFcbLwhxX9aFLhr6n1ND6ax206rBvSnHZvypKf+2zcT7rXjNt8Q5btaCc8nOOfTmSm7dtHd0Y+WQGo1w==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Fri, 15 Nov 2019 00:47:21 +0000
Received: by smtp404.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 234bd9b13aa8560229bdcd951a34976d;
          Fri, 15 Nov 2019 00:45:19 +0000 (UTC)
Date:   Fri, 15 Nov 2019 08:45:14 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20191115004512.GA7969@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191114190848.f6tlqpnybagez76g@kili.mountain>
 <20191114220015.GA20752@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114220015.GA20752@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan and Matthew,

On Thu, Nov 14, 2019 at 02:00:15PM -0800, Matthew Wilcox wrote:
> On Thu, Nov 14, 2019 at 10:10:03PM +0300, Dan Carpenter wrote:
> > 	fs/erofs/zdata.c:443 z_erofs_register_collection()
> > 	error: double unlocked 'cl->lock' (orig line 439)
> > 
> > fs/erofs/zdata.c
> >    432          cl = z_erofs_primarycollection(pcl);
> >    433          cl->pageofs = map->m_la & ~PAGE_MASK;
> >    434  
> >    435          /*
> >    436           * lock all primary followed works before visible to others
> >    437           * and mutex_trylock *never* fails for a new pcluster.
> >    438           */
> >    439          mutex_trylock(&cl->lock);
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^
> >    440  
> >    441          err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
> >    442          if (err) {
> >    443                  mutex_unlock(&cl->lock);
> >                         ^^^^^^^^^^^^^^^^^^^^^^^
> > How can we unlock if we don't know that the trylock succeeded?
> 
> The comment says it'll always succeed.  That said, this is an uncommon
> pattern -- usually we just mutex_lock().  If there's a good reason to use
> mutex_trylock() instead, then I'd prefer it to be guarded with a BUG_ON.
>

I think there is no actual problem here. If I am wrong, please kindly point out.
The selected code snippet is too short. The current full code is

static struct z_erofs_collection *clregister(struct z_erofs_collector *clt,
					     struct inode *inode,
					     struct erofs_map_blocks *map)
{
	struct z_erofs_pcluster *pcl;
	struct z_erofs_collection *cl;
	int err;

	/* no available workgroup, let's allocate one */
	pcl = kmem_cache_alloc(pcluster_cachep, GFP_NOFS);
	if (!pcl)
		return ERR_PTR(-ENOMEM);

^ Note that this is a new object here, which is guaranteed that the lock
was always unlocked with the last free (and it firstly inited in init_once).

	z_erofs_pcluster_init_always(pcl);

	pcl->obj.index = map->m_pa >> PAGE_SHIFT;

	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
			Z_EROFS_PCLUSTER_FULL_LENGTH : 0);

	if (map->m_flags & EROFS_MAP_ZIPPED)
		pcl->algorithmformat = Z_EROFS_COMPRESSION_LZ4;
	else
		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;

	pcl->clusterbits = EROFS_I(inode)->z_physical_clusterbits[0];
	pcl->clusterbits -= PAGE_SHIFT;

	/* new pclusters should be claimed as type 1, primary and followed */
	pcl->next = clt->owned_head;
	clt->mode = COLLECT_PRIMARY_FOLLOWED;

	cl = z_erofs_primarycollection(pcl);
	cl->pageofs = map->m_la & ~PAGE_MASK;

	/*
	 * lock all primary followed works before visible to others
	 * and mutex_trylock *never* fails for a new pcluster.
	 */
	mutex_trylock(&cl->lock);

^ That was simply once guarded by BUG_ON, but checkpatch.pl raised a warning,
I can use DBG_BUGON here instead.

	err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
	if (err) {
		mutex_unlock(&cl->lock);

^ free with unlock as a convention as one example above.

		kmem_cache_free(pcluster_cachep, pcl);
		return ERR_PTR(-EAGAIN);
	}

Thanks,
Gao Xiang

