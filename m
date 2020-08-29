Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC72569D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 21:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgH2TSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 15:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgH2TR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:17:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D5C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 12:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zzMteWS2vCKWYeDlaBKzqPMbcjWrLZZFWIm5SUXnQRQ=; b=QFW9qxRHKeny5cG7Y+/XaxbDo1
        DIkfxO3IIWlt8IozZ5MSYXd6o8oOJG++VBwXmfxH9gnwKNfU4zzEF8aBt3Du5ePW/oUEtj/T7Y0yn
        gPDCL1cKPnrei8e2SGMLUu+hxPsa7j2eOrjSKzyQZ0S3p18llPiN1e9luZfyYoOtlMmZgSHemiN45
        ex07PyZtnNcfBMvxbuZYUa4AuCpMcu6FjE2BDkkrkprIMtG2akWZV+AjUG6nXfV3maWRJDf0ZgbCN
        Tn1Zp7K9H6Nsl1iKrxMK9suQvviBSazrlJMcRHEn1O+WpTxArwEJkRZmgkYZkB7cSYT4zj9VVivAd
        3TzayUBg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC6MJ-00011v-CJ; Sat, 29 Aug 2020 19:17:51 +0000
Date:   Sat, 29 Aug 2020 20:17:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829191751.GT14765@casper.infradead.org>
References: <12480108.dgM6XvcGr8@silver>
 <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829161358.GP1236603@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 05:13:58PM +0100, Al Viro wrote:
> On Sat, Aug 29, 2020 at 05:07:17PM +0100, Matthew Wilcox wrote:
> 
> > I agree with you that supporting named streams within a file requires
> > an independent inode for each stream.  I disagree with you that this is
> > dentry cache infrastructure.  I do not believe in giving each stream
> > its own dentry.  Either they share the default stream's dentry, or they
> > have no dentry (mild preference for no dentry).
> 
> *blink*
> 
> Just how would they have different inodes while sharing a dentry?
> 
> > > The fact that ADS inodes would not be in the dentry cache and hence
> > > not visible to pathwalks at all then means that all of the issues
> > > such as mounting over them, chroot, etc don't exist in the first
> > > place...
> > 
> > Wait, you've now switched from "this is dentry cache infrastructure"
> > to "it should not be in the dentry cache".  So I don't understand what
> > you're arguing for.
> 
> Bloody wonderful, that.  So now we have struct file instances with no dentry
> associated with them?  Which would have to be taken into account all over
> the place...

I probably have the wrong nomenclature for what I'm proposing.

So here's a concrete API.  What questions need to be answered?

fd = open("real", O_RDWR);

// fetch stream names
sfd = open_stream(fd, NULL);
read(sfd, names, length);
close(sfd);

// open the first one
sfd = open_stream(fd, names);
read(sfd, buffer, buflen);
close(sfd);

// create a new anonymous stream
sfd = open_stream(fd, "");
write(sfd, buffer, buflen);
// name it
linkat(sfd, NULL, fd, "newstream", AT_EMPTY_PATH);
close(sfd);

 - Stream names are NUL terminated and may contain any other character.
   If you want to put a '/' in a stream name, that's fine, but there's
   no hierarchy.  Ditto "//../././../../..//./."  It's just a really
   oddly named stream.
 - linkat() will fail if 'fd' does not match where 'sfd' was created.
 - open_stream() always creates a new stream when a zero-length string is
   specified.
 - open_stream() returns ENOENT if there is no stream by that name (ie the
   only way to create a stream is to specify no name, and then name
   it later).
 - sfd inherits the appropriate O_ flags from fd (O_RDWR, O_CLOEXEC, ...)
 - open_stream(sfd) is ENOTTY.

