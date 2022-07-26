Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE055580E4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jul 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiGZHzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jul 2022 03:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZHzG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:55:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882592D1C3;
        Tue, 26 Jul 2022 00:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BD31B8122C;
        Tue, 26 Jul 2022 07:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4FEC341C0;
        Tue, 26 Jul 2022 07:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658822101;
        bh=ac2WrPmEy4oWwjGmJDlp7HjdY4CSvh04Z9eO/4eP5sk=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YulKCCgdhZCEjOCzOGfiwjUl5q1lSgXWVyFxPXstKsHj3zH7AJVnCbRhklH2WXqHf
         fdEbJQcAZ48psbNwZHoksJ8LIiVGVVEYLBAFK907X4b0FEksS21M9Scg3wqrC22oBu
         e1FEjd/0DD8dW+f9qdzZeIFiOAQ3JsscmLEcSUfLbB4SBMelDtMJPd/TlZ9fy+GbZl
         yWEQtyVq9aWfrPFmrcTe+Y3StVyp7f8FYyzaMmPS77z58hWFlmVQOhPuMvym3vKwWN
         Bchnl+Ik/52NWoDofhwugmQmGrpztB3BLf7/e/ZRewYsbbp6IR6dvnckbmNEahc6j0
         F9p97uJyR/gAQ==
Received: by mail-wr1-f41.google.com with SMTP id d8so18901604wrp.6;
        Tue, 26 Jul 2022 00:55:01 -0700 (PDT)
X-Gm-Message-State: AJIora/GVuVuW0fjv0t51g08bVXoO5sueMGxX3nE1tlX0NXKtjcRWmbP
        T0YPVLsHttvydiEdlJiXZORF6BRfjVOd56jPcLk=
X-Google-Smtp-Source: AGRyM1tFsabkbMbFAqy5WpNjoJ+eHwS9qaw5ep2ASMUt3FBuvqiRY1Vpeyw0kuUfMQ4YWo4CzXybKNB5+QfTFOhVmhg=
X-Received: by 2002:adf:de0d:0:b0:21d:66a1:ad4d with SMTP id
 b13-20020adfde0d000000b0021d66a1ad4dmr10024558wrm.17.1658822100006; Tue, 26
 Jul 2022 00:55:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f7cb:0:0:0:0:0 with HTTP; Tue, 26 Jul 2022 00:54:59
 -0700 (PDT)
In-Reply-To: <871qu8tiys.wl-tiwai@suse.de>
References: <20220722142916.29435-1-tiwai@suse.de> <20220722142916.29435-4-tiwai@suse.de>
 <0350c21bcfdc896f2b912363f221958d41ebf1e1.camel@perches.com>
 <87edyc2r2e.wl-tiwai@suse.de> <CAKYAXd_tohLszyrThNLE5tPHt=2Z8Xtt=hzzEQe3iqf0t549EQ@mail.gmail.com>
 <871qu8tiys.wl-tiwai@suse.de>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 26 Jul 2022 16:54:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8OAQ91dude9_-rWJ1tDCb4NM4rgdASKbmz4Tiu46cdzg@mail.gmail.com>
Message-ID: <CAKYAXd8OAQ91dude9_-rWJ1tDCb4NM4rgdASKbmz4Tiu46cdzg@mail.gmail.com>
Subject: Re: [PATCH 3/4] exfat: Expand exfat_err() and co directly to pr_*() macro
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Joe Perches <joe@perches.com>, linux-fsdevel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-07-26 16:46 GMT+09:00, Takashi Iwai <tiwai@suse.de>:
> On Tue, 26 Jul 2022 09:02:40 +0200,
> Namjae Jeon wrote:
>>
>> 2022-07-23 17:04 GMT+09:00, Takashi Iwai <tiwai@suse.de>:
>> > On Sat, 23 Jul 2022 09:42:12 +0200,
>> > Joe Perches wrote:
>> >>
>> >> On Fri, 2022-07-22 at 16:29 +0200, Takashi Iwai wrote:
>> >> > Currently the error and info messages handled by exfat_err() and co
>> >> > are tossed to exfat_msg() function that does nothing but passes the
>> >> > strings with printk() invocation.  Not only that this is more
>> >> > overhead
>> >> > by the indirect calls, but also this makes harder to extend for the
>> >> > debug print usage; because of the direct printk() call, you cannot
>> >> > make it for dynamic debug or without debug like the standard helpers
>> >> > such as pr_debug() or dev_dbg().
>> >> >
>> >> > For addressing the problem, this patch replaces exfat_msg() function
>> >> > with a macro to expand to pr_*() directly.  This allows us to create
>> >> > exfat_debug() macro that is expanded to pr_debug() (which output can
>> >> > gracefully suppressed via dyndbg).
>> >> []
>> >> > diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> >> []
>> >> > @@ -508,14 +508,19 @@ void __exfat_fs_error(struct super_block *sb,
>> >> > int
>> >> > report, const char *fmt, ...)
>> >> >  #define exfat_fs_error_ratelimit(sb, fmt, args...) \
>> >> >  		__exfat_fs_error(sb, __ratelimit(&EXFAT_SB(sb)->ratelimit), \
>> >> >  		fmt, ## args)
>> >> > -void exfat_msg(struct super_block *sb, const char *lv, const char
>> >> > *fmt,
>> >> > ...)
>> >> > -		__printf(3, 4) __cold;
>> >> > +
>> >> > +/* expand to pr_xxx() with prefix */
>> >> > +#define exfat_msg(sb, lv, fmt, ...) \
>> >> > +	pr_##lv("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>> >> > +
>> >> >  #define exfat_err(sb, fmt, ...)						\
>> >> > -	exfat_msg(sb, KERN_ERR, fmt, ##__VA_ARGS__)
>> >> > +	exfat_msg(sb, err, fmt, ##__VA_ARGS__)
>> >> >  #define exfat_warn(sb, fmt, ...)					\
>> >> > -	exfat_msg(sb, KERN_WARNING, fmt, ##__VA_ARGS__)
>> >> > +	exfat_msg(sb, warn, fmt, ##__VA_ARGS__)
>> >> >  #define exfat_info(sb, fmt, ...)					\
>> >> > -	exfat_msg(sb, KERN_INFO, fmt, ##__VA_ARGS__)
>> >> > +	exfat_msg(sb, info, fmt, ##__VA_ARGS__)
>> >> > +#define exfat_debug(sb, fmt, ...)					\
>> >> > +	exfat_msg(sb, debug, fmt, ##__VA_ARGS__)
>> >>
>> >> I think this would be clearer using pr_<level> directly instead
>> >> of an indirecting macro that uses concatenation of <level> that
>> >> obscures the actual use of pr_<level>
>> >>
>> >> Either: (and this first option would be my preference)
>> >>
>> >> #define exfat_err(sb, fmt, ...) \
>> >> 	pr_err("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>> >> #define exfat_warn(sb, fmt, ...) \
>> >> 	pr_warn("exFAT-fs (%s): " fmt "\n", (sb)->s_id, ##__VA_ARGS__)
>> >> etc...
>> >
>> > IMO, it's a matter of taste, and I don't mind either way.
>> > Just let me know.
>> Joe has already said that he prefers the first.
>
> My question was about the preference of the exfat maintainers :)
I also agree with his opinion.
>
>> Will you send v2 patch-set ?
>
> Sure.
Thanks a lot!
>
>
> Takashi
>
