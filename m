Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E301D0900
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgEMGut (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgEMGut (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:50:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339AE20708;
        Wed, 13 May 2020 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589352648;
        bh=wim/3pCx9DK4B0YG8gKaM83yFjabLaHMvWcVqY4/4HQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABPoje9RFWk8hFzzmHAuKhl2ETW1ZOzLN1lmp1u6iBwSFTi8c0KiQ6PqL0bW4fFIA
         oW5IRrwXAdQpO8nZL9Jbm7qRwzkiebxybVvfJzwAs4NoIX8w+gQDegVnPcHezm6Fpl
         Xn5dSBmjsdYeM5Qsj81AZX1ItVRy8TV3dsF9DIlI=
Date:   Wed, 13 May 2020 08:50:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v5 6/7] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200513065046.GA764247@kroah.com>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-7-scott.branden@broadcom.com>
 <20200513003830.GJ11244@42.do-not-panic.com>
 <60372b2f-c03d-6384-43a7-8b97413b6672@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60372b2f-c03d-6384-43a7-8b97413b6672@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 11:31:28PM -0700, Scott Branden wrote:
> Hi Luis,
> 
> On 2020-05-12 5:38 p.m., Luis Chamberlain wrote:
> > On Thu, May 07, 2020 at 05:27:38PM -0700, Scott Branden wrote:
> > > +#if defined(CONFIG_REQ_FW_INTO_BUF_PRIV)
> > > +
> > > +#define KERNEL_PREAD_FLAG_PART	0x0001 /* Allow reading part of file */
> > > +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf_priv
> > > +int request_firmware_into_buf_priv(const struct firmware **firmware_p,
> > > +				   const char *name, struct device *device,
> > > +				   void *buf, size_t size,
> > > +				   size_t offset, unsigned int pread_flags);
> > > +
> > > +#else
> > > +
> > > +#define REQUEST_FIRMWARE_INTO_BUF request_firmware_into_buf
> > > +
> > > +#endif
> > > +
> > > +#endif
> > Please clean this up, the code must reflect only the code upstream. No
> > config stuff like this should be used on the driver. I had to stop my
> > review here.
> The CONFIG_ prefix shouldn't have been there as there is no Kconfig option
> to select this.
> Would like to just change it to a normal define without CONFIG_ prefix
> instead?
> This code is here to allow a limited version of the driver to run on older
> kernels which do not have the necessary partial file read support.
> By having it in the upstream codebase we don't need to maintain an internal
> version of the driver.  User can take the upstream kernel module and compile
> it against an old version of the kernel by via the define.

That's not how kernel drivers in the tree work, sorry.  They do not
contain "older kernel support" in them, they work as a whole with the
rest of the kernel they ship with only.

Otherwise all drivers would be a total mess over time, can you imagine
doing this for the next 20+ years?  Not maintainable.

thanks,

greg k-h
