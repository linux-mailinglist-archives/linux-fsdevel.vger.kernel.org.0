Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1835F3ABC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 02:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJDAio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 20:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiJDAiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:38:03 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B22B29C85
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Oct 2022 17:37:43 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-127dca21a7dso14823668fac.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CupQOeUKXJkWlXPxrTf4vCGbL6f1ZdOjDUJRm8zc9XY=;
        b=MH0NJOASqE96lQWbox702Ai05A2Fb+2DSRXfibN+MwLmlzpCquaztIbFKL0jw6LrdA
         K59NAN8n38yO0UJDR5O/d/2tVPFOUpAjAqi2JRBLeNk7v9W2U5L9pJ5kiTXOZTtzvk7u
         hIO/AVkCbnfKgoGAouXN4uiUn9p9sVKM+c+5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CupQOeUKXJkWlXPxrTf4vCGbL6f1ZdOjDUJRm8zc9XY=;
        b=BkpsYo9657ETSHu0BzDxuJT0bacntOu51znQxElxrFjzHnqoXKJW22L3JUo91L5qhQ
         pBAE706t4PgBkLOmmww1yZNhkemp6HrEVGnXFFsSVoJMMeXX3D0EIJGspz1Bf2REaT3P
         daTFiUkNu/6UD8O79JWUAzm98WbgdT59LJQ3ItXUdCrLFVm6xPbaUSB8ZUXX1kYbYbq4
         JuXeZoRrVVG3VKj+qMTrJrWYgXjnpU8wWyA4aYGVDU9VVt4ofl24Uza18IAcq0kTbDHH
         cAYt81QLpzDNFhn1gzrSrrrs0wVIkT2HM/NnO5fL65yHRvTIv7c+2o8u2iyL5rG2Mmuy
         W4+w==
X-Gm-Message-State: ACrzQf2f0IEoeGnWkOSjuLhgTV/YE+tKTnPyR7L9wG7qBO4em7T1jBdm
        Ca2+jj6bTtjhA2qyE7kDk4nhCPd9JbQ6bw==
X-Google-Smtp-Source: AMsMyM4AR6jzgnTPIY+GeSejxe9YHQjn+TZO2+ujr/sWx9xhNsI0ydV61UO+Mzqy1b91yVR5MQPQ+Q==
X-Received: by 2002:a05:6870:ea84:b0:10d:fabe:9202 with SMTP id s4-20020a056870ea8400b0010dfabe9202mr6556994oap.294.1664843862055;
        Mon, 03 Oct 2022 17:37:42 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id t188-20020aca5fc5000000b0034fbbce2932sm2768349oib.42.2022.10.03.17.37.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:37:40 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id l5so12956673oif.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Oct 2022 17:37:40 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr5077414oif.126.1664843859992; Mon, 03
 Oct 2022 17:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV>
 <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com> <Yzt+xvE88/OENka+@ZenIV>
In-Reply-To: <Yzt+xvE88/OENka+@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2022 17:37:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiL2=FfSQx0pHkWAQW29Rc-htDtCouOe6Yp3r5C0tHPwA@mail.gmail.com>
Message-ID: <CAHk-=wiL2=FfSQx0pHkWAQW29Rc-htDtCouOe6Yp3r5C0tHPwA@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 3, 2022 at 5:31 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> OK, incremental is in #fixes, pushed out.

I'm assuming I'll still get a proper pull request. No?

              Linus
