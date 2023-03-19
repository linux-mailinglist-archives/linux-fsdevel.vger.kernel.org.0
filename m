Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D686BFF23
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Mar 2023 03:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjCSCvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Mar 2023 22:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCSCvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Mar 2023 22:51:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B9817176;
        Sat, 18 Mar 2023 19:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6cpyNU+RniP9ZGMmV+J7xJUGT6Ip5/sWZ1J+XMeD67c=; b=dz3i1li/xUe6gX2QgffRPlfRq3
        F6q0QczmjWehtRy8nyrto+L62Gk/smNYs7ZmRnDcvP3JxunsmPjfJ0hPV5+1MqeYfEFoehf6MEGlS
        xgxcoZLb7Kk+lnoYPnZkQGrPS4P6bgpN3VBVEAz4h7WeQASt9E4SCPhNqmNDzWICkggfZxaogmmBt
        elM6DNMBO1y6T3drlMzYPI/iulYANoGV6hFiCJiUXr2zSKfHol2vIX7Ib4YlC8A48scW9n3+VTPrm
        8ntnscGkcELcfoGTBaYFCMzWwOq1Q7PblihH0T7FXroT4AYGNEKzcCiA5GLPgsp2p3ZY4dOea6G0w
        3SyZAUog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pdj8K-00HLWg-I5; Sun, 19 Mar 2023 02:50:56 +0000
Date:   Sun, 19 Mar 2023 02:50:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] mm: vmalloc: convert vread() to vread_iter()
Message-ID: <ZBZ4kLnFz9MEiyhM@casper.infradead.org>
References: <cover.1679183626.git.lstoakes@gmail.com>
 <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119871ea9507eac7be5d91db38acdb03981e049e.1679183626.git.lstoakes@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 19, 2023 at 12:20:12AM +0000, Lorenzo Stoakes wrote:
>  /* for /proc/kcore */
> -extern long vread(char *buf, char *addr, unsigned long count);
> +extern long vread_iter(char *addr, size_t count, struct iov_iter *iter);

I don't love the order of the arguments here.  Usually we follow
memcpy() and have (dst, src, len).  This sometimes gets a bit more
complex when either src or dst need two arguments, but that's not the
case here.
