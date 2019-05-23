Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68642281FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfEWP6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 11:58:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62483 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730752AbfEWP6i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 11:58:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9C7B64D87;
        Thu, 23 May 2019 15:58:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8D8D60C9E;
        Thu, 23 May 2019 15:58:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/2] KEYS: Replace uid/gid/perm permissions checking with an
 ACL
From:   David Howells <dhowells@redhat.com>
To:     keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 16:58:27 +0100
Message-ID: <155862710731.24863.14013725058582750710.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
References: <155862710003.24863.11807972177275927370.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 23 May 2019 15:58:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the uid/gid/perm permissions checking on a key with an ACL to allow
the SETATTR and SEARCH permissions to be split.  This will also allow a
greater range of subjects to represented.

============
WHY DO THIS?
============

The problem is that SETATTR and SEARCH cover a slew of actions, not all of
which should be grouped together.

For SETATTR, this includes actions that are about controlling access to a
key:

 (1) Changing a key's ownership.

 (2) Changing a key's security information.

 (3) Setting a keyring's restriction.

And actions that are about managing a key's lifetime:

 (4) Setting an expiry time.

 (5) Revoking a key.

and (proposed) managing a key as part of a cache:

 (6) Invalidating a key.

Managing a key's lifetime doesn't really have anything to do with
controlling access to that key.

Expiry time is awkward since it's more about the lifetime of the content
and so, in some ways goes better with WRITE permission.  It can, however,
be set unconditionally by a process with an appropriate authorisation token
for instantiating a key, and can also be set by the key type driver when a
key is instantiated, so lumping it with the access-controlling actions is
probably okay.

As for SEARCH permission, that currently covers:

 (1) Finding keys in a keyring tree during a search.

 (2) Permitting keyrings to be joined.

 (3) Invalidation.

But these don't really belong together either, since these actions really
need to be controlled separately.

Finally, there are number of special cases to do with granting the
administrator special rights to invalidate or clear keys that I would like
to handle with the ACL rather than key flags and special checks.


===============
WHAT IS CHANGED
===============

The SETATTR permission is split to create two new permissions:

 (1) SET_SECURITY - which allows the key's owner, group and ACL to be
     changed and a restriction to be placed on a keyring.

 (2) REVOKE - which allows a key to be revoked.

The SEARCH permission is split to create:

 (1) SEARCH - which allows a keyring to be search and a key to be found.

 (2) JOIN - which allows a keyring to be joined as a session keyring.

 (3) INVAL - which allows a key to be invalidated.

The WRITE permission is also split to create:

 (1) WRITE - which allows a key's content to be altered and links to be
     added, removed and replaced in a keyring.

 (2) CLEAR - which allows a keyring to be cleared completely.  This is
     split out to make it possible to give just this to an administrator.

 (3) REVOKE - see above.


Keys acquire ACLs which consist of a series of ACEs, and all that apply are
unioned together.  An ACE specifies a subject, such as:

 (*) Possessor - permitted to anyone who 'possesses' a key
 (*) Owner - permitted to the key owner
 (*) Group - permitted to the key group
 (*) Everyone - permitted to everyone

Note that 'Other' has been replaced with 'Everyone' on the assumption that
you wouldn't grant a permit to 'Other' that you wouldn't also grant to
everyone else.

Further subjects may be made available by later patches.

The ACE also specifies a permissions mask.  The set of permissions is now:

	VIEW		Can view the key metadata
	READ		Can read the key content
	WRITE		Can update/modify the key content
	SEARCH		Can find the key by searching/requesting
	LINK		Can make a link to the key
	SET_SECURITY	Can change owner, ACL, expiry
	INVAL		Can invalidate
	REVOKE		Can revoke
	JOIN		Can join this keyring
	CLEAR		Can clear this keyring


The KEYCTL_SETPERM function is then deprecated.

The KEYCTL_SET_TIMEOUT function then is permitted if SET_SECURITY is set,
or if the caller has a valid instantiation auth token.

The KEYCTL_INVALIDATE function then requires INVAL.

The KEYCTL_REVOKE function then requires REVOKE.

The KEYCTL_JOIN_SESSION_KEYRING function then requires JOIN to join an
existing keyring.

The JOIN permission is enabled by default for session keyrings and manually
created keyrings only.


======================
BACKWARD COMPATIBILITY
======================

To maintain backward compatibility, KEYCTL_SETPERM will translate the
permissions mask it is given into a new ACL for a key - unless
KEYCTL_SET_ACL has been called on that key, in which case an error will be
returned.

It will convert possessor, owner, group and other permissions into separate
ACEs, if each portion of the mask is non-zero.

SETATTR permission turns on all of INVAL, REVOKE and SET_SECURITY.  WRITE
permission turns on WRITE, REVOKE and, if a keyring, CLEAR.  JOIN is turned
on if a keyring is being altered.

The KEYCTL_DESCRIBE function translates the ACL back into a permissions
mask to return depending on possessor, owner, group and everyone ACEs.

It will make the following mappings:

 (1) INVAL, JOIN -> SEARCH

 (2) SET_SECURITY -> SETATTR

 (3) REVOKE -> WRITE if SETATTR isn't already set

 (4) CLEAR -> WRITE

Note that the value subsequently returned by KEYCTL_DESCRIBE may not match
the value set with KEYCTL_SETATTR.


=======
TESTING
=======

This passes the keyutils testsuite for all but a couple of tests:

 (1) tests/keyctl/dh_compute/badargs: The first wrong-key-type test now
     returns EOPNOTSUPP rather than ENOKEY as READ permission isn't removed
     if the type doesn't have ->read().  You still can't actually read the
     key.

 (2) tests/keyctl/permitting/valid: The view-other-permissions test doesn't
     work as Other has been replaced with Everyone in the ACL.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 certs/blacklist.c                                  |    7 -
 certs/system_keyring.c                             |   12 -
 drivers/md/dm-crypt.c                              |    2 
 drivers/nvdimm/security.c                          |    2 
 fs/afs/security.c                                  |    2 
 fs/cifs/cifs_spnego.c                              |   25 ++
 fs/cifs/cifsacl.c                                  |   28 ++
 fs/cifs/connect.c                                  |    4 
 fs/crypto/keyinfo.c                                |    2 
 fs/ecryptfs/ecryptfs_kernel.h                      |    2 
 fs/ecryptfs/keystore.c                             |    2 
 fs/fscache/object-list.c                           |    2 
 fs/nfs/nfs4idmap.c                                 |   30 ++-
 fs/ubifs/auth.c                                    |    2 
 include/linux/key.h                                |  121 ++++++----
 include/uapi/linux/keyctl.h                        |   63 +++++
 lib/digsig.c                                       |    2 
 net/ceph/ceph_common.c                             |    2 
 net/dns_resolver/dns_key.c                         |   12 +
 net/dns_resolver/dns_query.c                       |   15 +
 net/rxrpc/key.c                                    |   16 +
 security/integrity/digsig.c                        |   31 +--
 security/integrity/digsig_asymmetric.c             |    2 
 security/integrity/evm/evm_crypto.c                |    2 
 security/integrity/ima/ima_mok.c                   |   13 +
 security/integrity/integrity.h                     |    4 
 .../integrity/platform_certs/platform_keyring.c    |   13 +
 security/keys/encrypted-keys/encrypted.c           |    2 
 security/keys/encrypted-keys/masterkey_trusted.c   |    2 
 security/keys/gc.c                                 |    2 
 security/keys/internal.h                           |   11 +
 security/keys/key.c                                |   29 +-
 security/keys/keyctl.c                             |   92 +++++---
 security/keys/keyring.c                            |   27 ++
 security/keys/permission.c                         |  237 +++++++++++++++++---
 security/keys/persistent.c                         |   27 ++
 security/keys/proc.c                               |   20 +-
 security/keys/process_keys.c                       |   86 +++++--
 security/keys/request_key.c                        |   34 +--
 security/keys/request_key_auth.c                   |   15 +
 security/selinux/hooks.c                           |   16 +
 security/smack/smack_lsm.c                         |    3 
 42 files changed, 736 insertions(+), 285 deletions(-)

diff --git a/certs/blacklist.c b/certs/blacklist.c
index 181cb7fa9540..39de9d68b21e 100644
--- a/certs/blacklist.c
+++ b/certs/blacklist.c
@@ -93,8 +93,7 @@ int mark_hash_blacklisted(const char *hash)
 				   hash,
 				   NULL,
 				   0,
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW),
+				   &internal_key_acl,
 				   KEY_ALLOC_NOT_IN_QUOTA |
 				   KEY_ALLOC_BUILT_IN);
 	if (IS_ERR(key)) {
@@ -153,9 +152,7 @@ static int __init blacklist_init(void)
 		keyring_alloc(".blacklist",
 			      KUIDT_INIT(0), KGIDT_INIT(0),
 			      current_cred(),
-			      (KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			      KEY_USR_VIEW | KEY_USR_READ |
-			      KEY_USR_SEARCH,
+			      &internal_keyring_acl,
 			      KEY_ALLOC_NOT_IN_QUOTA |
 			      KEY_FLAG_KEEP,
 			      NULL, NULL);
diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index c05c29ae4d5d..2873a4ce2828 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -103,9 +103,7 @@ static __init int system_trusted_keyring_init(void)
 	builtin_trusted_keys =
 		keyring_alloc(".builtin_trusted_keys",
 			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			      KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
-			      KEY_ALLOC_NOT_IN_QUOTA,
+			      &internal_key_acl, KEY_ALLOC_NOT_IN_QUOTA,
 			      NULL, NULL);
 	if (IS_ERR(builtin_trusted_keys))
 		panic("Can't allocate builtin trusted keyring\n");
@@ -114,10 +112,7 @@ static __init int system_trusted_keyring_init(void)
 	secondary_trusted_keys =
 		keyring_alloc(".secondary_trusted_keys",
 			      KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-			      ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-			       KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
-			       KEY_USR_WRITE),
-			      KEY_ALLOC_NOT_IN_QUOTA,
+			      &internal_writable_keyring_acl, KEY_ALLOC_NOT_IN_QUOTA,
 			      get_builtin_and_secondary_restriction(),
 			      NULL);
 	if (IS_ERR(secondary_trusted_keys))
@@ -167,8 +162,7 @@ static __init int load_system_certificate_list(void)
 					   NULL,
 					   p,
 					   plen,
-					   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-					   KEY_USR_VIEW | KEY_USR_READ),
+					   &internal_key_acl,
 					   KEY_ALLOC_NOT_IN_QUOTA |
 					   KEY_ALLOC_BUILT_IN |
 					   KEY_ALLOC_BYPASS_RESTRICTION);
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 1b16d34bb785..0fd3ca9bfe54 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2035,7 +2035,7 @@ static int crypt_set_keyring_key(struct crypt_config *cc, const char *key_string
 		return -ENOMEM;
 
 	key = request_key(key_string[0] == 'l' ? &key_type_logon : &key_type_user,
-			  key_desc + 1, NULL);
+			  key_desc + 1, NULL, NULL);
 	if (IS_ERR(key)) {
 		kzfree(new_key_string);
 		return PTR_ERR(key);
diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index a570f2263a42..99a5708b37e3 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -55,7 +55,7 @@ static struct key *nvdimm_request_key(struct nvdimm *nvdimm)
 	struct device *dev = &nvdimm->dev;
 
 	sprintf(desc, "%s%s", NVDIMM_PREFIX, nvdimm->dimm_id);
-	key = request_key(&key_type_encrypted, desc, "");
+	key = request_key(&key_type_encrypted, desc, "", NULL);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) == -ENOKEY)
 			dev_dbg(dev, "request_key() found no key\n");
