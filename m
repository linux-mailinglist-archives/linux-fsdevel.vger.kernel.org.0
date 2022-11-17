Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B6D62E6EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 22:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiKQVap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 16:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiKQVan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:30:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7AD101C0;
        Thu, 17 Nov 2022 13:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3BB0B82205;
        Thu, 17 Nov 2022 21:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B627BC433D6;
        Thu, 17 Nov 2022 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668720638;
        bh=qYl67bsPlVudFRZ07LmNN+KoGZ8Y9700f1Y7TQQuaAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Mu1bjcodR2h6/tluJfRwYugN7e71YcxSv/MAWYAeYyM6pP9nh/LtchZM00hlfJP4
         YWY93YeMF0SBDgjiQEooKErINoLVwD6Uwl9Dpy7RJ58WHYo5sTt49s8jC9H+WkQajW
         WNmOX/r/l0+uTB1XIF6NEKv5O5FZFnmVojfttBik=
Date:   Thu, 17 Nov 2022 22:27:30 +0100
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
Message-ID: <Y3anQukokMcQr+iE@kroah.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com>
 <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <Y2zLRw/TzV/sWgqO@kroah.com>
 <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:03:43PM -0500, Nayna wrote:
> 
> On 11/10/22 04:58, Greg Kroah-Hartman wrote:
> > On Wed, Nov 09, 2022 at 03:10:37PM -0500, Nayna wrote:
> > > On 11/9/22 08:46, Greg Kroah-Hartman wrote:
> > > > On Sun, Nov 06, 2022 at 04:07:42PM -0500, Nayna Jain wrote:
> > > > > securityfs is meant for Linux security subsystems to expose policies/logs
> > > > > or any other information. However, there are various firmware security
> > > > > features which expose their variables for user management via the kernel.
> > > > > There is currently no single place to expose these variables. Different
> > > > > platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
> > > > > interface as they find it appropriate. Thus, there is a gap in kernel
> > > > > interfaces to expose variables for security features.
> > > > > 
> > > > > Define a firmware security filesystem (fwsecurityfs) to be used by
> > > > > security features enabled by the firmware. These variables are platform
> > > > > specific. This filesystem provides platforms a way to implement their
> > > > >    own underlying semantics by defining own inode and file operations.
> > > > > 
> > > > > Similar to securityfs, the firmware security filesystem is recommended
> > > > > to be exposed on a well known mount point /sys/firmware/security.
> > > > > Platforms can define their own directory or file structure under this path.
> > > > > 
> > > > > Example:
> > > > > 
> > > > > # mount -t fwsecurityfs fwsecurityfs /sys/firmware/security
> > > > Why not juset use securityfs in /sys/security/firmware/ instead?  Then
> > > > you don't have to create a new filesystem and convince userspace to
> > > > mount it in a specific location?
> > >  From man 5 sysfs page:
> > > 
> > > /sys/firmware: This subdirectory contains interfaces for viewing and
> > > manipulating firmware-specific objects and attributes.
> > > 
> > > /sys/kernel: This subdirectory contains various files and subdirectories
> > > that provide information about the running kernel.
> > > 
> > > The security variables which are being exposed via fwsecurityfs are managed
> > > by firmware, stored in firmware managed space and also often consumed by
> > > firmware for enabling various security features.
> > Ok, then just use the normal sysfs interface for /sys/firmware, why do
> > you need a whole new filesystem type?
> > 
> > >  From git commit b67dbf9d4c1987c370fd18fdc4cf9d8aaea604c2, the purpose of
> > > securityfs(/sys/kernel/security) is to provide a common place for all kernel
> > > LSMs. The idea of
> > > fwsecurityfs(/sys/firmware/security) is to similarly provide a common place
> > > for all firmware security objects.
> > > 
> > > /sys/firmware already exists. The patch now defines a new /security
> > > directory in it for firmware security features. Using /sys/kernel/security
> > > would mean scattering firmware objects in multiple places and confusing the
> > > purpose of /sys/kernel and /sys/firmware.
> > sysfs is confusing already, no problem with making it more confusing :)
> > 
> > Just document where you add things and all should be fine.
> > 
> > > Even though fwsecurityfs code is based on securityfs, since the two
> > > filesystems expose different types of objects and have different
> > > requirements, there are distinctions:
> > > 
> > > 1. fwsecurityfs lets users create files in userspace, securityfs only allows
> > > kernel subsystems to create files.
> > Wait, why would a user ever create a file in this filesystem?  If you
> > need that, why not use configfs?  That's what that is for, right?
> 
> The purpose of fwsecurityfs is not to expose configuration items but rather
> security objects used for firmware security features. I think these are more
> comparable to EFI variables, which are exposed via an EFI-specific
> filesystem, efivarfs, rather than configfs.
> 
> > 
> > > 2. firmware and kernel objects may have different requirements. For example,
> > > consideration of namespacing. As per my understanding, namespacing is
> > > applied to kernel resources and not firmware resources. That's why it makes
> > > sense to add support for namespacing in securityfs, but we concluded that
> > > fwsecurityfs currently doesn't need it. Another but similar example of it
> > > is: TPM space, which is exposed from hardware. For containers, the TPM would
> > > be made as virtual/software TPM. Similarly for firmware space for
> > > containers, it would have to be something virtualized/software version of
> > > it.
> > I do not understand, sorry.  What does namespaces have to do with this?
> > sysfs can already handle namespaces just fine, why not use that?
> 
> Firmware objects are not namespaced. I mentioned it here as an example of
> the difference between firmware and kernel objects. It is also in response
> to the feedback from James Bottomley in RFC v2 [https://lore.kernel.org/linuxppc-dev/41ca51e8db9907d9060cc38adb59a66dcae4c59b.camel@HansenPartnership.com/].

I do not understand, sorry.  Do you want to use a namespace for these or
not?  The code does not seem to be using namespaces.  You can use sysfs
with, or without, a namespace so I don't understand the issue here.

With your code, there is no namespace.

> > > 3. firmware objects are persistent and read at boot time by interaction with
> > > firmware, unlike kernel objects which are not persistent.
> > That doesn't matter, sysfs exports what the hardware provides, and that
> > might persist over boot.
> > 
> > So I don't see why a new filesystem is needed.
> > 
> > You didn't explain why sysfs, or securitfs (except for the location in
> > the tree) does not work at all for your needs.  The location really
> > doesn't matter all that much as you are creating a brand new location
> > anyway so we can just declare "this is where this stuff goes" and be ok.
> 
> For rest of the questions, here is the summarized response.
> 
> Based on mailing list previous discussions [1][2][3] and considering various
> firmware security use cases, our fwsecurityfs proposal seemed to be a
> reasonable and acceptable approach based on the feedback [4].
> 
> [1] https://lore.kernel.org/linuxppc-dev/YeuyUVVdFADCuDr4@kroah.com/#t
> [2] https://lore.kernel.org/linuxppc-dev/Yfk6gucNmJuR%2Fegi@kroah.com/
> [3] https://lore.kernel.org/all/Yfo%2F5gYgb9Sv24YB@kroah.com/t/#m40250fdb3fddaafe502ab06e329e63381b00582d
> [4] https://lore.kernel.org/linuxppc-dev/YrQqPhi4+jHZ1WJc@kroah.com/
> 
> RFC v1 was using sysfs. After considering feedback[1][2][3], the following
> are design considerations for unification via fwsecurityfs:
> 
> 1. Unify the location: Defining a security directory under /sys/firmware
> facilitates exposing objects related to firmware security features in a
> single place. Different platforms can create their respective directory
> structures within /sys/firmware/security.

