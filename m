Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E9F7A521E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjIRSgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRSgN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:36:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388BC10D;
        Mon, 18 Sep 2023 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=83UBXje6sUk9WQn75kJ8b+5PbDOix+4jIDRAqbsZBZI=; b=n4a5FdcOoqT1RgfzLlj/F0VmUC
        HE5gfUbRZWc7yXpix1tK3ST/7dYyaFvG/1iudJ23+afNDyitWgbo077hJWs39miKja/uUlLW4GbGp
        TWYGjFv/i86FkNkPXRxpioTGcwWM79JYt19QeXMOUPXvaeNZx4H8YoC8hy2gYsAId5g0slLNiqRD2
        V0FiOFIaxS04XCiPKKpDWVnaS1kyUT8OTwyJ/swXA7T9wPxKIbowwrfJ0VS9CgErlMhh3ec6nAkCx
        +Wm2dnsBeHUAcCqSk+2Of1reWaWQvbFnUrHdbn9C7/1emkK7pk2wuOawPk38lPPW48EQEZ3HnfxIM
        wjDj/1gw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qiJ6I-00G5ix-39;
        Mon, 18 Sep 2023 18:36:03 +0000
Date:   Mon, 18 Sep 2023 11:36:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Pankaj Raghav <kernel@pankajraghav.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, p.raghav@samsung.com,
        david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        djwong@kernel.org, linux-mm@kvack.org, chandan.babu@oracle.com,
        gost.dev@samsung.com
Subject: Re: [RFC 08/23] filemap: align the index to mapping_min_order in
 filemap_get_folios_tag()
Message-ID: <ZQiYkhDDsWS7PNzZ@bombadil.infradead.org>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
 <20230915183848.1018717-9-kernel@pankajraghav.com>
 <ZQS1o38TOOI+AY5H@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQS1o38TOOI+AY5H@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 15, 2023 at 08:50:59PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 15, 2023 at 08:38:33PM +0200, Pankaj Raghav wrote:
> > From: Luis Chamberlain <mcgrof@kernel.org>
> > 
> > Align the index to the mapping_min_order number of pages while setting
> > the XA_STATE in filemap_get_folios_tag().
> 
> ... because?  It should already search backwards in the page cache,
> otherwise calling sync_file_range() would skip the start if it landed
> in a tail page of a folio.

Thanks! Will drop and verify!

  Luis
