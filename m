Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6350D6C3DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 02:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfGRAqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 20:46:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:33050 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfGRAqY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:46:24 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8CCBF20B7185;
        Wed, 17 Jul 2019 17:46:22 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     gmazyland@gmail.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
        dm-devel@redhat.com, jmorris@namei.org, scottsh@microsoft.com,
        mdsakib@microsoft.com, mpatocka@redhat.com, ebiggers@google.com
Subject: [RFC PATCH v7 0/1] Add dm verity root hash pkcs7 sig validation. 
Date:   Wed, 17 Jul 2019 17:46:14 -0700
Message-Id: <20190718004615.16818-1-jaskarankhurana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set adds in-kernel pkcs7 signature checking for the roothash
of
the dm-verity hash tree.
The verification is to support cases where the roothash is not secured
by
Trusted Boot, UEFI Secureboot or similar technologies.
One of the use cases for this is for dm-verity volumes mounted after
boot,
the root hash provided during the creation of the dm-verity volume has
to
be secure and thus in-kernel validation implemented here will be used
before we trust the root hash and allow the block device to be created.

Why we are doing validation in the Kernel?
------------------------------------------
The reason is to still be secure in cases where the attacker is able to
compromise the user mode application in which case the user mode
validation
could not have been trusted.
The root hash signature validation in the kernel along with existing
dm-verity implementation gives a higher level of confidence in the
executable code or the protected data. Before allowing the creation of
the device mapper block device the kernel code will check that the
detached
pkcs7 signature passed to it validates the roothash and the signature is
trusted by builtin keys set at kernel creation. The kernel should be
secured using Verified boot, UEFI Secure Boot or similar technologies so
we
can trust it.

What about attacker mounting non dm-verity volumes to run executable code?
--------------------------------------------------------------------------
This verification can be used to have a security architecture where a
LSM
can enforce this verification for all the volumes and by doing this it
can
ensure that all executable code runs from signed and trusted dm-verity
volumes.

Further patches will be posted that build on this and enforce this
verification based on policy for all the volumes on the system.

Kernel commandline parameter require_signatures will indicate whether to
force (for all dm verity volumes) roothash signature verification.

How are these changes tested?
-----------------------------

Build time steps:
----------------

CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG needs to be turned on in .config.

Add the certificate(pubic key) that will be used to check whether to trust
the signature of the roothash in a PEM-encoded file to the 
CONFIG_SYSTEM_TRUSTED_KEYS (example step 1) and step 2) below).

When formatting the fs for verity we need to save and sign the roothash, the 
signature would be used in verification by the kernel later when we create dm
verity block device on the test machine/kernel.

Dump the roothash returned by veritysetup format in a text file,
say roothash.txt and then sign using the openssl command (see below).

1) openssl req -x509 -newkey rsa:1024 -keyout ca_key.pem -out ca.pem -nodes
   -days 365 -set_serial 01 -subj /CN=example.com
2) In .config add the certificate as CONFIG_SYSTEM_TRUSTED_KEYS="path/ca.pem"
3) veritysetup format <fs> <hashdev>, this will return the ROOT_HASH.
4) Use the roothash returned in step 3) and save it to a file for reference and
   signing.
   echo -n <ROOT_HASH> > roothash.txt
5) openssl smime -sign -nocerts -noattr -binary -in <roothash.txt> 
   -inkey ca_key.pem -signer ca.pem -outform der -out sign.txt

Kernel Commandline:
-------------------

To enforce the signatures for all dm verity volumes specify the
dm_verity.require_signatures=1 on the kernel commandline.

Steps on the test kernel/machine:
---------------------------------

After the kernel boots try to create device mapper block device by providing
the roothash and the roothash signature which will be validated by the kernel.

To pass the roothash signature to dm-verity, veritysetup part of
cryptsetup library was modified to take a optional root-hash-sig parameter.

