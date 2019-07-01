Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5855A46719
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfFNSFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 14:05:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:33022 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbfFNSFn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:05:43 -0400
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 4C1245C13C2EEB6086AD;
        Fri, 14 Jun 2019 19:05:41 +0100 (IST)
Received: from roberto-HP-EliteDesk-800-G2-DM-65W.huawei.com (10.204.65.154)
 by smtpsuk.huawei.com (10.201.108.43) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Jun 2019 19:05:32 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@huawei.com>,
        <mjg59@google.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <silviu.vlasceanu@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 14/14] ima: add Documentation/security/IMA-digest-lists.txt
Date:   Fri, 14 Jun 2019 19:55:13 +0200
Message-ID: <20190614175513.27097-15-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614175513.27097-1-roberto.sassu@huawei.com>
References: <20190614175513.27097-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.204.65.154]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds the documentation of the IMA Digest Lists extension.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 Documentation/security/IMA-digest-lists.txt | 226 ++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 Documentation/security/IMA-digest-lists.txt

diff --git a/Documentation/security/IMA-digest-lists.txt b/Documentation/security/IMA-digest-lists.txt
new file mode 100644
index 000000000000..dd9633e21304
--- /dev/null
+++ b/Documentation/security/IMA-digest-lists.txt
@@ -0,0 +1,226 @@
+==========================
+IMA Digest Lists Extension
+==========================
+
+INTRODUCTION
+============
+
+Integrity Measurement Architecture (IMA) is a security module that performs
+measurement of files accessed with the execve(), mmap() and open() system
+calls. File measurements can be used for different purposes. They can be
+added in a measurement list and sent to a remote verifier for an integrity
+evaluation. They can be compared to reference values provided by the
+software vendor and access can be denied if there is a mismatch. File
+measurements can also be included in system logs for auditing purposes.
+
+IMA Digest Lists is an extension providing additional functionality for
+the IMA submodules. Its main task is to load reference file digests in the
+kernel memory, and to communicate to IMA submodules (measurement and
+appraisal) whether the digest of a file being accessed is found in the
+uploaded digest lists.
+
+The IMA-Measure submodule uses the IMA Digest Lists extension to create
+a new measurement list (with a different PCR, for example 11) which
+contains the measurement of uploaded digest lists and unknown files. Since
+the loading of digest lists is sequential, the chosen PCR will have a
+predictable value for the whole boot cycle and can be used for sealing
+policies based on the OS software integrity.
+
+Both the standard and the new measurement list can be generated at the same
+time, allowing for implicit attestation based on the usage of a TPM key
+sealed to the OS, and for explicit attestation when a more precise
+integrity evaluation is necessary.
+
+The IMA-Appraise submodule uses the IMA Digest Lists extension to
+grant/deny access to the files depending on whether the file digest is
+found in the uploaded digest lists, instead of checking security.ima.
+
+The main advantage of the extension is that reference measurements used for
+the digest comparison can be extracted from already existing sources (for
+example RPM headers). Another benefit is that the overhead compared to file
+signatures is lower as only one signature is verified for all files
+included in the digest list. A disadvantage is that file metadata are not
+verified.
+
+
+
+WORKFLOW
+========
+
+The IMA workflow is modified as follows. The added steps are marked as
+[NEW].
+
+  +------------+
+  |  IMA hook  |
+  +------------+
+        |
+   +---------+
+   | collect |
+   +---------+
+        |                                           +---------------------+
++---------------+                       ------------| don't measure [NEW] |
+| digest lookup |                       | yes       +---------------------+
+|     [NEW]     |                 -------------- no +---------------------+
++---------------+           -----/ digest       \---| add to measurement  |
+        |                   |    \ found? [NEW] /   | list (PCR 11) [NEW] |
+        |                   |     --------------    +---------------------+
+  +----------+       +-------------+                +--------------------+
+  |  switch  |-------| IMA-Measure |----------------| add to measurement |
+  | (action) |       +-------------+                | list (PCR 10)      |
+  +----------+                                      +--------------------+
+        |
+        |
+        |       no xattr
++--------------+     ---------------  yes
+| IMA-Appraise |----/ filec created \-------------------------------
++--------------+    \ created [NEW] /                              |
+  xattr |            ---------------                               |
+        |                   | no                                   |
+        |           ------------------  no  --------------  yes  +--------+
+        |          / EVM initialized? \----/ digest       \------| grant  |
+        |          \ [NEW]            /    \ found? [NEW] /      | access |
+        |           ------------------      --------------       +--------+
+        |                   | yes                 | no
+        |                   |                     |              +--------+
+        |           -------------------  no       ---------------| deny   |
+        |          / digest-nometadata \-------------------------| access |
+        |          \ mode? [NEW]       /                         +--------+
+        |           -------------------
+        |               ^   | yes                                +--------+
+        |               |   -------------------------------------| grant  |
+        |               |                                        | access |
+        |               |                                        +--------+
+        |               | yes
+        |           -------------------------  no                +--------+
+        |----------/ security.ima (new type) \-------------------| deny   |
+        |          \ present and valid?      /                   | access |
+        |           -------------------------                    +--------+
+        |                                                            |
+        |           --------------------------  no                   |
+        -----------/ security.ima (cur types) \-----------------------
+                   \ present and valid?       /
+                    --------------------------
+                             | yes                               +--------+
+                             ------------------------------------| grant  |
+                                                                 | access |
+                                                                 +--------+
+
+After the file digest is calculated, it is searched in the hash table
+containing all digests extracted from the uploaded digest lists. Then, if
+the digest is found, a structure is returned to IMA with information
+associated to that digest. The structure is returned only to the IMA
+submodules that processed the digest lists (i.e. the action returned by
+ima_get_action() was 'measure' or 'appraise').
+
+IMA-Measure behavior depends on whether the digest list PCR has been
+specified in the kernel command line. If the PCR was not specified, the
+submodule behaves as before. If the PCR was specified, IMA-Measure creates
+a new measurement with that PCR, only if the file digest is not found in
+the digest lists. It additionally creates a measurement with the default
+PCR if '+' is added as a prefix to the PCR.
+
+IMA-Appraise behavior depends on whether either the 'digest' or
+'digest-nometadata' appraisal modes have been specified in the kernel
+command line. If they were not specified, IMA-Appraise relies solely on the
+security.ima xattr for verification. If the 'digest' mode was specified,
+verification succeeds if the file digest is found in the digest lists and
+EVM is not initialized, as there is no other way to verify file metadata.
+
+If the 'digest-nometadata' mode was specified, verification succeeds
+regardless of the fact that EVM is initialized or not. However, after a
+write, files for which access was granted without verifying metadata will
+have a new security.ima type, so that they can be identified also after
+reboot. Specifying 'digest-nometadata' is required also to access files
+with the new security.ima type.
+
+
+
+ARCHITECTURE
+============
+
++--------------+           8) digest lookup
+| IMA-Appraise |--------------------------------------
++--------------+                                     |
+                                                     |
++-------------+            7) digest lookup          |
+| IMA-Measure | -------------------------------------|
++-------------+                                     ||
+                                                   |||
++-------------+ 2a/5b) parse compact list +-------------------+
+| IMA (secfs) | ------------------------> | IMA Digests Lists |
++-------------+                           +-------------------+
+   ^        ^                                 |     | 3a/6b add digests
+   |        |                                 |  +------------+
+   |        |                                 |  | hash table |
+   |        |                                 |  +------------+
+   |        | 4b) upload compact list         |
+   |        |                                 |                kernel space
+---|--------|---------------------------------|-------------------------------
+   |        | 1b) open digest_list_data       |                user space
+   | +-------------+                          |
+   | |    Parser   |<--------------------------
+   | +-------------+   2b) check parser binary, shared libraries
+   |     ^  ^  ^           and actions (measure/appraise)
+   |    RPM | ...      3b) read and convert digest list
+   |     manifest
+   |
+1a) upload compact list
+
+The main addition to IMA is a new hash table (similar to that used to check
+for duplicate measurement entries), which contains file digests extracted
+from the digest lists.
+
+File digests can be uploaded to IMA through a new securityfs file named
+'digest_list_data' and must be sent in a format called compact list. Digest
+lists can be uploaded directly to the kernel, by specifying their path, or
+by executing a user space parser.
+
+The parser, called upload_digest_lists, converts digest lists from the
+original format defined by the software vendor (e.g. RPM package header) to
+the compact list format. It is executed by the kernel even before init,
+so that the hash table is populated before any file is accessed.
+
+Converted digest lists can be uploaded exclusively by the parser. The
+reason is that digest lists are measured only when they are accessed. If
+they were uploaded by any process there wouldn't be any guarantee that the
+converted lists contain the same digests as the original list. IMA checks
+that the digest of the executable that opened 'digest_list_data' as well as
+shared libraries supporting new digest list formats have type
+COMPACT_PARSER.
+
+As mentioned above, digest lists cannot be used unconditionally but must
+have been processed by the IMA submodule willing to use them. This is
+achieved by keeping track of the process that opens and closes
+digest_list_data, and checking the actions done by that process. If a file
+opened by the parser is not being measured, IMA-Measure will not be able
+to use digest lists until reboot. The same happens for IMA-Appraise.
+
+
+
+CONFIGURATION
+=============
+
+The first step consists in generating digest lists with the
+gen_digest_lists tool included in the digest-list-tools package.
+digest-list-tools can be retrieved at the URL:
+
+https://github.com/euleros/digest-list-tools
+
+gen_digest_lists can generate digest lists from different sources (for
+example: RPM package DB and IMA measurement list). By default, it saves
+generated digest lists in the /etc/ima/digest_lists directory.
+digest-list-tools includes also two bash scripts setup_ima_digest_lists and
+setup_digest_lists_demo to simplify the digest list generation for the
+users.
+
+To use the parser at boot, it is also necessary to generate a digest list
+for it. It is automatically generated by the setup_ima_digest_lists script,
+or it must be manually generated otherwise. If digest lists are used for
+appraisal, they must be signed with a key saved to /etc/keys/x509_ima.der
+and the key must be signed with a key in the primary or secondary kernel
+keyring.
+
+To use digest lists during early boot, it is necessary to regenerate the
+initial ram disk. Digest lists and the parser will be included in the ram
+disk by the new dracut/initramfs-tools modules, included in the
+digest-list-tools package.
-- 
2.17.1

