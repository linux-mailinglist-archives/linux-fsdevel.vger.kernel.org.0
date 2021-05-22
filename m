Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819BF38D2E6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhEVCIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhEVCIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 22:08:20 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED82C06138B
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 19:06:55 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id z12so31627745ejw.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 19:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enh1CO1fRJ/3s4nFuYfV9slAcR71xCie3kXiqBTbpWg=;
        b=DCGJ5Nilo9/AGG1ArRxCjRgl6Ds9yTKWnR6U59uXzOZmtwiUQ5494CMZyReO55uwFC
         bWQGlDqLRp/uFHm5zG6la0tMj+mGyzU7/vMvuDBbNIXjksEXwzlAE5G1hmTvER3/Jo1R
         YevoCUqNHBiF6AzfOPz9cWHKzkxXERNFSCqZX0G2NyH1AsaUTr7VCU16+FNGRhBapnhO
         z+Vlj89N0pKTqThOiXfuC8DqDIO7oFc89t651Zng0mhBQGHlIVNyJva1qSub9eoR34fF
         Qv0FYzdvvK38zcP1XpSvJfH+a4AowNlrh2wC6JfqExuFDqBBSuwRE2Hl+MMhteqYRHq9
         VYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enh1CO1fRJ/3s4nFuYfV9slAcR71xCie3kXiqBTbpWg=;
        b=tyjwvzx+VmgdbsVpf2cpFfKgQCe9YCJsaYeXCoJxxctIKqh6wyzY1FIOML9DThNGLc
         pdVlgvz04trQH/K2YJuzj+ZpZCMvPpYlYL1WRXB1kyJwH/BFP5ctj4my90jgnbQK/s6S
         JplYhapswrHo8FRfsKxPtwJLJdHngVsGjD5Nub1J4i8Ta47AWLHqwOJpX7ZDv1qmbP65
         WcbVZFsLajHBgnnqogmxwqsOtqN26B0jzEtIjb9FL5OQ3ldsY0TvjDaUdaB1r/s6qpP4
         TdlpxHt7PV2dVZ8bNCqy495Yw2DK5Zs3c9Sga8Y9ie9hZxbehe9rW2gIEn1PyrcYPCn5
         QuyQ==
X-Gm-Message-State: AOAM5308ZbCNFVYhT4DqngvsQhY2+HQSna02bTdxIsXAiJG4evLPdrDs
        Zkj7uxAIZ0zt248r7HOM25pOuiokKfyNsoTN76BR
X-Google-Smtp-Source: ABdhPJwAdi1Bw98L2/qGMo17Mi+Nh8QFY/8nuxWxu+5qFeaSxXKZgxnhJ2PPUK/Xid00W60zEIsVCCAHK9qd/G6j0x4=
X-Received: by 2002:a17:907:1749:: with SMTP id lf9mr13285225ejc.178.1621649212774;
 Fri, 21 May 2021 19:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <162163367115.8379.8459012634106035341.stgit@sifl> <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
In-Reply-To: <f67213bf-8f41-ce06-b3b2-adf1ab2a3c5c@i-love.sakura.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 May 2021 22:06:41 -0400
Message-ID: <CAHC9VhRG9jD3JPbf==Bo0B+cyMG8mrQnM=RyoxenqxqePdRdsw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Add LSM access controls and auditing to io_uring
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        io-uring@vger.kernel.org, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 8:53 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/05/22 6:49, Paul Moore wrote:
> > I've provided the SELinux
> > implementation, Casey has been nice enough to provide a Smack patch,
> > and John is working on an AppArmor patch as I write this.  I've
> > mentioned this work to the other LSM maintainers that I believe might
> > be affected but I have not heard back from anyone else at this point.
>
> I don't think any change is required for TOMOYO, for TOMOYO does not
> use "struct cred"->security where [RFC PATCH 8/9] and [RFC PATCH 9/9]
> are addressing, and TOMOYO does not call kernel/audit*.c functions.

Good to know, thank you for checking.

-- 
paul moore
www.paul-moore.com
