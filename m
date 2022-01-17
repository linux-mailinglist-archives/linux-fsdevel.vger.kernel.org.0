Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E4B49100F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiAQSJh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 13:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbiAQSJg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:09:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3426DC06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 10:09:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d3so60612685lfv.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jan 2022 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCBpQE3+WKAHFckl3pJBbXwBgqjJXxTRTSODJTXYv7Y=;
        b=nbREpN2YaeqLnZMVaW619Kq51fm9aWUkoukudf4cywftKptHH3Vsfw9n/3ft4bAsif
         QQ0w83Cs9R9F4HnP+26UedSOauMchTX03j320ASZUG+JdQ+AoVNLXF7LKPH8dGkqZ4ud
         Znva8zjFyPD6oYjl20ha16uTDgswsNBNsCAAcbYaLHjl5u08RBuldTmQGaOammODmlxI
         sf/cWQ0Dl5+eh8sK7iDN5wIJ6r0DC/3GHw729TSb5Nj1JAlzb9jcsAD9KupZq0vlv8xc
         75Pq2qZ35W4unKVHgfIyr3AeF6SF17TmnWQkb1XUjEiS8Wf90RGI4sQltFBDNykbnG8u
         ORiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCBpQE3+WKAHFckl3pJBbXwBgqjJXxTRTSODJTXYv7Y=;
        b=8K2i/wPjd1aG2bQUx29TR54ILhz379gMmm9fjMR9A7Tm0DVVPs/VwDrHPbNfiXNR4/
         E1JSYdkm071WgHypTGl7APFF01+CZbxxhf1Z+kFG2eHxCcA4Uzn5Dj/LPZSbHTnb8BsM
         v0+hr4DhfZLBXrYRJsYBl6ugPhZNAnau0s6m+XNoItxeYq9jU1n6zK6OpJ6i+fDK1xzb
         KK0nJM5ME7HPqEdaiHSIeRFJRE3nTyhN2+eCC6gup7RYRTpZI8SVFZqqaGnTRMuVl0QU
         PxGaUINsT099RG5onU2hCUoFYmj91NyieJnUTNANxxpeXPGAxxc59Veu6Ip1390GwTt5
         W1bw==
X-Gm-Message-State: AOAM531cX5CNwO5ig6epXs/XrpwDeCofmvIhCz6+N1sWYDaSoKv2+lc2
        tESLaBk90C2VyuTdwXsN7ml4xzjdeLTeTCdKcHq/LQ==
X-Google-Smtp-Source: ABdhPJzQDt9oG1pDNP+UePVmsbqVilT0eCroclyIpQ16Rn8UweQ7upS1R2bO7ir2v+uIbj3n61q3iqwI7YQKMRhMrjE=
X-Received: by 2002:a05:6512:2629:: with SMTP id bt41mr17727678lfb.264.1642442974365;
 Mon, 17 Jan 2022 10:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20220115144150.1195590-1-shakeelb@google.com> <YeUXcK3/6vIXw7Ju@infradead.org>
In-Reply-To: <YeUXcK3/6vIXw7Ju@infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 17 Jan 2022 10:09:22 -0800
Message-ID: <CALvZod7=CSNqjPNdgFsESxDNKb2ovyyQv8sM_YE=_EXK8W6_3Q@mail.gmail.com>
Subject: Re: [PATCH] mpage: remove ineffective __GFP_HIGH flag
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 16, 2022 at 11:15 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> FYI, I have a patch removing mpage_alloc entirely as part of a bio
> allocation refactoring series about to be sent out.  So while your
> analysis here is correct I'd prefer to hold this as the issue goes away
> entirely.

SGTM
