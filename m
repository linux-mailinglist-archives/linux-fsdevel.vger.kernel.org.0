Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F54E7939
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 17:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbiCYQsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357111AbiCYQsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:48:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E043E339F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 09:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tX+nPhI46D8fF5eNlX2pBGKdrwcJeodsxhXztnvwMwo=; b=H26sgs4tvsMhxknbgEYB2W0ib7
        3MJgNHnw6vmU70YzrGPaj8ijgIAW2RGtz08zmD8r2B3lQORRSnJwwM5gA8uKbMqKw+mMwdOw/K7Z+
        aEpDKPVRTM7iMYnzYLajI7E7nU9xd7AEtkZeDPSFDzBXCUlHQk3z7n51OoymF57g84Mdy4ZnVpeSv
        zTDDIPEj+TyVYKW+s+U5AHXFO9y1D2mNWHwD9xuweM5n+jgdLtGCWIXdK493YyMuw551bs+4Xye+G
        jayRzeuy1fIXHDDJayRXtIEU/NQYREFTngwDlwrw69hgQk1FwqglXjxsJ5AuFhmlbr2O+PYFMiLn5
        0/+KmGqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXn5e-002dYD-P1; Fri, 25 Mar 2022 16:47:06 +0000
Date:   Fri, 25 Mar 2022 09:47:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Niels Dossche <dossche.niels@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] fs/dcache: use write lock in the fallback instead of
 read lock
Message-ID: <Yj3yCqOcg0Jo9K+G@infradead.org>
References: <20220325155804.10811-1-dossche.niels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325155804.10811-1-dossche.niels@gmail.com>
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

> @@ -1692,7 +1692,7 @@ void shrink_dcache_for_umount(struct super_block *sb)
>  {
>  	struct dentry *dentry;
>  
> -	WARN(down_read_trylock(&sb->s_umount), "s_umount should've been locked");
> +	WARN(down_write_trylock(&sb->s_umount), "s_umount should've been locked");

This really should be a lockdep_assert_held_write() instead.
