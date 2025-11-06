Return-Path: <linux-fsdevel+bounces-67337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90164C3C26E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 16:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCA351CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E030DEAC;
	Thu,  6 Nov 2025 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="H9HGV3CI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735A28726D
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444006; cv=none; b=AGHieyYZ6nFm15b9Uam5mL7JjPpwGfO9taz2MilvieANobEGO8br+A13PPs4pMIAFbPc+zMf4KBQ32bmCJdj7oxnWUZEkWjIMEYF6Orqwr3G6hPLtbfRWw2n48WFYPGnS7n3wQ6lN0AHqI6cv+npgkFEznhLbsXA8p71fkgYROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444006; c=relaxed/simple;
	bh=era7T+bgmXOaHf45ZTz0hBBDYUtmI/Ol51RmLNsaqYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ulRsUZE/Q87/IsRg+fTF159sEK5ZVuRaSTvhdLV0GhuHVlIz0L7h4dr82JjZV19kPrQvqK+WEvXba5W1zo5RbKekUhbizL8DZqVG2SyLrdTZHuo8EQZRzHxAffBp/qj7hAweRC07JgJecs2kZFEyhakpGAraPo+MAz9PGK2Awjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=H9HGV3CI; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A6Fjq44005528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Nov 2025 10:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762443956; bh=0eSe5mZPxrh9RS9hBZRVcgRI0dayWpReg8pEEdzuiig=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=H9HGV3CI+R/dg9eiqR4cXm8IkCU2yLDRW6qGlmuHoZkBSp4s43327v/M6fricvgbH
	 WRp+ouhmS0G6zyB8FnrrpKjNrkLuKxKSgo4aR4AJzvPNQw2VP1z6AbxI6FXUT2X/bp
	 J8btqzZWN2oDG9mWd8QOVX3CzrGiHxcJEWk7jOucIG3dxo5P37G9c6A8tov1GqJ4Qv
	 KmHmbjCcCCpVjz3KFacTVF4jfbHa06fr++kBupZnj4dnoHUbY1x3Mvv/cw0OzReSIW
	 82+7AcrpRurz5ArZOcBZBWKYYseTBP2ocTdn5lp9JoTZKsGzfQI8WnpMvToG2Sc1ev
	 aGXp0UMo31kNA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 73C382E00DB; Thu, 06 Nov 2025 10:45:52 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v4 00/12] ext4: optimize online defragment
Date: Thu,  6 Nov 2025 10:45:48 -0500
Message-ID: <176244393632.3131189.16391049442120337284.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
References: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 13 Oct 2025 09:51:16 +0800, Zhang Yi wrote:
> Changes since v3:
>  - Patch 09, preserve the error number when copying data in
>    mext_move_extent().
>  - Add review tag in patch 10 from Jan.
> Changes since v2:
>  - Rebase patches to the 6.18-5472d60c129f.
>  - Patch 02, add a TODO comment, we should optimize the increasement of
>    the extents sequence counter ext4_es_insert_extent() in the future as
>    Jan suggested.
>  - Patch 09, add a WARN_ON_ONCE if ext4_swap_extents() return
>    successfully but the swapped length is shorter than required. Also,
>    copy data if some extents have been swapped to prevent data loss.
>    Finally, fix the comment as Jan suggested.
>  - Patch 10, fix the increasement of moved_len in ext4_move_extents()
>    as Jan pointed out.
>  - Patch 11, fix potential overflow issues on the left shift as Jan
>    pointed out.
>  - Add review tag in patch 01-08,11-12 from Jan.
> Changes since v1:
>  - Fix the syzbot issues reported in v1 by adjusting the order of
>    parameter checks in mext_check_validity() in patches 07 and 08.
> 
> [...]

Applied, thanks!

[01/12] ext4: correct the checking of quota files before moving extents
        commit: a2e5a3cea4b18f6e2575acc444a5e8cce1fc8260
[02/12] ext4: introduce seq counter for the extent status entry
        commit: dd064d5101ea473d39c39ffaa8beeb8f47bbeb09
[03/12] ext4: make ext4_es_lookup_extent() pass out the extent seq counter
        commit: 7da5565cab4069b2b171dbfa7554b596a7fdf827
[04/12] ext4: pass out extent seq counter when mapping blocks
        commit: 07c440e8da8fee5b3512a5742ddc71776a0041ac
[05/12] ext4: use EXT4_B_TO_LBLK() in mext_check_arguments()
        commit: c9570b6634243cc7a55307dffd1965a3b8798591
[06/12] ext4: add mext_check_validity() to do basic check
        commit: 22218516e462d59b27ffcfc9dd75d4f98e482c51
[07/12] ext4: refactor mext_check_arguments()
        commit: 57c1df07f1ac2668a4e65796565adcbc6995f86c
[08/12] ext4: rename mext_page_mkuptodate() to mext_folio_mkuptodate()
        commit: 37cb211f97f8a0d30d7195d6c427f3233fa0271f
[09/12] ext4: introduce mext_move_extent()
        commit: 962e8a01eab95597bb571672f59ab2ec9fec342a
[10/12] ext4: switch to using the new extent movement method
        commit: 4589c4518f7c19e49ae2ba4767a86db881017793
[11/12] ext4: add large folios support for moving extents
        commit: 65097262f5ee786e649224ead2c08b7552376269
[12/12] ext4: add two trace points for moving extents
        commit: 9dbf945320b11c5865d2f550f8e972566d04d181

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

