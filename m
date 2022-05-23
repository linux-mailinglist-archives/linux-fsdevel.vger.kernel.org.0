Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4253196C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiEWUTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 16:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEWUTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 16:19:34 -0400
X-Greylist: delayed 2991 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 13:19:32 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5369BC6C1;
        Mon, 23 May 2022 13:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BEjCKmEEMSSOtJMVmqVfIC+RkZgNI8u3xBenZK+hUro=; b=XRTrc4lAUy9jkpgVFOq2TSxezd
        I3wKs11DSNWPt0smYy84y8nX4OQpi2ShTNU+G9tW+Yllwv6rMJhJQ7BXgKVp1vNon4qhiH1MqoODT
        l/Z0+UcxTluUmD/IPXWAYoogG+L7bdnoCFn41igpJqE+Z0iBqPr6hgZahTLWZDS1Hs5bTMGfphH8F
        XO5iqaxMoV2nZbBszT3k9ljMldkb1qdaL4+ZUE91w5xsku3P8VN18E/atgx0/LbcuB5y8eG65c+zb
        8J/dPbRR92XSx0HQiulEuZ4Sjx1DrsRys+Q+UVF9bIaUIPS+JwEisoXZvd78Aoa+iG3xZ0t7m7ri2
        Y+kik54w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntCIl-005SSl-Cr; Mon, 23 May 2022 17:57:07 +0000
Date:   Mon, 23 May 2022 10:57:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     jlayton@kernel.org, idryomov@gmail.com, viro@zeniv.linux.org.uk,
        willy@infradead.org, vshankar@redhat.com,
        ceph-devel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fs/dcache: add d_compare() helper support
Message-ID: <YovK86vEmOUUoBn6@bombadil.infradead.org>
References: <20220519101847.87907-1-xiubli@redhat.com>
 <20220519101847.87907-2-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519101847.87907-2-xiubli@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 06:18:45PM +0800, Xiubo Li wrote:
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/dcache.c            | 15 +++++++++++++++
>  include/linux/dcache.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 93f4f5ee07bf..95a72f92a94b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -2262,6 +2262,21 @@ static inline bool d_same_name(const struct dentry *dentry,
>  				       name) == 0;
>  }
>  
> +/**
> + * d_compare - compare dentry name with case-exact name
> + * @parent: parent dentry
> + * @dentry: the negative dentry that was passed to the parent's lookup func
> + * @name:   the case-exact name to be associated with the returned dentry
> + *
> + * Return: 0 if names are same, or 1
> + */
> +bool d_compare(const struct dentry *parent, const struct dentry *dentry,
> +	       const struct qstr *name)
> +{
> +	return !d_same_name(dentry, parent, name);

What's wrong with d_same_name()? Why introduce a whole new operation
and export it when you the same prototype except first and second
argument moved with an even more confusing name?

> +}
> +EXPORT_SYMBOL(d_compare);

New symbols should go with EXPORT_SYMBOL_GPL() instead.

  Luis
