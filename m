Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BED264ACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgIJRMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:12:38 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:52504 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgIJRMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:12:14 -0400
Date:   Thu, 10 Sep 2020 12:39:50 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910163949.GJ3265@brightrain.aerifal.cx>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
 <20200910162059.GA18228@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910162059.GA18228@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 05:20:59PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> > userspace emulation done in libc implementations. No change is made to
> > the underlying chmod_common(), so it's still possible to attempt
> > changes via procfs, if desired.
> 
> And that is the goddamn problem.  We need to fix that _first_.

Can you clarify exactly what that is? Do you mean fixing the
underlying fs backends, or just ensuring that the chmod for symlinks
doesn't reach them by putting the check in chmod_common? I'm ok with
any of these.

> After that we can add sugarcoating using new syscalls if needed.

The new syscall is _not_ about this problem. It's about the missing
flags argument and inability to implement fchmodat() without access to
procfs. The above problem is just something you encounter and have to
make a decision about in order to fix the missing flags problem and
make a working AT_SYMLINK_NOFOLLOW.

Rich
