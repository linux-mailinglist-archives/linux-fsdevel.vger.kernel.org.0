Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9984B117297
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 18:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLIRQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 12:16:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfLIRQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sKpnu902walIOcxLjkyyE85oTqPlYWgcrFR9yLmrVZU=; b=BSFEUKa6yZYh0/Ab+Zooqn0Xe
        4I5Nd23IqCcv3CYR3Wzoe0Z0kkvXapgvfRN4/vx6vimNalltX0dqNtrSRF+oM/QfoZ3xpuBFSlaJ0
        wSH95GEwOIxNvHeT+qaYKesj4kNoEAgCHTFnHka1mnx5Kqt9GHJ0ey69gA3B6sbKTaduecBtZE8wi
        85aSIaz/FmM6PI9OrxJzFcb4cHunNnIyM61BsEyv1w8XWM4AEDGmV1g27TbjVVxK5wgHZC5Ht8hoe
        6N5AWMjgXDoZHV6iDmV4vcm35/ZF9FDYML5f1CeOC2G8OIvJBD213jNgMk/gQU177unQbRDQEfjnw
        8h3YtLDWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieMdb-0007X8-7W; Mon, 09 Dec 2019 17:15:59 +0000
Date:   Mon, 9 Dec 2019 09:15:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Vyacheslav Dubeyko <slava@dubeyko.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/41] fs/adfs: inode: update timestamps to centisecond
 precision
Message-ID: <20191209171559.GF32169@bombadil.infradead.org>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
 <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
 <59711cf492815c5bba93d641398011ea2341f635.camel@dubeyko.com>
 <20191209140357.GJ25745@shell.armlinux.org.uk>
 <e45222ab3f6292c013c93126078396f4b212d904.camel@dubeyko.com>
 <20191209143959.GL25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209143959.GL25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 02:40:00PM +0000, Russell King - ARM Linux admin wrote:
> > Sounds good. :) But why namely 10000000?
> 
> I don't know what you mean.
> 
> If you're asking, why "10000000", isn't it obvious if you read the
> commit message?  adfs has "centi-second" granularity. s_time_gran
> is in nanoseconds. There are 10000000 nanoseconds in a centisecond.
> 
> What do you expect?
> 
> #define ADFS_TIME_GRAN 10000000
> 
> 	sb->s_time_gran = ADFS_TIME_GRAN;
> 
> ?
> 
> How does that help - it just stupidly and needlessly obfuscates the
> code.
> 
> The whole "use definitions for constants" is idiotic when a constant
> is only used in one place - when it means you have to search through
> more source code to find it's single definition. Sorry, I'm not
> doing that and make readability *worse*.

I'd find it more readable if you wrote it as 10 * 1000 * 1000.  Saves
trying to count zeroes.  I know C added the ability to spell that as
10'000'000, but I don't think all compiler versions support that yet.

Maybe this would be cleanest:

	sb->s_time_gran = NSEC_PER_SEC / 100;

This is definitely how not to do it:

include/acpi/actypes.h:#define ACPI_100NSEC_PER_SEC            10000000L

