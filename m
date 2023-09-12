Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01A79DAF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjILVbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjILVbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 17:31:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10F10CA
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:31:09 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76f17eab34eso371815285a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694554268; x=1695159068; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y6d1LGpCg2X8fBo+4dvLu5EIg9yZWWJA/k12TK2X6Dc=;
        b=gr3O1z4BMe+5vsnewqIK3P33h6VvkXUR+kJ3UzkFgQHp74xVB+k4L6UKdi7qcGa8ty
         NhV//pflZaZHWoDJnHRvn7XE8AtNmvjyKcNvQn6cRCU6xzzuDUlR4B5rHukI2NK73ATf
         JH7ERSfQ2dnkKYCuTH2nlBznfQsZrvdAdf1C6re8czokjpDdJKCq3n7vEj1xBr5ujOtr
         5s+xj4Vm22hixxGfgkjesEf2B1DTr0G346fS70f4nYFqCwpOo4GNPyjLwsrA3emYKV9S
         7Ryy5ZZCXjsWGPdlqBQ55YeW9vmzSd6e9emnFZza2MamWthRNphchKeuRig2ImkIuQ18
         ODHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694554268; x=1695159068;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6d1LGpCg2X8fBo+4dvLu5EIg9yZWWJA/k12TK2X6Dc=;
        b=n9UBIckBsYjqn2hHXq2O3u0+o6nb/GC/XElL9RouoP/nBxg53fp1aLT43kKovzolj/
         QsGop9UeA13PxQvCOj5REVQxRj6WUACdLt5adkgkxPGaMahu3DNUkBBa9mZqkoorcNJE
         EGlQHVxYap/ptaFOARMo9zYzBsrTclb05xrCtg8lBAlnsLCtvCsK4urz9wrQBKqB7VVR
         pOz+fkxK3xMz1eVQQcyIgt7h41vPL8ntku6kQNkjRc3/K9tcOBjKRs6r3kuwkg2Ucv0c
         OJwlwFdYDdX8YNjoGaaoimwykGalACwx0Yp2lrYyJ8XMFLoXs2AomoJZB9zvNHesY4V0
         M8kw==
X-Gm-Message-State: AOJu0YwXylMYXnsE3YiVnKzxtzcUP1jfml8UZJsmT6tV0gr8J9x+EeO2
        ordto2qWa48kxO3KPdfws7rk6dW1t6eChEtqZg==
X-Google-Smtp-Source: AGHT+IEJiiEJgMI/MOcUWNcejsvLxlPmyyckx7hw6penxLc8tg9G9Y0/08ch5zdgVXEwkBbyLLroZg==
X-Received: by 2002:a05:620a:24d4:b0:768:f02:532e with SMTP id m20-20020a05620a24d400b007680f02532emr690055qkn.39.1694554268459;
        Tue, 12 Sep 2023 14:31:08 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id o13-20020a05620a110d00b00767dba7a4d3sm3463544qkk.109.2023.09.12.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 14:31:08 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:31:07 -0400
Message-ID: <f48a346737f99d7b82ecaf214ac2b77e.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        selinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Adam Williamson <awilliam@redhat.com>
Subject: Re: [PATCH] selinux: fix handling of empty opts in  selinux_fs_context_submount()
References: <20230911142358.883728-1-omosnace@redhat.com>
In-Reply-To: <20230911142358.883728-1-omosnace@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sep 11, 2023 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> selinux_set_mnt_opts() relies on the fact that the mount options pointer
> is always NULL when all options are unset (specifically in its
> !selinux_initialized() branch. However, the new
> selinux_fs_context_submount() hook breaks this rule by allocating a new
> structure even if no options are set. That causes any submount created
> before a SELinux policy is loaded to be rejected in
> selinux_set_mnt_opts().
> 
> Fix this by making selinux_fs_context_submount() leave fc->security
> set to NULL when there are no options to be copied from the reference
> superblock.
> 
> Reported-by: Adam Williamson <awilliam@redhat.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2236345
> Fixes: d80a8f1b58c2 ("vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/selinux/hooks.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Thanks Ondrej, this looks good.  I'm going to merge this into
selinux/stable-6.6 and assuming all goes well with the automated
testing (I can't imagine it would catch anything) I'll send this up
to Linus later this week.

I'm also tagging this for the stable kernels even though this patch
is only present in v6.6-rc1 because the original patch has a number
of 'Fixes:' tags which means the stable folks will probably end up
pulling it into their trees.

--
paul-moore.com
