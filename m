Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBD66C585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbjAPQHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 11:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjAPQGV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:06:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600925E17;
        Mon, 16 Jan 2023 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MzbI4mK0CdoF3B/H//+HN9YCPUxyR571ZP+T0wNHvZ0=; b=QJSFklNnf+i6dh9mOZ+zKH9pic
        sRJWL91C9t4/H3Rcx3RdAEDawNh698CoHXxLq8pPk5Pm+wgSEf1IqhFOV1Lxp5QLckQeGnMVaIxIl
        MAqslVYsYz2HeCHFV/IDJ/hUybuiDA6r6S8qbLii4deV8OcSm8+GaJj3p2WXZx8XAZeSfBBK84537
        mFobmy17auOErrY1837R+bqLE0y2IiDXt2BCB3R8luJeWdC9LjvR7nedzoRNY51UsSv7hF7bebDIa
        PIqfAjcVSdqg6K030sWyMpRO+Zo54tCBW+FmxBnH9piSMattV7taZS8VH7CDCdlIQah1qQT56a/sq
        bK53n4gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHRyZ-00BCBj-Tb; Mon, 16 Jan 2023 16:04:47 +0000
Date:   Mon, 16 Jan 2023 08:04:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Is there a reason why REQ_OP_READ has to be 0?
Message-ID: <Y8V1n4e/eeOd4n8/@infradead.org>
References: <2117829.1673884910@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2117829.1673884910@warthog.procyon.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 16, 2023 at 04:01:50PM +0000, David Howells wrote:
> Hi Jens, Christoph,
> 
> Do you know if there's a reason why REQ_OP_READ has to be 0?  I'm seeing a
> circumstance where a direct I/O write on a blockdev is BUG'ing in my modified
> iov_iter code because the iterator says it's a source iterator (correct), but
> the bio->bi_opf == REQ_OP_READ (which should be wrong).
> 
> I thought I'd move REQ_OP_READ to, say, 4 so that I could try and see if it's
> just undefined but the kernel BUGs and then panics during boot.

There's all kind of assumptions of that from basically day 1 of
Linux.  The most obvious one is in op_is_write, but I'm pretty sure
there are more hidden somewhere.
