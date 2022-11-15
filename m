Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE800629384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 09:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiKOIov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 03:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236796AbiKOIor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:44:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A3D645E;
        Tue, 15 Nov 2022 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JE+pDa9oSSrGTlesv5H0dmP0xLVCZF0jWZ2Qnff57X4=; b=u0X6G+mImjx/pFk7pniyypRq63
        uemKvyAmtAw7GqwPvrVEdzHDLgGhMXw3Jkq/1NJUiiWqEg4RMW+pbpHcm84jHEaFcqqm54HsMiVF0
        1L3TSD3Pxk6Eg0AEx8D/CTVmrU0qaJKb5H+62XEj5aLux7EgDs3ESD8/lQ7/lPKoFi9H32FXPEp3N
        RkZUPi6qbIGS2W9O6xdYaiBsjN7ypSeYstW/0Qkh02qi+USZLbsnNUZtsPfn/IuhREu3JC9VPpT5J
        PdwB2OsSeyW8XaPTM3Ddo6UnzfoltWHX0D5OE1xffNWAS69Woa6AsG9bk+i9Dshhdp5Xiq5zF0tDl
        u/wXtyMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ourYk-0090jB-Lh; Tue, 15 Nov 2022 08:44:46 +0000
Date:   Tue, 15 Nov 2022 00:44:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 6/9] xfs: xfs_bmap_punch_delalloc_range() should take a
 byte range
Message-ID: <Y3NRfgxWcenyCe+i@infradead.org>
References: <20221115013043.360610-1-david@fromorbit.com>
 <20221115013043.360610-7-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115013043.360610-7-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:30:40PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> All the callers of xfs_bmap_punch_delalloc_range() jump through
> hoops to convert a byte range to filesystem blocks before calling
> xfs_bmap_punch_delalloc_range(). Instead, pass the byte range to
> xfs_bmap_punch_delalloc_range() and have it do the conversion to
> filesystem blocks internally.

Ok, so we do this here.   Why can't we just do this earlier and
avoid the strange inbetween stage with a wrapper?
