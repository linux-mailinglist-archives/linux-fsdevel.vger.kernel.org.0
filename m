Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B084A540F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 01:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiBAAaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 19:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiBAAaS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:30:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2137C061714;
        Mon, 31 Jan 2022 16:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wCllJt1DxhpzMCaB8bcse2sVN5nJ6RjkGMkVeeF9NZ4=; b=g0oSgH9dlxF/6YP1dTT3ahQwEH
        gY5nXKNxj09ExKNT+gD+hcuOvdSPbBe7c/s5hlb8aOx+SFLBVrzybZfqLCnNISRAW4mLRZf3UpJOR
        w3lrufRe4KuhOwdF2FpiqMbYjfqDhjqP8VlBDwz8OYrAsY+FPPnOO8ejy21IuGqU6FE4OqTjYIAsM
        Nc+gGADtlesZPQss+M4ohfjHB/c75Z5vzumMHloG1Kh/r/lNVHpm1UmnU5Cw+lOLVV2HHNs4YdkBL
        JPCamc3MiBR2SCV1h31r1uXP1JK6yHVTpGqpaepXlGl9VRvIY6PU4jJk6fQ+zpSx5Uyll/bIWaCw+
        QfpfE5Dg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEh3j-00B0lh-7b; Tue, 01 Feb 2022 00:30:11 +0000
Date:   Tue, 1 Feb 2022 00:30:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Mathnerd314 <mathnerd314.gph@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: EINTR for fsync(2)
Message-ID: <Yfh/E5i/oqhe6KsQ@casper.infradead.org>
References: <CADVL9rE70DK+gWn-pbHXy6a+5sdkHzFg_xJ9phhQkRapTUJ_zg@mail.gmail.com>
 <55d40a53-ad40-0bbf-0aed-e57419408796@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55d40a53-ad40-0bbf-0aed-e57419408796@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:44:38PM +0100, Alejandro Colomar (man-pages) wrote:
> Hello Alexander,
> 
> On 1/31/22 19:32, Mathnerd314 wrote:
> > Hi,
> > 
> > The POSIX standard says fsync(2) can return EINTR:
> > https://pubs.opengroup.org/onlinepubs/9699919799/
> > 
> > The man page does not:
> > https://man7.org/linux/man-pages/man2/fsync.2.html
> > 
> > I think fsync can be interrupted by a signal on Linux, so this should
> > just be an oversight in the man page.
> > 
> > At least, fsync on fuse seems be able to return EINTR:
> > https://github.com/torvalds/linux/blob/5367cf1c3ad02f7f14d79733814302a96cc97b96/fs/fuse/dev.c#L114
> > 
> > Actually there seem to be numerous error codes that can be returned
> > from all filesystem calls on fuse: ENOTCONN, ENOMEM, etc. But EINTR is
> > at least documented in the POSIX standard, whereas these others seem
> > really rare. But for full correctness I suppose these should be
> > documented as well. It would be quite an undertaking.

It's probably worth reading this part of POSIX:

: 2.3 Error Numbers
:
: Most functions can provide an error number. The means by which each
: function provides its error numbers is specified in its description.
: 
: Some functions provide the error number in a variable accessed through
: the symbol errno, defined by including the <errno.h> header. The value
: of errno should only be examined when it is indicated to be valid by
: a function's return value. No function in this volume of POSIX.1-2017
: shall set errno to zero. For each thread of a process, the value of
: errno shall not be affected by function calls or assignments to errno
: by other threads.
: 
: Some functions return an error number directly as the function
: value. These functions return a value of zero to indicate success.
: 
: If more than one error occurs in processing a function call, any one
: of the possible errors may be returned, as the order of detection is
: undefined.
: 
: Implementations may support additional errors not included in this list,
: may generate errors included in this list under circumstances other
: than those described here, or may contain extensions or limitations that
: prevent some errors from occurring.
: 
: The ERRORS section on each reference page specifies which error conditions
: shall be detected by all implementations (``shall fail") and which may
: be optionally detected by an implementation (``may fail"). If no error
: condition is detected, the action requested shall be successful. If an
: error condition is detected, the action requested may have been partially
: performed, unless otherwise stated.

So while it's worth adding EINTR to the man page, I don't think it's
worth going through an exercise of trying to add every possible
errno to every syscall.

