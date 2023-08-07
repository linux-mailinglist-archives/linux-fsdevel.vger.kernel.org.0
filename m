Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C20F77273F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjHGOO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHGOO5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:14:57 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B31BC
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 07:14:55 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so67248891fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 07:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691417694; x=1692022494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miXhKIkPE3lmozcU/B+jO2gbohIQfxtvXQrL6JQrLaA=;
        b=rUbGf+JZcp35dmq7w8slw0nHgKluYcuW30g35dHvkRNE8GAplx/bmohiweQc5R1m+t
         n8zrOL6x18GLNviLyBdF1SBbwknD+YT0R92Z3r7ozf/LbxR/ZX+oGNC6AweYXTnFy1Td
         qjM3KL4IzdURsMRiax7oRl3ig1sdRDyJ5+2Ck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417694; x=1692022494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miXhKIkPE3lmozcU/B+jO2gbohIQfxtvXQrL6JQrLaA=;
        b=ZdfWRkhJF88WueRPCSgG/dujXYOWxzNP3dE0iPtX/aeZJgsLiVo3lJkiKi3q/6ngPV
         f/zZqPRM/oF294zBxq4as6F9R+4wKjfGuImryG3Fi6LQjuMrfJIRshtC0QLOUA232qRA
         +9hVClS101dk8bJEcP9srD95RkpOxIuuMC1rqI+/N+BXrS1hEEoqGuJsscK5hKU3W9nY
         7vH3FoABQCehj2qvVmdVphl5if+jiHiQJEZC6ndDNQmOpulyvkXHuHFoAjNbfhnyuWoO
         SE4ciVS2n1dsPKida3kXVd+Kxan8OpEGnfEQAJxMK5C9eyfD879CU0ZS+sHwhsJckyl+
         XSbg==
X-Gm-Message-State: AOJu0Yw3KQoHi33D4LD2FZqsSFQUt4o1Ttqy2+VwH8bFH8AAig3TrLN1
        HgUZ8LvvaqEktRQDUlxIGILHvFu2fXAI3j9RJDbpyA==
X-Google-Smtp-Source: AGHT+IEUzxQ8uhfef4Gwj5w4R2S1a/fG2YmFdaAnrERcAODuTjnUg5MW8ffcyCI3WwFTK01hsv/WyE2OTkrmMwFZBOU=
X-Received: by 2002:a2e:9254:0:b0:2b6:dfef:d526 with SMTP id
 v20-20020a2e9254000000b002b6dfefd526mr6547671ljg.11.1691417693488; Mon, 07
 Aug 2023 07:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com> <20230807110936.21819-20-zhengqi.arch@bytedance.com>
In-Reply-To: <20230807110936.21819-20-zhengqi.arch@bytedance.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 10:14:48 -0400
Message-ID: <CAEXW_YQHGBE2kKupLf12BGOEU5GnQsBUtVQcyMnzxUZ4y48QFA@mail.gmail.com>
Subject: Re: [PATCH v4 19/48] rcu: dynamically allocate the rcu-kfree shrinker
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 7, 2023 at 7:17=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
>
> Use new APIs to dynamically allocate the rcu-kfree shrinker.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

For RCU:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel


> ---
>  kernel/rcu/tree.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7c79480bfaa0..3b20fc46c514 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3449,13 +3449,6 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, str=
uct shrink_control *sc)
>         return freed =3D=3D 0 ? SHRINK_STOP : freed;
>  }
>
> -static struct shrinker kfree_rcu_shrinker =3D {
> -       .count_objects =3D kfree_rcu_shrink_count,
> -       .scan_objects =3D kfree_rcu_shrink_scan,
> -       .batch =3D 0,
> -       .seeks =3D DEFAULT_SEEKS,
> -};
> -
>  void __init kfree_rcu_scheduler_running(void)
>  {
>         int cpu;
> @@ -4931,6 +4924,7 @@ static void __init kfree_rcu_batch_init(void)
>  {
>         int cpu;
>         int i, j;
> +       struct shrinker *kfree_rcu_shrinker;
>
>         /* Clamp it to [0:100] seconds interval. */
>         if (rcu_delay_page_cache_fill_msec < 0 ||
> @@ -4962,8 +4956,18 @@ static void __init kfree_rcu_batch_init(void)
>                 INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache=
_func);
>                 krcp->initialized =3D true;
>         }
> -       if (register_shrinker(&kfree_rcu_shrinker, "rcu-kfree"))
> -               pr_err("Failed to register kfree_rcu() shrinker!\n");
> +
> +       kfree_rcu_shrinker =3D shrinker_alloc(0, "rcu-kfree");
> +       if (!kfree_rcu_shrinker) {
> +               pr_err("Failed to allocate kfree_rcu() shrinker!\n");
> +               return;
> +       }
> +
> +       kfree_rcu_shrinker->count_objects =3D kfree_rcu_shrink_count;
> +       kfree_rcu_shrinker->scan_objects =3D kfree_rcu_shrink_scan;
> +       kfree_rcu_shrinker->seeks =3D DEFAULT_SEEKS;
> +
> +       shrinker_register(kfree_rcu_shrinker);
>  }
>
>  void __init rcu_init(void)
> --
> 2.30.2
>
