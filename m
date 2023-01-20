Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9A1674A8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 05:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjATE2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 23:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjATE23 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:28:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B054B1EFD;
        Thu, 19 Jan 2023 20:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1AI2BoTZ1TxiBr87rR6t97wpf7nTvA1VN4SaoYxdtVI=; b=qN94m404d4LRMeZ5oPMDLZ73R8
        UJTm3lSLb/Wf64W4drKAhPLGoZ94PwKS4FxnvuZ4WvNs1mlv+I0vx+3DWy8DS7exbop92N8GBHsPT
        hNdWGMRk7y0LHjYIYWYNCVvl/YVunxE1HmgKubmAwVAko9zDhVusnCfeiG+E2IkN3BVNH8nuaiacI
        wxWICtfAtT3ZizSRF0ElUdR9nWIncSsMvbxfDXT0hDt4AsaXDj5TVP7iDIjarWjcs8Spg7zEsg5mO
        atg58RoSz4SokTF6Qqnzfyx2cXcAzACvkSHjQOpJ4/OYQYv0LY2z6g/iSN3WcioYuPIwkx9CgJcu7
        qDzj22pA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIj0e-001eSU-N9; Fri, 20 Jan 2023 04:28:12 +0000
Date:   Fri, 20 Jan 2023 04:28:12 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3 4/4] fs/sysv: Replace kmap() with kmap_local_page()
Message-ID: <Y8oYXEjunDDAzSbe@casper.infradead.org>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
 <20230119153232.29750-5-fmdefrancesco@gmail.com>
 <Y8oWsiNWSXlDNn5i@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8oWsiNWSXlDNn5i@ZenIV>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:21:06AM +0000, Al Viro wrote:
> On Thu, Jan 19, 2023 at 04:32:32PM +0100, Fabio M. De Francesco wrote:
> 
> > -inline void dir_put_page(struct page *page)
> > +inline void dir_put_page(struct page *page, void *page_addr)
> >  {
> > -	kunmap(page);
> > +	kunmap_local(page_addr);
> 
> ... and that needed to be fixed - at some point "round down to beginning of
> page" got lost in rebasing...

You don't need to round down in kunmap().  See:

void kunmap_local_indexed(const void *vaddr)
{
        unsigned long addr = (unsigned long) vaddr & PAGE_MASK;

