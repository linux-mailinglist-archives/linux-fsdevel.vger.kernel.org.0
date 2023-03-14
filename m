Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AAC6B95B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 14:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjCNNMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCNNMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EADA54E6;
        Tue, 14 Mar 2023 06:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEEEC6176E;
        Tue, 14 Mar 2023 13:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D71C4339B;
        Tue, 14 Mar 2023 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678799320;
        bh=ED/H03msNnHIgXAuyVjvskK9upZlG+OK2TwrM9SGjfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzowUvaXPkJHagVv7IunguFP90CMIVrU+/qkLKhRqZxhm4Bp/hOJThUW2zrRZdh4L
         38Kv0wLr1xUKWI0uGC4IYqqA1ysKSBB7nmYWySZmxBVnGHQmBoNxmTQuhoz0h4gTDs
         By+35VWKHvbDKogkg8HdKRIxdi96btucu/J+VB5BVfJVd4aCldITeyFkQHl8LfcC9M
         uFmrjN7pAJWhb/f83mtM98kvhf/HvAW0LJeiD9ozLQ49tQQh0qeYXQqXmzuPe1e/kB
         AMVK5cBiB1c23cPEFl1k32K0UzkNJAJlmQP4xuoVU+nudMhExTX2F4k64BjBmbu1co
         vJSGsjzWR+Oxw==
Date:   Tue, 14 Mar 2023 14:08:34 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2] nfs: use vfs setgid helper
Message-ID: <20230314130834.lf4lnebas3yfzspd@wittgenstein>
References: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
 <ZBBqbz7LeSZLr7s/@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZBBqbz7LeSZLr7s/@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:37:03PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 14, 2023 at 12:51:10PM +0100, Christian Brauner wrote:
> > +++ b/include/linux/fs.h
> > @@ -2675,6 +2675,8 @@ extern struct inode *new_inode(struct super_block *sb);
> >  extern void free_inode_nonrcu(struct inode *inode);
> >  extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
> >  extern int file_remove_privs(struct file *);
> > +int setattr_should_drop_sgid(struct mnt_idmap *idmap,
> > +			     const struct inode *inode);
> 
> Is there a reason that setattr_should_drop_sgid() doesn't take a
> const struct mnt_idmap pointer?

Yeah, unfortunately a bunch of helpers that we're passing it down to
from setattr_should_drop_sgid() currently take a non-const pointer to
mnt_idmap. I have a ToDo that to go through all helpers and make them
const wherever we can.
