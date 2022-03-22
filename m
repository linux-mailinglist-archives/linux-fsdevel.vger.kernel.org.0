Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE054E4834
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 22:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiCVVVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiCVVVG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:21:06 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5624C408
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 14:19:37 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:19:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1647983975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct1qkG3oA9UXq9tUwps5cBOhl3oYHIrsaiukDvIwNww=;
        b=w0PqXY4txgZKxN1SR/k6QcRAIYqxYIR+MXvlpJf3ySME0k6qQSiGbqsAXbEHOcIvt2hRPi
        8/Mi7Gto52Alz7+dVOKOI77KAgHpFKIohM9VTZ+iyA/Kyel0NkUGuBCme1KbOn0aILqd4I
        /vOR4o7Oz054xOXbRpuFlbwcELMzU7I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <Yjo9YrxU5SpydQKy@carbon.dhcp.thefacebook.com>
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
 <Yjo0lA3DiX1fFTue@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yjo0lA3DiX1fFTue@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 08:41:56PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> > I’d be happy to join this discussion. And in my opinion it’s going
> > beyond negative dentries: there are other types of objects which tend
> > to grow beyond any reasonable limits if there is no memory pressure.
> >
> > A perfect example when it happens is when a machine is almost idle
> > for some period of time. Periodically running processes creating
> > various kernel objects (mostly vfs cache) which over time are filling
> > significant portions of the total memory. And when the need for memory
> > arises, we realize that the memory is heavily fragmented and it’s
> > costly to reclaim it back.
> 
> When you say "vfs cache", do you mean page cache, inode cache, or
> something else?

Mostly inodes and dentries, but also in theory some fs-specific objects
(e.g. xfs implements nr_cached_objects/free_cached_objects callbacks).

Also dentries, for example, can have attached kmalloc'ed areas if the
length of the file's name is larger than x. And probably there are more
examples of indirectly pinned objects.
