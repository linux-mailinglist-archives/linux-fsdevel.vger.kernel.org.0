Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AB6763762
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 15:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbjGZNV3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 09:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjGZNV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:21:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A8128;
        Wed, 26 Jul 2023 06:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wdNxBNc/XKt1rGWWjT+wp501Ad4YlgkNoKw2dn6/n+k=; b=CsUu6uylvMJsB7M0iog9hiilm+
        dVXG/HErZSBkZSiokdl6L9dvYeJ2DkORtQYLTXbpgVu/dmtaWOxbZqq7L50TEcvjzWupagZ9Blapj
        1MZEu5BgGIlBXQxWxH1TjEXx56NRWIlF5Q47s0Nj6z99Bn5EzR5z8wkNUe3Ey6zdJ6kCJ7hYx2+3f
        6E2OzpZEH2KKiSXuncppwMwsR6WnVotoLFvTniTcqI5ZWy8OY1k0FC6PtSUfxpWaq9iIwS3OgUXVv
        BPaYqjK+dEgezftX0XMEoIXRV6ANT2TO2Vlr+pXAMPwOc3/f24UxEbxGjqK0DQM3Q11jEH3WH1mrC
        M2Qa8MnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOeSB-00AWJw-2z;
        Wed, 26 Jul 2023 13:21:23 +0000
Date:   Wed, 26 Jul 2023 06:21:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/20] block: Bring back zero_fill_bio_iter
Message-ID: <ZMEd08XCNFE1SwoU@infradead.org>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
 <20230712211115.2174650-7-kent.overstreet@linux.dev>
 <ZL62cVmeI6t7o+G9@infradead.org>
 <20230725024553.bqwoyz4ywqx6fypb@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725024553.bqwoyz4ywqx6fypb@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:45:53PM -0400, Kent Overstreet wrote:
> And yet, we've had a subtle bug introduced in that code that took quite
> awhile to be fixed - I'm not pro code duplication in general and I don't
> think this is a good place to start.

I'm not sure arguing for adding a helper your can triviall implement
yourself really helps to streamline your upstreaming process.
