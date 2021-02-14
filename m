Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95CC31B31E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Feb 2021 23:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBNW6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Feb 2021 17:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhBNW6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Feb 2021 17:58:38 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC0C061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Feb 2021 14:57:57 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBQKt-00E2fb-UZ; Sun, 14 Feb 2021 22:57:52 +0000
Date:   Sun, 14 Feb 2021 22:57:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC] namei: don't drop link paths acquired under
 LOOKUP_RCU
Message-ID: <YCmq75pc0bHInDGP@zeniv-ca.linux.org.uk>
References: <8b114189-e943-a7e6-3d31-16aa8a148da6@kernel.dk>
 <YClKQlivsPPcbyCd@zeniv-ca.linux.org.uk>
 <YClSik4Ilvh1vF64@zeniv-ca.linux.org.uk>
 <0699912b-84ae-39d5-6b2e-8cb04eaa3939@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0699912b-84ae-39d5-6b2e-8cb04eaa3939@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 14, 2021 at 09:45:39AM -0700, Jens Axboe wrote:

> >> +out3:
> >> +	nd->depth = 0;	// as we hadn't gotten to legitimize_links()
> >>  out2:
> >>  	nd->path.mnt = NULL;
> >>  out1:
> > 
> > Alternatively, we could use the fact that legitimize_links() is not
> > called anywhere other than these two places and have LOOKUP_CACHED
> > checked there.  As in
> 
> Both fix the issue for me, just tested them. The second one seems
> cleaner to me, would probably be nice to have a comment on that in
> either the two callers or at least in legitimize_links() though.

Hmm...  Do you have anything on top of that branch?  If you do, there's
no way to avoid leaving bisect hazard; if not, I'd rather fold a fix
into the broken commit...
