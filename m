Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E94690C48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 15:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBIO5F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 09:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjBIO5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:57:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F6EFF750;
        Thu,  9 Feb 2023 06:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BSmW7Iho/4/wXxxcfwoME8Q/qLAcfNzxOyq316M3Rcs=; b=ofOcVA38kMkyoZhsneBjHSGe6K
        QW+oxgXmuUQ4T56T3vxZZkp9K/e9zboAkYzKJresLmvERZFYKRAp4DbLzpGPEICb3bH1BYuD3H+Ii
        taDywoKde9WO9TiOXQyDiYrLOiZj88o+/BCeikcuFAmyEcEEhdX6kgqRNAYZKxzEV1WccJolHXLl2
        +Mku1/e1n0a/zA84F7t1n9aq0qe8hOk3HnrMEsb87CV+ijfJu9caZMZgUoF7mp4lZWXcQNe1mTl9m
        SoiWevi8ZNxdSTgMEOMA0vuajieOIpNu+QMcfvpC/Ts0Ri/pdjj8NlL7ziAcpBp+PoMxJje12BCqe
        Ov3PVmYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQ8M7-002HNo-L6; Thu, 09 Feb 2023 14:56:59 +0000
Date:   Thu, 9 Feb 2023 14:56:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] afs: Split afs_pagecache_valid() out of
 afs_validate()
Message-ID: <Y+UJu6PLCHYXl5il@casper.infradead.org>
References: <20230208145335.307287-3-willy@infradead.org>
 <20230208145335.307287-1-willy@infradead.org>
 <684134.1675952905@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684134.1675952905@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 09, 2023 at 02:28:25PM +0000, David Howells wrote:
> Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> 
> >  extern int afs_getattr(struct mnt_idmap *idmap, const struct path *,
> >  		       struct kstat *, u32, unsigned int);
> >  extern int afs_setattr(struct mnt_idmap *idmap, struct dentry *, struct iattr *);
> 
> This doesn't apply to linus/master.  I'm guessing it's based on something
> else?

next-20230203.  I'm guessing it's "fs: port xattr to mnt_idmap" that's
causing merge conflicts for you?
