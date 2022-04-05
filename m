Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC82B4F4CFE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353803AbiDEXg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbiDEUTB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 16:19:01 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BD9633B2
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Apr 2022 12:59:54 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d15-20020a9d72cf000000b005cda54187c3so293737otk.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Apr 2022 12:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=vsB0AuI21Kofyvp/riTyvNd4coqIjgD81UccFUtHY1Y=;
        b=Rkj/0laop7KLDhsOuGYl3niAtveifqwL5e0lXIyZGGEB1m2SyARx3Ci4ExPlECaTkX
         7L2h9PJbcRmLixmWeR7a2H/j38YzUjHGSgu3s57NYqCTEAzbH+sQR9e52MexiSIpH6Vf
         Sv2LAOUWH3J38FPTjKaV4IpEhnKgbI9eUEH4/Hrlg6mcxhzq978HjsCyqxkBMi17ZJfT
         NDFn0g5mtAtXhrDjW6qKOkD0lEYXWzru37r1hI2HBZEPY9Zm8Q3IpgPMvDbaY+TPg7gJ
         awHH5L3kRLCOXBMIwig5z4glyV738Jh6WF+xGDSgZCmyHMAD7I7X1RBLVUE2n9BROIk3
         yD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=vsB0AuI21Kofyvp/riTyvNd4coqIjgD81UccFUtHY1Y=;
        b=S3fMZbDPoDp6AahFvVqvjZ+hj7mp46ncnU+A5kg2Myl7tm5/wyh1adzzetjn7osEio
         maVOVkWcvSfDuwz07EnLppFtSzZp04sOV4DfD4PdrL8T+ldcgzVfsO8okeuPe20R7vIY
         smFSvR27/37VnLVgwIHMtAMbxUEeL+cU8xD4PXGx1XLuO5BniLpnL0mNyZOcAYe4/e2w
         7dZjL4+rX1BHfcaP0nsnfQYH8DYbZYroQlJddWGWsSy7eYIj5lsLGhiepQNYsSqi8Zz0
         l9AR+pTy8xPbi9NtrIGRSYg3oLOzUP6ssiom68TFGlO5+OtzBhx879FqK1vn1caMu196
         508g==
X-Gm-Message-State: AOAM533l9F2lu5lTj/CdcQJrjVOjFZ+JD7oE35LYmF+G6LBd00KVwMy6
        aric82MB0cTkVJiyKPVSGxZvJ4is1SwGFQ==
X-Google-Smtp-Source: ABdhPJwzGIRq6HBtLV2yo+jbEAfZXa6Ihlndw2zKxu4l+L+ifFdh57ilwowSntY2zVXQfwdL7la53w==
X-Received: by 2002:a9d:853:0:b0:5b2:617e:e982 with SMTP id 77-20020a9d0853000000b005b2617ee982mr1876988oty.333.1649188793899;
        Tue, 05 Apr 2022 12:59:53 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r129-20020acac187000000b002ef358c6e0esm5643602oif.49.2022.04.05.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 12:59:51 -0700 (PDT)
Date:   Tue, 5 Apr 2022 12:59:41 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>
cc:     hughd@google.com, mpatocka@redhat.com, lczerner@redhat.com,
        djwong@kernel.org, hch@lst.de, zkabelac@redhat.com,
        miklos@szeredi.hu, bp@suse.de, akpm@linux-foundation.org,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Valentin CARON - foss <valentin.caron@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Regression with v5.18-rc1 tag on STM32F7 and STM32H7 based
 boards
In-Reply-To: <481a13f8-d339-f726-0418-ab4258228e91@foss.st.com>
Message-ID: <95a0d1dd-bcce-76c7-97b9-8374c9913321@google.com>
References: <481a13f8-d339-f726-0418-ab4258228e91@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 5 Apr 2022, Patrice CHOTARD wrote:
> 
> We found an issue with last kernel tag v5.18-rc1 on stm32f746-disco and 
> stm32h743-disco boards (ARMV7-M SoCs).
> 
> Kernel hangs when executing SetPageUptodate(ZERO_PAGE(0)); in mm/filemap.c.
> 
> By reverting commit 56a8c8eb1eaf ("tmpfs: do not allocate pages on read"), 
> kernel boots without any issue.

Sorry about that, thanks a lot for finding.

I see that arch/arm/configs/stm32_defconfig says CONFIG_MMU is not set:
please confirm that is the case here.

Yes, it looks as if NOMMU platforms are liable to have a bogus (that's my
reading, but it may be unfair) definition for ZERO_PAGE(vaddr), and I was
walking on ice to touch it without regard for !CONFIG_MMU.

CONFIG_SHMEM depends on CONFIG_MMU, so that PageUptodate is only needed
when CONFIG_MMU.

Easily fixed by an #ifdef CONFIG_MMU there in mm/filemap.c, but I'll hunt
around (again) for a better place to do it - though I won't want to touch
all the architectures for it.  I'll post later today.

Hugh
