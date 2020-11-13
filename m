Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997092B23FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 19:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgKMSqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 13:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKMSqn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:46:43 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853F3C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 10:46:43 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id k1so9367436ilc.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2020 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cTJlJ+7xtu0sUuJYplh5pdrvcoxPXi2kVPalslnbuBo=;
        b=MXdK/hBFVZU9sIyi3jdmY6UGXxmLRQ+WPtbV+AuWQVNdIgqdvtprYRVMYDUfArJhYY
         V0/yWQy7fmHZh04SVLKUZwm4tfOG47Hfd1Y/w77U3XwqOFW5FmEBxhhI6GZ9BqgveJby
         t5bXvkXnG6oH4Zddp+WDRbVHtJO7TGT/wWc9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cTJlJ+7xtu0sUuJYplh5pdrvcoxPXi2kVPalslnbuBo=;
        b=nPUjaNnW0aai9f4VJAqwYMo6hLsmVonuYDU9x7T8h7i5+gr8nEjS3WEwPw21ozPO2C
         PargcFEd8e+D2p59RaFeWUh1GmLIntwS7HZjDILDaHSWrclf6J0C0IeLIawECNKJZLUg
         0tqfbV7bDIq/RlPOX1SFztZBNrxB/tuhUHeuaRO8nJ5effL6K6QHZzDZdAeG+b4D+lNB
         mRuOQWm23pqXqlCMWND+Ua4wS5wSTeYhlE8vYvpi1E/Fu7EEwz2xAKnGiYEJhtbi65V4
         QpHhf0FuycvJfRhJB8koJnXAjBV7+ikden/9v7WblGKk6iEqVmbzQ5KnOWk4Xq8TCpYH
         VGnw==
X-Gm-Message-State: AOAM530t+CGnvYG9ZXUCe4X71UvSH49261VxjjjHjbqMnwUHxv14T/fJ
        9tfNu0YamdiYjlmw2PsYJp0NQw==
X-Google-Smtp-Source: ABdhPJwGClNp5JrE4fdKndsLLJw6ddafB0Zud1YHDNyHMMvxd3LeWD+obVjRVPSlzsa2bT2R24Bt0Q==
X-Received: by 2002:a92:6706:: with SMTP id b6mr975121ilc.42.1605293202608;
        Fri, 13 Nov 2020 10:46:42 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id k28sm1099897ilg.40.2020.11.13.10.46.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Nov 2020 10:46:42 -0800 (PST)
Date:   Fri, 13 Nov 2020 18:46:40 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     mauricio@kinvolk.io, Alban Crequy <alban.crequy@gmail.com>,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Anderson <kylea@netflix.com>
Subject: Re: [PATCH v5 0/2] NFS: Fix interaction between fs_context and user
 namespaces
Message-ID: <20201113184640.GA29286@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201112100952.3514-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112100952.3514-1-sargun@sargun.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 02:09:50AM -0800, Sargun Dhillon wrote:
> Right now, it is possible to mount NFS with an non-matching super block
> user ns, and NFS sunrpc user ns. This (for the user) results in an awkward
> set of interactions if using anything other than auth_null, where the UIDs
> being sent to the server are different than the local UIDs being checked.
> This can cause "breakage", where if you try to communicate with the NFS
> server with any other set of mappings, it breaks.
> 
> The reason for this is that you can call fsopen("nfs4") in the unprivileged
> namespace, and that configures fs_context with all the right information
> for that user namespace. In addition, it also keeps a gets a cred object
> associated with the caller -- which should match the user namespace.
> Unfortunately, the mount has to be finished in the init_user_ns because we
> currently require CAP_SYS_ADMIN in the init user namespace to call fsmount.
> This means that the superblock's user namespace is set "correctly" to the
> container, but there's absolutely no way nfs4idmap to consume an
> unprivileged user namespace because the cred / user_ns that's passed down
> to nfs4idmap is the one at fsmount.
> 
> How this actually exhibits is let's say that the UID 0 in the user
> namespace is mapped to UID 1000 in the init user ns (and kuid space). What
> will happen is that nfs4idmap will translate the UID 1000 into UID 0 on the
> wire, even if the mount is in entirely in the mount / user namespace of the
> container.
> 
> So, it looks something like this
> Client in unprivileged User NS (UID: 0, KUID: 0)
> 	->Perform open()
> 		...VFS / NFS bits...
> 		nfs_map_uid_to_name ->
> 			from_kuid_munged(init_user_ns, uid) (returns 0)
> 				RPC with UID 0
> 
> This behaviour happens "the other way" as well, where the UID in the
> container may be 0, but the corresponding kuid is 1000. When a response
> from an NFS server comes in we decode it according to the idmap userns.
> The way this exhibits is even more odd.
> 
> Server responds with file attribute (UID: 0, GID: 0)
> 	->nfs_map_name_to_uid(..., 0)
> 		->make_kuid(init_user_ns, id) (returns 0)
> 			....VFS / NFS Bits...
> 			->from_kuid(container_ns, 0) -> invalid uid
> 				-> EOVERFLOW
> 
> This changes the nfs server to use the cred / userns from fs_context, which
> is how idmap is constructed. This subsequently is used in the above
> described flow of converting uids back-and-forth.
> 
> Trond gave the feedback that this behaviour [implemented by this patch] is
> how the legacy sys_mount() behaviour worked[1], and that the intended
> behaviour is for UIDs to be plumbed through entirely, where the user
> namespaces UIDs are what is sent over the wire, and not the init user ns.
> 
> [1]: https://lore.kernel.org/linux-nfs/8feccf45f6575a204da03e796391cc135283eb88.camel@hammerspace.com/
> 
> Sargun Dhillon (2):
>   NFS: NFSv2/NFSv3: Use cred from fs_context during mount
>   NFSv4: Refactor to use user namespaces for nfs4idmap
> 
>  fs/nfs/client.c     | 4 ++--
>  fs/nfs/nfs4client.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 8c39076c276be0b31982e44654e2c2357473258a
> -- 
> 2.25.1
> 
Trond,

I was just thinking, since you said that this is the behaviour of the sys_mount 
API, would this be considered a regression? Should it go to stable (v5.9)?
