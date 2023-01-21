Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E1F676431
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 07:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjAUGjc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 01:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUGjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 01:39:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320333AB1;
        Fri, 20 Jan 2023 22:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pbB8338ZfSvN5avLy4jRRyLgTgoL9VF2bh4jfARYSoY=; b=F+LR1CwIsyVpngzUGE2qUMd1jN
        uj274WuuBiMxOEJ/sz8alo6NOXYTEmgDpxSqhy6+F8U/DLhKVoH7y5pF90W4oQaTeRBgyzwhm1gUu
        JnmVwS0bYrPR09cpQVViev3nCD9OzprTksNZzrocqDTt1IOw6xnyNOG2tmZY1aX4EtX/oTR2SN+eo
        /a5Y6I7VBXwxkAJLWa1m0egijIDvOY9XKuuY7Et6B3cmpF2fP+7ltQXRwbc4kPJixH1yjovqRuZsW
        oTQvvuzNpFPz1GGep/Up3cpy9UoShl8qOlObgbqAMRiP/K/vPnX48uKdKsWRYFxl+4DovjWbi8vmK
        pxe3gEqg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pJ7X9-00DQNk-ST; Sat, 21 Jan 2023 06:39:23 +0000
Date:   Fri, 20 Jan 2023 22:39:23 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-ext4@vger.kernel.org,
        Andrey Albershteyn <aalbersh@redhat.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 10/11] fs/buffer.c: support fsverity in
 block_read_full_folio()
Message-ID: <Y8uImwmmprNOCnB9@infradead.org>
References: <20221223203638.41293-1-ebiggers@kernel.org>
 <20221223203638.41293-11-ebiggers@kernel.org>
 <20230109183759.c1e469f5f2181e9988f10131@linux-foundation.org>
 <Y7zV41MQWSUGo4fw@sol.localdomain>
 <Y8rx/SPfnlYJJ8XD@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rx/SPfnlYJJ8XD@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:56:45AM -0800, Eric Biggers wrote:
> Any more thoughts on this from Andrew, the ext4 maintainers, or anyone else?

As someone else:  I relaly much prefer to support common functionality
(fsverity) in common helpers rather than copy and pasting them into
various file systems.  The copy common helper and slightly modify it
is a cancer infecting various file systems that makes it really hard
to maintain the kernel.
