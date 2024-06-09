Return-Path: <linux-fsdevel+bounces-21290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CE4901599
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D061EB21192
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 10:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E442C19E;
	Sun,  9 Jun 2024 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b="A6+uuzE1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AoEnVlYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC7217554;
	Sun,  9 Jun 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929588; cv=none; b=ZlPnLeXNeaMAX1GiAh1VccFelQa8PvMFVoJHX6sh5NF0A22y3Qqy0r6SxCYYS4DeycHMdj0JdEpOiQozm8KXTKBjPbtCOGeoMv7EVaU5+/3N9IAt2IP5OXp8SIvti9mCtZhP2VewlVYzRjwL3nf2xC33RmUulN1dHMvSL7w5RN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929588; c=relaxed/simple;
	bh=dKaNr1T+2ZoKYO9xvZbhamHUunp15XF6FR3PVyK6ofs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YyfpeObEHeB9j2CAM8UpsCuM+iKk0I56wGlpW2MH/hAnK8jjLkZLq6FpteEbqXQdrCHM2eAhzdA2Yj2MK9F1Bi/1Bdm8Gt3601FGGQRuZ9DRVuhMhUhe/eY4Cv08fYv095zJQg37Rz4x7PJC8Dccf1Hswp6OSWn5do/B9Bvk5Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net; spf=pass smtp.mailfrom=3xx0.net; dkim=pass (2048-bit key) header.d=3xx0.net header.i=@3xx0.net header.b=A6+uuzE1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AoEnVlYQ; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=3xx0.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=3xx0.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailflow.nyi.internal (Postfix) with ESMTP id E12AC200151;
	Sun,  9 Jun 2024 06:39:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 09 Jun 2024 06:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=3xx0.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1717929585; x=1717933185; bh=/O
	0tfbzHKuHaojRdWTQXNBZb0w0SRZ82f5WuNVpAO8c=; b=A6+uuzE1rHNWSsZTV2
	nh1GgNpjc352DgFM/jZmNgD1WhF905rYRmEKbvxZUpXDOMmDeBGRo63NyA943gXB
	ljW4aI2qdH8o9+YWN9GGDLPEsJEvMaLl3TwU6HWh4C0SGTs/DDfsn0FIEBqiS6AA
	DkZIjmnKSDloyVn9VQDpcrAu6vCm1QK24jjFQpP9/eUnEjws0WhLBrrVh4ZNvIGG
	k3TMnL3/B9kNLkDUh/ctpKkeDQpzNdUiWe9Hz+703TzBOwdkoVuai/31wZuczjn/
	YoUIG97TJBy2DJUMfUJgnKU6dZA8tdEX2Nf8gGGUlgq5bUpxralJlmIJH81XI5wH
	cr6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1717929585; x=1717933185; bh=/O0tfbzHKuHao
	jRdWTQXNBZb0w0SRZ82f5WuNVpAO8c=; b=AoEnVlYQzmapn7PSxAEaGwMl5HKnC
	Gi+eLp2B2yPpYpKhrgYJbaf1CNuuBb8Nj0EZn5xeqCj/OYQNpSn0N+Sez1NTsyvE
	o4zzTqq98s08xqhcKsfLLAqfDAJbkr6QW2qGF56RrKkMycCf4a8NuVxGOQ00A4x4
	I7coXhOtpc6Np3R/o6XT04/Z2yhSdT2YA1jmCw3fjv+o7vQ4+5NrJ72ELB+9FJRL
	zUlPUqUz8Z2Mov+4pST/+REpzCp9BeZ8zp5lPOmbYZ5KSpvijRSlJTHWvVBZI804
	dZWBSTfN7LVZodknvVRVtJNFAN9wg0VZPFxZDHl/e0Q8cgnlMx9XY5L1Q==
X-ME-Sender: <xms:cYZlZk0NrIt22oj_PCTv7GPk8BKAdSC4CvBNBtXMlKrOds-jXCX6kg>
    <xme:cYZlZvHzJl2uMqjDCy3roIoo-wPALzr84HqJipIzv4B8BezJaghk90YZwAoLHZaiY
    m6JB2LvR0uL0Rgub5A>
X-ME-Received: <xmr:cYZlZs67TIAQXuRvS4LNJsxIfRhJCMyiWqLUXp3W9CszFQYAOSHyy3BskIrFs2z4wP4f_IFOCGRfLW-6pzjocKeQK7xB5wKEeX-c2uzDAIy6Cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtjedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhnrght
    hhgrnhcuvegrlhhmvghlshcuoehjtggrlhhmvghlshesfeiggidtrdhnvghtqeenucggtf
    frrghtthgvrhhnpefhieevtdektdekvdfftdetudejvdejudekffelvdegteejueeujeeu
    fefhieegfeenucffohhmrghinhepphgrmhgptggrphdrshhopdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjtggr
    lhhmvghlshesfeiggidtrdhnvght
X-ME-Proxy: <xmx:cYZlZt12MpxahFlMi53JTtlMs2HyPQa9_US94TsFreIjarv_5keVTg>
    <xmx:cYZlZnHuRk7vWBuaU_r-RtQjzMj_tt4zI_yGC5SVMw6LoOjX-kDXRA>
    <xmx:cYZlZm-of11IqdzrJfcOfQNEqi19HaNDmVivU5F753rXVxPN1UYGtw>
    <xmx:cYZlZskCoHs4JNkY3J6Og298J1wP6jL-wswP_utkz1mzpGJkfCz-1Q>
    <xmx:cYZlZnGSnk2LavPUrcuXBV7haSMyAl3K3F7V8QEGPjlkJBm2S4l_yIuo>
