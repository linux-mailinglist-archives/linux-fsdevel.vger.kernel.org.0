Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6245B7A2BD7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjIPAVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 20:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjIPAUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:20:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58B3C00
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:18:51 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso4350921e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694823371; x=1695428171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=FGtUYMjDUo/vxqvnL/p+dNQbjJOsMfDK3U2ckYlvp+9DYiXRDoWIjEBXh6VR3StVHn
         G4FTwxGQZ5GWYbDk+lk+BbGQ21FXo///kUv29067Gbg334dPOnB7HfYS70gnDDIfTnmO
         JJ7WKakV/+f4qF+M7EWaRFP+WW16+8Z+GnYEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694823371; x=1695428171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zporDHrE3+uyIwe+VfbiYR93jfa43r8rLTR9B3l5F9o=;
        b=qiBuN3miGfLiSLghvOHYIDXWL/iBy06wTNg5JUAfUNg2RQ3fpSYQoXwGBlunps6fPj
         5anTrAMZ741y51H5aPnhCpyz2jwcP1EU83ciWSg6B6oYKPFR853Lvpve34rhPtGVUvym
         P6wcDR0D7CoEIZYZhFft+dXTY9otRS3Wb+tjotV8iAVCQ+NDmxm9j7K4K5qq9osPiF5r
         cu/A39NCzO70MBPuR4est33iukvP/ny3pJgbXQChjKFu+AcFOMhVUgkDBHwrA2f5OWVR
         VUrAfco+eHi6935FyXhuAd6eWZgyVLhjTRFminrBYoXk59YsqyBhlRYXHWHYYhu1kxYJ
         Ld2A==
X-Gm-Message-State: AOJu0Yzk4XZkmUuNTHonu3tNbB0ZrU52dCshhvjyZ1IVG/Q6a8MQe6hN
        8hfOjOCX2MMvN5GpLXluMce2eLPF5/L4ImI2K8d4u7oW
X-Google-Smtp-Source: AGHT+IE523Z5W6PsfrrWCB/ATy4omE8OlsYVtpdu7ZZXkIu5OH+HvwOD7SpLz1HGvaum9kIng6QZEQ==
X-Received: by 2002:a05:6512:3da6:b0:500:b2f6:592 with SMTP id k38-20020a0565123da600b00500b2f60592mr2688298lfv.50.1694823371327;
        Fri, 15 Sep 2023 17:16:11 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id y21-20020ac255b5000000b00500a297ec4esm802952lfg.102.2023.09.15.17.16.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso4350897e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 17:16:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3113:b0:500:bc14:3e06 with SMTP id
 n19-20020a056512311300b00500bc143e06mr2583654lfb.44.1694823369876; Fri, 15
 Sep 2023 17:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-3-willy@infradead.org>
 <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
In-Reply-To: <CAHk-=wh4=cYh5OC5PiiX_nAQkyViXL21bpmaARduGOLiOOgTyw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 17:15:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Message-ID: <CAHk-=whqZqTYunL-0tn2-khCU1rcZDrTvY4cdFsx_b_bF=xbGw@mail.gmail.com>
Subject: Re: [PATCH 02/17] iomap: Protect read_bytes_pending with the state_lock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 15 Sept 2023 at 17:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
[...]
>         if (unlikely(error))
>                 folio_set_error(folio);
>         else if (uptodate)
>                 folio_mark_uptodate(folio);
>         if (finished)
>                 folio_unlock(folio);
>   }

Note that this then becomes

        if (unlikely(error))
                folio_set_error(folio);
        if (finished)
                folio_unlock(folio, uptodate && !error);
  }

but that change would happen later, in patch 6/17.

             Linus
