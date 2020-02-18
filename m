Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6CC161E25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 01:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgBRAOj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 19:14:39 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35391 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgBRAOj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 19:14:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id y25so515094edi.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 16:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1vYFSkdKc64YU909r3NN/RxWnwYJTgCAzVYJykceo4=;
        b=dPTgLG+YkkLPBW9twraX80RUev1XvRASe4OXsqmBuzlxxZR1SxZRuxc7fyQxjupqcv
         ywjCvau2eVJdkP5foRhAPzEcyd4ivNGjvrwSrpqLjRpinZLegg2PjvnFB4IcYDZbtusg
         OZM7pNxc/FUdrNtUYsh7YaTqEsOrn5cFeWXBEe99VTeuHLbmyAN2RScSyPrXh5hmWh6M
         0qlWjSjggkhQYRR4N0dNZI8R6JnLNapNQM7O0HIS5P1mBDyLb8bPpc9f6k9GXtEctxXJ
         EdfhLdGWGGq6HRVFkH/uZ8wGUPfyUCCbgTXqUTi8+h57QAJqSf1STcyVWvH8zlMBj3+a
         t/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1vYFSkdKc64YU909r3NN/RxWnwYJTgCAzVYJykceo4=;
        b=RH5bPADo500PQqx7zFVtV3PhglvhvAw5M9ysyip33tfra+gHfLdQX5nsAy1PqRNzRh
         UvRJMhs2WVVU6Hsyjbw/Br436KVoQ3pLc6Dhr6TWxNaRuBWeXH0JvfvLO7II3siSEQt4
         hQ6NpFq3PIuTnBQEM3lLa9qv2+qDzLlovvB+PoLVfrahMc+U1q22BqRBBxSIARVEdJHu
         a+/PPuqbm/fIGf+dJE4KgzwGN28rQqoU2KJrtAE/0p6G4LFuq0ZLNeqL4nQQr2UZMupD
         yCA8vy57f9uBomEoKClRt82SHDYpAmNS9LOiOrMjAGpoH2j4oZolgaKmx8HdNNoErNNC
         a0Gw==
X-Gm-Message-State: APjAAAUtcRgNUtAjyaqlLk9g13UIIE4yX5x4klUAiG4tY6wAOrFXSaGZ
        i7/GYa1apQ54RDsPdba/bGQ3TEvbeGWmL9iF9Rup
X-Google-Smtp-Source: APXvYqwn0E8HDTiFXoWF/DdHcW13nSXh+LKbFA1du82DjhCL9nzW4mM5cz9RyEKKtHSNtDsWRxboa3ZJFD/dcTvfKo4=
X-Received: by 2002:a05:6402:61a:: with SMTP id n26mr15421837edv.135.1581984875984;
 Mon, 17 Feb 2020 16:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20200213194157.5877-1-sds@tycho.nsa.gov>
In-Reply-To: <20200213194157.5877-1-sds@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Feb 2020 19:14:24 -0500
Message-ID: <CAHC9VhSsjrgu2Jn+yiV5Bz_wt2x5bgEXdhjqLA+duWYNo4gOtw@mail.gmail.com>
Subject: Re: [RFC PATCH] security,anon_inodes,kvm: enable security support for
 anon inodes
To:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     selinux@vger.kernel.org, kvm@vger.kernel.org, dancol@google.com,
        nnk@google.com, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 13, 2020 at 2:41 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> Add support for labeling and controlling access to files attached to anon
> inodes. Introduce extended interfaces for creating such files to permit
> passing a related file as an input to decide how to label the anon
> inode. Define a security hook for initializing the anon inode security
> attributes. Security attributes are either inherited from a related file
> or determined based on some combination of the creating task and policy
> (in the case of SELinux, using type_transition rules).  As an
> example user of the inheritance support, convert kvm to use the new
> interface for passing the related file so that the anon inode can inherit
> the security attributes of /dev/kvm and provide consistent access control
> for subsequent ioctl operations.  Other users of anon inodes, including
> userfaultfd, will default to the transition-based mechanism instead.
>
> Compared to the series in
> https://lore.kernel.org/selinux/20200211225547.235083-1-dancol@google.com/,
> this approach differs in that it does not require creation of a separate
> anonymous inode for each file (instead storing the per-instance security
> information in the file security blob), it applies labeling and control
> to all users of anonymous inodes rather than requiring opt-in via a new
> flag, it supports labeling based on a related inode if provided,
> it relies on type transitions to compute the label of the anon inode
> when there is no related inode, and it does not require introducing a new
> security class for each user of anonymous inodes.
>
> On the other hand, the approach in this patch does expose the name passed
> by the creator of the anon inode to the policy (an indirect mapping could
> be provided within SELinux if these names aren't considered to be stable),
> requires the definition of type_transition rules to distinguish userfaultfd
> inodes from proc inodes based on type since they share the same class,
> doesn't support denying the creation of anonymous inodes (making the hook
> added by this patch return something other than void is problematic due to
> it being called after the file is already allocated and error handling in
> the callers can't presently account for this scenario and end up calling
> release methods multiple times), and may be more expensive
> (security_transition_sid overhead on each anon inode allocation).
>
> We are primarily posting this RFC patch now so that the two different
> approaches can be concretely compared.  We anticipate a hybrid of the
> two approaches being the likely outcome in the end.  In particular
> if support for allocating a separate inode for each of these files
> is acceptable, then we would favor storing the security information
> in the inode security blob and using it instead of the file security
> blob.

Bringing this back up in hopes of attracting some attention from the
fs-devel crowd and Al.  As Stephen already mentioned, from a SELinux
perspective we would prefer to attach the security blob to the inode
as opposed to the file struct; does anyone have any objections to
that?

-- 
paul moore
www.paul-moore.com