Use the signature file from above step as a parameter to veritysetup.
The changes for veritysetup are in a topic branch for now at:
https://github.com/jaskarankhurana/veritysetup/tree/veritysetup_add_sig

veritysetup open  <data_device> <name> <hash_device> <root_hash>
 --root-hash-sig=<root_hash_pkcs7_detached_sig>

OR
--
We could also use a unpatched veritysetup to test this.

Steps are shown as an example below :
(The roothash and signature will be obtained from steps 1 to 5 above)

eg:
NAME=test
DEV=/dev/sdc
DEV_HASH=/dev/sdd
ROOT_HASH=778fccab393842688c9af89cfd0c5cde69377cbe21ed439109ec856f2aa8a423
SIGN_NAME=verity:$NAME
SIGN=sign.txt
# load signature to keyring
keyctl padd user $SIGN_NAME @u <$SIGN

# add device-mapper table, now with sighed root hash optional argument
dmsetup create -r $NAME --table "$TABLE 2 root_hash_sig_key_desc $SIGN_NAME"
dmsetup table $NAME

# cleanup
dmsetup remove $NAME
keyctl clear @u

Changelog:
---------

v7
  - Changes to patch header to add steps that can help test this.
  - Use the rebased version of the patch that was tested by Milan Broz from his
    tree.

v6
  - Address comments from Milan Broz and Eric Biggers on v5.

  - Keep the verification code under config DM_VERITY_VERIFY_ROOTHASH_SIG.

  - Change the command line parameter to requires_signatures(bool) which will
    force root hash to be signed and trusted if specified.

  - Fix the signature not being present in verity_status. Merged the
    https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/commit/?h=dm-cryptsetup&id=a26c10806f5257e255b6a436713127e762935ad3
    made by Milan Broz and tested it.

v5 (since previous):
  - Code review feedback given by Milan Broz.
  - Remove the Kconfig for root hash verification and instead add a
    commandline parameter(dm_verity.verify_sig) that determines whether
to
    check or enforce root hash signature validation.
  - Fixed a small issue when dm-verity was built sepaerately as a
    module.
  - Added the openssl commandline that can be used to sign the roothash
    in the cover letter.

v4:
  - Code review feedback given by Milan Broz.
  - Add documentation about the root hash signature parameter.
  - Bump up the dm-verity target version.
  - Provided way to sign and test with veritysetup in cover letter.

v3:
  - Code review feedback given by Sasha Levin.
  - Removed EXPORT_SYMBOL_GPL since this was not required.
  - Removed "This file is released under the GPLv2" since we have SPDX
    identifier.
  - Inside verity_verify_root_hash changed EINVAL to ENOKEY when the key
    descriptor is not specified but due to force option being set it is
    expected.
  - Moved CONFIG check to inside verity_verify_get_sig_from_key.
     (Did not move the sig_opts_cleanup to inside verity_dtr as the
     sig_opts do not need to be allocated for the entire duration the
block
     device is active unlike the verity structure, note verity_dtr is
     called      only if verity_ctr fails or after the lifetime of the
     block device.)

v2:
  - Code review feedback to pass the signature binary blob as a key that
    can be looked up in the kernel and be used to verify the roothash.
    [Suggested by Milan Broz]
  - Made the code related change suggested in review of v1.
    [Suggested by Balbir Singh]

v1:
  - Add kconfigs to control dm-verity root has signature verification
    and
    use the signature if specified to verify the root hash.


Jaskaran Khurana (1):
  Add dm verity root hash pkcs7 sig validation.

 .../admin-guide/device-mapper/verity.rst      |   7 +
 drivers/md/Kconfig                            |  12 ++
 drivers/md/Makefile                           |   5 +
 drivers/md/dm-verity-target.c                 |  43 +++++-
 drivers/md/dm-verity-verify-sig.c             | 133 ++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h             |  60 ++++++++
 drivers/md/dm-verity.h                        |   2 +
 7 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

-- 
2.17.1

