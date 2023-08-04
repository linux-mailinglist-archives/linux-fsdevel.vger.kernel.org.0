Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB19E77070D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 19:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjHDR2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjHDR2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:28:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153AB49C1;
        Fri,  4 Aug 2023 10:28:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3159d5e409dso2171908f8f.0;
        Fri, 04 Aug 2023 10:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691170090; x=1691774890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xJurCnFb19/xTjtoQWvlbIXrIzYRUxZWI+vBYnNya6Y=;
        b=lUzBTPdKkEmsXjFsH+m4uEssQONxx92ha5AzO5LlALONSxHVCQa6xTNTdy9+5hhdcK
         C3fr8tq1nUpfHt+F+W5/QmKwkfwdOhxvPp4Ep/8GzeFj8Cgx0ZcD5ZnP/+Mkn3yspV2l
         tSeKIw8EgUGDO73tF3w0qG2AEkiNyHgN2JloDui1z4fVSSqdYhoqzLu0ULKfsgMW46Sb
         fHA9yR6rhJR66ffyXPEj4cmPAnkRAe8Q4qIhS4n5HGj9BED10m0JEbfy2X8oMEy+RhBJ
         RrsYoQdPNr1qnYDxkkO/e/Dxxxzf64G/3KvmNprwOaWp/dsEyyCngJawjeHkr8b/aQ2O
         6qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170090; x=1691774890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJurCnFb19/xTjtoQWvlbIXrIzYRUxZWI+vBYnNya6Y=;
        b=NK+IcyvwVpWC9sHfa8g3W90QFKlGQsjZDmJ5q+67epHcVkiHZKL3g0flKqsLHarcgB
         qtrLiqZUiE3wyNIxyls4w5NOm8hqUMLsmuRbjSV274yPHmf0/E8az+TdUgjTaE2F7bSX
         qOgRsSy3hvL3hqrD5r6c7YLKPy8ob1ETdNavTUqxq0XPYRYq6dBf96Zg+aMK3u0fN0h2
         YKAxjpdVQm9wm28C/2TLe8f4ISWoKCuBAmFRwfXlF+Vko1VxRjFWxxWFfjGLH/EFEioc
         pQGhbPpY1fTFc+k1BupBK8nok5tod22v+b/v39Neu5LBUzs8v/OXokFSbSoRw1z/e1/P
         WO2A==
X-Gm-Message-State: AOJu0YwcFFwh+rPWifn7jgPKzIygB9gx6YGpWMJ7R4ixhZhQZGCKhjo8
        7zKLVIV9WmxxWUvzd7pbqg==
X-Google-Smtp-Source: AGHT+IEyX90MMJYcVkqtrHDU5UbrucNNfHXCFY/L05rBr9zCZl/fJH0VaLfIsD0z8OawFnR+x8GbJQ==
X-Received: by 2002:adf:f8ca:0:b0:317:59a6:6f68 with SMTP id f10-20020adff8ca000000b0031759a66f68mr328336wrq.0.1691170090391;
        Fri, 04 Aug 2023 10:28:10 -0700 (PDT)
Received: from p183 ([46.53.252.19])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d6a46000000b003142e438e8csm2994480wrw.26.2023.08.04.10.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 10:28:10 -0700 (PDT)
Date:   Fri, 4 Aug 2023 20:28:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 2/2] fs/proc: Add /proc/cmdline_image for
 embedded arguments
Message-ID: <aff81f30-e20d-40a0-adb3-893781459475@p183>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-2-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728033701.817094-2-paulmck@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 27, 2023 at 08:37:01PM -0700, Paul E. McKenney wrote:
> In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will show
> all kernel boot parameters, both those supplied by the boot loader and
> those embedded in the kernel image.  This works well for those who just
> want to see all of the kernel boot parameters, but is not helpful to those
> who need to see only those parameters that were embedded into the kernel
> image.  This is especially important in situations where there are many
> kernel images for different kernel versions and kernel configurations,
> all of which opens the door to a great deal of human error.
> 
> Therefore, provide a /proc/cmdline_image file that shows only those kernel
> boot parameters that were embedded in the kernel image.  The output
> is in boot-image format, which allows easy reconcilation against the
> boot-config source file.
> 
> Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
> it makes sense to put it in the same place that /proc/cmdline is located.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  fs/proc/cmdline.c    | 12 ++++++++++++
>  include/linux/init.h | 11 ++++++-----
>  init/main.c          |  9 +++++++++

Same thing,

Please if possible put /proc/x into fs/proc/x.c so that it is easier to
find source. Not all /proc follows this convention but still.

I don't like this name too (but less than the other one).
Is it Boot Image Format (BIF). If yes, maybe add it as /proc/cmdline.bif ?

I don't know what's the good name.
