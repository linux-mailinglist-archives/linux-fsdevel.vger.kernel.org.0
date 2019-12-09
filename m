Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6E79116F2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfLIOkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:40:07 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34844 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfLIOkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W4l5Cx8ZgsHs4yQOqjrJ4kn71geW9TvbjjZNSVfp8CA=; b=wxOsyl1JWkRE9N0mzgCZ2/mrF
        5cS5xHs/y3El+0j2Veuwg3LhQR1pmC7Xp1R/A3wMXHn8SF+2b8oB0GZc2lCnXX+Ywr8sTj/VKQjfp
        3NDIgrRguHrYlo/dtjpu/sqzvboBLq77emOLXt1hTnqY3S08CZCmBav7olhja3X51H49v/9bJJ5Z0
        nlw7F0dw9ztfb7goUtnEaHUeoic0JvTDnUYmRD2Gdwk2NT/Fse1JjvheHYudeOGgrj12g8nY9BDiY
        1ZlkSwLcws8wqfpM2xFJC4HtLmg0W47zQkHeJ4IcFhRc+oBjH+TDVwUpk4ZDkQdA9NV0XlOKhpBr7
        iIuqhZZwg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46508)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ieKCf-0003ce-L3; Mon, 09 Dec 2019 14:40:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ieKCe-0003ja-2F; Mon, 09 Dec 2019 14:40:00 +0000
Date:   Mon, 9 Dec 2019 14:40:00 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Vyacheslav Dubeyko <slava@dubeyko.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/41] fs/adfs: inode: update timestamps to centisecond
 precision
Message-ID: <20191209143959.GL25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
 <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
 <59711cf492815c5bba93d641398011ea2341f635.camel@dubeyko.com>
 <20191209140357.GJ25745@shell.armlinux.org.uk>
 <e45222ab3f6292c013c93126078396f4b212d904.camel@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e45222ab3f6292c013c93126078396f4b212d904.camel@dubeyko.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 09, 2019 at 05:34:05PM +0300, Vyacheslav Dubeyko wrote:
> On Mon, 2019-12-09 at 14:03 +0000, Russell King - ARM Linux admin
> wrote:
> > > > 
> > On Mon, Dec 09, 2019 at 04:54:55PM +0300, Vyacheslav Dubeyko wrote:
> > > On Mon, 2019-12-09 at 11:08 +0000, Russell King wrote:
> 
> <snipped>
> 
> > > >  	sb->s_fs_info = asb;
> > > > +	sb->s_time_gran = 10000000;
> > > 
> > > I believe it's not easy to follow what this granularity means.
> > > Maybe,
> > > it makes sense to introduce some constant and to add some comment?
> > 
> > Or simply name it "s_time_gran_ns" so the units are in the name.
> > 
> 
> Sounds good. :) But why namely 10000000?

I don't know what you mean.

If you're asking, why "10000000", isn't it obvious if you read the
commit message?  adfs has "centi-second" granularity. s_time_gran
is in nanoseconds. There are 10000000 nanoseconds in a centisecond.

What do you expect?

#define ADFS_TIME_GRAN 10000000

	sb->s_time_gran = ADFS_TIME_GRAN;

?

How does that help - it just stupidly and needlessly obfuscates the
code.

The whole "use definitions for constants" is idiotic when a constant
is only used in one place - when it means you have to search through
more source code to find it's single definition. Sorry, I'm not
doing that and make readability *worse*.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
