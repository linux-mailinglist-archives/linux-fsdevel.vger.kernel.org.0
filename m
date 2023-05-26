Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819F17127D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjEZNyX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjEZNyW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 09:54:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43933DF;
        Fri, 26 May 2023 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MVg67d6tqd4lwkRaTe+6MM98KoWSEd2dKs7M6jq9Edk=; b=ojX1a7ro2uIIFc9IZPCrb7T1P/
        t98E3papAcFBLMw6gNNkOqjJbTbgzGnPaubXEi20RLHCoNArWLZ6Z01g9JQ+d1E1jT8D5Ty91i+fM
        NkL2Zdb7Ir4BiD4zZlwg3T0Fl2LjFrZz6TkWE0F8EkWR+1sOHib00qqhITphgLPVzDKqn8Q+SNutN
        C1yAvozRrYQNiQLmJ6pt+w0SJgjs0v7bImmpDUSwrqVFNY4aLYr7X7U6my8u8/k731yjsyJ2rf7is
        zTHjmuR0s9CdWwdc70Rl7VBuw3TtNHG/rT6e8LB9xjPBSCjPy0M2RUS2N2wYn4hWGUD4lT8HBUK4y
        BIIEXmmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2XtU-002pxk-64; Fri, 26 May 2023 13:54:12 +0000
Date:   Fri, 26 May 2023 14:54:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 0/8] add support for blocksize > PAGE_SIZE
Message-ID: <ZHC6BM+ehSC5Atv8@casper.infradead.org>
References: <20230526075552.363524-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526075552.363524-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 26, 2023 at 12:55:44AM -0700, Luis Chamberlain wrote:
> This is an initial attempt to add support for block size > PAGE_SIZE for tmpfs.
> Why would you want this? It helps us experiment with higher order folio uses
> with fs APIS and helps us test out corner cases which would likely need
> to be accounted for sooner or later if and when filesystems enable support
> for this. Better review early and burn early than continue on in the wrong
> direction so looking for early feedback.

I think this is entirely the wrong direction to go in.

You're coming at this from a block layer perspective, and we have two
ways of doing large block devices -- qemu nvme and brd.  tmpfs should
be like other filesystems and opportunistically use folios of whatever
size makes sense.

Don't add a mount option to specify what size folios to use.

