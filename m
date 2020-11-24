Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3244E2C23F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731896AbgKXLOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 06:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgKXLOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:14:24 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B1FC0613D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 03:14:24 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id s63so7301208pgc.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 03:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v/sot8C2WsjzLbiXIhxi+5cp9rKmtAFXiiGvcKf+TbE=;
        b=S510g7kb5vjSscjz2aQWVET1/qXviVXD2YCzJUVzQGY1FWvp9RWqUzYO9kykrDBSBU
         qufXQya3b+g2T8LrFfnd/CZHuwh8CPyZvElR50o4yNB6cyYWz0cWZhcHaQWPMQ8hbEOa
         m9UlcQXNdJSSywxcKqHN/OIHiC8/mFJLshrwTypZV3z6/WWtcQ0N4AUWnsBQkvyGn4fT
         hRaVjfuRJQDQA/nqTO6moD3WeYsyR06s4kN+lfkBmgtXegNiM5AgRXlUWUibck8hq795
         OehpHHbmzF8wrw4YJm2cBicnzqhlktXZRZgpAFJFxDxwu+55nF9BjzIFmk7/4IIPTjDG
         /obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v/sot8C2WsjzLbiXIhxi+5cp9rKmtAFXiiGvcKf+TbE=;
        b=Gr9mN19UvyP2KfGASRMqbuw30Mb0fAuJRMtPtOPLDr96P9yEZ+7tFnH1SYsI6uEouT
         lV3rNerpL1Oeog7zwyO79NznmOLYMl5LOLnbc5VCL+c0SK7tr/vPDgcqzdPqPOSKhU6l
         YOBP87h3FUjafSIZBIzh1Lyqa+m4Z++W1ORIPPW1PetTNM2WDJfSAjuTGL+zFhdm5KW/
         0Bnqqq8riiFKfjXYGjzUL0jS872TU1LdIgKAbXGASjBmOQ3kI1pgoNE8fsR3NF4cuk87
         Q7pPVqf6z88MsvQ8fakenllN/hJSunGRFhSdd6bGCeks9fMPHS8wViKUSxU2K1R+K1dP
         CDWQ==
X-Gm-Message-State: AOAM533I39HUbH98rDwf5VyDQ72MuQBXpdhyUadxi3gKEPtuAYR+35eZ
        3MgZIDc5hPlcFLbTW3v9UXmyag0dsrmBwL2zKfU5pg==
X-Google-Smtp-Source: ABdhPJwZQyY7kH8gIqzhnKBbLHHF3RPAiMy6aiswptBAfQVUw6PtBUQ54ClI+tM+sA0E0N7Y9Z5aGZQA2c9JBp3BKdU=
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr4338471pjb.147.1606216464411;
 Tue, 24 Nov 2020 03:14:24 -0800 (PST)
MIME-Version: 1.0
References: <20201124095259.58755-1-songmuchun@bytedance.com>
 <20201124095259.58755-8-songmuchun@bytedance.com> <20201124102441.GA24718@linux>
In-Reply-To: <20201124102441.GA24718@linux>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 24 Nov 2020 19:13:47 +0800
Message-ID: <CAMZfGtVRywVmfWSLPwy4HFPa8O9--Acx+Tsd+tiJa3U3gwF-sQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 07/16] x86/mm/64: Disable PMD page
 mapping of vmemmap
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 6:24 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Nov 24, 2020 at 05:52:50PM +0800, Muchun Song wrote:
> > If we enable the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, we can just
> > disbale PMD page mapping of vmemmap to simplify the code. In this
> > case, we do not need complex code doing vmemmap page table
> > manipulation. This is a way to simply the first version of this
> > patch series. In the future, we can add some code doing page table
> > manipulation.
>
> IIRC, CONFIG_HUGETLB_PAGE_FREE_VMEMMAP was supposed to be enabled by default,
> right?
> And we would control whether we __really__ want to this by a boot option,
> which was disabled by default?
>
> If you go for populating the memmap with basepages by checking
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, would not everybody, even the ones that
> did not enable this by the boot option be affected?

Yeah, this should be improved. We should enable the basepage mapping
of vmemmap only when this feature is enabled via boot command line.
I will apply the suggestions mentioned by Barry. Thanks.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
