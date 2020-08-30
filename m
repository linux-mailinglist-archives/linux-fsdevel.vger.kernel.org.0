Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB573256FF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Aug 2020 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgH3TKa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Aug 2020 15:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgH3TKa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:10:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70909C061573
        for <linux-fsdevel@vger.kernel.org>; Sun, 30 Aug 2020 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J1cbLJ8F4WGYQkL5gnov6H5FbEcaOkn/XAlRvPP0Z7Q=; b=n3NzOi3PjZt2/X6wydSB721ero
        sWqXXAejB4W60L+Cs2/TWLtK2JXs7f2ktFuKbsCGLFN8/lDIv2ftG8V7UuauWv/Czl00KIP8WmSeq
        nSGryHdMDqoXXKRUqWJbulJwyObE0q1ku1VHCFjrNEE92d/uiYiCZWo9SZcdHIn1D8q1WJ47djwRW
        8WjkjgX7DHvNGhsXC38d4bNi1/ZkzgQkHlhhIlVGRn/IOXLXnXBR/UUI/xuyDyVdAAD1y21qL87lZ
        3xP3xc9SGt2LqnPSPaCB0x4ccCAFriOj1X7M8BHVhFU6XfcKPhbuZIkF+XmEba/tgiw+fO96F6SxC
        pWitJJig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCSiX-0000FI-1l; Sun, 30 Aug 2020 19:10:17 +0000
Date:   Sun, 30 Aug 2020 20:10:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200830191016.GZ14765@casper.infradead.org>
References: <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 30, 2020 at 09:05:40PM +0200, Miklos Szeredi wrote:
> Yes, open(..., O_ALT) would be special.  Let's call it open_alt(2) to
> avoid confusion with normal open on a normal filesystem.   No special
> casing anywhere at all.   It's a completely new interface that returns
> a file which either has ->read/write() or ->iterate() and which points
> to an inode with empty i_ops.

I think fiemap() should be allowed on a stream.  After all, these extents
do exist.  But I'm opposed to allowing getdents(); it'll only encourage
people to think they can have non-files as streams.
