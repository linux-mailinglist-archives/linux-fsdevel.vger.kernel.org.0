Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811666A85F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 17:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCBQOP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 11:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCBQOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:14:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD68498B7;
        Thu,  2 Mar 2023 08:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x+ixSdP2zPXopsM7yTBEHWYzYmGh5aQ6xAk6tH2TQig=; b=aWE3ZHhHs3R480VC6l6XGkOUG/
        YQhj6A3YaByPe6I9Kj7d0n9UvZEmlE1X6kltVw+UPGFov+4MeloNfqXZVftCzDH2gqnJyDdJ2IcZO
        hDmOYTwDA+hu4z9E1jfIY31uJ4hZJqJdzB32HVr/CGog/8RpIA9Vw5dTI7L2DqhLgmxY/bqQtGDAq
        QvLfTLrlybxp05Ao5y4/ukWMXeUIIiHioUgjHAvxTZqe8RdI1gI2kXV3y4K9k1eT0t4RQEjpo4FCg
        h3pM2W+07GFdBm+YnB868vBpmE0A1on/3nqSU1bkmjZ6BXYib5cmSC4KGpXztJhI1mtFUdwDz+yq+
        nnoLvAXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXlZE-002VaC-Ro; Thu, 02 Mar 2023 16:14:04 +0000
Date:   Thu, 2 Mar 2023 16:14:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: Re: [PATCH 1/3] kernfs: Introduce separate rwsem to protect inode
 attributes.
Message-ID: <ZADLTO0NM1yb5ZLF@casper.infradead.org>
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
 <20230302043203.1695051-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302043203.1695051-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:32:01PM +1100, Imran Khan wrote:
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -47,6 +47,7 @@ struct kernfs_root {
>  
>  	wait_queue_head_t	deactivate_waitq;
>  	struct rw_semaphore	kernfs_rwsem;
> +	struct rw_semaphore	kernfs_iattr_rwsem;
>  };
>  
>  /* +1 to avoid triggering overflow warning when negating it */

Can you explain why we want one iattr rwsem per kernfs_root instead of
one rwsem per kernfs_node?
