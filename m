Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65C6CA1B71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 15:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfH2N3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 09:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfH2N3z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1F8F2309175F;
        Thu, 29 Aug 2019 13:29:55 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 812C7600C1;
        Thu, 29 Aug 2019 13:29:50 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 13DE22206F5; Thu, 29 Aug 2019 09:29:50 -0400 (EDT)
Date:   Thu, 29 Aug 2019 09:29:49 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual
 machines
Message-ID: <20190829132949.GA6744@redhat.com>
References: <20190821173742.24574-1-vgoyal@redhat.com>
 <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 29 Aug 2019 13:29:55 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 11:28:27AM +0200, Miklos Szeredi wrote:
> On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > Hi,
> >
> > Here are the V3 patches for virtio-fs filesystem. This time I have
> > broken the patch series in two parts. This is first part which does
> > not contain DAX support. Second patch series will contain the patches
> > for DAX support.
> >
> > I have also dropped RFC tag from first patch series as we believe its
> > in good enough shape that it should get a consideration for inclusion
> > upstream.
> 
> Pushed out to
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
> 

Hi Miklos,

Compilation of virtio-fs as module fails. While it works if compiled as
non-module.

fs/fuse/virtio_fs.c: In function ‘copy_args_to_argbuf’:
fs/fuse/virtio_fs.c:255:5: error: ‘struct fuse_req’ has no member named ‘argbuf’
  req->argbuf = kmalloc(len, GFP_ATOMIC);

It can't find req->argbuf. 

I noticed that you have put ifdef around argbuf.

#ifdef CONFIG_VIRTIO_FS
        /** virtio-fs's physically contiguous buffer for in and out args */
        void *argbuf;
#endif

It should have worked. Not sure why it is not working.

Vivek
