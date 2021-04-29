Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5566036E2D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 03:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhD2BEh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 21:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhD2BEg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:04:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D70AE61433;
        Thu, 29 Apr 2021 01:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619658231;
        bh=QelXBbSgBUyrBKlgyxSwVEOZEOdLf7nE1gbuDs5Zp2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYwN3D8qFwmrI+nK9zY/A1ycwLtx3ON1QCbwvYVqg3ZsA6DwL+Ivf35eF/zMMmrAi
         mFqIofIChqxZMeFkBDJ8TkrPR2iXw+b7ZkbQ4W1KTZMAhAgNZ041F0VTO7wtvVaIk9
         jGGRTt+NnkHgOW/7s0H32742JUzfyYikmklDPhC/ZjMJYs/KsZG/UmYq0LHzT44Lc6
         MY2UulNn63LFet5m1NzeyVHf9CnZxM/l9sOaQWrkOE9cahSHrhMsdFeBBmjx69jnyJ
         2F/m8Mmge2sSyolAegGWChTna3Qjhj1PUhmgYC4Cr4xBvKf2D6L9LYck+qAaht1bAk
         iV/dVApS5cFsA==
Date:   Wed, 28 Apr 2021 18:03:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, pakki001@umn.edu,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: Re: [PATCH] ics932s401: fix broken handling of errors when word
 reading fails
Message-ID: <20210429010351.GI1251862@magnolia>
References: <20210428222534.GJ3122264@magnolia>
 <20210428224624.GD1847222@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428224624.GD1847222@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 11:46:24PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 28, 2021 at 03:25:34PM -0700, Darrick J. Wong wrote:
> > In commit b05ae01fdb89, someone tried to make the driver handle i2c read
> > errors by simply zeroing out the register contents, but for some reason
> > left unaltered the code that sets the cached register value the function
> > call return value.
> > 
> > The original patch was authored by a member of the Underhanded
> > Mangle-happy Nerds, I'm not terribly surprised.  I don't have the
> > hardware anymore so I can't test this, but it seems like a pretty
> > obvious API usage fix to me...
> 
> Not sure why you cc'd linux-fsdevel, but that's how i got to see it ...

I whacked the wrong mutt shortcut key. :)

> > +++ b/drivers/misc/ics932s401.c
> > @@ -134,7 +134,7 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
> >  	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
> >  		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
> >  		if (temp < 0)
> > -			data->regs[regs_to_copy[i]] = 0;
> > +			temp = 0;
> >  		data->regs[regs_to_copy[i]] = temp >> 8;
> >  	}
> 
> Looking at a bit more context in this function, shouldn't we rather clear
> 'sensors_valid'?  or does it really make sense to pretend we read zero
> (rather than 255) from this register?

Dunno.  As I said, I don't have that piece of hardware anymore.
It probably does make more sense to fail the read or something, but
since I can't QA it properly I'll go with "return a batch of zeroes".

Though ... if memory serves, the current behavior will probably shift
the interesting parts of the errno code off the right end, filling the
u8 buffer with all ones.  Maybe?

> But then we'd have to actually check sensors_valid in functions like
> calculate_src_freq, and i just don't know if it's worthwhile.  Why not
> just revert this patch?

I had half expected them all to get reverted immediately, but since 5.12
went out with this still included, I thought it worth pointing out that
despite UMN claims that none of their junk patches made it to Linus,
this (mostly benign) one did.  Granted, maybe 18 Jan 2019 was earlier
than that, but who knows and who cares? :P

--D
