Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0372C95D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbjFLPI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbjFLPI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:08:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913718C;
        Mon, 12 Jun 2023 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n3e11jRQWWC935V1Hjg1spGDix3QZMtSzpgALiBeRjg=; b=klE9+0M74Frd3+4+Ha7S2Oxnk1
        ybkV/8+DMPt24DqQ3MD61j1mb2zcYLlLFtRlLFyyJgQni/9ONCA1BzvqdABsSyINu+3PBTJIEjcKX
        6GxpCdZuVGp57Ul/ynWKQy2CfGID7aHe+/ghng4DPs8lyxiSMCfb/a0d5nPDNaJkgIjIbQNAgoCMP
        J+hMmbH2NZAxHg59Kum6kHY/CTxiASYMgvJrXRRXHlN4Te0nu/a3RQMl3WJ7j5kDJcysQ+Zzvn+0C
        y4o0Rsz6ovSpBwNKe0repwL7lE/ryF5boZXgyzL5UYAWPhs098XjxN/KoRYN8UsA1dfija9VFQiY5
        hlHMl/rg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8jA3-002kvn-Hn; Mon, 12 Jun 2023 15:08:51 +0000
Date:   Mon, 12 Jun 2023 16:08:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv9 1/6] iomap: Rename iomap_page to iomap_folio_state and
 others
Message-ID: <ZIc1A5uMthrT1hya@casper.infradead.org>
References: <ZIa51URaIVjjG35D@infradead.org>
 <87wn09ghqh.fsf@doe.com>
 <20230612150520.GA11467@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612150520.GA11467@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:05:20AM -0700, Darrick J. Wong wrote:
> static inline struct iomap_folio_state *
> to_folio_state(struct folio *folio)
> {
> 	return folio->private;
> }

I'd reformat it to not-XFS-style:

static inline struct iomap_folio_state *to_folio_state(struct folio *folio)
{
	return folio->private;
}

But other than that, I approve.  Unless you just want to do without it
entirely and do

	struct iomap_folio_state *state = folio->private;

instead of

	struct iomap_folio_state *state = to_folio_state(folio);

I'm having a hard time caring between the two.

