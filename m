Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448436E9CAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 21:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjDTTtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 15:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjDTTs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:48:56 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713DF4EEB;
        Thu, 20 Apr 2023 12:48:48 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51efefe7814so1396394a12.3;
        Thu, 20 Apr 2023 12:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682020128; x=1684612128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hSMRCReTvqtVhzznHuB7A9Sa7YpxOxqbCtc68BgIgE=;
        b=GoIwaWRNZp8R808HTRD2raT1Cv8BRnqejXttPEHtds1fb9h/AhpUl9OJJDZbZmKXs5
         ej/EgFXvWbW4w9LKCGU126TWEXFo2+e2QBkYSEiIkVYLkKp1Yq2F3zfrwPr0jqd9Gxuf
         nQBlNGqMhkaoKeGxlQQKNtnQKu8VM9dMoPNkjoNtq2Vl5kaG9YwMIhgPxXoCy36D5FRc
         kTUIUtcABjFyfsXA5LyCQQ3tIc/llbcBmRnzOByhC5xDRPIRsz2ZEK0WecgOzzFd/OBx
         kDyCdn5VDNCWI38ITAGu4oI1U/W4LwSmXRJIn63S/wewHbLIYoRGeaHxay6aEJrk9U+e
         dTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682020128; x=1684612128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hSMRCReTvqtVhzznHuB7A9Sa7YpxOxqbCtc68BgIgE=;
        b=HV53kQQA8qYOs9FrtBbIgudYmaQ0OzjB1q2AB2TRXo1F++WxVRLNXQ7HxPSDbAoByu
         M+XVt1gC4AJcT/7Dzwrfoad4K6DswpcKuNw6bwYLIe1clzvThZBMaSn6mTYdkxvuOESy
         NVAbkm7gEkUN0lBFZlIWtC0r+Rbew8dgPQjsLtKHswl5DMhzwZf5RFxd5ZBT9QEjg6Mc
         EzvEjlmsHWmsr7AqbZlEYsIF0SvEYCOhRki8b/pyB3GQuhRPpvm805flhB/E10bok/nq
         OuGbd9QtKHsnCmBJK7GiWNA3aoh31kgyUuuL0SabrRVIl4NwD83eKQvi812wHVBHELto
         ZEGA==
X-Gm-Message-State: AAQBX9c8Nu2fD+ajR06/VI3t3izdmrJlhjSwNT4Cxf+c5drPDIlspA+U
        z5OuVS+FnEr6djs5O389Ac8=
X-Google-Smtp-Source: AKy350ZtGf0SkVbGCZspaovqfSWXuducYPXYd9oQgGaKPCyMX1ORGiwZ1xJNcQ1I3koOdW1GPF86ng==
X-Received: by 2002:a17:90a:c24a:b0:23d:35d9:d065 with SMTP id d10-20020a17090ac24a00b0023d35d9d065mr2219608pjx.48.1682020127742;
        Thu, 20 Apr 2023 12:48:47 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001a04d27ee92sm1474391plj.241.2023.04.20.12.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 12:48:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Apr 2023 09:48:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable RFC 5/5] cgroup: remove
 cgroup_rstat_flush_atomic()
Message-ID: <ZEGXHvEPsfORq36_@slm.duckdns.org>
References: <20230403220337.443510-1-yosryahmed@google.com>
 <20230403220337.443510-6-yosryahmed@google.com>
 <CALvZod79Au=Fw9MTW7fP0P7KwQQ_NUiKgRHsNUFnv9v61pKnZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod79Au=Fw9MTW7fP0P7KwQQ_NUiKgRHsNUFnv9v61pKnZA@mail.gmail.com>
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

On Thu, Apr 20, 2023 at 12:40:24PM -0700, Shakeel Butt wrote:
> +Tejun
> 
> 
> On Mon, Apr 3, 2023 at 3:03 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Previous patches removed the only caller of cgroup_rstat_flush_atomic().
> > Remove the function and simplify the code.
> 
> 
> I would say let cgroup maintainers decide this and this patch can be
> decoupled from the series.

Looks fine to me but yeah please cc me on the whole series from the next
round.

Thanks.

-- 
tejun
