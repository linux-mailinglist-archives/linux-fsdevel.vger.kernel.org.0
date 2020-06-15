Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B80D1F9D9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgFOQjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbgFOQjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:39:52 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778A3C05BD43
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so19980302ljh.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=hYqsrzQyaCq1kQgp0spHAppAk0hS2j5g++6SYxCLxYxJXAmMfKqTQ18qJkn1C27/AG
         eJGDl4TDVRdRqRzTxahAgnZfaGDf0lo3JVIvuqg2IKhggaqVKPMvCx5tTM7h4m+tvAMI
         wN5LBnLvHufylZ12CACwK78MI49zcsJYaDln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=dASnTde+oygXfffnzi9hKhAkx/nNYgJ7oU54VcaZNjaA/72HN52lvfXSEZx945RCqy
         XmybI+OTFNDzgVE0Pah6CDuNGRtoGQrO3SMI/Q45BezxzEd6ZxAa5s8yZXZEWAE3TqCD
         hvfuS0oxdjcFCpveVQcKS05xDZwr11vV3JI7p86Xiwn4gkK2wI1COyt3VjZrATL5KSzn
         08EnkUkMIXtRKoBp9ylX0X1Mh9quKCRtFTrYg+NeBwKFYwdEbIxGqY5xEGiMHCy8hGAC
         /aelkVzwcRHvmYxgFqXQpb/o8wT1+QnLPAOpu9kM+YhtbFRvYoSEOK1YudvAwnovzU0o
         MFuw==
X-Gm-Message-State: AOAM53105cHD0d0QAWhBCYwF37EawJ614l6185CroTui46wsflT7Pr23
        LzSNgyiXC+buwKAPoJgMs7rnCF8FUn8=
X-Google-Smtp-Source: ABdhPJyR2DlTdtvmFCptUXkBGqxEP8SNM4vH+I7xu2rGJNWgu0vKDJSYKq3MZkbMjMMySsoZcnlNog==
X-Received: by 2002:a2e:8150:: with SMTP id t16mr13498856ljg.160.1592239189319;
        Mon, 15 Jun 2020 09:39:49 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l7sm3909093ljj.55.2020.06.15.09.39.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id i27so19953974ljb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr12917365ljj.102.1592239187960;
 Mon, 15 Jun 2020 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-6-hch@lst.de>
In-Reply-To: <20200615121257.798894-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:39:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] fs: check FMODE_WRITE in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> We still need to check if the f=D1=95 is open write, even for the low-lev=
el
> helper.

Is there actually a way to trigger something like this? I'm wondering
if it's worth a WARN_ON_ONCE()?

It doesn't sound sensible to have some kernel functionality try to
write to a file it didn't open for write, and sounds like a kernel bug
if this case were to ever trigger..

                Linus
