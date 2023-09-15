Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB9C7A2765
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbjIOTt3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbjIOTs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:48:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24912105;
        Fri, 15 Sep 2023 12:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WBVxEdKN63NHXHCCRu/fwhuDd28XfSSWxEv7k+XBY9g=; b=pdDlku3meiiSaPWPouNeoL+qTk
        DyxzV6ISQSsbD96x6LLvz7Yf+Y4VXboIabhv290t6LoSU+18OMGD1TLoKwU0e0++Yl/CCStyXOy3u
        NmWvq8lTTDms3yCsr0gzXYed2aVqi29iAMbBNv6tISsFNGYNVlXAr+fheDkqcj4xOznWR0Cr5VxD8
        jATaiH2xdOTWs4NfAWx2f45kk/WuTNKR7bCRmHuRjhnUHGS92H5zh6jl0CwzQKTLnm6biC01F+NC9
        cAYqKQ+F9fzrONcTJpiUz9AJgL32udasHPs3SXXGUsZCLFJ9ktZCf8f/pOrOBYExgN1KuFnNdEHGV
        sJ9SzQtw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qhEnz-00BgCA-GT; Fri, 15 Sep 2023 19:48:43 +0000
Date:   Fri, 15 Sep 2023 20:48:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <kernel@pankajraghav.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        mcgrof@kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 07/23] filemap: align the index to mapping_min_order in
 __filemap_add_folio()
Message-ID: <ZQS1GyfwqJXstRQA@casper.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-8-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915183848.1018717-8-kernel@pankajraghav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:38:32PM +0200, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Align the index to the mapping_min_order number of pages while setting
> the XA_STATE and xas_set_order().

Not sure why this one's necessary either.  The index should already be
aligned to folio_order.

Some bits of it are clearly needed, like checking that folio_order() >=
min_order.
