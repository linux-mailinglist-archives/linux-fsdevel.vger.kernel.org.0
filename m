Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0ABD7E142
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2019 19:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfHARmT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 13:42:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44239 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbfHARmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:42:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so34451668pfe.11;
        Thu, 01 Aug 2019 10:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c2hESp5P0VdXb1KGHmHBHOL26umzSRk5VuA6OOFxtVM=;
        b=fUiMNYiNxQbaJUKktacnDTuosoG403NWOfF1HoQSSVDbV0vtoPNVsxlMGoS8c+Ka1x
         FyJqtwGWRA6wAHk4Pux8DTGUsiZk/YwnZNFqPdPKWd/IbLDLog5rA6RyQ2cMw6mdqoMe
         Jkd2dJ/KQz3ZAylI1np91LamwLuI2qAHck1QaWVpPvL0slIoSGXEgc3ta/61GpkU2oem
         eEXgctyQnlhJThZ4qWaihUQqPR5uGdiOUtu1wnjcz1tThKZzGNPgIngtimOLylL8yI4a
         4Fk2QKc3xr7IvlJdIqifNbMLOQLrQpP1rzu54TUJtkhEiZ4Gwu3L5es+bqO+vAGAanyW
         HDLQ==
X-Gm-Message-State: APjAAAUxA+sxzCdOhwJLUxGAJHWMJOIJj+vQWg86NXsbwB7+Ael/522i
        M7W4kciQyukLBdJofRoAHfM=
X-Google-Smtp-Source: APXvYqwvXu3G8nVpXIkNxWN9ELmjM1cWN+Tl1xKF06uVZBAUb2aBahH/zXWAt3NRyzyefm9aQ216BA==
X-Received: by 2002:a62:e901:: with SMTP id j1mr55881964pfh.189.1564681338080;
        Thu, 01 Aug 2019 10:42:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j6sm63680898pfa.141.2019.08.01.10.42.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:42:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 07BF440280; Thu,  1 Aug 2019 17:42:15 +0000 (UTC)
Date:   Thu, 1 Aug 2019 17:42:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
Message-ID: <20190801174215.GB16384@42.do-not-panic.com>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-3-scott.branden@broadcom.com>
 <20190523055233.GB22946@kroah.com>
 <15c47e4d-e70d-26bb-9747-0ad0aa81597b@broadcom.com>
 <20190523165424.GA21048@kroah.com>
 <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
 <20190524052258.GB28229@kroah.com>
 <2f67db0a-27c3-d13c-bbe0-0af5edd4f0da@broadcom.com>
 <20190801061801.GA4338@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190801061801.GA4338@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 08:18:01AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2019 at 05:18:32PM -0700, Scott Branden wrote:
> > Hi Greg,
> > 
> > I am now back from leave to continue this patch.  Comment below.
> > 
> > On 2019-05-23 10:22 p.m., Greg Kroah-Hartman wrote:
> > > On Thu, May 23, 2019 at 10:01:38PM -0700, Scott Branden wrote:
> > > > On 2019-05-23 9:54 a.m., Greg Kroah-Hartman wrote:
> > > > > On Thu, May 23, 2019 at 09:36:02AM -0700, Scott Branden wrote:
> > > > > > Hi Greg,
> > > > > > 
> > > > > > On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> > > > > > > On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
> > > > > > > > Add offset to request_firmware_into_buf to allow for portions
> > > > > > > > of firmware file to be read into a buffer.  Necessary where firmware
> > > > > > > > needs to be loaded in portions from file in memory constrained systems.
> > > > > > > > 
> > > > > > > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > > > > > > ---
> > > > > > > >     drivers/base/firmware_loader/firmware.h |  5 +++
> > > > > > > >     drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
> > > > > > > >     include/linux/firmware.h                |  8 +++-
> > > > > > > >     3 files changed, 45 insertions(+), 17 deletions(-)
> > > > > > > No new firmware test for this new option?  How do we know it even works?
> > > > > > I was unaware there are existing firmware tests.  Please let me know where
> > > > > > these tests exists and I can add a test for this new option.
> > > > > tools/testing/selftests/firmware/
> > > > Unfortunately, there doesn't seem to be a test for the existing
> > > > request_firmware_into_buf api.
> > > Are you sure?  The test is for userspace functionality, there isn't
> > > kernel unit tests here.  You need to verify that you didn't break
> > > existing functionality as well as verify that your new functionality
> > > works.
> > 
> > I managed to figure out how to build and run
> > tools/testing/selftest/firmware/fw_run_tests.sh
> > 
> > and my changes don't break existing functionality.

I'm soon going to release something that is going to let you do this 
faster and easier, let me know if you had troubles in trying to figure
out how to not regress the kernel using this.

> > But, I find no use of request_firmware_into_buf in lib/test_firmware.c
> > (triggered by fw_run_tests.sh).
> > 
> > Is there another test for request_firmware_into_buf?
> 
> I have no idea, sorry.

The folks who implemented request_firmware_into_buf() didn't add a
respective test, because, well, this API went upstream IMO without much
ACKs / review, and even no damn users. Now we have a user so we're stuck
with it.

So new testing calls for it would be appreciated. If you have questions
I am happy to help.

  Luis
