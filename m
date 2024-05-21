Return-Path: <linux-fsdevel+bounces-19896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854328CB04E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 16:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FAF72812EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 14:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18612F5BF;
	Tue, 21 May 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUaUlTBc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5625812FB26;
	Tue, 21 May 2024 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301350; cv=none; b=gFoRcpxDjyXf62X5eiLxCQm7EbhfofRjFp5J/EEkqpEFKLfF1BrPueOD6w5vihEx/vzhbDyWOBJc60hjFfd6LG21E+lXI2RpOR0/3IsrjkjlaQKM9dlDT/H44fSRVWyjxpE9b4PrNtRxq2EY950JkdBVE451OqI4ukyq7ihCa6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301350; c=relaxed/simple;
	bh=m86SWA58UTFLl7ZY4hpk8foqwuUbo2R0FmBExAclAag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahxJer0bxkXvJWXTx+v1G7Ftm4g+UtGzWn0LzROG20L+0JrwWDQmJOohgfMFqUlHoTbzetRPNu5GL6ZtcBef9aPPLL2rJ7AUv/HLU0J+kiUNdkPmHL37N6FEKudOzJp3uKZaiySlxQLbcbxM/OIW/QDOiJXt1AbRA3mmXkdWkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUaUlTBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B9AC32786;
	Tue, 21 May 2024 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716301350;
	bh=m86SWA58UTFLl7ZY4hpk8foqwuUbo2R0FmBExAclAag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUaUlTBc1VsKj7bwgdrOzuFXuO7FQO9kqcKQYdZPWiNLY4zHCBaJGic5AWF9uqFtX
	 wpa34BPk0C/WRm8PlD6WBQjvZqJW0zZiWpJ01dlmRd+ItB9AFLL3nxctmGg7DAPP+z
	 JU+HPV5NYKR7b0EbJBQ6jbREle9FJHl10qJLxikL+N2qX1DrzNOimt79ZeLVX2VuAH
	 BjEpH7BAsgH9XjHYq5aX8P5SobNukH/zLHQbu3OdXxgYwanY6K0y/5kBi+ApCN/kfr
	 EKGof5/vvg8BWTe52SWmeCC78Mh8YcFEoOnAQoKoZA6mYd/T3qnDh3l7xYqne2Oaq9
	 euoh0avu0yJ9w==
From: Christian Brauner <brauner@kernel.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	jun.li@nxp.com,
	djwong@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH v5 1/2] filemap: add helper mapping_max_folio_size()
Date: Tue, 21 May 2024 16:22:09 +0200
Message-ID: <20240521-beinbruch-kabine-0f83d1eab5e6@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521114939.2541461-1-xu.yang_2@nxp.com>
References: <20240521114939.2541461-1-xu.yang_2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=brauner@kernel.org; h=from:subject:message-id; bh=m86SWA58UTFLl7ZY4hpk8foqwuUbo2R0FmBExAclAag=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT5rJMTrP3SwyFx8WJB2eu+GQvy9LmO8fv3ep0rUrt3q L48+vr2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImctGH4wzk1P2P7Q0O/7G5W 3c7LvYbPFUKF1RsMX3+IzDzas4aZh5Hh3EEB+8bbdpffvLKS6bZ0/y+clPjmwfvKjMN/JswSzTn ADwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 21 May 2024 19:49:38 +0800, Xu Yang wrote:
> Add mapping_max_folio_size() to get the maximum folio size for this
> pagecache mapping.
> 
> 

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

[1/2] filemap: add helper mapping_max_folio_size()
      https://git.kernel.org/vfs/vfs/c/0c31d63eebdd
[2/2] iomap: fault in smaller chunks for non-large folio mappings
      https://git.kernel.org/vfs/vfs/c/63ba6f07d115

