Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C23E193288
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 22:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCYVUw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 17:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbgCYVUv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:20:51 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B2C20719;
        Wed, 25 Mar 2020 21:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585171250;
        bh=5lTuaENgwe+jO4ZXbV3h/ksO3A+z4mLrxl48bAkXc/8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UuS66/kG5mkaUy0bO6ayqwJMAo9AR2uq3vqcnjv8Y+HgcqJM4627esOHHzOuwCvZ1
         Gf3x8hT6p29vCTnWTLlx0FDdUrKAXhRcf3RDzONzKo46fRpejoJXscwJ9VP04FN0z1
         ZVh/jsQVS2DqReiuMzEacuwL7B+3o2RJEjauJpa8=
Date:   Wed, 25 Mar 2020 16:20:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        linux-pci <linux-pci@vger.kernel.org>
Subject: Re: mmotm 2020-03-23-21-29 uploaded
 (pci/controller/dwc/pcie-tegra194.c)
Message-ID: <20200325212048.GA72586@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200325170122.GA29504@red-moon.cambridge.arm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:01:43PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Mar 25, 2020 at 08:43:32PM +0530, Vidya Sagar wrote:
> > On 3/24/2020 9:48 PM, Bjorn Helgaas wrote:
> > > On Tue, Mar 24, 2020 at 08:16:34AM -0700, Randy Dunlap wrote:
> > > > On 3/23/20 9:30 PM, akpm@linux-foundation.org wrote:
> > > > > The mm-of-the-moment snapshot 2020-03-23-21-29 has been uploaded to
> > > > > 
> > > > >     http://www.ozlabs.org/~akpm/mmotm/
> > > > > 
> > > > > mmotm-readme.txt says
> > > > > 
> > > > > README for mm-of-the-moment:
> > > > > 
> > > > > http://www.ozlabs.org/~akpm/mmotm/
> > > > > 
> > > > > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > > > > more than once a week.
> > > > > 
> > > > > You will need quilt to apply these patches to the latest Linus release (5.x
> > > > > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > > > > http://ozlabs.org/~akpm/mmotm/series
> > > > 
> > > > 
> > > > on x86_64:
> > > > 
> > > > ../drivers/pci/controller/dwc/pcie-tegra194.c: In function ‘tegra_pcie_dw_parse_dt’:
> > > > ../drivers/pci/controller/dwc/pcie-tegra194.c:1160:24: error: implicit declaration of function ‘devm_gpiod_get’; did you mean ‘devm_phy_get’? [-Werror=implicit-function-declaration]
> > > >    pcie->pex_rst_gpiod = devm_gpiod_get(pcie->dev, "reset", GPIOD_IN);
> > > >                          ^~~~~~~~~~~~~~
> > > >                          devm_phy_get
> > > 
> > > Thanks a lot for the report!
> > > 
> > > This was found on mmotm, but I updated my -next branch with Lorenzo's
> > > latest pci/endpoint branch (current head 775d9e68f470) and reproduced
> > > this build failure with the .config you attached.
> > > 
> > > I dropped that branch from my -next branch for now and pushed it.
> > I found that one header file inclusion is missing.
> > The following patch fixes it.
> > Also, I wanted to know how can I catch this locally? i.e. How can I
> > generate the config file attached by Randy locally so that I can get the
> > source ready without these kind of issues?

Randy attached the config-r1578 file to his initial report.  I saved
that attachment, then:

  $ git checkout next
  $ make mrproper
  $ cp ~/Downloads/config-r1578 .config
  $ make drivers/pci/controller/

> > Bjorn/Lorenzo, would you be able to apply below change in your trees or
> > do I need to send a patch for this?
> 
> Squashed in and re-pushed out pci/endpoint, it should have fixed this
> issue.

I updated my -next branch with this, thanks!

Bjorn
