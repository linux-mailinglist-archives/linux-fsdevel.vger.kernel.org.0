Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A944073F3B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjF0Esp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjF0EsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:48:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4ADB19A4;
        Mon, 26 Jun 2023 21:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7RyDwXMhAhhZiR97FwkWYgIuZXpYVNBH8EOHVFeUoOM=; b=TpNqp6rQFZJQTFxyMLakBYTw3q
        5VCFj31gSlpJzsafS6frTiCBqyW2UEsFcGyr/Npdh/5Qsa42+TdlDJnzwPC4uCsDshfvew+/Xr+q7
        pq2/ZiuceRWlCvKbNXPNv2vjx1XUsnbnxmJ2CJ6ZtJiywwTbS7nWCpwjLXIXBQn82fHlndd/BkDUG
        lanCyhoh3R3GjfzJrxw3k94BND8T9Po1BDli5uKuBB9MteRJLQKen26LhCmB/Pu1FbMUzfRCWOddd
        NuIxsKXaDjoMaZg8QWWW/qRlBRhCFaXr1uCtj91vwCWKS+4bPeIjI0XQTO5L51TrXH8Y1MeuNfVyY
        a5AcKphg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qE0cZ-00Bklk-34;
        Tue, 27 Jun 2023 04:48:07 +0000
Date:   Mon, 26 Jun 2023 21:48:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Hindborg <nmi@metaspace.dk>,
        "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        gost.dev@samsung.com, Andreas Hindborg <a.hindborg@samsung.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Message-ID: <ZJpqBwzVu+h9g0VV@infradead.org>
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <ZJpbUShJUL788r7u@infradead.org>
 <31ceba83-9d06-8fc6-4688-d568a698a4cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31ceba83-9d06-8fc6-4688-d568a698a4cc@kernel.org>
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

On Tue, Jun 27, 2023 at 01:45:38PM +0900, Damien Le Moal wrote:
> But thinking of it, we probably would be better off having a generic check for
> "q->limits.max_zone_append_sectors != 0" in blk_revalidate_disk_zones().

Agreed.
