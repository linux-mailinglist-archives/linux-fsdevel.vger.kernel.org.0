Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F008D4C2870
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 10:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiBXJpw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 04:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbiBXJpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:45:50 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20A27DF31;
        Thu, 24 Feb 2022 01:45:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so3090013ejb.4;
        Thu, 24 Feb 2022 01:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2bq1GD0jy9T+yRRISppNcCl5IjRO7UwAkdMEPjekUD4=;
        b=CJKeWGRH84suOvoSjt58KDLWmFmX/vxqR72SQml+AHqPcLbBss5jDWcTr6AM7P9YG+
         +cFxHfRFn49+jra/Fbe23fQ3ItjFw2uQJ3/E1+MqOBNZlQY0H0YimN4jC61KyqZ/bhFq
         Fr14TUI2j5sG4M28ss3+5HsL6dNvfyY7xaoaBUFq6yCSKOpT9mSA4Y0XGrsGI8lcqauD
         RKJEoylC8Emm3Ik6KTnHSdqwYQADVP0OKq5dDEd31LbIAyudOMbcaNqJAIMhmSz3Xbzf
         eFnI+Zq53aXN7hJfLXs1zuCYwNzu/AqctUqlFgW8StCHzzmSbMw0upXx/DworrBaBqAG
         wy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bq1GD0jy9T+yRRISppNcCl5IjRO7UwAkdMEPjekUD4=;
        b=bqRxzqouBUtxh+nS5g/IisLltTI/U+cexJ59eZ2pHDfzZ9I8z9U8t0UtnMkBkLw8+f
         EBlZEBqituqqej/OhPwwfoodQkQcxucfeKQoB5uD6lAiBDCAROgRxeAE6ahPq36IwO34
         tXs5Gh3pv2ObdjNaO3WE/waSm8OrK3qYYQ0tv4Shv+8XyYf6M4I+mAhllXiEakamrOP/
         r3FbZvbqnHziy4Qj9FYL8E0/Laze3silXL3skbIS/lkAfhIyPzxmAmF9Yw0tnSRDKq2X
         E77uv1LY8I+vuHZZfEoRY3pxWNxsHKkRXoJEksTOMMZluquISjIb3Fco5Y2S0RNzS6AQ
         dCXQ==
X-Gm-Message-State: AOAM5310KCC9gqhvp8KvcVjn8ASGvzknLxSqvtIBoqWeHG145TIDMMSr
        5Wjk+B74hR3QAH1JhgGHNHLuusNy+Q==
X-Google-Smtp-Source: ABdhPJyI9AsrwzY4egVw/KkmAwv6B63e+6k98CRk1XQ8KI7+7LLVavtr+Ld0EyoA9Rue9FEoV6rTMw==
X-Received: by 2002:a17:906:dfe9:b0:6cf:7f1d:dddd with SMTP id lc9-20020a170906dfe900b006cf7f1dddddmr1547256ejc.621.1645695919492;
        Thu, 24 Feb 2022 01:45:19 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.11])
        by smtp.gmail.com with ESMTPSA id s6sm1075471ejc.206.2022.02.24.01.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:45:19 -0800 (PST)
Date:   Thu, 24 Feb 2022 12:45:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        David Gow <davidgow@google.com>,
        Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        kunit-dev@googlegroups.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf: Introduce KUnit test
Message-ID: <YhdTrXhu6sgi35WQ@localhost.localdomain>
References: <20220224054332.1852813-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224054332.1852813-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:43:32PM -0800, Kees Cook wrote:
> Adds simple KUnit test for some binfmt_elf internals: specifically a
> regression test for the problem fixed by commit 8904d9cd90ee ("ELF:
> fix overflow in total mapping size calculation").

This can be tested by small 2 segment program run from userspace.
Make 2 segments, swap them, and see executable rejected because mmap
gets too big an area.

	PT_ALEXEY
