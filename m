Return-Path: <linux-fsdevel+bounces-75277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIoPMYxpc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:29:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4343475CB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 860B7311728D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16DA2FE048;
	Fri, 23 Jan 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1bx+21x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC3315D23;
	Fri, 23 Jan 2026 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171062; cv=none; b=aVK8PJXwaksUa1Mes0EiKOjcH0tW2cNJOK9UbneGd77kTs9IBuR4LjBO4f0MePQnZyalqDUU3Dsaj7xeKIwN5t+Hq7NUw/WdbEdc13a/rBr8xJOSMEC344Q2ujh2hplxKuKfZBOMKnosFar0Y81m7xT1rzF9KMUBYRf0MWdnuwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171062; c=relaxed/simple;
	bh=W2XSh+Nbw4vAqglqhq0i1BW+lu3gtSY6MoT63KQVZB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qa8xbPn3vrNOSGaV3hNSNgIa0lT970goH7Oa8KrJMroi7sgl/alyR6yUx0JHMU1mjLGTcM0OVeyTU5ikSJTQOMi4ZNWJfBKTVPzD/wAHz9x+5D4PPLCu61732Jtotx5BQYOIp3NBKRViPZE3RVDHXtjgUVkeBEw2kGru2pv0n5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1bx+21x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B149C4CEF1;
	Fri, 23 Jan 2026 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769171061;
	bh=W2XSh+Nbw4vAqglqhq0i1BW+lu3gtSY6MoT63KQVZB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T1bx+21xBzXJ3pJKe+G+TtpjA7o1BY8a4dDkOtOzqiBkO1eHDhwwkeW0rX+EwYqKi
	 LtDFc3L+gAtQcEey8Z2gNgmqHNUuaFWnZDDPc5KOK177WZFCqpWACk4nImXsZ73SzX
	 6nMriqw/kEFhT7WCuAHiD1gsBsOQtQhjyf/GvxTfBZ3euGwYtMnfvxOvenaUDJl+mt
	 h4nPe7ioQRVTcNCnhUiLTjjFhca0tfsKZ8KHrQ84gNAWG0uWqXxOZbwAvJkCs2vO/S
	 mLP2He9UN0IOUqhl8lAiUo3wfKyGNfN3Si9OD9y/xI3lxORv2FmEQWr6N6W5IMFzAH
	 F8wP0yrwRNvAw==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Qu Wenruo <wqu@suse.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: bounce buffer direct I/O when stable pages are required v2
Date: Fri, 23 Jan 2026 13:24:08 +0100
Message-ID: <20260123-zuerst-viadukt-b61b8db7f1c5@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119074425.4005867-1-hch@lst.de>
References: <20260119074425.4005867-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2759; i=brauner@kernel.org; h=from:subject:message-id; bh=W2XSh+Nbw4vAqglqhq0i1BW+lu3gtSY6MoT63KQVZB0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWZxRY3ePafVBsB2OBIN/hJ9/ur9dVc9yysWz+Oh9W1 5bgtzN4OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSVs3IsPgM75rA9iPyd5n9 eW5UbE4+tCmhZ+fCkK6oGae6Zl+L+8zwz9aOwfS9uvNOyY/s11a8Nlu4TPlxa4NFS/LEv9smx7K u5gAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75277-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4343475CB5
X-Rspamd-Action: no action

On Mon, 19 Jan 2026 08:44:07 +0100, Christoph Hellwig wrote:
> this series tries to address the problem that under I/O pages can be
> modified during direct I/O, even when the device or file system require
> stable pages during I/O to calculate checksums, parity or data
> operations.  It does so by adding block layer helpers to bounce buffer
> an iov_iter into a bio, then wires that up in iomap and ultimately
> XFS.
> 
> [...]

Applied to the vfs-7.0.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.iomap

[01/14] block: refactor get_contig_folio_len
        https://git.kernel.org/vfs/vfs/c/81b30a454966
[02/14] block: open code bio_add_page and fix handling of mismatching P2P ranges
        https://git.kernel.org/vfs/vfs/c/447ca020a401
[03/14] iov_iter: extract a iov_iter_extract_bvecs helper from bio code
        https://git.kernel.org/vfs/vfs/c/1f0b577cd289
[04/14] block: remove bio_release_page
        https://git.kernel.org/vfs/vfs/c/8422e6bde5c1
[05/14] block: add helpers to bounce buffer an iov_iter into bios
        https://git.kernel.org/vfs/vfs/c/cec1a583be7b
[06/14] iomap: fix submission side handling of completion side errors
        https://git.kernel.org/vfs/vfs/c/006966526be1
[07/14] iomap: simplify iomap_dio_bio_iter
        https://git.kernel.org/vfs/vfs/c/87226227f1bc
[08/14] iomap: split out the per-bio logic from iomap_dio_bio_iter
        https://git.kernel.org/vfs/vfs/c/d9e65abb3c1b
[09/14] iomap: share code between iomap_dio_bio_end_io and iomap_finish_ioend_direct
        https://git.kernel.org/vfs/vfs/c/eb1620aac3ed
[10/14] iomap: free the bio before completing the dio
        https://git.kernel.org/vfs/vfs/c/dd6c37c1e1bf
[11/14] iomap: rename IOMAP_DIO_DIRTY to IOMAP_DIO_USER_BACKED
        https://git.kernel.org/vfs/vfs/c/ee377c08560c
[12/14] iomap: support ioends for direct reads
        https://git.kernel.org/vfs/vfs/c/3bcca2b5d53b
[13/14] iomap: add a flag to bounce buffer direct I/O
        https://git.kernel.org/vfs/vfs/c/dcc3a3452079
[14/14] xfs: use bounce buffering direct I/O when the device requires stable pages
        https://git.kernel.org/vfs/vfs/c/387bea142297

