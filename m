Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82E46E242F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 15:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDNNVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 09:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDNNVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:21:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84A0120;
        Fri, 14 Apr 2023 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4n2+V3v5NS7BrPgVP+hnCjbRjgXvefs1QrA/ZzAt1rk=; b=aFlGGh9LKFSqzG3gk5GP4IZVVR
        aDCSNtXbnQlGh8gbAzVyVTDNw1yE7Kcp6M7hD8NDZeFo7qNgc1r6x4tNIRG4YTomr6vG92QMHBdf4
        TaT6NjUcJvRa6LHd+iKTpebivKX4nRnlk6h8nAy+E/2htxm+wtNSCR4RjQy9R8Rpo6FAUXib7k7yj
        VE8PhACWRGQpowge2ROd6v0cD9juIOFE4BDy4NTP99QIqQn2bLeamnVCDoyjYVfmSbF/X/iY/FTOc
        GY8mN7syt6HUnehZ196E55XencDVdB6RCMyF5/1yHeMzqMFCwajwo9eAwhWclvbgXPrVqLNQIOqWh
        EHiUT1Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnJMm-008lyW-8u; Fri, 14 Apr 2023 13:21:28 +0000
Date:   Fri, 14 Apr 2023 14:21:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     brauner@kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        gost.dev@samsung.com, hare@suse.de
Subject: Re: [RFC 4/4] fs/buffer: convert create_page_buffers to
 create_folio_buffers
Message-ID: <ZDlTWILV+E7XAzDy@casper.infradead.org>
References: <20230414110821.21548-1-p.raghav@samsung.com>
 <CGME20230414110827eucas1p20e5f6bc74025acfb62b13465f267fa84@eucas1p2.samsung.com>
 <20230414110821.21548-5-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414110821.21548-5-p.raghav@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:08:21PM +0200, Pankaj Raghav wrote:
> fs/buffer do not support large folios as there are many assumptions on
> the folio size to be the host page size. This conversion is one step
> towards removing that assumption. Also this conversion will reduce calls
> to compound_head() if create_folio_buffers() calls
> folio_create_empty_buffers().

I'd call this folio_create_buffers(), but other than that, looks good.
