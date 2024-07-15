Return-Path: <linux-fsdevel+bounces-23682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A45C931338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 13:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C43B1F23C37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 11:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32A18A939;
	Mon, 15 Jul 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcZkYR+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E1188CAB;
	Mon, 15 Jul 2024 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043457; cv=none; b=AzkwJEjco/UqnuI45egMW9UZRd25TUEO1XizqAByQR+9+Gk14OhhlERQP4avjkC6vnhf5/o8eLO8usgvL88WqgIPvlm5tF0bp+54wL7vCNQm0SukIYB9PAqr1+NJS9UWr9t/Fizj27HzP7AHZ0dZn5ghu/nBNp76+WHjszB1y4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043457; c=relaxed/simple;
	bh=tyAZldTH+5oVW2/oSVpXIdVNSmITgWx1TexxtmkV0jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW7P30hjzbAkPLczKG2E0GaccZ7V84wTZLomtrmVxTnDDkG6n3Splg/+7JxcwlvRkHpnBRmjwrJIWr43xCMlZqCXV6R9BUT/oq5Uyf2BLWB9vkgITmnFO9RuK99KQ3OJyOBkg1qaJYZPUj3Vw4Z4xcKF+PpUG/DHJVa8OvRjZ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcZkYR+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E99C4AF0E;
	Mon, 15 Jul 2024 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721043456;
	bh=tyAZldTH+5oVW2/oSVpXIdVNSmITgWx1TexxtmkV0jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DcZkYR+yzZz/NcsML+/wHVznbzfBhksyG6VzyAUY0SLfqleTyS+qS2rTVa47BRzS1
	 ZqWijtCLx7mxZJvVmH/Bkpx79KOtqfAw89jm78+l6g6L77NmepgqOXspeuFCoHBNXJ
	 PBU1QtCbCJqh53UpYNVKsS49GjZiFIqY/Rs/f0R6xwYDXkU9PAQi9XwKofghZ9uVP5
	 St0cbQPCa73XiLl5d/27zbJYenIDr8muZxFVjytyYDaWU6lbSpO1NIjRgMcXzXxlsr
	 Gs3mtgXlGS15Vt3ioW8OqIpGZMAkQpHHMFAq2eIutrLAzx+dkJSh9llEfGstnH3OEf
	 zoit4S0HeSlJg==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	bharata@amd.com
Subject: Re: [PATCH] vfs: use RCU in ilookup
Date: Mon, 15 Jul 2024 13:37:14 +0200
Message-ID: <20240715-bundesweit-eckwerte-e5ddcae12fbc@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240715071324.265879-1-mjguzik@gmail.com>
References: <20240715071324.265879-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=brauner@kernel.org; h=from:subject:message-id; bh=tyAZldTH+5oVW2/oSVpXIdVNSmITgWx1TexxtmkV0jA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRN5Xx7Q/HRoh/yxf83JrT/FopyEb25d6PrNkHbtTOXi eq37N0xs6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiyQcZ/rsuWhbo+fLc/6/M k1wnRWz8LuM2fd03Cw5HDZf+i1UPRLQYGa7nfmw8Ep0yRWvx5IdORlamO+5e2RqUpHnwbuLNVx9 PyfABAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 15 Jul 2024 09:13:24 +0200, Mateusz Guzik wrote:
> A soft lockup in ilookup was reported when stress-testing a 512-way
> system [1] (see [2] for full context) and it was verified that not
> taking the lock shifts issues back to mm.
> 
> [1] https://lore.kernel.org/linux-mm/56865e57-c250-44da-9713-cf1404595bcc@amd.com/
> [2] https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com/
> 
> [...]

Applied to the vfs.inode.rcu branch of the vfs/vfs.git tree.
Patches in the vfs.inode.rcu branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.inode.rcu

[1/1] vfs: use RCU in ilookup
      https://git.kernel.org/vfs/vfs/c/2eae762dece6