diff --git a/fs/afs/security.c b/fs/afs/security.c
index 5d8ece98561e..3185898237b2 100644
--- a/fs/afs/security.c
+++ b/fs/afs/security.c
@@ -32,7 +32,7 @@ struct key *afs_request_key(struct afs_cell *cell)
 
 	_debug("key %s", cell->anonymous_key->description);
 	key = request_key(&key_type_rxrpc, cell->anonymous_key->description,
-			  NULL);
+			  NULL, NULL);
 	if (IS_ERR(key)) {
 		if (PTR_ERR(key) != -ENOKEY) {
 			_leave(" = %ld", PTR_ERR(key));
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 7f01c6e60791..d1b439ad0f1a 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -32,6 +32,25 @@
 #include "cifsproto.h"
 static const struct cred *spnego_cred;
 
+static struct key_acl cifs_spnego_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
+static struct key_acl cifs_spnego_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_CLEAR),
+	}
+};
+
 /* create a new cifs key */
 static int
 cifs_spnego_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
@@ -170,7 +189,8 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo)
 
 	cifs_dbg(FYI, "key description = %s\n", description);
 	saved_cred = override_creds(spnego_cred);
-	spnego_key = request_key(&cifs_spnego_key_type, description, "");
+	spnego_key = request_key(&cifs_spnego_key_type, description, "",
+				 &cifs_spnego_key_acl);
 	revert_creds(saved_cred);
 
 #ifdef CONFIG_CIFS_DEBUG2
@@ -207,8 +227,7 @@ init_cifs_spnego(void)
 
 	keyring = keyring_alloc(".cifs_spnego",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&cifs_spnego_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index 1d377b7f2860..78eed72f3af0 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -33,6 +33,25 @@
 #include "cifsproto.h"
 #include "cifs_debug.h"
 
+static struct key_acl cifs_idmap_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
+static struct key_acl cifs_idmap_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+	}
+};
+
 /* security id for everyone/world system group */
 static const struct cifs_sid sid_everyone = {
 	1, 1, {0, 0, 0, 0, 0, 1}, {0} };
@@ -298,7 +317,8 @@ id_to_sid(unsigned int cid, uint sidtype, struct cifs_sid *ssid)
 
 	rc = 0;
 	saved_cred = override_creds(root_cred);
