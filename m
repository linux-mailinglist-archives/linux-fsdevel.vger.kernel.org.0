Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31846BA1C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 23:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCNWGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 18:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCNWGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:06:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA4A2D161
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 15:06:03 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32EM5pOZ026141
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678831553; bh=f55aRfAdSgVp59T5HwTu8L46hWS9gBZtqUR3rWlVLMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aQTu7T1onkNDVVuFhddOe5AXpleOPSCC0u/rUyPpFdJqUtMUefuRIzeOOIGDT5R8M
         /sdtLYK94SgH5W6hkx4SM0kWjZZR/LlTV8jglMuyzX0CthjvKYSPU4nB/8ox2g+5Xb
         vnS5dngKJdGexkz4O9Cj2RR92eOcgb0DFI3ULNGPO7eHXZsKlo2+949ESL1f9GaUF0
         YvR7lpOttarZtfICoLiWm3t6NFEjzoQVDqY5Nm3eyVtDiXGujtYeoABqG39v8Kl8iH
         i3nhztvya9GGILU/uRoYrlA10grhvWcJcIGUA50rsqKQtkeOstnubXfF1ssIDHJRdo
         Fm9VYwfFl5zRg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 70C7715C5830; Tue, 14 Mar 2023 18:05:51 -0400 (EDT)
Date:   Tue, 14 Mar 2023 18:05:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/31] fscrypt: Add some folio helper functions
Message-ID: <20230314220551.GQ860405@mit.edu>
References: <20230126202415.1682629-1-willy@infradead.org>
 <20230126202415.1682629-3-willy@infradead.org>
 <Y9M+tl5CcNfRScds@sol.localdomain>
 <Y9P4MYXE9NcC8+gv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9P4MYXE9NcC8+gv@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:13:37PM +0000, Matthew Wilcox wrote:
> 
> It's out of scope for _this_ patchset.  I think it's a patchset that
> could come either before or after, and is needed to support large folios
> with ext4.  The biggest problem with doing that conversion is that
> bounce pages are allocated from a mempool which obviously only allocates
> order-0 folios.  I don't know what to do about that.  Have a mempool
> for each order of folio that the filesystem supports?  Try to allocate
> folios without a mempool and then split the folio if allocation fails?
> Have a mempool containing PMD-order pages and split them ourselves if
> we need to allocate from the mempool?
> 
> Nothing's really standing out to me as the perfect answer.  There are
> probably other alternatives.

Hmm.... should we have some kind of check in case a large folio is
passed to these fscrypt functions?  (e.g., some kind of BUG_ON, or
WARN_ON?)

Or do we just rely on people remembering that when we start trying to
support large folios for ext4, it will probably have to be the easy
cases first (e.g., no fscrypt, no fsverity, block size == page size)?

      	    	      	       	  	    - Ted

      	    	      	       	  

