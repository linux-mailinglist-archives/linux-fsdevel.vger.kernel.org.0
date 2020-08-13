Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2D8243D2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 18:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMQVp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 12:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMQVp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:21:45 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD77FC061757;
        Thu, 13 Aug 2020 09:21:44 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6Fz3-00EzMC-U0; Thu, 13 Aug 2020 16:21:41 +0000
Date:   Thu, 13 Aug 2020 17:21:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Josef Bacik' <josef@toxicpanda.com>, "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] proc: use vmalloc for our kernel buffer
Message-ID: <20200813162141.GY1236603@ZenIV.linux.org.uk>
References: <20200813145305.805730-1-josef@toxicpanda.com>
 <714c8baabe1a4d0191f8cdaf6e28a32d@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714c8baabe1a4d0191f8cdaf6e28a32d@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 04:19:27PM +0000, David Laight wrote:
> From: Josef Bacik
> > Sent: 13 August 2020 15:53
> > 
> >   sysctl: pass kernel pointers to ->proc_handler
> > 
> > we have been pre-allocating a buffer to copy the data from the proc
> > handlers into, and then copying that to userspace.  The problem is this
> > just blind kmalloc()'s the buffer size passed in from the read, which in
> > the case of our 'cat' binary was 64kib.  Order-4 allocations are not
> > awesome, and since we can potentially allocate up to our maximum order,
> > use vmalloc for these buffers.
> 
> What happens if I run 'dd bs=16M ...' ?

Try it.
