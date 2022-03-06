Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27EF4CE85A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 03:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiCFC66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 21:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiCFC65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 21:58:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4DDE0D1;
        Sat,  5 Mar 2022 18:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TvYRN1YmUBdHSWPYQwg2K3EE2AkUEhTFgrDPAkH+IiY=; b=mKq4YwMS6eUAxFggJkyGM2x7hn
        C6PrW9vm1cR73JF+afzt0DHevDIgFxF8zX+NMeez5fBEFTChhRgNzjz71qFtB4NPllNdVa/PJHKHA
        sTyZt6GjlkEZ30FyhadWd78j/rNd6vWnWjuX6Rh84K3pLCg2Je1zHkIFf1VDTv2/Eeh3wqt/oEQyX
        UznNY0HjgIGb/bYsVBZhZu9zFIfUu7F48Q8tEEJHDryC+pNpdNViBX8BnpsvkA+FwmuCTl9+vxCCH
        BH8zaYFk9GHzvTXZA+AbTajg5+My6nID+Go5DHMCGTB7EFc3mXzx2e5FHcvkLmgKaFosZfV6fweUl
        4HJ1/eYg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQh5n-00E3CB-Eu; Sun, 06 Mar 2022 02:57:55 +0000
Date:   Sun, 6 Mar 2022 02:57:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        linux-sgx@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, codalist@coda.cs.cmu.edu,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC] mm: Add f_ops->populate()
Message-ID: <YiQjM7LdwoAWpC5L@casper.infradead.org>
References: <20220306021534.83553-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306021534.83553-1-jarkko@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 06, 2022 at 04:15:33AM +0200, Jarkko Sakkinen wrote:
> Sometimes you might want to use MAP_POPULATE to ask a device driver to
> initialize the device memory in some specific manner. SGX driver can use
> this to request more memory by issuing ENCLS[EAUG] x86 opcode for each
> page in the address range.
> 
> Add f_ops->populate() with the same parameters as f_ops->mmap() and make
> it conditionally called inside call_mmap(). Update call sites
> accodingly.

Your device driver has a ->mmap operation.  Why does it need another
one?  More explanation required here.
