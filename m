Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01CA2328E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgG3AcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jul 2020 20:32:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54150 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgG3AbX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:31:23 -0400
Received: from dede-linux-virt.corp.microsoft.com (unknown [131.107.160.54])
        by linux.microsoft.com (Postfix) with ESMTPSA id 686C620B4917;
        Wed, 29 Jul 2020 17:31:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 686C620B4917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596069081;
        bh=KhoFsTJs5gxu/rX0FiRwuDyUMSPaO0P9QryO0bopQaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0auL+qkTZ8BpUGmAMvZ6PJ/86vjeGgUibH1hkxgTyvVLdF2864CxgvB8ex7px/2+
         2+jcHlszQmKJBhS2e5oFw+wxhh+awEAJx15CcG2xPrUyYLW86KRY6MxCmKSy5kKVNh
         4Nf2mMSN9NBluW5K167djYsoK0ibDXRw8QRNqWIk=
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        viro@zeniv.linux.org.uk, paul@paul-moore.com, eparis@redhat.com,
        jannh@google.com, dm-devel@redhat.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com
Cc:     tyhicks@linux.microsoft.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net, sashal@kernel.org,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: [RFC PATCH v6 10/11] documentation: add ipe documentation
Date:   Wed, 29 Jul 2020 17:31:12 -0700
Message-Id: <20200730003113.2561644-11-deven.desai@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
References: <20200730003113.2561644-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add IPE's documentation to the kernel tree.

Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
Acked-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/LSM/index.rst       |   1 +
 Documentation/admin-guide/LSM/ipe.rst         | 508 ++++++++++++++++++
 .../admin-guide/kernel-parameters.txt         |  12 +
 MAINTAINERS                                   |   1 +
 4 files changed, 522 insertions(+)
 create mode 100644 Documentation/admin-guide/LSM/ipe.rst

diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index a6ba95fbaa9f..ce63be6d64ad 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -47,3 +47,4 @@ subdirectories.
    tomoyo
    Yama
    SafeSetID
