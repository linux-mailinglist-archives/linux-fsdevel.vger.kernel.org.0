Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8373F2FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 05:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjF0Dqx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 23:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjF0DqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:46:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2891BE8;
        Mon, 26 Jun 2023 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BCU0vSxqLVTX419lXjVkZjx3a/Yiyook2insNB/VnXc=; b=o9AnIofC0gBmiKHyrKuNgwEnMg
        SNFY+wOoS2vtORD/zJeXRDNASshBfameF6PetykSZmQjyguK2qtVWWsgCvk3PLezL/3kB9Ewzxhk1
        u8C4FhdRNKJcVoLgLb9q/HDGmCeY37q63vntZR9mKcY7VRGtgwMfJlwLTo8cZg8xcj1MX7LtQuKfA
        OhRmYupYudQrcZsAnJJ7RBJGVgAZSZGAYMSDVBKi1ZCxO1DoVNO+yspmGmsWwwtl1oKjqKcnf6+Y/
        Xj1hybHHrm/hZdHycBQjcBlJb+I5KHI5bXGxhc5udx2v6S5Wfu+lyb6oMhx34SoEi/44TIQ9B+FcS
        3t+C9hjA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qDzdp-00BciT-0q;
        Tue, 27 Jun 2023 03:45:21 +0000
Date:   Mon, 26 Jun 2023 20:45:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        gost.dev@samsung.com, Andreas Hindborg <a.hindborg@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Message-ID: <ZJpbUShJUL788r7u@infradead.org>
References: <20230626164752.1098394-1-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626164752.1098394-1-nmi@metaspace.dk>
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

On Mon, Jun 26, 2023 at 06:47:52PM +0200, Andreas Hindborg wrote:
> From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
> 
> Zonefs will try to use `zonefs_file_dio_append()` for direct sync writes even if
> device `max_zone_append_sectors` is zero. This will cause the IO to fail as the
> io vector is truncated to zero. It also causes a call to
> `invalidate_inode_pages2_range()` with end set to UINT_MAX, which is probably
> not intentional. Thus, do not use append when device does not support it.

How do you even manage to hit this code?  Zone Append is a mandatory
feature and driver need to check it is available.
