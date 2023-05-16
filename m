Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EB170597F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 23:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEPVcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPVcl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 17:32:41 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896F86EA2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 14:32:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-643bb9cdd6eso12433684b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684272760; x=1686864760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxYdFfNWgH8T3xza0b6h2vTAfCsIMX0iES+NjWywOvA=;
        b=bXzoKWHeThT08/25gYmYH/PwvxAModM/x18sF48hSGj6VfYx3AqwxvU/wbGQ5mK0I8
         8+IV3gwBatiY+/CsiJpzllvn6cxt3Da73Qsi7ikeS1pvjLSFJnKtNdk9H5CtJjTRxk/W
         NlheeFiA1lboSiLgxb1bD8vHNpJviFWLuyTFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684272760; x=1686864760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxYdFfNWgH8T3xza0b6h2vTAfCsIMX0iES+NjWywOvA=;
        b=Q6pyFRK7uylE0vSFl4snG3vNkO+yzyhDuqG7PuCMjSqoQqoHFgf1lXwYsmtrHPUMfI
         4U6wO919C/Gpwf8L5zT3QFbkmlK2WT8+6s3hYAsHMVpZLOGOvu+lBYCmkUK88j/k22im
         SdDDiS7BVM4FaNXliJlrzNFV5teEpn1IAjJq4hrO8h4pevWW2VQfeehbORUX9MTvvw47
         z8ar5tOUXRr9IdhY0qtnasujAeMZLXtz8te4Z0Hp54ro2xIfVheCzCo3HPhFobRdLyc0
         Feunqe+C53xXJoJ018gCG1b5OLhj5Hjueu8GxgyYjwYh3LYAMD6dw/BhbWd3JE/h66nI
         iHsA==
X-Gm-Message-State: AC+VfDyLiU8u/Pfwrb8l9CYVyTfE5h0tltDkPb9bWXWOkfqupixAHtDr
        BSP1m3ErJk+juLapmzeZvgHasw==
X-Google-Smtp-Source: ACHHUZ4VD+Jiit5nBg+95/NhuhCFqpi2Y3R98cX5qgMR2DjWCcb42bHIdO2wn+EhSDv5VMuUlg+loQ==
X-Received: by 2002:a05:6a00:1311:b0:63a:fae3:9890 with SMTP id j17-20020a056a00131100b0063afae39890mr49796503pfu.24.1684272760089;
        Tue, 16 May 2023 14:32:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k14-20020a65464e000000b00530914c3bc1sm8277026pgr.21.2023.05.16.14.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 14:32:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-fsdevel@vger.kernel.org, kexec@lists.infradead.org,
        Al Viro <viro@zeniv.linux.org.uk>, bhe@redhat.com,
        maskray@google.com, ebiederm@xmission.com, brauner@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coredump, vmcore: Set p_align to 4 for PT_NOTE
Date:   Tue, 16 May 2023 14:32:34 -0700
Message-Id: <168427275061.1358677.10611822490555556072.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512022528.3430327-1-maskray@google.com>
References: <20230512022528.3430327-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 May 2023 02:25:28 +0000, Fangrui Song wrote:
> Tools like readelf/llvm-readelf use p_align to parse a PT_NOTE program
> header as an array of 4-byte entries or 8-byte entries. Currently, there
> are workarounds[1] in place for Linux to treat p_align==0 as 4. However,
> it would be more appropriate to set the correct alignment so that tools
> do not have to rely on guesswork. FreeBSD coredumps set p_align to 4 as
> well.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] coredump, vmcore: Set p_align to 4 for PT_NOTE
      https://git.kernel.org/kees/c/60592fb6b67c

-- 
Kees Cook

