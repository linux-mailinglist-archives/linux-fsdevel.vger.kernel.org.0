Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFD192EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 18:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYRCB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 13:02:01 -0400
Received: from foss.arm.com ([217.140.110.172]:51002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgCYRCB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:02:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AEE21FB;
        Wed, 25 Mar 2020 10:02:00 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.20.165])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E8223F52E;
        Wed, 25 Mar 2020 10:01:58 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:01:43 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
Message-ID: <20200325170122.GA29504@red-moon.cambridge.arm.com>
References: <20200324161851.GA2300@google.com>
 <eb101f02-c893-e16e-0f3f-151aac223205@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb101f02-c893-e16e-0f3f-151aac223205@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 08:43:32PM +0530, Vidya Sagar wrote:
> 
> 
> On 3/24/2020 9:48 PM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Tue, Mar 24, 2020 at 08:16:34AM -0700, Randy Dunlap wrote:
> > > On 3/23/20 9:30 PM, akpm@linux-foundation.org wrote:
> > > > The mm-of-the-moment snapshot 2020-03-23-21-29 has been uploaded to
> > > > 
> > > >     http://www.ozlabs.org/~akpm/mmotm/
> > > > 
> > > > mmotm-readme.txt says
> > > > 
> > > > README for mm-of-the-moment:
> > > > 
> > > > http://www.ozlabs.org/~akpm/mmotm/
> > > > 
> > > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > > more than once a week.
> > > > 
> > > > You will need quilt to apply these patches to the latest Linus release (5.x
> > > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > > http://ozlabs.org/~akpm/mmotm/series
> > > 
> > > 
> > > on x86_64:
> > > 
> > > ../drivers/pci/controller/dwc/pcie-tegra194.c: In function ‘tegra_pcie_dw_parse_dt’:
> > > ../drivers/pci/controller/dwc/pcie-tegra194.c:1160:24: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_phy_get’? [-Werror=implicit-function-declaration]
> > >    pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
> > >                          ^~~~~~~~~~~~~~
> > >                          devm_phy_get
> > 
> > Thanks a lot for the report!
> > 
> > This was found on mmotm, but I updated my -next branch with Lorenzo's
> > latest pci/endpoint branch (current head 775d9e68f470) and reproduced
> > this build failure with the .config you attached.
> > 
> > I dropped that branch from my -next branch for now and pushed it.
> I found that one header file inclusion is missing.
> The following patch fixes it.
> Also, I wanted to know how can I catch this locally? i.e. How can I
> generate the config file attached by Randy locally so that I can get the
> source ready without these kind of issues?
> 
> Bjorn/Lorenzo, would you be able to apply below change in your trees or
> do I need to send a patch for this?

Squashed in and re-pushed out pci/endpoint, it should have fixed this
issue.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c
> b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 97d3f3db1020..eeeca18892c6 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -11,6 +11,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/kernel.h>
> 
> 
> > 
> > Bjorn
> > 
