Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFCB4DA421
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351767AbiCOUnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiCOUnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:43:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE852B1C
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:41:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n18so126697plg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x2HRjG55PUg/u3UM4Tr3n/OPNpIEJ3hkQ56bvjTB8cc=;
        b=fc96+5KX3uv9vIHja5m9w7eMmKsL9uvKkZkMJeDlEFxaXlOoGOcK108jKNtxs/jin1
         z7ZQV7hsQ0725yoDCA9JqSygHu/MNADXpyOUDFmDocLfQZFb9wcGSbKXmg47zG/xmq2s
         v9PVrbMFnE7Sa56x4BWQdwvh0YAr2p7hCWmRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x2HRjG55PUg/u3UM4Tr3n/OPNpIEJ3hkQ56bvjTB8cc=;
        b=pfz9zPWMXD6YlmI/NP31C1qZK9/T4LSWhx81a2l3onUgXZTy1uTdBbakIUaORStIq/
         2xprmu+2/DvMt/bRCLoigQjBl2bJ97geMPeyoKUtP/iyfXqHPzv6prR0ukm3jgX7fExp
         KgmoEWKldjwNh3QdW3TwqVTBsmiVQFp5b7qT/+eNyRDV8RKkASJi2HwfDKtHgdoEk3TW
         nsLfusjpndFuu15C73uW1VsaHXrBz+wwyLLxNpcJ0t8pduxqG59TxwW3bPzbukMThjRI
         ZyT3q1pzkF8ppUB1xDLQ5lBtOYRi6KYevxtFOYioioNx59fHDJa0aOWY6IxCYtVUkkuw
         mH7w==
X-Gm-Message-State: AOAM533/5uudoOMGvBCNFO96/H7pTbe+WLtML1GybvtShypwXBviTD1l
        xjpyH9Ds7+2mby/hyZrHeZXUBA==
X-Google-Smtp-Source: ABdhPJyuuEGZ83Uzbvo13KYrTnSMbxORc97gIkcaYmq0yqjspypdLR7q8pNlY7mihpUehwWbKA5bTg==
X-Received: by 2002:a17:90b:3e8e:b0:1bf:489a:930d with SMTP id rj14-20020a17090b3e8e00b001bf489a930dmr6681587pjb.214.1647376913973;
        Tue, 15 Mar 2022 13:41:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g24-20020a17090a579800b001c60f919656sm82903pji.18.2022.03.15.13.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:41:53 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:41:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
Message-ID: <202203151340.7447F75BDC@keescook>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
 <20220315201706.7576-2-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220315201706.7576-2-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:17:04PM -0700, Rick Edgecombe wrote:
> In ptrace, the x86_32_regsets and x86_64_regsets are constructed such that
> there are no gaps in the arrays. This appears to be for two reasons. One,
> the code in fill_thread_core_info() can't handle the gaps. This will be
> addressed in a future patch. And two, not having gaps shrinks the size of
> the array in memory.
> 
> Both regset arrays draw their indices from a shared enum x86_regset, but 32
> bit and 64 bit don't all support the same regsets. In the case of
> IA32_EMULATION they can be compiled in at the same time. So this enum has
> to be laid out in a special way such that there are no gaps for both
> x86_32_regsets and x86_64_regsets. This involves creating aliases for
> enum’s that are only in one view or the other, or creating multiple
> versions like in the case of REGSET_IOPERM32/REGSET_IOPERM64.
> 
> Simplify the construction of these arrays by just fully separating out the
> enums for 32 bit and 64 bit. Add some bitsize-free defines for
> REGSET_GENERAL and REGSET_FP since they are the only two referred to in
> bitsize generic code.
> 
> This should have no functional change and is only changing how constants
> are generated and named. The enum is local to this file, so it does not
> introduce any burden on code calling from other places in the kernel now
> having to worry about whether to use a 32 bit or 64 bit enum name.
> 
> [1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Have you verified there's no binary difference in machine code output?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
