Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6C222CF62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 22:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGXU0L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgGXU0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:26:10 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51420C0619E4
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 13:26:10 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so11234220ljl.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 13:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=KtKcrijfok2OM2Bs9fSARpIOCqZAORRhOEAWEspyefuuQiv0/hudjwYFxvdZYP8RIE
         x/etcayReiFZfOvZz4a+h99awZFUCnk+gEVf5LIz5qer03CSy6o0FgWPmB4n2oXPdXJB
         lJgwEQlLR1A9JtB7EMnPQ4yBFe/eY6IWqSZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkXygjf+m2gKsI4Lztqfnb3auT7BfwLJDotOPSg45zA=;
        b=VFJvreEgW81XZPscn+dTLulIwM8cPTJQ5EM2b3iAlS3GzRtuNqYsrgqwFfhi/fGLM+
         HNfp4zTXCqi9E2dhauwdYAIdDYUN7Mhal/68qc3FM9cL94vi8SIiMxQTxtx2NQaobY8l
         fXH90lAPlJXoQ/T4jCWfOXlm1dQarR4RWxPMuSJ/n1FDv+C7ZNWOSWtj4Rplp2E9dzou
         8OSQP92EngKvIqojNwXXgYwDTcIAIg5GZSF9RNEAzVZxebR3E08oaAgrqoqh5HnUVCYO
         33W1fBuFa8EFVDSGpvRa///YVGVcDaPX9h5wodMm/1k5vKlBCxtHwrv8konrbnwjlkv5
         b8Gg==
X-Gm-Message-State: AOAM530sN/2E4/Y8yUf/bx187NvJAeXKjs9R/KYqHJ0YDjmMPAPctKkl
        US/I3Pl9fkn+xRY+zQo5+D+LoYqHo9E=
X-Google-Smtp-Source: ABdhPJwQUq4lmGy5GtseAf6TLMT8OcHVEEPDiGwRf0G3InV4j3bTixPe76xaWu8MDv8k1j8uoBDNcQ==
X-Received: by 2002:a2e:9d81:: with SMTP id c1mr5271483ljj.198.1595622368211;
        Fri, 24 Jul 2020 13:26:08 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d13sm557394lfl.89.2020.07.24.13.26.06
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:26:07 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id b25so11237650ljp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr4879223ljj.102.1595622366366;
 Fri, 24 Jul 2020 13:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
 <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com> <2189056.1595620785@warthog.procyon.org.uk>
In-Reply-To: <2189056.1595620785@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 13:25:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Message-ID: <CAHk-=wgWNpzCuHyyFwhR2fq49yxB9tKiH2t2y-O-8V6Gh0TFdw@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:59 PM David Howells <dhowells@redhat.com> wrote:
>
> That's a good point.  Any suggestions on how to do it?  An additional RLIMIT?
>
> Or should I do it like I did with keyrings and separately manage a quota for
> each user?

I'd count them per user, and maybe start out saying "you can have as
many watches as you can have files" and just re-use RLIMIT_NOFILE as
the limit for them.

And if that causes problems, let's re-visit. How does that sound?

                Linus
