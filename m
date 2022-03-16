Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4EA4DA7B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345217AbiCPCIk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiCPCIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:08:38 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C406C5E744
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:07:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V7JsqWV_1647396439;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7JsqWV_1647396439)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 16 Mar 2022 10:07:22 +0800
Date:   Wed, 16 Mar 2022 10:07:19 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
Subject: Re: [LSF/MM TOPIC] Better handling of negative dentries
Message-ID: <YjFGVxImP/nVyprQ@B-P7TQMD6M-0146.local>
Mail-Followup-To: Roman Gushchin <roman.gushchin@linux.dev>,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org,
        Gautham Ananthakrishna <gautham.ananthakrishna@oracle.com>,
        khlebnikov@yandex-team.ru
References: <YjDvRPuxPN0GsxLB@casper.infradead.org>
 <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A35C545C-1926-4AA9-BFC7-0CF11669EA9E@linux.dev>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:56:18PM -0700, Roman Gushchin wrote:
> 
> > On Mar 15, 2022, at 12:56 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > 
> > ﻿The number of negative dentries is effectively constrained only by memory
> > size.  Systems which do not experience significant memory pressure for
> > an extended period can build up millions of negative dentries which
> > clog the dcache.  That can have different symptoms, such as inotify
> > taking a long time [1], high memory usage [2] and even just poor lookup
> > performance [3].  We've also seen problems with cgroups being pinned
> > by negative dentries, though I think we now reparent those dentries to
> > their parent cgroup instead.
> 
> Yes, it should be fixed already.
> 
> > 
> > We don't have a really good solution yet, and maybe some focused
> > brainstorming on the problem would lead to something that actually works.
> 
> I’d be happy to join this discussion. And in my opinion it’s going beyond negative dentries: there are other types of objects which tend to grow beyond any reasonable limits if there is no memory pressure.

+1, we once had a similar issue as well, and agree that is not only
limited to negative dentries but all too many LRU-ed dentries and inodes.

Limited the total number may benefit to avoid shrink spiking for servers.

Thanks,
Gao Xiang

> A perfect example when it happens is when a machine is almost idle for some period of time. Periodically running processes creating various kernel objects (mostly vfs cache) which over time are filling significant portions of the total memory. And when the need for memory arises, we realize that the memory is heavily fragmented and it’s costly to reclaim it back.
> 
> Thanks!
