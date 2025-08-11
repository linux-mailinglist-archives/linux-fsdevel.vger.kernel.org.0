Return-Path: <linux-fsdevel+bounces-57311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973FFB2072F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35C42A308C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACAA2C0303;
	Mon, 11 Aug 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CjQtsYYR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F94F2C08B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910868; cv=none; b=PPFVoD8PIjVeW0j2OSDOR756gQ6bgOpTv5qMDpXuKmE3E3UxtbfYBGOEh0vqkpTpmudrAiv5q6L+pWB/wWJr/0KbJhSljoYynz/eH5XOl3FHdQ1Ujf/rCC+LCGkt0xSl6J393GL3Z0wjA2Wp1ARJGzuqoVoXshyDqBj53FbY4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910868; c=relaxed/simple;
	bh=KAs5jOZENA+23HRC30nHOmdO4LP+gU6V2ANPivN/B7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdxDf3gfTbWb/hs1G05qPurIg6cqe35imyvKJqR/gLB2CQ9pWeLLzBh2S8hl5Q0Y07cc9MQcYQT5b84/Dqnzg3W72EekFZpwWjvyxPP+9H3wIg6HjXkJmHuDstPlXfeXBZVpM/l0mr7eoyfQ/kHE8dp71zzYC/YgAL1/01f2CNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CjQtsYYR; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-121.bstnma.fios.verizon.net [173.48.111.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57BBDaM5029819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 07:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1754910820; bh=yHFvHo6R+wyvHhllEY32hSJMp83zXaOzd29KX8MLnHU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CjQtsYYRB4hjhMsFcG4MM7KsFeE/ne0VzdfIAZXYral+rbBfboazdcrCorY8copyA
	 /9lJZwoxtASPD5sZV/SlFnG6XNbOiqjpEOjxnUW4WC9tSdT+NEKtkNGueJ88vuAblh
	 I4eTexci9aW1BAwDNmf+Bq+UIQ/aP1lNsAJjqA8yMgP8eB0ohGD81Flq1zMxVV+jzo
	 I0ZJ7vxAzqqNcJHLA6hm8X0UNbnhbZf0TsJCflzsu260J6EIuQJfOxbCCno0TBO9aE
	 7uKTEs5qw7kfPPGMDMZp+/zOHXpj9Budfyg1vGCowkZgTDvwzSZcjPq6YgIr3c+YRm
	 FJplTrp1n8j2A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 525CB2E00D6; Mon, 11 Aug 2025 07:13:36 -0400 (EDT)
Date: Mon, 11 Aug 2025 07:13:36 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mtd@lists.infradead.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 03/13] ext4: move crypt info pointer to fs-specific
 part of inode
Message-ID: <20250811111336.GB984814@mit.edu>
References: <20250810075706.172910-1-ebiggers@kernel.org>
 <20250810075706.172910-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810075706.172910-4-ebiggers@kernel.org>

On Sun, Aug 10, 2025 at 12:56:56AM -0700, Eric Biggers wrote:
> Move the fscrypt_inode_info pointer into the filesystem-specific part of
> the inode by adding the field ext4_inode_info::i_crypt_info and
> configuring fscrypt_operations::inode_info_offs accordingly.
> 
> This is a prerequisite for a later commit that removes
> inode::i_crypt_info, saving memory and improving cache efficiency with
> filesystems that don't support fscrypt.
> 
> Co-developed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>

