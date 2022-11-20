Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B684631528
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Nov 2022 17:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiKTQXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Nov 2022 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTQXu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:23:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF752DDB;
        Sun, 20 Nov 2022 08:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73C9160C83;
        Sun, 20 Nov 2022 16:23:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CF3C433D6;
        Sun, 20 Nov 2022 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668961427;
        bh=VEJFrHA3qn6Rwg4Teu5pGnSV2TQDYMG+LACbP7i1H4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIVe/EjLxTjJRpEYUbRy4/jlY4n20uQ/Ks7yVzv7byfrCKj1SxALQR5AviL9TGWNM
         Qs7NhTH5XJ2DOcNN2yPVnkMXYA8Cem1IjKH1LO9B0FogH8mclb99sNBwl9YMjAiikX
         ZIjmCDCv4H78R91ZVIeWE4TauaBx9CA+FR0cv9jg=
Date:   Sun, 20 Nov 2022 17:13:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
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
Message-ID: <Y3pSF2MRIXd6aH14@kroah.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com>
 <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <Y2zLRw/TzV/sWgqO@kroah.com>
 <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
 <Y3anQukokMcQr+iE@kroah.com>
 <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 19, 2022 at 01:20:09AM -0500, Nayna wrote:
> 
> On 11/17/22 16:27, Greg Kroah-Hartman wrote:
> > On Mon, Nov 14, 2022 at 06:03:43PM -0500, Nayna wrote:
> > > On 11/10/22 04:58, Greg Kroah-Hartman wrote:
> > > > On Wed, Nov 09, 2022 at 03:10:37PM -0500, Nayna wrote:
> > > > > On 11/9/22 08:46, Greg Kroah-Hartman wrote:
> > > > > > On Sun, Nov 06, 2022 at 04:07:42PM -0500, Nayna Jain wrote:
> > > > > > > securityfs is meant for Linux security subsystems to expose policies/logs
> > > > > > > or any other information. However, there are various firmware security
> > > > > > > features which expose their variables for user management via the kernel.
> > > > > > > There is currently no single place to expose these variables. Different
> > > > > > > platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
> > > > > > > interface as they find it appropriate. Thus, there is a gap in kernel
> > > > > > > interfaces to expose variables for security features.
> > > > > > > 
> > > > > > > Define a firmware security filesystem (fwsecurityfs) to be used by
> > > > > > > security features enabled by the firmware. These variables are platform
> > > > > > > specific. This filesystem provides platforms a way to implement their
> > > > > > >     own underlying semantics by defining own inode and file operations.
> > > > > > > 
> > > > > > > Similar to securityfs, the firmware security filesystem is recommended
> > > > > > > to be exposed on a well known mount point /sys/firmware/security.
> > > > > > > Platforms can define their own directory or file structure under this path.
> > > > > > > 
> > > > > > > Example:
> > > > > > > 
> > > > > > > # mount -t fwsecurityfs fwsecurityfs /sys/firmware/security
> > > > > > Why not juset use securityfs in /sys/security/firmware/ instead?  Then
> > > > > > you don't have to create a new filesystem and convince userspace to
> > > > > > mount it in a specific location?
> > > > >   From man 5 sysfs page:
> > > > > 
> > > > > /sys/firmware: This subdirectory contains interfaces for viewing and
> > > > > manipulating firmware-specific objects and attributes.
> > > > > 
> > > > > /sys/kernel: This subdirectory contains various files and subdirectories
> > > > > that provide information about the running kernel.
> > > > > 
> > > > > The security variables which are being exposed via fwsecurityfs are managed
> > > > > by firmware, stored in firmware managed space and also often consumed by
> > > > > firmware for enabling various security features.
> > > > Ok, then just use the normal sysfs interface for /sys/firmware, why do
> > > > you need a whole new filesystem type?
> > > > 
> > > > >   From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose of
> > > > > securityfs(/sys/kernel/security) is to provide a common place for all kernel
> > > > > LSMs. The idea of
> > > > > fwsecurityfs(/sys/firmware/security) is to similarly provide a common place
> > > > > for all firmware security objects.
> > > > > 
> > > > > /sys/firmware already exists. The patch now defines a new /security
> > > > > directory in it for firmware security features. Using /sys/kernel/security
> > > > > would mean scattering firmware objects in multiple places and confusing the
> > > > > purpose of /sys/kernel and /sys/firmware.
> > > > sysfs is confusing already, no problem with making it more confusing :)
> > > > 
> > > > Just document where you add things and all should be fine.
> > > > 
> > > > > Even though fwsecurityfs code is based on securityfs, since the two
> > > > > filesystems expose different types of objects and have different
> > > > > requirements, there are distinctions:
> > > > > 
> > > > > 1. fwsecurityfs lets users create files in userspace, securityfs only allows
> > > > > kernel subsystems to create files.
> > > > Wait, why would a user ever create a file in this filesystem?  If you
> > > > need that, why not use configfs?  That's what that is for, right?
> > > The purpose of fwsecurityfs is not to expose configuration items but rather
> > > security objects used for firmware security features. I think these are more
> > > comparable to EFI variables, which are exposed via an EFI-specific
> > > filesystem, efivarfs, rather than configfs.
> > > 
> > > > > 2. firmware and kernel objects may have different requirements. For example,
> > > > > consideration of namespacing. As per my understanding, namespacing is
> > > > > applied to kernel resources and not firmware resources. That's why it makes
> > > > > sense to add support for namespacing in securityfs, but we concluded that
> > > > > fwsecurityfs currently doesn't need it. Another but similar example of it
> > > > > is: TPM space, which is exposed from hardware. For containers, the TPM would
> > > > > be made as virtual/software TPM. Similarly for firmware space for
> > > > > containers, it would have to be something virtualized/software version of
> > > > > it.
> > > > I do not understand, sorry.  What does namespaces have to do with this?
> > > > sysfs can already handle namespaces just fine, why not use that?
> > > Firmware objects are not namespaced. I mentioned it here as an example of
> > > the difference between firmware and kernel objects. It is also in response
> > > to the feedback from James Bottomley in RFC v2 [https://lore.kernel.org/linuxppc-dev/41ca51e8db9907d9060cc38adb59a66dcae4c59b.camel@HansenPartnership.com/].
> > I do not understand, sorry.  Do you want to use a namespace for these or
> > not?  The code does not seem to be using namespaces.  You can use sysfs
> > with, or without, a namespace so I don't understand the issue here.
> > 
> > With your code, there is no namespace.
> 
> You are correct. There's no namespace for these.

So again, I do not understand.  Do you want to use filesystem
namespaces, or do you not?

How again can you not use sysfs or securityfs due to namespaces?  What
is missing?

confused,

greg k-h
