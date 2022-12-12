Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB896498E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 07:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiLLGMI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 01:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiLLGMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:12:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8059CE20;
        Sun, 11 Dec 2022 22:12:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C2B4B80B72;
        Mon, 12 Dec 2022 06:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0E0C433EF;
        Mon, 12 Dec 2022 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670825522;
        bh=HNQ+jgM7nK49r0QXRAxcWzevnlOGKXqz3QgiETxRhHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WM0p9cjRA54uIuhCbl3bNcjmtBqXqjXOC3mdqoTPMfXNGFGVY+p2LjDHubsqAvGNB
         dtfxv2dYaZK0bzf5t8f37JjGjSbnHHD6vnwMO8yrTT4w13cgZukg1Dg/Y2fB2b3TAR
         5LSj2GE832dWK6oLrVDYpmOMou+L9g4VWVxl5Pls=
Date:   Mon, 12 Dec 2022 07:11:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Donnellan <ajd@linux.ibm.com>
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
        Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Message-ID: <Y5bGLuTAARW+T1Lm@kroah.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
 <20221106210744.603240-3-nayna@linux.ibm.com>
 <Y2uvUFQ9S2oaefSY@kroah.com>
 <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
 <20221119114234.nnfxsqx4zxiku2h6@riteshh-domain>
 <d3e8df29-d9b0-5e8e-4a53-d191762fe7f2@linux.vnet.ibm.com>
 <a2752fdf-c89f-6f57-956e-ad035d32aec6@linux.vnet.ibm.com>
 <Y35C9O27J29bUDjA@kroah.com>
 <6f2a4a5f-ab5b-8c1b-47d5-d4e6dca5fc3a@linux.vnet.ibm.com>
 <deda857ccc949f920ae3b7eca753d41b76acceda.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deda857ccc949f920ae3b7eca753d41b76acceda.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 12, 2022 at 11:58:56AM +1100, Andrew Donnellan wrote:
> On Wed, 2022-11-23 at 13:57 -0500, Nayna wrote:
> > 
> > Given there are no other exploiters for fwsecurityfs and there should
> > be 
> > no platform-specific fs, would modifying sysfs now to let userspace 
> > create files cleanly be the way forward? Or, if we should strongly 
> > consider securityfs, which would result in updating securityfs to
> > allow 
> > userspace creation of files and then expose variables via a more 
> > platform-specific directory /sys/kernel/security/pks? We want to pick
> > the best available option and would find some hints on direction
> > helpful 
> > before we develop the next patch.
> 
> Ping - it would be helpful for us to know your thoughts on this.

sysfs is not for userspace creation of files, you all know this :)

greg k-h
