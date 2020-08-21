Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36BE24D61B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgHUNb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgHUNbz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:31:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64906C061573;
        Fri, 21 Aug 2020 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AIbazufSjLEMEQ/d/Dh4pzlQECF2J1OLKd5TXR+II1g=; b=Cuq3iopCyVuYMmI6xbYWhJ1Kl0
        0boWHRzDvAaO2vLimQwyTgS/xEuMuO++yFe37kDXEXMvaDf9/VNnh2/TPnWtZD75afcstreGP2Ax0
        NMqzK6i16wUPYSmrrx4PEt+PQEVR4AOD2P+nYEBXCqmuzvfJ6r7wCoNjBEXNbpQZn2q5UsoMtAB+P
        TATSZC29536WsJXebAjdJo6I0UHaShiqCFYD0haW4GYBoPbgVqzedCkzez1n9rkQMZ93fDqo5WDoq
        nRuqig6eDHOPlm6YHAugAJu+oHcKQlJ67Gvnb2ngSzlrLCRvp3/gVpJVj8xmiKer+Q1I7l29AJBr/
        CT1VtZAw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9794-0005mN-ND; Fri, 21 Aug 2020 13:31:50 +0000
Date:   Fri, 21 Aug 2020 14:31:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [PATCH] iomap: Fix the write_count in iomap_add_to_ioend().
Message-ID: <20200821133150.GT17456@casper.infradead.org>
References: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819102841.481461-1-anju@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:58:41PM +0530, Anju T Sudhakar wrote:
> __bio_try_merge_page() may return same_page = 1 and merged = 0. 
> This could happen when bio->bi_iter.bi_size + len > UINT_MAX. 
> Handle this case in iomap_add_to_ioend() by incrementing write_count.

One of the patches I have pending ignores same_page by just using the
write_count as a byte count instead of a segment count.  It's currently
mixed into this patch but needs to be separated.

http://git.infradead.org/users/willy/pagecache.git/commitdiff/0186d1dde949a458584c56b706fa8dfd252466ff

(another patch does the same thing to the read count).
