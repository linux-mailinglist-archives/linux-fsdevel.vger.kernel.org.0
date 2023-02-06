Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E010868C2BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 17:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjBFQOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 11:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjBFQNl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:13:41 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E593DA;
        Mon,  6 Feb 2023 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=mIRcIoAifSJJXbfeWDyo12Lwpj4DPb3rPRwB4Mt45Bw=;
  b=p1TnNZO6FuaqpOo6Y7LKaCra3LvWpPF1pNjA1XbPb9EQJXOhnoQ4pNX1
   MoC4O6P0A3Yb7EbfK+PDX42b8aY5STlqyZSdwInjYLsNUwl2l+OsLySiv
   nx46CHb+eKJN2UmaJ68/CXcwuG807UrDdql5CYeEMz4nMG2XLIPINteGe
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,276,1669071600"; 
   d="scan'208";a="47004662"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 17:13:03 +0100
Date:   Mon, 6 Feb 2023 17:13:02 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dan Carpenter <error27@gmail.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
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
In-Reply-To: <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
Message-ID: <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn> <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com> <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 6 Feb 2023, Luis Chamberlain wrote:

> On Sat, Jan 28, 2023 at 11:33:08PM -0800, Linus Torvalds wrote:
> > On Sat, Jan 28, 2023 at 10:05 PM Hongchen Zhang
> > <zhanghongchen@loongson.cn> wrote:
> > >
> > > Use spinlock in pipe_{read,write} cost too much time,IMO
> > > pipe->{head,tail} can be protected by __pipe_{lock,unlock}.
> > > On the other hand, we can use __pipe_{lock,unlock} to protect
> > > the pipe->{head,tail} in pipe_resize_ring and
> > > post_one_notification.
> >
> > No, we really can't.
> >
> > post_one_notification() is called under the RCU lock held, *and* with
> > a spinlock held.
> >
> > It simply cannot do a sleeping lock like __pipe_lock().
> >
> > So that patch is simply fundamentally buggy, I'm afraid.
>
> This patch lingered for a while until *way* later *Al Viro* and then
> Linus chimed in on this. Ie, the issue for rejecting the patch wasn't so
> obvious it seems.
>
> As for Linus' point about us needing to avoid sleep under RCU +
> spinlock, curious if we can capture *existing* bad users of that with
> Coccinelle SmPL.

An analysis with Coccinelle may be highly prone to false positives if the
issue is very interprocedural.  Maybe smatch would be better suited for
this?

julia
