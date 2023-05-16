Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BD670570A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjEPTZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjEPTZ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6494C8A48;
        Tue, 16 May 2023 12:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F188663E5B;
        Tue, 16 May 2023 19:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2317C433D2;
        Tue, 16 May 2023 19:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684265127;
        bh=S0Rq0G95CHXp1m5S50Xtw88jTsSFrtOHdzpyyFfPe0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wz3FHy0V43KAsSPzha+tkRRwMjg88jaek5nHtnOKFD69lkdQjPK1x4dLPI8VAhx4+
         cUjeTfmLgmawZQr1sy/f0j9C5nRE2xgaE0EKWlK9c5bYUcwIXNDs7+jH22wKB/ukWv
         TiMRfHW63t4IQ6YksDh/bFAzrJP12OWuWyhmNNtY=
Date:   Tue, 16 May 2023 21:25:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avadhut Naik <Avadhut.Naik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1] ACPI: APEI: EINJ: Add support for vendor defined
 error types
Message-ID: <2023051602-clear-encode-984e@gregkh>
References: <20230516183228.3736-1-Avadhut.Naik@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516183228.3736-1-Avadhut.Naik@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 06:32:28PM +0000, Avadhut Naik wrote:
> According to ACPI specification 6.5, section 18.6.4, Vendor-Defined Error
> types are supported by the system apart from standard error types if bit
> 31 is set in the output of GET_ERROR_TYPE Error Injection Action. While
> the errors themselves and the length of their associated OEM Vendor data
> structure might vary between vendors, the physical address of this very
> structure can be computed through vendor_extension and length fields of
> SET_ERROR_TYPE_WITH_ADDRESS Data Structure and Vendor Error Type Extension
> Structure respectively (ACPI Spec 6.5, Table 18.31 and 18.32).
> 
> Currently, however, the einj module only computes the physical address of
> Vendor Error Type Extension Structure. Neither does it compute the physical
> address of OEM Vendor structure nor does it establish the memory mapping
> required for injecting Vendor-defined errors. Consequently, userspace
> tools have to establish the very mapping through /dev/mem, nopat kernel
> parameter and system calls like mmap/munmap initially before injecting
> Vendor-defined errors.
> 
> Circumvent the issue by computing the physical address of OEM Vendor data
> structure and establishing the required mapping with the structure. Create
> a new file "oem_error", if the system supports Vendor-defined errors, to
> export this mapping, through debugfs_create_blob API. Userspace tools can
> then populate their respective OEM Vendor structure instances and just
> write to the file as part of injecting Vendor-defined Errors.
> 
> Additionally, since the debugfs files created through debugfs_create_blob
> API are read-only, introduce a write callback to enable userspace tools to
> write OEM Vendor structures into the oem_error file.

When you say "additionally", that's usually a huge hint that you need to
split this up into multiple patches.

Please do so here.

Also note that debugfs is almost never a valid api for anything you care
about for having a running system, as it is locked down for root access
only and some distros refuse to enable it at all due to its security
leakage.  So be careful about creating an api here that you might need
to use on a normal running system.


> 
> Note: Some checkpatch warnings are ignored to maintain coding style.

That's not good, please follow the right style for new code.

thanks,

greg k-h
