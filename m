Return-Path: <linux-fsdevel+bounces-78880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNdNNmBipWmx+wUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:11:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6051D6204
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 11:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F51630172D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 10:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547421A459;
	Mon,  2 Mar 2026 10:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld0iTfc0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A233A70A;
	Mon,  2 Mar 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446300; cv=none; b=nPu549YXIsK6jgxVochzSARXVEmZcgaDFFKB61XjZou01OB56Vt8t5S4OOFINzPcz7euPTAO0Q4u0i5INZqUZk2gbKThmXRowCa/Q+XO/xaZythWz3n/QsQoSrBxXeE4pAwmK9AwkWtTZtGla0XC5dLIcljEDnJlqS+h4aUtt5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446300; c=relaxed/simple;
	bh=kUc0farZiGjD/n/ZNvbtXOu1ZJEABLXUI1WRJsXmbXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/rAMOFtQmWwICYCJWX1z8ZmVZi9TQxFlXVYawg1t+UGd2JbYnP9zqIrUxdecPT/LcWTmqizTdl+PdtCVTQeUbCTaKtNZGEkYZz418sP8eNGsRKIkBtZsD8ugTZ8Hsz4oX7WKrx1t/GzO5Xcp60guOyxF9KZ/h7dSDEyLd3TKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld0iTfc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C359C19423;
	Mon,  2 Mar 2026 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446299;
	bh=kUc0farZiGjD/n/ZNvbtXOu1ZJEABLXUI1WRJsXmbXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ld0iTfc0cwdtiAlPMEakYAevL8IA888m/oSGOWsZW9Vt/zRCmvQ4Uc2DLU421l8Ep
	 FeEfp7BAVN3Md4S7xoDs560NSkIPqpAgGZjI8duIgTUDUN4ffC/n9jlqR9mSdh7DOK
	 i+fwYRegrrDbqO2zS5LTbG0RJJekRLaCqvE4GMYHd2g6AqdC5IbN1o6ybzmA2KYMQj
	 H8/+Z0X4Lskdq25zp26NlH+MAudrmt8Ze01H0WanxEKFuUQOsSeWHdU+ioNIsSNDJn
	 l1yOC6qj/LVeXnfey1eygn3X+LetUHp/cr/wpE8fSTUC2ZAQM12IfB/Z06v2wfSFCz
	 rcqnAPVmF3txA==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	ntfs3@lists.linux.dev,
	linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: support file system generated / verified integrity information v4
Date: Mon,  2 Mar 2026 11:11:22 +0100
Message-ID: <20260302-legehennen-musizieren-08d0e3caa674@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223132021.292832-1-hch@lst.de>
References: <20260223132021.292832-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=brauner@kernel.org; h=from:subject:message-id; bh=kUc0farZiGjD/n/ZNvbtXOu1ZJEABLXUI1WRJsXmbXM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQuTQr5LTEvM/FaGJOD/CtL7fimM5MvX52/7GFUWNlF5 gnPizyZOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyO4zhf+nviJw1/T92tyfF 9+oxcPcx3b+kpPDy0xazm+GSsTvXxDMyTOuLZW/sZO/YaLDhx4U9+x7ZqCtYeCwNmqqhk85+08S cAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78880-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.735];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D6051D6204
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 05:20:00 -0800, Christoph Hellwig wrote:
> this series adds support to generate and verify integrity information
> (aka T10 PI) in the file system, instead of the automatic below the
> covers support that is currently used.
> 
> There two reasons for this:
> 
>   a) to increase the protection enveloped.  Right now this is just a
>      minor step from the bottom of the block layer to the file system,
>      but it is required to support io_uring integrity data passthrough in
>      the file system similar to the currently existing support for block
>      devices, which will follow next.  It also allows the file system to
>      directly see the integrity error and act upon in, e.g. when using
>      RAID either integrated (as in btrfs) or by supporting reading
>      redundant copies through the block layer.
>   b) to make the PI processing more efficient.  This is primarily a
>      concern for reads, where the block layer auto PI has to schedule a
>      work item for each bio, and the file system them has to do it again
>      for bounce buffering.  Additionally the current iomap post-I/O
>      workqueue handling is a lot more efficient by supporting merging and
>      avoiding workqueue scheduling storms.
> 
> [...]

Applied to the vfs-7.1.verity branch of the vfs/vfs.git tree.
Patches in the vfs-7.1.verity branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.1.verity

[01/16] block: factor out a bio_integrity_action helper
        https://git.kernel.org/vfs/vfs/c/08163237c7be
[02/16] block: factor out a bio_integrity_setup_default helper
        https://git.kernel.org/vfs/vfs/c/32d5010c428f
[03/16] block: add a bdev_has_integrity_csum helper
        https://git.kernel.org/vfs/vfs/c/840b166bef09
[04/16] block: prepare generation / verification helpers for fs usage
        https://git.kernel.org/vfs/vfs/c/179c2a24466b
[05/16] block: make max_integrity_io_size public
        https://git.kernel.org/vfs/vfs/c/1b9353e52c31
[06/16] block: add fs_bio_integrity helpers
        https://git.kernel.org/vfs/vfs/c/e539fc923425
[07/16] block: pass a maxlen argument to bio_iov_iter_bounce
        https://git.kernel.org/vfs/vfs/c/fc9fc9482061
[08/16] iomap: refactor iomap_bio_read_folio_range
        https://git.kernel.org/vfs/vfs/c/9701407ec63e
[09/16] iomap: pass the iomap_iter to ->submit_read
        https://git.kernel.org/vfs/vfs/c/f11d7d3307f4
[10/16] iomap: only call into ->submit_read when there is a read_ctx
        https://git.kernel.org/vfs/vfs/c/46441138b832
[11/16] iomap: allow file systems to hook into buffered read bio submission
        https://git.kernel.org/vfs/vfs/c/04c2cc5bb77b
[12/16] ntfs3: remove copy and pasted iomap code
        https://git.kernel.org/vfs/vfs/c/4c3906772536
[13/16] iomap: add a bioset pointer to iomap_read_folio_ops
        https://git.kernel.org/vfs/vfs/c/c1dec831dd53
[14/16] iomap: support ioends for buffered reads
        https://git.kernel.org/vfs/vfs/c/9c617c91f801
[15/16] iomap: support T10 protection information
        https://git.kernel.org/vfs/vfs/c/fa1758bda166
[16/16] xfs: support T10 protection information
        https://git.kernel.org/vfs/vfs/c/330cc116c7a0

