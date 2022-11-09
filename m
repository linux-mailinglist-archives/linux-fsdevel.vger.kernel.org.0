Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85853622CAF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Nov 2022 14:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKINrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Nov 2022 08:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKINrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:47:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0921D13FB3;
        Wed,  9 Nov 2022 05:47:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B73C3B81EC4;
        Wed,  9 Nov 2022 13:47:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FE1C433C1;
        Wed,  9 Nov 2022 13:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668001619;
        bh=T8ZpCfeDrYRnXim+EtribWm92PpPSXe5RMsnfAotB4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yilDZTQVRk/dQ6ZjPzjqvsk7gjmJ/ywI9HPUjKi20aCPrjgXYmUwjckntNGsnqPeV
         OVgTzAcVyN1BnZ3Ofu/6wLcRP7+Msh6bQ75oLO7maLPj9bNjjKgnASzOY7FMZb/WBo
         ziaNbBLpVAhRioTwS6CD7/5TLkPzIquE2AJTNFDI=
Date:   Wed, 9 Nov 2022 14:46:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
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
Message-ID: <Y2uvUFQ9S2oaefSY@kroah.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106210744.603240-3-nayna@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 06, 2022 at 04:07:42PM -0500, Nayna Jain wrote:
> securityfs is meant for Linux security subsystems to expose policies/logs
> or any other information. However, there are various firmware security
> features which expose their variables for user management via the kernel.
> There is currently no single place to expose these variables. Different
> platforms use sysfs/platform specific filesystem(efivarfs)/securityfs
> interface as they find it appropriate. Thus, there is a gap in kernel
> interfaces to expose variables for security features.
> 
> Define a firmware security filesystem (fwsecurityfs) to be used by
> security features enabled by the firmware. These variables are platform
> specific. This filesystem provides platforms a way to implement their
>  own underlying semantics by defining own inode and file operations.
> 
> Similar to securityfs, the firmware security filesystem is recommended
> to be exposed on a well known mount point /sys/firmware/security.
> Platforms can define their own directory or file structure under this path.
> 
> Example:
> 
> # mount -t fwsecurityfs fwsecurityfs /sys/firmware/security

Why not juset use securityfs in /sys/security/firmware/ instead?  Then
you don't have to create a new filesystem and convince userspace to
mount it in a specific location?

thanks,

greg k-h
