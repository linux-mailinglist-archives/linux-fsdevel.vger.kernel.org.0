Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA323359B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgG3Pey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3Pex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:34:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D164C061574;
        Thu, 30 Jul 2020 08:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VBPWwrsXMPKnDitP89rUNPyQKT9bsGFBjZQdtzzU7ds=; b=dCzn/wkP++dkRu1oDJt9RGaBFz
        K2yUeZF7hHvMOL2NmgXDAC5Z4QNx8FMnirqGBK+cSaN/08vTSc9ttNWOCGRYDQyNvT9Ez//mrHUnt
        n0eUNrEFNhpwEIb5zx6moVr+SseapOElItdDhZy5VeFs8+NeRxLvC53Bugwg+M10AxEdv9YTV6tc6
        0oa6hy8yD+sLiFfg484wsbw6RQbkY2AFSGHwMz8757ejFlLk0zDqtX9+6o8MNNhFPJKQpvOkTFAMi
        YyvPWknL1/EsDgV5cQaPJ0mtm/1cVNunmLlH8j3dnt9H+/6ynBG4D8QMl4l0ZfckxU+qysqDoBqka
        jA9bb4VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1Aa2-0006vP-4Q; Thu, 30 Jul 2020 15:34:50 +0000
Date:   Thu, 30 Jul 2020 16:34:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        gerg@linux-m68k.org, ktkhai@virtuozzo.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200730153450.GH23808@casper.infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <20200730152250.GG23808@casper.infradead.org>
 <20200730152705.ol42jppnl4xfhl32@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730152705.ol42jppnl4xfhl32@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:27:05PM +0200, Christian Brauner wrote:
> On Thu, Jul 30, 2020 at 04:22:50PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 27, 2020 at 10:11:22AM -0700, Anthony Yznaga wrote:
> > > This patchset adds support for preserving an anonymous memory range across
> > > exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> > > sharing memory in this manner, as opposed to re-attaching to a named shared
> > > memory segment, is to ensure it is mapped at the same virtual address in
> > > the new process as it was in the old one.  An intended use for this is to
> > > preserve guest memory for guests using vfio while qemu exec's an updated
> > > version of itself.  By ensuring the memory is preserved at a fixed address,
> > > vfio mappings and their associated kernel data structures can remain valid.
> > > In addition, for the qemu use case, qemu instances that back guest RAM with
> > > anonymous memory can be updated.
> > 
> > I just realised that something else I'm working on might be a suitable
> > alternative to this.  Apologies for not realising it sooner.
> > 
> > http://www.wil.cx/~willy/linux/sileby.html
> 
> Just skimming: make it O_CLOEXEC by default. ;)

I appreciate the suggestion, and it makes sense for many 'return an fd'
interfaces, but the point of mshare() is to, well, share.  So sharing
the fd with a child is a common usecase, unlike say sharing a timerfd.
The only other reason to use mshare() is to pass the fd over a unix
socket to a non-child, and I submit that is far less common than wanting
to share with a child.

