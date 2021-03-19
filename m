Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA943423F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 19:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSSEH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 14:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhCSSDo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:03:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E42C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 11:03:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y200so6437011pfb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 11:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fgm96KdkqPPp5AyePMeoZ4bVy8WajnICuOF6lgD+oIg=;
        b=WLn4qJw0mRnRd2MuhQP7t0sfnyhwEvjNu988xXSPLRxMyhbXuwpXBBTk46I7unAvON
         cjyhkk6qSlLOYR0UI87kTBxgP/Wnddx3aAKZdL5coNoywwluId0NvmkBbwQcv409IPbH
         mzySyBVh/E+KEz95rYinZ5MCAQ1HFNil/owiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fgm96KdkqPPp5AyePMeoZ4bVy8WajnICuOF6lgD+oIg=;
        b=l4rZd6saiHlvHV3XimccPdJ+H7ElqQndmSN/3/XkRya7hKSQxjxeMMezcIa/ujB78n
         hgKr2DSjTS+99RQrt2g3YcAVhWSi4bKU/O2lLCXwjc5a6pBQ/XAlSILqkD/gSYNt5R8C
         AvmewbRniLP/Vf+CAMlFXklPlslIxWgBU/3KZDQqAbZYCOYc8hUvJuNg1XzVqwCUN2M8
         gf4Emyh48vAWR6WvinHt5DmKD7fbt8fVyKaQXP8vdyG+7f3+za9LE3kuAHyxWPn3lyEt
         PSgHmHI6SeJrpygUaQJftq2P2e2KKCQApb6iv/IL5oDsIbVI7ss40kVrDtqqSIMDrkD3
         ep7w==
X-Gm-Message-State: AOAM530H+itmohYIkyPVapUyR1tEKmIGW2xbWlzXVNXfWXxyKuWvx4ff
        DcUz0+SyHrnWo9feClq6ZsLJSw==
X-Google-Smtp-Source: ABdhPJzhTUxr8xtElyOo2sGLLBM/SHQIPL7qbearL3PQEkxev8oiF1oDVJM+cInZoueV8pCU8aX6hQ==
X-Received: by 2002:aa7:99c4:0:b029:1f6:c0bf:43d1 with SMTP id v4-20020aa799c40000b02901f6c0bf43d1mr10042556pfi.37.1616177023839;
        Fri, 19 Mar 2021 11:03:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m16sm5544874pgj.26.2021.03.19.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 11:03:43 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:03:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v30 12/12] landlock: Add user and kernel documentation
Message-ID: <202103191056.71AB0515A@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-13-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-13-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:52PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> This documentation can be built with the Sphinx framework.

Well, yes. :) Maybe describe what the documentation covers instead here.
Regardless: yay docs! This is great.

> [...]
> +Bind mounts and OverlayFS
> +-------------------------
> +
> +Landlock enables to restrict access to file hierarchies, which means that these
> +access rights can be propagated with bind mounts (cf.
> +:doc:`/filesystems/sharedsubtree`) but not with :doc:`/filesystems/overlayfs`.
> +
> +A bind mount mirrors a source file hierarchy to a destination.  The destination
> +hierarchy is then composed of the exact same files, on which Landlock rules can
> +be tied, either via the source or the destination path.  These rules restrict
> +access when they are encountered on a path, which means that they can restrict
> +access to multiple file hierarchies at the same time, whether these hierarchies
> +are the result of bind mounts or not.
> +
> +An OverlayFS mount point consists of upper and lower layers.  These layers are
> +combined in a merge directory, result of the mount point.  This merge hierarchy
> +may include files from the upper and lower layers, but modifications performed
> +on the merge hierarchy only reflects on the upper layer.  From a Landlock
> +policy point of view, each OverlayFS layers and merge hierarchies are
> +standalone and contains their own set of files and directories, which is
> +different from bind mounts.  A policy restricting an OverlayFS layer will not
> +restrict the resulted merged hierarchy, and vice versa.

Can you include some examples about what a user of landlock should do?
i.e. what are some examples of unexpected results when trying to write
policy that runs on top of overlayfs, etc?

> [...]
> +File renaming and linking
> +-------------------------
> +
> +Because Landlock targets unprivileged access controls, it is needed to properly
> +handle composition of rules.  Such property also implies rules nesting.
> +Properly handling multiple layers of ruleset, each one of them able to restrict
> +access to files, also implies to inherit the ruleset restrictions from a parent
> +to its hierarchy.  Because files are identified and restricted by their
> +hierarchy, moving or linking a file from one directory to another implies to
> +propagate the hierarchy constraints.  To protect against privilege escalations
> +through renaming or linking, and for the sack of simplicity, Landlock currently

typo: sack -> sake

> [...]
> +Special filesystems
> +-------------------
> +
> +Access to regular files and directories can be restricted by Landlock,
> +according to the handled accesses of a ruleset.  However, files that do not
> +come from a user-visible filesystem (e.g. pipe, socket), but can still be
> +accessed through /proc/self/fd/, cannot currently be restricted.  Likewise,
> +some special kernel filesystems such as nsfs, which can be accessed through
> +/proc/self/ns/, cannot currently be restricted.  For now, these kind of special
> +paths are then always allowed.  Future Landlock evolutions will enable to
> +restrict such paths with dedicated ruleset flags.

With this series, can /proc (at the top level) be blocked? (i.e. can a
landlock user avoid the weirdness by making /proc/$pid/ unavailable?)

> +Ruleset layers
> +--------------
> +
> +There is a limit of 64 layers of stacked rulesets.  This can be an issue for a
> +task willing to enforce a new ruleset in complement to its 64 inherited
> +rulesets.  Once this limit is reached, sys_landlock_restrict_self() returns
> +E2BIG.  It is then strongly suggested to carefully build rulesets once in the
> +life of a thread, especially for applications able to launch other applications
> +that may also want to sandbox themselves (e.g. shells, container managers,
> +etc.).

How was this value (64) chosen?

-- 
Kees Cook
