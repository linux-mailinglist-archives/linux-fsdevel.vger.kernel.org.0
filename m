Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D40C50A925
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357650AbiDUT2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 15:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377834AbiDUT2E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:28:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807AA193D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 12:25:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so5928778plg.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 12:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qeRjKSXDeJIH0+CQwoCMl5922pNFNUxTvF5aowm8rco=;
        b=n99NELoggPuhcsqKws/Ci4cGpg5aTBJYtQnAe9JU8tBA1qr9ygYOAR+1bDIsNVLV5p
         PzgfBQxai1TPXPdvVFGh9O1CcYKegnrlAPTNYxwYYt07W/JnhKPeV2EssXa5URw7o0Ag
         SbxCXwUC9VpajRWpPiZp096BFjq0Fjh6o1gRqvsaf0QS+Sdy/HmIRHNhWGUZRtzVg3E0
         0z9GCsn/tiJHXCCHr7NILgGmwG4cakwPAGUyQGFLATwnHLGp7l43bBirgfe1702YLJfw
         VHRKT35JWViWbCpUyZM0Orq2vsD7GoyOqWqol0/N/ekRJwk1FNnIIjq8s4maGk+0/XGT
         dCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeRjKSXDeJIH0+CQwoCMl5922pNFNUxTvF5aowm8rco=;
        b=fd7Zv0be96ZpDqvU2e5UGpgMKB6NEtOmOgxQbMAaEiZBHLo8/4bpnM+rYHivXvgnjx
         aN7NvkN+V+PDx6tYLTIXeUMKyH+txTdScjaKD2VX5tu8xoI6OWc/9T+OwXzNg+cofG1j
         HiaiJnTHWjZf9o/2eVqEzFn4UVfQ0D+ahxoLTNy66FQj09pbxTkKOz73NwkMfp/iZnn2
         2QUY6d+p+ZA4zjD64vjcr9Dep3rsmquB0DNb5vfZQrbcmxPDfxUVw8LqkyVjHA5gJNL5
         RuHGCJX83fEXgWDPOBDhPLAjXNud2ihYvPhzTsthEeAOvbXjc6pcGzjvvTyywyFWYE96
         coqw==
X-Gm-Message-State: AOAM53238xLJJRUoqvZFr8koZ+M8EWUUC6sI1yqEIoKs/aTPQlaBEvsJ
        srsbnhM3K+nJCKuhdzEwTBkzYwNXCDP4e4bxtU6oWg==
X-Google-Smtp-Source: ABdhPJyqf0QRE4ybiwrpA4CL2rjYdR9Dfz1kuf/M+oV726c8/KeCCX7M1xEsBCAx988EvXNGhdhdyy5S+lFBAanpVRU=
X-Received: by 2002:a17:90b:4c84:b0:1d2:cadc:4e4d with SMTP id
 my4-20020a17090b4c8400b001d2cadc4e4dmr12075384pjb.8.1650569111988; Thu, 21
 Apr 2022 12:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220420020435.90326-1-jane.chu@oracle.com> <20220420020435.90326-2-jane.chu@oracle.com>
In-Reply-To: <20220420020435.90326-2-jane.chu@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Apr 2022 12:25:00 -0700
Message-ID: <CAPcyv4jMNvgWrh5WMY1gFN3-vKLU4eccXW3CDRrn1+=FY7D5jw@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] acpi/nfit: rely on mce->misc to determine poison granularity
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 19, 2022 at 7:05 PM Jane Chu <jane.chu@oracle.com> wrote:
>
> nfit_handle_mec() hardcode poison granularity at L1_CACHE_BYTES.
> Instead, let the driver rely on mce->misc register to determine
> the poison granularity.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

...I'll add the Fixes: line when applying this.