So just pick one place in sysfs for this to always go into.

Your patch series does not document anything here, there are no
Documentation/ABI/ entries that define the files being created, so that
it's really hard to be able to review the code to determine if it is
doing what you are wanting it to do.

You can't document apis with just a changelog text alone, sorry.

> 2. Unify the code:  To support unification, having the fwsecurityfs
> filesystem API allows different platforms to define the inode and file
> operations they need. fwsecurityfs provides a common API that can be used by
> each platform-specific implementation to support its particular requirements
> and interaction with firmware. Initializing platform-specific functions is
> the purpose of the fwsecurityfs_arch_init() function that is called on
> mount. Patch 3/4 implements fwsecurityfs_arch_init() for powerpc.

But you only are doing this for one platform, that's not any
unification.  APIs don't really work unless they can handle 3 users, as
then you really understand if they work or not.

Right now you wrote this code and it only has one user, that's a
platform-specific-filesystem-only so far.

> Similar to the common place securityfs provides for LSMs to interact with
> kernel security objects, fwsecurityfs would provide a common place for all
> firmware security objects, which interact with the firmware rather than the
> kernel. Although at the API level, the two filesystem look similar, the
> requirements for firmware and kernel objects are different. Therefore,
> reusing securityfs wasn't a good fit for the firmware use case and we are
> proposing a similar but different filesystem -  fwsecurityfs - focused for
> firmware security.

What other platforms will use this?  Who is going to move their code
over to it?

> > And again, how are you going to get all Linux distros to now mount your
> > new filesystem?
> 
> It would be analogous to the way securityfs is mounted.

That did not answer the question.  The question is how are you going to
get the distros to mount your new filesystem specifically?  How will
they know that they need to modify their init scripts to do this?  Who
is going to do that?  For what distro?  On what timeline?

Oh, and it looks like this series doesn't pass the kernel testing bot at
all, so I'll not review the code until that's all fixed up at the very
least.

thanks,

greg k-h
