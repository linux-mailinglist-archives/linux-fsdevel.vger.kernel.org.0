Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA576FB518
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 18:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjEHQ3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 12:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjEHQ3g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 12:29:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ECE65BA
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 09:29:31 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-51f10bda596so2139776a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683563371; x=1686155371;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NCAPmpxEboZRCp5DLfCJG8it89iaKWx8exXle5+fDgE=;
        b=A+o0rLnAoFkcu74b0ZTyzM4ELOkmu/fubFOC43V3bUC8SI2ZLvAgDgdLvm7YpNb4iY
         lkDovKqfkqWHqHpHROm2OpwUiBiwkFH0eq41npWZUl0Auxtvlm9TltesUV5gaGCOdjK6
         YZeNqElzkzKVeM4q1kGcoXt0wC6fx/+T09iRE4HSSfLzQrMpX69Es2m2gFqj/lsccwA3
         G+IDS9nQAaFgj/uLiCLVwBBL26UiAwRdZ+quQGoVCbC2LZugLCjsv3wveXeRpElvfrSt
         rbOd8ZsetUR6aYFg8l/NOSvaQOYVs49lC//LrjyPaKtzsYZ8J1y4h8OQcDQgfnmQv9TE
         Esuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683563371; x=1686155371;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCAPmpxEboZRCp5DLfCJG8it89iaKWx8exXle5+fDgE=;
        b=iIJnejpHrQZwTjblmCtIXKGFUwBgUFbV24EmMLYT/S2ET5d5/zL0aiY5OElG+EEHms
         qsidVqk7olsAkeEVSutPu7is6e7hKRys1y8jOGsvLbmtkQBnaVcme84hLplZXxcZawH1
         aOu1RvRn4SjMypvWoS5eu5QiqBfFn7AmR7UF7QmWsq+BXdd5aOEhKT5bKRap2nvYw2AA
         smw99Ifxx3VqnwrsoZR1wEXO2Gl1JoH4oTcjk9SapOv1iPw0a1y+j4OOgULNYk61DFTd
         yWMQwXy9pPgQB5nq6gkVfVIplwrqu9MXj+tbUcM/L8hjJo4rhwr9k9wqWhyJrWwrhLYn
         BBuw==
X-Gm-Message-State: AC+VfDzw5mdfOjfgBK3tdotlMRQwS4ZYfR5WQiKLVfmGyHLiIfe4+QPz
        Js2NZPiqYt5DbisYNRjJM9uu5T+HsEtirCUReQ==
X-Google-Smtp-Source: ACHHUZ76MdGRZaZii/Tb2tEloQqPEW6qT4wxUIpboq08Bq3SCocGXXbj1z+MFqhm9tKSr2oW8q4lKvAUY4lcbA5McQ==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a63:2b04:0:b0:521:62ef:9b38 with SMTP
 id r4-20020a632b04000000b0052162ef9b38mr3198022pgr.3.1683563371206; Mon, 08
 May 2023 09:29:31 -0700 (PDT)
Date:   Mon, 08 May 2023 16:29:29 +0000
In-Reply-To: <20230504001409.GA104105@monkey> (message from Mike Kravetz on
 Wed, 3 May 2023 17:14:09 -0700)
Mime-Version: 1.0
Message-ID: <diqz5y92g51y.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH 2/2] fs: hugetlbfs: Fix logic to skip allocation on hit in
 page cache
From:   Ackerley Tng <ackerleytng@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     willy@infradead.org, sidhartha.kumar@oracle.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        muchun.song@linux.dev, jhubbard@nvidia.com, vannapurve@google.com,
        erdemaktas@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



I wrote a selftest to verify the behavior of page_cache_next_miss() and
indeed you are right about the special case.

I'll continue to look into this to figure out why it isn't hitting in
the page cache.

Thanks Mike!
