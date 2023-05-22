Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13B70C89A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 21:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbjEVTkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjEVTj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 15:39:59 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CF9139
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 12:39:52 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2535d86a41bso3495925a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784392; x=1687376392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZNUaQE6VKvjsh7xrkuV4v8D0r55eKxWvK+t0uMsFI8=;
        b=YvKTLXk/IIa+97neDHvl1q9LrImkclAS+7j5d1vJg/hULvqmkzL/+Gq7nFxGecAH4C
         S6V1QO38N/GeSXFB06FEG2Au6/J5Mytjp5dmRPvcR0YzaAISMnjgVwAIcr6iRSKIxmQN
         QJFbmzXyfCR8EYdbyUhTYU0Hk0FCh6i56f560=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784392; x=1687376392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZNUaQE6VKvjsh7xrkuV4v8D0r55eKxWvK+t0uMsFI8=;
        b=ipiMepLeg8Xy4bNmeyRc38+Mdsk2gq1I1DTQV8hwfy4vRYYhln9D0tNrPTTcXDto83
         gIuiP15OAJpMSfcU7NSNDQepKDxkujpVUdOPSZFPXy3RBep6cOnLxYS8q/xWML3w514z
         jsSzRLTmnMvLX3yYrLQ/hAoFBC1TFQz7aV7eW6yB8WOhrU+tJDpc878oxFp/BnyzoMvM
         uMkxABQ9Da+9nAvX1NqBwQOJ7lebRiN3Mz1GPASsYmpn9wlS1Vcxt4oRAXR+sQKU9k+1
         Z1XOsnU9jXVNpyxH5uacuUjPDDXIcU2o6eFcd24joK7tKrHEfCvgXf9gkwvFUzUG0lUq
         9M/A==
X-Gm-Message-State: AC+VfDx3Z5ZNKr4lcan9E239ruCdcuI9+XXvGLL2L5Y8nHX2JniboYh3
        +LJg5LdWBV956cnXb5Lsn2X9Ww==
X-Google-Smtp-Source: ACHHUZ4EpKzUa09Hle/pf2yb2NX+DsxU29dtqawxDs+DN3RESUwjEOptlWwRLaHSygNm5bUpfAxKUA==
X-Received: by 2002:a17:90a:9f8b:b0:255:6ea7:7041 with SMTP id o11-20020a17090a9f8b00b002556ea77041mr3720184pjp.41.1684784391898;
        Mon, 22 May 2023 12:39:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gt18-20020a17090af2d200b0024df6bbf5d8sm4484416pjb.30.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     hdegoede@redhat.com, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:43 -0700
Message-Id: <168478437621.244538.1202856406180337699.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
References: <20230510211146.3486600-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 10 May 2023 21:11:46 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] vboxsf: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/883f8fe87686

-- 
Kees Cook

