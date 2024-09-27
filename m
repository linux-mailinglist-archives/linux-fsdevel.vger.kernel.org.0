Return-Path: <linux-fsdevel+bounces-30242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592E988349
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 13:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0E8281365
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9670189909;
	Fri, 27 Sep 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGTSznEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AE188CA8
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436431; cv=none; b=eI4JREu4nUx9mvKNl7Ic2R8EpUgHvY6RQ8EZpdYoEZzWtYrlxIc2b7nIdnNWIU37NqU9MnAp141XhP7DNvVgTYrTSjFs5o+dpwEOQ2i/jfya//eikEweGxdOa7I2knG5pft8Vf45A4gK9LgkkUsPSgX3A5NHe4ormFWZbW+JEkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436431; c=relaxed/simple;
	bh=S5VTyUkNaRGFGvv8OSg0WlPkUVDHtifzA3PJbFFkMDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fh28uyLi+ZVd1FyRkLEs7sq1NLT6ZAEAp37BuHdlqz6Mc8iOEqNZHShm8F1tQswkz5gSfE+QsOLt1FlDjVAHu0btQp0n8wXeuNzuHa1LbjYnrWzU2veU2/7hcSKTAttPCmHkgPnpYfZLaKwTLcEhSybtBPoB6ZeK7beEHa2hyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGTSznEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA378C4CEC4;
	Fri, 27 Sep 2024 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727436430;
	bh=S5VTyUkNaRGFGvv8OSg0WlPkUVDHtifzA3PJbFFkMDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGTSznEqbNJU7FWhJRpvEinVO+8yJSzH4VxRq4Q+SSTWTtq7IPOpi+a/wHmGI87a7
	 ET+Sw9FVydyU5OjBq1Wcca2lsOJhZjMNtqbPdAXieQqk7iNB7AtfazzXTX+4it/fkv
	 uynyQkfxKc6jrOXTG/Apt/8sUe5++3ztSdj1bWopeWXo4kL3Of1bqA1iph1bWVH7op
	 OjCXzTZeeN/zAFNteHrrMYFnsQfnj5BD3a4QpqsU7eFzjh9gkmAWlP1E6fp6kn//cx
	 n2eBYr+HI8etspnRzE2A6zoo57BqyyROjZXtEXcF8tW3HbRiamPAe7gJvGlTXZ6YiX
	 72d8IH5RqIZpA==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Julian Sun <sunjunchao2870@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	hch@lst.de
Subject: Re: [PATCH v2] vfs: return -EOVERFLOW in generic_remap_checks() when overflow check fails
Date: Fri, 27 Sep 2024 13:27:01 +0200
Message-ID: <20240927-eilte-willkommen-36601271c983@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927065325.2628648-1-sunjunchao2870@gmail.com>
References: <20240927065325.2628648-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=brauner@kernel.org; h=from:subject:message-id; bh=S5VTyUkNaRGFGvv8OSg0WlPkUVDHtifzA3PJbFFkMDQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9m9b+cvbJlHSdvZptQlJbN7hwOb2Y6tOg3sZ5c2/Nu fN98X1LO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSto7hn57SlQuNt/OCt9md mPG/8MZcnsqIfKeM7X6Rk0PXCjLVlzAyXNo7TfZx5iGtIvcziW5HWHyO6/rmma44EPZ7/68fZbz FjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 27 Sep 2024 14:53:25 +0800, Julian Sun wrote:
> Keep the errno value consistent with the equivalent check in
> generic_copy_file_checks() that returns -EOVERFLOW, which feels like the
> more appropriate value to return compared to the overly generic -EINVAL.
> 
> 

Applied to the vfs.misc.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.misc.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc.v6.13

[1/1] vfs: return -EOVERFLOW in generic_remap_checks() when overflow check fails
      https://git.kernel.org/vfs/vfs/c/53070eb468a2

