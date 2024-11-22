Return-Path: <linux-fsdevel+bounces-35559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170169D5DC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC9FB23C8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5C91DE8A7;
	Fri, 22 Nov 2024 11:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgUYo7eJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C6B1D7996;
	Fri, 22 Nov 2024 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273757; cv=none; b=SWXXHSva27BwJtrvdVmL4UmzHksdZzOx+jQOTzVyBCMmeeFyKdFe7SPaRDCwRx7bH0jJwQtafmULHFBUB1yej5Wjx7EYdN6cBDsVZ0o84l+/RvjIr785OfkvlUJ5M2KTENfcZP6zA5JpJBgcOwQWi/ebywUtBeRD3sjDaOFcZ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273757; c=relaxed/simple;
	bh=lUDhyZnVTG7iOGzpUYujxykIMPrQoxJzf/DztzKQWf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+kMPhttZc7hiJZxcktiiIb6TgNRgOEqIZ13N5E8qPTrMSFm2qoXbHRon6NMPJlSZEwq1RC1TquqcLXJgbHNM039I5do5xKYj5iu9ToKxfsh6XIXIRgjSKg1rtTVaOrUM1pbsUggfwkD/pkz+etGi39ZE+3MsYvBXiRpaekSxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgUYo7eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14B3C4CECE;
	Fri, 22 Nov 2024 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732273756;
	bh=lUDhyZnVTG7iOGzpUYujxykIMPrQoxJzf/DztzKQWf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GgUYo7eJnS1F01x8QPUjbxbFXSj/bk81a2//CGx0Fok+5g5K8DNnS5Hs6jP1hUO4j
	 e+qku7yiO1f5NYrkUcT/SyG9hvvS+1ibUzixYa6xamMiBIj7s7vXfN4jG0hbFoDhxY
	 edzu9oAxbHutO7zplLFQorl2sZSL6cBkmnSZ18YxZWpRUSTYRbBYD0inVis/E+JcB0
	 Y4DbLLrGt/tp7beegvarSsgF7JgK4VhR3I20blKmEpuwF1XPTycN6DL3JHfxyPbKfn
	 pWg2wXgp6p3A6V0u7FmIOeodJNRKTGxhUTuiWIECrUjwY/4WvotJC4k6PF+KkibH2M
	 P3PXgOhChgIMw==
From: Christian Brauner <brauner@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	stable@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero
Date: Fri, 22 Nov 2024 12:09:09 +0100
Message-ID: <20241122-sammeln-optik-ebfb9726d030@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121231118.3212000-1-jolsa@kernel.org>
References: <20241121231118.3212000-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=brauner@kernel.org; h=from:subject:message-id; bh=lUDhyZnVTG7iOGzpUYujxykIMPrQoxJzf/DztzKQWf4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7pIU1yf4WbT265scBndjCa0EmvMukn7Ycu50YNmml5 d1bOmGRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZEM7wzzSfzyvaPj/s58Zr xetXdr6/+ci9aFKRm2jgfFl3Vv0bBYwMH8VZHp54vo4pflH5KVU1gyjBxv2c/p6rbKYnnay80eT HAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 22 Nov 2024 00:11:18 +0100, Jiri Olsa wrote:
> If iov_iter_zero succeeds after failed copy_from_kernel_nofault,
> we need to reset the ret value to zero otherwise it will be returned
> as final return value of read_kcore_iter.
> 
> This fixes objdump -d dump over /proc/kcore for me.
> 
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero
      https://git.kernel.org/vfs/vfs/c/088f294609d8