Feedback-ID: i76614979:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Jun 2024 06:39:41 -0400 (EDT)
From: Jonathan Calmels <jcalmels@3xx0.net>
To: brauner@kernel.org,	ebiederm@xmission.com,
	Jonathan Corbet <corbet@lwn.net>,	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,	"Serge E. Hallyn" <serge@hallyn.com>,
	KP Singh <kpsingh@kernel.org>,	Matt Bobrowski <mattbobrowski@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,	Joel Granados <j.granados@samsung.com>,
	John Johansen <john.johansen@canonical.com>,
	David Howells <dhowells@redhat.com>,	Jarkko Sakkinen <jarkko@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>
Cc: containers@lists.linux.dev,
	Jonathan Calmels <jcalmels@3xx0.net>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/4] Introduce user namespace capabilities
Date: Sun,  9 Jun 2024 03:43:33 -0700
Message-ID: <20240609104355.442002-1-jcalmels@3xx0.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces a new user namespace capability set, as
well as some plumbing around it (i.e. sysctl, secbit, lsm support).

First patch goes over the motivations for this as well as prior art.

In summary, while user namespaces are a great success today in that they
avoid running a lot of code as root, they also expand the attack surface
of the kernel substantially which is often abused by attackers. 
Methods exist to limit the creation of such namespaces [1], however,
application developers often need to assume that user namespaces are
available for various tasks such as sandboxing. Thus, instead of
restricting the creation of user namespaces, we offer ways for userspace
to limit the capabilities granted to them.

Why a new capability set and not something specific to the userns (e.g.
ioctl_ns)?

    1. We can't really expect userspace to patch every single callsite
    and opt-in this new security mechanism. 

    2. We don't necessarily want policies enforced at said callsites.
    For example a service like systemd-machined or a PAM session need to
    be able to place restrictions on any namespace spawned under it.

    3. We would need to come up with inheritance rules, querying
    capabilities, etc. At this point we're just reinventing capability
    sets.

    4. We can easily define interactions between capability sets, thus
    helping with adoption (patch 2 is an example of this)

Some examples of how this could be leveraged in userspace:

    - Prevent user from getting CAP_NET_ADMIN in user namespaces under SSH:
        echo "auth optional pam_cap.so" >> /etc/pam.d/sshd
        echo "!cap_net_admin $USER"     >> /etc/security/capability.conf
        capsh --secbits=$((1 << 8)) -- -c /usr/sbin/sshd

    - Prevent containers from ever getting CAP_DAC_OVERRIDE:
        systemd-run -p CapabilityBoundingSet=~CAP_DAC_OVERRIDE \
                    -p SecureBits=userns-strict-caps \
                    /usr/bin/dockerd
        systemd-run -p UserNSCapabilities=~CAP_DAC_OVERRIDE \
                    /usr/bin/incusd

    - Kernel could be vulnerable to CAP_SYS_RAWIO exploits, prevent it:
        sysctl -w cap_bound_userns_mask=0x1fffffdffff

    - Drop CAP_SYS_ADMIN for this shell and all the user namespaces below it:
        bwrap --unshare-user --cap-drop CAP_SYS_ADMIN /bin/sh

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cd4c5c2101cb092db00f61f69d24380cf7a0ee8

---
Changes since v1:
- Add documentation
- Change commit wording
- Cleanup various aspects of the code based on feedback
- Add new CAP_SYS_CONTROL capability for sysctl check
- Add BPF-LSM support for modifying userns capabilities
---
Jonathan Calmels (4):
  capabilities: Add user namespace capabilities
  capabilities: Add securebit to restrict userns caps
  capabilities: Add sysctl to mask off userns caps
  bpf,lsm: Allow editing capabilities in BPF-LSM hooks

 Documentation/filesystems/proc.rst            |  1 +
 Documentation/security/credentials.rst        |  6 ++
 fs/proc/array.c                               |  9 +++
 include/linux/cred.h                          |  3 +
 include/linux/lsm_hook_defs.h                 |  2 +-
 include/linux/securebits.h                    |  1 +
 include/linux/security.h                      |  4 +-
 include/linux/user_namespace.h                |  7 ++
 include/uapi/linux/capability.h               |  6 +-
 include/uapi/linux/prctl.h                    |  7 ++
 include/uapi/linux/securebits.h               | 11 ++-
 kernel/bpf/bpf_lsm.c                          | 55 +++++++++++++
 kernel/cred.c                                 |  3 +
 kernel/sysctl.c                               | 10 +++
 kernel/umh.c                                  | 15 ++++
 kernel/user_namespace.c                       | 80 +++++++++++++++++--
 security/apparmor/lsm.c                       |  2 +-
 security/commoncap.c                          | 62 +++++++++++++-
 security/keys/process_keys.c                  |  3 +
 security/security.c                           |  6 +-
 security/selinux/hooks.c                      |  2 +-
 security/selinux/include/classmap.h           |  5 +-
 .../selftests/bpf/prog_tests/deny_namespace.c | 12 ++-
 .../selftests/bpf/progs/test_deny_namespace.c |  7 +-
 24 files changed, 291 insertions(+), 28 deletions(-)

-- 
2.45.2


