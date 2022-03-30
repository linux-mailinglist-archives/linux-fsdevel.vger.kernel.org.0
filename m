Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28734EBA47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 07:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbiC3Fnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 01:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbiC3Fns (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 01:43:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F12235757;
        Tue, 29 Mar 2022 22:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XYYGWYlGuqIll3206prQVGyP0v/a7w+dmLgKcE4zaws=; b=jHHEU4mvd0H5k2hZQ2Oh1VIDR3
        ZsbE/wCHfCB3yo6Tv3WBxleJOBG5ac3ibd3V6uBxVQCqrxXmSfZyD6hLBU7jrd4ZYlnTDcbU4X3EA
        4qzEE0C1hDU3VdFrAO0w5xxIA/+PsG8trZyx992Le9Grzq1a36f3m07Dbvj1SXjQqr/UZP70leQTg
        HrTR85viFYLEBCb4gcSTqrZvQq2/1kGUszwuEO7eefI/g0/2iJ/crGr9oCCfcZiVisT/j39xzcLh0
        XcnL1oWNCPc0aLsQEryrtCXzxkh2yA0drzYSof6Xj0pKdU8LsIL60mtA3sY6JyhsWwkaUIoB7ZNHF
        KTpo10vg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZR5i-00EMe6-R7; Wed, 30 Mar 2022 05:41:58 +0000
Date:   Tue, 29 Mar 2022 22:41:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
Message-ID: <YkPtptNljNcJc1g/@infradead.org>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
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

On Wed, Mar 16, 2022 at 09:46:07PM +0800, Shiyang Ruan wrote:
> > Forgive me if this has been discussed before, but since dax_operations
> > are in terms of pgoff and nr pages and memory_failure() is in terms of
> > pfns what was the rationale for making the function signature byte
> > based?
> 
> Maybe I didn't describe it clearly...  The @offset and @len here are
> byte-based.  And so is ->memory_failure().

Yes, but is there a good reason for that when the rest of the DAX code
tends to work in page chunks?
