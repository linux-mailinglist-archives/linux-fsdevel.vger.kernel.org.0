Return-Path: <linux-fsdevel+bounces-31438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21187996956
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC2EEB27659
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F2192B85;
	Wed,  9 Oct 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah+NPHNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F991925AC;
	Wed,  9 Oct 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474988; cv=none; b=topnNIx1+465xMaKF+I2ctivrgnD4t+mutm7nlJDJnZ7TcfOqWOqGwc0QJ/iBiEkwx4YyG+NgjglEdHF3MC5pIFo7Qma7sH3wK4v6j+NcrbNxuxv5UEdBoDOOvo9AK0Zvq+ry5Lk6rlSyr5f44HQPbdxNKU0X1OWnaYtL+NVNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474988; c=relaxed/simple;
	bh=QU2Gz7IMgu47xLytuaP9hy7d2/cd7EjRuGwMRSoBSYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKG/VHYAfsjIlTcSViK5sXxy97Nou35R8u4Lo9iXj4y0A6hZl3SP2X1rVpw9FlzPYWUSy+FM/ihQBwxOTVUbtlHMmGkuincMwESQOR02urFEA6q1cDtWuTJ9lTeO3r/inF36KR9/qmwLMOVXp0og7xvy99voiMFyVMrft1AOQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah+NPHNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7BAC4CEC5;
	Wed,  9 Oct 2024 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728474987;
	bh=QU2Gz7IMgu47xLytuaP9hy7d2/cd7EjRuGwMRSoBSYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ah+NPHNiYy1Tfhpmtu2mOYXlGA60NlllcYsOLpKu+F9w+2+/NOmT6nXWLGI3sqOcJ
	 UMb3f8leDtYUvqsvAzE7TbPYOD2UCl4JBdup7iKnyGRSETKdQWQQi/7W63KRtUPUrc
	 vPs40974uYoEb6WhWrjUkeu2t/5f5VkC19EWFYRdfajVGKqPrffzfQ05GhYe9lDttn
	 2/olRleGEYiBh0CCo2ZvlvJ170sUKoUiD6ZXVs1Ok1OI9hho3XMK5tm358FiY2jWDO
	 5yYkagK97QPcbDzwRLxvZmeN0EBXqib1WqTbhbMdqOKV6EwznPrGVnx4CFXn5jZxJ4
	 /ljyKLSplU7Gg==
Date: Wed, 9 Oct 2024 13:56:20 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Joel Granados <j.granados@samsung.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/6] sysctl: prepare sysctl core for const struct
 ctl_table
Message-ID: <20241009115620.mps3n2rfkwoltgej@joelS2.panther.com>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>

On Mon, Aug 05, 2024 at 11:39:34AM +0200, Thomas Weiﬂschuh wrote:
> Adapt the internal and external APIs of the sysctl core to handle
> read-only instances of "struct ctl_table".

Finally getting around to this. Testing for this has been done on
sysctl-testing base:v6.11-rc6 and now on base:v6.12-rc2. Putting this in
sysctl-next so it will get further testing on its way to v6.13. First
patch (bugfix) will be ignored as it is already upstream.

Best

> 
> Patch 1: Bugfix for the sysctl core, the bug can be reliably triggered
>          with the series applied
> Patch 2: Trivial preparation commit for the sysctl BPF hook
> Patch 3: Adapts the internal sysctl APIs
> Patch 4: Adapts the external sysctl APIs
> Patch 5: Constifies the sysctl internal tables as proof that it works
> Patch 6: Updates scripts/const_structs.checkpatch for "struct ctl_table"
> 
> Motivation
> ==========
> 
> Moving structures containing function pointers into unmodifiable .rodata
> prevents attackers or bugs from corrupting and diverting those pointers.
> 
> Also the "struct ctl_table" exposed by the sysctl core were never meant
> to be mutated by users.
> 
> For this goal changes to both the sysctl core and "const" qualifiers for
> various sysctl APIs are necessary.
> 
> Full Process
> ============
> 
> * Drop ctl_table modifications from the sysctl core ([0], in mainline)
> * Constify arguments to ctl_table_root::{set_ownership,permissions}
>   ([1], in mainline)
> * Migrate users of "ctl_table_header::ctl_table_arg" to "const".
>   (in mainline)
> * Afterwards convert "ctl_table_header::ctl_table_arg" itself to const.
>   (in mainline)
> * Prepare helpers used to implement proc_handlers throughout the tree to
>   use "const struct ctl_table *". ([2], in mainline)
> * Afterwards switch over all proc_handlers callbacks to use
>   "const struct ctl_table *" in one commit. (in mainline)
> * Switch over the internals of the sysctl core to "const struct ctl_table *" (this series)
> * Switch include/linux/sysctl.h to "const struct ctl_table *" (this series)
> * Transition instances of "struct ctl_table" through the tree to const (to be done)
> 
> This series is meant to be applied through the sysctl tree.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
> Changes in v2:
> - Avoid spurious permanent empty tables (patch 1)
> - Link to v1: https://lore.kernel.org/r/20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net
> 
> ---
> Thomas Weiﬂschuh (6):
>       sysctl: avoid spurious permanent empty tables
>       bpf: Constify ctl_table argument of filter function
>       sysctl: move internal interfaces to const struct ctl_table
>       sysctl: allow registration of const struct ctl_table
>       sysctl: make internal ctl_tables const
>       const_structs.checkpatch: add ctl_table
> 
>  fs/proc/internal.h               |   2 +-
>  fs/proc/proc_sysctl.c            | 100 +++++++++++++++++++++------------------
>  include/linux/bpf-cgroup.h       |   2 +-
>  include/linux/sysctl.h           |  12 ++---
>  kernel/bpf/cgroup.c              |   2 +-
>  scripts/const_structs.checkpatch |   1 +
>  6 files changed, 63 insertions(+), 56 deletions(-)
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240729-sysctl-const-api-73954f3d62c1
> 
> Best regards,
> -- 
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

-- 

Joel Granados

