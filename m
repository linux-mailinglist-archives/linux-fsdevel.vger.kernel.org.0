Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB8C74195A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjF1UNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 16:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjF1UNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:13:01 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C00210E
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:12:38 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6b7474b0501so67834a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687983158; x=1690575158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4rTWpAfDqcdZDTILe7jmFb9qWXSX04H9q/bdDWrzoY=;
        b=U4zCCdk957gzYM+H+xsRYEONc6RfAPY01RFg1AsAiC76Nlrzfibh3F8apitW44iD4n
         RUHp1ewjwkT8/07gIW2yd2o6KWfoEsdQ1RsO1okZZ6nH2Mr5kwlGrby0vWUhM9ViRN7t
         13g9BOJ5WDeL79lOybkTWaiBVxSQg1laObVGeO5NhmQS1SQYJYNB5wjLMo1HO0fK6Gz5
         WdLKojwTtKjBN5QFGmMtZvkJreuEo/Brvnxn3Upo5JUokm0wI4OKMDq++dzzSY9+JFo0
         YW0LvwHCBuHdnHsKhCeaX5n+BThhzuEZo0yXHZ3GfqDOIG/IIy3NqjntHu24BBKEIPsN
         To+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687983158; x=1690575158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4rTWpAfDqcdZDTILe7jmFb9qWXSX04H9q/bdDWrzoY=;
        b=BA0g8qKfTVAWJqAEeZeWRcwLyFO2SbQ30EhUWtKFGd+OsWW75HBzSsqkzOz9mZwfpg
         De7VmoCikmjH3GvLGgNBgglQvYY3vusB2oD6bOhMFkL2n/weCJVEc0oadmZvJzSXL80g
         9vkqVnozo5h80SIJZam0vTOdTrXR6+rTSlTPnx7eR1jgQYiG83YOolGvBaPeqWYhwbda
         iqPb9JmxebrP+hfCgXtQ9bugdsGu1cj5zViEFoOukQ5apZUxlsl0AAjLbXDFEbwvGgOh
         QQGKn1C+70BzULrDxX+lCSi9SROEETg2mEEx4Ijjr0GdjXOxGiFhzKhEBLpDeIzkPrml
         NK4g==
X-Gm-Message-State: AC+VfDzL656AqCSmIIZtk0yrPnZgM5NQlZJCou1mdnWfkjt9yZS0QV0a
        ZiPke87zLGqXknVnwjglnPo0xTAusMpbwhHabhfM1Q==
X-Google-Smtp-Source: ACHHUZ6FR3Q+UdlHx+0nHQ1ukoAT7ZW0Bve/Vrx68Gwzk0fbdxOs2iZiizkEs1ms+M358FLBTh7hk80EiL5EDb3sgSQ=
X-Received: by 2002:a9d:6289:0:b0:6b8:8a3b:86be with SMTP id
 x9-20020a9d6289000000b006b88a3b86bemr154556otk.26.1687983157754; Wed, 28 Jun
 2023 13:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAJuCfpG2_trH2DuudX_E0CWfMxyTKfPWqJU14zjVxpTk6kPiWQ@mail.gmail.com>
 <ZJuSzlHfbLj3OjvM@slm.duckdns.org> <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner> <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner> <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner> <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com> <2023062845-stabilize-boogieman-1925@gregkh>
In-Reply-To: <2023062845-stabilize-boogieman-1925@gregkh>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 28 Jun 2023 13:12:23 -0700
Message-ID: <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christian Brauner <brauner@kernel.org>,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Jun 28, 2023 at 11:42=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Wed, Jun 28, 2023 at 11:18:20AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Jun 28, 2023 at 11:02=E2=80=AFAM Tejun Heo <tj@kernel.org> wrot=
e:
> > >
> > > On Wed, Jun 28, 2023 at 07:35:20PM +0200, Christian Brauner wrote:
> > > > > To summarize my understanding of your proposal, you suggest addin=
g new
> > > > > kernfs_ops for the case you marked (1) and change ->release() to =
do
> > > > > only (2). Please correct me if I misunderstood. Greg, Tejun, WDYT=
?
> > > >
> > > > Yes. I can't claim to know all the intricate implementation details=
 of
> > > > kernfs ofc but this seems sane to me.
> > >
> > > This is going to be massively confusing for vast majority of kernfs u=
sers.
> > > The contract kernfs provides is that you can tell kernfs that you wan=
t out
> > > and then you can do so synchronously in a finite amount of time (you =
still
> > > have to wait for in-flight operations to finish but that's under your
> > > control). Adding an operation which outlives that contract as somethi=
ng
> > > usual to use is guaranteed to lead to obscure future crnashes. For a
> > > temporary fix, it's fine as long as it's marked clearly but please do=
n't
> > > make it something seemingly widely useable.
> > >
> > > We have a long history of modules causing crashes because of this. Th=
e
> > > severing semantics is not there just for fun.
> >
> > I'm sure there are reasons things are working as they do today. Sounds
> > like we can't change the ->release() logic from what it is today...
> > Then the question is how do we fix this case needing to release a
> > resource which can be released only when there are no users of the
> > file? My original suggestion was to add a kernfs_ops operation which
> > would indicate there are no more users but that seems to be confusing.
> > Are there better ways to fix this issue?
>
> Just make sure that you really only remove the file when all users are
> done with it?  Do you have control of that from the driver side?

I'm a bit confused. In my case it's not a driver, it's the cgroup
subsystem and the issue is not that we are removing the file while
there are other users. The issue is that kernfs today has no operation
which is called when the last user is gone. I need such an operation
to be able to free the resources knowing that no users are left.

>
> But, why is this kernfs file so "special" that it must have this special
> construct?  Why not do what all other files that handle polling do and
> just remove and get out of there when done?

AFAIU all other files that handle polling rely on f_op->release()
being called after all the users are gone, therefore they can safely
free their resources. However kernfs can call ->release() while there
are still active users of the file. I can't use that operation for
resource cleanup therefore I was suggesting to add a new operation
which would be called only after the last fput() and would guarantee
no users. Again, I'm not an expert in this, so there might be a better
way to handle it. Please advise.
Thanks,
Suren.

>
> thanks,
>
> greg k-h
