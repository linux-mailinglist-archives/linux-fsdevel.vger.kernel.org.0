Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30765DF032
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfJUOpC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 10:45:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36307 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfJUOpC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:45:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id c7so427656otm.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXKBAnyH4k8+RtijsexqxpoxgeB4fhcJobwvx31LMho=;
        b=A08jDv+Vol6PvOoXT/M++kzuwcxp91LiBFYVYM8EPNPJr69L5QUHqGuyp6zGv7tyF9
         6FX/3oF06Fh+suEw+xQCGVLXW/2yTptC75eQ4/Bbh3WX6Ds/b0M7cf50hvpynQ5ibr4v
         gyYdRFItY3w55CEltwtFaefj+WsgXARJ5YWtFuxW73BsZK0zpcCSH1MoB0rLRv8RqmVt
         qiaRQW1K0uEwRHT9/yan1nEhEFofsZXJYLXFQRs8G0Luo67GpvQH6OEE/XLvxxr7bbTv
         RWxGf3MhxbRyjvhxwa7eDi1zMvw+87+x9G1yJ+8txjhDZ6FYAZefo+3fNI8vS/AdDEne
         vqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXKBAnyH4k8+RtijsexqxpoxgeB4fhcJobwvx31LMho=;
        b=kOeEdqQC/K6MWD1sFQDF1tnIRN7mVm2zmKOoamjaulOD3HEgLinj9Wb8TOL1zs+t/h
         +Ccv5JbOF5x3JEsa+d1ekxDcDsRzxiE47HrKkZzYH9tg0sqfXgazKVrkMzltmaWkOcLx
         9XDhbbrqbtiFdQ8KNQBTP6O3UBX4SdP0zje8zQ2wNzCXLA+Prn9Y1Q5gCynBf0BI5RA9
         CgZlqfZGCQzNzVKKRcjFTEP6UnY7OGXEXOU7qnYcxZaV/8lYJTjCDCH239w6LN4AJeZ1
         b8idxBuxbHQ62NV30DjHULHabSV0TEJtG9hY3/ZuODCbfw3eHbaCH3jB1/2P3Ny+Jitk
         AuQg==
X-Gm-Message-State: APjAAAW51bM/GMA+UkJJOnRHo8Ot3hxsqnwGC4aY32qz96aRoBeNrNoN
        PPsL1Fik9OdK+qJ49b05Xd29Qdcto2e87HiW1rGLWg==
X-Google-Smtp-Source: APXvYqxBK0s4meOHW5S/bgvSxL00+aVLbFSn/xa462jwXlzSuPi3v0iK8imKwTC8RSn2iFmHXyu4Ls1dS51GrTPHPKE=
X-Received: by 2002:a9d:7c92:: with SMTP id q18mr19206153otn.363.1571669101455;
 Mon, 21 Oct 2019 07:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <157150237973.3940076.12626102230619807187.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x495zkii9o5.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 21 Oct 2019 07:44:51 -0700
Message-ID: <CAPcyv4j66KoivrNRpOrqwrVtsOP5fSWKPqcHx_dDf1czy=f3qQ@mail.gmail.com>
Subject: Re: [PATCH] fs/dax: Fix pmd vs pte conflict detection
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Smits <jeff.smits@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        stable <stable@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 5:07 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Check for NULL entries before checking the entry order, otherwise NULL
> > is misinterpreted as a present pte conflict. The 'order' check needs to
> > happen before the locked check as an unlocked entry at the wrong order
> > must fallback to lookup the correct order.
>
> Please include the user-visible effects of the problem in the changelog.
>

Yup, I noticed that right after sending.
