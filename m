Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FF05E9E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 19:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfGCRBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 13:01:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38231 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfGCRBt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:01:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id d17so3110122oth.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2019 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Idpa3jUrKCpC/Bdr1fHQx4WNMnrk4XzF66JGkHfuORg=;
        b=wNUY8V/mhFuU37yp/ZiCDNP/H5W230TbjZb/97Elz40NFzQaPClxobNSgEuk/f3fsc
         KAsS1YqM5g5FH4s1vA63O4LG1jBHrjJk4+vd6uDPabBVuDZihDUD9S0urvnYPszj/0V7
         K3GtQXRnQlXcSKL2AyAP/XyoqqAcN/eugW+0Q5+IDzc1779CIDToxE4AjArrBzIAjzzq
         Q/pmhuRmYDByH0oTkD8u1Po/Dr97GukMF3RPS45sTrwZMCPuUPVZ7/af6ttu3XmQfaUC
         k9omAOSsVODfgBm0uvi0QAClbSTpv8GcLOOgeFCzj/fCCrb3D7mDtnKte0e0X0QHsNvy
         4Y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Idpa3jUrKCpC/Bdr1fHQx4WNMnrk4XzF66JGkHfuORg=;
        b=OG9ufux55no+rlIFFZhXHTWzqBuAe0hvvG28tGqQjtqHWJJU7ygFSj2QFa6D1KTldR
         OOcns1dMxX2TGww+C7zEO/e8Ifz9P91Y3wn2iMkhmIYdmlbubA3C4NuztE1b+MLHgBt1
         Q6uc4dhusGfo0R5WoJ6oM0Zc5jYPm1yV25c12EpZAmMRRrKI4vdvMduOxUOqo612Mztm
         Z5OrPRHKKMTJK35CXDVLFzDJ/EOjgPR02yotmhBer5m0G/YWFdXgucdDI1gQPcyEpD7O
         iL2ZTtQdfFDJn2UT/MCTUYuo3jmmyycUa5Th/ziaHE8msSHXsRBgQXgCqPQtIGXw/lCu
         FUUA==
X-Gm-Message-State: APjAAAXKewRo3iFV6ydSNAc8qLL2JNsVHakhdhVwLZSKgQ404UZx4fO5
        i67SloVNAyjPHrUMaCLnuUGqO3NS7o8osGOUf94viQ==
X-Google-Smtp-Source: APXvYqzUjYaojSiF9PThGytBdcW3gjnOn4fcnoQwduNIvsAmCsZm45nhyVZ2Fow2YVOBy+g16od/O247MvqVqqVrRTo=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr29298148oto.207.1562173309283;
 Wed, 03 Jul 2019 10:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <156213869409.3910140.7715747316991468148.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190703121743.GH1729@bombadil.infradead.org>
In-Reply-To: <20190703121743.GH1729@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 3 Jul 2019 10:01:37 -0700
Message-ID: <CAPcyv4jgs5LTtTXR+2CyfbjJE85B_eoPFuXQsGBDnVMo41Jawg@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix missed PMD wakeups
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Boaz Harrosh <openosd@gmail.com>,
        stable <stable@vger.kernel.org>,
        Robert Barror <robert.barror@intel.com>,
        Seema Pandit <seema.pandit@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 3, 2019 at 5:17 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jul 03, 2019 at 12:24:54AM -0700, Dan Williams wrote:
> > This fix may increase waitqueue contention, but a fix for that is saved
> > for a larger rework. In the meantime this fix is suitable for -stable
> > backports.
>
> I think this is too big for what it is; just the two-line patch to stop
> incorporating the low bits of the PTE would be more appropriate.

Sufficient, yes, "appropriate", not so sure. All those comments about
pmd entry size are stale after this change.
