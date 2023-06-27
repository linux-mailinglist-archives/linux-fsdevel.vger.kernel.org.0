Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0026C74027B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjF0RqH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjF0RqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:46:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B8271D;
        Tue, 27 Jun 2023 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3piB8sV1UFL/lFG8Il7umSIZWxHMcPA2/YMJz4ovkgg=; b=SHHXU0p7apD8wJBMyab2sxX9YR
        YDfr1sh5721+G1hjPW5AoeHnujg4ovEzxR1OdblAFTnNf9OGk3ECHT/3dJea73EqX6T/t2rg7SvD3
        mnkPEFGzgjLoSdg1SEPeazqogVVAh9A+DD8+a7TCehDvAoPh7woWnY35mTq6KmZe5tC0oOdoiIMVk
        the3jRD4+QPv5ayrhpV+ztAjMdEzlSqvlZHjKgLaVKgMDdcEb8wUb8wzqIXjxKYLkY1W1wvVVcIhy
        Hmwt2RNrLq0XjAFoA8I8w73TXPVj3ER7mRssjLhFm4BUhI/QFJyqDTcd3zjeGqkZQGiEzjoy05Hiq
        Geynaz1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEClN-002wao-QO; Tue, 27 Jun 2023 17:46:01 +0000
Date:   Tue, 27 Jun 2023 18:46:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <ZJsgWQb+tOqtQuKL@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com>
 <6a566e51-6288-f782-2fa5-f9b0349b6d7c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a566e51-6288-f782-2fa5-f9b0349b6d7c@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:34:51PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 6/27/23 15:51, Sumitra Sharma wrote:
> > kmap() has been deprecated in favor of the kmap_local_page() due to high
> > cost, restricted mapping space, the overhead of a global lock for
> > synchronization, and making the process sleep in the absence of free
> > slots.
> > 
> > kmap_local_{page, folio}() is faster than kmap() and offers thread-local
> > and CPU-local mappings, can take pagefaults in a local kmap region and
> > preserves preemption by saving the mappings of outgoing tasks and
> > restoring those of the incoming one during a context switch.
> > 
> > The difference between kmap_local_page() and kmap_local_folio() consist
> > only in the first taking a pointer to a page and the second taking two
> > arguments, a pointer to a folio and the byte offset within the folio which
> > identifies the page.
> > 
> > The mappings are kept thread local in the functions 'vboxsf_read_folio',
> > 'vboxsf_writepage', 'vboxsf_write_end' in file.c
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> 
> Thanks, patch looks good to me:

It doesn't look great to me, tbh.  It's generally an antipattern to map
the page/folio up at the top and then pass the virtual address down to
the bottom.  Usually we want to work in terms of physical addresses
as long as possible.  I see the vmmdev_hgcm_function_parameter can
take physical addresses; does it work to simply use the phys_addr
instead of the linear_addr?  I see this commentary:

       /** Deprecated Doesn't work, use PAGELIST. */
        VMMDEV_HGCM_PARM_TYPE_PHYSADDR           = 3,

so, um, can we use
        /** Physical addresses of locked pages for a buffer. */
        VMMDEV_HGCM_PARM_TYPE_PAGELIST           = 10,

and convert vboxsf_read_folio() to pass the folio down to vboxsf_read()
which converts it to a PAGELIST (however one does that)?
