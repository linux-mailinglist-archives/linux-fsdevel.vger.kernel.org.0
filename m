Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A867257B38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaOXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 10:23:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59437 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726292AbgHaOXg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:23:36 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07VENCmS024921
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 10:23:13 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 45286420128; Mon, 31 Aug 2020 10:23:12 -0400 (EDT)
Date:   Mon, 31 Aug 2020 10:23:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200831142312.GB4267@mit.edu>
References: <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <20200829191751.GT14765@casper.infradead.org>
 <20200829194042.GT1236603@ZenIV.linux.org.uk>
 <20200829201245.GU14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829201245.GU14765@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 09:12:45PM +0100, Matthew Wilcox wrote:
> > 	3) what happens to it if that underlying file is unlinked?
> 
> Unlinking a file necessarily unlinks all the streams.  So the file
> remains in existance until all fds on it are closed, including all
> the streams.

That's a bad idea, because if the fds are closed silently, then they
can be reused; and then if the userspace library tries to write to
what it *thinks* is an ADS file, not knowing that the application has
unlinked and closed the ADS file, user file data would be lost.

What we would want instead (if we want to pursue the madness of ADS,
which I don't), is something like the effects of a BSD-style revoke(2)
system call, which causes all attempts to operate on said file
descriptor to return an error and/or EOF after the fd has been
revoked.

				- Ted
