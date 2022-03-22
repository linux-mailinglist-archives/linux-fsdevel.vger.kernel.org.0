Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC74E47AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiCVUnb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 16:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiCVUna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:43:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A277522F
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=VVdPJvP8CTmA6uCU7BHeBGm/i6I2iUb5gLPuoYQG+lU=; b=jn9DyNFw2YYcG+K2n52e1ftzfB
        fbXds5OckFD4M8BO1yK6inWZnpMCk3ZQ7AzjiAhouiyhLLugNcTonjBW5hWcyzm9ZFzmj971KJkwT
        opZEm0E47Jaj5+/pg/8E+GerszS5qcKxRDfeLqaOi/G6EJ6wRRCFRdrK3kc9JUUCS8nALLJt05XyW
        fWYc0MI1ddjul0zVTG6Nc8b6lzSFv5uv/6ApaHx5fa3C+W5RQQZFzZQESqd0DAeJgYLfWg6jgu8Nd
        T/7Fdkf+OP7V0ByephrSDyla5EKywI2dVbET7XHisXz3at7yiTqB7/2fM5Q0RtBmktYY44OfdXw+N
        +r5cVMeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWlKG-00BvCw-47; Tue, 22 Mar 2022 20:41:56 +0000
Date:   Tue, 22 Mar 2022 20:41:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <Yjo0lA3DiX1fFTue@casper.infradead.org>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> I’d be happy to join this discussion. And in my opinion it’s going
> beyond negative dentries: there are other types of objects which tend
> to grow beyond any reasonable limits if there is no memory pressure.
>
> A perfect example when it happens is when a machine is almost idle
> for some period of time. Periodically running processes creating
> various kernel objects (mostly vfs cache) which over time are filling
> significant portions of the total memory. And when the need for memory
> arises, we realize that the memory is heavily fragmented and it’s
> costly to reclaim it back.

When you say "vfs cache", do you mean page cache, inode cache, or
something else?
