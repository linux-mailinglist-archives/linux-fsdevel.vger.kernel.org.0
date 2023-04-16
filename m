Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F1F6E3BB9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjDPTv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 15:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPTv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:51:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A2CA
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 12:51:57 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-54ee0b73e08so401511317b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Apr 2023 12:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681674716; x=1684266716;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XV1SaR4oDj2LmHIYbtEP9BS2GzUn6i8QGpmiK2pWes=;
        b=35GxN9QmW2hjy0Dfkmb2w05f+ZtVlxILgN7uYJpNWJLcIPK3szAO7GVlFCTIxLRIFw
         ovaBhQJgVADB9Q6ICg7hyMv/NAh8j0wq800X9YdYJ/dDjbdghw8JokHMRoEQNsIdRkdC
         WLiQXpG4Q+TttdZCcEbXfxWBxXC2GFAHRO1LtQZQgEpcMxrKREN4Avy2QCWCb6+mN3qa
         FRLCFpSJV0ak+dFRGggbPcpzGTkIvZjikma5vN7FHtcFbl8p3SNMYoZ+VAOk0dtr67BG
         CWcPeQAuI2DkTnaae9/D0Af3q8cBuCh0xrhWT3C7wipnfK4eVsi6qPFipvyeb/FiaUE3
         Z2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681674716; x=1684266716;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XV1SaR4oDj2LmHIYbtEP9BS2GzUn6i8QGpmiK2pWes=;
        b=JZUJBopgNR8QILASmPkdGwWoLUvkEjmq/8KBdu4HRrUDmr46pkN2GuQ1n50tIrT35H
         lNFd9h8VYowY2gCraxoSdmcJBk0af8Q2lpBqdKvxqfTrXfA8ACNo1vulvA2qMjPFDky7
         8bmQrBd4+KNBUjoIDaaP21x18Q3SF4Chq25u4+RCGQHsUGipLsytwbtP19gJ7RjJG5gd
         lgb5kbH5vdFtthCXv1oK1mmsdAB0FMMRA4pVoIUExdTalWqP3ixx+xKwAIZkH5mWr1T+
         J2MN5AH615OKDMyJi2vkNL7wxeD8o/DlwB8YjWEWh8ypgGw2kNldh77fgIit6Pm8+U8W
         jxvQ==
X-Gm-Message-State: AAQBX9cI4kVHWiV5suZJDkOQhDkkv3sEIXQ3L0wwLZzcmg/4Su0dMImx
        qfR7DeJ+T+06BBCw2ThEFHbhVA==
X-Google-Smtp-Source: AKy350aso6IEsDAN1exazMbmo6Wh+kHtNe004GaFkMaSD4/1/07yu0c9ScNQNbT2abH6NzKDCzhu7g==
X-Received: by 2002:a81:a210:0:b0:54e:ffbd:7a7e with SMTP id w16-20020a81a210000000b0054effbd7a7emr13157859ywg.45.1681674716340;
        Sun, 16 Apr 2023 12:51:56 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 22-20020a810b16000000b0054fae5ed408sm2677063ywl.45.2023.04.16.12.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 12:51:55 -0700 (PDT)
Date:   Sun, 16 Apr 2023 12:51:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Zi Yan <ziy@nvidia.com>
cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?ISO-8859-15?Q?Michal_Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Zach O'Keefe <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] mm: truncate: split huge page cache page to a
 non-zero order if possible.
In-Reply-To: <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
Message-ID: <86864d6c-39d3-d26f-278f-b96e14884541@google.com>
References: <20230403201839.4097845-1-zi.yan@sent.com> <20230403201839.4097845-7-zi.yan@sent.com> <9dd96da-efa2-5123-20d4-4992136ef3ad@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> As this code stands, truncate a 2M huge page at 1M and you get two 1M
> pieces (one then discarded) - nice; but truncate it at 1M+1 and you get
> lots of order 2 (forced up from 1) pieces.  Seems weird, and not worth
> the effort.

I've probably said that wrong: truncate at 1M+1 and you'd get lots of
order 0 pieces.

Hugh
