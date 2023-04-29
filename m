Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940C76F22FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjD2EuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 00:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjD2EuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 00:50:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D8326AF
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k/av0blLG68oYkF2krZftCjiJkXh5BqBmDIS1wQeh4s=; b=DqzuV8AG7dO9w9MAwacR4w9wdw
        gx5wDH+PzdLaljX4RnLeYSiVWI0K8RFvD6URj0A3RPUCwrCQpQG6z7oZm2wKp2blrh6ITel7w4LBt
        zMiXXYVPj3lu3EBY11AYeFIQR0ohd/uoQfyF1LKU3KATqI//z6g3CuDUCbqqn3upiIghglciq50eP
        FDZN1md8SrLe/Ilwtu0PYhfE/Wr90vlFe47EFFRBX8od7SyJB1u+AD+dADQHDIkcz80TecaxxO3+5
        HhF19h33PaHv/oGQSrL13gHWlA5dcX6OyMB1EpTXMXrq6wOhxy2VWqr8gnHSWh337Wy2spEv5Hv7O
        rhsy5cbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pscXG-00CEol-1z;
        Sat, 29 Apr 2023 04:50:14 +0000
Date:   Fri, 28 Apr 2023 21:50:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm: Do not reclaim private data from pinned page
Message-ID: <ZEyiBphefPmgCE42@infradead.org>
References: <20230428124140.30166-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428124140.30166-1-jack@suse.cz>
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

On Fri, Apr 28, 2023 at 02:41:40PM +0200, Jan Kara wrote:
> If the page is pinned, there's no point in trying to reclaim it.
> Furthermore if the page is from the page cache we don't want to reclaim
> fs-private data from the page because the pinning process may be writing
> to the page at any time and reclaiming fs private info on a dirty page
> can upset the filesystem (see link below).

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
