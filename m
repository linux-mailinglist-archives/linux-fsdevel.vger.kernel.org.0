Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06BF74DF22
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 22:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjGJUWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGJUWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:22:12 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D220133;
        Mon, 10 Jul 2023 13:22:09 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ed230c81so4275629b3a.0;
        Mon, 10 Jul 2023 13:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689020529; x=1691612529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVYuNT6EKDwT78XA7oQei5eRW2f7Pj43cJgZHxURJ0M=;
        b=b27G8isFzatJkPEvAH0d48BGZUoyFdMCKbweWfvbVBPqKbzF9JcyLH9MEwO0NY2QrG
         0qdQsJbOFewwEc03KkfZ/gtRabY4hraZtKISxttsRuyUvZXGx5v7DxFABCGJr5Iz0urE
         lbD74g84snd4sMBb3WCdgx+l9bsBYSwXxs5MZaH0aWsfC44+IY6WX2u3LvHRR2Fvd33F
         PIul173VaWZaiSRFzIm2Or9VPJKpWbT+TZaIBUfMetuj2qQYqdEn8nYLm1QvfMyDWdyq
         rznd0fdlTKGjA60hFUyrztVHERHufE/N8V+FxgBD1gb+1xRxg2xHtixyxNlgnCe/EBaF
         YJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020529; x=1691612529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVYuNT6EKDwT78XA7oQei5eRW2f7Pj43cJgZHxURJ0M=;
        b=h7H9pPyBjk7xgpvhWxl2VS+5pbrdhKeAId9FHTDzEp0u92e3/oMcpFKiSh8Uy7TVND
         FWVTpsa9WYVDz1uk5MTwtutXyPIW8qjje1AruquRQYryo7J9knHj6N9ER5UTbhuAeg7E
         +TiID2HkdDWkHMuGrB/V5CLxxs7Lt+PRMP1yySJaTkTSCPpb2LXUryD46Mvj1gNUUlmm
         v9Kd57fAS3Uu/+drGJ5c/YB8s56mphqBqAIiXEiZza/T9pF6civ7z5YCalLPuqnIuKjb
         Y2COBQXu2jvB54UQG8KJAe9iMZLP0XdwnFXv0vsEuJdaqMKMO8W9b9sGqs8V5oJjqwGC
         AQZA==
X-Gm-Message-State: ABy/qLY/Ebv3GPqqwJm19sq+9veWyCPIGlvU/ur5l7emyhaIIGc1RPnc
        jOlrmBWlyHFdJfVlNxyfI1o=
X-Google-Smtp-Source: APBJJlGg63KMt6xiGy7XT7dJsIZ7msfrKBDQsUaA8vRRK6Vgqds35BYFhtZDkAwB8UuUYJbDwrM/Xg==
X-Received: by 2002:a17:903:41c6:b0:1b2:1a79:147d with SMTP id u6-20020a17090341c600b001b21a79147dmr18010380ple.2.1689020528584;
        Mon, 10 Jul 2023 13:22:08 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001b8903d6773sm302475plb.85.2023.07.10.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:22:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Jul 2023 10:22:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     peterz@infradead.org, gregkh@linuxfoundation.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] sched/psi: use kernfs polling functions for PSI
 trigger polling
Message-ID: <ZKxobukY3EbLcks9@slm.duckdns.org>
References: <20230630005612.1014540-1-surenb@google.com>
 <CAJuCfpH1eoB4cb-huqoMOP9M-zzm40pEJPZgSO_9Z8ZP6bRGPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpH1eoB4cb-huqoMOP9M-zzm40pEJPZgSO_9Z8ZP6bRGPQ@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 06:04:15PM -0700, Suren Baghdasaryan wrote:
> This patch is a replacement for the patchset posted at
> https://lore.kernel.org/all/20230626201713.1204982-1-surenb@google.com/
> The original patchset was more appropriate for Tejun's tree but this
> one is mostly touching PSI-related code, so I changed the recipient to
> PeterZ. That said, I would still greatly appreciate inputs from Tejun
> and Greg, and anyone else of course.

Yeah, this looks good to me.

Thanks.

-- 
tejun
