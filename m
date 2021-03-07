Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E9C32FF96
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Mar 2021 09:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCGITP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Mar 2021 03:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCGITF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:19:05 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FEDC06174A;
        Sun,  7 Mar 2021 00:19:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q2-20020a17090a2e02b02900bee668844dso1354078pjd.3;
        Sun, 07 Mar 2021 00:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZhmCGFCWE9B1mgJsiqMToPvrYNntF7QZQE78G1v4dD0=;
        b=KwD9hVfm+FoiQmNP00Fjr9GPA0JjY12vqRZ/3os7bpBo+JIfIdmBe4CJBbDre7myIz
         dX7vGD06+sbIwpz9FK6FkZGfT4dtyilx5BS9FE0p4PSFEt3iuHNqQCzB3qsVX2FznMgc
         f5+5mUayzCuKWvp22MFZIyr8Y44umG45q8LIlHHgdU3ZTV4m+yyrfSbSSj0Z+fdv2d/H
         nCYQ7i68nmZuTLBsqSjFP8bQGq5XjTLTb+OEBGgFw0Ny/Adt1W5RZnQR7AIm4YI/boC3
         V08tE+dogYC9cYDsaGauZGitU4JG2bZwf0Dff9hYmK5b2QwEZ3RDD/mLb9Hh94m4Lr7s
         sGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZhmCGFCWE9B1mgJsiqMToPvrYNntF7QZQE78G1v4dD0=;
        b=krFFfnOogsU6OBF2YjmnPZ1BpYuyJVXRKaurSuh8p/RQ+iB0r8PW9C8ETY99fW0iig
         d6yRA1oVtCBYlAe8zf6iXz9JnDsRqLJS7JJHBUlIh7mDsSwmoZ9keXKuOMU76iqBtXWQ
         taJDrGR972CmG7rtMVkwezomWMcEQRNWeEIWvlgZm02kiRgXBJZekbSQY1jkpfNPGKoA
         8qfNHAaQ1cO/OsSeXedAK4XZQWeWbVmLoCfDpUxJXvj+kfNS8Lp8Tycpw6a9nZxC7f28
         BTV7JEUMp6fDE66hH6uvIrQV/I8yNcxHxRkl9tWslgV2PfCKp3voROw4pnfkq8bTORNl
         z5Zw==
X-Gm-Message-State: AOAM531zYYRKsNhG5DA3Iqb17IgcIVu9eHgy9vvzSE1f/fEQSVReytfu
        Rbice+uOmtDBScE8SzXIgsI=
X-Google-Smtp-Source: ABdhPJw6L+8rGzr6RiNOOEJzLsGocciaUifoiNri6jiHAbpSW7AUvV3P/qCwIq2V+Vgam893063lRQ==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr18783404pjb.55.1615105144148;
        Sun, 07 Mar 2021 00:19:04 -0800 (PST)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id 2sm6934784pfi.116.2021.03.07.00.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 00:19:01 -0800 (PST)
Date:   Sun, 7 Mar 2021 19:18:57 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v17 5/9] mm: hugetlb: set the PageHWPoison to the raw
 error page
Message-ID: <20210307081857.GE1223287@balbir-desktop>
References: <20210225132130.26451-1-songmuchun@bytedance.com>
 <20210225132130.26451-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225132130.26451-6-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 25, 2021 at 09:21:26PM +0800, Muchun Song wrote:
> Because we reuse the first tail vmemmap page frame and remap it
> with read-only, we cannot set the PageHWPosion on some tail pages.
> So we can use the head[4].private (There are at least 128 struct
> page structures associated with the optimized HugeTLB page, so
> using head[4].private is safe) to record the real error page index
> and set the raw error page PageHWPoison later.
>

Does the hardcoding of 4 come from HUGETLB_CGROUP_MIN_ORDER, if so
do we need to hardcode 4? Also, I am not sure about the comment
on safety and 128 struct pages

Balbir
 
