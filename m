Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA102352FC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Aug 2020 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgHAPhQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Aug 2020 11:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAPhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:37:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86674C06174A;
        Sat,  1 Aug 2020 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yI7TX5klAseKr0Z3D3BS8xEKHJ+ORcK03f7IAlX4iJU=; b=dSY5QXHatS2DCto5C80rS/BTwQ
        r59sRNJL3/z73ZC2XXhgHHXFhGGnxhCdtCXqiYHlYeQTGIuERgE4x9FjlpxN+Zjo0jOHHjFwrDf7o
        KmcY4X/Ko7sAbiXgsJkHu3p4M2+FseQ8XBNYeBxPgjyoFLKhW/QA40DaA4MreUshLgoLzR15NWRVp
        F3V9QM/eUfURIKoXUaF8KBH88NSOHQ+wgqLRNpVwBel1qrVFdH3YV/SQs0pHxt1fLuKMR76TKD5HH
        hAV5YaL+0F8AIU1cnL9OZYvDuBBMCkAZPXvdpM3pkU+so/aW7B0OO0EWTxm+TdmBS84Rt1C4lP3sT
        EWUe8Gzw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1tZP-0004jB-U1; Sat, 01 Aug 2020 15:37:11 +0000
Date:   Sat, 1 Aug 2020 16:37:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: optimise kiocb_set_rw_flags()
Message-ID: <20200801153711.GV23808@casper.infradead.org>
References: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e523f51f59ad6ecdad4ad22c560cb9c913e96e1a.1596277420.git.asml.silence@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 01, 2020 at 01:36:33PM +0300, Pavel Begunkov wrote:
> Use a local var to collect flags in kiocb_set_rw_flags(). That spares
> some memory writes and allows to replace most of the jumps with MOVEcc.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

If you want to improve the codegen here further, I would suggest that
renumbering the IOCB flags to match the RWF flags would lead to better
codegen (can't do it the other way around; RWF flags are userspace ABI,
IOCB flags are not).  iocb_flags() probably doesn't get any worse because
the IOCB_ flags don't have the same numbers as the O_ bits (which differ
by arch anyway).

