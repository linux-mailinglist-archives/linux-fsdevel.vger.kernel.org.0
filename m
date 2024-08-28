Return-Path: <linux-fsdevel+bounces-27558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1659625EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7501BB20FAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38E016DC31;
	Wed, 28 Aug 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnksQoqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110116BE1D;
	Wed, 28 Aug 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844158; cv=none; b=p1SwduFvTru4ebADVG/7XCFwHTTHITc+SEVXACbC5Ma4i7NwiDG9uzqp/tnCUa4TBDKzJ3JUdTRjSQWsS915BLLuC2yBY7zpCjVM2SmqBxvRohbNUzomIBd0Hk8BUfGizB/+5e6dfM2B3tznH1j/GfEXPtxonxb0oy7pQPYU574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844158; c=relaxed/simple;
	bh=Nf3PEb3R2fEBVAcqaU+NbEMYg0L6+wEFWBzFvK14wyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cN11O8yHHFYADT2qofPPa9cbdrXj7s5HcPrUct4hgzODzOZvQqQ8EWP9sqp4SwVlwqILovIihEPahLWu3cv14g0h5Ra+E0e4+sl+gaYM7ldVtNehrz6jniY++WP1HaHhVu//fntV7RVnyPXGZ/Uf/Io6ucQLu/YCckzhAIK9Us0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnksQoqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3164AC98EC1;
	Wed, 28 Aug 2024 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724844157;
	bh=Nf3PEb3R2fEBVAcqaU+NbEMYg0L6+wEFWBzFvK14wyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CnksQoqoxVFIKKsZi0byoMoAlvfMilDr9GmU3TSdrR57167Ow0qcTcOBIwCBpiEiF
	 9A5RVEWTfgtnYs2iehI43J2kFfJtBS/TtIS862NDTN+2JE2R+cM1Kb6yGHuEUh1oIg
	 jVdhJBw1rO7fc0n8zuqaLsggnHa8JajsE1vzY9du9y3EEnqJ4ZqE0HRbmuvKHFBq+y
	 OYssINTq1TTl8zzHUx02vK9gWvdvaA0AHrA7gTYIii8fWVZsVdHOrNT5BbndKD5k17
	 RFVkHMwJiY+n7CFkjc8bok6sb7NmP3E6Mm+49dN8Kx2mTA3z+LtD+76+sFoSMGSG1E
	 wUrew8yfxFgBg==
From: Christian Brauner <brauner@kernel.org>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	libaokun@huaweicloud.com
Cc: Christian Brauner <brauner@kernel.org>,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
Date: Wed, 28 Aug 2024 13:22:25 +0200
Message-ID: <20240828-fuhren-platzen-fc6210881103@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826113404.3214786-1-libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=brauner@kernel.org; h=from:subject:message-id; bh=Nf3PEb3R2fEBVAcqaU+NbEMYg0L6+wEFWBzFvK14wyk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSd5yj+XHu7QM5zVi/D7FsC/Qyf+y9GKRm3KrjPrIutv Lme48ftjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInkiTEyTEn+oXj92MfjrwUr pv1YM5Mn7ZDOv4Lsd/FtT7nFrvDF3WJkeKOWkj2/ae92kcK+YOc572qO/CuuM7y5rFjuQ1LzpMX crAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 26 Aug 2024 19:34:04 +0800, libaokun@huaweicloud.com wrote:
> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs',
> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> deleting its subtree. This triggers the following WARNING:
> 
> ==================================================================
> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at least 'requests'
> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x160/0x1c0
> Modules linked in: netfs(-)
> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> RIP: 0010:remove_proc_entry+0x160/0x1c0
> Call Trace:
>  <TASK>
>  netfs_exit+0x12/0x620 [netfs]
>  __do_sys_delete_module.isra.0+0x14c/0x2e0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> [...]

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

[1/1] netfs: Delete subtree of 'fs/netfs' when netfs module exits
      https://git.kernel.org/vfs/vfs/c/0aef59b3eabb

