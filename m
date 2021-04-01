Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4751351794
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhDARmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbhDARh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8227CC0045E4
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 07:40:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id s21so1276023pjq.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84VhsIYUGXjP4bvTSVVhtBz5aOdDg4WLVMSSjupzcrQ=;
        b=n3/SBRMGVrQAHPKH8CBspegdctivbT4oLgx4A6JGVo06EHnU5N7hrWFWW0Km0ZoYpb
         QIV4pKNKQS+/lR4qQSAdkN0jYIAZXZGXgvrA8BuVBUpgV0JL1lVh8aZS/mD9nHv4iXXO
         LrJPvEyhoI+/msRLROnUYdKWX3W4YENmzJrkSQEwYbOwW+oQacQDDsk1A7YLE7K+Y8IT
         MZhqMUbPG+5d32JiozdF9HDqJVIcaHat4vEVmD6JgkQFDhSwrjzBOsNxrTrSCG061Uwc
         o1TNx0byNAcR9z2UyxaeZ6j+54jhYf4uLOmc3dEQvRdDmsiEzMzeCGYwvw9Rs03l+/cg
         SqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84VhsIYUGXjP4bvTSVVhtBz5aOdDg4WLVMSSjupzcrQ=;
        b=Hhlvn8NX6POEKER452BZAzqDkv80qp1utbT06VUpEfpqCvf2aRkgfD3Fdq1R8O2m3J
         tg5dgQcmZ88XosMS+iXmjgAvz7jwT9givLF4vXc91QvmNshQSLq642gOAvUbhww+W3Dl
         r7wGkQeiz0kh3wDZ6wlrdjYjExFHSBSHa9olp8vuMpD9pUkv3YoPNjbkZZRz2bCMlqtL
         CjeC7yeh2EcQyJnjKZVwkYpX/r773JQV9+Slb0Tz4i77D/14E57f3j5/1K/nhDlMqvd8
         aTY1ukYIMENJzil8x4MaAI8FWP1ZUt/p7p6u3hc68vya0sGZgNztvQSkFBslBTKuMsSR
         0GpA==
X-Gm-Message-State: AOAM531kckWaPod2mbDq/VoKbRh+6NuaTOB1B4hfUC2vC7ZgjHRcGJrP
        Q65N4gqpdmy4tvfUoFnB6rzAzi49DVLJUgoVgIRsVQ==
X-Google-Smtp-Source: ABdhPJxZ6vHJhYB8lWLeKnCmXrKCfcNJ8m/exOcGQnwLMAEZhsAo8xFwga7hZwxyYL5U6ax6PgkGcuZz4MgjyJJC+jo=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr9034123pjv.229.1617288035983;
 Thu, 01 Apr 2021 07:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210401093343.51299-1-songmuchun@bytedance.com>
 <YGWf1C/gIZgs0AhR@dhcp22.suse.cz> <CAMZfGtX9V898aezb-huMEYU_-NjqfL6HbXeaZr2Q2MUa+VG3qQ@mail.gmail.com>
 <YGXaqcLOHjlCkNkt@dhcp22.suse.cz>
In-Reply-To: <YGXaqcLOHjlCkNkt@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 1 Apr 2021 22:39:59 +0800
Message-ID: <CAMZfGtW4W3KUwXOSV-YK3cdc_b09mZF75=Gq1jvR43kcxURxqA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] writeback: fix obtain a reference to a
 freeing memcg css
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, axboe@fb.com,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 10:37 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 01-04-21 21:59:13, Muchun Song wrote:
> > On Thu, Apr 1, 2021 at 6:26 PM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Even if the css ref count is not really necessary it shouldn't cause any
> > > harm and it makes the code easier to understand. At least a comment
> > > explaining why that is not necessary would be required without it
> >
> > OK. I will add a comment here to explain why we need to hold a
> > ref.
>
> I do not think this is necessary. Taking the reference is a standard
> way and I am not sure it requires a comment. I meant to say that not
> having a reference should really have a comment explaining why.

Very Sorry. I got it wrong, thank you for further explanation.

>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
