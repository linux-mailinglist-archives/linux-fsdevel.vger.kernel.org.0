Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73246156B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 01:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKBApX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 20:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiKBApK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 20:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D791AD81;
        Tue,  1 Nov 2022 17:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7308761789;
        Wed,  2 Nov 2022 00:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F6DC433C1;
        Wed,  2 Nov 2022 00:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667349907;
        bh=4e3rycQUwb33zwwCwGW0m1UPZ5kIn2EC65KtL6U4wZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmjO3y2sm11ONmRank57zkDzKxO01q8BE9hXRvTd4jmFX2RW4+S9ZqmnzxKVm4cUN
         YJDYCav7pb8K+u8cxR+wOpnii7Skg5QwZh4NjV7qj1tR0QAuFXnSOHNeEf6XMzKfO6
         4jlQcoWESNFvzonFw2Vi1pQpjXOhVsP0NQYuHQ1R5MikRCAPcfUTiK1+HaKz2gwHpk
         9KA7rLIcasZ0aFUIucXvwXTJou+nCwHBPU+pIfYebvu8bqz/0d8xQ9b/bHyfEHjPcZ
         KZk10R2cwjEb/8GveeF3ZIEfTLygDy5jKs4DnHrPiel4CHrbe6avRseEv5YJqzXNFJ
         aCoR+q353l9TQ==
Date:   Tue, 1 Nov 2022 17:45:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <Y2G9k9/XJVQ7yiWN@magnolia>
References: <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
 <20221023220018.GX3600936@dread.disaster.area>
 <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20221024053109.GY3600936@dread.disaster.area>
 <dd00529c-d3ef-40e3-9dea-834c5203e3df@fujitsu.com>
 <Y1gjQ4wNZr3ve2+K@magnolia>
 <Y1rzZN0wgLcie47z@magnolia>
 <635b325d25889_6be129446@dwillia2-xfh.jf.intel.com.notmuch>
 <7a3aac47-1492-a3cc-c53a-53c908f4f857@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a3aac47-1492-a3cc-c53a-53c908f4f857@fujitsu.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 30, 2022 at 05:31:43PM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2022/10/28 9:37, Dan Williams 写道:
> > Darrick J. Wong wrote:
> > > [add tytso to cc since he asked about "How do you actually /get/ fsdax
> > > mode these days?" this morning]
> > > 
> > > On Tue, Oct 25, 2022 at 10:56:19AM -0700, Darrick J. Wong wrote:
> > > > On Tue, Oct 25, 2022 at 02:26:50PM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> ...skip...
> 
> > > > 
> > > > Nope.  Since the announcement of pmem as a product, I have had 15
> > > > minutes of acces to one preproduction prototype server with actual
> > > > optane DIMMs in them.
> > > > 
> > > > I have /never/ had access to real hardware to test any of this, so it's
> > > > all configured via libvirt to simulate pmem in qemu:
> > > > https://lore.kernel.org/linux-xfs/YzXsavOWMSuwTBEC@magnolia/
> > > > 
> > > > /run/mtrdisk/[gh].mem are both regular files on a tmpfs filesystem:
> > > > 
> > > > $ grep mtrdisk /proc/mounts
> > > > none /run/mtrdisk tmpfs rw,relatime,size=82894848k,inode64 0 0
> > > > 
> > > > $ ls -la /run/mtrdisk/[gh].mem
> > > > -rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 18:09 /run/mtrdisk/g.mem
> > > > -rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 19:28 /run/mtrdisk/h.mem
> > > 
> > > Also forgot to mention that the VM with the fake pmem attached has a
> > > script to do:
> > > 
> > > ndctl create-namespace --mode fsdax --map dev -e namespace0.0 -f
> > > ndctl create-namespace --mode fsdax --map dev -e namespace1.0 -f
> > > 
> > > Every time the pmem device gets recreated, because apparently that's the
> > > only way to get S_DAX mode nowadays?
> > 
> > If you have noticed a change here it is due to VM configuration not
> > anything in the driver.
> > 
> > If you are interested there are two ways to get pmem declared the legacy
> > way that predates any of the DAX work, the kernel calls it E820_PRAM,
> > and the modern way by platform firmware tables like ACPI NFIT. The
> > assumption with E820_PRAM is that it is dealing with battery backed
> > NVDIMMs of small capacity. In that case the /dev/pmem device can support
> > DAX operation by default because the necessary memory for the 'struct
> > page' array for that memory is likely small.
> > 
> > Platform firmware defined PMEM can be terabytes. So the driver does not
> > enable DAX by default because the user needs to make policy choice about
> > burning gigabytes of DRAM for that metadata, or placing it in PMEM which
> > is abundant, but slower. So what I suspect might be happening is your
> > configuration changed from something that auto-allocated the 'struct
> > page' array, to something that needed those commands you list above to
> > explicitly opt-in to reserving some PMEM capacity for the page metadata.
> 
> I am using the same simulation environment as Darrick's and Dave's and have
> tested many times, but still cannot reproduce the failed cases they
> mentioned (dax+non_reflink mode, currently focuing) until now. Only a few
> cases randomly failed because of "target is busy". But IIRC, those failed
> cases you mentioned were failed with dmesg warning around the function
> "dax_associate_entry()" or "dax_disassociate_entry()". Since I cannot
> reproduce the failure, it hard for me to continue sovling the problem.

FWIW things have calmed down as of 6.1-rc3 -- if I disable reflink,
fstests runs without complaint.  Now it only seems to be affecting
reflink=1 filesystems.

> And how is your recent test?  Still failed with those dmesg warnings? If so,
> could you zip the test result and send it to me?

https://djwong.org/docs/kernel/daxbad.zip

--D

> 
> 
> --
> Thanks,
> Ruan
