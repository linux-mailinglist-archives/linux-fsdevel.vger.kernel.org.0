Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8292632BC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 19:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKUSMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 13:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiKUSMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:12:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8E9233B6;
        Mon, 21 Nov 2022 10:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E4EE61374;
        Mon, 21 Nov 2022 18:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092D4C433D7;
        Mon, 21 Nov 2022 18:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669054360;
        bh=3hKMiUWSJlNUwha4kRCYF6DVvlsHYc9XldvHrQoGMS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev62ZYHqi31e22gyDngGK7EIfQceHN+E3DDkSWP1G3IXOBeCWfQmDmemGbtRgLukA
         PMGWLB5QgVoQQljqfoH29fsa4KLSPEWOOnpn5Aiaqd8e5vxAhXnoElRuLtbWLwGYMI
         TyhDZXlGf4swVfntlNQFIjIo5U9cdNUCbgZf9t6c=
Date:   Mon, 21 Nov 2022 19:12:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, Dov Murik <dovmurik@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell Currey <ruscur@russell.cc>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Message-ID: <Y3u/lF2wb7xWqnDO@kroah.com>
References: <Y2zLRw/TzV/sWgqO@kroah.com>
 <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
 <Y3anQukokMcQr+iE@kroah.com>
 <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
 <Y3pSF2MRIXd6aH14@kroah.com>
 <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
 <Y3tbhmL4oG1YTyT/@kroah.com>
 <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
 <Y3uT0PJ5g86TAj6t@kroah.com>
 <94fe007e8eab8bc7ae3f56b88ad94646b4673657.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94fe007e8eab8bc7ae3f56b88ad94646b4673657.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:33:55PM -0500, James Bottomley wrote:
> On Mon, 2022-11-21 at 16:05 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Nov 21, 2022 at 09:03:18AM -0500, James Bottomley wrote:
> > > On Mon, 2022-11-21 at 12:05 +0100, Greg Kroah-Hartman wrote:
> > > > On Sun, Nov 20, 2022 at 10:14:26PM -0500, James Bottomley wrote:
> [...]
> > > > > I already explained in the email that sysfs contains APIs like
> > > > > simple_pin_... which are completely inimical to namespacing.
> > > > 
> > > > Then how does the networking code handle the namespace stuff in
> > > > sysfs? That seems to work today, or am I missing something?
> > > 
> > > have you actually tried?
> > > 
> > > jejb@lingrow:~> sudo unshare --net bash
> > > lingrow:/home/jejb # ls /sys/class/net/
> > > lo  tun0  tun10  wlan0
> > > lingrow:/home/jejb # ip link show
> > > 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT
> > > group
> > > default qlen 1000
> > >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> > > 
> > > So, as you see, I've entered a network namespace and ip link shows
> > > me the only interface I can see in that namespace (a down loopback)
> > > but sysfs shows me every interface on the system outside the
> > > namespace.
> > 
> > Then all of the code in include/kobject_ns.h is not being used?  We
> > have a whole kobject namespace set up for networking, I just assumed
> > they were using it.  If not, I'm all for ripping it out.
> 
> Hm, looking at the implementation, it seems to trigger off the
> superblock (meaning you have to remount inside a mount namespace) and
> it only works to control visibility in label based namespaces, so this
> does actually work
> 
> jejb@lingrow:~/git/linux> sudo unshare  --net --mount bash 
> lingrow:/home/jejb # mount -t sysfs none /sys
> lingrow:/home/jejb # ls /sys/class/net/
> lo
> 
> The label based approach means that any given file can be shown in one
> and only one namespace, which works for net, but not much else
> (although it probably could be adapted).

Great, thanks for verifying it works properly.

No other subsystem other than networking has cared about adding support
for namespaces to their sysfs representations.  But the base logic is
all there if they want to do so.

thanks,

greg k-h
