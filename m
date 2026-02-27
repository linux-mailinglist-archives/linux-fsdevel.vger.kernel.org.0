Return-Path: <linux-fsdevel+bounces-78689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OkMHwFToWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:17:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 164C31B45C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93E3A309C9C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AAA37756A;
	Fri, 27 Feb 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="mY6r9ygk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i670.smtp2go.com (e3i670.smtp2go.com [158.120.86.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF7242D76
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180165; cv=none; b=q8qbxgHxMP+cqBo9Wx4eDXZTLiULCBJnnfR48dI3p97xeAYZN0AKgGWXIHnrHXxJFDzqHkz6SaWLoG3JtOrq0nCAY3Qt6ook/HAbPHxRb062qNI6S1MEatQOHqphV1xEIqyx673NrMF0vo9MExgeqmmyoW5Za+qu3mv6x9hiMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180165; c=relaxed/simple;
	bh=cPPm/LxTGin0WTZSGhPPnZCVw13guVicL/ExTN0AdKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHyNJdGTQrrrLjoTxWJJJB+oarP7w5ZYkMXRE+yczVRmOCVkQIh0bU81vvZUIN8goZR0AKtMIXkrfIbPpwivx+YdaozqVwXbvlEIa/0fGX/r95ygWcPl0ycuj/6aKTiXnJlnD4u7HUMyviCIhLa25ripwQlgCiTieReWNH+9Ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=mY6r9ygk; arc=none smtp.client-ip=158.120.86.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772180161; h=from : subject
 : to : message-id : date;
 bh=7q4ck1jSkFF2a7txlvqCLczhxHn0jMNnagqqcLi9F7A=;
 b=mY6r9ygk5PwOUjlcBhO9RmiXDpLmXjXltQxzyGD+bocJKvhOn1x2YNejYJmBC76LRdyUK
 hKTeIw9Ia4bVZVLkUv+jO0aoZp/98g1eJyUK5vc5JyyVuVRIMsonaqm8IiJzFwprI1SBUcm
 WLmXwNWJmWAkqqZ1cOXtj6FyE/XwuqQcjPMByqeH+cUiM/DhpTcAIja3nxqI9BuOIqJinJm
 RXqSsTijQUZKFt/sgKFS8T+b4MQr4J2bg704+uMBoiLe9sr8OyEb17NwjJcMK8Ka4HGnvU0
 Vqle4Fs/Bq4kHPwbcPnkdbRysyhyZ35x5oVXwS4bCxJM1c2TTy42b9BVfsTA==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vvt0t-FnQW0hPlFgP-nUw0;
	Fri, 27 Feb 2026 08:15:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 0/4] 9p: Performance improvements for build workloads
Date: Fri, 27 Feb 2026 08:56:51 +0100
Message-ID: <cover.1772178819.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616siJYhIGm7G
X-smtpcorp-track: oXoiTDVUyrmh.OOotcqFyEizW.0OGBjQ7mmji
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78689-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 164C31B45C7
X-Rspamd-Action: no action

This patchset introduces several performance optimizations for the 9p
filesystem when used with cache=loose option (exclusive or read only
mounts). These improvements particularly target workloads with frequent
lookups of non-existent paths and repeated symlink resolutions.

The very state of the art benchmark consisting of cloning a fresh
hostap repository and building hostapd and wpa_supplicant for hwsim
tests (cd tests/hwsim; time ./build.sh) in a VM running on a 9pfs rootfs
(with trans=virtio,cache=loose options) has been used to test those
optimizations impact.

For reference, the build takes 0m56.492s on my laptop natively while it
completes in 2m18.702sec on the VM. This represents a significant
performance penalty considering running the same build on a VM using a
virtiofs rootfs (with "--cache always" virtiofsd option) takes around
1m32.141s. This patchset aims to bring the 9pfs build time close to
that of virtiofs, rather than the native host time, as a realistic
expectation.

This first three patches in this series focus on keeping negative
dentries in the cache, ensuring that subsequent lookups for paths known
to not exist do not require redundant 9P RPC calls. This optimization
reduces the time needed for the compiler to search for header files
across known locations. The two first patches introduce a new mount
option, ndentrycache, which specifies the number of ms to keep the
dentry in the cache. Using ndentrycache without value (i.e. keeping the
negative dentry indifinetly) shrunk build time to 1m46.198s. The third
patch enable the negative dentry caching for 24 hours by default on
cache=loose.

The fourth patch extends page cache usage to symlinks by allowing
p9_client_readlink() results to be cached. Resolving symlink is
apparently something done quite frequently during the build process and
avoiding the cost of a 9P RPC call round trip for already known symlinks
helps reduce the build time to 1m26.602s, outperforming the virtiofs
setup.

Here is summary of the different hostapd/wpa_supplicant build times:

  - Baseline (no patch): 2m18.702s
  - negative dentry caching (patches 1-3): 1m46.198s (23% improvement)
  - Above + symlink caching (patches 1-4): 1m26.302s (an additional 18%
    improvement, 37% in total)

With this ~37% performance gain, 9pfs with cache=loose can compete with
virtiofs for (at least) this specific scenario. Although this benchmark
is not the most typical, I do think that these caching optimizations
could benefit a wide range of other workflows as well.

Changes since v2:
  - Rename v9fs_dentry_is_{expired,refresh} to ndentry
  - Some grammatical fixes in couple of comments
  - Rename the negative cache mount option to ndentrycache. Using
    ndentrycache without value enable infinite caching while
    ndentrycache=<time> enable caching for <time> milliseconds.
    This allows the option to be unsigned.
  - Make it more obvious v9fs_issue_read() is only called on dotl
    symlinks

Changes since v1:
  - Rebase on 9p-next (with new mount API conversion)
  - Integrated symlink caching with the network filesystem helper
    library for robustness (a lot of code expects a valid netfs context)
  - Instantiate symlink dentry at creation to avoid keeping a negative
    dentry in cache
  - Moved IO waiting time accounting to a separate patch series

Thanks.

Remi Pommarel (4):
  9p: Cache negative dentries for lookup performance
  9p: Add mount option for negative dentry cache retention
  9p: Set default negative dentry retention time for cache=loose
  9p: Enable symlink caching in page cache

 fs/9p/fid.c             |  11 +++--
 fs/9p/v9fs.c            |  84 +++++++++++++++++++++-----------
 fs/9p/v9fs.h            |  28 +++++++----
 fs/9p/v9fs_vfs.h        |  15 ++++++
 fs/9p/vfs_addr.c        |  29 +++++++++--
 fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c       |  18 ++++---
 fs/9p/vfs_inode_dotl.c  |  72 ++++++++++++++++++++++++---
 fs/9p/vfs_super.c       |   1 +
 include/net/9p/client.h |   2 +
 10 files changed, 290 insertions(+), 75 deletions(-)

-- 
2.52.0


