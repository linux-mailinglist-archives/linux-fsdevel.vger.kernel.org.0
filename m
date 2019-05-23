Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 756D828451
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfEWQ4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbfEWQ4J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:56:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2C72133D;
        Thu, 23 May 2019 16:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558630567;
        bh=NxEqmz70QWzEjbS+pf4ify9tPSuURZA6s5RVayaoBJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NDV86IuVu1EYXQEYNcVDDQnio+t0hmbUuHgESpY3OPxFXYasZ4OgE82w6OBV/f0nr
         faw75AZCiqvGr0QNfzIYDrbVR7ZR2N6K1qmyRIGCaJBQwS398anbj9sy1r8kVgoJuW
         l6pqQscW0wKtkQDfYv2fLxEmAw2fReHdH44jENQw=
Date:   Thu, 23 May 2019 18:56:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] soc: qcom: mdt_loader: add offset to
 request_firmware_into_buf
Message-ID: <20190523165605.GB21048@kroah.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-4-scott.branden@broadcom.com>
 <20190523055212.GA22946@kroah.com>
 <c12872f5-4dc3-9bc4-f89b-27037dc0b6ff@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12872f5-4dc3-9bc4-f89b-27037dc0b6ff@broadcom.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 09:41:49AM -0700, Scott Branden wrote:
> Hi Greg,
> 
> On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> > On Wed, May 22, 2019 at 07:51:13PM -0700, Scott Branden wrote:
> > > Adjust request_firmware_into_buf API to allow for portions
> > > of firmware file to be read into a buffer.  mdt_loader still
> > > retricts request fo whole file read into buffer.
> > > 
> > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > ---
> > >   drivers/soc/qcom/mdt_loader.c | 7 +++++--
> > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > > index 1c488024c698..ad20d159699c 100644
> > > --- a/drivers/soc/qcom/mdt_loader.c
> > > +++ b/drivers/soc/qcom/mdt_loader.c
> > > @@ -172,8 +172,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
> > >   		if (phdr->p_filesz) {
> > >   			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
> > > -			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
> > > -							ptr, phdr->p_filesz);
> > > +			ret = request_firmware_into_buf
> > > +						(&seg_fw, fw_name, dev,
> > > +						 ptr, phdr->p_filesz,
> > > +						 0,
> > > +						 KERNEL_PREAD_FLAG_WHOLE);
> > So, all that work in the first 2 patches for no real change at all?  Why
> > are these changes even needed?
> 
> The first two patches allow partial read of files into memory.
> 
> Existing kernel drivers haven't need such functionality so, yes, there
> should be no real change
> 
> with first two patches other than adding such partial file read support.
> 
> We have a new driver in development which needs partial read of files
> supported in the kernel.

As I said before, I can not take new apis without any in-kernel user.
So let's wait for your new code that thinks it needs this, and then we
will be glad to evaluate all of this at that point in time.

To do so otherwise is to have loads of unused "features" aquiring cruft
in the kernel source, and you do not want that.

> > And didn't you break this driver in patch 2/3?  You can't fix it up
> > later here, you need to also resolve that in the 2nd patch.
> 
> I thought the driver changes needs to be in a different patch. If required I
> can squash this

You can NEVER break the build with any individual kernel patch, that
should be well known by now as we have been doing this for over a
decade.

thanks,

greg k-h
