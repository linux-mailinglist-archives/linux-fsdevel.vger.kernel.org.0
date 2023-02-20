Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55E69D54B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 21:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjBTUvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 15:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjBTUvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:51:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C727ED5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:51:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id g1so9028762edz.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5FoV6iz+qsHEti0YmCKdm3et15hMt/LBUX5sGM07PY=;
        b=ZLqCns8zkWPZ59uoG1MGmaVNWbez4ixf8sJg90IoueBTbTxz0Bnfiuoiou9/91WlyD
         i7lqLNHl+s8TmNuMYOaCOqA9f2eeksCveWQM2FTm4DBO4M1f+Rog2dsGecxIpaXz0FfZ
         elaiO9K4aT92O7YZaeEzVsw6+bgJaWsw3u7+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5FoV6iz+qsHEti0YmCKdm3et15hMt/LBUX5sGM07PY=;
        b=ycKluZ8KFT54SlQb7gDPGtiO93i+0vvBQGxzrZrjrZur3jo7ljwAh50BiLHWK+zRc6
         NWlDDK+RQlbur2NZdldwRBYhOAFOa1V9tR6O7XA0NBeA6Puoiqdtzd/7Tn12t0YTPnhM
         Y4US4Qp0/t0O5P88LFV3m0R9wyoJ4tPoI1AKsz19uYCb/jkLYXQyeU+C3R/X/4J466/m
         Z9QocFX5eGq51xG6sRTuLs7M42W4thaJQsOTbwls+8t4nkbrhe1SHE6wvYZC73orN6Ka
         6mxllDi+yFIH4V7jdY0AdYEDDD63N97E34f/2LnAI1ul9+UwLJ6co+vmI/5rtF5uDR/+
         V+Jg==
X-Gm-Message-State: AO0yUKX0fRaLBoCr2h/ieKuXknd1IGnYQ2YpXSyzDssVZl/f2xBDsSi1
        Ij8O2Puw+qPvFd5gyKoBd+68nySiuhfpBy5yIis=
X-Google-Smtp-Source: AK7set/Pk1s27LXKQokphP3pTpiSG9RgyJyWhKQpy7+mTN9qhsF3qOINK5SBrZZPbd0gt4nT87SZkQ==
X-Received: by 2002:a17:907:6d05:b0:8a9:e031:c49b with SMTP id sa5-20020a1709076d0500b008a9e031c49bmr11333580ejc.4.1676926304818;
        Mon, 20 Feb 2023 12:51:44 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id fp1-20020a1709069e0100b008cda6560404sm2320273ejc.193.2023.02.20.12.51.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 12:51:44 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id da10so10503945edb.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:51:44 -0800 (PST)
X-Received: by 2002:a17:906:b746:b0:88d:64e7:a2be with SMTP id
 fx6-20020a170906b74600b0088d64e7a2bemr4936768ejb.15.1676926304040; Mon, 20
 Feb 2023 12:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20230217114342.vafa3sf7tm4cojh6@quack3>
In-Reply-To: <20230217114342.vafa3sf7tm4cojh6@quack3>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Feb 2023 12:51:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwuQw=mP2G6qx9M-9GSNU5Ej-Y5E1RJ1Pq+PeCXYzLFQ@mail.gmail.com>
Message-ID: <CAHk-=whwuQw=mP2G6qx9M-9GSNU5Ej-Y5E1RJ1Pq+PeCXYzLFQ@mail.gmail.com>
Subject: Re: [GIT PULL] UDF and ext2 fixes
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 17, 2023 at 3:43 AM Jan Kara <jack@suse.cz> wrote:
>
>   * One fix to mpage_writepages() on which other udf fixes depend

I've pulled this, and this doesn't look *wrong* per se, but it really
didn't look like a bug in mpage_writepages() to me.

The bug seems to be clearly in the filesystem not returning a proper
error code from its "->get_block()" function.

If the VFS layer asks for block creation, and the filesystem returns
no error, but then a non-mapped result, that sounds like _clearly_ a
filesystem bug to me.

Blaming mpage_writepages() seems entirely wrong.

The extra sanity check in the vfs layer doesn't strike me as wrong, but ...

Maybe it could have been a WARN_ON_ONCE() if "get_block(.., 1)"
returns success with an unmapped result?

            Linus
