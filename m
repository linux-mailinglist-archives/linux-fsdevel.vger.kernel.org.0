Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1B742AB76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Oct 2021 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJLSEd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Oct 2021 14:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbhJLSEZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:04:25 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47B9C061767;
        Tue, 12 Oct 2021 11:02:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id d3so2759360edp.3;
        Tue, 12 Oct 2021 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mt4tK4CWEsYitFNESRdq5gQKepAHPRfQuKWF85se3SU=;
        b=KB1PXcwmOUmX7nb07cBlXcrMUqLhlGSrYIxMjpNQvY4wp9bhDm/X+x+P+MlBlUNRmo
         rIAb/7DMPXEKLsynOCMSYU5uqiAb8zEhTTu50wXdi/TVl89hxRGaD3NW+Ihfl/SwKviF
         geWVOTAaOczrRkmsz3UiQSKCG5mxH5ZJHENLcHTLufWt6j8/ffNepWG6BI9p+z8ZGTym
         170zYv+VWAbzGe8RRwzh7nNbxmuY6gilJ6/TzK48GNk58FjLLP/cWIjfjAaQ3hsvUczP
         cEbeMd+UVvXttFIp5v/CZi/qYtWMkT2Fs6/8TSR5lV1D1BSbKl0+I2yj7bCAT1lkUC0+
         gP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mt4tK4CWEsYitFNESRdq5gQKepAHPRfQuKWF85se3SU=;
        b=V/et3oqmJB/ohNNTOrOAU5UdDhRIqtbtK/xLJOD3Yc8zwfVTojVy6yTDpX7tKVUgI5
         XpzNPR1P/XMgxZgJEKpes+ddOMNC+zI0xv3IczKj38W4spThQ8To/N2d2F8k26EiKbME
         UpSyB44o8MhssYehqVleEHh6EPaEY/NOrFIn3XrBnGYCuTt7NOSqJ6DEFwnakpcZgdvL
         3RLTrmnGrAgPJuid4Y1cHdezOOYMJd4tuK/VFnSFJ6pNvvzplaL0C9k3vOTTfUJa6PNz
         5cxNflsNh9LgkXq1vNU6RcCdl726FQcG+R/KAgoc1t/9JLCYsVIC32GB395NVBodyeE3
         K0gA==
X-Gm-Message-State: AOAM531SeUGQKd6RBd6xhKw/R9JDP6eY55ma4N7GOUw06X7Rmq6qjPFE
        JMRFNLm2iN4dBDMcZxC9TDjggbGZduTIXe5jhd0=
X-Google-Smtp-Source: ABdhPJyuIkpKy+46yE0qflE4D2DsnLc14o01sPyp4dhRjRZbwenXL07HKHkTqE8edAB9lYY5S/VYXvLb6B1Unpm71QE=
X-Received: by 2002:a05:6402:5112:: with SMTP id m18mr1652051edd.101.1634061742373;
 Tue, 12 Oct 2021 11:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s> <YWTobPkBc3TDtMGd@t490s>
In-Reply-To: <YWTobPkBc3TDtMGd@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 12 Oct 2021 11:02:09 -0700
Message-ID: <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 11, 2021 at 6:44 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> > Another thing is I noticed soft_offline_in_use_page() will still ignore file
> > backed split.  I'm not sure whether it means we'd better also handle that case
> > as well, so shmem thp can be split there too?
>
> Please ignore this paragraph - I somehow read "!PageHuge(page)" as
> "PageAnon(page)"...  So I think patch 5 handles soft offline too.

Yes, exactly. And even though the split is failed (or file THP didn't
get split before patch 5/5), soft offline would just return -EBUSY
instead of calling __soft_offline_page->page_handle_poison(). So
page_handle_poison() should not see THP at all.

>
> --
> Peter Xu
>
