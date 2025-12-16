Return-Path: <linux-fsdevel+bounces-71497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BECDBCC54E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0D95304248D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 22:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F233EB0E;
	Tue, 16 Dec 2025 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqiadpWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B11FECAB;
	Tue, 16 Dec 2025 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922941; cv=none; b=D/537MyGFczoiCLEHThnBPCzIgIvMdFBS/wxsXZmgIAUIXzBgz7GeL6B96zuhUcFemmKIxoLFoBEiFKTxV2ZiAwQ/8sBC1XsAjVfdeASBqwYWQLVKiHeGRluG1V3BTaBc8n2ODNOUpV4fKDmq59qplQ3jttJYTouS0/ivRqTYI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922941; c=relaxed/simple;
	bh=B0kVLZK7YMAGW4+NymplABFlILpQoztpjaegZ/yGPWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMpaE23jSgq9qlupeS2miimFmK2DMp1iENCB9OVblDXwaT2G1mK0a4443Ux3mriqk0VQtUypCYZLrjbMpQQMumbp33NyWkib/BgpLpFFZUCj6bOm1Rq+x/kMmJ7pI7kxteA8kCmy6I0YN5D++DRF5izOml5CbROoYUqsGYJjHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqiadpWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4509EC4CEF1;
	Tue, 16 Dec 2025 22:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765922941;
	bh=B0kVLZK7YMAGW4+NymplABFlILpQoztpjaegZ/yGPWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqiadpWDrn1VtQBdfyFy7VbAAFT/N+0QKxoy/la9xGx5fG3NMm5680qrqPz22qZtD
	 730Nc00631mF5M860GXrud+DirVS8MK0VRJURSahC1gOVM6BuWECPyT/JBCL+vTTHR
	 ANySaFterNV+lUXLbgI+r8YXLCTsj+4BuyJNK3LGYSvphQs/L5oShSzo5DruIKbDsw
	 M2Ec01YwtnmYPJ7y2JWbxiXJ1J5ndwfCfLR9yd6hMhGqoKzsqZ/GRP5mtCOsLCzOlN
	 J4KQTLdsHQL34okSpaVlrE+jMhJ41hJeBTw53maElT/xvlUJlwMFrwPOAejsH/MToP
	 PLc1BPivYW6UA==
Date: Tue, 16 Dec 2025 14:08:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux AMDGPU
 <amd-gfx@lists.freedesktop.org>, Linux DRI Development
 <dri-devel@lists.freedesktop.org>, Linux Filesystems Development
 <linux-fsdevel@vger.kernel.org>, Linux Media <linux-media@vger.kernel.org>,
 linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com, Linux
 Virtualization <virtualization@lists.linux.dev>, Linux Memory Management
 List <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>, Harry Wentland
 <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Matthew Brost
 <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, Philipp
 Stanner <phasta@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Sumit
 Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Taimur Hassan
 <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon
 Varone <Dillon.Varone@amd.com>, George Shen <george.shen@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, Cruise Hung <Cruise.Hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Dominik
 Kaszewski <dominik.kaszewski@amd.com>, David Hildenbrand
 <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>,
 "Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Alexey Skidanov <alexey.skidanov@intel.com>,
 Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet
 <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, Harry
 Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown
 <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou
 <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Lyude Paul <lyude@redhat.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Roopa Prabhu
 <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, Shaomin Deng
 <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, Jilin Yuan
 <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 00/14] Assorted kernel-doc fixes
Message-ID: <20251216140857.77cf0fb3@kernel.org>
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 18:38:48 +0700 Bagas Sanjaya wrote:
> Here are assorted kernel-doc fixes for 6.19 cycle. As the name
> implies, for the merging strategy, the patches can be taken by
> respective maintainers to appropriate fixes branches (targetting
> 6.19 of course) (e.g. for mm it will be mm-hotfixes).

Please submit just the relevant changes directly to respective
subsystems. Maintainers don't have time to sort patches for you.
You should know better.

