Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C597318CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 14:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjFOMTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbjFOMSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:18:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A125430E6;
        Thu, 15 Jun 2023 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JVkEymm9Huz2MtiY0wDbPcEQlIvMLsxvpW7ZXqGQT6g=; b=Zjh/4hR537kymKP0ZUnB9VMxA8
        KV2pEVvme1tx9tB/D+d3U1q9yID9hvsk7FzqYu2pYXmc8CWBfPvQYpAHZYFx3fiiFS9eUkmk5UMaG
        ew2hCpiH9bFSSzJvpwiodmXg7tWWeX4gQJ6u2oyh5CHWu7WHbEF/sht65Xh8oj+DpBiZi8+qeT179
        bMpmwRPJS+lV/cA1XlUb8OyxXA6sFAX/suxRIa6Pj6DYuju6S7o1sQ47T83nqD/C90nkOMpz0youm
        LwZDNrjOjFloBOBo3zHDbg/G22Ca03bHywratYyTWxdP/bZVEqh/dUXzvP5ywZow5lai+OFXHofTO
        +8FxoWQA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9ltb-007cut-7c; Thu, 15 Jun 2023 12:16:11 +0000
Date:   Thu, 15 Jun 2023 13:16:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/2] highmem: Add memcpy_to_folio()
Message-ID: <ZIsBC9+dCx2bifP+@casper.infradead.org>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614134853.1521439-1-willy@infradead.org>
 <20230615055831.GA5609@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615055831.GA5609@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:58:31AM +0200, Christoph Hellwig wrote:
> On Wed, Jun 14, 2023 at 02:48:52PM +0100, Matthew Wilcox (Oracle) wrote:
> > This is the folio equivalent of memcpy_to_page(), but it handles large
> > highmem folios.  It may be a little too big to inline on systems that
> > have CONFIG_HIGHMEM enabled but on systems we actually care about almost
> > all the code will be eliminated.
> 
> I suspect the right thing is to have the trivial version without kmapping
> for !HIGHMEM inline, and a separate version with the kmap loop out of
> line for HIGHMEM builds.
> 
> Same for the next patch.

Yeah, that's what I did to zero_user_segments().  As time goes by,
I'm starting to care about performance of CONFIG_HIGHMEM systems less
and less.


