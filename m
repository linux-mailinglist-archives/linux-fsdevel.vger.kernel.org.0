Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442D26B960A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 14:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCNNZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjCNNZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:25:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0195BE3;
        Tue, 14 Mar 2023 06:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NNdt8Wz1epDx/x0kbbQr5KnKKMW58gz7CK+aWbaWSh4=; b=S979cjgEbJ5GffG9UeBjKhdSRp
        yG/tWxypcKHOTqZJEabpN98fshMNe2yIo7+534iezark2gCWIxJpDWdBarAepP9VGUtvBARd7Fefw
        6QT2ZYuPntW5DD0U+pc6npTzGoioGH9ITKg1T/OiGriQIFpSbhsPAL3xTELDB4J65OKE515zaVqpo
        or21VZYRmDZhvA7vwDDmTC1XZ6yqlfO3TIeU9bgjqjyxEpaCC/60wDDn2cwm5B40nFUjWugfTFHil
        jM19nN9tLSneq+gLdzkA90SMwYtFS3SWE3n+dNWiK4I4tgZzIMPVj8dgrch20jilxb3vrqXO7KmDU
        24xvxBGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pc3tn-00Cu0B-LU; Tue, 14 Mar 2023 12:37:03 +0000
Date:   Tue, 14 Mar 2023 12:37:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
Message-ID: <ZBBqbz7LeSZLr7s/@casper.infradead.org>
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:51:10PM +0100, Christian Brauner wrote:
> +++ b/include/linux/fs.h
> @@ -2675,6 +2675,8 @@ extern struct inode *new_inode(struct super_block *sb);
>  extern void free_inode_nonrcu(struct inode *inode);
>  extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
>  extern int file_remove_privs(struct file *);
> +int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> +			     const struct inode *inode);

Is there a reason that setattr_should_drop_sgid() doesn't take a
const struct mnt_idmap pointer?
