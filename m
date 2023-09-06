Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1AD579402B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241298AbjIFPUR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjIFPUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:20:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431871717;
        Wed,  6 Sep 2023 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qxp2t+bVHW8cmZYbivfo0KSh5jDiqaqDQ6bYkaNkWNg=; b=cFN2ja9Wv5igmbovtOkdtREqz3
        Y9jwx4BGIQnvbIf/QdhRs178R1cS7jV8mm5ZcWytjQ6c8fakFAO05eXXGF2sh/zhWcSocKNuspMH2
        knfXjYs35VgCZd/7VP6iIITKtUSc/Z9hGGeODtYBvZEDEIMduXAXwIQ0cPZLSTHa9QCgo6Tyaf8b+
        v4GV5zPRo6HzOiinyWmYRQhL2AExRoGG8wSkYUkXouvHcfSxEmLtlloVRTyK3bQVIbtJFFHCdD7rr
        RsgwKEwIOZl+bYUz+PeOWs/GinxvYA45HU7PV3T8/c7t+RKRt27FSsi88Rk8tV+dbc4oK0ecN3HGS
        urAN1B1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qduK7-003NvM-Rg; Wed, 06 Sep 2023 15:20:07 +0000
Date:   Wed, 6 Sep 2023 16:20:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        bernd.schubert@fastmail.fm
Subject: Re: [RFC PATCH] vfs: add inode lockdep assertions
Message-ID: <ZPiYp+t6JTUscc81@casper.infradead.org>
References: <20230831151414.2714750-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831151414.2714750-1-mjguzik@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:14:14PM +0200, Mateusz Guzik wrote:
> +++ b/include/linux/fs.h
> @@ -842,6 +842,16 @@ static inline void inode_lock_shared_nested(struct inode *inode, unsigned subcla
>  	down_read_nested(&inode->i_rwsem, subclass);
>  }
>  
> +static inline void inode_assert_locked(struct inode *inode)
> +{
> +	lockdep_assert_held(&inode->i_rwsem);
> +}
> +
> +static inline void inode_assert_write_locked(struct inode *inode)
> +{
> +	lockdep_assert_held_write(&inode->i_rwsem);
> +}

This mirrors what we have in mm, but it's only going to trigger on
builds that have lockdep enabled.  Lockdep is very expensive; it
easily doubles the time it takes to run xfstests on my laptop, so
I don't generally enable it.  So what we also have in MM is:

static inline void mmap_assert_write_locked(struct mm_struct *mm)
{
        lockdep_assert_held_write(&mm->mmap_lock);
        VM_BUG_ON_MM(!rwsem_is_locked(&mm->mmap_lock), mm);
}

Now if you have lockdep enabled, you get the lockdep check which
gives you all the lovely lockdep information, but if you don't, you
at least get the cheap check that someone is holding the lock at all.

ie I would make this:

+static inline void inode_assert_write_locked(struct inode *inode)
+{
+	lockdep_assert_held_write(&inode->i_rwsem);
+	WARN_ON_ONCE(!inode_is_locked(inode));
+}

Maybe the locking people could give us a rwsem_is_write_locked()
predicate, but until then, this is the best solution we came up with.
