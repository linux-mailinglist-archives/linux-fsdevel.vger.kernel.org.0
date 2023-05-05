Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD59B6F8566
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 17:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjEEPSd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjEEPSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 11:18:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDCBAD28;
        Fri,  5 May 2023 08:18:31 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab267e3528so13623205ad.0;
        Fri, 05 May 2023 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683299911; x=1685891911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifGe5SCBl6LiTmaKB6IMHqgE/UQtwA/JCHyZLwepmFs=;
        b=LOCvxoCYnbO8vSFTDuslVAoHxOxcX15yndsKlnUvr2wTVi5GO8cUn6SH8zrFLLfgKj
         gctVe7W4+OfqT7r+1idRiG/ru/roEMb6dNrPfky5N9RPinDVOJR3alCNfoDv321FKcok
         GeA+J/uYdMExiKiTKCoyKPGYVr+oQbnl3liZu+wD5qnu+CWQ0QfcPpjO3ir5/1a9fyX9
         NQnXKFocgv2gOwhxEbwbiroRzVebgIWY50njUAsUYR3Wf+B4+ondcckCIzTiX2HLB/Og
         GdYQfKOrWu/ZZhRLoL8huAgdkqz+9WEIokjox6VecuQoiQttNEmUd4E8QYbgAKC1usGg
         HG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299911; x=1685891911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifGe5SCBl6LiTmaKB6IMHqgE/UQtwA/JCHyZLwepmFs=;
        b=dgYeWk6kjxN5Tj+mQZs2zNjaWPeKYxAR9vWak7b+nn3RK7NKqq01t2/YoupbjNI+PV
         sa5FuRXbjE/CTqkxwQMCUY9MJ3VA1Nntclgv8ccIAsyuVLTkAFlOxfzLoGx9XJYJ/n6K
         hYxLtWd67qDMeSq4OhKZW+/l+etxI45KmTX/e3ioA2SrfpsPm4mqnFrOPC+ePs+77fKn
         cOkij+Ea5WAIsW4/68GSAvP2NtW13X1KMh6WC+bKv9uK7rK8eWuNJUjea2hg/ah8Uxdx
         42dM63PsNhPzdyxsnKpaHCriyuosxWabW+avBTL/IZ+l/YHUbeP+03+MxyAYQXE39Pvp
         5w/w==
X-Gm-Message-State: AC+VfDxF+utqOkn+R1ZNDV4baJ/pN77xxtWMBUmqrH/2iTLWzV4ri2xF
        oVR7dhyPGWYxU/3wNOZfFx8=
X-Google-Smtp-Source: ACHHUZ52SvHzNYSS03JP+px8g4n9TWTr5boTMz6H2G0M0V35JmKb9GdqAxbp2/TvvQ4FIojhgqiYFQ==
X-Received: by 2002:a17:902:a583:b0:1aa:f818:7a23 with SMTP id az3-20020a170902a58300b001aaf8187a23mr1917554plb.27.1683299910592;
        Fri, 05 May 2023 08:18:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001aae64e9b36sm1936479plg.114.2023.05.05.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:18:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 05:18:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 1/5] writeback: move wb_over_bg_thresh() call outside
 lock section
Message-ID: <ZFUeRAYMJZQ7J7Ld@slm.duckdns.org>
References: <20230421174020.2994750-1-yosryahmed@google.com>
 <20230421174020.2994750-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421174020.2994750-2-yosryahmed@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 05:40:16PM +0000, Yosry Ahmed wrote:
> wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
> flush, which can be expensive on large systems. Currently,
> wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
> have to do the rstat flush atomically. On systems with a lot of
> cpus and/or cgroups, this can cause us to disable irqs for a long time,
> potentially causing problems.
> 
> Move the call to wb_over_bg_thresh() outside the lock section in
> preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
> The list_empty(&wb->work_list) check should be okay outside the lock
> section of wb->list_lock as it is protected by a separate lock
> (wb->work_lock), and wb_over_bg_thresh() doesn't seem like it is
> modifying any of wb->b_* lists the wb->list_lock is protecting.
> Also, the loop seems to be already releasing and reacquring the
> lock, so this refactoring looks safe.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
