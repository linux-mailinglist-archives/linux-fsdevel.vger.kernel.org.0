Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A325F214C29
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 13:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgGELrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 07:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGELrE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:47:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D71820723;
        Sun,  5 Jul 2020 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593949624;
        bh=iS+dEu4ZlbKVi61KnZ+UXpVxu0dHrpYBvIX4WV8E5m4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1c7gRkP8UaxVu6l1OoEYgLWfENAntRpmlfRdEJxsaxYkWDJ7glW+16ivqzObROx6Y
         qNzvkQqgD68TqZIIwsevTFQzBaNCHSWlJqgwmjbLYlVcmsjC6idJBNq6O6VI0aK6NG
         89qr1JRxgy2i/92FdgY7lUVvt05/uiLfQoMtLbwQ=
Date:   Sun, 5 Jul 2020 13:47:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705114706.GA1227487@kroah.com>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704193040.GC2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704193040.GC2786714@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 08:30:40PM +0100, Al Viro wrote:
> On Sat, Jul 04, 2020 at 04:02:46PM +0200, Greg Kroah-Hartman wrote:
> > Here is a tiny new syscall, readfile, that makes it simpler to read
> > small/medium sized files all in one shot, no need to do open/read/close.
> > This is especially helpful for tools that poke around in procfs or
> > sysfs, making a little bit of a less system load than before, especially
> > as syscall overheads go up over time due to various CPU bugs being
> > addressed.
> 
> Nice series, but you are 3 months late with it...  Next AFD, perhaps?

Perhaps :)

> Seriously, the rationale is bollocks.  If the overhead of 2 extra
> syscalls is anywhere near the costs of the real work being done by
> that thing, we have already lost and the best thing to do is to
> throw the system away and start with saner hardware.

The real-work the kernel does is almost neglegant compared to the
open/close overhead of the syscalls on some platforms today.  I'll post
benchmarks with the next version of this patch series to hopefully show
that.  If not, then yeah, this isn't worth it, but it was fun to write.

thanks,

greg k-h
