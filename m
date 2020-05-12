Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E211CEA84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 04:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgELCGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 22:06:54 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:48762 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgELCGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 22:06:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TyILjVR_1589249211;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TyILjVR_1589249211)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 May 2020 10:06:52 +0800
Date:   Tue, 12 May 2020 10:06:51 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH RFC] fuse: invalidate inode attr in writeback cache mode
Message-ID: <20200512020651.GX47669@e18g06458.et15sqa>
References: <1588778444-28375-1-git-send-email-eguan@linux.alibaba.com>
 <CAJfpegsivYq68FjSxAGnszcPJBrJrYG5Gojsc8T+PKup0Cm8fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsivYq68FjSxAGnszcPJBrJrYG5Gojsc8T+PKup0Cm8fw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 03:06:08PM +0200, Miklos Szeredi wrote:
> On Wed, May 6, 2020 at 5:21 PM Eryu Guan <eguan@linux.alibaba.com> wrote:
> >
> > Under writeback mode, inode->i_blocks is not updated, making utils like
> > du read st.blocks as 0.
> >
> > For example, when using virtiofs (cache=always & nondax mode) with
> > writeback_cache enabled, writing a new file and check its disk usage
> > with du, du reports 0 usage.
> 
> Hmm... invalidating the attribute might also yield the wrong result as
> the server may not have received the WRITE request that modifies the
> underlying file.

That's true, I open-write a file then sleep without closing it, and
check file's st_blocks in another terminal, the usage is 0, and remains
0 even after the file is closed, because the wrong attr is cached.

> 
> Invalidating attributes at the end of fuse_flush() definitely makes
> sense, though.

du also reports 0 if I didn't close the file, but I got correct
st_blocks when it's closed.

> 
> If we wanted 100% correct behavior, we'd need to flush WRITE requests
> before each GETATTR request.  That might be a performance bottleneck,
> though.
> 
> So first I'd just try doing the invalidation from fuse_flush().

Sure, will send v2 soon.

> 
> Thanks,
> Miklos

Thanks for the review!

Eryu
