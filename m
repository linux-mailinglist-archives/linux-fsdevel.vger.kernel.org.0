Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E06BA2B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCNWqe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCNWqd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:46:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9451443910
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:46:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EMkJQY015156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678833981; bh=EIw3Ie5TxrW1nfO5BfJJMgBnHdIwKHl0l4whmp/KkbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=erYjPhE5URyPdmvcgHk5D/48YoVDe6YsN0iemipQAjDspdPmBCRRFp3AXDmpmjoDO
         mFSnWkyvOvJfb7qFcaqRcIxKJtwBCWnkyTjt4qepNiT1YFPRF0C4DtVIorVIMs+P8/
         W0kw8V7mhM7wLuwMy4PzHrD68A+vi2iFBCi21gL7N2QF5qO13oDvGHZaQrI26YJx57
         5zKbCOsfTtb7mx0fZwwltFuhU8x7hzb4UOEN18R/Yjbs4qkbaB28VNQU2NV2ioWvcA
         88W86lqT3HFEb2Y7Sk+L4m1qoZ9Frb24RkXwqlIhbQ0hPcX7ja8tS8DGeOL3o9M9Rr
         i8iRCCVgUtoNg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 814C715C5830; Tue, 14 Mar 2023 18:46:19 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:46:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 19/31] ext4: Convert ext4_journalled_zero_new_buffers()
 to use a folio
Message-ID: <20230314224619.GF860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-20-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126202415.1682629-20-willy@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:24:03PM +0000, Matthew Wilcox (Oracle) wrote:
> Remove a call to compound_head().

Same question as with other commits, plus one more; why is it notable
that calls to compound_head() are being reduced.  I've looked at the
implementation, and it doesn't look all _that_ heavyweight....

