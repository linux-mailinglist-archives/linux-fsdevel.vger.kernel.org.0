Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA96AB61F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Mar 2023 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCFFoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 00:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCFFoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 00:44:00 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCE68A53;
        Sun,  5 Mar 2023 21:43:59 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id bp19so6195016oib.4;
        Sun, 05 Mar 2023 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678081438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G3blmO4OTuJouJDAqgjhtGz5rmKBjjr7Lny23sxTPkQ=;
        b=YBfsKiJVUgGZgJn+qLtLdAsdY74xD9tciqi1XoAi0bwgZ6JvyMKrRkhBBtCMaiUvb+
         HpVh4SG1v1agDgxWC6nbm5zb0upiR6h2PuapQRh2iGLwyQ4qoLLd3PdONVbu5i8Fd/PE
         wANeRXvOaQjA7p2JjKuHyLR5cOXCbeFkxxDvU5tg/dFZ0jPBSvulQllvFOY0ORb1avle
         OvXg+vVkZO1hpRRIlCAUDAlONZZqIc4LBF7PVHgP0jC1f26YAwNKYJ+72zFh6XZv33Qo
         SGnLlclgWUVcAz93ebM60EcpSQLaezqjuAkvVAbinpyUuhotE1nEhPH2hmI2xFnG3ZDy
         ylUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678081438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3blmO4OTuJouJDAqgjhtGz5rmKBjjr7Lny23sxTPkQ=;
        b=HoYUtEAVU90PtejycDQJHe/dQGU2HkomgUD4qpSnkZj1v4GlI2EPJAIGfNnyduEKDP
         en+WMBf4JnedBL/KCeBxsWpwHYNfLx1HY3OnBPf9XBrXYrzVj7XIs7NfedNRe1NWxwvo
         2vsALoL4VzxhklZPTJYVZLAwmqNssJEHRcuIZj2ABMpXAt1c1xOcmnVSE9mHVSejrcyr
         Hv+/UtK3ZGp/D55WsJzkGxXuyVnaJ051Gov3w6pyhSGATEXhYKCknYhujvGHc6DVGNF/
         ORp0GG1qP0Wd+eq/Up06z2b0Jzg12DjghYRJEaDkv9+ADMQa/9auZYDGtpfnvre55lgq
         zLLw==
X-Gm-Message-State: AO0yUKVwSNOcExyNW3Nmnh0FFldYhBWkLtLCZxUe9HcQG/nwwXDxM+qc
        iYzyp4RnEHrGrYvQq207Bc0=
X-Google-Smtp-Source: AK7set8319Kc1VjHI7N7B4HWlfW3Wdd+y1hQJ0Ptk1Lc50YJcx7O0qMgv5PqUs8Dxg4Ivqrv/sKsLQ==
X-Received: by 2002:a05:6808:2805:b0:384:2171:2891 with SMTP id et5-20020a056808280500b0038421712891mr4230097oib.36.1678081438448;
        Sun, 05 Mar 2023 21:43:58 -0800 (PST)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id h19-20020a056808015300b00384926684b8sm3502808oie.13.2023.03.05.21.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 21:43:57 -0800 (PST)
Date:   Sun, 5 Mar 2023 21:43:56 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZAV9nGG9e1/rV+L/@yury-laptop>
References: <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop>
 <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop>
 <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
 <ZAOvUuxJP7tAKc1e@yury-laptop>
 <CAHk-=wh2U3a7AdvekB3uyAmH+NNk-CxN-NxGzQ=GZwjaEcM-tg@mail.gmail.com>
 <CAHk-=whEwe1H1_YXki1aYwGnVwazY+z0=6deU-Zd855ogvLgww@mail.gmail.com>
 <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiHp3AkvFThpnGSA7k=KpPbXd0vurga+-8FqUNRbML_fA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 04, 2023 at 03:08:49PM -0800, Linus Torvalds wrote:
> On Sat, Mar 4, 2023 at 1:10 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Whether the end result _works_ or not, I still haven't checked.
> 
> Well, this particular patch at least boots for me for my normal
> config. Not that I've run any extensive tests, but I'm writing this
> email while running this patch, so ..
> 
>            Linus

