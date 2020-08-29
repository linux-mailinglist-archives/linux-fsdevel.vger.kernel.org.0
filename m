Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF802568FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgH2QOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgH2QOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 12:14:11 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DFEC061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 09:14:11 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC3UM-007535-QF; Sat, 29 Aug 2020 16:13:58 +0000
Date:   Sat, 29 Aug 2020 17:13:58 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829161358.GP1236603@ZenIV.linux.org.uk>
References: <20200728105503.GE2699@work-vm>
 <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829160717.GS14765@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 05:07:17PM +0100, Matthew Wilcox wrote:

> I agree with you that supporting named streams within a file requires
> an independent inode for each stream.  I disagree with you that this is
> dentry cache infrastructure.  I do not believe in giving each stream
> its own dentry.  Either they share the default stream's dentry, or they
> have no dentry (mild preference for no dentry).

*blink*

Just how would they have different inodes while sharing a dentry?

> > The fact that ADS inodes would not be in the dentry cache and hence
> > not visible to pathwalks at all then means that all of the issues
> > such as mounting over them, chroot, etc don't exist in the first
> > place...
> 
> Wait, you've now switched from "this is dentry cache infrastructure"
> to "it should not be in the dentry cache".  So I don't understand what
> you're arguing for.

Bloody wonderful, that.  So now we have struct file instances with no dentry
associated with them?  Which would have to be taken into account all over
the place...
