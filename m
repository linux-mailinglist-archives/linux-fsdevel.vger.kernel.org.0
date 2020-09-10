Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A81264A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgIJQtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 12:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgIJQmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:42:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3BBC061573;
        Thu, 10 Sep 2020 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+47H5A8WVuSjFI0h3Ukcy2wKP9GdHGo5YwAsuUcoBHw=; b=IZ9xQ3mRAEpm+VKYGpxZ6vLdsI
        Y3eCN0u46t2Gtb6MN41UIrlUIVEe/inE5XiA7SYxFwTCsdqKhEGzG51DN2UEs42BT9NXMz0NIyYha
        Yzcdul7y9R+B8PnjyZwlXGZjmXfWEcdRSWZIBBC39OsiFXSA8JDks8HQowaJwDXdQH3t5sava4AEi
        ibxHvTh8fl8ZqS3nrT2k8W5z3mrMDYTgEHtZ5QLUyIk2ff828NoSYYElFfR9vUbqVhCabQ4CDjpvN
        qPg22j9V8tUfapO7FFSURCYeE+O5sIsrSRbtV+XrPqEyfR5WY4ytSoFjXHkuN9kWz97wUT0ZtL+gZ
        bkA+FgIQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGPec-0006Zw-Kg; Thu, 10 Sep 2020 16:42:34 +0000
Date:   Thu, 10 Sep 2020 17:42:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: add fchmodat2 syscall
Message-ID: <20200910164234.GA25140@infradead.org>
References: <20200910142335.GG3265@brightrain.aerifal.cx>
 <20200910162059.GA18228@infradead.org>
 <20200910163949.GJ3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910163949.GJ3265@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:39:50PM -0400, Rich Felker wrote:
> On Thu, Sep 10, 2020 at 05:20:59PM +0100, Christoph Hellwig wrote:
> > On Thu, Sep 10, 2020 at 10:23:37AM -0400, Rich Felker wrote:
> > > userspace emulation done in libc implementations. No change is made to
> > > the underlying chmod_common(), so it's still possible to attempt
> > > changes via procfs, if desired.
> > 
> > And that is the goddamn problem.  We need to fix that _first_.
> 
> Can you clarify exactly what that is? Do you mean fixing the
> underlying fs backends, or just ensuring that the chmod for symlinks
> doesn't reach them by putting the check in chmod_common? I'm ok with
> any of these.

Either - we need to make sure the user can't change the permission
bits.

> > After that we can add sugarcoating using new syscalls if needed.
> 
> The new syscall is _not_ about this problem. It's about the missing
> flags argument and inability to implement fchmodat() without access to
> procfs. The above problem is just something you encounter and have to
> make a decision about in order to fix the missing flags problem and
> make a working AT_SYMLINK_NOFOLLOW.

And I'm generally supportive of that.  But we need to fix the damn
bug first an then do nice to haves.
