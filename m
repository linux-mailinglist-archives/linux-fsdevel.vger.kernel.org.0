Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC667A2698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjIOSvp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237118AbjIOSvf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:51:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9886A4684;
        Fri, 15 Sep 2023 11:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LO1yu7NDurGz5o2rdddgqdJM3Q13LpqRTHQ7QT9TTOo=; b=HC2OPQqFxalw4dkSw+zCUvDi2m
        CySSkIZYKgpzi/LAc5N11o7WrBB/5FE6qHQOeedzceli1IkuyglEbMmyOkF0kR7qaHuZTui26guLx
        i8m56aRO6jFnb8AgdkHySPgjuP2zdjMt9daRxVPXvNN2ogy4I5yktIu4oD19CEom1Iz9bhwIQPro3
        TQAgxXmkowCZUSxIEmDGxBveDUNejR/hhRiC7vxY57WzssKbFQ4NbVCGiMPA2IWlDCfdGqaKuQx7I
        vrVxbi3B3dBMMycQVMptqrnEbNWy0SL8Q6/R0GiPPWafnvEJdx76F06W3OVITw886NCLdjabT+UpU
        7Q/ufstQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhDtB-00BPM9-Ii; Fri, 15 Sep 2023 18:50:01 +0000
Date:   Fri, 15 Sep 2023 19:50:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 00/23] Enable block size > page size in XFS
Message-ID: <ZQSnWUF2M1iNzGWM@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:25PM +0200, Pankaj Raghav wrote:
> Only XFS was enabled and tested as a part of this series as it has
> supported block sizes up to 64k and sector sizes up to 32k for years.
> The only thing missing was the page cache magic to enable bs > ps. However any filesystem
> that doesn't depend on buffer-heads and support larger block sizes
> already should be able to leverage this effort to also support LBS,
> bs > ps.

I think you should choose whether you're going to use 'bs > ps' or LBS
and stick to it.  They're both pretty inscrutable and using both
interchanagbly is worse.

But I think filesystems which use buffer_heads should be fine to support
bs > ps.  The problems with the buffer cache are really when you try to
support small block sizes and large folio sizes (eg arrays of bhs on
the stack).  Supporting bs == folio_size shouldn't be a problem.

