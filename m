Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E742B0287
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Nov 2020 11:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgKLKKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Nov 2020 05:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgKLKKR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:10:17 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266DDC0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 02:10:17 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so462148pfg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2020 02:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXrDzR3SLORDW5B7BUxvaBnQDDjG2dXfGiE5xVAIxC0=;
        b=nBow6u9tPZA43FN3nCgtszIoqhqbBJjGt0CmSFIvvOYVwRXDr7SihjVAAtnWPjQdp0
         dX+sebVqnQfw8LbuxSnfYoDc4g46kXifVQEDtx5fWi9C/6MJcfmSrqN04DOPYU6EYdeR
         ctU7Eht15V2KESPM+8lqAhTQh4Goj8IhT07k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZXrDzR3SLORDW5B7BUxvaBnQDDjG2dXfGiE5xVAIxC0=;
        b=NtjqN1qyf9a5kvWiqoOAx8r78Obl4yuefhur6onlDZVEJEU1UpiWplOPUWeABb/5f/
         rxCWd2ckLtDYFGSkkps9SX9I6ExUvGcDqDzAlMEMaN4Dz3P6rGTUdt2oEgCc6c1oCt71
         h9B72q+eMoJm8bEWRhb16HF6SzNivEzzV+yom6Eu8dEIQAEglgPkVMEubEKOqBcVMUUS
         G6arfsp7YuE/1kC3tu7NZu+WzRL24Eu5TZuIiEutSiRLn0wmSuTX57d1bA3WdtYTrRcG
         BlEC2eES2Ps1aB51hwK6SE461Ril3TF7LttDOBQS2PdWlivdoKnZaHhJ/UjkvCjLhqRz
         qJMA==
X-Gm-Message-State: AOAM533E7Ye9GaUCQfOp1yuWnRMwgtjaR2mrbFhYHA9WdkFaSVzqtr+b
        7wpRjxJ7sZwn8dx3sggQtWCMqYuNcpKK2lZjwPE=
X-Google-Smtp-Source: ABdhPJwB7gExvcWWZhLfWtnNMQ/JrrgUkIyGe5YvETA35aU+CCtIA0OUTuMLrMSotsd7uhY9aqguBg==
X-Received: by 2002:a17:90b:512:: with SMTP id r18mr8949419pjz.149.1605175816341;
        Thu, 12 Nov 2020 02:10:16 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id n1sm5577060pfu.211.2020.11.12.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:10:15 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>,
        Scott Mayhew <smayhew@redhat.com>
Cc:     mauricio@kinvolk.io, Alban Crequy <alban.crequy@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Anderson <kylea@netflix.com>
Subject: [PATCH v5 0/2] NFS: Fix interaction between fs_context and user namespaces
Date:   Thu, 12 Nov 2020 02:09:50 -0800
Message-Id: <20201112100952.3514-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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

Sargun Dhillon (2):
  NFS: NFSv2/NFSv3: Use cred from fs_context during mount
  NFSv4: Refactor to use user namespaces for nfs4idmap

 fs/nfs/client.c     | 4 ++--
 fs/nfs/nfs4client.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 8c39076c276be0b31982e44654e2c2357473258a
-- 
2.25.1

