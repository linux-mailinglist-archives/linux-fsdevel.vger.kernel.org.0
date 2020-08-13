Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE679243A6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 15:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgHMNAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 09:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMNAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:00:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD72CC061757;
        Thu, 13 Aug 2020 06:00:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Cqa-00Eqiw-Mc; Thu, 13 Aug 2020 13:00:44 +0000
Date:   Thu, 13 Aug 2020 14:00:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select.c: batch user writes in do_sys_poll
Message-ID: <20200813130044.GW1236603@ZenIV.linux.org.uk>
References: <20200813071120.2113039-1-dja@axtens.net>
 <20200813073220.GB15436@infradead.org>
 <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
 <87wo22n5ez.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo22n5ez.fsf@dja-thinkpad.axtens.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 09:36:52PM +1000, Daniel Axtens wrote:
> Hi,
> 
> >> Seem like this could simply use a copy_to_user to further simplify
> >> things?
> >
> > I'll benchmark it and find out.
> 
> I tried this:
> 
>         for (walk = head; walk; walk = walk->next) {
> -               struct pollfd *fds = walk->entries;
> -               int j;
> -
> -               for (j = 0; j < walk->len; j++, ufds++)
> -                       if (__put_user(fds[j].revents, &ufds->revents))
> -                               goto out_fds;
> +               if (copy_to_user(ufds, walk->entries,
> +                                sizeof(struct pollfd) * walk->len))
> +                       goto out_fds;
> +               ufds += walk->len;
>         }
> 
> With that approach, the poll2 microbenchmark (which polls 128 fds) is
> about as fast as v1.
> 
> However, the poll1 microbenchmark, which polls just 1 fd, regresses a
> touch (<1% - ~2%) compared to the current code, although it's largely
> within the noise. Thoughts?

I'd go with copy_to_user() here; post such variant and I'll throw it into
-next after -rc1.
