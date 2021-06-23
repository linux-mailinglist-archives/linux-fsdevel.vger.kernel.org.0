Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04FB3B2394
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 00:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFWW2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWW2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 18:28:52 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2197C061574;
        Wed, 23 Jun 2021 15:26:34 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwBKB-00BeJB-Rn; Wed, 23 Jun 2021 22:26:23 +0000
Date:   Wed, 23 Jun 2021 22:26:23 +0000
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
Message-ID: <YNO1D++slcnNoLVU@zeniv-ca.linux.org.uk>
References: <YNDem7R6Yh4Wy9po@relinquished.localdomain>
 <CAHk-=wh+-otnW30V7BUuBLF7Dg0mYaBTpdkH90Ov=zwLQorkQw@mail.gmail.com>
 <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
 <YNOuiMfRO51kLcOE@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNOuiMfRO51kLcOE@relinquished.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:58:32PM -0700, Omar Sandoval wrote:

> Ah, I was stuck on thinking about this calling convention:
> 
> 	struct encoded_iov encoded_iov;
> 	char compressed_data[...];
> 	struct iovec iov[] = {
> 		{ &encoded_iov, sizeof(encoded_iov) },
> 		{ compressed_data, sizeof(compressed_data) },
> 	};
> 	preadv2(fd, iov, 2, -1, RWF_ENCODED);
> 
> But what you described would look more like:
> 
> 	// Needs to be large enough for maximum returned header + data.
> 	char buffer[...];
> 	struct iovec iov[] = {
> 		{ buffer, sizeof(buffer) },
> 	};
> 	preadv2(fd, iov, 2, -1, RWF_ENCODED);
> 	// We should probably align the buffer.
> 	struct encoded_iov *encoded_iov = (void *)buffer;
> 	char *data = buffer + encoded_iov->size;
> 
> That's a little uglier, but it should work, and allows for arbitrary
> extensions. So, among these three alternatives (fixed size structure
> with reserved space, variable size structure like above, or ioctl),
> which would you prefer?

Variable-sized structure would seem to be the easiest from the kernel
POV and the interface is the easiest to describe - "you read the
encoded data preceded by the header"...
