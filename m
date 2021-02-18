Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FFA31EA2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 14:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbhBRNA6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 08:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhBRMjz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 07:39:55 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1275C061786
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 04:39:11 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b3so2818442wrj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Feb 2021 04:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b4Hk9Xkt4Q3LlvCihgo4WN89RwASW9sNa4+yXZPWHPw=;
        b=e2wBy1MEwC/GnkPUKP18oTIaZeV+3cuJQuXXon38Nat/uZM3dk0R0b47WOIe0tSJDk
         5rqG7MssU6N82c00g4XY/bDJNn2rOyyoq2l7UaVohob9V0PgKH4ng+CoWaekt5KnzBXf
         9vFYK65ZKg0hp8mEF4FBAv0A5XJy0Ga3q8wVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b4Hk9Xkt4Q3LlvCihgo4WN89RwASW9sNa4+yXZPWHPw=;
        b=tqyMyFnA4cI4FLZaFk6G8gc36t/wfVRBsMHRRjLgOYbuLnkQj7kU4sTiCWzvxzM6xf
         SdMK6pjlrUbn8iuPfL8Ph/kBn1PdQVuCvINqmxeJvzc37vp1xeZ9VfKDQvKKCiKu91AJ
         pSHNhRYOYNhAFWdJsP6XU0o8liW2LUwN51k/+ikOeocRlS1x0128du4wVmIM1SNMUOC/
         a/eezX7bfEj2t3R5tud3tdpSasoeCcs8fwXkMbSHafaiWzmP52BsXBCR5u+2jSULEAF3
         wQzEqp6YYUk6q8HX4RjQx1k7pStlnnp9iTDqSjC0ZeBo47biemSRXs5lbIJMcJdUED9Y
         bM5A==
X-Gm-Message-State: AOAM532jqJgEM1fBG+Z76Ju4UwygE9TdVQ88geFUqftxktipvove3QCx
        ubh3mBtbi/jUM7VDMLSUAvLpIw==
X-Google-Smtp-Source: ABdhPJwUakPH1ZbGEB2SO4sHsjmVQffVAVDx0FvlBYPTCQdYSSxqg/qebMbkRC6RmykPuzbcG3Ur4g==
X-Received: by 2002:adf:fb51:: with SMTP id c17mr4302952wrs.145.1613651950397;
        Thu, 18 Feb 2021 04:39:10 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::4:f7e9])
        by smtp.gmail.com with ESMTPSA id z63sm7641374wme.8.2021.02.18.04.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 04:39:09 -0800 (PST)
Date:   Thu, 18 Feb 2021 12:39:09 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Felipe Franciosi <felipe@nutanix.com>,
        "shakeelb@google.com" <shakeelb@google.com>
Subject: Re: [RFC PATCH] mm, oom: introduce vm.sacrifice_hugepage_on_oom
Message-ID: <YC5f7SalbXhemwV7@chrisdown.name>
References: <20210216030713.79101-1-eiichi.tsukata@nutanix.com>
 <YCt+cVvWPbWvt2rG@dhcp22.suse.cz>
 <bb3508e7-48d1-fa1b-f1a0-7f42be55ed9c@oracle.com>
 <YCzMVa5QSyUtlmnI@dhcp22.suse.cz>
 <D66DC6A7-C708-4888-8FCF-E4EB0F90ED48@nutanix.com>
 <YC0MiqwCGp90Oj4N@dhcp22.suse.cz>
 <99FF105C-1AAB-40F3-9C13-7BDA23AD89D9@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <99FF105C-1AAB-40F3-9C13-7BDA23AD89D9@nutanix.com>
User-Agent: Mutt/2.0.5 (da5e3282) (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eiichi Tsukata writes:
>>> But that comes with a challenge: despite listening on cgroup for
>>> pressure notifications (which happen from those runtime events we do
>>> not control),
>>
>> We do also have global pressure (PSI) counters. Have you tried to look
>> into those and try to back off even when the situation becomes critical?
>
>Yes. PSI counters help us to some extent. But we've found that in some cases
>OOM can happen before we observe memory pressure if memory bloat occurred
>rapidly. The proposed failsafe mechanism can cover even such a situation.
>Also, as I mentioned in commit message, oom notifiers doesn't work if OOM
>is triggered by memory allocation for kernel.

Hmm, do you have free swap? Without it, we can trivially go from fine to OOM in 
a totally binary fashion. As long as there's some swap space available, there 
should be a clear period where pressure is rising prior to OOM.