I didn't test it properly, but the approach looks good. Need some time
to think on implications of the new rule. At the first glance, there
should be no major impact on cpumask machinery. 

It should be very well tested on arm and m68k because they implement
their own bitmap functions.

Please see comments inline.

Thanks,
Yury

[...]

> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 10c92bd9b807..bd9576e8d856 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -50,8 +50,30 @@ static inline void set_nr_cpu_ids(unsigned int nr)
>  #endif
>  }
>  
> -/* Deprecated. Always use nr_cpu_ids. */
> -#define nr_cpumask_bits	nr_cpu_ids
> +/*
> + * The difference between nr_cpumask_bits and nr_cpu_ids is that
> + * 'nr_cpu_ids' is the actual number of CPU ids in the system, while
> + * nr_cpumask_bits is a "reasonable upper value" that is often more
> + * efficient because it can be a fixed constant.
> + *
> + * So when clearing or traversing a cpumask, use 'nr_cpumask_bits',
> + * but when checking exact limits (and when _setting_ bits), use the
> + * tighter exact limit of 'nr_cpu_ids'.
> + *
> + * NOTE! The code depends on any exyta bits in nr_cpumask_bits a always

s/exyta/extra ?
s/a always/as always ?

> + * being (a) allocated and (b) zero, so that the only effect of using
> + * 'nr_cpumask_bits' is that we might return a higher maximum CPU value
> + * (which is why we have that pattern of
> + *
> + *   Returns >= nr_cpu_ids if no cpus set.
> + *
> + * for many of the functions - they can return that higher value).
> + */
> +#ifndef CONFIG_CPUMASK_OFFSTACK
> + #define nr_cpumask_bits ((unsigned int)NR_CPUS)
> +#else
> + #define nr_cpumask_bits	nr_cpu_ids
> +#endif
>  
>  /*
>   * The following particular system cpumasks and operations manage
> @@ -114,7 +136,7 @@ static __always_inline void cpu_max_bits_warn(unsigned int cpu, unsigned int bit
>  /* verify cpu argument to cpumask_* operators */
>  static __always_inline unsigned int cpumask_check(unsigned int cpu)
>  {
> -	cpu_max_bits_warn(cpu, nr_cpumask_bits);
> +	cpu_max_bits_warn(cpu, nr_cpu_ids);
>  	return cpu;
>  }
>  
> @@ -248,16 +270,6 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  #define for_each_cpu(cpu, mask)				\
>  	for_each_set_bit(cpu, cpumask_bits(mask), nr_cpumask_bits)
>  
> -/**
> - * for_each_cpu_not - iterate over every cpu in a complemented mask
> - * @cpu: the (optionally unsigned) integer iterator
> - * @mask: the cpumask pointer
> - *
> - * After the loop, cpu is >= nr_cpu_ids.
> - */
> -#define for_each_cpu_not(cpu, mask)				\
> -	for_each_clear_bit(cpu, cpumask_bits(mask), nr_cpumask_bits)
> -

We can do it like:

    for ((bit) = 0;
         (bit) = find_next_zero_bit((addr), nr_cpumask_bits, (bit)),
         (bit) < nr_cpu_ids;
         (bit)++)

>  #if NR_CPUS == 1
>  static inline
>  unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
> @@ -495,10 +507,14 @@ static __always_inline bool cpumask_test_and_clear_cpu(int cpu, struct cpumask *
>  /**
>   * cpumask_setall - set all cpus (< nr_cpu_ids) in a cpumask
>   * @dstp: the cpumask pointer
> + *
> + * Note: since we set bits, we should use the tighter 'bitmap_set()' with
> + * the eact number of bits, not 'bitmap_fill()' that will fill past the

s/eact/exact

> + * end.
>   */
>  static inline void cpumask_setall(struct cpumask *dstp)
>  {
> -	bitmap_fill(cpumask_bits(dstp), nr_cpumask_bits);
> +	bitmap_set(cpumask_bits(dstp), 0, nr_cpu_ids);
>  }

It should be like:

 +	bitmap_set(cpumask_bits(dstp), 0, nr_cpu_ids);
 +	bitmap_clear(cpumask_bits(dstp), nr_cpu_ids, nr_cpumask_bits);

Because bitmap_set() will not zero memory beyond round_up(nr_cpu_ids, 64).
