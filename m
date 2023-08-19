Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E93781745
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Aug 2023 05:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjHSDxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 23:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjHSDx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:53:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A74421B;
        Fri, 18 Aug 2023 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k+uWMHcD/UtEix/sGulCtsST6BuPB2WW6e/wqc+BshQ=; b=igEYJf8E84W5MJE8NgKQFUPp6v
        nvYWlL+4yQcdlQqWFSZ8+6jxn5lgE3AZl2+aGMAJeyXvDHDM7B3GCLGr0skKFpDyinXxOaIEnqUNO
        IcBx92z8rfILaHeupgs/Y7pxsEL/EOS5ROXOiAg3pd20ILhc9SLHTqC1V46gmvawPdc/iPd27pU1M
        1JRLHpegQKbqu+xNCHh+ChVHahQAt6qCmCyecs8cjeRshBfj5zqPBtgiFUWozxHqxP0vENyG3Glc9
        Lcp//6scRBQenT2XPBr9NDVga81mL8pQSHlOgDKB9y7a/pzjW8te6O0yzemwjQTQjHYFFqGj1CI0m
        nqg5ERaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXD1L-00DQDv-LS; Sat, 19 Aug 2023 03:53:03 +0000
Date:   Sat, 19 Aug 2023 04:53:03 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hongchen Zhang <zhanghongchen@loongson.cn>
Cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Jens Axboe <axboe@kernel.dk>, David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v5 2/2] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <ZOA8n/uPrkAKg86b@casper.infradead.org>
References: <20230811010309.20196-2-zhanghongchen@loongson.cn>
 <20230811010309.20196-1-zhanghongchen@loongson.cn>
 <3955287.1692002820@warthog.procyon.org.uk>
 <b6f395a6-ca81-f107-0a3f-59e8f8d41f9d@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f395a6-ca81-f107-0a3f-59e8f8d41f9d@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 19, 2023 at 11:28:58AM +0800, Hongchen Zhang wrote:
> Hi David,
> 
> On 2023/8/14 pm 4:47, David Howells wrote:
> > Hongchen Zhang <zhanghongchen@loongson.cn> wrote:
> > 
> > > -	spin_lock_irq(&pipe->rd_wait.lock);
> > > +	__pipe_lock(pipe);
> > 
> I changed the code and the post_one_notification is not called inside spin
> lock ,please check this patch again.

In remove_watch_from_object(), you moved post_one_notification() before
lock_queue(), but it's still called inside a RCU read-side critical
section, which cannot sleep.

Please test with CONFIG_DEBUG_ATOMIC_SLEEP before you send a new version.
You should probably turn on DEBUG_SPINLOCK, LOCKDEP, DEBUG_MUTEXES
and a few other debug options.
