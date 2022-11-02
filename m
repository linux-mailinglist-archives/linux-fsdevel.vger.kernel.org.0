Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89538615CD7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 08:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKBHRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKBHRr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:17:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BEFB4A4;
        Wed,  2 Nov 2022 00:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YFi1do1PLyjdKzO28E7aCSxbIE8rZL5lF1FUwuF7FGQ=; b=CIpv299ODseOSDZAZiklOJ7/OM
        G0rd96+QVCSFg0cBgdSgugwBJOvKAPzV4ytkKygQUNT1gwTudIJmFMhqOW9F3VsKy6P1rPkYWtUb9
        ywvLnnBLaTJ1FKOgucOvDKwLc/vu2butDRBrU5zYD5WVJUrWgtPA8BzBN/qiqG3y3KENJpR6uKwpG
        62NrZx+QQ1kUyfJiOKgY0DA8RokXxJcr3rFRUnmzfPd1CwwII46d5pXXb+YB3ALwLN3rP9vJDSbm8
        wXpLo+efrNd5lxBfGYoXz0wX5rXnCdsfCtrDgAsvrCFRh7tADPnGuSd/oIkT94zvi5655uqwlsF3W
        cXqCI+Gw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oq80P-008bVC-Vc; Wed, 02 Nov 2022 07:17:45 +0000
Date:   Wed, 2 Nov 2022 00:17:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] xfs: write page faults in iomap are not buffered
 writes
Message-ID: <Y2IZmaV/dNcaolTI@infradead.org>
References: <20221101003412.3842572-1-david@fromorbit.com>
 <20221101003412.3842572-2-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101003412.3842572-2-david@fromorbit.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The analsysi and fix look correct, but I wonder if it wouldn't be better
if we don't expand the number of iomap ops even further and just check
for IOMAP_FAULT to not be set in flags in xfs_buffered_write_iomap_end.

Either way:

Reviewed-by: Christoph Hellwig <hch@lst.de>
