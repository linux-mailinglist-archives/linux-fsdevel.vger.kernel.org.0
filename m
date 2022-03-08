Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990614D1426
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 11:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbiCHKEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 05:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiCHKEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:04:42 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219853FDA5;
        Tue,  8 Mar 2022 02:03:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id z7so18268190oid.4;
        Tue, 08 Mar 2022 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8NyC0HQLRNlBfMnrTVIE2guWnmK/c2ptH5AUAHFhoE=;
        b=gUKXwVM4DNiokUV9ZYCnHg41X1LS3Dy3adlkI2nJY4Nc/cSI+Yf3JAkudlHUndz+d6
         DRlHanNcey/ZMlIFUE80aQ0Y0GGkNzZTPolXV0+x+metDlb1u5M++sL40O/jt/JfesB4
         tVQ+qCAVtFTS7H10MoOJZgpwIwTwnkhPeGtwulYkS2U3j0fG8wW7My7CRuZm0SnwkHrO
         Oi3DGoC6VLoQFtFfFe+/o7SVoX5GBYSLHupz43GQY5wQBQxmkn/Dw3jHS2gqT3YEa77v
         ldGhs7Ko67qc6YAcgVHGiYbsvtfEFnDclkjGQB4ekLVYxJOKIGSoJYOUIDxl7bAWVbit
         v9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8NyC0HQLRNlBfMnrTVIE2guWnmK/c2ptH5AUAHFhoE=;
        b=fuRSKqlyRAhcb3ZWxOFs6laLuwlKO0/d/pG98I8zXsHTzTImQzz0vSjbaD/yAw9SFs
         lwq4juTIwzcoxzHjqiZxvqDAiqKyUKu5owtwTwB3E7EEWPeDLLFbrvSVOndqb2v+Tl34
         ldJRcpdd+tOWk8JrDYy1hojaXtCSVYHHrA7Bnhf7P/UdDn23PAfZOdyDPMjxBl18dniQ
         u2upC5MiuJR74ny7aoj/kM1bdkZXxyfj7KNwC3v6LmegXVESLMB8qNIbOB7Xl0UBdCb7
         5Be2PlYTPQP9WC47Mmv8XU6ILp7d+XTs9NrADUPxPLXqIwJ9x0sUNvq/hSBewyNelZ1r
         lw1g==
X-Gm-Message-State: AOAM530BFqhS76j4C8iwvej3UymY+AmaGhWC6F9tTLFtAj+ssHTLlcsN
        mkhEegk3WN74RP/PGA9kUhexSeqy738GclMB34pCYJ90QFs=
X-Google-Smtp-Source: ABdhPJxQL3pP+7Ccdf8a+03LvzxVaOhhUzFTSrIeaWIMjKjlR4gWZEfvy0VUYWVJ9xIvRS2z+9sYK3o5CKMLbPWoSf8=
X-Received: by 2002:aca:b845:0:b0:2d4:4207:8fd5 with SMTP id
 i66-20020acab845000000b002d442078fd5mr2082731oif.98.1646733825348; Tue, 08
 Mar 2022 02:03:45 -0800 (PST)
