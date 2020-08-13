Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54915243D24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHMQUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMQUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:20:08 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4263C061757;
        Thu, 13 Aug 2020 09:20:07 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6FxS-00EzAD-Ij; Thu, 13 Aug 2020 16:20:02 +0000
Date:   Thu, 13 Aug 2020 17:20:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@fb.com,
        willy@infradead.org
Subject: Re: [PATCH][v2] proc: use vmalloc for our kernel buffer
Message-ID: <20200813162002.GX1236603@ZenIV.linux.org.uk>
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <20200813153356.857625-1-josef@toxicpanda.com>
 <20200813153722.GA13844@lst.de>
 <974e469e-e73d-6c3e-9167-fad003f1dfb9@toxicpanda.com>
 <20200813154117.GA14149@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813154117.GA14149@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:41:17PM +0200, Christoph Hellwig wrote:
> On Thu, Aug 13, 2020 at 11:40:00AM -0400, Josef Bacik wrote:
> > On 8/13/20 11:37 AM, Christoph Hellwig wrote:
> >> On Thu, Aug 13, 2020 at 11:33:56AM -0400, Josef Bacik wrote:
> >>> Since
> >>>
> >>>    sysctl: pass kernel pointers to ->proc_handler
> >>>
> >>> we have been pre-allocating a buffer to copy the data from the proc
> >>> handlers into, and then copying that to userspace.  The problem is this
> >>> just blind kmalloc()'s the buffer size passed in from the read, which in
> >>> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
> >>> awesome, and since we can potentially allocate up to our maximum order,
> >>> use vmalloc for these buffers.
> >>>
> >>> Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
> >>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >>> ---
> >>> v1->v2:
> >>> - Make vmemdup_user_nul actually do the right thing...sorry about that.
> >>>
> >>>   fs/proc/proc_sysctl.c  |  6 +++---
> >>>   include/linux/string.h |  1 +
> >>>   mm/util.c              | 27 +++++++++++++++++++++++++++
> >>>   3 files changed, 31 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> >>> index 6c1166ccdaea..207ac6e6e028 100644
> >>> --- a/fs/proc/proc_sysctl.c
> >>> +++ b/fs/proc/proc_sysctl.c
> >>> @@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
> >>>   		goto out;
> >>>     	if (write) {
> >>> -		kbuf = memdup_user_nul(ubuf, count);
> >>> +		kbuf = vmemdup_user_nul(ubuf, count);
> >>
> >> Given that this can also do a kmalloc and thus needs to be paired
> >> with kvfree shouldn't it be kvmemdup_user_nul?
> >>
> >
> > There's an existing vmemdup_user that does kvmalloc, so I followed the 
> > existing naming convention.  Do you want me to change them both?  Thanks,
> 
> I personally would, and given that it only has a few users it might
> even be feasible.

FWIW, how about following or combining that with "allocate count + 1 bytes on
the read side"?  Allows some nice cleanups - e.g.
                len = sprintf(tmpbuf, "0x%04x", *(unsigned int *) table->data);
                if (len > left)
                        len = left;
                memcpy(buffer, tmpbuf, len);
                if ((left -= len) > 0) {
                        *((char *)buffer + len) = '\n';
                        left--;
                }
in sunrpc proc_dodebug() turns into
		left -= snprintf(buffer, left, "0x%04x\n",
				 *(unsigned int *) table->data);
and that's not the only example.
