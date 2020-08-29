Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCE2569E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 21:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgH2Tk6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgH2Tk6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:40:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72766C061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 12:40:57 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC6iQ-0079cr-Fk; Sat, 29 Aug 2020 19:40:42 +0000
Date:   Sat, 29 Aug 2020 20:40:42 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829194042.GT1236603@ZenIV.linux.org.uk>
References: <20200812143323.GF2810@work-vm>
 <27541158.PQPtYaGs59@silver>
 <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <20200829191751.GT14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829191751.GT14765@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 08:17:51PM +0100, Matthew Wilcox wrote:

> I probably have the wrong nomenclature for what I'm proposing.
> 
> So here's a concrete API.  What questions need to be answered?
> 
> fd = open("real", O_RDWR);
> 
> // fetch stream names
> sfd = open_stream(fd, NULL);
> read(sfd, names, length);

	1) what does fstat() on sfd return?
	2) what does keeping it open do to underlying file?
	3) what happens to it if that underlying file is unlinked?
	4) what does it do to underlying filesystem?  Can it be unmounted?

> close(sfd);

> 
> // open the first one
> sfd = open_stream(fd, names);
> read(sfd, buffer, buflen);
> close(sfd);
> 
> // create a new anonymous stream
> sfd = open_stream(fd, "");
> write(sfd, buffer, buflen);
> // name it
> linkat(sfd, NULL, fd, "newstream", AT_EMPTY_PATH);

Oh, lovely - so linkat() *CAN* get that for dirfd and must somehow tell
it from the normal case.  With the semantics entirely unrelated to the normal
one.  And on top of everything else, we have
	5) what are the permissions involved?  When are they determined, BTW?

> close(sfd);
> 
>  - Stream names are NUL terminated and may contain any other character.
>    If you want to put a '/' in a stream name, that's fine, but there's
>    no hierarchy.  Ditto "//../././../../..//./."  It's just a really
>    oddly named stream.

Er...  Whatever for?

>  - linkat() will fail if 'fd' does not match where 'sfd' was created.

	6) "match" in the above being what, exactly?

Incidentally, how do you remove those?
