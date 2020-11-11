Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCE42AEF48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgKKLMu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 06:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgKKLMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:12:41 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866E0C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 03:12:40 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n129so1870634iod.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2020 03:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d0GfdO7JXkiEcLNK6+4nDT65yhOpVcfU3tMJUKAFX/Y=;
        b=jafUJjOqF5iuCiNKamzhXZfEZ2b/KMJSV/69Aov1fbD58v8fUzXzme/k77v5/PTBtq
         IZ8QYN2UjmF2OEApFLD9HSnQFavdr4UUDX7cpXt0w3tCrPn1m6Eoyfl6901jVQGwiYym
         cFr29OMMYLb3oXnjmecSGsiRxF37VX406vLxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d0GfdO7JXkiEcLNK6+4nDT65yhOpVcfU3tMJUKAFX/Y=;
        b=BzOIsovxoibYyQ3WhKoHy+UEqVk73Jf5RvBDuE9fgcEVQBBU5MkM5CSEcHx8lkelkv
         GjsPWwp/OSvwQ/3vne74I/AI6Xm6HZ3u7CHpyoi2Z7Dv0GXn7rCRq4/1F2BaFtzXzqcc
         XxPiopqDHtSBmcRTqGdT5nRXnh4FgHzhqxUcRFDrkz81QwbQopzHM/dpAaWZXiH508PB
         AMmfT0uRPih4y7HJRe+6DHZCBssBCQEoaGl3WeIn3bkF0tYwysldFEG4AF02DQtiFnfk
         Sw8NtTqvS+5tvtIKbSs0h4Qn139OW7ctMXp2QXC2Nt50iJOupMkqiP2sarj3bj65BJXs
         784A==
X-Gm-Message-State: AOAM532rgnRSU0qQMSbekP1FFd4ZX0yztqT/omQuaSITS+IFra95ATZx
        LTI7HH4QiIiHRTjQ4oYBsbhbhw==
X-Google-Smtp-Source: ABdhPJx24PI5gINDAmGN9cKsbgQ8QJ/4C3dXJyR8HTMiufSH56fhugdT1cUZE1UKaMsItJ8xsCSweA==
X-Received: by 2002:a02:c884:: with SMTP id m4mr9701932jao.43.1605093159708;
        Wed, 11 Nov 2020 03:12:39 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id z11sm1094793iop.22.2020.11.11.03.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Nov 2020 03:12:38 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:12:36 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "alban.crequy@gmail.com" <alban.crequy@gmail.com>,
        "mauricio@kinvolk.io" <mauricio@kinvolk.io>,
        "smayhew@redhat.com" <smayhew@redhat.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "schumaker.anna@gmail.com" <schumaker.anna@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH v4 0/2] NFS: Fix interaction between fs_context and user
 namespaces
Message-ID: <20201111111233.GA21917@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201102174737.2740-1-sargun@sargun.me>
 <CAMXgnP5cVoLKTGPOAO+aLEAGLpkjACy1e4iLBKkfp8Gv1U77xA@mail.gmail.com>
 <f6d86006ccd19d4d101097de309eb21bbbf96e43.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d86006ccd19d4d101097de309eb21bbbf96e43.camel@hammerspace.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 10, 2020 at 08:12:01PM +0000, Trond Myklebust wrote:
> On Tue, 2020-11-10 at 17:43 +0100, Alban Crequy wrote:
> > Hi,
> > 
> > I tested the patches on top of 5.10.0-rc3+ and I could mount an NFS
> > share with a different user namespace. fsopen() is done in the
> > container namespaces (user, mnt and net namespaces) while fsconfig(),
> > fsmount() and move_mount() are done on the host namespaces. The mount
> > on the host is available in the container via mount propagation from
> > the host mount.
> > 
> > With this, the files on the NFS server with uid 0 are available in
> > the
> > container with uid 0. On the host, they are available with uid
> > 4294967294 (make_kuid(&init_user_ns, -2)).
> > 
> 
> Can someone please tell me what is broken with the _current_ design
> before we start trying to push "fixes" that clearly break it?
Currently the mechanism of mounting nfs4 in a user namespace is as follows:

Parent: fork()
Child: setns(userns)
C: fsopen("nfs4") = 3
C->P: Send FD 3
P: FSConfig...
P: fsmount... (This is where the CAP_SYS_ADMIN check happens))


Right now, when you mount an NFS filesystem in a non-init user
namespace, and you have UIDs / GIDs on, the UIDs / GIDs which
are sent to the server are not the UIDs from the mounting namespace,
instead they are the UIDs from the init user ns.

The reason for this is that you can call fsopen("nfs4") in the unprivileged 
namespace, and that configures fs_context with all the right information for 
that user namespace, but we currently require CAP_SYS_ADMIN in the init user 
namespace to call fsmount. This means that the superblock's user namespace is 
set "correctly" to the container, but there's absolutely no way nfs4uidmap
to consume an unprivileged user namespace.

This behaviour happens "the other way" as well, where the UID in the container
may be 0, but the corresponding kuid is 1000. When a response from an NFS
server comes in we decode it according to the idmap userns[1]. The userns
used to get create idmap is generated at fsmount time, and not as fsopen
time. So, even if the filesystem is in the user namespace, and the server
responds with UID 0, it'll come up with an unmapped UID.

This is because we do
Server UID 0 -> idmap make_kuid(init_user_ns, 0) -> VFS from_kuid(container_ns, 0) -> invalid uid

This is broken behaviour, in my humble opinion as is it makes it impossible to 
use NFSv4 (and v3 for that matter) out of the box with unprivileged user 
namespaces. At least in our environment, using usernames / GSS isn't an option,
so we have to rely on UIDs being set correctly [at least from the container's
perspective].


> 
> The current design assumes that the user namespace being used is the one where 
> the mount itself is performed. That means that the uids and gids or usernames 
> and groupnames that go on the wire match the uids and gids of the container in 
> which the mount occurred.
> 

Right now, NFS does not have the ability for the fsmount() call to be
called in an unprivileged user namespace. We can change that behaviour
elsewhere if we want, but it's orthogonal to this.

> The assumption is that the server has authenticated that client as
> belonging to a domain that it recognises (either through strong
> RPCSEC_GSS/krb5 authentication, or through weaker matching of IP
> addresses to a list of acceptable clients).
> 
I added a rejection for upcalls because upcalls can happen in the init 
namespaces. We can drop that restriction from the nfs4 patch if you'd like. I
*believe* (and I'm not a little out of my depth) that the request-key
handler gets called with the *network namespace* of the NFS mount,
but the userns is a privileged one, allowing for potential hazards.

The reason I added that block there is that I didn't imagine anyone was running 
NFS in an unprivileged user namespace, and relying on upcalls (potentially into 
privileged namespaces) in order to do authz.


> If you go ahead and change the user namespace on the client without
> going through the mount process again to mount a different super block
> with a different user namespace, then you will now get the exact same
> behaviour as if you do that with any other filesystem.

Not exactly, because other filesystems *only* use the s_user_ns for conversion 
of UIDs, whereas NFS uses the currend_cred() acquired at mount time, which 
doesn't match s_user_ns, leading to this behaviour.

1. Mistranslated UIDs in encoding RPCs
2. The UID / GID exposed to VFS do not match the user ns.

> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
-Thanks,
Sargun

[1]: https://elixir.bootlin.com/linux/v5.9.8/source/fs/nfs/nfs4idmap.c#L782
[2]: https://elixir.bootlin.com/linux/v5.9.8/source/fs/nfs/nfs4client.c#L1154
