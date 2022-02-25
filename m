Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85914C3C08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 03:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiBYC7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 21:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiBYC7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:59:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3D461E3741
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 18:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645757918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CauoURgUZ4v50QCANyExBUMWNUuGIGlFYqjgg6YLGL0=;
        b=FCDgNJCd/rG0tQzOcYySSapjWxF3ydBGnQB5bUSbCU7GAzInT25SFDBdwtzPakPKktCLcE
        NNlRmvtZIL+xUrHpD+wKUB03q0fauSgBxwDFZuZX34feRvCI9LFr0GdsStGY0kgQjcM64u
        YPurK4obn7lq4vmIQPLKnzFVJ4UShQY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-DpaBLUnPPxyGlhZEJLRAgg-1; Thu, 24 Feb 2022 21:58:37 -0500
X-MC-Unique: DpaBLUnPPxyGlhZEJLRAgg-1
Received: by mail-pj1-f70.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso2475335pjq.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 18:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CauoURgUZ4v50QCANyExBUMWNUuGIGlFYqjgg6YLGL0=;
        b=g1nb57kg/YSsd1vub5Azt1y8JJZ4v5Aew5GIHwvE7fw7wG3365aQLdPlxYhAb3PRBq
         SI/MIT4eV6+y72AVwMREsQQ+TJcUCbLjFWYc3K9q7mHsPUMCXLXgW2jICBw9dhdhCfR8
         fmDkX8Uf47AQk+PmdHBrbt4AnNym4zz3jqna4GIkdNF/myxrwuneMyKw/Mo0ThFOgIfU
         ngPLgPd3xSPgaziNBHktUrpXPgjYgAVA+qSTiM7C/6NuEjf+E9T0VDMae1JjdNHk7Kev
         YIjz5ZxM/lN6th7198Fd6KozD5GvuNqDieNrVH56Svnre9BBtfiBV8SaC3ohBxg8gRjb
         HwKA==
X-Gm-Message-State: AOAM531W1nmusg4VrqAsgTrwradblnoDScE0RD78X3ZFDltvR0p06PmG
        3M4ve3TbWjmjeVShJbyEtTO5Q740/4UiOeliB4WKw0835PkbjL5uIv9YL9VGeHF+XkpsmZPjCen
        /E8S2LfF2C+P60ClxzVEB7x+zWg==
X-Received: by 2002:a17:903:244a:b0:150:25d1:d2ff with SMTP id l10-20020a170903244a00b0015025d1d2ffmr1997041pls.70.1645757916653;
        Thu, 24 Feb 2022 18:58:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOGBViVIjSEs20HiGON+uKIVzSeyomY20qDxZXbhJhU+z/NsaHHhe2vINl/rCk0vkgrzDJ8Q==
X-Received: by 2002:a17:903:244a:b0:150:25d1:d2ff with SMTP id l10-20020a170903244a00b0015025d1d2ffmr1997024pls.70.1645757916338;
        Thu, 24 Feb 2022 18:58:36 -0800 (PST)
Received: from xz-m1.local ([94.177.118.52])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm891513pfh.83.2022.02.24.18.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:58:35 -0800 (PST)
Date:   Fri, 25 Feb 2022 10:58:26 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
Message-ID: <YhhF0jEeytTO32yt@xz-m1.local>
References: <20220224181953.1030665-1-axelrasmussen@google.com>
 <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
 <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
 <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f74f1e4-6374-0e00-c5cb-04eba37e4ee3@schaufler-ca.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:39:44PM -0800, Casey Schaufler wrote:
> What I'd want to see is multiple users where the use of CAP_USERFAULTD
> is independent of the use of CAP_SYS_PTRACE. That is, the programs would
> never require CAP_SYS_PTRACE. There should be demonstrated real value.
> Not just that a compromised program with CAP_SYS_PTRACE can do bad things,
> but that the programs with CAP_USERFAULTDD are somehow susceptible to
> being exploited to doing those bad things. Hypothetical users are just
> that, and often don't materialize.

I kind of have the same question indeed..

The use case we're talking about is VM migration, and the in-question
subject is literally the migration process or thread.  Isn't that a trusted
piece of software already?

Then the question is why the extra capability (in CAP_PTRACE but not in
CAP_UFFD) could bring much risk to the system.  Axel, did I miss something
important?

Thanks,

-- 
Peter Xu

