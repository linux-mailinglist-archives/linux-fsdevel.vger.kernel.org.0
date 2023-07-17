Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07080755B1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 08:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjGQGFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 02:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGQGFH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:05:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903D1E60
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jul 2023 23:05:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6686708c986so4247891b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jul 2023 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689573905; x=1692165905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iB3oxg4/4mcbnuTDOWro6GY3dvlB9Z5x26ldgxnqjpA=;
        b=mh1/gfi8rqLXjEFckVw5ufe+eekYNYVW3f5HITdKcE3yjii43ck8p5lZ8+P6Xexbod
         WN3XOz5Zr84dovT1MfRIc+cmZ1aeeEDfhSvR4fOZ+Ph1WoNWZtoh7nJrkbLrCJfvzajK
         I3lcbNCJtoLbJIStfhS5hVm/UH1r3JMC/7zzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689573905; x=1692165905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iB3oxg4/4mcbnuTDOWro6GY3dvlB9Z5x26ldgxnqjpA=;
        b=g3WPL8nUniPuNpMuv4yrYJJjoEb+WCg9ODJCcN3yaFxzIYLD4R8Fkd9XmePmUb3941
         C065zpNqMAY+AWn1aG95wUzmO3+V8K82HDVfEpZrVqeMB5/lwo+T1C1Dn07l+Y1G8ArY
         dwP/UiSFSv0fDVUWbOMpZ3hT3qtUSHg8PcQCsVG7LLSWb7PrirfkmOdiQylgTYfbWAiL
         JMbtyH24D616t+0PTRlm087qIBJTQcK7hEiaJWIUTyj/oU5qhe3ceq+z2B7Ce7fU2rMt
         TDXetOTKBmmLk38oX9F9HW8TeUcYIL8xQTf2z/A2Ie08M48DkAs2N/czpAwKpvO/rmbE
         MEuw==
X-Gm-Message-State: ABy/qLZT+5fTfVQTmSwPXsyVPjNJNNBK9M0NcDv78GlfxRPyMg9vIqYv
        lmfN0Ei6DgW3B5WOJP+emAptCQ==
X-Google-Smtp-Source: APBJJlEgdzswER/T7NxmKJAFMnxOkCPNy85OYAN1/Ofe2VNuJJnA2ySIVk3bQeWMYFWlWTUhUTNkRQ==
X-Received: by 2002:a17:90a:9b0a:b0:253:340d:77d8 with SMTP id f10-20020a17090a9b0a00b00253340d77d8mr10301584pjp.33.1689573904973;
        Sun, 16 Jul 2023 23:05:04 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 95-20020a17090a0fe800b00263f6687690sm4664525pjz.18.2023.07.16.23.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:05:04 -0700 (PDT)
Date:   Mon, 17 Jul 2023 15:05:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     huzhi001@208suo.com, Petr Mladek <pmladek@suse.com>
Cc:     tglx@linutronix.de, senozhatsky@chromium.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Fix four errors in kmsg.c
Message-ID: <20230717060500.GB57770@google.com>
References: <tencent_053A1A860EFB7AAD92B2409B9D5AE06AB507@qq.com>
 <2f88487fa9f29eeb5a5bd4b6946a7e4c@208suo.com>
 <ZLEF16qgcTOaLMIk@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLEF16qgcTOaLMIk@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (23/07/14 10:22), Petr Mladek wrote:
> On Fri 2023-07-14 14:57:59, huzhi001@208suo.com wrote:
> > The following checkpatch errors are removed:
> > ERROR: "foo * bar" should be "foo *bar"
> > ERROR: "foo * bar" should be "foo *bar"
> > ERROR: "foo * bar" should be "foo *bar"
> > ERROR: "foo * bar" should be "foo *bar"
> 
> Please, do not do fix these cosmetic issues reported by checkpatch.pl.
> It is not worth the effort. In fact, it is contra productive.
> It complicates the git history, backports.

Absolutely agree with Petr.

As a side note, I wonder if checkpatch can deprecate that -f option?
