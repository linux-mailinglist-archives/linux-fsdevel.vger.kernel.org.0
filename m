Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257793B24B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 04:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhFXCD1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 22:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhFXCD0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:03:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF6C061574;
        Wed, 23 Jun 2021 19:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0QHbmQbQHTx8CxUzqQMkfKnK4E0g0O8Q4OT44lwAo9M=; b=IveZmI3vJmiCcXAA2q0IDt8hNY
        RxCZRjKOZ4WlZYM7PFVhJimOZiZz1caDs6mPZMK/lQXuEqFHTT/WEnT5zfLX/roW1KX5tQLcLdlP8
        XsvxwheFWGr/wCQ+Q/7D985+jHRqnCHEYjY4FD4J3E1kSB3qNK1Mr+F8jyNkYkCwGjX4YQtIrD0E7
        z/Hfao/eSWJKdG0RfP1CXFzS38dlZBFyx8FyxKqxhit4ZSugMf4A30tWsHMvDO5IWBP2i/pAx4P2s
        HzYzwMikO2KH7ByhSpAjd4FDM55uB9UmVOzgYmvXid6REd0a7CA71Ixg3C5zQTdxJu3JbEN0RWmn9
        4QSeT/qA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwEfX-00G4ne-FP; Thu, 24 Jun 2021 02:00:45 +0000
Date:   Thu, 24 Jun 2021 03:00:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNPnRyasHVq9NF79@casper.infradead.org>
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 23, 2021 at 02:58:32PM -0700, Omar Sandoval wrote:
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

Does that work for O_DIRECT and the required 512-byte alignment?
