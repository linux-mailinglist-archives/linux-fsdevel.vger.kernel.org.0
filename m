Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52A6E179A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 12:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbfJWKPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 06:15:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391029AbfJWKPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:15:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so12615280pfn.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hESAzTzUhDJYzksaOkjM7hZkMI+UHgjldrQJvCm8mlk=;
        b=p4P3kA0z50+ygpLpC3dpr9ayiMpPGa5MTYwdH6ga8VozgqUC/Fd211GhSGKGinjyDH
         4QLdt8uPScbKKksSPKel5GsgaAQfunW1iGt3E91wRqol54RCZYzZs9WJp7oHS8hfulNU
         kG6x9j/UMcBZGEH2WYoztAGdnk7J2i8EofQg0zol/lpWMEy566IYZ9E1+/Iq6V4EBuXt
         OGa/L2Brd4QTozc/GinEkmS3du2tt7Jl329zAPlZ71dT28ThhV/Ag+BkQow6qB1RSBfV
         WYtHiWhHIKoz2/JspYw4qywWoTtwacdiHc7xRESc2eW24nag/cdTozI6O4YQG7KQMO4m
         h9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hESAzTzUhDJYzksaOkjM7hZkMI+UHgjldrQJvCm8mlk=;
        b=lvCKgio6VltzBZfjvpamjAd2U2frZyXp9zo+cHYB3gAWPzR0BZmLKeGmlodVYqLtCw
         glEuKS95VfVdTGvs/9gCgzuEA8cwcog1tzdRkGj3hDELdN3l2RXgYHB8gZ3/CYgXgp5B
         919LWXmwHjv6DsFspJw6Uw4WV6guV1Mj2fTHseohcIPoyDanTOupZOlsbuzgFL06/bGh
         ZehOxm7Hv8FSQoM1dxaeZyUQDQ56lzyAFaBoIkAWR9DlN97Ig1v/7Nd81+J+vfrb0PZ0
         wfRlPZWxEzE2QKRkF+ZR81h6s58ndlPMKWE/omtswzr1NZFz2EgaR4K79AUYUJe+WknO
         muqw==
X-Gm-Message-State: APjAAAVBG6mY1FCzJyiO1zmPb1BCUmmJCk+DdtzX7viBsWbX9DKIsygF
        XKocQZJ2lMQFRtdE4prxm+Yh
X-Google-Smtp-Source: APXvYqyBVP25+YP+O86GQCMHVUN+LFce/9Pq19zs3cGhpUmHzbNMGwfW1TpbiVKlR6JDj78pg0UuCQ==
X-Received: by 2002:a63:6782:: with SMTP id b124mr9350617pgc.220.1571825699329;
        Wed, 23 Oct 2019 03:14:59 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id v35sm29340414pgn.89.2019.10.23.03.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 03:14:58 -0700 (PDT)
Date:   Wed, 23 Oct 2019 21:14:52 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 01/12] ext4: move set iomap routines into separate
 helper ext4_set_iomap()
Message-ID: <20191023101452.GB6725@bobrowski>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <7dd1a1a895fd7e55c659b10bba16976faab4cd85.1571647178.git.mbobrowski@mbobrowski.org>
 <20191023063152.EEE024C050@d06av22.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023063152.EEE024C050@d06av22.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:01:51PM +0530, Ritesh Harjani wrote:
> 
> 
> On 10/21/19 2:47 PM, Matthew Bobrowski wrote:
> > Separate the iomap field population chunk of code that is currently
> > within ext4_iomap_begin() into a new helper called
> > ext4_set_iomap(). The intent of this function is self explanatory,
> > however the rationale behind doing so is to also reduce the overall
> > clutter that we currently have within the ext4_iomap_begin() callback.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> Could you please re-arrange patch sequence in this fashion.
> 
> 1. Patch-11 (re-ordering of unwritten flags)
> 2. Patch-8 (trylock in IOCB_NOWAIT cases)
> 3. Patch-2 (should explain offset & len in this patch)
> 4. Patch-1 (this patch).

No objections to this. Just needing to do a little shuffle here and there.

> This is so that some of these are anyway fixes or refactoring
> which can be picked up easily, either for backporting or
> sometimes this helps in getting some of the patches in, if the patch
> series gets bigger.
> Also others (like me) can also pick some of these changes then to meet
> their dependency. :)

Sure, thanks for educating me and making me aware of this.
 
> This patch looks good to me. You may add:
> 
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks Ritesh!
 
--<M>--
