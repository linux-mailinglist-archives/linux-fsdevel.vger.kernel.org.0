Return-Path: <linux-fsdevel+bounces-22797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E321791C4B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F6811C227A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81C21CFD4B;
	Fri, 28 Jun 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RKbFkYnE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D31CE084
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595109; cv=none; b=Cx1kxnDhr9QDJpxRRXbuMiSbj0RQvpVGDL6PylmIPuPp50I3KHBSRaeE1DwwxzbXpsgetHrzN2Gn4uLw9GXZfoEOYamR24Ba+3lFbuGhBt+ryNcOps+2UWOmFs2J3M+aKAxt597NcgDgfbpOh2qUisqWdRa9NDwDey4BvfGry9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595109; c=relaxed/simple;
	bh=RFHiuY1hBRFafK9fzUjmZnRVOM+aQhmgEXbVxYNmDTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImRmBgCIIhhgWP8/G6/Ii2F7YscE9ajnw9C0IPiRPKLCfI5vWtTAMLG8KFqe7oYWcDnsIBI52bDQ4qTY+GI1AFtB7RqiGFh+AsQ5PwbSXLURp/aXm4w9ySjld5swwPULFWJZi5HmsUAmnZaSwWXPAddj9I3bjthgofGijH+xv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RKbFkYnE; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-120-63.bstnma.fios.verizon.net [173.48.120.63])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 45SHHtvH024131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1719595077; bh=wIjWt0UUSggE+fxOOHBDOXTXa8EsNhtHr9vWBIP/G74=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=RKbFkYnEhFwDMSNDrES8H/NamCv0POJYdED6xe9DpjPUNo5mJcoL1uhhGM7SRwIgi
	 boEzN517Eg6ptPEWO6qWVKSF1HPY4bp6ChUr2MOwUGqSS9E04RM2WX7qk7aVrxqpkr
	 aKHHYkNIOqjRmGorXe6rgT15mvrPcX4aNR6cwwnXOfFWs4YmeXIWUi6BSf2HeffU+t
	 VaIYkE92T8JSUDPh7dFbHW4xYzcJK6zC/5a6IoWJUdbeApD24DzyFrPgHLnpceCWkI
	 xmSUd/6K760EQoCRqV4+6fISzs7nOu/G3LxLxIG/NPruf9damBRar5wlCbyaP2e+fW
	 2NNY+oxz4KN8g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id DB04C15C02DA; Fri, 28 Jun 2024 13:17:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v5 00/10] ext4: support adding multi-delalloc blocks
Date: Fri, 28 Jun 2024 13:17:50 -0400
Message-ID: <171959506221.737463.10372679974958819518.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 17 May 2024 20:39:55 +0800, Zhang Yi wrote:
> Changes since v4:
>  - In patch 3, switch to check EXT4_ERROR_FS instead of
>    ext4_forced_shutdown() to prevent warning on errors=continue mode as
>    Jan suggested.
>  - In patch 8, rename ext4_da_check_clu_allocated() to
>    ext4_clu_alloc_state() and change the return value according to the
>    cluster allocation state as Jan suggested.
>  - In patch 9, do some appropriate logic changes since
>    the ext4_clu_alloc_state() has been changed in patch 8, so I remove
>    the reviewed-by tag from Jan, please take a look again.
> 
> [...]

Applied, thanks!

[01/10] ext4: factor out a common helper to query extent map
        commit: 8e4e5cdf2fdeb99445a468b6b6436ad79b9ecb30
[02/10] ext4: check the extent status again before inserting delalloc block
        commit: 0ea6560abb3bac1ffcfa4bf6b2c4d344fdc27b3c
[03/10] ext4: warn if delalloc counters are not zero on inactive
        commit: b37c907073e80016333b442c845c3acc198e570f
[04/10] ext4: trim delalloc extent
        commit: 14a210c110d1ffbef4ed56e88e3c34de04790ff8
[05/10] ext4: drop iblock parameter
        commit: bb6b18057f18e9b7f53a524721060652de151e8a
[06/10] ext4: make ext4_es_insert_delayed_block() insert multi-blocks
        commit: 12eba993b94c9186e44a01f46e38b3ab3c635f2d
[07/10] ext4: make ext4_da_reserve_space() reserve multi-clusters
        commit: 0d66b23d79c750276f791411d81a524549a64852
[08/10] ext4: factor out a helper to check the cluster allocation state
        commit: 49bf6ab4d30b7a39d86a585e0a58f6c449d2e009
[09/10] ext4: make ext4_insert_delayed_block() insert multi-blocks
        commit: 1850d76c1b781ad9c7dc3c4968fb40c1915231c0
[10/10] ext4: make ext4_da_map_blocks() buffer_head unaware
        commit: 8262fe9a902c8a7b68c8521ebe18360a9145bada

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

