Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859494FCE6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 07:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiDLFEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 01:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiDLFEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:04:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1A340C9;
        Mon, 11 Apr 2022 22:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xxpfJwOTp0zZ4mEFeo2bEwyNiH/HvBWSwa1t8TxoKCk=; b=1Bp/fmvIlZv8uA/4GoXEweJp/p
        jlJjY7tp9v1H/I5gwNEEO8e0bZ+Pz7kTlrArNY8Qe0bCZY5RqIYP42bATTDtDeCzwmjVWRpAoDz5c
        N1TuusZGVo27oRO9a9kJoTXp3442Y9BfyiVseUegOZXd81cxS7Ei/UsUe98Hysm3X1HJ9bHQnhjrf
        AXHrMIYfxlvEEO8dXxBI45I6AT6iOV5hybD+7tPANpKCYjrdiZ4KnB4YbFOjAE1hnmn4bwv63GFnP
        DnEVvUVr2iAriSepVlr/s9pY6Vlrw4MhRUdh/9HmyVWfHpc/9QkTixdWDnWm+iKqECdmpASOrXPVq
        /kHk02qQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ne8fR-00Bjrs-9H; Tue, 12 Apr 2022 05:02:17 +0000
Date:   Mon, 11 Apr 2022 22:02:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v7 4/6] dax: add DAX_RECOVERY flag and .recovery_write
 dev_pgmap_ops
Message-ID: <YlUH2f66hMyXOP1r@infradead.org>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-5-jane.chu@oracle.com>
 <CAPcyv4jpOss6hzPgM913v_QsZ+PB6Jzo1WV=YdUvnKZiwtfjiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jpOss6hzPgM913v_QsZ+PB6Jzo1WV=YdUvnKZiwtfjiA@mail.gmail.com>
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

On Mon, Apr 11, 2022 at 09:57:36PM -0700, Dan Williams wrote:
> So how about change 'int flags' to 'enum dax_access_mode mode' where
> dax_access_mode is:
> 
> /**
>  * enum dax_access_mode - operational mode for dax_direct_access()
>  * @DAX_ACCESS: nominal access, fail / trim access on encountering poison
>  * @DAX_RECOVERY_WRITE: ignore poison and provide a pointer suitable
> for use with dax_recovery_write()
>  */
> enum dax_access_mode {
>     DAX_ACCESS,
>     DAX_RECOVERY_WRITE,
> };
> 
> Then the conversions look like this:
> 
>  -       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
>  +       rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1,
> DAX_ACCESS, &kaddr, NULL);
> 
> ...and there's less chance of confusion with the @nr_pages argument.

Yes, this might be a little nicer.
