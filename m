Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4D43B229C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 23:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFWVme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 17:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWVmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 17:42:33 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A47C061574;
        Wed, 23 Jun 2021 14:40:15 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwAb6-00BdqY-Is; Wed, 23 Jun 2021 21:39:48 +0000
Date:   Wed, 23 Jun 2021 21:39:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
References: <YM0fFnMFSFpUb63U@zeniv-ca.linux.org.uk>
 <YM09qaP3qATwoLTJ@relinquished.localdomain>
 <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNOdunP+Fvhbsixb@relinquished.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 01:46:50PM -0700, Omar Sandoval wrote:

> Suppose we add a new field representing a new type of encoding to the
> end of encoded_iov. On the write side, the caller might want to specify
> that the data is encoded in that new way, of course. But on the read
> side, if the data is encoded in that new way, then the kernel will want
> to return that. The kernel needs to know if the user's structure
> includes the new field (otherwise when it copies the full struct out, it
> will write into what the user thinks is the data instead).

Er...  What's the problem with simply copying that extended structure out,
followed by the data?

IOW, why can't the caller pick the header out of the whole thing and
deal with it in whatever way it likes?  Why should kernel need to do
anything special here?

IDGI...  Userland had always been able to deal with that kind of stuff;
you read e.g. gzipped data into buffer, you decode the header, you figure
out how long it is and how far out does the payload begin, etc.

How is that different?
