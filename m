Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3343A222CE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 22:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgGPUev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 16:34:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27499 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725926AbgGPUeu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594931688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c/r4tdsrz9c/t7kzUXM6V6dGDNFnWeX/dhq9J93jq+c=;
        b=Q22bXouZPqEKKNpsEFdGMcczeHA1oo692YdUws6kXgPl+FOHBzDcsh2Iy5f8kc+aRGWNjK
        rxDyx1ggy6ykuxn4patCMllhGahDiq6W2NPZydIcTUv0RSfTkicU9FhNMtzarkgUsUblO6
        9EJzZN4sIWpRFXenzRfwDwML3TRCIq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-jL_sknZ9MgK7gGliAT6NIg-1; Thu, 16 Jul 2020 16:34:47 -0400
X-MC-Unique: jL_sknZ9MgK7gGliAT6NIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D40A81080;
        Thu, 16 Jul 2020 20:34:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8957319C58;
        Thu, 16 Jul 2020 20:34:38 +0000 (UTC)
Subject: [RFC PATCH 0/5] keys: Security changes, ACLs and Container keyring
From:   David Howells <dhowells@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     keyrings@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org,
        dhowells@redhat.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>, jlayton@redhat.com,
        christian@brauner.io, selinux@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org
Date:   Thu, 16 Jul 2020 21:34:37 +0100
Message-ID: <159493167778.3249370.8145886688150701997.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Here are some patches to provide some security changes and some container
support:

 (1) The mapping from KEY_NEED_* symbols to what is permitted is pushed
     further down into the general permissions checking routines and the
     LSMs.

     More KEY_NEED_* symbols are provided to give finer grained control in
     the mapping.

 (2) The permissions mask is replaced internally with an ACL that contains
     a list of ACEs, each with a specific subject and granted permissions
     mask.  Potted default ACLs are available for new keys and keyrings.

     ACE subjects include:

	- The owner of the key (uid)
	- The key's group (gid)
	- Anyone who possesses the key
	- Everyone
	- Containers (ie. user_namespaces)

 (3) The ACE permissions are split to give finer control.  Examples include
     splitting the revocation permit from the change-attributes permit,
     thereby allowing someone to be granted permission to revoke a key
     without allowing them to change the owner; also the ability to join a
     keyring is split from the ability to link to it, thereby stopping a
     process accessing a keyring by joining it and thus acquiring use of
     possessor permits.

     This is only accessible through the ACL interface; the old setperm
     interface concocts an ACL from what it is given.

 (4) A keyctl is provided to grant or remove a grant of one or more permits
     to a specific subject.  Direct access to the ACL is not permitted, and
     the ACL cannot be viewed.

 (5) A container keyring is made available on the user-namespace and
     created when needed.  This is searched by request_key() after it has
     searched the normal thread/process/session keyrings, but it can't
     normally be accessed from inside the container.  The container
     manager, however, *can* manipulate the contents of the keyring.

     This allows the manager to push keys into the container to allow the
     use of authenticated network filesystems without any need for the
     denizens inside the container to do anything as the manager can add
     and refresh the keys.

The patches can be found on the following branch:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=keys-acl

David
---
David Howells (1):
      keys: Implement a 'container' keyring


 Documentation/security/keys/core.rst               | 128 ++++-
 Documentation/security/keys/request-key.rst        |   9 +-
 certs/blacklist.c                                  |   9 +-
 certs/system_keyring.c                             |  12 +-
 crypto/asymmetric_keys/asymmetric_type.c           |   2 +-
 drivers/md/dm-crypt.c                              |   2 +-
 drivers/md/dm-verity-verify-sig.c                  |   3 +-
 drivers/nvdimm/security.c                          |   2 +-
 fs/afs/security.c                                  |   2 +-
 fs/cifs/cifs_spnego.c                              |  25 +-
 fs/cifs/cifsacl.c                                  |  28 +-
 fs/cifs/connect.c                                  |   4 +-
 fs/crypto/keyring.c                                |  29 +-
 fs/crypto/keysetup_v1.c                            |   2 +-
 fs/ecryptfs/ecryptfs_kernel.h                      |   2 +-
 fs/ecryptfs/keystore.c                             |   2 +-
 fs/fscache/object-list.c                           |   2 +-
 fs/nfs/nfs4idmap.c                                 |  30 +-
 fs/ubifs/auth.c                                    |   2 +-
 fs/verity/signature.c                              |  14 +-
 include/linux/key.h                                | 142 +++--
 include/linux/lsm_hook_defs.h                      |   2 +-
 include/linux/lsm_hooks.h                          |   8 +
 include/linux/security.h                           |   9 +-
 include/linux/user_namespace.h                     |   7 +
 include/uapi/linux/keyctl.h                        |  69 +++
 lib/digsig.c                                       |   2 +-
 net/ceph/ceph_common.c                             |   2 +-
 net/dns_resolver/dns_key.c                         |  12 +-
 net/dns_resolver/dns_query.c                       |  15 +-
 net/rxrpc/key.c                                    |  19 +-
 net/rxrpc/security.c                               |   2 +-
 net/wireless/reg.c                                 |   6 +-
 security/integrity/digsig.c                        |  31 +-
 security/integrity/digsig_asymmetric.c             |   2 +-
 security/integrity/evm/evm_crypto.c                |   2 +-
 security/integrity/ima/ima_mok.c                   |  13 +-
 security/integrity/integrity.h                     |   6 +-
 .../integrity/platform_certs/platform_keyring.c    |  14 +-
 security/keys/Kconfig                              |  11 +
 security/keys/compat.c                             |   5 +
 security/keys/dh.c                                 |   7 +-
 security/keys/encrypted-keys/encrypted.c           |   2 +-
 security/keys/encrypted-keys/masterkey_trusted.c   |   2 +-
 security/keys/gc.c                                 |   2 +-
 security/keys/internal.h                           |  41 +-
 security/keys/key.c                                |  98 ++--
 security/keys/keyctl.c                             | 580 +++++++++++---------
 security/keys/keyctl_pkey.c                        |  17 +-
 security/keys/keyring.c                            |  47 +-
 security/keys/permission.c                         | 600 +++++++++++++++++++--
 security/keys/persistent.c                         |  29 +-
 security/keys/proc.c                               |  27 +-
 security/keys/process_keys.c                       | 137 +++--
 security/keys/request_key.c                        |  49 +-
 security/keys/request_key_auth.c                   |  23 +-
 security/security.c                                |   4 +-
 security/selinux/hooks.c                           | 163 ++++--
 security/smack/smack_lsm.c                         |  90 +++-
 59 files changed, 1885 insertions(+), 721 deletions(-)


