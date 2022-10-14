Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D995FF08C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 16:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiJNOrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Oct 2022 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNOrN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCF910A7ED;
        Fri, 14 Oct 2022 07:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BF2261B8F;
        Fri, 14 Oct 2022 14:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC2CC43142;
        Fri, 14 Oct 2022 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665758831;
        bh=VJwQySFdRGFPCBd4Ml53QivsdMbpYMCvrYEubw3X5VA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ieGqkBYc5cXIeEZoGfymuYbOW9ebXYjeZ0UGKNdtYSfkIuoS4OTGWYKeUJ7N+jX0C
         ouUyjRgvt+KAkoNrSIQbtbGB/2rGdc6IKgRsgBP1wQdJp0fK9H4kkAsOzK9vP63e+v
         cMXXjZcupQ5hpjZn0uYM0K1PgsTP5Izn2rBo84LqmO2MXU8KGC10OJGCY277XTsVgS
         S/xhWRsapx+5RUKpDOwnzaZAKDY8tf8nSWIDlZMKP3HjjPhp5xjovWq9v6/gVO6naJ
         kCyf50qXAIion/CDn9oDz0pmj5IkfiONFIdR2VIm3v7KHBqCCBQgxYjRv0Ee7rT9y1
         DhX0DG4M5nrsA==
Received: by mail-lf1-f50.google.com with SMTP id f37so7542226lfv.8;
        Fri, 14 Oct 2022 07:47:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf1f/M0ULGlTcqcXlYKIX6OGP0rSiz/FyS452fIOtc4q4PbAzePf
        tng+sNAJgN7+xc6ZbN5Y7VsQe24Q4pfd9xbSLho=
X-Google-Smtp-Source: AMsMyM6MzlL7rg2UudUMUW7YFwkLl+bSnkojouPRZ0ZXDfFzxUJyPYNBO5veOgEOFHbidgTJB4MwPWn/Xx7e1jOzYMc=
X-Received: by 2002:ac2:4c47:0:b0:4a2:c07b:4b62 with SMTP id
 o7-20020ac24c47000000b004a2c07b4b62mr1747771lfk.426.1665758829498; Fri, 14
 Oct 2022 07:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210648.137452-1-gpiccoli@igalia.com> <20221013210648.137452-2-gpiccoli@igalia.com>
In-Reply-To: <20221013210648.137452-2-gpiccoli@igalia.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 14 Oct 2022 16:46:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGe++psjOmmztkNY2KeGAGD3DD8F_spG0F37+4vu6dwBw@mail.gmail.com>
Message-ID: <CAMj1kXGe++psjOmmztkNY2KeGAGD3DD8F_spG0F37+4vu6dwBw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] pstore: Alert on backend write error
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 13 Oct 2022 at 23:11, Guilherme G. Piccoli <gpiccoli@igalia.com> wrote:
>
> The pstore dump function doesn't alert at all on errors - despite
> pstore is usually a last resource and if it fails users won't be
> able to read the kernel log, this is not the case for server users
> with serial access, for example.
>
> So, let's at least attempt to inform such advanced users on the first
> backend writing error detected during the kmsg dump - this is also
> very useful for pstore debugging purposes.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>
> V2:
> - Show error message late, outside of the critical region
> (thanks Kees for the idea!).
>
>
>  fs/pstore/platform.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 06c2c66af332..cbc0b468c1ab 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -393,6 +393,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>         const char      *why;
>         unsigned int    part = 1;
>         unsigned long   flags = 0;
> +       int             saved_ret = 0;
>         int             ret;
>
>         why = kmsg_dump_reason_str(reason);
> @@ -463,12 +464,21 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>                 if (ret == 0 && reason == KMSG_DUMP_OOPS) {
>                         pstore_new_entry = 1;
>                         pstore_timer_kick();
> +               } else {
> +                       /* Preserve only the first non-zero returned value. */
> +                       if (!saved_ret)
> +                               saved_ret = ret;
>                 }
>
>                 total += record.size;
>                 part++;
>         }
>         spin_unlock_irqrestore(&psinfo->buf_lock, flags);
> +
> +       if (saved_ret) {
> +               pr_err_once("backend (%s) writing error (%d)\n", psinfo->name,
> +                           saved_ret);
> +       }
>  }
>
>  static struct kmsg_dumper pstore_dumper = {
> --
> 2.38.0
>
