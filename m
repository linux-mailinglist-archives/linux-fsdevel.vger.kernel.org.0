Return-Path: <linux-fsdevel+bounces-62921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E4ABA543C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 23:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AB73AD163
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 21:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D965311C31;
	Fri, 26 Sep 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Cbe/n7B3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94884311580
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758923316; cv=none; b=F9ZYSvWk/AWp0RFfreQZ7vhrUwP+qMVNI/eln7DM5o6ma1LrQzGtHV7d/n747/Iy9+uXjk9Hvm9wpXcz6myqnf5R37GQT7EXF/6kDzHT3aPQ0iHKK09HckwaV/83QgkHyMLw7ADW2uvbzIgQNLFrlZj1SAlsPiLvwDOJY7Dd2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758923316; c=relaxed/simple;
	bh=gxgZqhwH/mTgPoELIYApERxo593egAgyTQKocED8Rlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJ5LsOWmzryPjAHNVvDZgNYooJWY/sYBagxLbdJfMoO35l8kr68qF3zVuY90D2dZ5FwKnOWJBf+MMeWyo67c5c/pT2U9gL7u0bNWYqGRwEM9c4G21raSluZk+OXNVqUihXl7vRIMwV/IXVHOZJu0SSauIfsabzksqX5jhNh/Y8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Cbe/n7B3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58QLluuO014767
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 17:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1758923278; bh=4O8aGl8jnSeE+Eb9p/N1s4cwgutKvArz/nVzl2lN+WI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Cbe/n7B3SUBKwUUXouaMj7u0bvzmJNqO+ReUIDqxuHP0/6b2JlwhkSbLEHG2zOUhF
	 Hn2KiBAQGUSTU1VW0FVwNkyfeE3EYA4Tt0UPjF/dQCA7+TcJi489mLJ0DtUoR+yiD7
	 SChhd94uxmwbZaL3rLSHQQ/BkuocC/6V8XG9Vf36Z17O33PUASfqNeEOgiz3Iha+Sf
	 LgVStLlVIN9K143OLfOemSjbtv+hwPDBzbc18fZBx9EHtXXoEHAVANq/Rgue7n9ZyE
	 sKswdgmUqt9RpWdXUi9ufGV+2WLrRYY3g6a8QdUmkKyKMf/DyIL9ynF4vpxJMhFxKq
	 aw9HzjsYcfwqg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id F08532E00E5; Fri, 26 Sep 2025 17:47:53 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Yongjian Sun <sunyongjian@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        jack@suse.cz, yangerkun@huawei.com, yi.zhang@huawei.com,
        libaokun1@huawei.com, chengzhihao1@huawei.com, sunyongjian1@huawei.com
Subject: Re: [PATCH v5] ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()
Date: Fri, 26 Sep 2025 17:47:46 -0400
Message-ID: <175892300644.128029.8297502087637094289.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133024.1841027-1-sunyongjian@huaweicloud.com>
References: <20250911133024.1841027-1-sunyongjian@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 11 Sep 2025 21:30:24 +0800, Yongjian Sun wrote:
> After running a stress test combined with fault injection,
> we performed fsck -a followed by fsck -fn on the filesystem
> image. During the second pass, fsck -fn reported:
> 
> Inode 131512, end of extent exceeds allowed value
> 	(logical block 405, physical block 1180540, len 2)
> 
> [...]

Applied, thanks!

[1/1] ext4: increase i_disksize to offset + len in ext4_update_disksize_before_punch()
      commit: 9d80eaa1a1d37539224982b76c9ceeee736510b9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

