Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037743D9332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 18:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhG1Q17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhG1Q16 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:27:58 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7B1C061757;
        Wed, 28 Jul 2021 09:27:56 -0700 (PDT)
Received: from nazgul.tnic (unknown [109.121.183.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F24F1EC0527;
        Wed, 28 Jul 2021 18:27:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1627489669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GOEYhGPYQ4YUbo4gftj4JX0Uz5V/Qj9S6dris+AXSaA=;
        b=LxjG3gFIJCDuOQDGzY+hiG0vN+dfpBr7Vq5w2ORdpOETiJfx6X9JMDFJJMxIan0ujoNNw7
        KMi/vJ5Nq5Vi/Nq5x7JcXDHRAXe8ptcsnGwT9j1ZZa1hhOAXVDNeta9RonTrMrxsR3lvLV
        KIVjknjki6FEc0QGw1JCe7AU529aFu0=
Date:   Wed, 28 Jul 2021 18:28:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH 01/11] mm: Introduce a function to check for
 virtualization protection features
Message-ID: <YQGFh3BlaD8RAEBz@nazgul.tnic>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <cbc875b1d2113225c2b44a2384d5b303d0453cf7.1627424774.git.thomas.lendacky@amd.com>
 <YQFY5/cq2thyHzUe@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YQFY5/cq2thyHzUe@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 02:17:27PM +0100, Christoph Hellwig wrote:
> So common checks obviously make sense, but I really hate the stupid
> multiplexer.  Having one well-documented helper per feature is much
> easier to follow.

We had that in x86 - it was called cpu_has_<xxx> where xxx is the
feature bit. It didn't scale with the sheer amount of feature bits that
kept getting added so we do cpu_feature_enabled(X86_FEATURE_XXX) now.

The idea behind this is very similar - those protected guest flags
will only grow in the couple of tens range - at least - so having a
multiplexer is a lot simpler, I'd say, than having a couple of tens of
helpers. And those PATTR flags should have good, readable names, btw.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
