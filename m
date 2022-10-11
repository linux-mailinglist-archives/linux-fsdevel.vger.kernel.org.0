Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739785FBBC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 22:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJKUEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 16:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJKUEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:04:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE899B85F
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 13:04:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so7216990pjb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Oct 2022 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iiS31l/93h6KvcIGG20NGCzdtac4WK0XoSGwVDtqYiA=;
        b=TZgbCo5pjCweHSqv6LL9cWbHwxNDv6NIvaHUOpCybGso/qwJcYNU66mtle/dJPV6u9
         ulbiei3IdX92xNcxCWZSHow5YyyDto/a2h7YYeh5bPxt2CVXCzMvJHrysyZByilhzG+o
         JMpk/1+4bE8s6sxfpPUCWRhAWwueKEBochaXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiS31l/93h6KvcIGG20NGCzdtac4WK0XoSGwVDtqYiA=;
        b=zVRFyxrxv4Kcm4BeEGLQdHy+txsn1v2Qoao1R6rzfTs3XcTkz/BFGeQNnuydtmIBaF
         uuYaJmFXfhGlxTH1d/uRqXCMpc/S1KpypFV7cRemfDf7yNzsC/hC0IwEOtfepMuiulas
         1rY1WHglXeFXnTSnz1Lo5ycfWDFnOd8rx30v/nKJO8nLkBYuWh2x7Qg6jMNV2IyB+EU3
         qH1SlZSFdIfcLXEHQctwnPk36piTn+n1SElySCnXLdLbqoEjI2Moftr2CzkgXvUOLwEn
         kEu4Ko51hs2e0+xHIVWZSyoj41kpGcdaSdR5etcn+R537MvWt+MLn0c0S1IduhCdNCEi
         XUJQ==
X-Gm-Message-State: ACrzQf0tGH5OMFi6hxL1jeI1l6UurMU3rfBUhdBjNbtA/zYxzrY4ZCTR
        2OOshF7H7wPppTsMGRCSF7c2MalmSFfHqA==
X-Google-Smtp-Source: AMsMyM7L3RBLFv92acvZmxED1ZGwENjcs6stDtNWL0Qfq5bTTI1QPN8pWlIBQOGIPb7xaLwmrP6ODg==
X-Received: by 2002:a17:902:8215:b0:178:6946:a282 with SMTP id x21-20020a170902821500b001786946a282mr26196205pln.162.1665518645976;
        Tue, 11 Oct 2022 13:04:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o66-20020a17090a0a4800b002033b3875eesm8288744pjo.20.2022.10.11.13.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:04:05 -0700 (PDT)
Date:   Tue, 11 Oct 2022 13:04:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paramjit Oberoi <pso@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/1] pstore/ram: Ensure stable pmsg address with per-CPU
 ftrace buffers
Message-ID: <202210111302.3179DB77@keescook>
References: <20221011183630.3113666-1-pso@chromium.org>
 <20221011113511.1.I1cf52674cd85d07b300fe3fff3ad6ce830304bb6@changeid>
 <202210111209.7F1541F5BE@keescook>
 <CAHqLn7Hd6KaNYA=goS7=dumrG3wZedbV1+ANa+-dZzFPiP_vsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHqLn7Hd6KaNYA=goS7=dumrG3wZedbV1+ANa+-dZzFPiP_vsQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:59:50PM -0700, Paramjit Oberoi wrote:
> > Hm, interesting point. Since only ftrace is dynamically sized in this
> > fashion, how about just moving the pmsg allocation before ftrace, and
> > adding a comment that for now ftrace should be allocated last?
> 
> That is a good idea, and it would solve the problem.
> 
> The only downside is it would break some code that works today because it
> ran in contexts where the pmsg address was stable (no per-cpu ftrace
> buffers, or power-of-two CPUs).

I don't follow? And actually, I wonder about the original patch now --
nothing should care about the actual addresses. Everything should be
coming out of the pstore filesystem.

-- 
Kees Cook
