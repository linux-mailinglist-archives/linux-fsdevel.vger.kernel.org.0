Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01378712250
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 10:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbjEZIft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 04:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbjEZIfs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 04:35:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58276199;
        Fri, 26 May 2023 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cU4HbZ0Ihk69KMRkjUWIN8WBPWiQau/75Wx/UKV6Xy8=; b=NbqKOjNGXmKVkdSnQezuWV1eT5
        shzgQn36kaoEabnbYb/Jyz3Rdfyo4i9Gt9NcFEgBW4SxCR9JG+o+jSKnUKh34k8rrj8nhlDQulx6y
        6VreloRZ4j6ECTgnH6aVsJIOwYtIqjD5EVkDYaakhcl9aFDyVUPVL/7qPbXwjDPiuKZjBAJ0h2p/c
        AeN+fmkiyu4Cusz7HUAP0Hz6pvjMNSt5HsMgL8MBhbG43QEg+Ri3e8GndeuvIjNy1idYUYW6cxIiL
        jsCIs6TkJFVD5KST6G7qRiRVkM5o6ra1UpwTs2oEuwtb9GLGqQOM7RcaspSqneNmqabaORhr7WwZy
        Stg1KBDw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2Sv2-001cm2-0Z;
        Fri, 26 May 2023 08:35:28 +0000
Date:   Fri, 26 May 2023 01:35:28 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, djwong@kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, a.manzanares@samsung.com, dave@stgolabs.net,
        yosryahmed@google.com, keescook@chromium.org, hare@suse.de,
        kbusch@kernel.org, patches@lists.linux.dev,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 0/8] add support for blocksize > PAGE_SIZE
Message-ID: <ZHBvUNqKEyszpJKT@bombadil.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
 <ZHBqfyPUR4B2GNsF@infradead.org>
 <ZHBrS4hTZZn3w4tF@bombadil.infradead.org>
 <ZHBtk3mmupubbWyc@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZHBtk3mmupubbWyc@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 01:28:03AM -0700, Christoph Hellwig wrote:
> On Fri, May 26, 2023 at 01:18:19AM -0700, Luis Chamberlain wrote:
> > On Fri, May 26, 2023 at 01:14:55AM -0700, Christoph Hellwig wrote:
> > > On Fri, May 26, 2023 at 12:55:44AM -0700, Luis Chamberlain wrote:
> > > > This is an initial attempt to add support for block size > PAGE_SIZE for tmpfs.
> > > 
> > > The concept of a block size doesn't make any sense for tmpfs.   What
> > > are you actually trying to do here?
> > 
> > More of helping to test high order folios for tmpfs. Swap for instance
> > would be one thing we could use to test.
> 
> I'm still not sure where the concept of a block size would come in here.

From a filesystem perspective that's what we call it as well today, and
tmpfs implements a simple one, just that indeed this just a high order
folio support. The languge for blocksize was used before my patches for the
sb->s_blocksize and sb->s_blocksize_bits. Even for shmem_statfs()
buf->f_bsize.

I understand we should move the sb->s_blocksize to the block_device
and use the page order for address_space, but we can't negate the
existing stuff there immediately.

  Luis
