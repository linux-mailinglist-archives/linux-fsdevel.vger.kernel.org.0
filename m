Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148EB36E31C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 03:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhD2Bze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 21:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhD2Bzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:55:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD44EC06138B;
        Wed, 28 Apr 2021 18:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CJN5Kcexc5YmqOT6pv9lP9gGODhHyBXgg7ljmhraqDk=; b=MgrtTnP78RCXUa07uJ+CbKbio8
        iUKZZ0tjhYvwjvMrQCHIPLZi8HY9EV5m9xJvSSnCDbNElxcVU9P8fARoRCTzT5c5/qxfHGwvPlZct
        HrxzaFsQ83Kj6zqcZamFXINPoqWlDdC3fFjYcdEXmtQzb2oz2NoiINdoxlbXVC9nGUT2sYJg/PXar
        /tmt/2dtPlKTp37K3ZzyDrntnMe/5N7pX9fRtdP5GLrAjzIQkfTQc8cldIP6CNyv5jryXHu8Bk2LX
        gpE4CNUoBrk35pNxozJVVHrARz538ghHjLrOPWE3VRqxZogzNFLaaQp/3TjmRG1P3YgyOx0akvnLX
        bT+7TSfA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbvsU-0093XD-V2; Thu, 29 Apr 2021 01:54:38 +0000
Date:   Thu, 29 Apr 2021 02:54:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, pakki001@umn.edu,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: Re: [PATCH] ics932s401: fix broken handling of errors when word
 reading fails
Message-ID: <20210429015406.GE1847222@casper.infradead.org>
References: <20210428222534.GJ3122264@magnolia>
 <20210428224624.GD1847222@casper.infradead.org>
 <20210429010351.GI1251862@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429010351.GI1251862@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 06:03:51PM -0700, Darrick J. Wong wrote:
> On Wed, Apr 28, 2021 at 11:46:24PM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 28, 2021 at 03:25:34PM -0700, Darrick J. Wong wrote:
> > > In commit b05ae01fdb89, someone tried to make the driver handle i2c read
> > > errors by simply zeroing out the register contents, but for some reason
> > > left unaltered the code that sets the cached register value the function
> > > call return value.
> > > 
> > > The original patch was authored by a member of the Underhanded
> > > Mangle-happy Nerds, I'm not terribly surprised.  I don't have the
> > > hardware anymore so I can't test this, but it seems like a pretty
> > > obvious API usage fix to me...
> > 
> > Not sure why you cc'd linux-fsdevel, but that's how i got to see it ...
> 
> I whacked the wrong mutt shortcut key. :)

"A computer lets you make more mistakes faster than any other invention
with the possible exceptions of handguns and Tequila."

> > Looking at a bit more context in this function, shouldn't we rather clear
> > 'sensors_valid'?  or does it really make sense to pretend we read zero
> > (rather than 255) from this register?
> 
> Dunno.  As I said, I don't have that piece of hardware anymore.
> It probably does make more sense to fail the read or something, but
> since I can't QA it properly I'll go with "return a batch of zeroes".

It's from 2008 ... does anyone have that piece of hardware any more,
or should we delete the driver?  Seems like it's for use with the Intel
Pentium 4/D 955X chipset, which is from 2005.  Definitely out of support,
but I guess not entirely dead yet.

> Though ... if memory serves, the current behavior will probably shift
> the interesting parts of the errno code off the right end, filling the
> u8 buffer with all ones.  Maybe?

Right.  I mean, my smartwatch sometimes reads my heart rate as 255 bpm
when it gets cold.  I don't think they did QA at -40C.

But what's being read here is a bit more complex than beats-per-minute;
there's divisors and control registers and stuff.  I just don't feel
like '0' is a good fake value to pretend to have read.  I think we have
four options -- complicate the driver to make it understand that it
didn't read a value, pretend we read 0, 255 or the-last-value-we-read.
And the last option seems like the best to me?  So ...

@@ -134,7 +134,7 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
        for (i = 0; i < NUM_MIRRORED_REGS; i++) {
                temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
                if (temp < 0)
-                       data->regs[regs_to_copy[i]] = 0;
+                       continue;
                data->regs[regs_to_copy[i]] = temp >> 8;
        }
 

might be the best we can do?
