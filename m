Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B921F37E1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 12:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgFIKUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 06:20:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgFIKUZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:20:25 -0400
Received: from zn.tnic (p200300ec2f0d68002503c5de6f6b5eb0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6800:2503:c5de:6f6b:5eb0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21B641EC02B1;
        Tue,  9 Jun 2020 12:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591698023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=085VCpEjqM+GYch4ms9evINYEp+0wAs7XM3mVBlU0S0=;
        b=b9FcJ+mnX+Q47LOFSNU9YDy/3dRiU1w3RBY8bgcoCgkrdaRNbP/GouFz6vOgiKtrl38pMx
        pV/jHoN7mWdbF16dfS5hAMKtsgLyxySnBkwXlmpPdpcPEzMK9EfNi7taapklf49q2HZui9
        dcztIqPhrt6fhELlQj9WfKpK6elI13Q=
Date:   Tue, 9 Jun 2020 12:20:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 3/5] ext4: mballoc: Introduce pcpu seqcnt for freeing
 PA to improve ENOSPC handling
Message-ID: <20200609102015.GA7696@zn.tnic>
References: <cover.1589955723.git.riteshh@linux.ibm.com>
 <7f254686903b87c419d798742fd9a1be34f0657b.1589955723.git.riteshh@linux.ibm.com>
 <CGME20200603064851eucas1p2e435089fbdf4de1d1fa3fb051c2f3d7b@eucas1p2.samsung.com>
 <aa4f7629-02ff-e49b-e9c0-5ef4a1deee90@samsung.com>
 <2940d744-3f6f-d0b5-ad8d-e80128c495d0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2940d744-3f6f-d0b5-ad8d-e80128c495d0@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 03:40:16PM +0530, Ritesh Harjani wrote:
> Yes, this is being discussed in the community.
> I have submitted a patch which should help fix this warning msg.
> Feel free to give this a try on your setup.
> 
> https://marc.info/?l=linux-ext4&m=159110574414645&w=2

I just triggered the same thing here too. Looking at your fix and not
even pretending to know what's going on with that percpu sequence
counting, I can't help but wonder why do you wanna do:

	seq = *raw_cpu_ptr(&discard_pa_seq);

instead of simply doing:

	seq = this_cpu_read(discard_pa_seq);

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