+   ipe
diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-guide/LSM/ipe.rst
new file mode 100644
index 000000000000..2e6610c4a134
--- /dev/null
+++ b/Documentation/admin-guide/LSM/ipe.rst
@@ -0,0 +1,508 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Integrity Policy Enforcement (IPE)
+==================================
+
+Overview
+--------
+
+IPE is a Linux Security Module which allows for a configurable policy
+to enforce integrity requirements on the whole system. It attempts to
+solve the issue of Code Integrity: that any code being executed (or
+files being read), are identical to the version that was built by a
+trusted source.
+
+There are multiple implementations within the Linux kernel that solve
+some measure of integrity verification. For instance, device-mapper
+verity, which ensures integrity for a block device, and fs-verity which
+is a system that ensures integrity for a filesystem. What these
+implementations lack is a measure of run-time verification that binaries
+are sourced from these locations. IPE aims to address this gap.
+
+IPE is separated between two major components: A configurable policy,
+provided by the LSM ("IPE Core"), and deterministic attributes provided
+by the kernel to evaluate files against, ("IPE Properties").
+
+Use Cases
+---------
+
+IPE is designed for use is an embedded device with a specific purpose
+(e.g. network firewall device in a data center), where all software and
+configuration is built and provisioned by the owner.
+
+Ideally, a system which leverages IPE is not intended for general
+purpose computing and does not utilize any software or configuration
+built by a third party. An ideal system to leverage IPE has both mutable
+and immutable components, however, all binary executable code is
+immutable.
+
+For the highest level of security, platform firmware should verify the
+the kernel and optionally the root filesystem (e.g. via U-Boot verified
+boot). This allows the entire system to be integrity verified.
+
+Known Gaps
+----------
+
+IPE cannot verify the integrity of anonymous executable memory, such as
+the trampolines created by gcc closures and libffi, or JIT'd code.
+Unfortunately, as this is dynamically generated code, there is no way
+for IPE to detect that this code has not been tampered with in
+transition from where it was built, to where it is running. As a result,
+IPE is incapable of tackling this problem for dynamically generated
+code.
+
+IPE cannot verify the integrity of interpreted languages' programs when
+these scripts invoked via ``<interpreter> <file>``. This is because the
+way interpreters execute these files, the scripts themselves are not
+evaluated as executable code through one of IPE's hooks. Interpreters
+can be enlightened to the usage of IPE by trying to mmap a file into
+executable memory (+X), after opening the file and responding to the
+error code appropriately. This also applies to included files, or high
+value files, such as configuration files of critical system components.
+This specific gap is planned on being addressed within IPE.
+
+Threat Model
+------------
+
+The threat type addressed by IPE is tampering of executable user-land
+code beyond the initially booted kernel, and the initial verification of
+kernel modules that are loaded in userland through ``modprobe`` or
+``insmod``.
+
+Tampering violates the property of integrity. IPE's role in mitigating
+this threat is to verify the integrity (and authenticity) of all
+executable code and to deny their use if integrity verification fails.
+IPE generates audit logs which may be utilized to detect integrity
+verification failures.
+
+Tampering threat scenarios include modification or replacement of
+executable code by a range of actors including:
+
+-  Insiders with physical access to the hardware
+-  Insiders with local network access to the system
+-  Insiders with access to the deployment system
+-  Compromised internal systems under external control
+-  Malicious end users of the system
+-  Compromised end users of the system
+-  Remote (external) compromise of the system
+
+IPE does not mitigate threats arising from malicious authorized
+developers, or compromised developer tools used by authorized
+developers. Additionally, IPE draws hard security boundary between user
+mode and kernel mode. As a result, IPE does not provide any protections
+against a kernel level exploit, and a kernel-level exploit can disable
+or tamper with IPE's protections.
+
+The root of trust for all of IPE's verifications is the
+``SYSTEM_TRUSTED_KEYRING``.
+
+IPE Core
+--------
+
+IPE Policy
+~~~~~~~~~~
+
+IPE policy is designed to be both forward compatible and backwards
+compatible. There is one required line, at the top of the policy,
+indicating the policy name, and the policy version, for instance::
+
+   policy_name="Ex Policy" policy_version=0.0.0
+
+The policy name is a unique key identifying this policy in a human
+readable name. This is used to create nodes under securityfs as well as
+uniquely identify policies to deploy new policies vs update existing
+policies.
+
+The policy version indicates the current version of the policy (NOT the
+policy syntax version). This is used to prevent roll-back of policy to
+potentially insecure previous versions of the policy.
+
+The next portion of IPE policy, are rules. Rules are formed by key=value
+pairs, known as properties. IPE rules require two properties: "action",
+which determines what IPE does when it encounters a match against the
+rule, and "op", which determines when that rule should be evaluated.
+Thus, a minimal rule is::
+
+   op=EXECUTE action=ALLOW
+
+This example will allow any execution. Additional properties are used to
+restrict attributes about the files being evaluated. These properties
+are intended to be deterministic attributes that are resident in the
+kernel.
+
+Order does not matter for the rule's properties - they can be listed in
+any order, however it is encouraged to have the "op" property be first,
+and the "action" property be last for readability. Rules are evaluated
+top-to-bottom. As a result, any revocation rules, or denies should be
+placed early in the file to ensure that these rules are evaluated before
+as rule with "action=ALLOW" is hit.
+
+IPE policy is designed to be forward compatible and backwards
+compatible, thus any failure to parse a rule will result in the line
+being ignored, and a warning being emitted. If backwards compatibility
+is not required, the kernel command line parameter and sysctl,
+``ipe.strict_parse`` can be enabled, which will cause these warnings to
+be fatal.
+
+IPE policy supports comments. The character '#' will function as a
+comment, ignoring all characters to the right of '#' until the newline.
+
+The default behavior of IPE evaluations can also be expressed in policy,
+through the ``DEFAULT`` statement. This can be done at a global level,
+or a per-operation level::
+
+   # Global
+   DEFAULT action=ALLOW
+
+   # Operation Specific
+   DEFAULT op=EXECUTE action=ALLOW
+
+A default must be set for all known operations in IPE. If you want to
+preserve older policies being compatible with newer kernels that can introduce
+new operations, please set a global default of 'ALLOW', and override the
+defaults on a per-operation basis.
+
+With configurable policy-based LSMs, there's several issues with
+enforcing the configurable policies at startup, around reading and
+parsing the policy:
+
+1. The kernel *should* not read files from userland, so directly reading
+   the policy file is prohibited.
+2. The kernel command line has a character limit, and one kernel module
+   should not reserve the entire character limit for its own
+   configuration.
+3. There are various boot loaders in the kernel ecosystem, so handing
+   off a memory block would be costly to maintain.
+
+As a result, IPE has addressed this problem through a concept of a "boot
+policy". A boot policy is a minimal policy, compiled into the kernel.
+This policy is intended to get the system to a state where userland is
+setup and ready to receive commands, at which point a more complex
+policy ("user policies") can be deployed via securityfs. The boot policy
+can be specified via the Kconfig, ``SECURITY_IPE_BOOT_POLICY``, which
+accepts a path to a plain-text version of the IPE policy to apply. This
+policy will be compiled into the kernel. If not specified, IPE will be
+disabled until a policy is deployed through securityfs, and activated
+through sysfs.
+
+Deploying Policies
+^^^^^^^^^^^^^^^^^^
+
+User policies as explained above, are policies that are deployed from
+userland, through securityfs. These policies are signed to enforce some
+level of authorization of the policies (prohibiting an attacker from
+gaining root, and deploying an "allow all" policy), through the PKCS#7
+enveloped data format. These policies must be signed by a certificate
+that chains to the ``SYSTEM_TRUSTED_KEYRING``. Through openssl, the
+signing can be done via::
+
+   openssl smime -sign -in "$MY_POLICY" -signer "$MY_CERTIFICATE" \
+     -inkey "$MY_PRIVATE_KEY" -binary -outform der -noattr -nodetach \
+     -out "$MY_POLICY.p7s"
+
+Deploying the policies is done through securityfs, through the
+``new_policy`` node. To deploy a policy, simply cat the file into the
+securityfs node::
+
+   cat "$MY_POLICY.p7s" > /sys/kernel/security/ipe/new_policy
+
+Upon success, this will create one subdirectory under
+``/sys/kernel/security/ipe/policies/``. The subdirectory will be the
+``policy_name`` field of the policy deployed, so for the example above,
+the directory will be ``/sys/kernel/security/ipe/policies/Ex\ Policy``.
+Within this directory, there will be four files: ``raw``, ``content``,
+``active``, and ``delete``.
+
+The ``raw`` file is rw, reading will provide the raw PKCS#7 data that
+was provided to the kernel, representing the policy. Writing, will
+deploy an in-place policy update - if this policy is the currently
+running policy, the new updated policy will replace it immediately upon
+success.
+
+The ``content`` file is read only. Reading will provide the PKCS#7 inner
+content of the policy, which will be the plain text policy.
+
+The ``active`` file is used to set a policy as the currently active policy.
+This file is rw, and accepts a value of ``"1"`` to set the policy as active.
+Since only a single policy can be active at one time, all other policies
+will be marked inactive.
+
+Similarly, the ``cat`` command above will result in an error upon
+syntactically invalid or untrusted policies. It will also error if a
+policy already exists with the same ``policy_name``. The write to the
+``raw`` node will error upon syntactically invalid, untrusted policies,
+or if the payload fails the version check. The write will also fail if
+the ``policy_name`` in the payload does not match the existing policy.
+
+Deploying these policies will *not* cause IPE to start enforcing this
+policy. Once deployment is successful, a policy can be marked as active,
+via ``/sys/kernel/security/ipe/$policy_name/active``. IPE will enforce
+whatever policy is marked as active. For our example, we can activate
+the ``Ex Policy`` via::
+
+   echo -n 1 > "/sys/kernel/security/ipe/Ex Policy/active"
+
+At which point, ``Ex Policy`` will now be the enforced policy on the
+system.
+
+.. NOTE::
+
+   The -n parameter is important, as it strips an additional newline.
+
+IPE also provides a way to delete policies. This can be done via the
+``delete`` securityfs node, ``/sys/kernel/security/ipe/$policy_name/delete``.
+Writing ``1`` to that file will delete that node::
+
+   echo -n 1 > "/sys/kernel/security/ipe/$policy_name/delete"
+
+There are two requirements to delete policies:
+
+1. The policy being deleted must not be the active policy.
+2. The policy being deleted must not be the boot policy.
+
+.. NOTE::
+
+   If a MAC system is enabled, all writes to ipe's securityfs nodes require
+   ``CAP_MAC_ADMIN``.
+
+Modes
+~~~~~
+
+IPE supports two modes of operation: permissive (similar to SELinux's
+permissive mode) and enforce. Permissive mode performs the same checks
+as enforce mode, and logs policy violations, but will not enforce the
+policy. This allows users to test policies before enforcing them.
+
+The default mode is enforce, and can be changed via the kernel command
+line parameter ``ipe.enforce=(0|1)``, or the securityfs node
+``/sys/kernel/security/ipe/enforce``. The ability to switch modes can
+be compiled out of the LSM via setting the Kconfig
+``CONFIG_SECURITY_IPE_PERMISSIVE_SWITCH`` to N.
+
+.. NOTE::
+
+   If a MAC system is enabled, all writes to ipe's securityfs nodes require
+   ``CAP_MAC_ADMIN``.
+
+Audit Events
+~~~~~~~~~~~~
+
+Success Auditing
+^^^^^^^^^^^^^^^^
+
+IPE supports success auditing. When enabled, all events that pass IPE
+policy and are not blocked will emit an audit event. This is disabled by
+default, and can be enabled via the kernel command line
+``ipe.success_audit=(0|1)`` or the securityfs node,
+``/sys/kernel/security/ipe/success_audit``.
+
+This is very noisy, as IPE will check every user-mode binary on the
+system, but is useful for debugging policies.
+
+.. NOTE::
+
+   If a MAC system is enabled, all writes to ipe's securityfs nodes require
+   ``CAP_MAC_ADMIN``.
+
+IPE Properties
+--------------
+
+As explained above, IPE properties are ``key=value`` pairs expressed in
+IPE policy. Two properties are built-into the policy parser: 'op' and
+'action'. The other properties are determinstic attributes to express
+across files. Currently those properties are: 'boot_verified',
+'dmverity_signature', 'dmverity_roothash'. A description of all
+properties supported by IPE are listed below:
+
+op
+~~
+
+Indicates the operation for a rule to apply to. Must be in every rule.
+IPE supports the following operations:
+
+Version 1
+^^^^^^^^^
+
+``EXECUTE``
+
+   Pertains to any file attempting to be executed, or loaded as an
+   executable.
+
+``FIRMWARE``:
+
+   Pertains to firmware being loaded via the firmware_class interface.
+   This covers both the preallocated buffer and the firmware file
+   itself.
+
+``KMODULE``:
+
+   Pertains to loading kernel modules via ``modprobe`` or ``insmod``.
+
+``KEXEC_IMAGE``:
+
+   Pertains to kernel images loading via ``kexec``.
+
+``KEXEC_INITRAMFS``
+
+   Pertains to initrd images loading via ``kexec --initrd``.
+
+``POLICY``:
+
+   Controls loading IMA policies through the
+   ``/sys/kernel/security/ima/policy`` securityfs entry.
+
+``X509_CERT``:
+
+   Controls loading IMA certificates through the Kconfigs,
+   ``CONFIG_IMA_X509_PATH`` and ``CONFIG_EVM_X509_PATH``.
+
+``KERNEL_READ``:
+
+   Short hand for all of the following: ``FIRMWARE``, ``KMODULE``,
+   ``KEXEC_IMAGE``, ``KEXEC_INITRAMFS``, ``POLICY``, and ``X509_CERT``.
+
+action
+~~~~~~
+
+Version 1
+^^^^^^^^^
+
+Determines what IPE should do when a rule matches. Must be in every
+rule. Can be one of:
+
+``ALLOW``:
+
+   If the rule matches, explicitly allow the call to proceed without
+   executing any more rules.
+
+``DENY``:
+
+   If the rule matches, explicitly prohibit the call from proceeding
+   without executing any more rules.
+
+boot_verified
+~~~~~~~~~~~~~
+
+Version 1
+^^^^^^^^^
+
+This property can be utilized for authorization of the first super-block
+that executes a file. This is almost always init. Typically this is used
+for systems with an initramfs or other initial disk, where this is unmounted
+before the system becomes available, and is not covered by any other property.
+This property is controlled by the Kconfig, ``CONFIG_IPE_BOOT_PROP``. The
+format of this property is::
+
+       boot_verified=(TRUE|FALSE)
+
+
+.. WARNING::
+
+  This property will trust any disk where the first execution occurs
+  evaluation occurs. If you do not have a startup disk that is
+  unpacked and unmounted (like initramfs), then it will automatically
+  trust the root filesystem and potentially overauthorize the entire
+  disk.
+
+dmverity_roothash
+~~~~~~~~~~~~~~~~~
+
+Version 1
+^^^^^^^^^
+
+This property can be utilized for authorization or revocation of
+specific dm-verity volumes, identified via root hash. It has a
+dependency on the DM_VERITY module. This property is controlled by the
+property: ``CONFIG_IPE_DM_VERITY_ROOTHASH``. The format of this property
+is::
+
+   dmverity_roothash=HashHexDigest
+
+dmverity_signature
+~~~~~~~~~~~~~~~~~~
+
+Version 1
+^^^^^^^^^
+
+This property can be utilized for authorization of all dm-verity volumes
+that have a signed roothash that chains to the system trusted keyring.
+It has a dependency on the ``DM_VERITY_VERIFY_ROOTHASH_SIG`` Kconfig.
+This property is controlled by the Kconfig:
+``CONFIG_IPE_DM_VERITY_SIGNATURE``. The format of this property is::
+
+   dmverity_signature=(TRUE|FALSE)
+
+Policy Examples
+---------------
+
+Allow all
+~~~~~~~~~
+
+::
+
+   policy_name="Allow All" policy_version=0.0.0
+   DEFAULT action=ALLOW
+
+Allow only initial superblock
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name="Allow All Initial SB" policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE boot_verified=TRUE action=ALLOW
+
+Allow any signed dm-verity volume and the initial superblock
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name="AllowSignedAndInitial" policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE boot_verified=TRUE action=ALLOW
+   op=EXECUTE dmverity_signature=TRUE action=ALLOW
+
+Prohibit execution from a specific dm-verity volume
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name="AllowSignedAndInitial" policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE dmverity_roothash=401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=DENY
+   op=EXECUTE boot_verified=TRUE action=ALLOW
+   op=EXECUTE dmverity_signature=TRUE action=ALLOW
+
+Allow only a specific dm-verity volume
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+::
+
+   policy_name="AllowSignedAndInitial" policy_version=0.0.0
+   DEFAULT action=DENY
+
+   op=EXECUTE dmverity_roothash=401fcec5944823ae12f62726e8184407a5fa9599783f030dec146938 action=ALLOW
+
+External Information
+--------------------
+
+Please see the github repository at: https://github.com/microsoft/ipe
+
+FAQ
+---
+
+Q: What's the difference between other LSMs which provide integrity
+verification (i.e. IMA)?
+
+A: IPE differs from other LSMs which provide integrity checking, as it
+has no dependency on the filesystem metadata itself. The attributes that
+IPE checks are deterministic properties that exist solely in the kernel.
+Additionally, IPE provides no additional mechanisms of verifying these
+files (e.g. IMA Signatures) - all of the attributes of verifying files
+are existing features within the kernel.
+
+Additionally, IPE is completely restricted to integrity. It offers no
+measurement or attestation features, which IMA addresses.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..5309813f25f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1953,6 +1953,18 @@
 	ipcmni_extend	[KNL] Extend the maximum number of unique System V
 			IPC identifiers from 32,768 to 16,777,216.
 
+	ipe.enforce=	[IPE]
+			Format: <bool>
+			Determine whether IPE starts in permissive (0) or
+			enforce (1) mode. The default is enforce.
+
+	ipe.success_audit=
+			[IPE]
+			Format: <bool>
+			Start IPE with success auditing enabled, emitting
+			an audit event when a binary is allowed. The default
+			is 0.
+
 	irqaffinity=	[SMP] Set the default irq affinity mask
 			The argument is a cpu list, as described above.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index e817e4bfeae3..b448fd435712 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8584,6 +8584,7 @@ INTEGRITY POLICY ENFORCEMENT (IPE)
 M:	Deven Bowers <deven.desai@linux.microsoft.com>
 L:	linux-integrity@vger.kernel.org
 S:	Supported
+F:	Documentation/admin-guide/LSM/ipe.rst
 F:	scripts/ipe/
 F:	security/ipe/
 
-- 
2.27.0

