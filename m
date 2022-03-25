Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE7A4E7941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 17:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiCYQuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355060AbiCYQuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:50:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D3BF53C
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5XEgUtW8BAa3ty5tfm9QFPQ3EyBbqzLVH+Voto8vDU=; b=lCGXwCAkt3w5f+MS266D8no0kf
        kcEwzFkB2+YeSHaDn0xIgzMAtjQIts4FjD8zfxzUHa8lf51cZa4mbR4aa7YvH6P1yig0l01d7PoAZ
        JBL04VWKIBODgC0OsFTs9HirW/vRAbK91Z/z1KamRiYqFAISvqp8uUtWtClaAOUH31RRXDQHaIgaI
        MiRzDv8Sk8hfCyjepdb8qxuA2/nwD8BKmhYb0HDF6Frfsnz3JWXHjH62AciogxXr9vq2QGHezDJXn
        f3edKzlRaTFfZ9ENF/FeHFj0j7A3VQltfneEx3y2E8fCabvCWjsObUxyjRvZn+oZRtbzFg1zHNnnu
        k54/89ow==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXn7n-002dgl-OJ; Fri, 25 Mar 2022 16:49:19 +0000
Date:   Fri, 25 Mar 2022 09:49:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/dcache: use write lock in the fallback instead of
 read lock
Message-ID: <Yj3yj3KULli7nKr7@infradead.org>
References: <20220325155804.10811-1-dossche.niels@gmail.com>
 <Yj3yCqOcg0Jo9K+G@infradead.org>
 <814c6a67-0fa4-862c-c98e-0e3e77cee4c1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <814c6a67-0fa4-862c-c98e-0e3e77cee4c1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 05:48:43PM +0100, Niels Dossche wrote:
> >> -	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
> >> +	WARN(down_write_trylock(&sb->s_umount), "s_umount should've been locked");
> > 
> > This really should be a lockdep_assert_held_write() instead.
> 
> That's probably a bit nicer indeed.
> I can write up a patch that does a lockdep_assert_held_write() if you want.

I would much prefer that.
