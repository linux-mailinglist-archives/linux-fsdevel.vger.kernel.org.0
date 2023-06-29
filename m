Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4E741E93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 05:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF2DI1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 23:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjF2DI0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:08:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2C3187;
        Wed, 28 Jun 2023 20:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UyjrCotgO7uYZOm+6Yg4lhXn3aLv6mW8Va1xLVdfQ7c=; b=qVUr0VHRTIHla7fIYfeQiHZNW+
        QRa3R+LBa1d7EskIqn9EftfFl60q4+2a7B8RknJBs1+NL0zXUZOvRihf/qP8doVM8YGWBgtWEgcBO
        ONVla/ercIhcnDZp46AGDi/BVbxs+G7LJottUP+SyisegXdIiL35enE5WezgWCBqw2hR2Z+/2VV8u
        ofsuDZcFfXkO4ZFTwVRDqBONkb8eNZ2Y/Od5d1031YE2s0906NCdwL9vU4eWaDxjJxj0yzCsPBIEG
        Zh/JxOOoZtEOVVnpf5JawymHFG55XuTXed3T7FvwtW+AusOMCqfPPGw2Xn16NrRehIo3WSo96NfYr
        4izXUJXA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qEi0x-004XyR-7b; Thu, 29 Jun 2023 03:08:11 +0000
Date:   Thu, 29 Jun 2023 04:08:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Sumitra Sharma <sumitraartsy@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <ZJz1m/1ZE/iuZuxB@casper.infradead.org>
References: <20230627135115.GA452832@sumitra.com>
 <ZJxqmEVKoxxftfXM@casper.infradead.org>
 <649ceb3aeb554_92a1629445@iweiny-mobl.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649ceb3aeb554_92a1629445@iweiny-mobl.notmuch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:23:54PM -0700, Ira Weiny wrote:
> Matthew Wilcox wrote:
> > Here's a more comprehensive read_folio patch.  It's not at all
> > efficient, but then if we wanted an efficient vboxsf, we'd implement
> > vboxsf_readahead() and actually do an async call with deferred setting
> > of the uptodate flag.  I can consult with anyone who wants to do all
> > this work.
> > 
> > I haven't even compiled this, just trying to show the direction this
> > should take.
> 
> I'm a bit confused.  Is this progressing toward having the folio passed
> down to vboxsf_read() or just an expanded vboxsf_read_folio which can
> handle larger folios as well as fix the kmap?

This just handles large folios & switches to kmap_local_folio().  Doing
this properly is a _lot_ of work, and needs someone who can commit to
actually testing it.
