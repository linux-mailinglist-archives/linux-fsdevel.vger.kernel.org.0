Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA20D7428AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjF2OnD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 10:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjF2OnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:43:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B74D1FC1;
        Thu, 29 Jun 2023 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bsfX3JMuop516GotuJhoV/AW1k9XSHNWBLWZsLPkEfA=; b=KdkTx/37O+SRDDy+Gmt/3IeIsE
        ypBdKFSOaF3yMJEYD5mwHT2aEXPEuFgd8Wt5cx6m7V/yIqlNC8r9GGSWGmeqrLM+wXj9tTGhRQh91
        46jvSIcyaoKQlgCc25/kI3zV0KMwteIG+XcJm15s0/Q+TEfTwK2IZOD/l3BZJs0Ly7KzGneO9DOga
        /tJ2f2KMgZfuIBAs9rXs9D5Zt9CkmRhJubprLvZHlCC2NmcT/JKvMAELfSKsn9AUgVgSlfLPAftY3
        hhvWxU3Jy9GBvikFinPWALjIg/6qCrDQTQw9B1j/S9MydcGkYBpjGRv5UHNRu57m1sQqtl7rOH+iw
        bvZBvKIw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEsrH-004wOF-7l; Thu, 29 Jun 2023 14:42:55 +0000
Date:   Thu, 29 Jun 2023 15:42:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <ZJ2Yb8YOpakO7SbY@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org>
 <20230629092844.GA456505@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629092844.GA456505@sumitra.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 02:28:44AM -0700, Sumitra Sharma wrote:
> On Wed, Jun 28, 2023 at 06:15:04PM +0100, Matthew Wilcox wrote:
> > Here's a more comprehensive read_folio patch.  It's not at all
> > efficient, but then if we wanted an efficient vboxsf, we'd implement
> > vboxsf_readahead() and actually do an async call with deferred setting
> > of the uptodate flag.  I can consult with anyone who wants to do all
> > this work.
>
> So, after reading the comments, I understood that the problem presented 
> by Hans and Matthew is as follows:
> 
> 1) In the current code, the buffers used by vboxsf_write()/vboxsf_read() are 
> translated to PAGELIST-s before passing to the hypervisor, 
> but inefficiently— it first maps a page in vboxsf_read_folio() and then 
> calls page_to_phys(virt_to_page()) in the function hgcm_call_init_linaddr(). 

It does ... and I'm not even sure that virt_to_page() works for kmapped
pages.  Has it been tested with a 32-bit guest with, say, 4-8GB of memory?

> The inefficiency in the current implementation arises due to the unnecessary 
> mapping of a page in vboxsf_read_folio() because the mapping output, i.e. the 
> linear address, is used deep down in file 'drivers/virt/vboxguest/vboxguest_utils.c'. 
> Hence, the mapping must be done in this file; to do so, the folio must be passed 
> until this point. It can be done by adding a new member, 'struct folio *folio', 
> in the 'struct vmmdev_hgcm_function_parameter64'. 

That's not the way to do it (as Hans already said).

The other problem is that vboxsf_read() is synchronous.  It makes the
call to the host, then waits for the outcome.  What we really need is
a vboxsf_readahead() that looks something like this:

static void vboxsf_readahead(struct readahead_control *ractl)
{
	unsigned int nr = readahead_count(ractl);
	req = vbg_req_alloc(... something involving nr ...);
	... fill in the page array ...
	... submit the request ...
}

You also need to set up a kthread that will sit on the hgcm_wq and handle
the completions that come in (where you'd call folio_mark_uptodate() if
the call is successful, folio_unlock() to indicate the I/O has completed,
etc, etc).

Then go back to read_folio() (which can be synchronous), and maybe factor
out the parts of vboxsf_readahead() that can be reused for filling in
the vbg_req.

Hans might well have better ideas about this could be structured; I'm
new to the vbox code.
