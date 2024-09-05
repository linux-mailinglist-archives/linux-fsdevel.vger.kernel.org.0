Return-Path: <linux-fsdevel+bounces-28744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E2D96DCB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 16:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 414B528730D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C021990BA;
	Thu,  5 Sep 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LUPKQ7Jm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A212D198824
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Sep 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548073; cv=none; b=qu02F8MEr08ZT7Acvb7Pbc0/JV7idpDsygao65TD91N9vJvLApevZox4CUnppu1Hvy4EnXfRbB3x4AajcCxi96eDwCuhut+iAkRhICnsqn1HweAPaJFEsrZrUTmOrxR7MHHm0FoV0K9i2e+9ms9wALqGTf71FRP0jbzDWxKStXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548073; c=relaxed/simple;
	bh=V14CJcYvfPKl9Dyj1UEohkgVr1leB7mId7uDrVlxZ+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvu7vxDg+0/hwL1fjj20eFgE/CdfrJZkLLIruKlBZforJ2DbpHI+BZYxhIUe2Xng08lNPUHfag2B3HR+VrRD5FYyKOBnL2WhA3Aup1GPF+xPE2Eho5CEdozsvJjdwkDhSsBgyYtAoX4TXt0mSWMtpvf/lcj8yyI6E4yXMeefu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LUPKQ7Jm; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-194.bstnma.fios.verizon.net [173.48.102.194])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 485Erxhn004736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 10:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725548041; bh=pKlbDCE9K1sa7wnK0pbZ2MfXOKK0I1JnnQcWYxcFKjo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=LUPKQ7JmFyJ5kjiOplydNZOb5oUfbrfb+sZqHUkF9yB14PhxdHC79WG8hAsh5X1Ap
	 PRok2NVp/4k7Q+lIIpKU4lg9MfZoe0V3Bhznw90cHMcssjmjyfd2KNQDCLz815nWnU
	 pb8BpDXTG5nHDZwCaFK2qbmUTVdf/kIM+aqFC+SXTMvEAZlRj3JM2axm3ZSqfEToUk
	 wi6NU9RdKEpcnZIXcnlBSAweYJGORfk+6efm4lpU6Co6ptF9YEGsiQL6zwKoU7CeTl
	 yDDwtEBh+t90qXlIhf9j1q69Cbwxpd7IxY27GxtyRC5MnM3F+STT509k8z3cZh6n7u
	 /dt6aR0AlHjpA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id ED79E15C1D08; Thu, 05 Sep 2024 10:53:54 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v3 00/12] ext4: simplify the counting and management of delalloc reserved blocks
Date: Thu,  5 Sep 2024 10:53:49 -0400
Message-ID: <172554793830.1268668.9236864034882757675.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
References: <20240813123452.2824659-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 13 Aug 2024 20:34:40 +0800, Zhang Yi wrote:
> Changes since v2:
>  - In patch 3, update the chang log as Jan suggested.
>  - In patch 5 and 6, when moving reserved blocks count updating to
>    ext4_es_insert_extent(), chang the condition for determining quota
>    claim by passing allocation information instead of counting used
>    reserved blocks as Jan suggested.
>  - Add patch 9, drop an unused helper ext4_es_store_status().
>  - Add patch 10, make extent status type exclusive, add assertion and
>    commtents as Jan suggested.
> 
> [...]

Applied, thanks!

[01/12] ext4: factor out ext4_map_create_blocks() to allocate new blocks
        commit: 130078d020e0214809f2e13cf4fb80c646020e94
[02/12] ext4: optimize the EXT4_GET_BLOCKS_DELALLOC_RESERVE flag set
        commit: 8b8252884f2ff4d28e3ce1a825057b3ad2900c35
[03/12] ext4: don't set EXTENT_STATUS_DELAYED on allocated blocks
        commit: eba8c368c8cb9ea05c08caf3dd1a0d0b87d614dc
[04/12] ext4: let __revise_pending() return newly inserted pendings
        commit: fccd632670408ab3066712aa90cc972b18d1b617
[05/12] ext4: passing block allocation information to ext4_es_insert_extent()
        commit: f3baf33b9cae0e00fe1870abca952d5dfea53dc6
[06/12] ext4: update delalloc data reserve spcae in ext4_es_insert_extent()
        commit: c543e2429640293d9eda8c7841d4b5d5e8682826
[07/12] ext4: drop ext4_es_delayed_clu()
        commit: 6e124d5b4b02229f8aaa206b1952db31d1687523
[08/12] ext4: use ext4_map_query_blocks() in ext4_map_blocks()
        commit: 15996a848564e40a3d030ec7e4603dddb9f425b6
[09/12] ext4: drop unused ext4_es_store_status()
        commit: 3b4ba269ab6673d664d2522a0e76797a3550983f
[10/12] ext4: make extent status types exclusive
        commit: ce09036ea4f0a54e9dcd7ba644bb1db7cf2d95d4
[11/12] ext4: drop ext4_es_is_delonly()
        commit: b224b18497484eef9d2dbb3c803888a3f3a3475e
[12/12] ext4: drop all delonly descriptions
        commit: 2046657e64a11b61d5ed07e0d60befd86303125e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

