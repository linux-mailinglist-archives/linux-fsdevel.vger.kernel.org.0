Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE58E561E46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 16:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiF3Ojj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 10:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiF3OjW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:39:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F071928A;
        Thu, 30 Jun 2022 07:38:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEbwFJ000461
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656599881; bh=rZwPiLcKye0U/mwTOCKDykueQ6+V0zCIaDXWdLBBeO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ys+pFhD/OX//kD7MlmS3BJ92SirYngNws0DllJmHUer2zwRl0B4HPiTpBItpRH7qa
         Ea2dBXSeGgJSOGobvkMMm0L5wwawJsm3tzxAaRfwI0+ojQ/YTUqnbZDiZaMHUmWalr
         4KPAl3mjsxecX9dN6cvh/sfbBfg2ixmkBKdyvZkHAx1J5BMYEXsYDagvoE2COARDFG
         AbTkkKx7A0/ezq+rBHRm/GDh1L6i3MBCMoAqP4D2TU1+//oEaMQlqFAtY9tsAQ0nZb
         WW34OFwYzcCWgD5SvUNtzZyhlP3Rw0RULwD66GOSPUazwt6ddAZrmO/KprrAnVyEaq
         aLr/Unsy9Z+uA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8477815C3E94; Thu, 30 Jun 2022 10:37:58 -0400 (EDT)
Date:   Thu, 30 Jun 2022 10:37:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Dominique MARTINET <dominique.martinet@atmark-techno.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: Major btrfs fiemap slowdown on file with many extents once in
 cache (RCU stalls?) (Was: [PATCH 1/3] filemap: Correct the conditions for
 marking a folio as accessed)
Message-ID: <Yr21RoL+ztf1W5Od@mit.edu>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
 <Yr1QwVW+sHWlAqKj@atmark-techno.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1QwVW+sHWlAqKj@atmark-techno.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 04:29:05PM +0900, Dominique MARTINET wrote:
> Hi Willy, linux-btrfs@vger,
> 
> Matthew Wilcox (Oracle) wrote on Sun, Jun 19, 2022 at 04:11:41PM +0100:
> > We had an off-by-one error which meant that we never marked the first page
> > in a read as accessed.  This was visible as a slowdown when re-reading
> > a file as pages were being evicted from cache too soon.  In reviewing
> > this code, we noticed a second bug where a multi-page folio would be
> > marked as accessed multiple times when doing reads that were less than
> > the size of the folio.
> 
> when debugging an unrelated issue (short reads on btrfs with io_uring
> and O_DIRECT[1]), I noticed that my horrible big file copy speeds fell
> down from ~2GB/s (there's compression and lots of zeroes) to ~100MB/s
> the second time I was copying it with cp.
> 
> I've taken a moment to bisect this and came down to this patch.

I think you may have forgotten to include the commit-id that was the
results of your bisect.... ?

					- Ted
