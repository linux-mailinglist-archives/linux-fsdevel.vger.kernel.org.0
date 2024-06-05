Return-Path: <linux-fsdevel+bounces-21055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFFC8FD1AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 032F1B28F6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592A14C619;
	Wed,  5 Jun 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1JBTobx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60AA17BCB;
	Wed,  5 Jun 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601388; cv=none; b=k2leBw3vHSYHvRcNVQDt7xjaIKeK8PLalZWAyaRI+2/MtZ62do1eMj8V39ZM7oMJV/18PoeAXWsy32ytXUKoCZHSme8gwltqK7UVVjPmOoeA3l6R6n0PNLfOwYIQQIABbTHRo9iLHPJvbuQdFvJn3cM/ADR5wvzR0PCGkHFZgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601388; c=relaxed/simple;
	bh=ZQPi/RGHTyxoioSKrwRgeAWRpLmECc6fA2ejzqKJ3jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFr/Oo2I/KEX8YLZxrDdwUqdNDdm/1KPfCqzbB5LPGyQUJ6HiQ325cHOTUNw98qLj/4M7ctAZQ/R1TaszV4aIsPOSzXM0eJ02Nu4d69ldzLz/B7iexbSyHm1McG6bdmfET8o2d1iLDu9nDuTIaIYBm514ml+/2Phg9SKriUDkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1JBTobx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12BAC2BD11;
	Wed,  5 Jun 2024 15:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717601388;
	bh=ZQPi/RGHTyxoioSKrwRgeAWRpLmECc6fA2ejzqKJ3jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1JBTobxRE7q/5mSDm4kqWxajscPKYhKDZjjJRD6gMnt5HMiwtA1hqn7LE1/7k+Uo
	 1iJftPMo1QeLcucyNcETYoaG4SOEpTOJW/Pe3YSj1hWkKx6dl3PYTRbqUYMyyaXM1o
	 3FKvaQYueLX3owT7REHqcrO6Kt324u4AosIEtUBCqiNlnTUbboQcYPXlbqtU5JW7dB
	 NHuLNTgbOWOOlb+veStWhj8FrA8xT1FZxpRqkNny3YFb+JIFzOCybhEADapJlC77H2
	 uhjSArvABsoXjC0xyhvJW0mOr6zDW8i+iT3MLsWdhKX1IdrVpl9Ku1xn3hE/qAP0Oj
	 bIRbelUag4Mbg==
From: Christian Brauner <brauner@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	linux-xfs@vger.kernel.org
Subject: Re: (subset) [PATCHv2 2/2] iomap: Optimize iomap_read_folio
Date: Wed,  5 Jun 2024 17:29:27 +0200
Message-ID: <20240605-hinnehmbar-dargeboten-259db4b80250@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
References: <cover.1715067055.git.ritesh.list@gmail.com> <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=brauner@kernel.org; h=from:subject:message-id; bh=ZQPi/RGHTyxoioSKrwRgeAWRpLmECc6fA2ejzqKJ3jU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQltKTsZzWZLbIj9nhNl8n//IzozbWxbbVbehZo9F9Ye MTsp4ZARykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETONTMybL35yi33wjXZ4xk3 dpn8/frKQPF3t4Ty62lbt4kxqrxL02H4p/nd5W/nstntDG9vBqixL9S/r5jr2BYcVbH/udSDXTN EmQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 14:25:43 +0530, Ritesh Harjani (IBM) wrote:
> iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
> within a folio separately. This makes iomap_read_folio() to call into
> ->iomap_begin() to request for extent mapping even though it might already
> have an extent which is not fully processed.
> This happens when we either have a large folio or with bs < ps. In these
> cases we can have sub blocks which can be uptodate (say for e.g. due to
> previous writes). With iomap_read_folio_iter(), this is handled more
> efficiently by not calling ->iomap_begin() call until all the sub blocks
> with the current folio are processed.
> 
> [...]

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[2/2] iomap: Optimize iomap_read_folio
      https://git.kernel.org/vfs/vfs/c/20b686c56bd0

