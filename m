Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AE5226BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 00:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiEJWSP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 18:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiEJWSN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 18:18:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6654362A33;
        Tue, 10 May 2022 15:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55C86617F3;
        Tue, 10 May 2022 22:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74233C385CF;
        Tue, 10 May 2022 22:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652221090;
        bh=5yEe4D44yUcfWHEZ8mIUjXGZ6LTehhn7/6meohWTYp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rm8JynhWQdxAmeoI0WkmtXG1QNxG4cuL2/vIn+x1LxmBF3ufyf0LFXFOWBRI9L3uO
         rnyUOj4dhix0PZd9dbGOBOBhAD9Bc3qRd3qdHsj52ReSlpMMYI2nPXGkotEPgSB+pD
         MSAT3KDZfF5uisxgWY5s1VMErPW9oDmGBQ5A0hWM=
Date:   Tue, 10 May 2022 15:18:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Two folio fixes for 5.18
Message-Id: <20220510151809.f06c7580af34221c16003264@linux-foundation.org>
In-Reply-To: <YnRhFrLuRM5SY+hq@casper.infradead.org>
References: <YnRhFrLuRM5SY+hq@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 May 2022 00:43:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:

>  - Fix readahead creating single-page folios instead of the intended
>    large folios when doing reads that are not a power of two in size.

I worry about the idea of using hugepages in readahead.  We're
increasing the load on the hugepage allocator, which is already
groaning under the load.

The obvious risk is that handing out hugepages to a low-value consumer
(copying around pagecache which is only ever accessed via the direct
map) will deny their availability to high-value consumers (that
compute-intensive task against a large dataset).

Has testing and instrumentation been used to demonstrate that this is
not actually going to be a problem, or are we at risk of getting
unhappy reports?

