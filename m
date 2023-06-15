Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C5E730EE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 07:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238287AbjFOF6m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 01:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbjFOF6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 01:58:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EE270C;
        Wed, 14 Jun 2023 22:58:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 912AB67373; Thu, 15 Jun 2023 07:58:31 +0200 (CEST)
Date:   Thu, 15 Jun 2023 07:58:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Hannes Reinecke <hare@suse.de>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 1/2] highmem: Add memcpy_to_folio()
Message-ID: <20230615055831.GA5609@lst.de>
References: <20230614114637.89759-1-hare@suse.de> <20230614134853.1521439-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614134853.1521439-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 02:48:52PM +0100, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of memcpy_to_page(), but it handles large
> highmem folios.  It may be a little too big to inline on systems that
> have CONFIG_HIGHMEM enabled but on systems we actually care about almost
> all the code will be eliminated.

I suspect the right thing is to have the trivial version without kmapping
for !HIGHMEM inline, and a separate version with the kmap loop out of
line for HIGHMEM builds.

Same for the next patch.
