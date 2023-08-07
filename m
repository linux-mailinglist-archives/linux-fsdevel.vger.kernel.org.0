Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8A772750
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjHGOQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 10:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjHGOQO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:16:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAE810DC
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 07:16:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9338e4695so73297511fa.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691417769; x=1692022569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVE/GJTe1IuiufpABjiYZn1olHI1ifx/I1TivYEBHQg=;
        b=KDeUHSfDD3L4EI9ZDbXXnOCIgf36k4kTiyHRIIffaGRG3HCFl39GcfvKDi2APyBxt9
         uIkOV41JjBWzvcfkl4hWbMoMF6B7yW2N6o4toZetNa+16q9cwIbk8dhp8WLMlbMnqtzs
         lrCcsJN2ho/fqPCpmMmUqd/p18Lc2P1XhR9Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417769; x=1692022569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVE/GJTe1IuiufpABjiYZn1olHI1ifx/I1TivYEBHQg=;
        b=SjI6GXq+nBEv5St2UTFbU2sy/jVRbxI1EwLL9HTd8qwv3I571+jPd+qZ0J2iVIMSml
         dtqBOCRE9p1vSJBaBvPRZjFkHIMbnWmLZP0Sun25E+ep8Z+G+bLh78Gqph0H7LwWpjOh
         XM7MFsckFpzTgzBJW3uGdHspmn/LwQhmbHWm6M5J8AxqnEmc8oaMeukeZA5LLO2c8az/
         6NAN86tGzufi6P/44AMPV9CC/jWbz/jRhw6OuxukjWJ5knE8hRMebLVBeQFmedVbxgGO
         0V47Vxl/wLCx34v0UEYcVfS2DCHi+Ur1Whog6zDaqElsWxT8jlM+HJ1cYKOj0p5+cRK9
         zEuw==
X-Gm-Message-State: AOJu0YzgTcLhjX77TLuZXCCGXkxL8UDSvxn81O2jeHcNMyfwVT+3gayW
        OTLstYvTcfcju8YzgFslmF8cqSAesbe7XY0iCLDsOQ==
X-Google-Smtp-Source: AGHT+IGOrJUhdG+ahMA8bObfIwJouhmkY47ZzUfvTwinDgzhZuBpH+4Q7OaueJuZRAHK8xn8XVlTzjWWvAUYbt+ovvQ=
X-Received: by 2002:a2e:b166:0:b0:2b9:dd3b:cf43 with SMTP id
 a6-20020a2eb166000000b002b9dd3bcf43mr6572529ljm.13.1691417768626; Mon, 07 Aug
 2023 07:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com> <20230807110936.21819-19-zhengqi.arch@bytedance.com>
In-Reply-To: <20230807110936.21819-19-zhengqi.arch@bytedance.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 7 Aug 2023 10:16:03 -0400
Message-ID: <CAEXW_YTKHUeZHWtzeSG5Tt7MscNKjVTScBWkVDkC4Orisa7w=Q@mail.gmail.com>
Subject: Re: [PATCH v4 18/48] rcu: dynamically allocate the rcu-lazy shrinker
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 7, 2023 at 7:36=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.com=
> wrote:
>
> Use new APIs to dynamically allocate the rcu-lazy shrinker.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

For RCU:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel


> ---
>  kernel/rcu/tree_nocb.h | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 5598212d1f27..e1c59c33738a 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1396,13 +1396,6 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, stru=
ct shrink_control *sc)
>
>         return count ? count : SHRINK_STOP;
>  }
> -
> -static struct shrinker lazy_rcu_shrinker =3D {
> -       .count_objects =3D lazy_rcu_shrink_count,
> -       .scan_objects =3D lazy_rcu_shrink_scan,
> -       .batch =3D 0,
> -       .seeks =3D DEFAULT_SEEKS,
> -};
>  #endif // #ifdef CONFIG_RCU_LAZY
>
>  void __init rcu_init_nohz(void)
> @@ -1410,6 +1403,7 @@ void __init rcu_init_nohz(void)
>         int cpu;
>         struct rcu_data *rdp;
>         const struct cpumask *cpumask =3D NULL;
> +       struct shrinker * __maybe_unused lazy_rcu_shrinker;
>
>  #if defined(CONFIG_NO_HZ_FULL)
>         if (tick_nohz_full_running && !cpumask_empty(tick_nohz_full_mask)=
)
> @@ -1436,8 +1430,16 @@ void __init rcu_init_nohz(void)
>                 return;
>
>  #ifdef CONFIG_RCU_LAZY
> -       if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
> -               pr_err("Failed to register lazy_rcu shrinker!\n");
> +       lazy_rcu_shrinker =3D shrinker_alloc(0, "rcu-lazy");
> +       if (!lazy_rcu_shrinker) {
> +               pr_err("Failed to allocate lazy_rcu shrinker!\n");
> +       } else {
> +               lazy_rcu_shrinker->count_objects =3D lazy_rcu_shrink_coun=
t;
> +               lazy_rcu_shrinker->scan_objects =3D lazy_rcu_shrink_scan;
> +               lazy_rcu_shrinker->seeks =3D DEFAULT_SEEKS;
> +
> +               shrinker_register(lazy_rcu_shrinker);
> +       }
>  #endif // #ifdef CONFIG_RCU_LAZY
>
>         if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
> --
> 2.30.2
>
