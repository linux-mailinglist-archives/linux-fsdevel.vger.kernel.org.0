Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55263493655
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 09:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352485AbiASI26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 03:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352484AbiASI25 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:28:57 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1B3C06173E
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 00:28:57 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j2so7556290edj.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 00:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhke7viFTh+984sDiukRcfEr3dDTzTM2M1AdIWscGkI=;
        b=IPaQXqeKWhvXrnF1NTn+04SxablavDfev1QQdPokB1Szeda1ZTHt4AjsyGJo/NfNqV
         6fyseawScGNSvOb4vATPREo2hp2c0ojbGLOA5Soo1sMnw21qUj9LxINE1Dno4m8PIC5e
         TWAB3J5T2CITv32jpTEop26cRpnT6Miv+nYQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhke7viFTh+984sDiukRcfEr3dDTzTM2M1AdIWscGkI=;
        b=VklgBrgWSOTGoMi3PAzPomPens2Rd5dmg8fcBLTz4NTqWaD2Crg1Dn3coDa4A4FiaC
         82KR33p3cfN3tosXLL0YmS7rvEBxZr5leKvLBbozVhnsAoXU2uprU87TPYEiKuWNaLMs
         Nklwm75oTwAyLH71s5lhCu95xId5WY2AwjNU19No+V+eEiUW1rz1e+nW66R3UZmr7voy
         UtzO4F8h8O6DqujbNsWJ4EMREG+5Qmx9Xfi2FRg5oPqihzZCIbcSjzrYRltBDvgor5ki
         38xHzl9Dp5hFBsfOwiIb+RfItFRp0MTTGctlIGQksPhK4HQnjnHlIdglT/MOgXOix0ft
         5mog==
X-Gm-Message-State: AOAM533BvtUryRlmk5pkQKxizVAh3UM7O4TWxwwGx0W4RozDbL9s+JNW
        RJn+J8kS/4JDAABE6XdmfikOdFigjJU/bOEtqUk=
X-Google-Smtp-Source: ABdhPJxdXWPsuDLwgDlUh2uYuVDg9gDV7ZHKPW71+rJUmhcvkFA6XgX5moQ7wgWQCfPPCzulttE7bw==
X-Received: by 2002:a17:906:4782:: with SMTP id cw2mr24065876ejc.337.1642580935632;
        Wed, 19 Jan 2022 00:28:55 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id 7sm6076835ejh.161.2022.01.19.00.28.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jan 2022 00:28:54 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so4150061wmb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jan 2022 00:28:54 -0800 (PST)
X-Received: by 2002:a05:600c:34d6:: with SMTP id d22mr1240895wmq.26.1642580934004;
 Wed, 19 Jan 2022 00:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20220118065614.1241470-1-hch@lst.de>
In-Reply-To: <20220118065614.1241470-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jan 2022 10:28:37 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjrxHOHPj_U7cOwQZFV8pBPwoppg7iTL=gtr8qGsCf6Tg@mail.gmail.com>
Message-ID: <CAHk-=wjrxHOHPj_U7cOwQZFV8pBPwoppg7iTL=gtr8qGsCf6Tg@mail.gmail.com>
Subject: Re: [PATCH] unicode: clean up the Kconfig symbol confusion
To:     Christoph Hellwig <hch@lst.de>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Note that a lot of the IS_ENALBED() checks could be turned from cpp
> statements into normal ifs, but this change is intended to be fairly
> mechanic, so that should be cleaned up later.

Yeah, that patch looks uglier than what I would have hoped for, but a
number of the conversions really look like they then would get a lot
cleaner if the IS_ENABLED() was part of the code flow, rather than
have those ugly (and now arguably even uglier) #ifdef's inside code.

And I think the mechanical conversion is the right thing to do, with
any cleanup being separate.

I'll look at this again when I have all my pulls done.

              Linus
