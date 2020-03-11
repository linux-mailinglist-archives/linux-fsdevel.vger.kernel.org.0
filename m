Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D084C180F0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 05:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgCKE6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 00:58:39 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38840 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbgCKE6j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:58:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=bo.liu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TsGfZAt_1583902699;
Received: from rsjd01523.et2sqa(mailfrom:bo.liu@linux.alibaba.com fp:SMTPD_---0TsGfZAt_1583902699)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Mar 2020 12:58:24 +0800
Date:   Wed, 11 Mar 2020 12:58:19 +0800
From:   Liu Bo <bo.liu@linux.alibaba.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, virtio-fs@redhat.com
Subject: Re: [PATCH] fuse: make written data persistent after writing
Message-ID: <20200311045812.3p57mi23huazlvsx@rsjd01523.et2sqa>
Reply-To: bo.liu@linux.alibaba.com
References: <1583270111-76859-1-git-send-email-bo.liu@linux.alibaba.com>
 <CAJfpegtFWqEAV-Jb_KoHihJ5-UpU=JkdxEg_stz6JM5OP_LXMQ@mail.gmail.com>
 <20200310184640.5djxclzt6gqkq4v3@rsjd01523.et2sqa>
 <CAJfpegtUkfwZXZ977HeC7pJ+2rFVwyr0pk-ru4J7z1-TVafcSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtUkfwZXZ977HeC7pJ+2rFVwyr0pk-ru4J7z1-TVafcSQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:08:49PM +0100, Miklos Szeredi wrote:
> On Tue, Mar 10, 2020 at 7:46 PM Liu Bo <bo.liu@linux.alibaba.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 11:14:17AM +0100, Miklos Szeredi wrote:
> > > On Tue, Mar 3, 2020 at 10:15 PM Liu Bo <bo.liu@linux.alibaba.com> wrote:
> > > >
> > > > If this is a DSYNC write, make sure we push it to stable storage now
> > > > that we've written data.
> > >
> > > If this is direct I/O then why do we need an fysnc() call?
> > >
> > > The only thing needed should be correct setting O_DSYNC in the flags
> > > field of the WRITE request, and it appears to me that that is already
> > > being done.
> >
> > Given direct IO itself doesn't guarantee FUA or FLUSH, I think we
> > still need such a fsync() call to make sure a FUA/FLUSH is sent after
> > direct IO.
> 
> What I mean is that the server itself can call fsync(2) from the WRITE
> request if it finds that fi->flags contains O_DSYNC.

Right, I missed that with no_open FUSE_DIRECT_IO is not possible,
thanks for clarifying it.

thanks,
-liubo
