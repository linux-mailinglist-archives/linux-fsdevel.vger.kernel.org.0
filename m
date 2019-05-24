Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88129054
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 07:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbfEXFXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 01:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfEXFXD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 01:23:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 205E12175B;
        Fri, 24 May 2019 05:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558675381;
        bh=f82AkJp+40WX2NnbIN+0SDdISJuq17jnjJEWcou+ku8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RNSdo2mEGNLVWgg8saywtySjugfajliIhGqv3WPyH33AcK/NKbmqAa+AwRjmqfn+n
         TbJulVvkoz+hrBYbspr6pP0xhNQEffiOCCd1h2S7LfzIKd8Qjs7sxoBwGJ/FgKXldB
         P1bZb984H136y+/GMCXbmx+36V99RUNmbtlunPuc=
Date:   Fri, 24 May 2019 07:22:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
Message-ID: <20190524052258.GB28229@kroah.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-3-scott.branden@broadcom.com>
 <20190523055233.GB22946@kroah.com>
 <15c47e4d-e70d-26bb-9747-0ad0aa81597b@broadcom.com>
 <20190523165424.GA21048@kroah.com>
 <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 10:01:38PM -0700, Scott Branden wrote:
> 
> On 2019-05-23 9:54 a.m., Greg Kroah-Hartman wrote:
> > On Thu, May 23, 2019 at 09:36:02AM -0700, Scott Branden wrote:
> > > Hi Greg,
> > > 
> > > On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> > > > On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
> > > > > Add offset to request_firmware_into_buf to allow for portions
> > > > > of firmware file to be read into a buffer.  Necessary where firmware
> > > > > needs to be loaded in portions from file in memory constrained systems.
> > > > > 
> > > > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > > > ---
> > > > >    drivers/base/firmware_loader/firmware.h |  5 +++
> > > > >    drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
> > > > >    include/linux/firmware.h                |  8 +++-
> > > > >    3 files changed, 45 insertions(+), 17 deletions(-)
> > > > No new firmware test for this new option?  How do we know it even works?
> > > I was unaware there are existing firmware tests.  Please let me know where
> > > these tests exists and I can add a test for this new option.
> > tools/testing/selftests/firmware/
> 
> Unfortunately, there doesn't seem to be a test for the existing
> request_firmware_into_buf api.

Are you sure?  The test is for userspace functionality, there isn't
kernel unit tests here.  You need to verify that you didn't break
existing functionality as well as verify that your new functionality
works.

> > > We have tested this with a new driver in development which requires the
> > > firmware file to be read in portions into memory.  I can add my tested-by
> > > and others to the commit message if desired.
> > I can't take new apis without an in-kernel user, you all know this...
> 
> OK, It will have to wait then as I was hoping to get this in before my
> leave.

Throwing new code over the wall and running away is a sure way to ensure
that your code will be ignored :)

thanks,

greg k-h
