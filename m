Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E2C221226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 18:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGOQWu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOQWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:22:49 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93733C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 09:22:49 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e18so2490999ilr.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cMsbk8fG5j4bGVocL9/5tlZNkVQmVlGemFIr4hGZCG8=;
        b=qMIcBGVmvtORRfMXDCH88dh9P+fvkn97flc6uUMtUjgz/ZzRJj7m36D/3mHZnNBtQw
         vMoZu3B86yGmJMVUGI8i5oJTg2claMbGMq1SjrHdcw0ApjCwxlYWhPrljJtSUkpGSSIf
         DW6PcYW09m77K/npUk5bium671EebVLcq2aEsLcByP/hGJLufLpqR89LBb8bXashdwtL
         5CyjZwwzIUAq54OnWpsmOn5+2tI/r9dyADU2zKpwCAiB+Bw1RqKpNV2PGqJNsz/qunHC
         m5z7cC4kWpFTkXyznwhRK301uEoQFuAWcFIGacmVMEt5TvRPSD7xGlIR0S/Jg075nDqJ
         pM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cMsbk8fG5j4bGVocL9/5tlZNkVQmVlGemFIr4hGZCG8=;
        b=bURbz9o32GdrblXwAWB2MHA5SPS7JR0iwrsove5Xd1APG+lkKuvJiwznT2d+y8uWot
         CraRI7v1YAP/QobZFZaWpCGsh+fC57IzTd22lQGKwwVppiAJxDe4oHjeqdNoZxSyUYLo
         Zs4qNIK+KefrViesh45vwjZcl5/jOYmxmXcerLs3SKoSxUDSYGmBbgRdytr5pX+4S2xD
         RPBVvBt5MtEpsg5WI5rJRWwZWa2o72UdkV0Ak4Xkki/uvUN5FpCwvhmZhX9fBQx9l+EM
         Zv+fNBWhFAQWA1rlRA7zYZEvSqhr87554HpBJEH4iTHS47ozFoe5mZSSOYz3lr/w3lZc
         GNNg==
X-Gm-Message-State: AOAM532dx7iRM934/S4agMI4LYZPIVVrKS7mo0Y2e43g5PjYzXq2fW6X
        Yod+j+hqeMhL0pby2LBvhub8ZvoEBpVDQs8KvIec7v2r
X-Google-Smtp-Source: ABdhPJxX7mM6LafqWV3x35t4vhSj82TFfbfLjUCV3w+xG9QFaOmSmNy+8lnEGjV8wv9xXbtcTVDlKovHXE/2BdZvOJY=
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr280309ilj.9.1594830168910;
 Wed, 15 Jul 2020 09:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200708111156.24659-1-amir73il@gmail.com> <20200708111156.24659-20-amir73il@gmail.com>
 <20200715153454.GO23073@quack2.suse.cz> <CAOQ4uxg+75abXiNtPXqh6tybUAGfJ7=we9nmxSnaCsfNGBjZcQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+75abXiNtPXqh6tybUAGfJ7=we9nmxSnaCsfNGBjZcQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Jul 2020 19:22:37 +0300
Message-ID: <CAOQ4uxhGt9CQ4WY_NvhWSjFbATVrrmNO_quZzA_QSu_6F9_43A@mail.gmail.com>
Subject: Re: [PATCH v3 20/20] fanotify: no external fh buffer in fanotify_name_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Any reason why proper fh len is not passed in by both callers?
>
> No good reason.
> It's just how the function evolved and I missed this simplification.
>
> > We could then get rid of this 'if' and 'bytes' variable.
>
> Yap. sounds good.
> I will test and push the branches.
> Let me know if you want me to re-post anything.
>

Pushed this nit fix to prep series branch fanotify_prep
and complete tested series to branch fanotify_name_fid.

Thanks,
Amir.
