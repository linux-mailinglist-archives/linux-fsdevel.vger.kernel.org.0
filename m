Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4FB3E1062
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237464AbhHEIfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 04:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237891AbhHEIfp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D322560F38;
        Thu,  5 Aug 2021 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628152531;
        bh=Yrn6sqTekF6PeA1ktJLFOwdn4txRLATabspLPmH5xJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xU25zz4i8OCGTyLqwSf3Iv8PuIgQ9Vs7rZ9pVsCd4vSRSsvFovBsuZ+poZ8Z5svk+
         uQVY9frN3cEAtJ7ztOEZDxoK1o6WNZ4TFbzE1Uy0IsywpWba+kxRDCoPlp9uCpzxbk
         M9ZY0sJ+K1BKd4QYYRfog7Xz9jiU37DG7eKIgXhc=
Date:   Thu, 5 Aug 2021 10:35:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.or,
        dhowells@redhat.com, linux@rasmusvillemoes.dk,
        peterz@infradead.org, nicolas.dichtel@6wind.com, raven@themaw.net,
        christian@brauner.io
Subject: Re: [PATCH] pipe: increase minimum default pipe size to 2 pages
Message-ID: <YQuixFfztw0RaDFi@kroah.com>
References: <20210805000435.10833-1-alex_y_xu.ref@yahoo.ca>
 <20210805000435.10833-1-alex_y_xu@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805000435.10833-1-alex_y_xu@yahoo.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 04, 2021 at 08:04:35PM -0400, Alex Xu (Hello71) wrote:
> Before this patch, the following program prints 4096 and hangs.
> Afterwards, it prints 8192 and exits successfully. Note that you may
> need to increase your RLIMIT_NOFILE before running the program.
> 
> int main() {
>     int pipefd[2];
>     for (int i = 0; i < 1025; i++)
>         if (pipe(pipefd) == -1)
>             return 1;
>     size_t bufsz = fcntl(pipefd[1], F_GETPIPE_SZ);
>     printf("%zd\n", bufsz);
>     char *buf = calloc(bufsz, 1);
>     write(pipefd[1], buf, bufsz);
>     read(pipefd[0], buf, bufsz-1);
>     write(pipefd[1], buf, 1);
> }
> 
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---

Is this due to the changes that happened in 5.5?  If so, a cc: stable
and a fixes tag would be nice to have :)

> See discussion at https://lore.kernel.org/lkml/1628086770.5rn8p04n6j.none@localhost/.

This can go up in the changelog text too.

thanks,

greg k-h
