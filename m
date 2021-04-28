Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4351B36E1D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 01:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhD1WrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 18:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbhD1WrV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:47:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DB1C06138B;
        Wed, 28 Apr 2021 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rXvNoPgNaqHdbVMB7W9vlBaxUSKI0uva7csE65FMNlc=; b=Z50PuLd7pKNDi6e9BoiTyDnQk+
        EeJAhxafmDN+smPJ+7W5l4NFjyR9ohGXtYYFBohs6UwaLp8B2sdocAvKKYftpFeJ+KE+Oo7gHVMjO
        t3DtlN8KEjYDiYfw4oJbLwO+YO1qyR9zVlBbuBq25lfNDnF8V0zesPIeTIiyghyexOIzFGs+6oegK
        TsrG066XXmbXAaQL/+ZG5UVMqEVfEqJHcvefgw3UJhmuU/p9CHlUKmdbahc2JnzguQU+eYnsEhWjp
        5M7iZyaSdXFVOkwJ7KHRt6+K+LJz6eUK0Uo+CYGPLSS3E0WwGaKO1neuHl4mbOb+ghIFHwpWWNMhS
        4vRgB0sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lbswq-008u3e-GK; Wed, 28 Apr 2021 22:46:27 +0000
Date:   Wed, 28 Apr 2021 23:46:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, pakki001@umn.edu,
        gregkh@linuxfoundation.org, arnd@arndb.de
Subject: Re: [PATCH] ics932s401: fix broken handling of errors when word
 reading fails
Message-ID: <20210428224624.GD1847222@casper.infradead.org>
References: <20210428222534.GJ3122264@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428222534.GJ3122264@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 28, 2021 at 03:25:34PM -0700, Darrick J. Wong wrote:
> In commit b05ae01fdb89, someone tried to make the driver handle i2c read
> errors by simply zeroing out the register contents, but for some reason
> left unaltered the code that sets the cached register value the function
> call return value.
> 
> The original patch was authored by a member of the Underhanded
> Mangle-happy Nerds, I'm not terribly surprised.  I don't have the
> hardware anymore so I can't test this, but it seems like a pretty
> obvious API usage fix to me...

Not sure why you cc'd linux-fsdevel, but that's how i got to see it ...

> +++ b/drivers/misc/ics932s401.c
> @@ -134,7 +134,7 @@ static struct ics932s401_data *ics932s401_update_device(struct device *dev)
>  	for (i = 0; i < NUM_MIRRORED_REGS; i++) {
>  		temp = i2c_smbus_read_word_data(client, regs_to_copy[i]);
>  		if (temp < 0)
> -			data->regs[regs_to_copy[i]] = 0;
> +			temp = 0;
>  		data->regs[regs_to_copy[i]] = temp >> 8;
>  	}

Looking at a bit more context in this function, shouldn't we rather clear
'sensors_valid'?  or does it really make sense to pretend we read zero
(rather than 255) from this register?

But then we'd have to actually check sensors_valid in functions like
calculate_src_freq, and i just don't know if it's worthwhile.  Why not
just revert this patch?

