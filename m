Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754A427767A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIXQTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIXQTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:19:15 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ECEC0613CE;
        Thu, 24 Sep 2020 09:19:15 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id c2so1663441otp.7;
        Thu, 24 Sep 2020 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EDrVEIgRKX7DJHruxvfWiEIEjp75G6MffjRUfIzRobk=;
        b=KgXwBeE8eBvm9xJKsCWdNtbXpSuC/6StTGu0Q5164xy7XkeG8qJDADIfxv4VWmpNuq
         8Gss+VlXw3LfHQkceCMfeLIjNTv9PFs5iEdeOEbbNUWbSYlvaskZ2p48E5Gv5Cg8aDCg
         lc5QBukmSTYDy0UiGAxEcHUDjPe+m4P3jsnGbbhsIA/7VMbsnxRb9FPS2Dw+mgsQcaIz
         xleqLdgDvjqjXTu08RO4X1O3umFIuoBW/Y1lDvLGenEs2TNTq6OZuC3mTGjGcDmrmeNr
         2RlytAA/oVr/MoDgqUyP9RFrr5S9saMtbRmxI7rSjxVqBHXWQJlbpNkr8sTAelbYdWwJ
         l0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EDrVEIgRKX7DJHruxvfWiEIEjp75G6MffjRUfIzRobk=;
        b=XSmig/bBSf3LKdUlZi8AsaCmRR7DOcpIyzwD11dfHLa/iPwwOcFZJHiwjKj0BSw+bm
         dLO3XsyDIQikq/Dl1QjUIYQIIllOaofCvquxLr7gcNlMYm/wxIAsmDPM7aj/UZbh8Wqp
         uSKbC205ti2rvdl6r0FNkeYtYfijIWDLZABI+FIQ5Q8+v27f6s7fbs4U3Hf2TUIwxN+V
         HBaF2Unv4VuSO7YMgniWqSl3RTJZzbr0Q/ZryKCUxxijVc9Wzz0h0F1Pt0Lg8ln/Xsn4
         4e/yEf1zJBWvAQ7SggQegwx5o0nhOaFeBZV1NEQOXqSmCwWI2I3yJC9yDiIrKnvYZrnA
         euqg==
X-Gm-Message-State: AOAM530w11m85RQ3GMSbCzkaxunD+FEZxKtsdp7iAXqvkngAWPMDGQox
        MSfq46KAsT8wCCjjtRALoonhwZGstz37kvX9Wmu+d81OflI=
X-Google-Smtp-Source: ABdhPJyqVHCc8Cnz+bPH4+z4HNo3jgU6hfL+HkJ6shnN/Y4Fc6DBtW1IZ/2ZePgbFEzrsqIeDEXsehjG8uBU1VHwraQ=
X-Received: by 2002:a05:6830:110b:: with SMTP id w11mr285499otq.109.1600964354539;
 Thu, 24 Sep 2020 09:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200924125608.31231-1-willy@infradead.org> <CA+icZUUQGmd3juNPv1sHTWdhzXwZzRv=p1i+Q=20z_WGcZOzbg@mail.gmail.com>
 <20200924151538.GW32101@casper.infradead.org> <CA+icZUX4bQf+pYsnOR0gHZLsX3NriL=617=RU0usDfx=idgZmA@mail.gmail.com>
 <20200924152755.GY32101@casper.infradead.org>
In-Reply-To: <20200924152755.GY32101@casper.infradead.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 24 Sep 2020 18:19:03 +0200
Message-ID: <CA+icZUURRcCh1TYtLs=U_353bhv5_JhVFaGxVPL5Rydee0P1=Q@mail.gmail.com>
Subject: Re: [PATCH] iomap: Set all uptodate bits for an Uptodate page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Qian Cai <cai@redhat.com>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 24, 2020 at 5:27 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 24, 2020 at 05:21:00PM +0200, Sedat Dilek wrote:
> > Great and thanks.
> >
> > Can you send out a seperate patch and label it with "PATCH v5.9"?
> > I run:
> > $ git format-patch -1 --subject-prefix="PATCH v5.9" --signoff
> >
> > Normally, I catch patches from any patchwork URL in mbox format.
>
> Maybe wait a few hours for people to decide if they like the approach
> taken to fix the bug before diving into producing backports?

That make sense.

You have a test-case for me?
I have here Linux-Test-Project and FIO available.

- Sedat -
