Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F64DFD0AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfKNWAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 17:00:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKNWAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R9rapZsPL2Sc4OaIDs6c/5nQ15OuRRZR9anBWrXMzdI=; b=rLBqMtfqNB+uY84vih6nZntUG
        ZnKfo9QJqJ8AcTVXQIqO5nbGL9jANx5BNOJ1UoqG3o46XOYt/bYMv9ksOEQq2KAmjKE3l0u2N/r1q
        8zh9MWZNiZDLDX0UM0aTJcd56XWuoqXq1etH2ib4ShfZM791Y2z0C8JLb9p4GNFXWODKnLws59PJN
        r4PU4/TrQp0qXt+lMbuDfZP+p3WSTbfOj1X0BLeKJn7dgexZdOT/cvwdr81bR8U1vSTl7WqShfzoE
        KkhP6urUSTOpfXa8V6uP8SgbW9kJsdntcNwhZq+Lojj8Z1dr15jWpoMADBDzD/1evAL3+Atyqp2ud
        aaxGeging==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVN9z-0005AF-Gk; Thu, 14 Nov 2019 22:00:15 +0000
Date:   Thu, 14 Nov 2019 14:00:15 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     xiang@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] staging: erofs: tidy up decompression frontend
Message-ID: <20191114220015.GA20752@bombadil.infradead.org>
References: <20191114190848.f6tlqpnybagez76g@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114190848.f6tlqpnybagez76g@kili.mountain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:10:03PM +0300, Dan Carpenter wrote:
> 	fs/erofs/zdata.c:443 z_erofs_register_collection()
> 	error: double unlocked 'cl->lock' (orig line 439)
> 
> fs/erofs/zdata.c
>    432          cl = z_erofs_primarycollection(pcl);
>    433          cl->pageofs = map->m_la & ~PAGE_MASK;
>    434  
>    435          /*
>    436           * lock all primary followed works before visible to others
>    437           * and mutex_trylock *never* fails for a new pcluster.
>    438           */
>    439          mutex_trylock(&cl->lock);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^
>    440  
>    441          err = erofs_register_workgroup(inode->i_sb, &pcl->obj, 0);
>    442          if (err) {
>    443                  mutex_unlock(&cl->lock);
>                         ^^^^^^^^^^^^^^^^^^^^^^^
> How can we unlock if we don't know that the trylock succeeded?

The comment says it'll always succeed.  That said, this is an uncommon
pattern -- usually we just mutex_lock().  If there's a good reason to use
mutex_trylock() instead, then I'd prefer it to be guarded with a BUG_ON.

