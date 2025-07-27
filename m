Return-Path: <linux-fsdevel+bounces-56109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D2EB13166
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30A5176C59
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Jul 2025 19:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3FD1FF603;
	Sun, 27 Jul 2025 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pESxtngY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63D2E3715;
	Sun, 27 Jul 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753642913; cv=none; b=vABOMsFl1IYrSfU3uEzaBcjMzerdtrqgz8bDrBf5+FNAoY8hv++ol+CT4FjmShf0mnsKiGlYfQdxHyeDY/93fwXtYJPwC4POswunYPbc+/zr9Edl2H3LFVYvnjwlfFeSsFdU8EiTm9487IgZctdczHFXy/wVeeamF8r3XmV4kWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753642913; c=relaxed/simple;
	bh=zKwEychoT1QyHVs/x1S4WKgwsM2oRH20fAyZuXchz68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjHp8JX9hLV6hCRa6fWywx9s2lmUVR3Fjd7giyNcEBOYEH0EA7x/Zd25xJw8KMw0WfjD2sQ8LTNA3cpE0fI6MkULRydigxyb7yMIGPDRJmnOiX4zzETxnBbUtpsMC03s6hg42oaCJdeflWCbAuz6sSNQNAluUcBOYLZazCQz5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pESxtngY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F034C4CEEB;
	Sun, 27 Jul 2025 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753642913;
	bh=zKwEychoT1QyHVs/x1S4WKgwsM2oRH20fAyZuXchz68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pESxtngY/t6yQ7cLYhGi8pggH+X8lgBkIJQwxFSxYxQSjUq9dygsedt/l4T75Y5/D
	 b1GHx2IYn4TQdZ7JiRvpyyhpvbvlEUcJDoCPcZuqmLBco/XDehBfKdQu2DCBpV+GCP
	 b5TIFDOrB8um8M150BopkGKnyQKdBBKoMk2fJpQg6wLGGA+ykQQDkZD/nhuXCdmCYl
	 U8xA8QpVJPbcL6i99MTn6mhItDlyg1ApDWhP4JN84rWTXywObHBr1P0NsvY0ktPJ6k
	 +/06/YNULyowqvL4ub7ynSAmg3wc78rSa8gAVZzScsvyHVZLwByIv11b4uBPtBg7mB
	 Lr16Jm2BIsYjA==
From: Chuck Lever <cel@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 0/8] nfsd/vfs: fix handling of delegated timestamp updates
Date: Sun, 27 Jul 2025 15:01:48 -0400
Message-ID: <175364288504.65253.4186795083698628174.b4-ty@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
References: <20250727-nfsd-testing-v3-0-8dc2aafb166d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On Sun, 27 Jul 2025 14:36:10 -0400, Jeff Layton wrote:
> This patchset fixes the handling of delegated timestamps in nfsd.
> 
> This posting is basically identical to the last, aside from
> splitting out one fix into a separate patch, and the addition of some
> Fixes: tags.
> 
> 
> [...]

Applied to nfsd-testing, thanks!

[1/8] nfsd: fix assignment of ia_ctime.tv_nsec on delegated mtime update
      commit: fe4f2bcb1a5ec8301af577b9373c80842212145c
[2/8] nfsd: ignore ATTR_DELEG when checking ia_valid before notify_change()
      commit: 4d619040969071a8e2fb51f66df52cc9fc25015f
[3/8] vfs: add ATTR_CTIME_SET flag
      commit: a8adc73b9ff670b77ff3e99b315a4f2c49123444
[4/8] nfsd: use ATTR_CTIME_SET for delegated ctime updates
      commit: 9c5d4468d49e0066682f473e0d4c908d904d350e
[5/8] nfsd: track original timestamps in nfs4_delegation
      commit: 3d0b3a6ab22cb233b9cc52872ba0ff2350eb9ba0
[6/8] nfsd: fix SETATTR updates for delegated timestamps
      commit: 1a64065d565d76942fd086c134de70cad3515887
[7/8] nfsd: fix timestamp updates in CB_GETATTR
      commit: 409cc8fd6365956ce0d0f14d20d1c59b4c05f5b2
[8/8] vfs: remove inode_set_ctime_deleg()
      commit: 5cca8d3d2fc34440fb73f5b8331d5228ef6d151a

--
Chuck Lever


