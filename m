Return-Path: <linux-fsdevel+bounces-78029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNmqFKzdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:07:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2ED17ED4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3196318DEA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B037D126;
	Mon, 23 Feb 2026 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnOOyCc8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA8337D11D;
	Mon, 23 Feb 2026 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887855; cv=none; b=QdcAXz0wlxLFfP+Zl3WwWa1gFVq4Z9RQ5r5ZxxqAZy5LWUC1KMTu7OZJUMbI4j954lHQdnDYAHjbA3ezAsoARx9w+Qp53b0YQ2G4P0mJbgQRqLF8unCRaR91jlzlT4oaP8JyJSCKXbdh0KV3UBzRkb49sIuFe4wxKutEkBupqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887855; c=relaxed/simple;
	bh=RK2wQUhVjXMYMKbuFaa168T85P+VefLVbONdf2pvFz4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtdIoXZGspe6s7jtBTY5Ei9UK6BEq6Idcco3IRMUMx9LAsmwYMBGvOdXAQEk0xgcA/AqrbWTq/qyGHkXRKFV8PkrjRD0OhwTuoeMh0nHsH6zPlU+L9hAuTyaSlVBZuuewnE5bV4bhQRlbreOyZ/OHk5u3j6cF5KHtWJOK2UsGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnOOyCc8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE21C116C6;
	Mon, 23 Feb 2026 23:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887854;
	bh=RK2wQUhVjXMYMKbuFaa168T85P+VefLVbONdf2pvFz4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XnOOyCc8/Kt59oBMIbbSKFWI7tgApFEC/3vO1AIayuL0pTbJQygjdRNw+4doViTYJ
	 SwqjIhwCib3Ilcxc7KJ/wo23VywSndwyLRLRGQ2+o4sZS9MGpcOnWuaCKanKJzuTmj
	 ZQlAwx1YIN3NJFLJ4g56WU3tSpxmB1Q1MI3fUtVeViicx6K5YIw0XdHRzB1jKK27ED
	 kAZndD7zLngpasg3QGxBHFwxTf7BaXbudLs0i77qXoMmHCcwsmrYbL01OojEQtdfia
	 yF/J/4yKlunRTdxw/TmtZ22pmZpumP5a0FogQvdmwLPW0X+muypF71WRvS18m50MV/
	 T/jSF/rEPMAfg==
Date: Mon, 23 Feb 2026 15:04:14 -0800
Subject: [PATCHSET RFC 6/6] fuse: allow fuse servers to upload iomap BPF
 programs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, john@groves.net, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741597.3942368.18114094782378370092.stgit@frogsfrogsfrogs>
In-Reply-To: <20260223224617.GA2390314@frogsfrogsfrogs>
References: <20260223224617.GA2390314@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,groves.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-78029-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF2ED17ED4A
X-Rspamd-Action: no action

Hi all,

There are certain fuse servers that might benefit from the ability to
upload a BPF program into the kernel to respond to ->iomap_begin
requests instead of upcalling the fuse server itself.

For example, consider a fuse server that abstracts a large amount of
storage for use as intermediate storage by programs.  If the storage is
striped across hardware devices (e.g. RAID0 or interleaved memory
controllers) then the iomapping pattern will be completely regular but
the mappings themselves might be very small.

Performance for large IOs will suck if it is necessary to upcall the
fuse server every time we cross a mapping boundary.  The fuse server can
try to mitigate that hit by upserting mappings ahead of time, but
there's a better solution for this usecase: BPF programs.

In this case, the fuse server can compile a BPF program that will
compute the mapping data for a given request and upload the program.
This avoids the overhead of cache lookups and server upcalls.  Note that
the BPF verifier still imposes instruction count and complexity limits
on the uploaded programs.

Note that I embraced and extended some code from Joanne, but at this
point I've modified it so heavily that it's not really the original
anymore.  But she still gets credit for coming up with the idea and
engaging me in flinging prototypes around.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-bpf
---
Commits in this patchset:
 * libfuse: allow fuse servers to upload bpf code for iomap functions
 * libfuse: add kfuncs for iomap bpf programs to manage the cache
 * libfuse: make fuse_inode opaque to iomap bpf programs
---
 include/fuse_iomap_bpf.h |  263 ++++++++++++++++++++++++++++++++++++++++++++++
 include/meson.build      |    3 -
 2 files changed, 265 insertions(+), 1 deletion(-)
 create mode 100644 include/fuse_iomap_bpf.h


