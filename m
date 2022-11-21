Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78ED632780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 16:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiKUPMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 10:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiKUPL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:11:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB3194A4E;
        Mon, 21 Nov 2022 07:05:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A6D4B81050;
        Mon, 21 Nov 2022 15:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4A6C433D6;
        Mon, 21 Nov 2022 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669043155;
        bh=69fnffLkz/ILK6bYr21czslsgeqwii9nzQ1KmDeEAF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgEmmbjYMxg528j5wuwTzPboE9RBUDUwjIV2gNsrOBwiIFh7KjwAVpFzD9dRUycw6
         LGvn+xCfvrRYuDHNEFnQENBJpbGO6vP97nFlevknNth7LVb7SLaAmUZl7BdwzraGNC
         hZmKPSHWuadxhFWfGEsvQJpgTCv4levVp/MeYLcA=
Date:   Mon, 21 Nov 2022 16:05:52 +0100
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
Message-ID: <Y3uT0PJ5g86TAj6t@kroah.com>
References: <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <Y2zLRw/TzV/sWgqO@kroah.com>
 <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
 <Y3anQukokMcQr+iE@kroah.com>
 <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
 <Y3pSF2MRIXd6aH14@kroah.com>
 <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
 <Y3tbhmL4oG1YTyT/@kroah.com>
 <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 21, 2022 at 09:03:18AM -0500, James Bottomley wrote:
> On Mon, 2022-11-21 at 12:05 +0100, Greg Kroah-Hartman wrote:
> > On Sun, Nov 20, 2022 at 10:14:26PM -0500, James Bottomley wrote:
> > > On Sun, 2022-11-20 at 17:13 +0100, Greg Kroah-Hartman wrote:
> > > > On Sat, Nov 19, 2022 at 01:20:09AM -0500, Nayna wrote:
> > > > > 
> > > > > On 11/17/22 16:27, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Nov 14, 2022 at 06:03:43PM -0500, Nayna wrote:
> > > > > > > On 11/10/22 04:58, Greg Kroah-Hartman wrote:
> > > [...]
> > > > > > > > I do not understand, sorry.  What does namespaces have to
> > > > > > > > do
> > > > > > > > with this?
> > > > > > > > sysfs can already handle namespaces just fine, why not
> > > > > > > > use
> > > > > > > > that?
> > > > > > > Firmware objects are not namespaced. I mentioned it here as
> > > > > > > an
> > > > > > > example of the difference between firmware and kernel
> > > > > > > objects.
> > > > > > > It is also in response to the feedback from James Bottomley
> > > > > > > in
> > > > > > > RFC v2 [
> > > > > > > https://lore.kernel.org/linuxppc-dev/41ca51e8db9907d9060cc38ad
> > > > > > > b59a66dcae4c59b.camel@HansenPartnership.com/].
> > > > > > I do not understand, sorry.  Do you want to use a namespace
> > > > > > for
> > > > > > these or not?  The code does not seem to be using
> > > > > > namespaces. 
> > > > > > You can use sysfs with, or without, a namespace so I don't
> > > > > > understand the issue here.
> > > > > > 
> > > > > > With your code, there is no namespace.
> > > > > 
> > > > > You are correct. There's no namespace for these.
> > > > 
> > > > So again, I do not understand.  Do you want to use filesystem
> > > > namespaces, or do you not?
> > > 
> > > Since this seems to go back to my email quoted again, let me
> > > repeat: the question isn't if this patch is namespaced; I think
> > > you've agreed several times it isn't.  The question is if the
> > > exposed properties would ever need to be namespaced.  This is a
> > > subtle and complex question which isn't at all explored by the
> > > above interchange.
> > > 
> > > > How again can you not use sysfs or securityfs due to namespaces? 
> > > > What is missing?
> > > 
> > > I already explained in the email that sysfs contains APIs like
> > > simple_pin_... which are completely inimical to namespacing.
> > 
> > Then how does the networking code handle the namespace stuff in
> > sysfs?
> > That seems to work today, or am I missing something?
> 
> have you actually tried?
> 
> jejb@lingrow:~> sudo unshare --net bash
> lingrow:/home/jejb # ls /sys/class/net/
> lo  tun0  tun10  wlan0
> lingrow:/home/jejb # ip link show
> 1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group
> default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 
> So, as you see, I've entered a network namespace and ip link shows me
> the only interface I can see in that namespace (a down loopback) but
> sysfs shows me every interface on the system outside the namespace.

Then all of the code in include/kobject_ns.h is not being used?  We have
a whole kobject namespace set up for networking, I just assumed they
were using it.  If not, I'm all for ripping it out.

thanks,

greg k-h
