Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F1036E5A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhD2HNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 03:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2HNS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2B046141E;
        Thu, 29 Apr 2021 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619680351;
        bh=3fsok0wCSZLbAq41vKAGozZ3ndqQi3pGDMCx05gU6Z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rRdbBS/sTyijeyENZnMbKpXk03EzmAzpkK1RSADy1NOsrbf8DRs7Rbsp0vuClmFJu
         JOUOFSPxXxDjX6p5c+A6Hey/dv11q4csuErnG1BlOZqXEobbjovrgNqdjwzbZwKsVU
         whuo78INCZj3HXHZJKoH13Er40a1gJo7sqBj5kZ0=
Date:   Thu, 29 Apr 2021 09:12:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, pakki001@umn.edu,
        arnd@arndb.de
Subject: Re: [PATCH] ics932s401: fix broken handling of errors when word
 reading fails
Message-ID: <YIpcXKQtn6mLcU+o@kroah.com>
References: <20210428222534.GJ3122264@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428222534.GJ3122264@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:25:34PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> In commit b05ae01fdb89, someone tried to make the driver handle i2c read
> errors by simply zeroing out the register contents, but for some reason
> left unaltered the code that sets the cached register value the function
> call return value.
> 
> The original patch was authored by a member of the Underhanded
> Mangle-happy Nerds, I'm not terribly surprised.  I don't have the
> hardware anymore so I can't test this, but it seems like a pretty
> obvious API usage fix to me...
> 
> Fixes: b05ae01fdb89 ("misc/ics932s401: Add a missing check to i2c_smbus_read_word_data")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  drivers/misc/ics932s401.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ics932s401.c b/drivers/misc/ics932s401.c
> index 2bdf560ee681..0f9ea75b0b18 100644
> --- a/drivers/misc/ics932s401.c
> +++ b/drivers/misc/ics932s401.c
> @@ -134,7 +134,7 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
>  	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
>  		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
>  		if (temp < 0)
> -			data->regs[regs_to_copy[i]] = 0;
> +			temp = 0;
>  		data->regs[regs_to_copy[i]] = temp >> 8;
>  	}
>  

Many thanks for looking at this again, I'll add it to my series of
patches for "reviewing all the crap and fixing it up" that I will be
working to get merged for 5.13-final.

greg k-h
