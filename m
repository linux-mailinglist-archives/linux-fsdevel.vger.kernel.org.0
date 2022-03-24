Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5188F4E5D56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Mar 2022 03:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiCXCso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 22:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbiCXCsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:48:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D88939CC;
        Wed, 23 Mar 2022 19:47:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso3768781pjb.5;
        Wed, 23 Mar 2022 19:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90v/5Py9W7EAZEot7188HYCPw8B0VfqItjFqNp0yU8I=;
        b=dxrv0V3AiE2m0/WOX54xvV5yxB0eJv9FvLmxGfHi84fR/RWgBOp4yXdDNToYvyAawj
         kFAqEG2QtJP6dJm1A/UKmq+1eB7PdUAV/zCkGhgbi9FbsP45vrQ9Soh8L719JjYtuwIg
         N8NN/8zPbZSLvzEiIEYCgbzuHQ3nWPE/VgE7HlJAPPawvyRDtRTBtdnSAeEjeXLRRFJY
         hF4aVeYUjd1A+GEfDEvARaNz62S+hP9Rhjqv1hfCPw9ceQkOiviCfxLNeiibnjpNAGNi
         /6516352cSybYQDMu2cYXhPHBes/c1Nn7vARgXL0a/M/f8rTpmQpxgaP5aNDcNn0GcUs
         QfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90v/5Py9W7EAZEot7188HYCPw8B0VfqItjFqNp0yU8I=;
        b=L+Nkts2qPDy28GS2t9yQVU9DCQCizPhOys0HQG12B6SJ1XWGlFlFx8bi41rtihAc7u
         SxHlRpN3m5QDWwTzWK4IrpjM8/va7gN8nUsnb385S0vHSv+RHL4H7agXmRRxanby//d6
         /Ke9oBd/6P9gQY25ZNFhi2P6FbBHGTnnlz3STl3DOfbjE3xIsSq2QVdUxyLCoootMnzU
         Cbf574csqaVdregMOf0+FOlyVv2HiSYbV3eMJLFYXov7eJ1mEedIoNh8ftXxgD6bcTqI
         2HjMZ9rbT4Agz1a5vaLjd6g4pi8Zgo5PTMCkeWQ4MYJg9uO8Mlimihe5KFi1ZlwEn2k3
         NBDg==
X-Gm-Message-State: AOAM531iqzff1cAlAU97hVhfidLAinJRwh1xDXqSq7SIAFL8vnZ2AgHW
        5/5wIPNPNcLJS25BXLSFTTuZCWQACPBzXEak0Hc=
X-Google-Smtp-Source: ABdhPJzEvjnYd7B0WIGRcPh8gW/FvpiuSCSRc80jOwhBs6SPVLjct24P89mwBuS0aVh2B9zE/pT9CUr0CDpyaw6jaGg=
X-Received: by 2002:a17:903:1cd:b0:154:5edf:5704 with SMTP id
 e13-20020a17090301cd00b001545edf5704mr3481459plh.26.1648090031398; Wed, 23
 Mar 2022 19:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220317234827.447799-1-shy828301@gmail.com> <YjvNzvdcagflTejJ@mit.edu>
In-Reply-To: <YjvNzvdcagflTejJ@mit.edu>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 23 Mar 2022 19:46:59 -0700
Message-ID: <CAHbLzkqTeD_VB0znsBNt8HjjPceqU-uKh6TF3jNVVjZn4dbBLw@mail.gmail.com>
Subject: Re: [v2 PATCH 0/8] Make khugepaged collapse readonly FS THP more consistent
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        darrick.wong@oracle.com, Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 6:48 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Mar 17, 2022 at 04:48:19PM -0700, Yang Shi wrote:
> >
> > The patch 1 ~ 7 are minor bug fixes, clean up and preparation patches.
> > The patch 8 converts ext4 and xfs.  We may need convert more filesystems,
> > but I'd like to hear some comments before doing that.
>
> Adding a hard-coded call to khugepage_enter_file() in ext4 and xfs,
> and potentially, each file system, seems kludgy as all heck.  Is there
> any reason not to simply call it in the mm code which calls f_op->mmap()?

Thanks, Ted. Very good point. I just didn't think of it. I think it is
doable. We may be able to clean up the code further.

>
>                                  - Ted
