Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B072D8F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 07:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjFMFGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 01:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjFMFFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:05:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3E18E;
        Mon, 12 Jun 2023 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5zDf6/0B/zL7xd9Ex0auSe0TPOeVQ4ktNw1lfiHlBqQ=; b=Y6J50pePIeJWvofoxRgmfatfDS
        tZUaUmLniY61o/U0jn4qNJEhIoBE2/uoUixtplOls+J3pclmCdiu7TrnwQXMg7QwfamHCLBcbposb
        tVmSlzrfPSGFYFsdsPVt2auvrv4re+Wn4zkwvrWbXhSkNERDAP7LMnPoJu1/CgyUxs9q09ISDokn0
        Cj2v3BJnkw25HIyUfP2KTQB0m6leDI/y6wjUPqI+pzYl0nPKlAg4fZ6XJH+02Xbgd54y1ypDgAD7p
        NXU2tqWZThm/EBVte+vnSlWgyEufR29XjaXpeQUJzlgY1IGuiQcj047IIltNvcgWOCK8Zs5fXqk+U
        RL/ZrcjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8wE3-006wF3-2V;
        Tue, 13 Jun 2023 05:05:51 +0000
Date:   Mon, 12 Jun 2023 22:05:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and
 others
Message-ID: <ZIf5LydN7shXU519@infradead.org>
References: <ZIa51URaIVjjG35D@infradead.org>
 <87wn09ghqh.fsf@doe.com>
 <20230612150520.GA11467@frogsfrogsfrogs>
 <ZIc1A5uMthrT1hya@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIc1A5uMthrT1hya@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 04:08:51PM +0100, Matthew Wilcox wrote:
> But other than that, I approve.  Unless you just want to do without it
> entirely and do
> 
> 	struct iomap_folio_state *state = folio->private;
> 
> instead of
> 
> 	struct iomap_folio_state *state = to_folio_state(folio);
> 
> I'm having a hard time caring between the two.

The direct dereference is fine to me as well and bypasses the naming
discussion entirely, which is always a plus.

I didn't notice the folio had switched to a void pointer for the private
data vs the always somewhat odd unsigned long in the page, making this
possibly and preferred by me.
