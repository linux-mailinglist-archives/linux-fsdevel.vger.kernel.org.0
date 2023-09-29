Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB367B3859
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjI2RHJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjI2RHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:07:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED631A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 10:07:05 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1ff5b741cso129706515ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696007225; x=1696612025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AsjkU9sd/Uxf4RtLULirbDyU2qsyvP7kZCyEPcyynys=;
        b=NCeltnBdboNqY3m4comfuM3gPNdZpKk70J0U63U5CxU9ofdtb+QgtlV7crt5UtkpZu
         19p8+eukakv9kyKt1xbgJwenhrj1y51IBU0fMS3CSIfQQ7vP1SBOJ5asgtvaOSxS9LyA
         0iO+ZBAjpfqtA6tUDDah1x6dVEgNaJc9SJURM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696007225; x=1696612025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsjkU9sd/Uxf4RtLULirbDyU2qsyvP7kZCyEPcyynys=;
        b=e0PodfmcFWegaf6kpZPgVjl/xJnG3Yf/X6ASBe4+D8GNwsUliImIyShYUF+2P/rlWc
         bzAJtz2Cnl6CXP8+9NuRWnJsVb7tZCZbn0pu1B4ZZ037H7hfiWGvkB8rVj593izQqC+n
         vHxxYNpoZuOwhxfO0ygjuG6x6eowMI+gFjhZxK3nPdWgnDWfNpzau2CxvZGE6/l4avI0
         JVCm5IQDIsUK4qoh5x9lOTOdRe4CYlp/7jYowoUOeTuE8wEJv2z08yYHqRr8c3/7CYTL
         lQbMvd8uLfFX7FAXpc58M++N2fbaeQm8ApRi68bzOTCwYFMEOSuSpPsPKSCj1XKycGmb
         1YpA==
X-Gm-Message-State: AOJu0YwXZN4ipy6sCuIxgEmPth/TIPgKC5eIXuaAnorgQZuEGM5nJn1S
        F4PxreHyGb8WLlj+Rsl9SjxUHw==
X-Google-Smtp-Source: AGHT+IGoHObC+sZwgjMlD4gRGJqzF6I88du7DuaXRNll+YfQeWUWgm8kyHo8H1I8fA8ubS/sIoCPug==
X-Received: by 2002:a17:903:1ca:b0:1c3:e5bf:a9f8 with SMTP id e10-20020a17090301ca00b001c3e5bfa9f8mr6044483plh.19.1696007224586;
        Fri, 29 Sep 2023 10:07:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b001c5d09e9437sm17218637plb.25.2023.09.29.10.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:07:04 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:07:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
Message-ID: <202309291006.E9FB95D0B@keescook>
References: <20230929031716.it.155-kees@kernel.org>
 <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKbZUD3dxYqb4RSnXFs9ehWymXe15pt8ra232WAD_msJsBF_BQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:58:18PM +0100, Pedro Falcato wrote:
> So on that end, you can take my
> 
> Tested-by: Pedro Falcato <pedro.falcato@gmail.com>

Thanks!

-- 
Kees Cook
