Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B324E4C142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2019 21:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfFSTKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jun 2019 15:10:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36214 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfFSTKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:10:54 -0400
Received: from jaskaran-Intel-Server-Board-S1200V3RPS-UEFI-Development-Kit.corp.microsoft.com (unknown [131.107.160.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 27B2620B7194;
        Wed, 19 Jun 2019 12:10:53 -0700 (PDT)
From:   Jaskaran Khurana <jaskarankhurana@linux.microsoft.com>
To:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        jmorris@namei.org, scottsh@microsoft.com, ebiggers@google.com,
        mpatocka@redhat.com, gmazyland@gmail.com
Subject: [RFC PATCH v5 0/1] Add dm verity root hash pkcs7 sig validation. 
Date:   Wed, 19 Jun 2019 12:10:47 -0700
Message-Id: <20190619191048.20365-1-jaskarankhurana@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch set adds in-kernel pkcs7 signature checking for the roothash of
the dm-verity hash tree.
The verification is to support cases where the roothash is not secured by
Trusted Boot, UEFI Secureboot or similar technologies.
One of the use cases for this is for dm-verity volumes mounted after boot,
the root hash provided during the creation of the dm-verity volume has to
be secure and thus in-kernel validation implemented here will be used
before we trust the root hash and allow the block device to be created.

Why we are doing validation in the Kernel?

The reason is to still be secure in cases where the attacker is able to
compromise the user mode application in which case the user mode validation
could not have been trusted.
The root hash signature validation in the kernel along with existing
dm-verity implementation gives a higher level of confidence in the
executable code or the protected data. Before allowing the creation of
the device mapper block device the kernel code will check that the detached
pkcs7 signature passed to it validates the roothash and the signature is
trusted by builtin keys set at kernel creation. The kernel should be
secured using Verified boot, UEFI Secure Boot or similar technologies so we
can trust it.

What about attacker mounting non dm-verity volumes to run executable
code?

This verification can be used to have a security architecture where a LSM
can enforce this verification for all the volumes and by doing this it can
ensure that all executable code runs from signed and trusted dm-verity
volumes.

Further patches will be posted that build on this and enforce this
verification based on policy for all the volumes on the system.

How are these changes tested?

To generate and sign the roothash, dump the roothash returned by 
veritysetup format in a text file, say roothash.txt and then sign using
the openssl command:

openssl smime -sign -nocerts -noattr -binary -in <roothash.txt> 
-inkey <keyfile> -signer <certfile> -outform der -out <out_sigfile>

To pass the roothash signature to dm-verity, veritysetup part of cryptsetup
library was modified to take a optional root-hash-sig parameter.

Commandline used to test the changes:

Use the signature file from above step as a parameter to veritysetup.

veritysetup open  <data_device> <name> <hash_device> <root_hash>
 --root-hash-sig=<root_hash_pkcs7_detached_sig>

The changes for veritysetup are in a topic branch for now at:
https://github.com/jaskarankhurana/veritysetup/tree/veritysetup_add_sig

Set kernel commandline dm_verity.verify_sig=1 or 2 for check/force
dm-verity to do root hash signature validation.

Changelog:

v5 (since previous):
  - Code review feedback given by Milan Broz.
  - Remove the Kconfig for root hash verification and instead add a
    commandline parameter(dm_verity.verify_sig) that determines whether to
    check or enforce root hash signature validation.
  - Fixed a small issue when dm-verity was built sepaerately as a module.
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
     sig_opts do not need to be allocated for the entire duration the block
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
  - Add kconfigs to control dm-verity root has signature verification and
    use the signature if specified to verify the root hash.


Jaskaran Khurana (1):
  Adds in-kernel pkcs7 sig check dmverity roothash

 Documentation/device-mapper/verity.txt |   7 ++
 drivers/md/Kconfig                     |   1 +
 drivers/md/Makefile                    |   2 +-
 drivers/md/dm-verity-target.c          |  36 ++++++-
 drivers/md/dm-verity-verify-sig.c      | 139 +++++++++++++++++++++++++
 drivers/md/dm-verity-verify-sig.h      |  37 +++++++
 6 files changed, 216 insertions(+), 6 deletions(-)
 create mode 100644 drivers/md/dm-verity-verify-sig.c
 create mode 100644 drivers/md/dm-verity-verify-sig.h

-- 
2.17.1

