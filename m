Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9DA1CC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfH2ObR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 10:31:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfH2ObR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:31:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36B1E2A09CD;
        Thu, 29 Aug 2019 14:31:17 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572151001B2A;
        Thu, 29 Aug 2019 14:31:08 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D65632206F5; Thu, 29 Aug 2019 10:31:07 -0400 (EDT)
Date:   Thu, 29 Aug 2019 10:31:07 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190829143107.GB6744@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
 <20190829132949.GA6744@redhat.com>
 <CAJfpegtd-MQNbUW9YuL4xdXDkGR8K6LMHCqDG2Ppu9F_Hyk2RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtd-MQNbUW9YuL4xdXDkGR8K6LMHCqDG2Ppu9F_Hyk2RQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 29 Aug 2019 14:31:17 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:41:26PM +0200, Miklos Szeredi wrote:
> On Thu, Aug 29, 2019 at 3:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > #ifdef CONFIG_VIRTIO_FS
> >         /** virtio-fs's physically contiguous buffer for in and out args */
> >         void *argbuf;
> > #endif
> >
> > It should have worked. Not sure why it is not working.
> 
> Needs to be changed to
> 
> #if IS_ENABLED(CONFIG_VIRTIO_FS)
> 
> Pushed out fixed version.

Cool. That works. Faced another compilation error with "make allmodconfig"
config file.

  HDRINST usr/include/linux/virtio_fs.h
error: include/uapi/linux/virtio_fs.h: missing "WITH Linux-syscall-note" for SPDX-License-Identifier
make[1]: *** [scripts/Makefile.headersinst:66: usr/include/linux/virtio_fs.h] Error 1

Looks like include/uapi/linux/virtio_fs.h needs following.

-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */

Vivek
