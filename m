Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3E22E5D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 08:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgG0GY2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 02:24:28 -0400
Received: from verein.lst.de ([213.95.11.211]:42172 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgG0GY2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:24:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0BE068B05; Mon, 27 Jul 2020 08:24:25 +0200 (CEST)
Date:   Mon, 27 Jul 2020 08:24:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     hpa@zytor.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/23] init: open code setting up stdin/stdout/stderr
Message-ID: <20200727062425.GA2005@lst.de>
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-19-hch@lst.de> <20200727030534.GD795125@ZenIV.linux.org.uk> <F3DAF5DA-82C2-4833-805D-4F54F7C4326E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3DAF5DA-82C2-4833-805D-4F54F7C4326E@zytor.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:20:41PM -0700, hpa@zytor.com wrote:
> On July 26, 2020 8:05:34 PM PDT, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >On Tue, Jul 14, 2020 at 09:04:22PM +0200, Christoph Hellwig wrote:
> >> Don't rely on the implicit set_fs(KERNEL_DS) for ksys_open to work,
> >but
> >> instead open a struct file for /dev/console and then install it as FD
> >> 0/1/2 manually.
> >
> >I really hate that one.  Every time we exposed the internal details to
> >the fucking early init code, we paid for that afterwards.  And this
> >goes over the top wrt the level of details being exposed.
> >
> >_IF_ you want to keep that thing, move it to fs/file.c, with dire
> >comment
> >re that being very special shite for init and likely cause of
> >subsequent
> >trouble whenever anything gets changed, a gnat farts somewhere, etc.
> >
> >	Do not leave that kind of crap sitting around init/*.c; KERNEL_DS
> >may be a source of occasional PITA, but here you are trading it for a
> >lot
> >worse one in the future.
> 
> Okay... here is a perhaps idiotic idea... even if we don't want to run stuff in actual user space, could we map initramfs into user space memory before running init (execing init will tear down those mappings anyway) so that we don't need KERNEL_DS at least?

Err, why?  The changes have been pretty simple, and I'd rather not come
up with new crazy ways just to make things complicated.
