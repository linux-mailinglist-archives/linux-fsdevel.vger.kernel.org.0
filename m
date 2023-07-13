Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D162C75255F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjGMOm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjGMOmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:42:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4922705;
        Thu, 13 Jul 2023 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qlBSNZe+0NvNZn+P5G748gKaiHgsz3ciqEGyUuZBWjY=; b=D0QNrR2P0oNIy7MaTXRI+ArkOC
        URsmfC9MHg39RcQQZVmyGDySTaD2Pj57LcxQmPM4seAF2bGHpenh6tA8IkLPJj3R3IoY4fWocGnyU
        dNChIBk9sqJRRwZkJeyD8RW+noZi6wbfPIjNVov6KwtDPB2dJZDRIn/ZTX52zf7wQFXGBz3bqD/KW
        NTeRLnwTh0d7OGY654VUO6DgmpsXTwshYlx4oDUP0kfDYVShY8TTfEghSJ4xrZBVlFDhvKnH+48dG
        H2MHBrXXp7Iq28BXSYYg66g18mcIPnXRPor94tD2a9Lc8CwC6a1C4LsGEJ4zm07j9x/+Qt8PJlMW3
        QnmDEMcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJxWM-000EHP-W7; Thu, 13 Jul 2023 14:42:19 +0000
Date:   Thu, 13 Jul 2023 15:42:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4 7/9] filemap: Allow __filemap_get_folio to allocate
 large folios
Message-ID: <ZLANSurqCQi2jHmP@casper.infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
 <20230710130253.3484695-8-willy@infradead.org>
 <20230713050439.ehtbvs3bugm6vvtb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713050439.ehtbvs3bugm6vvtb@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:04:39AM -0400, Kent Overstreet wrote:
> On Mon, Jul 10, 2023 at 02:02:51PM +0100, Matthew Wilcox (Oracle) wrote:
> > Allow callers of __filemap_get_folio() to specify a preferred folio
> > order in the FGP flags.  This is only honoured in the FGP_CREATE path;
> > if there is already a folio in the page cache that covers the index,
> > we will return it, no matter what its order is.  No create-around is
> > attempted; we will only create folios which start at the specified index.
> > Unmodified callers will continue to allocate order 0 folios.
> 
> Why not just add an end_index parameter to filemap_get_folio()?

I'm reluctant to add more parameters.  Aside from the churn, every extra
parameter makes the function that little bit harder to use.  I like this
encoding; users who don't know/care about it get the current default
behaviour, and it's a simple addition to the users who do want to care.
end_index is particularly tricky ... what if it's lower than index?

