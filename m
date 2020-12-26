Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81E22E2EE3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Dec 2020 18:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgLZR6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Dec 2020 12:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgLZR6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Dec 2020 12:58:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AD8C0613C1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Dec 2020 09:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5jiMr/lyn6lvkRlFqUo8QdAXYN+UYKROrmXOMsSa8zA=; b=oHAjQpbkvDodhU/LPildFsD2MI
        U8BkdeHPn8gI7vOSZfKjgStVFL66I/R0HuzAv5no24ShUWy0F5RA+ZAlJCoftWOa+HWnVILEt/3wQ
        JguG1QdG3Effq3pzGhy3P4buLxCAPXSGZdrZ97X3BaVtfPu8oEhr2zj75YORCTphV5c2nGvXuboVy
        TtzIu0Ndau/JkB7eFSulY7BWcBweSLNeFA+d0GH9vO4zCaUbYcGiM8BtM0m2nWy/yU81Ofb4EotPS
        ZFpi3LUjH6p8oAmtgV5ufn56ZcUyA8bu9haam3HRyoK8HrbwiZvyAUXI8ltgA/kSHvYCtR78s+MW3
        cv3DMxSg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktDpJ-0000tm-UE; Sat, 26 Dec 2020 17:58:02 +0000
Date:   Sat, 26 Dec 2020 17:58:01 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 1/4] fs: make unlazy_walk() error handling consistent
Message-ID: <20201226175801.GV874@casper.infradead.org>
References: <20201217161911.743222-1-axboe@kernel.dk>
 <20201217161911.743222-2-axboe@kernel.dk>
 <66d1d322-42d4-5a46-05fb-caab31d0d834@kernel.dk>
 <20201226045043.GA3579531@ZenIV.linux.org.uk>
 <9ce193e7-8609-7d96-4719-f1b316c927e6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ce193e7-8609-7d96-4719-f1b316c927e6@kernel.dk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Dec 26, 2020 at 10:33:25AM -0700, Jens Axboe wrote:
> +.TP
> +.B RESOLVE_CACHED
> +Make the open operation fail unless all path components are already present
> +in the kernels lookup cache.
> +If any kind of revalidation or IO is needed to satisfy the lookup,

Usually spelled I/O in manpages.

> +.BR openat2 ()
> +fails with the error
> +.B EAGAIN.
> +This is useful in providing a fast path open that can be performed without
> +resorting to thread offload, or other mechanism that an application might
> +use to offload slower operations.

That almost reads backwards ... how about this?

This provides a fast path open that can be used when an application does
not wish to block.  It allows the application to hand off the lookup to
a separate thread which can block.