MIME-Version: 1.0
References: <20220305160424.1040102-1-amir73il@gmail.com> <20220305160424.1040102-3-amir73il@gmail.com>
In-Reply-To: <20220305160424.1040102-3-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 8 Mar 2022 12:03:33 +0200
Message-ID: <CAOQ4uxg57_c2Y4LMfqgJcE4VNGacHToiSC3PNkvLkDPL72b6Qw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] lib/percpu_counter: add helpers for arrays of counters
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 5, 2022 at 6:04 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Hoist the helpers to init/destroy an array of counters from
> nfsd_stats to percpu_counter library.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/export.c               | 10 ++++++---
>  fs/nfsd/nfscache.c             |  5 +++--
>  fs/nfsd/stats.c                | 37 +++-------------------------------
>  fs/nfsd/stats.h                |  3 ---
>  include/linux/percpu_counter.h | 19 +++++++++++++++++
>  lib/percpu_counter.c           | 27 +++++++++++++++++++++++++
>  6 files changed, 59 insertions(+), 42 deletions(-)
>
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index 668c7527b17e..ec97a086077a 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -334,17 +334,21 @@ static void nfsd4_fslocs_free(struct nfsd4_fs_locations *fsloc)
>  static int export_stats_init(struct export_stats *stats)
>  {
>         stats->start_time = ktime_get_seconds();
> -       return nfsd_percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM);
> +       return percpu_counters_init(stats->counter, EXP_STATS_COUNTERS_NUM, 0,
> +                                   GFP_KERNEL);
>  }
>
>  static void export_stats_reset(struct export_stats *stats)
>  {
> -       nfsd_percpu_counters_reset(stats->counter, EXP_STATS_COUNTERS_NUM);
> +       int i;
> +
> +       for (i = 0; i < EXP_STATS_COUNTERS_NUM; i++)
> +               percpu_counter_set(&stats->counter[i], 0);
>  }
>
>  static void export_stats_destroy(struct export_stats *stats)
>  {
> -       nfsd_percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
> +       percpu_counters_destroy(stats->counter, EXP_STATS_COUNTERS_NUM);
>  }
>
>  static void svc_export_put(struct kref *ref)
> diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> index 0b3f12aa37ff..d93bb4866d07 100644
> --- a/fs/nfsd/nfscache.c
> +++ b/fs/nfsd/nfscache.c
> @@ -150,12 +150,13 @@ void nfsd_drc_slab_free(void)
>
>  static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
>  {
> -       return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
> +       return percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM, 0,
> +                                   GFP_KERNEL);
>  }
>
>  static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
>  {
> -       nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
> +       percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
>  }
>
>  int nfsd_reply_cache_init(struct nfsd_net *nn)
> diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
> index a8c5a02a84f0..933e703cbb3b 100644
> --- a/fs/nfsd/stats.c
> +++ b/fs/nfsd/stats.c
> @@ -84,46 +84,15 @@ static const struct proc_ops nfsd_proc_ops = {
>         .proc_release   = single_release,
>  };
>
> -int nfsd_percpu_counters_init(struct percpu_counter counters[], int num)
> -{
> -       int i, err = 0;
> -
> -       for (i = 0; !err && i < num; i++)
> -               err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
> -
> -       if (!err)
> -               return 0;
> -
> -       for (; i > 0; i--)
> -               percpu_counter_destroy(&counters[i-1]);
> -
> -       return err;
> -}
> -
> -void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
> -{
> -       int i;
> -
> -       for (i = 0; i < num; i++)
> -               percpu_counter_set(&counters[i], 0);
> -}
> -
> -void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
> -{
> -       int i;
> -
> -       for (i = 0; i < num; i++)
> -               percpu_counter_destroy(&counters[i]);
> -}
> -
>  static int nfsd_stat_counters_init(void)
>  {
> -       return nfsd_percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
> +       return percpu_counters_init(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM,
> +                                   0, GFP_KERNEL);
>  }
>
>  static void nfsd_stat_counters_destroy(void)
>  {
> -       nfsd_percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
> +       percpu_counters_destroy(nfsdstats.counter, NFSD_STATS_COUNTERS_NUM);
>  }
>
>  int nfsd_stat_init(void)
> diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
> index 9b43dc3d9991..61840f9035a9 100644
> --- a/fs/nfsd/stats.h
> +++ b/fs/nfsd/stats.h
> @@ -36,9 +36,6 @@ extern struct nfsd_stats      nfsdstats;
>
>  extern struct svc_stat         nfsd_svcstats;
>
> -int nfsd_percpu_counters_init(struct percpu_counter counters[], int num);
> -void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num);
> -void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num);
>  int nfsd_stat_init(void);
>  void nfsd_stat_shutdown(void);
>
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 7f01f2e41304..37dd81c85411 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -46,6 +46,10 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc);
>  int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch);
>  void percpu_counter_sync(struct percpu_counter *fbc);
>
> +int percpu_counters_init(struct percpu_counter counters[], int num, s64 amount,
> +                        gfp_t gfp);
> +void percpu_counters_destroy(struct percpu_counter counters[], int num);
> +
>  static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
>  {
>         return __percpu_counter_compare(fbc, rhs, percpu_counter_batch);
> @@ -109,6 +113,21 @@ static inline void percpu_counter_destroy(struct percpu_counter *fbc)
>  {
>  }
>
> +static inline int percpu_counters_init(struct percpu_counter counters[],
> +                                      int num, s64 amount, gfp_t gfp)
> +{
> +       int i;
> +
> +       for (i = 0; i < num; i++)
> +               counters[i] = amount;

OOPS:

+               counters[i].count = amount;

> +       return 0;
> +}
> +
> +static inline void percpu_counters_destroy(struct percpu_counter counters[],
> +                                          int num)
> +{
> +}
> +
>  static inline void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
>  {
>         fbc->count = amount;
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index ed610b75dc32..f75a45c63c18 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -181,6 +181,33 @@ void percpu_counter_destroy(struct percpu_counter *fbc)
>  }
>  EXPORT_SYMBOL(percpu_counter_destroy);
>
> +int percpu_counters_init(struct percpu_counter counters[], int num, s64 amount,
> +                        gfp_t gfp)
> +{
> +       int i, err = 0;
> +
> +       for (i = 0; !err && i < num; i++)
> +               err = percpu_counter_init(&counters[i], amount, gfp);
> +
> +       if (!err)
> +               return 0;
> +
> +       for (; i > 0; i--)
> +               percpu_counter_destroy(&counters[i-1]);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL(percpu_counters_init);
> +
> +void percpu_counters_destroy(struct percpu_counter counters[], int num)
> +{
> +       int i;
> +
> +       for (i = 0; i < num; i++)
> +               percpu_counter_destroy(&counters[i]);
> +}
> +EXPORT_SYMBOL(percpu_counters_destroy);
> +
>  int percpu_counter_batch __read_mostly = 32;
>  EXPORT_SYMBOL(percpu_counter_batch);
>
> --
> 2.25.1
>
