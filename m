Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0D86F856C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 17:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjEEPTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbjEEPTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 11:19:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334924C26;
        Fri,  5 May 2023 08:19:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so2082646b3a.1;
        Fri, 05 May 2023 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683299953; x=1685891953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrpziiuRPJpNoKcFlKlNDYP3hr3GKLDf970mOGtKvuc=;
        b=Fj4FzNjR0Oz19A6ZjISxtRCIB+gQ3mormqowoEF1ln4EAGyvrsBXyRSKbqhyQLC+in
         o5fjKNvQ/yN0VkIUe2FBxZQFo8CuBxoJ2BHDLSjYh8+HdnZ3QVP+E3dS2Plzshy/p0pl
         Hf+Ipbvxtcy7Hi/3cT8d8Gb8J4VkAhSsEMdiy5ZKUcaPh932ZSd20eO3fYebZugEA49X
         mUUklW5aR3Rdjne/IP0kOlzyLqAlnitsZ0Nl/BTITfGcIQAdz5oicdNCa7j+DyuEkA1C
         Vd0a06+ACDVmjHz4Tb9Av8qWUmDjShH/SvaPwFsAA9tTqizN1m3Qn5TBxTXirG2Ivak4
         dJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299953; x=1685891953;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrpziiuRPJpNoKcFlKlNDYP3hr3GKLDf970mOGtKvuc=;
        b=hrOZW/YFg5kxhx+/9L/A8X5HRIqkxVQUDLrPr0jCrpd2/yV4o4b+JuEpnuN1akukFH
         kpr2PX3iarMyqjc8owWSji8SQi+JcYMZzrq0ovxJ7442tjB6Xw5KXQfVLMOSlOT8ZSL8
         b5+CgSkDiHd9P4zFZhFcJJGkJZ7iqV/EhjzYm71+gh1D3ejZ5ZyQS4eT7NHSFGx1prVO
         HLevuO/rdTstnPYH/Zjfn7RPwlb9lKD97rOjrDYUMS14/KlSB+srcmmH4oC/bsphtHSk
         S8nJ7nnnnftFXYwEhLeWEfDj5QKYeLQlD07fKgjABFmQvFpXdguahU2C4ZSVHbqKLzno
         ugaA==
X-Gm-Message-State: AC+VfDylVPKYFLvygS8BCOBYdCLwtvk0YwME+8I3pV/w8DHq3DL936KS
        cLY1p4ZBRc0YfAOFjA9x9Ig=
X-Google-Smtp-Source: ACHHUZ4oWHVbIQ4Y2X7zP+W64RCijgfgCdZHzfbuwUZyVuydxCxdQ1UzZ4jatoAtiD6Cz2rxTAqKgw==
X-Received: by 2002:a05:6a20:1583:b0:f2:3c0e:99fa with SMTP id h3-20020a056a20158300b000f23c0e99famr2447784pzj.26.1683299953266;
        Fri, 05 May 2023 08:19:13 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902b20900b001960706141fsm1939802plr.149.2023.05.05.08.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:19:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 05:19:11 -1000
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
Subject: Re: [PATCH v5 2/5] memcg: flush stats non-atomically in
 mem_cgroup_wb_stats()
Message-ID: <ZFUeb9UNmOETRxYQ@slm.duckdns.org>
References: <20230421174020.2994750-1-yosryahmed@google.com>
 <20230421174020.2994750-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421174020.2994750-3-yosryahmed@google.com>
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

On Fri, Apr 21, 2023 at 05:40:17PM +0000, Yosry Ahmed wrote:
> The previous patch moved the wb_over_bg_thresh()->mem_cgroup_wb_stats()
> code path in wb_writeback() outside the lock section. We no longer need
> to flush the stats atomically. Flush the stats non-atomically.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
