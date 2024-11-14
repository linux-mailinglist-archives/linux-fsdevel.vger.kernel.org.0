Return-Path: <linux-fsdevel+bounces-34751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 064339C8662
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08602834C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3101F76B8;
	Thu, 14 Nov 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEKPVv3x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B811F7552;
	Thu, 14 Nov 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731577504; cv=none; b=MP93/XWXRMT1zX8o5iQW4dKrzYtYJGxEcqgBW0lxhRQYBYEb2t9J1WF2D3eHIwfqnXgmoFR/c4FnCQJznmdx1u5Wj7PWYD4rfCiSNKxRIyS87QrsKB9SFml/1Fd/OXpOQ5T+w39UvCafiZQCSbCyO5SPfbEGUBQ7qVgHG6xVxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731577504; c=relaxed/simple;
	bh=Z3lY4e6SI7ivs04EJKJ13LELMAZCv79Dut7em/b1SuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAcW95lYc26/MJabxvhDpSJ2gDWXbnbCZcvvtYA6bKhHPdgXBYPvr1zmcYLnG5OYILtgtPH7Cgo6BLke+YY7Q+SPjXTcXDP43SKrn59jUq7gnQAcTGTLSptUn9SuSPmAaScSeykWaR5nzcMUOdbHhifBkvjIqvAvDEI8ttEVSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEKPVv3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BADEC4CECD;
	Thu, 14 Nov 2024 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731577503;
	bh=Z3lY4e6SI7ivs04EJKJ13LELMAZCv79Dut7em/b1SuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEKPVv3xfvRxAw0Z32Mjp2eezdc/hWCqRAETckrfLzXXnLAh1Dcre1XN224onlGCp
	 73squVI9OOXwqOmfYNobfRMwmtwuHF9kSHn2ry+hkV9znp9LmF9qCMYX8/S6NlJfJ6
	 Jj6M0kx8kI05XEGpdwNIVKs2c0DFM5MlUEHtcLsQJfWfRfVyNr8vc9DRYidCK7G6wz
	 eznc4knKbzjWgJDSHv8vE+fGXeWs6CuEn9O3B3+nu+wyUvn7ei67eKcXruAs2Mw6Mg
	 lfBYLqZMYpc42pglTvhpt2W7sazZ+WTcI0qgZ0LOLGQ9yA8sR1IMSUi4AQ9qo2oeti
	 X1ca29xd2Ri3w==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: make evict() use smp_mb__after_spinlock instead of smp_mb
Date: Thu, 14 Nov 2024 10:44:52 +0100
Message-ID: <20241114-erobern-knipsen-651aade0e443@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113155103.4194099-1-mjguzik@gmail.com>
References: <20241113155103.4194099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=brauner@kernel.org; h=from:subject:message-id; bh=Z3lY4e6SI7ivs04EJKJ13LELMAZCv79Dut7em/b1SuY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbHpve0quQFP9R30Hs4s3HOo4l666EPF+g4atxJPzBR Ikd76/FdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEYg3DX9EnGnpeF31+nen9 9Ke+NONmg9PauVEuDn7aqhVdulf+/mZkuJ9odqTj17O3TBn1C9Rqtv67Or2m8cGN9N92W5R95sa s5AYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 13 Nov 2024 16:51:03 +0100, Mateusz Guzik wrote:
> It literally directly follows a spin_lock() call.
> 
> This whacks an explicit barrier on x86-64.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] vfs: make evict() use smp_mb__after_spinlock instead of smp_mb
      https://git.kernel.org/vfs/vfs/c/45c9faf50665

