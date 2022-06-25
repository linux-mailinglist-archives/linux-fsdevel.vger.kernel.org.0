Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F080A55AA89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 15:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiFYNj5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 09:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiFYNj4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 09:39:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9B18B0B;
        Sat, 25 Jun 2022 06:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1b2WDsk+mj+vY991cx6kqmyfaX2i7Pf5yLchc29ZNU=; b=X+vTbl+/a5S7LX8PmZvmvhjxli
        Pgr6GAo47bhsiS0J24GJFSHAHrHVA6IV8qy0BANGpvR0fpjLSl/eFhOJzsuKonptYDtXe/eT1fDph
        VsX+ZeiJAinxP/L/wrXJ9r0oYLQw5M6oQGHVwplkaPYcOOgkmWQ3ICFRfgkebRQ7hIREvG83pEXky
        W2QqVxFMMshqOTr7r1bG3b237l9PQaLWQo3+jwinqG7hgJ+8syGLbQjyFW2OtsY3YVeLzwTgvh2eU
        o2T/9Tzb7KVoMWf08CKijw8pLb3tKUipl6Wzh9XyEYJhYr3itQuSNNkkApWnJSnzVS/q8B/wjQOZX
        TwCZ3rng==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o560u-006Ees-Fb; Sat, 25 Jun 2022 13:39:52 +0000
Date:   Sat, 25 Jun 2022 06:39:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] fs: clear or set FMODE_LSEEK based on llseek
 function
Message-ID: <YrcQKIruM3w2gGho@infradead.org>
References: <20220625110115.39956-1-Jason@zx2c4.com>
 <20220625110115.39956-4-Jason@zx2c4.com>
 <YrcIoaluGx+2TzfM@infradead.org>
 <YrcNpdJmyFU+Up1n@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrcNpdJmyFU+Up1n@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 25, 2022 at 02:29:09PM +0100, Al Viro wrote:
> I wouldn't bet on that - as it is, an ->open() instance can decide
> in some cases to clear FMODE_LSEEK, despite having file_operations
> with non-NULL ->llseek.

The interesting cases here are nonseekable_open and stream_open,
and I don't see why we could not fix this up in the file_operations.
