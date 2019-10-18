Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F300DC561
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2019 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634036AbfJRMtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 08:49:16 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:57916 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634008AbfJRMtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:49:15 -0400
Received: from [167.98.27.226] (helo=xylophone)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iLRgs-0001mQ-3j; Fri, 18 Oct 2019 13:49:10 +0100
Message-ID: <1984049ff0e359801401fbbcbdbc21ee0a64c1a9.camel@codethink.co.uk>
Subject: Re: [Y2038] [PATCH v6 31/43] compat_ioctl: move WDIOC handling into
 wdt drivers
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Date:   Fri, 18 Oct 2019 13:49:09 +0100
In-Reply-To: <20191009191044.308087-32-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
         <20191009191044.308087-32-arnd@arndb.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2019-10-09 at 21:10 +0200, Arnd Bergmann wrote:
> All watchdog drivers implement the same set of ioctl commands, and
> fortunately all of them are compatible between 32-bit and 64-bit
> architectures.
> 
> Modern drivers always go through drivers/watchdog/wdt.c as an abstraction
> layer, but older ones implement their own file_operations on a character
> device for this.
> 
> Move the handling from fs/compat_ioctl.c into the individual drivers.
> 
> Note that most of the legacy drivers will never be used on 64-bit
> hardware, because they are for an old 32-bit SoC implementation, but
> doing them all at once is safer than trying to guess which ones do
> or do not need the compat_ioctl handling.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_gpt.c |  1 +
>  arch/um/drivers/harddog_kern.c            |  1 +
>  drivers/char/ipmi/ipmi_watchdog.c         |  1 +
>  drivers/hwmon/fschmd.c                    |  1 +
>  drivers/rtc/rtc-ds1374.c                  |  1 +
[...]

It Looks like you missed a couple:

drivers/rtc/rtc-m41t80.c
drivers/watchdog/kempld_wdt.c

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

