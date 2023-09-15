Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDE7A2A73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 00:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbjIOW2e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbjIOW2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:28:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B4C83;
        Fri, 15 Sep 2023 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8LC9ABYMtvMooE79NbP16TEYzDeGtu70GqKcQJq0kq8=; b=yvjb2o6tPz1MXMBAeSj5x0aIeX
        cSyGmvEkgi9faScHYHoY7w2yGKAMnNLOrG7feAdQ0cZfW75y5sLVzItObHcbaA/wCbNeC7u9i7Vb3
        qVDqisy5tG+YMgMDi1CyH/XCPBPSVguSQJ7wZMp+4qsQK42Uf4LLP+6hCaYjmZLJMqDi3EhMjv/0N
        7T0Bk4kV6enU9TwwKEPuV/91RFgY2hBsV/hsFaqrU1Vmv3k179SqOkLfZj/J2KvTIygP9k3HJBb5i
        9iBIo7uUEM24yU59PUtlrUf3IHvGSg+AbdAG4MWXzCNGJN9bvnComXGA1VWmb50RdGbAqA9KuFJu1
        iudWUlVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qhHI6-00BUEa-2Z;
        Fri, 15 Sep 2023 22:27:58 +0000
Date:   Fri, 15 Sep 2023 15:27:58 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        brauner@kernel.org, hare@suse.de, ritesh.list@gmail.com,
        rgoldwyn@suse.com, jack@suse.cz, ziy@nvidia.com,
        ryan.roberts@arm.com, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, dan.helmick@samsung.com
Subject: Re: [RFC v2 07/10] nvme: enhance max supported LBA format check
Message-ID: <ZQTablZ1mHzb/MJl@bombadil.infradead.org>
References: <20230915213254.2724586-1-mcgrof@kernel.org>
 <20230915213254.2724586-8-mcgrof@kernel.org>
 <ZQTYt9qG0AxhgR4I@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQTYt9qG0AxhgR4I@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:20:39PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 02:32:51PM -0700, Luis Chamberlain wrote:
> > +/* XXX: shift 20 (1 MiB LBA) crashes on pure-iomap */
> > +#define NVME_MAX_SHIFT_SUPPORTED 19
> 
> I imagine somewhere we do a PAGE_SIZE << 20 and it overflows an int to 0.
> I've been trying to use size_t everywhere, but we probably missed
> something.
> 
> Does 19 work on a machine with 64kB pages?  My guess is no.

Let's ask someone who *might* have access to a 64k PAGE_SIZE system or
might know someone who does.

I definitely don't!

  Luis
