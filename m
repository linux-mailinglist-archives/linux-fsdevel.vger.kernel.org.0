Return-Path: <linux-fsdevel+bounces-59800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3230B3E138
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0250F7A1BED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A1F2494ED;
	Mon,  1 Sep 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE78woY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55A3F9C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756725206; cv=none; b=uJbeqUql8+5wglp0cE1egVkJPwBaj8E7Cw3lvY8ApeC87z5wvE0VEM+4nwquVapxh1jfebOd2N2ACgi0Hk+f1rq7wQ+TorR9BV+JCreTcUYn/d1YUrdEpWn+4D4ObH0zUHrwdcElXoDI+KXQUX5LDKueVDXZXUW4RNFZiwOy0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756725206; c=relaxed/simple;
	bh=M5SGwLiripEmlHHtXhZCjo0NlVC76/5slrggldrKaTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNy2vV6E4W5dnQuDiudxeaVb2LgY/JBOnTzmn08bqFTqrrp126kepIv8Xadf4vo7c9kNwBpZEFywQIJZ/coFvSORgeD25UsQfopcgBHksPd4uTf+gWHAdiqDuQNUfzKdtEZojgDTKCsMWvxiromHNOVNhUuLTlSBbefT/xS14us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE78woY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE9C4CEF0;
	Mon,  1 Sep 2025 11:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756725205;
	bh=M5SGwLiripEmlHHtXhZCjo0NlVC76/5slrggldrKaTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mE78woY0wYVRLtQf8io5jB5BqTN1nziy31X5LGXRs7QZ941aKrpqD/QlkJ5g/FBRX
	 ZdUzf9ENNTXKDuZVQTgFEeBcOmgLSMAInzy87cNcXRBrEHEbov813Lk+xPGoIOqhhE
	 XCZOsSONJaNS4imf4zXtVe7tjKc+4Y8fpX6dSwl91SpRNxfFnr8KwxQ5e1k+93SiNO
	 Tgdp+LKYsD8X6Z0lH1vc+DXgsslJ3uPMdyHpZPvOm9uoInDqKDLuwFB7wo2tEkkwiA
	 HwxsTUe2zxJnniWTt54o8+P4EJB57q4JjCjGHro8p0jFYcvHcCgRnWuDBoqhjafeN6
	 +wv/Ta8SLbQgw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] cramfs: Verify inode mode when loading from disk
Date: Mon,  1 Sep 2025 13:13:20 +0200
Message-ID: <20250901-rinde-sanduhr-b564b3a1a989@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <429b3ef1-13de-4310-9a8e-c2dc9a36234a@I-love.SAKURA.ne.jp>
References: <429b3ef1-13de-4310-9a8e-c2dc9a36234a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=brauner@kernel.org; h=from:subject:message-id; bh=M5SGwLiripEmlHHtXhZCjo0NlVC76/5slrggldrKaTI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRsrb+YfD2i/TjjgQqOkxs+iTRKHzIvTFmk8XTd96k7V iqdO5rF1VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRIAdGhlevPDe7ycwz2ZjP 3/6tbfk86eObjHjNBTS1wvoUXqyvnszIsDhdbPqtOvZizTcNlQ7rO3fY/Xhpt1tbQDfs8g2mOo1 +dgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sat, 30 Aug 2025 19:01:01 +0900, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from disk")
> does.
> 
> 

Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.18.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.18.misc

[1/1] cramfs: Verify inode mode when loading from disk
      https://git.kernel.org/vfs/vfs/c/7f9d34b0a7cb

