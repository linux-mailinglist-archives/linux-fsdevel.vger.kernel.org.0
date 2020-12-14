Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E606C2D91E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 03:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438091AbgLNCx6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 21:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406970AbgLNCx5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:53:57 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F17C0613D3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 18:53:12 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id f14so5434927pju.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 18:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfQodhCI8ZuQp7YRRZQxpihD4EYNwbDWNGKzRDV3Rag=;
        b=1KGzDS5u0//+69i40jGl8BDlvmqcrhtOGrim4gQ5ZvvqQHMirN53vp1rc+KQ2APQji
         9Qd3c1wKn31jlea+mxfiu1w+7gInJ4ouz8qQcxMw5YKDSzVCmRaZx9YMvbNDmbwZydSl
         61B+dCsaa8pDkz33W8h+7js6xg2xFV1aH8glo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KfQodhCI8ZuQp7YRRZQxpihD4EYNwbDWNGKzRDV3Rag=;
        b=LkbgdR4+pQT6H3pmXCFg6wLSjioYQaRgqp87KmM9lnwxE/cfGA7i8T1bXidbwS5KhN
         3pehC2zZcokV7bPHRYE/Yx/J5lcrEbeLRcpufTK7msNb+StQsG+H+ZAJbB0oduqsk6jj
         DG9i676/MCzbWOnOZe4YoHcnMR8JcvJoWuZy7RaSd6C5khjRHl71oTKxyeE6nEd1bYFN
         Rgfsk/jD7l0lzkgdk4XWKDHg+zwl3NfRYFUonWx2xLkfM7uoiwzT0j/+FTWb6FQQ+gzA
         KZvv1n+KwGpxe3akEV7Q7LMeFbgtjB7x6BF/tLklO3wxS8aYuJSEPge3Jvyw868+MNlK
         JNag==
X-Gm-Message-State: AOAM530HkR+xE2PNTW/ycsaoyze0wRezfJqyhioSs/0OPtczn2O+lxKW
        13PZwmIfrGxnkIOw9d5hLxQHfA==
X-Google-Smtp-Source: ABdhPJxnGNsNFzFel27Bu+rpPuTScapWtzqvD2o5GTyqWhbGx2VaTCHkBQzQMWb/zF/JNETrpe05IA==
X-Received: by 2002:a17:902:bf06:b029:dc:1f:ac61 with SMTP id bi6-20020a170902bf06b02900dc001fac61mr2372550plb.16.1607914391619;
        Sun, 13 Dec 2020 18:53:11 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id h20sm17102713pgv.23.2020.12.13.18.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 18:53:10 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <schumaker.anna@gmail.com>,
        "J . Bruce Fields" <bfields@fieldses.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mauricio@kinvolk.io, Alban Crequy <alban.crequy@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RESEND v5 0/2] NFS: Fix interaction between fs_context and user namespaces
Date:   Sun, 13 Dec 2020 18:53:03 -0800
Message-Id: <20201214025305.25984-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a resend[2] for consideration into the next NFS client merge window.

Right now, it is possible to mount NFS with an non-matching super block
user ns, and NFS sunrpc user ns. This (for the user) results in an awkward
set of interactions if using anything other than auth_null, where the UIDs
being sent to the server are different than the local UIDs being checked.
This can cause "breakage", where if you try to communicate with the NFS
server with any other set of mappings, it breaks.

The reason for this is that you can call fsopen("nfs4") in the unprivileged
namespace, and that configures fs_context with all the right information
for that user namespace. In addition, it also keeps a gets a cred object
associated with the caller -- which should match the user namespace.
Unfortunately, the mount has to be finished in the init_user_ns because we
currently require CAP_SYS_ADMIN in the init user namespace to call fsmount.
This means that the superblock's user namespace is set "correctly" to the
container, but there's absolutely no way nfs4idmap to consume an
unprivileged user namespace because the cred / user_ns that's passed down
to nfs4idmap is the one at fsmount.

How this actually exhibits is let's say that the UID 0 in the user
namespace is mapped to UID 1000 in the init user ns (and kuid space). What
will happen is that nfs4idmap will translate the UID 1000 into UID 0 on the
wire, even if the mount is in entirely in the mount / user namespace of the
container.

So, it looks something like this
Client in unprivileged User NS (UID: 0, KUID: 0)
	->Perform open()
		...VFS / NFS bits...
		nfs_map_uid_to_name ->
			from_kuid_munged(init_user_ns, uid) (returns 0)
				RPC with UID 0

This behaviour happens "the other way" as well, where the UID in the
container may be 0, but the corresponding kuid is 1000. When a response
from an NFS server comes in we decode it according to the idmap userns.
The way this exhibits is even more odd.

Server responds with file attribute (UID: 0, GID: 0)
	->nfs_map_name_to_uid(..., 0)
		->make_kuid(init_user_ns, id) (returns 0)
			....VFS / NFS Bits...
			->from_kuid(container_ns, 0) -> invalid uid
				-> EOVERFLOW

This changes the nfs server to use the cred / userns from fs_context, which
is how idmap is constructed. This subsequently is used in the above
described flow of converting uids back-and-forth.

Trond gave the feedback that this behaviour [implemented by this patch] is
how the legacy sys_mount() behaviour worked[1], and that the intended
behaviour is for UIDs to be plumbed through entirely, where the user
namespaces UIDs are what is sent over the wire, and not the init user ns.

[1]: https://lore.kernel.org/linux-nfs/8feccf45f6575a204da03e796391cc135283eb88.camel@hammerspace.com/
[2]: https://lore.kernel.org/linux-nfs/20201112100952.3514-1-sargun@sargun.me/

Sargun Dhillon (2):
  NFS: NFSv2/NFSv3: Use cred from fs_context during mount
  NFSv4: Refactor to use user namespaces for nfs4idmap

 fs/nfs/client.c     | 4 ++--
 fs/nfs/nfs4client.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.25.1

