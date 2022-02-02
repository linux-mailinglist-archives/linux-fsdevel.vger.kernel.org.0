Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A44A746B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 16:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbiBBPQD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 10:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbiBBPQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:16:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B378C061714;
        Wed,  2 Feb 2022 07:16:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso4878425wmh.4;
        Wed, 02 Feb 2022 07:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xyx4YcrE4z3BHCAOEuga3pXY2rjKc137zdyuqWhKuOM=;
        b=Jm7C99cyec4z66bazUdbfaepkU56S2Rm8BfdjARZZFnPAlPCY2JjD45fNi5ArkDevx
         2cUUFxtcIEboZu+L6f5743Shj1h3wuQayKmy0JZAqrfMiPP8RZ5rtTNlcNcd0VVj7WbC
         DreaMrXPZefuSSo++0RTBt2t+3D2HXR1OuLcnjbN3oPutyIfGDhMiASrRc0oCHaFeewG
         dyV50wC/1ARn7MKZS0392pZrWXFIvk03U13Q4Yt25DH7Z/8pAOyieJrVesAxN4sCgqxs
         tflTU/dB1YgWNcBDs9A2QrCRCPBLgeWtNRZ2VcFaob3ueSLaILSKh702BiS4f83uYXE6
         nufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xyx4YcrE4z3BHCAOEuga3pXY2rjKc137zdyuqWhKuOM=;
        b=VREF6HeScsX6761Wl9ekg0bN7/0Ba2mSyNEpMaa+nT8Q8X0q0YN2/FlUWaUnS1UUGd
         KLZs0H33Ox3SttQgjhKm/Y98c5BizjDqHpLFvHupBnslSXRNEc0P//MG4EUN4wQRVyio
         DtPqVHKRgugtV1bw7Wu3MKI/XdWd/39tV/xsYp96oDkL1O5dBHIM2oHUKaUe3iY8JTE8
         rkKJ4oMdIMSVtoyTaQZONOjX8z9frXFLzUKF9Kal64MbYSY1iuieHEwqsFe4L9KwGYgg
         DsJAN6aSW3ysBgeztcAPVCqNdEvYPo/ykgJM7IXnBbztZsYVJV3Jtl+bdXH79lodnSxu
         GmpA==
X-Gm-Message-State: AOAM530wIuGCdlHledUxh5DZLD0XaDzia+Y3b9mV6k2O75QetOOHZFc0
        FT0oxLg2U7N9dzxWuUX3cg==
X-Google-Smtp-Source: ABdhPJyWGbaaUABtH/hyVAAGBLGuXq3MTw5DLCzV7sRjdtW2leo4+V3sfnENMoemy8bHajCtQvU4kA==
X-Received: by 2002:a1c:4645:: with SMTP id t66mr6262855wma.39.1643814960897;
        Wed, 02 Feb 2022 07:16:00 -0800 (PST)
Received: from localhost.localdomain ([46.53.252.48])
        by smtp.gmail.com with ESMTPSA id o14sm4814945wmr.3.2022.02.02.07.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:16:00 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:15:58 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <YfqgLmk9+4W50EEB@localhost.localdomain>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
 <202201281347.F36AEA5B61@keescook>
 <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:48:16PM -0800, Andrew Morton wrote:
> On Fri, 28 Jan 2022 14:30:12 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > Andrew, can you update elf-fix-overflow-in-total-mapping-size-calculation.patch
> > to include:
> > 
> > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > Cc: stable@vger.kernel.org
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> Done.
> 
> I'm taking it that we can omit this patch ("elf: Relax assumptions
> about vaddr ordering") and that Alexey's "ELF: fix overflow in total
> mapping size calculation" will suffice?

Yes, it is same patch conceptually.
It should work, but those who can't play Bioshock are better test it.
