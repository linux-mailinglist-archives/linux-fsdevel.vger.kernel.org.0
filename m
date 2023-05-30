Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D224716851
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjE3P67 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjE3P6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:58:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44C7EC;
        Tue, 30 May 2023 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xo+9YJqIlNX5CkXFPT9/tOeJlUpNZJWwJsWPiPRjO34=; b=a/4wUBQBOA7ZKeL+US2Hb0UQ5B
        /uyae9/MztFBLT6xagj5Kj2uv4hUiq2xViYGiPyQzX5Dq1TrmE8j/2BmArhkvRNdZnoJKHuR3oGjT
        q70EOipgTCOr/gMVzEKY8Fld1WQ3d/Wei+V81fuf1wVcN0h4k+CwBCbTwkDA5byJ8rA+Q75oIpbuM
        iI75d5d8+/HxTAiGtolR57f7tauEk6fbSDNcy1G4kDvEbevNMhKYhPjvMkEn8KzgDS5lB3DBvpG4n
        vFNEkSG3LolLX4YWiZguakd3aNdyD1HVVpI5G4nS+PAQU4T04qEMPX+yl4QDrn2KolGB81WSxTBfA
        Ed6MfK9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q41jm-006QJo-VH; Tue, 30 May 2023 15:58:19 +0000
Date:   Tue, 30 May 2023 16:58:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com
Subject: Re: [PATCH v6 19/20] fs: iomap: use __bio_add_folio where possible
Message-ID: <ZHYdGlqnl922CDe0@casper.infradead.org>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
 <e809b83d60d9fb0f65a8116b3e50f1432f594725.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e809b83d60d9fb0f65a8116b3e50f1432f594725.1685461490.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 08:49:22AM -0700, Johannes Thumshirn wrote:
> When the iomap buffered-io code can't add a folio to a bio, it allocates a
> new bio and adds the folio to that one. This is done using bio_add_folio(),
> but doesn't check for errors.
> 
> As adding a folio to a newly created bio can't fail, use the newly
> introduced __bio_add_folio() function.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

