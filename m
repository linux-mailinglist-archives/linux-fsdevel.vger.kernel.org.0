Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C49968C25F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 16:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjBFP6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 10:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjBFP6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:58:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D46FF30;
        Mon,  6 Feb 2023 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8TDVZdwYrPcfERoqHXV0QZVvG/JjJWa414sKcZkelV8=; b=IdOrbjEM5xSxN4+Y5tdroDgmmo
        e3uWtySHbs+x1XrwoxPAjx4jtCiQsb7beTiYOl3ioTWM9oii8swJmu95NFOINKRm41vF5NzPKIj91
        IR7xGdzBvux7W7Fi1rMDC/Va6QdlqBHhiDNqQi9eIVAGXebfqlGIdRtm1SLjaidY+X3/rnEB/DFc+
        1GcFwNU5M1Y3wKD43tdOhXQs48kZFVfDm0IKcnOAnWhi1ToqiPQAjS8SKMJZCo5jzoeE6otpOo3ph
        rZFuFrHXlqk4+fdRHY7WIQc7ozX1rPxs7LT8QTpCjqd6ASjTmtATnv36q7lFkEvKuEDPf7vCNemZd
        dOUlvUXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pP3so-0097jS-EA; Mon, 06 Feb 2023 15:58:18 +0000
Date:   Mon, 6 Feb 2023 07:58:18 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH v4] pipe: use __pipe_{lock,unlock} instead of spinlock
Message-ID: <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:33:08PM -0800, Linus Torvalds wrote:
> On Sat, Jan 28, 2023 at 10:05 PM Hongchen Zhang
> <zhanghongchen@loongson.cn> wrote:
> >
> > Use spinlock in pipe_{read,write} cost too much time,IMO
> > pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> > On the other hand, we can use __pipe_{lock,unlock} to protect
> > the pipe->{head,tail} in pipe_resize_ring and
> > post_one_notification.
> 
> No, we really can't.
> 
> post_one_notification() is called under the RCU lock held, *and* with
> a spinlock held.
> 
> It simply cannot do a sleeping lock like __pipe_lock().
> 
> So that patch is simply fundamentally buggy, I'm afraid.

This patch lingered for a while until *way* later *Al Viro* and then
Linus chimed in on this. Ie, the issue for rejecting the patch wasn't so
obvious it seems.

As for Linus' point about us needing to avoid sleep under RCU +
spinlock, curious if we can capture *existing* bad users of that with
Coccinelle SmPL.

  Luis
