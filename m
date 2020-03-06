Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90A17C72B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 21:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCFUiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 15:38:52 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39000 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFUiw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:38:52 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAJk4-006U15-Rb; Fri, 06 Mar 2020 20:38:45 +0000
Date:   Fri, 6 Mar 2020 20:38:44 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200306203844.GC23230@ZenIV.linux.org.uk>
References: <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <20200306162549.GA28467@miu.piliscsaba.redhat.com>
 <20200306194322.GY23230@ZenIV.linux.org.uk>
 <20200306195823.GZ23230@ZenIV.linux.org.uk>
 <20200306200522.GA23230@ZenIV.linux.org.uk>
 <20200306203705.GB23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306203705.GB23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 08:37:05PM +0000, Al Viro wrote:

> You are misreading mntput_no_expire(), BTW - your get_mount() can
> bloody well race with umount(2), hitting the moment when we are done
> figuring out whether it's busy but hadn't cleaned ->mnt_ns (let alone
> set MNT_DOOMED) yet.  If somebody calls umount(2) on a filesystem that
> is not mounted anywhere else, they are not supposed to see the sucker
> return 0 until the filesystem is shut down.  You break that.

While we are at it, d_alloc_parallel() requires i_rwsem on parent held
at least shared.