-	sidkey = request_key(&cifs_idmap_key_type, desc, "");
+	sidkey = request_key(&cifs_idmap_key_type, desc, "",
+			     &cifs_idmap_key_acl);
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
 		cifs_dbg(FYI, "%s: Can't map %cid %u to a SID\n",
@@ -403,7 +423,8 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct cifs_sid *psid,
 		return -ENOMEM;
 
 	saved_cred = override_creds(root_cred);
-	sidkey = request_key(&cifs_idmap_key_type, sidstr, "");
+	sidkey = request_key(&cifs_idmap_key_type, sidstr, "",
+			     &cifs_idmap_key_acl);
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
 		cifs_dbg(FYI, "%s: Can't map SID %s to a %cid\n",
@@ -481,8 +502,7 @@ init_cifs_idmap(void)
 
 	keyring = keyring_alloc(".cifs_idmap",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&cifs_idmap_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 8c4121da624e..6e50d3e87948 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2990,7 +2990,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 	}
 
 	cifs_dbg(FYI, "%s: desc=%s\n", __func__, desc);
-	key = request_key(&key_type_logon, desc, "");
+	key = request_key(&key_type_logon, desc, "", NULL);
 	if (IS_ERR(key)) {
 		if (!ses->domainName) {
 			cifs_dbg(FYI, "domainName is NULL\n");
@@ -3001,7 +3001,7 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 		/* didn't work, try to find a domain key */
 		sprintf(desc, "cifs:d:%s", ses->domainName);
 		cifs_dbg(FYI, "%s: desc=%s\n", __func__, desc);
-		key = request_key(&key_type_logon, desc, "");
+		key = request_key(&key_type_logon, desc, "", NULL);
 		if (IS_ERR(key)) {
 			rc = PTR_ERR(key);
 			goto out_err;
diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index dcd91a3fbe49..4f85af8ab239 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -92,7 +92,7 @@ find_and_lock_process_key(const char *prefix,
 	if (!description)
 		return ERR_PTR(-ENOMEM);
 
-	key = request_key(&key_type_logon, description, NULL);
+	key = request_key(&key_type_logon, description, NULL, NULL);
 	kfree(description);
 	if (IS_ERR(key))
 		return key;
diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index e74cb2a0b299..6460bd2a4e9d 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -105,7 +105,7 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 
 static inline struct key *ecryptfs_get_encrypted_key(char *sig)
 {
-	return request_key(&key_type_encrypted, sig, NULL);
+	return request_key(&key_type_encrypted, sig, NULL, NULL);
 }
 
 #else
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 90fbac5d485b..923a6006ccea 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1624,7 +1624,7 @@ int ecryptfs_keyring_auth_tok_for_sig(struct key **auth_tok_key,
 {
 	int rc = 0;
 
-	(*auth_tok_key) = request_key(&key_type_user, sig, NULL);
+	(*auth_tok_key) = request_key(&key_type_user, sig, NULL, NULL);
 	if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
 		(*auth_tok_key) = ecryptfs_get_encrypted_key(sig);
 		if (!(*auth_tok_key) || IS_ERR(*auth_tok_key)) {
diff --git a/fs/fscache/object-list.c b/fs/fscache/object-list.c
index 43e6e28c164f..6a672289e5ec 100644
--- a/fs/fscache/object-list.c
+++ b/fs/fscache/object-list.c
@@ -321,7 +321,7 @@ static void fscache_objlist_config(struct fscache_objlist_data *data)
 	const char *buf;
 	int len;
 
-	key = request_key(&key_type_user, "fscache:objlist", NULL);
+	key = request_key(&key_type_user, "fscache:objlist", NULL, NULL);
 	if (IS_ERR(key))
 		goto no_config;
 
diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 1e7296395d71..69679f4f2e6c 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -72,6 +72,25 @@ struct idmap {
 	const struct cred	*cred;
 };
 
+static struct key_acl nfs_idmap_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
+static struct key_acl nfs_idmap_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+	}
+};
+
 static struct user_namespace *idmap_userns(const struct idmap *idmap)
 {
 	if (idmap && idmap->cred)
@@ -208,8 +227,7 @@ int nfs_idmap_init(void)
 
 	keyring = keyring_alloc(".id_resolver",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&nfs_idmap_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -287,11 +305,13 @@ static struct key *nfs_idmap_request_key(const char *name, size_t namelen,
 		return ERR_PTR(ret);
 
 	if (!idmap->cred || idmap->cred->user_ns == &init_user_ns)
-		rkey = request_key(&key_type_id_resolver, desc, "");
+		rkey = request_key(&key_type_id_resolver, desc, "",
+				   &nfs_idmap_key_acl);
 	if (IS_ERR(rkey)) {
 		mutex_lock(&idmap->idmap_mutex);
 		rkey = request_key_with_auxdata(&key_type_id_resolver_legacy,
-						desc, NULL, "", 0, idmap);
+						desc, NULL, "", 0, idmap,
+						&nfs_idmap_key_acl);
 		mutex_unlock(&idmap->idmap_mutex);
 	}
 	if (!IS_ERR(rkey))
@@ -320,8 +340,6 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 	}
 
 	rcu_read_lock();
-	rkey->perm |= KEY_USR_VIEW;
-
 	ret = key_validate(rkey);
 	if (ret < 0)
 		goto out_up;
diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index 60f43b93d06e..38718026ad0b 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -227,7 +227,7 @@ int ubifs_init_authentication(struct ubifs_info *c)
 	snprintf(hmac_name, CRYPTO_MAX_ALG_NAME, "hmac(%s)",
 		 c->auth_hash_name);
 
-	keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL);
+	keyring_key = request_key(&key_type_logon, c->auth_key_name, NULL, NULL);
 
 	if (IS_ERR(keyring_key)) {
 		ubifs_err(c, "Failed to request key: %ld",
diff --git a/include/linux/key.h b/include/linux/key.h
index 18d7f62ab6b0..bc4adfd254fe 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -32,49 +32,14 @@
 /* key handle serial number */
 typedef int32_t key_serial_t;
 
-/* key handle permissions mask */
-typedef uint32_t key_perm_t;
-
 struct key;
 struct net;
 
 #ifdef CONFIG_KEYS
 
-#undef KEY_DEBUGGING
+#include <linux/keyctl.h>
 
-#define KEY_POS_VIEW	0x01000000	/* possessor can view a key's attributes */
-#define KEY_POS_READ	0x02000000	/* possessor can read key payload / view keyring */
-#define KEY_POS_WRITE	0x04000000	/* possessor can update key payload / add link to keyring */
-#define KEY_POS_SEARCH	0x08000000	/* possessor can find a key in search / search a keyring */
-#define KEY_POS_LINK	0x10000000	/* possessor can create a link to a key/keyring */
-#define KEY_POS_SETATTR	0x20000000	/* possessor can set key attributes */
-#define KEY_POS_ALL	0x3f000000
-
-#define KEY_USR_VIEW	0x00010000	/* user permissions... */
-#define KEY_USR_READ	0x00020000
-#define KEY_USR_WRITE	0x00040000
-#define KEY_USR_SEARCH	0x00080000
-#define KEY_USR_LINK	0x00100000
-#define KEY_USR_SETATTR	0x00200000
-#define KEY_USR_ALL	0x003f0000
-
-#define KEY_GRP_VIEW	0x00000100	/* group permissions... */
-#define KEY_GRP_READ	0x00000200
-#define KEY_GRP_WRITE	0x00000400
-#define KEY_GRP_SEARCH	0x00000800
-#define KEY_GRP_LINK	0x00001000
-#define KEY_GRP_SETATTR	0x00002000
-#define KEY_GRP_ALL	0x00003f00
-
-#define KEY_OTH_VIEW	0x00000001	/* third party permissions... */
-#define KEY_OTH_READ	0x00000002
-#define KEY_OTH_WRITE	0x00000004
-#define KEY_OTH_SEARCH	0x00000008
-#define KEY_OTH_LINK	0x00000010
-#define KEY_OTH_SETATTR	0x00000020
-#define KEY_OTH_ALL	0x0000003f
-
-#define KEY_PERM_UNDEF	0xffffffff
+#undef KEY_DEBUGGING
 
 struct seq_file;
 struct user_struct;
@@ -118,6 +83,36 @@ union key_payload {
 	void			*data[4];
 };
 
+struct key_ace {
+	unsigned int		type;
+	unsigned int		perm;
+	union {
+		kuid_t		uid;
+		kgid_t		gid;
+		unsigned int	subject_id;
+	};
+};
+
+struct key_acl {
+	refcount_t		usage;
+	unsigned short		nr_ace;
+	bool			possessor_viewable;
+	struct rcu_head		rcu;
+	struct key_ace		aces[];
+};
+
+#define KEY_POSSESSOR_ACE(perms) {			\
+		.type = KEY_ACE_SUBJ_STANDARD,		\
+		.perm = perms,				\
+		.subject_id = KEY_ACE_POSSESSOR		\
+	}
+
+#define KEY_OWNER_ACE(perms) {				\
+		.type = KEY_ACE_SUBJ_STANDARD,		\
+		.perm = perms,				\
+		.subject_id = KEY_ACE_OWNER		\
+	}
+
 /*****************************************************************************/
 /*
  * key reference with possession attribute handling
@@ -184,6 +179,7 @@ struct key {
 	struct rw_semaphore	sem;		/* change vs change sem */
 	struct key_user		*user;		/* owner of this key */
 	void			*security;	/* security data for this key */
+	struct key_acl		__rcu *acl;
 	union {
 		time64_t	expiry;		/* time at which key expires (or 0) */
 		time64_t	revoked_at;	/* time at which key was revoked */
@@ -191,7 +187,6 @@ struct key {
 	time64_t		last_used_at;	/* last time used for LRU keyring discard */
 	kuid_t			uid;
 	kgid_t			gid;
-	key_perm_t		perm;		/* access permissions */
 	unsigned short		quotalen;	/* length added to quota */
 	unsigned short		datalen;	/* payload data length
 						 * - may not match RCU dereferenced payload
@@ -215,6 +210,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
+#define KEY_FLAG_HAS_ACL	10	/* Set if KEYCTL_SETACL called on key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
@@ -263,7 +259,7 @@ extern struct key *key_alloc(struct key_type *type,
 			     const char *desc,
 			     kuid_t uid, kgid_t gid,
 			     const struct cred *cred,
-			     key_perm_t perm,
+			     struct key_acl *acl,
 			     unsigned long flags,
 			     struct key_restriction *restrict_link);
 
@@ -300,7 +296,8 @@ static inline void key_ref_put(key_ref_t key_ref)
 extern struct key *request_key_tag(struct key_type *type,
 				   const char *description,
 				   struct key_tag *domain_tag,
-				   const char *callout_info);
+				   const char *callout_info,
+				   struct key_acl *acl);
 
 extern struct key *request_key_rcu(struct key_type *type,
 				   const char *description,
@@ -311,21 +308,24 @@ extern struct key *request_key_with_auxdata(struct key_type *type,
 					    struct key_tag *domain_tag,
 					    const void *callout_info,
 					    size_t callout_len,
-					    void *aux);
+					    void *aux,
+					    struct key_acl *acl);
 
 /**
  * request_key - Request a key and wait for construction
  * @type: Type of key.
  * @description: The searchable description of the key.
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
+ * @acl: The ACL to attach to a new key (or NULL).
  *
  * As for request_key_tag(), but with the default global domain tag.
  */
 static inline struct key *request_key(struct key_type *type,
 				      const char *description,
-				      const char *callout_info)
+				      const char *callout_info,
+				      struct key_acl *acl)
 {
-	return request_key_tag(type, description, NULL, callout_info);
+	return request_key_tag(type, description, NULL, callout_info, acl);
 }
 
 #ifdef CONFIG_NET
@@ -335,6 +335,7 @@ static inline struct key *request_key(struct key_type *type,
  * @description: The searchable description of the key.
  * @net: The network namespace that is the key's domain of operation.
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
+ * @acl: The ACL to attach to a new key (or NULL).
  *
  * As for request_key() except that it does not add the returned key to a
  * keyring if found, new keys are always allocated in the user's quota, the
@@ -344,8 +345,8 @@ static inline struct key *request_key(struct key_type *type,
  * Furthermore, it then works as wait_for_key_construction() to wait for the
  * completion of keys undergoing construction with a non-interruptible wait.
  */
-#define request_key_net(type, description, net, callout_info) \
-	request_key_tag(type, description, net->key_domain, callout_info);
+#define request_key_net(type, description, net, callout_info, acl)	\
+	request_key_tag(type, description, net->key_domain, callout_info, acl);
 #endif /* CONFIG_NET */
 
 extern int wait_for_key_construction(struct key *key, bool intr);
@@ -357,7 +358,7 @@ extern key_ref_t key_create_or_update(key_ref_t keyring,
 				      const char *description,
 				      const void *payload,
 				      size_t plen,
-				      key_perm_t perm,
+				      struct key_acl *acl,
 				      unsigned long flags);
 
 extern int key_update(key_ref_t key,
@@ -377,7 +378,7 @@ extern int key_unlink(struct key *keyring,
 
 extern struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 				 const struct cred *cred,
-				 key_perm_t perm,
+				 struct key_acl *acl,
 				 unsigned long flags,
 				 struct key_restriction *restrict_link,
 				 struct key *dest);
@@ -410,19 +411,29 @@ static inline key_serial_t key_serial(const struct key *key)
 extern void key_set_timeout(struct key *, unsigned);
 
 extern key_ref_t lookup_user_key(key_serial_t id, unsigned long flags,
-				 key_perm_t perm);
+				 u32 desired_perm);
 extern void key_free_user_ns(struct user_namespace *);
 
 /*
  * The permissions required on a key that we're looking up.
  */
-#define	KEY_NEED_VIEW	0x01	/* Require permission to view attributes */
-#define	KEY_NEED_READ	0x02	/* Require permission to read content */
-#define	KEY_NEED_WRITE	0x04	/* Require permission to update / modify */
-#define	KEY_NEED_SEARCH	0x08	/* Require permission to search (keyring) or find (key) */
-#define	KEY_NEED_LINK	0x10	/* Require permission to link */
-#define	KEY_NEED_SETATTR 0x20	/* Require permission to change attributes */
-#define	KEY_NEED_ALL	0x3f	/* All the above permissions */
+#define	KEY_NEED_VIEW	0x001	/* Require permission to view attributes */
+#define	KEY_NEED_READ	0x002	/* Require permission to read content */
+#define	KEY_NEED_WRITE	0x004	/* Require permission to update / modify */
+#define	KEY_NEED_SEARCH	0x008	/* Require permission to search (keyring) or find (key) */
+#define	KEY_NEED_LINK	0x010	/* Require permission to link */
+#define	KEY_NEED_SETSEC	0x020	/* Require permission to set owner, group, ACL */
+#define	KEY_NEED_INVAL	0x040	/* Require permission to invalidate key */
+#define	KEY_NEED_REVOKE	0x080	/* Require permission to revoke key */
+#define	KEY_NEED_JOIN	0x100	/* Require permission to join keyring as session */
+#define	KEY_NEED_CLEAR	0x200	/* Require permission to clear a keyring */
+#define KEY_NEED_ALL	0x3ff
+
+#define OLD_KEY_NEED_SETATTR 0x20 /* Used to be Require permission to change attributes */
+
+extern struct key_acl internal_key_acl;
+extern struct key_acl internal_keyring_acl;
+extern struct key_acl internal_writable_keyring_acl;
 
 static inline short key_read_state(const struct key *key)
 {
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index fd9fb11b312b..eb0bfd491374 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -15,6 +15,69 @@
 
 #include <linux/types.h>
 
+/*
+ * Keyring permission grant definitions
+ */
+enum key_ace_subject_type {
+	KEY_ACE_SUBJ_STANDARD	= 0,	/* subject is one of key_ace_standard_subject */
+	nr__key_ace_subject_type
+};
+
+enum key_ace_standard_subject {
+	KEY_ACE_EVERYONE	= 0,	/* Everyone, including owner and group */
+	KEY_ACE_GROUP		= 1,	/* The key's group */
+	KEY_ACE_OWNER		= 2,	/* The owner of the key */
+	KEY_ACE_POSSESSOR	= 3,	/* Any process that possesses of the key */
+	nr__key_ace_standard_subject
+};
+
+#define KEY_ACE_VIEW		0x00000001 /* Can describe the key */
+#define KEY_ACE_READ		0x00000002 /* Can read the key content */
+#define KEY_ACE_WRITE		0x00000004 /* Can update/modify the key content */
+#define KEY_ACE_SEARCH		0x00000008 /* Can find the key by search */
+#define KEY_ACE_LINK		0x00000010 /* Can make a link to the key */
+#define KEY_ACE_SET_SECURITY	0x00000020 /* Can set owner, group, ACL */
+#define KEY_ACE_INVAL		0x00000040 /* Can invalidate the key */
+#define KEY_ACE_REVOKE		0x00000080 /* Can revoke the key */
+#define KEY_ACE_JOIN		0x00000100 /* Can join keyring */
+#define KEY_ACE_CLEAR		0x00000200 /* Can clear keyring */
+#define KEY_ACE__PERMS		0xffffffff
+
+/*
+ * Old-style permissions mask, deprecated in favour of ACL.
+ */
+#define KEY_POS_VIEW	0x01000000	/* possessor can view a key's attributes */
+#define KEY_POS_READ	0x02000000	/* possessor can read key payload / view keyring */
+#define KEY_POS_WRITE	0x04000000	/* possessor can update key payload / add link to keyring */
+#define KEY_POS_SEARCH	0x08000000	/* possessor can find a key in search / search a keyring */
+#define KEY_POS_LINK	0x10000000	/* possessor can create a link to a key/keyring */
+#define KEY_POS_SETATTR	0x20000000	/* possessor can set key attributes */
+#define KEY_POS_ALL	0x3f000000
+
+#define KEY_USR_VIEW	0x00010000	/* user permissions... */
+#define KEY_USR_READ	0x00020000
+#define KEY_USR_WRITE	0x00040000
+#define KEY_USR_SEARCH	0x00080000
+#define KEY_USR_LINK	0x00100000
+#define KEY_USR_SETATTR	0x00200000
+#define KEY_USR_ALL	0x003f0000
+
+#define KEY_GRP_VIEW	0x00000100	/* group permissions... */
+#define KEY_GRP_READ	0x00000200
+#define KEY_GRP_WRITE	0x00000400
+#define KEY_GRP_SEARCH	0x00000800
+#define KEY_GRP_LINK	0x00001000
+#define KEY_GRP_SETATTR	0x00002000
+#define KEY_GRP_ALL	0x00003f00
+
+#define KEY_OTH_VIEW	0x00000001	/* third party permissions... */
+#define KEY_OTH_READ	0x00000002
+#define KEY_OTH_WRITE	0x00000004
+#define KEY_OTH_SEARCH	0x00000008
+#define KEY_OTH_LINK	0x00000010
+#define KEY_OTH_SETATTR	0x00000020
+#define KEY_OTH_ALL	0x0000003f
+
 /* special process keyring shortcut IDs */
 #define KEY_SPEC_THREAD_KEYRING		-1	/* - key ID for thread-specific keyring */
 #define KEY_SPEC_PROCESS_KEYRING	-2	/* - key ID for process-specific keyring */
diff --git a/lib/digsig.c b/lib/digsig.c
index 3782af401c68..ce87ca2e0929 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -227,7 +227,7 @@ int digsig_verify(struct key *keyring, const char *sig, int siglen,
 		else
 			key = key_ref_to_ptr(kref);
 	} else {
-		key = request_key(&key_type_user, name, NULL);
+		key = request_key(&key_type_user, name, NULL, NULL);
 	}
 	if (IS_ERR(key)) {
 		pr_err("key not found, id: %s\n", name);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 79eac465ec65..d4af93a35e2b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -305,7 +305,7 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name) {
 	int err = 0;
 	struct ceph_crypto_key *ckey;
 
-	ukey = request_key(&key_type_ceph, name, NULL);
+	ukey = request_key(&key_type_ceph, name, NULL, NULL);
 	if (IS_ERR(ukey)) {
 		/* request_key errors don't map nicely to mount(2)
 		   errors; don't even try, but still printk */
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index 3e1a90669006..6b201531b165 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -46,6 +46,15 @@ const struct cred *dns_resolver_cache;
 
 #define	DNS_ERRORNO_OPTION	"dnserror"
 
+static struct key_acl dns_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_CLEAR),
+	}
+};
+
 /*
  * Preparse instantiation data for a dns_resolver key.
  *
@@ -343,8 +352,7 @@ static int __init init_dns_resolver(void)
 
 	keyring = keyring_alloc(".dns_resolver",
 				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ,
+				&dns_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index cab4e0df924f..236baf2bfa4c 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -47,6 +47,16 @@
 
 #include "internal.h"
 
+static struct key_acl dns_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_SEARCH | KEY_ACE_READ),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_INVAL),
+	}
+};
+
 /**
  * dns_query - Query the DNS
  * @net: The network namespace to operate in.
@@ -125,7 +135,8 @@ int dns_query(struct net *net,
 	 * add_key() to preinstall malicious redirections
 	 */
 	saved_cred = override_creds(dns_resolver_cache);
-	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
+	rkey = request_key_net(&key_type_dns_resolver, desc, net, options,
+			       &dns_key_acl);
 	revert_creds(saved_cred);
 	kfree(desc);
 	if (IS_ERR(rkey)) {
@@ -135,8 +146,6 @@ int dns_query(struct net *net,
 
 	down_read(&rkey->sem);
 	set_bit(KEY_FLAG_ROOT_CAN_INVAL, &rkey->flags);
-	rkey->perm |= KEY_USR_VIEW;
-
 	ret = key_validate(rkey);
 	if (ret < 0)
 		goto put;
diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 1cc6b0c6cc42..284d7a025fbc 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -27,6 +27,14 @@
 #include <keys/user-type.h>
 #include "ar-internal.h"
 
+static struct key_acl rxrpc_null_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 1,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_READ),
+	}
+};
+
 static int rxrpc_vet_description_s(const char *);
 static int rxrpc_preparse(struct key_preparsed_payload *);
 static int rxrpc_preparse_s(struct key_preparsed_payload *);
@@ -914,7 +922,8 @@ int rxrpc_request_key(struct rxrpc_sock *rx, char __user *optval, int optlen)
 	if (IS_ERR(description))
 		return PTR_ERR(description);
 
-	key = request_key_net(&key_type_rxrpc, description, sock_net(&rx->sk), NULL);
+	key = request_key_net(&key_type_rxrpc, description, sock_net(&rx->sk),
+			      NULL, NULL);
 	if (IS_ERR(key)) {
 		kfree(description);
 		_leave(" = %ld", PTR_ERR(key));
@@ -945,7 +954,8 @@ int rxrpc_server_keyring(struct rxrpc_sock *rx, char __user *optval,
 	if (IS_ERR(description))
 		return PTR_ERR(description);
 
-	key = request_key_net(&key_type_keyring, description, sock_net(&rx->sk), NULL);
+	key = request_key_net(&key_type_keyring, description, sock_net(&rx->sk),
+			      NULL, NULL);
 	if (IS_ERR(key)) {
 		kfree(description);
 		_leave(" = %ld", PTR_ERR(key));
@@ -1026,7 +1036,7 @@ struct key *rxrpc_get_null_key(const char *keyname)
 
 	key = key_alloc(&key_type_rxrpc, keyname,
 			GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, cred,
-			KEY_POS_SEARCH, KEY_ALLOC_NOT_IN_QUOTA, NULL);
+			&rxrpc_null_key_acl, KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(key))
 		return key;
 
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e19c2eb72c51..c231e66734f9 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -51,7 +51,8 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 
 	if (!keyring[id]) {
 		keyring[id] =
-			request_key(&key_type_keyring, keyring_name[id], NULL);
+			request_key(&key_type_keyring, keyring_name[id],
+				    NULL, NULL);
 		if (IS_ERR(keyring[id])) {
 			int err = PTR_ERR(keyring[id]);
 			pr_err("no %s keyring: %d\n", keyring_name[id], err);
@@ -73,14 +74,14 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 	return -EOPNOTSUPP;
 }
 
-static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
+static int __integrity_init_keyring(const unsigned int id, struct key_acl *acl,
 				    struct key_restriction *restriction)
 {
 	const struct cred *cred = current_cred();
 	int err = 0;
 
 	keyring[id] = keyring_alloc(keyring_name[id], KUIDT_INIT(0),
-				    KGIDT_INIT(0), cred, perm,
+				    KGIDT_INIT(0), cred, acl,
 				    KEY_ALLOC_NOT_IN_QUOTA, restriction, NULL);
 	if (IS_ERR(keyring[id])) {
 		err = PTR_ERR(keyring[id]);
@@ -98,10 +99,7 @@ static int __integrity_init_keyring(const unsigned int id, key_perm_t perm,
 int __init integrity_init_keyring(const unsigned int id)
 {
 	struct key_restriction *restriction;
-	key_perm_t perm;
-
-	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW
-		| KEY_USR_READ | KEY_USR_SEARCH;
+	struct key_acl *acl = &internal_keyring_acl;
 
 	if (id == INTEGRITY_KEYRING_PLATFORM) {
 		restriction = NULL;
@@ -116,14 +114,14 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
-	perm |= KEY_USR_WRITE;
+	acl = &internal_writable_keyring_acl;
 
 out:
-	return __integrity_init_keyring(id, perm, restriction);
+	return __integrity_init_keyring(id, &internal_keyring_acl, restriction);
 }
 
-int __init integrity_add_key(const unsigned int id, const void *data,
-			     off_t size, key_perm_t perm)
+static int __init integrity_add_key(const unsigned int id, const void *data,
+				    off_t size, struct key_acl *acl)
 {
 	key_ref_t key;
 	int rc = 0;
@@ -132,7 +130,7 @@ int __init integrity_add_key(const unsigned int id, const void *data,
 		return -EINVAL;
 
 	key = key_create_or_update(make_key_ref(keyring[id], 1), "asymmetric",
-				   NULL, data, size, perm,
+				   NULL, data, size, acl ?: &internal_key_acl,
 				   KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
@@ -152,7 +150,6 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	void *data;
 	loff_t size;
 	int rc;
-	key_perm_t perm;
 
 	rc = kernel_read_file_from_path(path, &data, &size, 0,
 					READING_X509_CERTIFICATE);
@@ -161,21 +158,19 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 		return rc;
 	}
 
-	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
-
 	pr_info("Loading X.509 certificate: %s\n", path);
-	rc = integrity_add_key(id, (const void *)data, size, perm);
+	rc = integrity_add_key(id, data, size, NULL);
 
 	vfree(data);
 	return rc;
 }
 
 int __init integrity_load_cert(const unsigned int id, const char *source,
-			       const void *data, size_t len, key_perm_t perm)
+			       const void *data, size_t len, struct key_acl *acl)
 {
 	if (!data)
 		return -EINVAL;
 
 	pr_info("Loading X.509 certificate: %s\n", source);
-	return integrity_add_key(id, data, len, perm);
+	return integrity_add_key(id, data, len, acl);
 }
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 358f614811e8..a8bd8b2f4fce 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -57,7 +57,7 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 		else
 			key = key_ref_to_ptr(kref);
 	} else {
-		key = request_key(&key_type_asymmetric, name, NULL);
+		key = request_key(&key_type_asymmetric, name, NULL, NULL);
 	}
 
 	if (IS_ERR(key)) {
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index e11564eb645b..304cb0b21f7a 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -356,7 +356,7 @@ int evm_init_key(void)
 	struct encrypted_key_payload *ekp;
 	int rc;
 
-	evm_key = request_key(&key_type_encrypted, EVMKEY, NULL);
+	evm_key = request_key(&key_type_encrypted, EVMKEY, NULL, NULL);
 	if (IS_ERR(evm_key))
 		return -ENOENT;
 
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
index 073ddc9bce5b..ce48303cfacc 100644
--- a/security/integrity/ima/ima_mok.c
+++ b/security/integrity/ima/ima_mok.c
@@ -21,6 +21,15 @@
 #include <keys/system_keyring.h>
 
 
+static struct key_acl integrity_blacklist_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE | KEY_ACE_SEARCH),
+	}
+};
+
 struct key *ima_blacklist_keyring;
 
 /*
@@ -40,9 +49,7 @@ __init int ima_mok_init(void)
 
 	ima_blacklist_keyring = keyring_alloc(".ima_blacklist",
 				KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ |
-				KEY_USR_WRITE | KEY_USR_SEARCH,
+			        &integrity_blacklist_keyring_acl,
 				KEY_ALLOC_NOT_IN_QUOTA,
 				restriction, NULL);
 
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7de59f44cba3..fbc1264af55f 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -154,7 +154,7 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
-			       const void *data, size_t len, key_perm_t perm);
+			       const void *data, size_t len, struct key_acl *acl);
 #else
 
 static inline int integrity_digsig_verify(const unsigned int id,
@@ -172,7 +172,7 @@ static inline int integrity_init_keyring(const unsigned int id)
 static inline int __init integrity_load_cert(const unsigned int id,
 					     const char *source,
 					     const void *data, size_t len,
-					     key_perm_t perm)
+					     struct key_acl *acl)
 {
 	return 0;
 }
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index bcafd7387729..80bb6f750045 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -14,6 +14,15 @@
 #include <linux/slab.h>
 #include "../integrity.h"
 
+static struct key_acl platform_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_READ),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
 /**
  * add_to_platform_keyring - Add to platform keyring without validation.
  * @source: Source of key
@@ -29,10 +38,8 @@ void __init add_to_platform_keyring(const char *source, const void *data,
 	key_perm_t perm;
 	int rc;
 
-	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
-
 	rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source, data, len,
-				 perm);
+				 &platform_key_acl);
 	if (rc)
 		pr_info("Error adding keys to platform keyring %s\n", source);
 }
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 1b1456b21a93..dc76c60a27a6 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -307,7 +307,7 @@ static struct key *request_user_key(const char *master_desc, const u8 **master_k
 	const struct user_key_payload *upayload;
 	struct key *ukey;
 
-	ukey = request_key(&key_type_user, master_desc, NULL);
+	ukey = request_key(&key_type_user, master_desc, NULL, NULL);
 	if (IS_ERR(ukey))
 		goto error;
 
diff --git a/security/keys/encrypted-keys/masterkey_trusted.c b/security/keys/encrypted-keys/masterkey_trusted.c
index dc3d18cae642..3322e7eeafce 100644
--- a/security/keys/encrypted-keys/masterkey_trusted.c
+++ b/security/keys/encrypted-keys/masterkey_trusted.c
@@ -33,7 +33,7 @@ struct key *request_trusted_key(const char *trusted_desc,
 	struct trusted_key_payload *tpayload;
 	struct key *tkey;
 
-	tkey = request_key(&key_type_trusted, trusted_desc, NULL);
+	tkey = request_key(&key_type_trusted, trusted_desc, NULL, NULL);
 	if (IS_ERR(tkey))
 		goto error;
 
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 83d279fb7793..3b13fb62827f 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -155,6 +155,7 @@ static noinline void key_gc_unused_keys(struct list_head *keys)
 
 		key_user_put(key->user);
 		key_put_tag(key->domain_tag);
+		key_put_acl(rcu_access_pointer(key->acl));
 		kfree(key->description);
 
 		memzero_explicit(key, sizeof(*key));
@@ -224,7 +225,6 @@ static void key_garbage_collector(struct work_struct *work)
 			if (key->type == key_gc_dead_keytype) {
 				gc_state |= KEY_GC_FOUND_DEAD_KEY;
 				set_bit(KEY_FLAG_DEAD, &key->flags);
-				key->perm = 0;
 				goto skip_dead_key;
 			} else if (key->type == &key_type_keyring &&
 				   key->restrict_link) {
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 022584281865..36cac9f7dbc1 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -88,8 +88,11 @@ extern struct rb_root key_serial_tree;
 extern spinlock_t key_serial_lock;
 extern struct mutex key_construction_mutex;
 extern wait_queue_head_t request_key_conswq;
+extern struct key_acl default_key_acl;
+extern struct key_acl joinable_keyring_acl;
 
 extern void key_set_index_key(struct keyring_index_key *index_key);
+
 extern struct key_type *key_type_lookup(const char *type);
 extern void key_type_put(struct key_type *ktype);
 
@@ -156,6 +159,7 @@ extern struct key *request_key_and_link(struct key_type *type,
 					const void *callout_info,
 					size_t callout_len,
 					void *aux,
+					struct key_acl *acl,
 					struct key *dest_keyring,
 					unsigned long flags);
 
@@ -179,7 +183,10 @@ extern void key_gc_keytype(struct key_type *ktype);
 
 extern int key_task_permission(const key_ref_t key_ref,
 			       const struct cred *cred,
-			       key_perm_t perm);
+			       u32 desired_perm);
+extern unsigned int key_acl_to_perm(const struct key_acl *acl);
+extern long key_set_acl(struct key *key, struct key_acl *acl);
+extern void key_put_acl(struct key_acl *acl);
 
 /*
  * Check to see whether permission is granted to use a key in the desired way.
@@ -226,7 +233,7 @@ extern long keyctl_keyring_search(key_serial_t, const char __user *,
 				  const char __user *, key_serial_t);
 extern long keyctl_read_key(key_serial_t, char __user *, size_t);
 extern long keyctl_chown_key(key_serial_t, uid_t, gid_t);
-extern long keyctl_setperm_key(key_serial_t, key_perm_t);
+extern long keyctl_setperm_key(key_serial_t, unsigned int);
 extern long keyctl_instantiate_key(key_serial_t, const void __user *,
 				   size_t, key_serial_t);
 extern long keyctl_negate_key(key_serial_t, unsigned, key_serial_t);
diff --git a/security/keys/key.c b/security/keys/key.c
index 43bb06f39611..d6c31af6f583 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -199,7 +199,7 @@ static inline void key_alloc_serial(struct key *key)
  * @uid: The owner of the new key.
  * @gid: The group ID for the new key's group permissions.
  * @cred: The credentials specifying UID namespace.
- * @perm: The permissions mask of the new key.
+ * @acl: The ACL to attach to the new key.
  * @flags: Flags specifying quota properties.
  * @restrict_link: Optional link restriction for new keyrings.
  *
@@ -227,7 +227,7 @@ static inline void key_alloc_serial(struct key *key)
  */
 struct key *key_alloc(struct key_type *type, const char *desc,
 		      kuid_t uid, kgid_t gid, const struct cred *cred,
-		      key_perm_t perm, unsigned long flags,
+		      struct key_acl *acl, unsigned long flags,
 		      struct key_restriction *restrict_link)
 {
 	struct key_user *user = NULL;
@@ -250,6 +250,9 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	desclen = strlen(desc);
 	quotalen = desclen + 1 + type->def_datalen;
 
+	if (!acl)
+		acl = &default_key_acl;
+
 	/* get hold of the key tracking for this user */
 	user = key_user_lookup(uid);
 	if (!user)
@@ -296,7 +299,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->datalen = type->def_datalen;
 	key->uid = uid;
 	key->gid = gid;
-	key->perm = perm;
+	refcount_inc(&acl->usage);
+	rcu_assign_pointer(key->acl, acl);
 	key->restrict_link = restrict_link;
 	key->last_used_at = ktime_get_real_seconds();
 
@@ -782,7 +786,7 @@ static inline key_ref_t __key_update(key_ref_t key_ref,
  * @description: The searchable description for the key.
  * @payload: The data to use to instantiate or update the key.
  * @plen: The length of @payload.
- * @perm: The permissions mask for a new key.
+ * @acl: The ACL to attach if a key is created.
  * @flags: The quota flags for a new key.
  *
  * Search the destination keyring for a key of the same description and if one
@@ -805,7 +809,7 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			       const char *description,
 			       const void *payload,
 			       size_t plen,
-			       key_perm_t perm,
+			       struct key_acl *acl,
 			       unsigned long flags)
 {
 	struct keyring_index_key index_key = {
@@ -896,22 +900,9 @@ key_ref_t key_create_or_update(key_ref_t keyring_ref,
 			goto found_matching_key;
 	}
 
-	/* if the client doesn't provide, decide on the permissions we want */
-	if (perm == KEY_PERM_UNDEF) {
-		perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
-		perm |= KEY_USR_VIEW;
-
-		if (index_key.type->read)
-			perm |= KEY_POS_READ;
-
-		if (index_key.type == &key_type_keyring ||
-		    index_key.type->update)
-			perm |= KEY_POS_WRITE;
-	}
-
 	/* allocate a new key */
 	key = key_alloc(index_key.type, index_key.description,
-			cred->fsuid, cred->fsgid, cred, perm, flags, NULL);
+			cred->fsuid, cred->fsgid, cred, acl, flags, NULL);
 	if (IS_ERR(key)) {
 		key_ref = ERR_CAST(key);
 		goto error_link_end;
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 4a0a54ac2e49..51fae94ae2e0 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -120,8 +120,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 	/* create or update the requested key and add it to the target
 	 * keyring */
 	key_ref = key_create_or_update(keyring_ref, type, description,
-				       payload, plen, KEY_PERM_UNDEF,
-				       KEY_ALLOC_IN_QUOTA);
+				       payload, plen, NULL, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key_ref)) {
 		ret = key_ref_to_ptr(key_ref)->serial;
 		key_ref_put(key_ref);
@@ -211,7 +210,8 @@ SYSCALL_DEFINE4(request_key, const char __user *, _type,
 
 	/* do the search */
 	key = request_key_and_link(ktype, description, NULL, callout_info,
-				   callout_len, NULL, key_ref_to_ptr(dest_ref),
+				   callout_len, NULL, NULL,
+				   key_ref_to_ptr(dest_ref),
 				   KEY_ALLOC_IN_QUOTA);
 	if (IS_ERR(key)) {
 		ret = PTR_ERR(key);
@@ -373,16 +373,10 @@ long keyctl_revoke_key(key_serial_t id)
 	struct key *key;
 	long ret;
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_WRITE);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_REVOKE);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
-		if (ret != -EACCES)
-			goto error;
-		key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
-		if (IS_ERR(key_ref)) {
-			ret = PTR_ERR(key_ref);
-			goto error;
-		}
+		goto error;
 	}
 
 	key = key_ref_to_ptr(key_ref);
@@ -416,7 +410,7 @@ long keyctl_invalidate_key(key_serial_t id)
 
 	kenter("%d", id);
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SEARCH);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_INVAL);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 
@@ -461,7 +455,7 @@ long keyctl_keyring_clear(key_serial_t ringid)
 	struct key *keyring;
 	long ret;
 
-	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_WRITE);
+	keyring_ref = lookup_user_key(ringid, KEY_LOOKUP_CREATE, KEY_NEED_CLEAR);
 	if (IS_ERR(keyring_ref)) {
 		ret = PTR_ERR(keyring_ref);
 
@@ -639,6 +633,7 @@ long keyctl_describe_key(key_serial_t keyid,
 			 size_t buflen)
 {
 	struct key *key, *instkey;
+	unsigned int perm;
 	key_ref_t key_ref;
 	char *infobuf;
 	long ret;
@@ -668,6 +663,10 @@ long keyctl_describe_key(key_serial_t keyid,
 	key = key_ref_to_ptr(key_ref);
 	desclen = strlen(key->description);
 
+	rcu_read_lock();
+	perm = key_acl_to_perm(rcu_dereference(key->acl));
+	rcu_read_unlock();
+
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
 	infobuf = kasprintf(GFP_KERNEL,
@@ -675,7 +674,7 @@ long keyctl_describe_key(key_serial_t keyid,
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
-			    key->perm);
+			    perm);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
@@ -892,7 +891,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 		goto error;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -987,18 +986,25 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
  * the key need not be fully instantiated yet.  If the caller does not have
  * sysadmin capability, it may only change the permission on keys that it owns.
  */
-long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
+long keyctl_setperm_key(key_serial_t id, unsigned int perm)
 {
+	struct key_acl *acl;
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
+	int nr, i, j;
 
-	ret = -EINVAL;
 	if (perm & ~(KEY_POS_ALL | KEY_USR_ALL | KEY_GRP_ALL | KEY_OTH_ALL))
-		goto error;
+		return -EINVAL;
+
+	nr = 0;
+	if (perm & KEY_POS_ALL) nr++;
+	if (perm & KEY_USR_ALL) nr++;
+	if (perm & KEY_GRP_ALL) nr++;
+	if (perm & KEY_OTH_ALL) nr++;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref)) {
 		ret = PTR_ERR(key_ref);
 		goto error;
@@ -1006,17 +1012,45 @@ long keyctl_setperm_key(key_serial_t id, key_perm_t perm)
 
 	key = key_ref_to_ptr(key_ref);
 
-	/* make the changes with the locks held to prevent chown/chmod races */
-	ret = -EACCES;
-	down_write(&key->sem);
+	ret = -EOPNOTSUPP;
+	if (test_bit(KEY_FLAG_HAS_ACL, &key->flags))
+		goto error_key;
 
-	/* if we're not the sysadmin, we can only change a key that we own */
-	if (capable(CAP_SYS_ADMIN) || uid_eq(key->uid, current_fsuid())) {
-		key->perm = perm;
-		ret = 0;
+	ret = -ENOMEM;
+	acl = kzalloc(struct_size(acl, aces, nr), GFP_KERNEL);
+	if (!acl)
+		goto error_key;
+
+	refcount_set(&acl->usage, 1);
+	acl->nr_ace = nr;
+	j = 0;
+	for (i = 0; i < 4; i++) {
+		struct key_ace *ace = &acl->aces[j];
+		unsigned int subset = (perm >> (i * 8)) & KEY_OTH_ALL;
+
+		if (!subset)
+			continue;
+		ace->type = KEY_ACE_SUBJ_STANDARD;
+		ace->subject_id = KEY_ACE_EVERYONE + i;
+		ace->perm = subset;
+		if (subset & (KEY_OTH_WRITE | KEY_OTH_SETATTR))
+			ace->perm |= KEY_ACE_REVOKE;
+		if (subset & KEY_OTH_SEARCH)
+			ace->perm |= KEY_ACE_INVAL;
+		if (key->type == &key_type_keyring) {
+			if (subset & KEY_OTH_SEARCH)
+				ace->perm |= KEY_ACE_JOIN;
+			if (subset & KEY_OTH_WRITE)
+				ace->perm |= KEY_ACE_CLEAR;
+		}
+		j++;
 	}
 
+	/* make the changes with the locks held to prevent chown/chmod races */
+	down_write(&key->sem);
+	ret = key_set_acl(key, acl);
 	up_write(&key->sem);
+error_key:
 	key_put(key);
 error:
 	return ret;
@@ -1381,7 +1415,7 @@ long keyctl_set_timeout(key_serial_t id, unsigned timeout)
 	long ret;
 
 	key_ref = lookup_user_key(id, KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL,
-				  KEY_NEED_SETATTR);
+				  KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref)) {
 		/* setting the timeout on a key under construction is permitted
 		 * if we have the authorisation token handy */
@@ -1651,7 +1685,7 @@ long keyctl_restrict_keyring(key_serial_t id, const char __user *_type,
 	char *restriction = NULL;
 	long ret;
 
-	key_ref = lookup_user_key(id, 0, KEY_NEED_SETATTR);
+	key_ref = lookup_user_key(id, 0, KEY_NEED_SETSEC);
 	if (IS_ERR(key_ref))
 		return PTR_ERR(key_ref);
 
@@ -1737,7 +1771,7 @@ SYSCALL_DEFINE5(keyctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 	case KEYCTL_SETPERM:
 		return keyctl_setperm_key((key_serial_t) arg2,
-					  (key_perm_t) arg3);
+					  (unsigned int)arg3);
 
 	case KEYCTL_INSTANTIATE:
 		return keyctl_instantiate_key((key_serial_t) arg2,
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index f412a336f6f9..ca8f64909b93 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -519,11 +519,19 @@ static long keyring_read(const struct key *keyring,
 	return ret;
 }
 
-/*
- * Allocate a keyring and link into the destination keyring.
+/**
+ * keyring_alloc - Allocate a keyring and link into the destination
+ * @description: The key description to allow the key to be searched out.
+ * @uid: The owner of the new key.
+ * @gid: The group ID for the new key's group permissions.
+ * @cred: The credentials specifying UID namespace.
+ * @acl: The ACL to attach to the new key.
+ * @flags: Flags specifying quota properties.
+ * @restrict_link: Optional link restriction for new keyrings.
+ * @dest: Destination keyring.
  */
 struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
-			  const struct cred *cred, key_perm_t perm,
+			  const struct cred *cred, struct key_acl *acl,
 			  unsigned long flags,
 			  struct key_restriction *restrict_link,
 			  struct key *dest)
@@ -532,7 +540,7 @@ struct key *keyring_alloc(const char *description, kuid_t uid, kgid_t gid,
 	int ret;
 
 	keyring = key_alloc(&key_type_keyring, description,
-			    uid, gid, cred, perm, flags, restrict_link);
+			    uid, gid, cred, acl, flags, restrict_link);
 	if (!IS_ERR(keyring)) {
 		ret = key_instantiate_and_link(keyring, NULL, 0, dest, NULL);
 		if (ret < 0) {
@@ -1136,10 +1144,11 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
 /*
  * Find a keyring with the specified name.
  *
- * Only keyrings that have nonzero refcount, are not revoked, and are owned by a
- * user in the current user namespace are considered.  If @uid_keyring is %true,
- * the keyring additionally must have been allocated as a user or user session
- * keyring; otherwise, it must grant Search permission directly to the caller.
+ * Only keyrings that have nonzero refcount, are not revoked, and are owned by
+ * a user in the current user namespace are considered.  If @uid_keyring is
+ * %true, the keyring additionally must have been allocated as a user or user
+ * session keyring; otherwise, it must grant JOIN permission directly to the
+ * caller (ie. not through possession).
  *
  * Returns a pointer to the keyring with the keyring's refcount having being
  * incremented on success.  -ENOKEY is returned if a key could not be found.
@@ -1173,7 +1182,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 				continue;
 		} else {
 			if (key_permission(make_key_ref(keyring, 0),
-					   KEY_NEED_SEARCH) < 0)
+					   KEY_NEED_JOIN) < 0)
 				continue;
 		}
 
diff --git a/security/keys/permission.c b/security/keys/permission.c
index 06df9d5e7572..1f6a736d5acd 100644
--- a/security/keys/permission.c
+++ b/security/keys/permission.c
@@ -11,13 +11,62 @@
 
 #include <linux/export.h>
 #include <linux/security.h>
+#include <linux/user_namespace.h>
+#include <linux/uaccess.h>
 #include "internal.h"
 
+struct key_acl default_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~KEY_ACE_JOIN),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
+struct key_acl joinable_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces	= {
+		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~KEY_ACE_JOIN),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_LINK | KEY_ACE_JOIN),
+	}
+};
+
+struct key_acl internal_key_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH),
+	}
+};
+
+struct key_acl internal_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH),
+	}
+};
+
+struct key_acl internal_writable_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE | KEY_ACE_SEARCH),
+	}
+};
+
 /**
  * key_task_permission - Check a key can be used
  * @key_ref: The key to check.
  * @cred: The credentials to use.
- * @perm: The permissions to check for.
+ * @desired_perm: The permission to check for.
  *
  * Check to see whether permission is granted to use a key in the desired way,
  * but permit the security modules to override.
@@ -28,53 +77,73 @@
  * permissions bits or the LSM check.
  */
 int key_task_permission(const key_ref_t key_ref, const struct cred *cred,
-			unsigned perm)
+			unsigned int desired_perm)
 {
-	struct key *key;
-	key_perm_t kperm;
-	int ret;
+	const struct key_acl *acl;
+	const struct key *key;
+	unsigned int allow = 0;
+	int i;
+
+	BUILD_BUG_ON(KEY_NEED_VIEW	!= KEY_ACE_VIEW		||
+		     KEY_NEED_READ	!= KEY_ACE_READ		||
+		     KEY_NEED_WRITE	!= KEY_ACE_WRITE	||
+		     KEY_NEED_SEARCH	!= KEY_ACE_SEARCH	||
+		     KEY_NEED_LINK	!= KEY_ACE_LINK		||
+		     KEY_NEED_SETSEC	!= KEY_ACE_SET_SECURITY	||
+		     KEY_NEED_INVAL	!= KEY_ACE_INVAL	||
+		     KEY_NEED_REVOKE	!= KEY_ACE_REVOKE	||
+		     KEY_NEED_JOIN	!= KEY_ACE_JOIN		||
+		     KEY_NEED_CLEAR	!= KEY_ACE_CLEAR);
 
 	key = key_ref_to_ptr(key_ref);
 
-	/* use the second 8-bits of permissions for keys the caller owns */
-	if (uid_eq(key->uid, cred->fsuid)) {
-		kperm = key->perm >> 16;
-		goto use_these_perms;
-	}
+	rcu_read_lock();
 
-	/* use the third 8-bits of permissions for keys the caller has a group
-	 * membership in common with */
-	if (gid_valid(key->gid) && key->perm & KEY_GRP_ALL) {
-		if (gid_eq(key->gid, cred->fsgid)) {
-			kperm = key->perm >> 8;
-			goto use_these_perms;
-		}
+	acl = rcu_dereference(key->acl);
+	if (!acl || acl->nr_ace == 0)
+		goto no_access_rcu;
+
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
 
-		ret = groups_search(cred->group_info, key->gid);
-		if (ret) {
-			kperm = key->perm >> 8;
-			goto use_these_perms;
+		switch (ace->type) {
+		case KEY_ACE_SUBJ_STANDARD:
+			switch (ace->subject_id) {
+			case KEY_ACE_POSSESSOR:
+				if (is_key_possessed(key_ref))
+					allow |= ace->perm;
+				break;
+			case KEY_ACE_OWNER:
+				if (uid_eq(key->uid, cred->fsuid))
+					allow |= ace->perm;
+				break;
+			case KEY_ACE_GROUP:
+				if (gid_valid(key->gid)) {
+					if (gid_eq(key->gid, cred->fsgid))
+						allow |= ace->perm;
+					else if (groups_search(cred->group_info, key->gid))
+						allow |= ace->perm;
+				}
+				break;
+			case KEY_ACE_EVERYONE:
+				allow |= ace->perm;
+				break;
+			}
+			break;
 		}
 	}
 
-	/* otherwise use the least-significant 8-bits */
-	kperm = key->perm;
-
-use_these_perms:
+	rcu_read_unlock();
 
-	/* use the top 8-bits of permissions for keys the caller possesses
-	 * - possessor permissions are additive with other permissions
-	 */
-	if (is_key_possessed(key_ref))
-		kperm |= key->perm >> 24;
+	if (!(allow & desired_perm))
+		goto no_access;
 
-	kperm = kperm & perm & KEY_NEED_ALL;
+	return security_key_permission(key_ref, cred, desired_perm);
 
-	if (kperm != perm)
-		return -EACCES;
-
-	/* let LSM be the final arbiter */
-	return security_key_permission(key_ref, cred, perm);
+no_access_rcu:
+	rcu_read_unlock();
+no_access:
+	return -EACCES;
 }
 EXPORT_SYMBOL(key_task_permission);
 
@@ -108,3 +177,99 @@ int key_validate(const struct key *key)
 	return 0;
 }
 EXPORT_SYMBOL(key_validate);
+
+/*
+ * Roughly render an ACL to an old-style permissions mask.  We cannot
+ * accurately render what the ACL, particularly if it has ACEs that represent
+ * subjects outside of { poss, user, group, other }.
+ */
+unsigned int key_acl_to_perm(const struct key_acl *acl)
+{
+	unsigned int perm = 0, tperm;
+	int i;
+
+	BUILD_BUG_ON(KEY_OTH_VIEW	!= KEY_ACE_VIEW		||
+		     KEY_OTH_READ	!= KEY_ACE_READ		||
+		     KEY_OTH_WRITE	!= KEY_ACE_WRITE	||
+		     KEY_OTH_SEARCH	!= KEY_ACE_SEARCH	||
+		     KEY_OTH_LINK	!= KEY_ACE_LINK		||
+		     KEY_OTH_SETATTR	!= KEY_ACE_SET_SECURITY);
+
+	if (!acl || acl->nr_ace == 0)
+		return 0;
+
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
+
+		switch (ace->type) {
+		case KEY_ACE_SUBJ_STANDARD:
+			tperm = ace->perm & KEY_OTH_ALL;
+
+			/* Invalidation and joining were allowed by SEARCH */
+			if (ace->perm & (KEY_ACE_INVAL | KEY_ACE_JOIN))
+				tperm |= KEY_OTH_SEARCH;
+
+			/* Revocation was allowed by either SETATTR or WRITE */
+			if ((ace->perm & KEY_ACE_REVOKE) && !(tperm & KEY_OTH_SETATTR))
+				tperm |= KEY_OTH_WRITE;
+
+			/* Clearing was allowed by WRITE */
+			if (ace->perm & KEY_ACE_CLEAR)
+				tperm |= KEY_OTH_WRITE;
+
+			switch (ace->subject_id) {
+			case KEY_ACE_POSSESSOR:
+				perm |= tperm << 24;
+				break;
+			case KEY_ACE_OWNER:
+				perm |= tperm << 16;
+				break;
+			case KEY_ACE_GROUP:
+				perm |= tperm << 8;
+				break;
+			case KEY_ACE_EVERYONE:
+				perm |= tperm << 0;
+				break;
+			}
+		}
+	}
+
+	return perm;
+}
+
+/*
+ * Destroy a key's ACL.
+ */
+void key_put_acl(struct key_acl *acl)
+{
+	if (acl && refcount_dec_and_test(&acl->usage))
+		kfree_rcu(acl, rcu);
+}
+
+/*
+ * Try to set the ACL.  This either attaches or discards the proposed ACL.
+ */
+long key_set_acl(struct key *key, struct key_acl *acl)
+{
+	int i;
+
+	/* If we're not the sysadmin, we can only change a key that we own. */
+	if (!capable(CAP_SYS_ADMIN) && !uid_eq(key->uid, current_fsuid())) {
+		key_put_acl(acl);
+		return -EACCES;
+	}
+
+	for (i = 0; i < acl->nr_ace; i++) {
+		const struct key_ace *ace = &acl->aces[i];
+		if (ace->type == KEY_ACE_SUBJ_STANDARD &&
+		    ace->subject_id == KEY_ACE_POSSESSOR) {
+			if (ace->perm & KEY_ACE_VIEW)
+				acl->possessor_viewable = true;
+			break;
+		}
+	}
+
+	rcu_swap_protected(key->acl, acl, lockdep_is_held(&key->sem));
+	key_put_acl(acl);
+	return 0;
+}
diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 9944d855a28d..c4c480f630ea 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -16,6 +16,27 @@
 
 unsigned persistent_keyring_expiry = 3 * 24 * 3600; /* Expire after 3 days of non-use */
 
+static struct key_acl persistent_register_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_SEARCH | KEY_ACE_WRITE),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+	}
+};
+
+static struct key_acl persistent_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE |
+				  KEY_ACE_SEARCH | KEY_ACE_LINK |
+				  KEY_ACE_CLEAR | KEY_ACE_INVAL),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+	}
+};
+
 /*
  * Create the persistent keyring register for the current user namespace.
  *
@@ -26,8 +47,7 @@ static int key_create_persistent_register(struct user_namespace *ns)
 	struct key *reg = keyring_alloc(".persistent_register",
 					KUIDT_INIT(0), KGIDT_INIT(0),
 					current_cred(),
-					((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-					 KEY_USR_VIEW | KEY_USR_READ),
+					&persistent_register_keyring_acl,
 					KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
@@ -60,8 +80,7 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 
 	persistent = keyring_alloc(index_key->description,
 				   uid, INVALID_GID, current_cred(),
-				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				    KEY_USR_VIEW | KEY_USR_READ),
+				   &persistent_keyring_acl,
 				   KEY_ALLOC_NOT_IN_QUOTA, NULL,
 				   ns->persistent_keyring_register);
 	if (IS_ERR(persistent))
diff --git a/security/keys/proc.c b/security/keys/proc.c
index b4f5ba56b9cb..7a901b723abb 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -119,6 +119,7 @@ static void *proc_keys_start(struct seq_file *p, loff_t *_pos)
 	key_serial_t pos = *_pos;
 	struct key *key;
 
+	rcu_read_lock();
 	spin_lock(&key_serial_lock);
 
 	if (*_pos > INT_MAX)
@@ -150,10 +151,12 @@ static void proc_keys_stop(struct seq_file *p, void *v)
 	__releases(key_serial_lock)
 {
 	spin_unlock(&key_serial_lock);
+	rcu_read_unlock();
 }
 
 static int proc_keys_show(struct seq_file *m, void *v)
 {
+	const struct key_acl *acl;
 	struct rb_node *_p = v;
 	struct key *key = rb_entry(_p, struct key, serial_node);
 	unsigned long flags;
@@ -161,6 +164,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	time64_t now, expiry;
 	char xbuf[16];
 	short state;
+	bool check_pos;
 	u64 timo;
 	int rc;
 
@@ -174,15 +178,15 @@ static int proc_keys_show(struct seq_file *m, void *v)
 					   KEYRING_SEARCH_RECURSE),
 	};
 
-	key_ref = make_key_ref(key, 0);
+	acl = rcu_dereference(key->acl);
+	check_pos = acl->possessor_viewable;
 
 	/* determine if the key is possessed by this process (a test we can
 	 * skip if the key does not indicate the possessor can view it
 	 */
-	if (key->perm & KEY_POS_VIEW) {
-		rcu_read_lock();
+	key_ref = make_key_ref(key, 0);
+	if (check_pos) {
 		skey_ref = search_cred_keyrings_rcu(&ctx);
-		rcu_read_unlock();
 		if (!IS_ERR(skey_ref)) {
 			key_ref_put(skey_ref);
 			key_ref = make_key_ref(key, 1);
@@ -192,12 +196,10 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	/* check whether the current task is allowed to view the key */
 	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
 	if (rc < 0)
-		return 0;
+		goto out;
 
 	now = ktime_get_real_seconds();
 
-	rcu_read_lock();
-
 	/* come up with a suitable timeout value */
 	expiry = READ_ONCE(key->expiry);
 	if (expiry == 0) {
@@ -236,7 +238,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		   showflag(flags, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
-		   key->perm,
+		   key_acl_to_perm(acl),
 		   from_kuid_munged(seq_user_ns(m), key->uid),
 		   from_kgid_munged(seq_user_ns(m), key->gid),
 		   key->type->name);
@@ -247,7 +249,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		key->type->describe(key, m);
 	seq_putc(m, '\n');
 
-	rcu_read_unlock();
+out:
 	return 0;
 }
 
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index f8ead35a2ba5..fb187b2a1aac 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -36,6 +36,47 @@ struct key_user root_key_user = {
 	.uid		= GLOBAL_ROOT_UID,
 };
 
+static struct key_acl user_reg_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.possessor_viewable = true,
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_WRITE | KEY_ACE_SEARCH),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+	}
+};
+
+static struct key_acl user_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.possessor_viewable = true,
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_WRITE |
+				  KEY_ACE_SEARCH | KEY_ACE_LINK),
+		KEY_OWNER_ACE(KEY_ACE__PERMS & ~(KEY_ACE_JOIN | KEY_ACE_SET_SECURITY)),
+	}
+};
+
+static struct key_acl session_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.possessor_viewable = true,
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~KEY_ACE_JOIN),
+		KEY_OWNER_ACE(KEY_ACE_VIEW | KEY_ACE_READ),
+	}
+};
+
+static struct key_acl thread_and_process_keyring_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.possessor_viewable = true,
+	.nr_ace	= 2,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE__PERMS & ~(KEY_ACE_JOIN | KEY_ACE_SET_SECURITY)),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
 /*
  * Get or create a user register keyring.
  */
@@ -55,11 +96,8 @@ static struct key *get_user_register(struct user_namespace *user_ns)
 	if (!reg_keyring) {
 		reg_keyring = keyring_alloc(".user_reg",
 					    user_ns->owner, INVALID_GID,
-					    &init_cred,
-					    KEY_POS_WRITE | KEY_POS_SEARCH |
-					    KEY_USR_VIEW | KEY_USR_READ,
-					    0,
-					    NULL, NULL);
+					    &init_cred, &user_reg_keyring_acl,
+					    0, NULL, NULL);
 		if (!IS_ERR(reg_keyring))
 			smp_store_release(&user_ns->user_keyring_register,
 					  reg_keyring);
@@ -81,14 +119,11 @@ int look_up_user_keyrings(struct key **_user_keyring,
 	const struct cred *cred = current_cred();
 	struct user_namespace *user_ns = current_user_ns();
 	struct key *reg_keyring, *uid_keyring, *session_keyring;
-	key_perm_t user_keyring_perm;
 	key_ref_t uid_keyring_r, session_keyring_r;
 	uid_t uid = from_kuid(user_ns, cred->user->uid);
 	char buf[20];
 	int ret;
 
-	user_keyring_perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_ALL;
-
 	kenter("%u", uid);
 
 	reg_keyring = get_user_register(user_ns);
@@ -108,7 +143,7 @@ int look_up_user_keyrings(struct key **_user_keyring,
 	kdebug("_uid %p", uid_keyring_r);
 	if (uid_keyring_r == ERR_PTR(-EAGAIN)) {
 		uid_keyring = keyring_alloc(buf, cred->user->uid, INVALID_GID,
-					    cred, user_keyring_perm,
+					    cred, &user_keyring_acl,
 					    KEY_ALLOC_UID_KEYRING |
 					    KEY_ALLOC_IN_QUOTA,
 					    NULL, reg_keyring);
@@ -130,7 +165,7 @@ int look_up_user_keyrings(struct key **_user_keyring,
 	kdebug("_uid_ses %p", session_keyring_r);
 	if (session_keyring_r == ERR_PTR(-EAGAIN)) {
 		session_keyring = keyring_alloc(buf, cred->user->uid, INVALID_GID,
-						cred, user_keyring_perm,
+						cred, &user_keyring_acl,
 						KEY_ALLOC_UID_KEYRING |
 						KEY_ALLOC_IN_QUOTA,
 						NULL, NULL);
@@ -230,7 +265,7 @@ int install_thread_keyring_to_cred(struct cred *new)
 		return 0;
 
 	keyring = keyring_alloc("_tid", new->uid, new->gid, new,
-				KEY_POS_ALL | KEY_USR_VIEW,
+				&thread_and_process_keyring_acl,
 				KEY_ALLOC_QUOTA_OVERRUN,
 				NULL, NULL);
 	if (IS_ERR(keyring))
@@ -277,7 +312,7 @@ int install_process_keyring_to_cred(struct cred *new)
 		return 0;
 
 	keyring = keyring_alloc("_pid", new->uid, new->gid, new,
-				KEY_POS_ALL | KEY_USR_VIEW,
+				&thread_and_process_keyring_acl,
 				KEY_ALLOC_QUOTA_OVERRUN,
 				NULL, NULL);
 	if (IS_ERR(keyring))
@@ -332,8 +367,7 @@ int install_session_keyring_to_cred(struct cred *cred, struct key *keyring)
 			flags = KEY_ALLOC_IN_QUOTA;
 
 		keyring = keyring_alloc("_ses", cred->uid, cred->gid, cred,
-					KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ,
-					flags, NULL, NULL);
+					&session_keyring_acl, flags, NULL, NULL);
 		if (IS_ERR(keyring))
 			return PTR_ERR(keyring);
 	} else {
@@ -613,7 +647,7 @@ bool lookup_user_key_possessed(const struct key *key,
  * returned key reference.
  */
 key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
-			  key_perm_t perm)
+			  unsigned int desired_perm)
 {
 	struct keyring_search_context ctx = {
 		.match_data.cmp		= lookup_user_key_possessed,
@@ -790,12 +824,12 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		case -ERESTARTSYS:
 			goto invalid_key;
 		default:
-			if (perm)
+			if (desired_perm)
 				goto invalid_key;
 		case 0:
 			break;
 		}
-	} else if (perm) {
+	} else if (desired_perm) {
 		ret = key_validate(key);
 		if (ret < 0)
 			goto invalid_key;
@@ -807,9 +841,11 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		goto invalid_key;
 
 	/* check the permissions */
-	ret = key_task_permission(key_ref, ctx.cred, perm);
-	if (ret < 0)
-		goto invalid_key;
+	if (desired_perm) {
+		ret = key_task_permission(key_ref, ctx.cred, desired_perm);
+		if (ret < 0)
+			goto invalid_key;
+	}
 
 	key->last_used_at = ktime_get_real_seconds();
 
@@ -874,13 +910,13 @@ long join_session_keyring(const char *name)
 	if (PTR_ERR(keyring) == -ENOKEY) {
 		/* not found - try and create a new one */
 		keyring = keyring_alloc(
-			name, old->uid, old->gid, old,
-			KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ | KEY_USR_LINK,
+			name, old->uid, old->gid, old, &joinable_keyring_acl,
 			KEY_ALLOC_IN_QUOTA, NULL, NULL);
 		if (IS_ERR(keyring)) {
 			ret = PTR_ERR(keyring);
 			goto error2;
 		}
+		goto no_perm_test;
 	} else if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
 		goto error2;
@@ -889,6 +925,12 @@ long join_session_keyring(const char *name)
 		goto error3;
 	}
 
+	ret = key_task_permission(make_key_ref(keyring, false), old,
+				  KEY_NEED_JOIN);
+	if (ret < 0)
+		goto error3;
+
+no_perm_test:
 	/* we've got a keyring - now to install it */
 	ret = install_session_keyring_to_cred(new, keyring);
 	if (ret < 0)
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 8d564cca1700..0ce849f2dc23 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -139,8 +139,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 
 	cred = get_current_cred();
 	keyring = keyring_alloc(desc, cred->fsuid, cred->fsgid, cred,
-				KEY_POS_ALL | KEY_USR_VIEW | KEY_USR_READ,
-				KEY_ALLOC_QUOTA_OVERRUN, NULL, NULL);
+				NULL, KEY_ALLOC_QUOTA_OVERRUN, NULL, NULL);
 	put_cred(cred);
 	if (IS_ERR(keyring)) {
 		ret = PTR_ERR(keyring);
@@ -371,11 +370,11 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 			       struct key *dest_keyring,
 			       unsigned long flags,
 			       struct key_user *user,
+			       struct key_acl *acl,
 			       struct key **_key)
 {
 	struct assoc_array_edit *edit;
 	struct key *key;
-	key_perm_t perm;
 	key_ref_t key_ref;
 	int ret;
 
@@ -385,17 +384,9 @@ static int construct_alloc_key(struct keyring_search_context *ctx,
 	*_key = NULL;
 	mutex_lock(&user->cons_lock);
 
-	perm = KEY_POS_VIEW | KEY_POS_SEARCH | KEY_POS_LINK | KEY_POS_SETATTR;
-	perm |= KEY_USR_VIEW;
-	if (ctx->index_key.type->read)
-		perm |= KEY_POS_READ;
-	if (ctx->index_key.type == &key_type_keyring ||
-	    ctx->index_key.type->update)
-		perm |= KEY_POS_WRITE;
-
 	key = key_alloc(ctx->index_key.type, ctx->index_key.description,
 			ctx->cred->fsuid, ctx->cred->fsgid, ctx->cred,
-			perm, flags, NULL);
+			acl, flags, NULL);
 	if (IS_ERR(key))
 		goto alloc_failed;
 
@@ -473,6 +464,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 					  const char *callout_info,
 					  size_t callout_len,
 					  void *aux,
+					  struct key_acl *acl,
 					  struct key *dest_keyring,
 					  unsigned long flags)
 {
@@ -495,7 +487,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 		goto error_put_dest_keyring;
 	}
 
-	ret = construct_alloc_key(ctx, dest_keyring, flags, user, &key);
+	ret = construct_alloc_key(ctx, dest_keyring, flags, user, acl, &key);
 	key_user_put(user);
 
 	if (ret == 0) {
@@ -533,6 +525,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
  * @callout_len: The length of callout_info.
  * @aux: Auxiliary data for the upcall.
+ * @acl: The ACL to attach if a new key is created.
  * @dest_keyring: Where to cache the key.
  * @flags: Flags to key_alloc().
  *
@@ -560,6 +553,7 @@ struct key *request_key_and_link(struct key_type *type,
 				 const void *callout_info,
 				 size_t callout_len,
 				 void *aux,
+				 struct key_acl *acl,
 				 struct key *dest_keyring,
 				 unsigned long flags)
 {
@@ -634,7 +628,7 @@ struct key *request_key_and_link(struct key_type *type,
 			goto error_free;
 
 		key = construct_key_and_link(&ctx, callout_info, callout_len,
-					     aux, dest_keyring, flags);
+					     aux, acl, dest_keyring, flags);
 	}
 
 error_free:
@@ -677,6 +671,7 @@ EXPORT_SYMBOL(wait_for_key_construction);
  * @description: The searchable description of the key.
  * @domain_tag: The domain in which the key operates.
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
+ * @acl: The ACL to attach if a new key is created.
  *
  * As for request_key_and_link() except that it does not add the returned key
  * to a keyring if found, new keys are always allocated in the user's quota,
@@ -689,7 +684,8 @@ EXPORT_SYMBOL(wait_for_key_construction);
 struct key *request_key_tag(struct key_type *type,
 			    const char *description,
 			    struct key_tag *domain_tag,
-			    const char *callout_info)
+			    const char *callout_info,
+			    struct key_acl *acl)
 {
 	struct key *key;
 	size_t callout_len = 0;
@@ -699,7 +695,7 @@ struct key *request_key_tag(struct key_type *type,
 		callout_len = strlen(callout_info);
 	key = request_key_and_link(type, description, domain_tag,
 				   callout_info, callout_len,
-				   NULL, NULL, KEY_ALLOC_IN_QUOTA);
+				   NULL, acl, NULL, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key)) {
 		ret = wait_for_key_construction(key, false);
 		if (ret < 0) {
@@ -719,6 +715,7 @@ EXPORT_SYMBOL(request_key_tag);
  * @callout_info: The data to pass to the instantiation upcall (or NULL).
  * @callout_len: The length of callout_info.
  * @aux: Auxiliary data for the upcall.
+ * @acl: The ACL to attach if a new key is created.
  *
  * As for request_key_and_link() except that it does not add the returned key
  * to a keyring if found and new keys are always allocated in the user's quota.
@@ -731,14 +728,15 @@ struct key *request_key_with_auxdata(struct key_type *type,
 				     struct key_tag *domain_tag,
 				     const void *callout_info,
 				     size_t callout_len,
-				     void *aux)
+				     void *aux,
+				     struct key_acl *acl)
 {
 	struct key *key;
 	int ret;
 
 	key = request_key_and_link(type, description, domain_tag,
 				   callout_info, callout_len,
-				   aux, NULL, KEY_ALLOC_IN_QUOTA);
+				   aux, acl, NULL, KEY_ALLOC_IN_QUOTA);
 	if (!IS_ERR(key)) {
 		ret = wait_for_key_construction(key, false);
 		if (ret < 0) {
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index f613987e8a63..d9146606f54e 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -28,6 +28,17 @@ static void request_key_auth_revoke(struct key *);
 static void request_key_auth_destroy(struct key *);
 static long request_key_auth_read(const struct key *, char __user *, size_t);
 
+static struct key_acl request_key_auth_acl = {
+	.usage	= REFCOUNT_INIT(1),
+	.nr_ace	= 2,
+	.possessor_viewable = true,
+	.aces = {
+		KEY_POSSESSOR_ACE(KEY_ACE_VIEW | KEY_ACE_READ | KEY_ACE_SEARCH |
+				  KEY_ACE_LINK),
+		KEY_OWNER_ACE(KEY_ACE_VIEW),
+	}
+};
+
 /*
  * The request-key authorisation key type definition.
  */
@@ -214,8 +225,8 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 	authkey = key_alloc(&key_type_request_key_auth, desc,
 			    cred->fsuid, cred->fsgid, cred,
-			    KEY_POS_VIEW | KEY_POS_READ | KEY_POS_SEARCH | KEY_POS_LINK |
-			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA, NULL);
+			    &request_key_auth_acl,
+			    KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);
 		goto error_free_rka;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index c61787b15f27..b828401dcb70 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6481,6 +6481,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 {
 	struct key *key;
 	struct key_security_struct *ksec;
+	unsigned oldstyle_perm;
 	u32 sid;
 
 	/* if no specific permissions are requested, we skip the
@@ -6489,13 +6490,26 @@ static int selinux_key_permission(key_ref_t key_ref,
 	if (perm == 0)
 		return 0;
 
+	oldstyle_perm = perm & (KEY_NEED_VIEW | KEY_NEED_READ | KEY_NEED_WRITE |
+				KEY_NEED_SEARCH | KEY_NEED_LINK);
+	if (perm & KEY_NEED_SETSEC)
+		oldstyle_perm |= OLD_KEY_NEED_SETATTR;
+	if (perm & KEY_NEED_INVAL)
+		oldstyle_perm |= KEY_NEED_SEARCH;
+	if (perm & KEY_NEED_REVOKE && !(perm & OLD_KEY_NEED_SETATTR))
+		oldstyle_perm |= KEY_NEED_WRITE;
+	if (perm & KEY_NEED_JOIN)
+		oldstyle_perm |= KEY_NEED_SEARCH;
+	if (perm & KEY_NEED_CLEAR)
+		oldstyle_perm |= KEY_NEED_WRITE;
+
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
 	ksec = key->security;
 
 	return avc_has_perm(&selinux_state,
-			    sid, ksec->sid, SECCLASS_KEY, perm, NULL);
+			    sid, ksec->sid, SECCLASS_KEY, oldstyle_perm, NULL);
 }
 
 static int selinux_key_getsecurity(struct key *key, char **_buffer)
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0de725f88bed..6095dc3565a5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4285,7 +4285,8 @@ static int smack_key_permission(key_ref_t key_ref,
 #endif
 	if (perm & (KEY_NEED_READ | KEY_NEED_SEARCH | KEY_NEED_VIEW))
 		request |= MAY_READ;
-	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETATTR))
+	if (perm & (KEY_NEED_WRITE | KEY_NEED_LINK | KEY_NEED_SETSEC |
+		    KEY_NEED_INVAL | KEY_NEED_REVOKE | KEY_NEED_CLEAR))
 		request |= MAY_WRITE;
 	rc = smk_access(tkp, keyp->security, request, &ad);
 	rc = smk_bu_note("key access", tkp, keyp->security, request, rc);

