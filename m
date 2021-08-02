Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A243DD42F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Aug 2021 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhHBKpf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Aug 2021 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhHBKpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Aug 2021 06:45:35 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E387C06175F;
        Mon,  2 Aug 2021 03:45:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A1662379; Mon,  2 Aug 2021 12:45:24 +0200 (CEST)
Date:   Mon, 2 Aug 2021 12:45:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 06/11] x86/sev: Replace occurrences of sev_es_active()
 with prot_guest_has()
Message-ID: <YQfMw2FRO5M1osGF@8bytes.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <ba565128b88661a656fc3972f01bb2e295158a15.1627424774.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba565128b88661a656fc3972f01bb2e295158a15.1627424774.git.thomas.lendacky@amd.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 05:26:09PM -0500, Tom Lendacky wrote:
> @@ -48,7 +47,7 @@ static void sme_sev_setup_real_mode(struct trampoline_header *th)
>  	if (prot_guest_has(PATTR_HOST_MEM_ENCRYPT))
>  		th->flags |= TH_FLAGS_SME_ACTIVE;
>  
> -	if (sev_es_active()) {
> +	if (prot_guest_has(PATTR_GUEST_PROT_STATE)) {
>  		/*
>  		 * Skip the call to verify_cpu() in secondary_startup_64 as it
>  		 * will cause #VC exceptions when the AP can't handle them yet.

Not sure how TDX will handle AP booting, are you sure it needs this
special setup as well? Otherwise a check for SEV-ES would be better
instead of the generic PATTR_GUEST_PROT_STATE.

Regards,

Joerg
