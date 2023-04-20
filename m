Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB17A6E9C8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 21:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjDTTki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 15:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjDTTkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:40:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB240D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 12:40:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3ef31924c64so911971cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Apr 2023 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682019635; x=1684611635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWz8KeUWsabxybWxiN5KihW65aZnZuzamu2iaxIUYWQ=;
        b=5/j+YFuZMStm9e2iO/ipkrsa2LdUF1SNvtLNHwugoyYSsCQKMQue9JXQIakK2Sw0WU
         Wwjir2Vk1OMmOskjWngO0ESKAMDsptNSuo09gV/5QRZW5W8BQ9iMjvumS1k8RQnoXgOL
         7QkKMY/J5LQkz6+5J4PH84vnF85GhfActqCsLNHBVsQFYF+PvYs6ns1u/RYEmGSx5mPD
         AkN24JBdy2Ucvj2bMd5NJup/cObu22q8uICbnabF/uvOP7KNKI9LF9Jbp+9EshGpOaYQ
         /uKWf57USSlHvXnbQWfPzv0CMy0Ikth4sL9Oquuoc8TlAAtalyron/zEhtRI2r8h4bJv
         5HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682019635; x=1684611635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWz8KeUWsabxybWxiN5KihW65aZnZuzamu2iaxIUYWQ=;
        b=HJijHsBrGhl/laS9J5cQYWAqViVHNR2fXN26aS9F8p10WWc3JY6VvKrxzkNFShBD9W
         sFrEgVWWcZmmWW1B12n+cZGlUwvHkp1AluR4ki1kmI0NUvTAMVCV7m4wkbJffir22SSD
         +MeNUeUd3G/23CnoSP6+LJ33bx0BrBUu+jdcrBEkb/Rl61lC19fXvHXcnvg80yxSpGb1
         wzX2ssmaTumkCLjgGBOrULVDQo+9v78nW+RH/HkN998WP73o7sp7anEd0BYJIO9ydvhB
         OfcF2DttU4TBLF7EYGBOFssAFSwsz1FUqjuNAZJ4G6scKyDQ0OTIsDzU+uII8uC2JNI+
         ZspQ==
X-Gm-Message-State: AAQBX9cl/o/SFiU3NjAbyOZJku9sz7OwD/0xxz7OF3mAShp4qkSidU4/
        40/1kTcWBvbTpF32jrsl5cHUUpKG2CRDYCIfhZtRNA==
X-Google-Smtp-Source: AKy350YYyjDLnJOis5cVdCyQaWcXXZnjOis+Z+PsGdBsYf9K1xzOaD9kfB7G8dc8h9ipA4aFgcl7ilcahwxepQqFxP4=
X-Received: by 2002:a05:622a:1043:b0:3de:b0b0:557c with SMTP id
 f3-20020a05622a104300b003deb0b0557cmr47259qte.18.1682019634988; Thu, 20 Apr
 2023 12:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230403220337.443510-1-yosryahmed@google.com> <20230403220337.443510-6-yosryahmed@google.com>
In-Reply-To: <20230403220337.443510-6-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Apr 2023 12:40:24 -0700
Message-ID: <CALvZod79Au=Fw9MTW7fP0P7KwQQ_NUiKgRHsNUFnv9v61pKnZA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable RFC 5/5] cgroup: remove cgroup_rstat_flush_atomic()
To:     Yosry Ahmed <yosryahmed@google.com>, Tejun Heo <tj@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Tejun


On Mon, Apr 3, 2023 at 3:03=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> Previous patches removed the only caller of cgroup_rstat_flush_atomic().
> Remove the function and simplify the code.


I would say let cgroup maintainers decide this and this patch can be
decoupled from the series.

>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  include/linux/cgroup.h |  1 -
>  kernel/cgroup/rstat.c  | 26 +++++---------------------
>  2 files changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 885f5395fcd04..567c547cf371f 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -692,7 +692,6 @@ static inline void cgroup_path_from_kernfs_id(u64 id,=
 char *buf, size_t buflen)
>   */
>  void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
>  void cgroup_rstat_flush(struct cgroup *cgrp);
> -void cgroup_rstat_flush_atomic(struct cgroup *cgrp);
>  void cgroup_rstat_flush_hold(struct cgroup *cgrp);
>  void cgroup_rstat_flush_release(void);
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index d3252b0416b69..f9ad33f117c82 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -171,7 +171,7 @@ __weak noinline void bpf_rstat_flush(struct cgroup *c=
grp,
>  __diag_pop();
>
>  /* see cgroup_rstat_flush() */
> -static void cgroup_rstat_flush_locked(struct cgroup *cgrp, bool may_slee=
p)
> +static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>         __releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>  {
>         int cpu;
> @@ -207,9 +207,8 @@ static void cgroup_rstat_flush_locked(struct cgroup *=
cgrp, bool may_sleep)
>                 }
>                 raw_spin_unlock_irqrestore(cpu_lock, flags);
>
> -               /* if @may_sleep, play nice and yield if necessary */
> -               if (may_sleep && (need_resched() ||
> -                                 spin_needbreak(&cgroup_rstat_lock))) {
> +               /* play nice and yield if necessary */
> +               if (need_resched() || spin_needbreak(&cgroup_rstat_lock))=
 {
>                         spin_unlock_irq(&cgroup_rstat_lock);
>                         if (!cond_resched())
>                                 cpu_relax();
> @@ -236,25 +235,10 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *=
cgrp)
>         might_sleep();
>
>         spin_lock_irq(&cgroup_rstat_lock);
> -       cgroup_rstat_flush_locked(cgrp, true);
> +       cgroup_rstat_flush_locked(cgrp);
>         spin_unlock_irq(&cgroup_rstat_lock);
>  }
>
> -/**
> - * cgroup_rstat_flush_atomic- atomic version of cgroup_rstat_flush()
> - * @cgrp: target cgroup
> - *
> - * This function can be called from any context.
> - */
> -void cgroup_rstat_flush_atomic(struct cgroup *cgrp)
> -{
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&cgroup_rstat_lock, flags);
> -       cgroup_rstat_flush_locked(cgrp, false);
> -       spin_unlock_irqrestore(&cgroup_rstat_lock, flags);
> -}
> -
>  /**
>   * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
>   * @cgrp: target cgroup
> @@ -269,7 +253,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  {
>         might_sleep();
>         spin_lock_irq(&cgroup_rstat_lock);
> -       cgroup_rstat_flush_locked(cgrp, true);
> +       cgroup_rstat_flush_locked(cgrp);
>  }
>
>  /**
> --
> 2.40.0.348.gf938b09366-goog
>
