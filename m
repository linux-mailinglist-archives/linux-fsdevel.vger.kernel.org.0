Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07253306365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 19:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhA0Scn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 13:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236221AbhA0Sci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:32:38 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DD1C06174A;
        Wed, 27 Jan 2021 10:31:57 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4pbc-006j0L-K3; Wed, 27 Jan 2021 18:31:52 +0000
Date:   Wed, 27 Jan 2021 18:31:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iov_iter: optimise iter type checking
Message-ID: <20210127183152.GP740243@zeniv-ca>
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
 <b04df39d77114547811d7bfc2c0d4c8c@AcuMS.aculab.com>
 <1783c58f-1016-0c6b-be7f-a93bc2f8f2a4@gmail.com>
 <20210116051818.GF3579531@ZenIV.linux.org.uk>
 <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed385c4d-99ca-d7aa-8874-96e3c6b743bb@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:48:10PM +0000, Pavel Begunkov wrote:
> On 16/01/2021 05:18, Al Viro wrote:
> > On Sat, Jan 09, 2021 at 10:11:09PM +0000, Pavel Begunkov wrote:
> > 
> >>> Does any code actually look at the fields as a pair?
> >>> Would it even be better to use separate bytes?
> >>> Even growing the on-stack structure by a word won't really matter.
> >>
> >> u8 type, rw;
> >>
> >> That won't bloat the struct. I like the idea. If used together compilers
> >> can treat it as u16.
> > 
> > Reasonable, and from what I remember from looking through the users,
> > no readers will bother with looking at both at the same time.
> 
> Al, are you going turn it into a patch, or prefer me to take over?

I'll massage that a bit and put into #work.iov_iter - just need to dig my
way from under the pile of ->d_revalidate() review...
