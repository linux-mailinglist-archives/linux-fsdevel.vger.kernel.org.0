Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48263651A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 16:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbiKWP6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 10:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiKWP6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:58:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08481A812;
        Wed, 23 Nov 2022 07:57:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 04B76CE2322;
        Wed, 23 Nov 2022 15:57:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E49C433C1;
        Wed, 23 Nov 2022 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669219063;
        bh=Q0SEQR3uc6eCtl05I/8Xe29JQKDtlOnHtgnxpmvfeK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhiplsOioxUX4b7OWO/JF0jiV4e9OaOyeXb1vLr7BIXe2hSqp14HiG3LS60tfKiXR
         XYHklTI6LnIYJ+JdVdOx89JEMI34ZRFLWpqBlzMQsRqI8TmEAFjO9/8CnTgju7xKis
         AnxSbQ0zYNV4rEJno4YOqL/ulKqGxpwcGux1giIg=
Date:   Wed, 23 Nov 2022 16:57:40 +0100
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
        Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Message-ID: <Y35C9O27J29bUDjA@kroah.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com>
 <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <20221119114234.nnfxsqx4zxiku2h6@riteshh-domain>
 <d3e8df29-d9b0-5e8e-4a53-d191762fe7f2@linux.vnet.ibm.com>
 <a2752fdf-c89f-6f57-956e-ad035d32aec6@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2752fdf-c89f-6f57-956e-ad035d32aec6@linux.vnet.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 23, 2022 at 10:05:49AM -0500, Nayna wrote:
> 
> On 11/22/22 18:21, Nayna wrote:
> > 
> > From the perspective of our use case, we need to expose firmware
> > security objects to userspace for management. Not all of the objects
> > pre-exist and we would like to allow root to create them from userspace.
> > 
> > From a unification perspective, I have considered a common location at
> > /sys/firmware/security for managing any platform's security objects. And
> > I've proposed a generic filesystem, which could be used by any platform
> > to represent firmware security objects via /sys/firmware/security.
> > 
> > Here are some alternatives to generic filesystem in discussion:
> > 
> > 1. Start with a platform-specific filesystem. If more platforms would
> > like to use the approach, it can be made generic. We would still have a
> > common location of /sys/firmware/security and new code would live in
> > arch. This is my preference and would be the best fit for our use case.
> > 
> > 2. Use securityfs.  This would mean modifying it to satisfy other use
> > cases, including supporting userspace file creation. I don't know if the
> > securityfs maintainer would find that acceptable. I would also still
> > want some way to expose variables at /sys/firmware/security.
> > 
> > 3. Use a sysfs-based approach. This would be a platform-specific
> > implementation. However, sysfs has a similar issue to securityfs for
> > file creation. When I tried it in RFC v1[1], I had to implement a
> > workaround to achieve that.
> > 
> > [1] https://lore.kernel.org/linuxppc-dev/20220122005637.28199-3-nayna@linux.ibm.com/
> > 
> Hi Greg,
> 
> Based on the discussions so far, is Option 1, described above, an acceptable
> next step?

No, as I said almost a year ago, I do not want to see platform-only
filesystems going and implementing stuff that should be shared by all
platforms.

thanks,

greg k-h
