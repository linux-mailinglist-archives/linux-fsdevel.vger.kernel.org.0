Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EA67B3852
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjI2RGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2RGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:06:18 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C8E1A7
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 10:06:16 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68fb85afef4so12257347b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696007176; x=1696611976; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rxYI9ulX5XzPX5XOXonON+SMQGYguOvm0R6V5aclg6A=;
        b=bu1AoD1MBVuaFoU4Kuqjuqz5JwkYDxAb/pFXZk9XNWc31UlGWoURxzrRJKID/C5YQq
         GEenO95S0XOakk+8QV8UB7b5BzrBZ6AmxiUv10KSb1orI0GOiPELysEe8Wuk5eVnd8pN
         qcXdvyBgGUXe5HqINyWSntdWcpSuTAG/sM+cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696007176; x=1696611976;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxYI9ulX5XzPX5XOXonON+SMQGYguOvm0R6V5aclg6A=;
        b=dE3l4+bM+amgC3YmMZBPVY5c/XFafRlVYm2oEox1doUBLK7lfIYcgMXtIvjWq0E0l9
         YLwKUzYigdpgCIzGyF5NS7V7jUb9yTwFlAhRcpdzauqpi7NPOlljmYWTaMTODeRiC9Vs
         vpUE5szne5wvTo2POTizctBlAXNUe7IVo5d7hkoqIylzPdb8dxuuqGfptOZi9OZ9HVAo
         JdpxmeYjCryyAZz8lPGBM6SnXcwAytMThqj05CO2L6G4oOd5Vb3Uu0rtHM6BXvWad3vp
         Q3SMc/zhqHAaOAstb8I83B6eiILLxKz4ZBLBOBg97yLsBBNNHHjVBQWfqkV0yvTermIm
         RfCw==
X-Gm-Message-State: AOJu0YxsY3DlmQWF2KHYrSNjcoQ9ktvGKhf1nxZHwrtrQ/uy9hnG1Zp0
        olO3M7LOom6z+ks8AJyTvuTHNw==
X-Google-Smtp-Source: AGHT+IEEm0cgYM95RhBy+hVCohyjsNc4BHxivmWx4iHFGWyTUfY+kiazqEJ0Uju7DJ50x2sjMqjMDA==
X-Received: by 2002:a05:6a20:3d04:b0:153:7978:4faa with SMTP id y4-20020a056a203d0400b0015379784faamr5859933pzi.37.1696007176255;
        Fri, 29 Sep 2023 10:06:16 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fk1-20020a056a003a8100b00682868714fdsm15810970pfb.95.2023.09.29.10.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:06:15 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:06:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 4/6] binfmt_elf: Use elf_load() for library
Message-ID: <202309291005.80DD5F55E9@keescook>
References: <20230929031716.it.155-kees@kernel.org>
 <20230929032435.2391507-4-keescook@chromium.org>
 <CAKbZUD1ojuNN_+x6gkxEMsmLOd5KbCs-wfJcMM==b8+k8_uD_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD1ojuNN_+x6gkxEMsmLOd5KbCs-wfJcMM==b8+k8_uD_w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 29, 2023 at 01:12:13PM +0100, Pedro Falcato wrote:
> On Fri, Sep 29, 2023 at 4:24 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > While load_elf_library() is a libc5-ism, we can still replace most of
> > its contents with elf_load() as well, further simplifying the code.
> 
> While I understand you want to break as little as possible (as the ELF
> loader maintainer), I'm wondering if we could axe CONFIG_USELIB
> altogether? Since CONFIG_BINFMT_AOUT also got axed. Does this have
> users anywhere?

I can't even find a libc5 image I can test. :P

I made it non-default in '22:

7374fa33dc2d ("init/Kconfig: remove USELIB syscall by default")

I'm not sure we can drop it entirely, though.

-- 
Kees Cook
