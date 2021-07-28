Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ADF3D8ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhG1NTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 09:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbhG1NTS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:19:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8295AC061757;
        Wed, 28 Jul 2021 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bU/Ms46JtnXaVrVhQUyi3qsSgcv2ZUBgkJZ69baP/Pk=; b=l/t/Xn+txpO1+X8wtS8Uk4aaqG
        m2+T0SHpVqEnt0/9mZr65K2ueB1kLi0Gx/E9Ov/NZNfcfbm0aSIoCXUBZDMdD7FMkHtRpiECduJr7
        Rt4ArgG6CcLFJpfB7mhR9ochKMyUK4sUQhYvpLwmW49Gs9J06Mvyg5y94GM6d6rLaXR9BaAbWOIpZ
        10T8RMs/K27IkXLp/vjCX+SQ8wtLiH+hDMOJw4D/h2g1l8zP6PGPE8V75qPmB6DklI1zsDwON4VTT
        tuN/D97KN3CBoRNqQG3rooTGaJ8SPBZlGmhA5MCb/K3ZPko/3eWBLi9x75g/uvwD+FrvCC64M+RgR
        Pk0dHV9A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8jR9-00G4xh-78; Wed, 28 Jul 2021 13:17:52 +0000
Date:   Wed, 28 Jul 2021 14:17:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
Message-ID: <YQFY5/cq2thyHzUe@infradead.org>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 05:26:04PM -0500, Tom Lendacky via iommu wrote:
> In prep for other protected virtualization technologies, introduce a
> generic helper function, prot_guest_has(), that can be used to check
> for specific protection attributes, like memory encryption. This is
> intended to eliminate having to add multiple technology-specific checks
> to the code (e.g. if (sev_active() || tdx_active())).

So common checks obviously make sense, but I really hate the stupid
multiplexer.  Having one well-documented helper per feature is much
easier to follow.

> +#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
> +#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
> +#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
> +#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */

The kerneldoc comments on these individual helpers will give you plenty
of space to properly document what they indicate and what a (potential)
caller should do based on them.  Something the above comments completely
fail to.
