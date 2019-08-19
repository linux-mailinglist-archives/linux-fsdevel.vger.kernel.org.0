Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57890950B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 00:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfHSWWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 18:22:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44069 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbfHSWWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:22:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id c81so2013210pfc.11;
        Mon, 19 Aug 2019 15:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+1PDFzdbe/CicguML20QQINdH2qcnon9SYzPrR+XYSY=;
        b=jswEv1TugrN5lZJDigkV7Pz3cZaWvPsORERCOw9gwJd8aed9bHPWu4w7N/SRdB0nyO
         U9j/JHHulpCUvPCxItylYWOmQLQeBbc4qcIZyywLWRn4KJjk5t/gE+NjRh/UsLfSUUNn
         taQ1reKg0YHFMheI1v00cf9AgRzN9NJtHHLkuZj2CMIZiktJtaMxxIgo4E0uGtgD/0x/
         Dt9sgjeFZbVf7GfQbm6IjHILBfi7V8IygFAj8Sthvwq9OGBkZQ+97eJDFlwsN5yadxab
         0Cl4S7nOBmDykF7qKOpjL9VRBqq5z0QiEvNzh3OrRZOzr+j60chooCPXyzGKhwlnwY7U
         is9Q==
X-Gm-Message-State: APjAAAUlA2amumVjV4SPh7xMDnvAkc9vL4o0jbQxgGDrR8LHPB7v5UPy
        wVXFaOI1dwmb9dbd6Kd0Mo4=
X-Google-Smtp-Source: APXvYqzbW3eKMqXrYkNHJkzxIWyPBhhjc7UT7MB7GUnkG+87ImwTQ6A+SwcjFkchT7xpyzPR8oA/Sw==
X-Received: by 2002:a17:90a:cb89:: with SMTP id a9mr22871575pju.93.1566253365557;
        Mon, 19 Aug 2019 15:22:45 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e13sm18775233pff.181.2019.08.19.15.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 15:22:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 98891402D7; Mon, 19 Aug 2019 22:22:42 +0000 (UTC)
Date:   Mon, 19 Aug 2019 22:22:42 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] firmware: add offset to request_firmware_into_buf
Message-ID: <20190819222242.GT16384@42.do-not-panic.com>
References: <20190523025113.4605-3-scott.branden@broadcom.com>
 <20190523055233.GB22946@kroah.com>
 <15c47e4d-e70d-26bb-9747-0ad0aa81597b@broadcom.com>
 <20190523165424.GA21048@kroah.com>
 <44282070-ddaf-3afb-9bdc-4751e3f197ac@broadcom.com>
 <20190524052258.GB28229@kroah.com>
 <2f67db0a-27c3-d13c-bbe0-0af5edd4f0da@broadcom.com>
 <20190801061801.GA4338@kroah.com>
 <20190801174215.GB16384@42.do-not-panic.com>
 <74be1aa7-0e10-51dc-bbbf-94bb5f4bf7c4@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74be1aa7-0e10-51dc-bbbf-94bb5f4bf7c4@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:15:19AM -0700, Scott Branden wrote:
> Hi Luis,
> 
> On 2019-08-01 10:42 a.m., Luis Chamberlain wrote:
> > On Thu, Aug 01, 2019 at 08:18:01AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jul 31, 2019 at 05:18:32PM -0700, Scott Branden wrote:
> > > > Hi Greg,
> > > > 
> > > > I am now back from leave to continue this patch.  Comment below.
> > > > 
> > > > On 2019-05-23 10:22 p.m., Greg Kroah-Hartman wrote:
> > > > > On Thu, May 23, 2019 at 10:01:38PM -0700, Scott Branden wrote:
> > > > > > On 2019-05-23 9:54 a.m., Greg Kroah-Hartman wrote:
> > > > > > > On Thu, May 23, 2019 at 09:36:02AM -0700, Scott Branden wrote:
> > > > > > > > Hi Greg,
> > > > > > > > 
> > > > > > > > On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> > > > > > > > > On Wed, May 22, 2019 at 07:51:12PM -0700, Scott Branden wrote:
> > > > > > > > > > Add offset to request_firmware_into_buf to allow for portions
> > > > > > > > > > of firmware file to be read into a buffer.  Necessary where firmware
> > > > > > > > > > needs to be loaded in portions from file in memory constrained systems.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > > > > > > > > ---
> > > > > > > > > >      drivers/base/firmware_loader/firmware.h |  5 +++
> > > > > > > > > >      drivers/base/firmware_loader/main.c     | 49 +++++++++++++++++--------
> > > > > > > > > >      include/linux/firmware.h                |  8 +++-
> > > > > > > > > >      3 files changed, 45 insertions(+), 17 deletions(-)
> > > > > > > > > No new firmware test for this new option?  How do we know it even works?
> > > > > > > > I was unaware there are existing firmware tests.  Please let me know where
> > > > > > > > these tests exists and I can add a test for this new option.
> > > > > > > tools/testing/selftests/firmware/
> > > > > > Unfortunately, there doesn't seem to be a test for the existing
> > > > > > request_firmware_into_buf api.
> > > > > Are you sure?  The test is for userspace functionality, there isn't
> > > > > kernel unit tests here.  You need to verify that you didn't break
> > > > > existing functionality as well as verify that your new functionality
> > > > > works.
> > > > I managed to figure out how to build and run
> > > > tools/testing/selftest/firmware/fw_run_tests.sh
> > > > 
> > > > and my changes don't break existing functionality.
> > I'm soon going to release something that is going to let you do this
> > faster and easier, let me know if you had troubles in trying to figure
> > out how to not regress the kernel using this.
> 
> Yes, I had troubles in trying to figure it out.  The kernel build should
> 
> create an entire initrd with all the necessary components in it for testing
> purposes.
> 
> And the firmware test will now take me some time to figure out how it all
> works.
> 
> Could you please explain what you are going to release soon?  I don't want
> to waste

Sorry for the delay but I promise that I tried hard to get this out ASAP.

https://github.com/mcgrof/fw-kdevops

This now can be used to more easily let you start an environment to
test the firmware API.

Too late for you I gather, but perhaps others can take advantage.

  Luis
