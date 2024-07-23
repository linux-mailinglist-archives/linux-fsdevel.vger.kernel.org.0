Return-Path: <linux-fsdevel+bounces-24145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F0693A3D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6911284397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9AC15746B;
	Tue, 23 Jul 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm1exe1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02754155A52;
	Tue, 23 Jul 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749316; cv=none; b=eL9vIg5CAFcyaN2HF5chXvrji/RI14oiybTcIiiBUmIZ8VUH2CnryUOa3H/0ZTB2cciZLC0C84+HuFcFaZCtl3KgBVT0sAd4BVKgiDiKhexWUa8RUeaVlABbU+a8UsmSLXL4IM/U9AuwSsNY83xEgB8QiSdmw3mU/ZDqOpQr6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749316; c=relaxed/simple;
	bh=ZcoBl5D3JOITgJtAz7bCJ479P4um3u+bY4a95Jq8O/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5okoXzEzALDInkca/sfwKFaiuAR7VYnSZclYTRz0cTcUZr86M+OwZtx89aKDpzhlIECfU8bAQ/socsMuR4JMW+dvjPbEIYdJUH2zOy/TcXWlaoaPP25YPT6YHjXBVqXja5fNcQmkfvUHQ8C/1D9qno6RxhqBgQB7FSfHyhZG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm1exe1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C053FC4AF0A;
	Tue, 23 Jul 2024 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749315;
	bh=ZcoBl5D3JOITgJtAz7bCJ479P4um3u+bY4a95Jq8O/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gm1exe1rqUviSstwHA3bHOt8qHAKeagvxGtjZAt7J1+HizKlBQ0IFIDoa6RZ3RWQz
	 B+Z9ArRlTZ4pWlc9XQ+JFQxMYChAA9iu6ETmOhD1pdOcc/16UwxeJv34N9LUEBS+TW
	 IGW9KVKpPfN9tzutQkWHemL1XWaeoI0FZCZflJ4i6vRwzxI6CnBxa83Sn7/Z2FAOWz
	 2FGm6/b+tY1A7ZnXd73uq2DD+wDQt9/CMnOXWml62BHneMwvDBbOKNbfwtHowbS15V
	 ag82xrXVR1aGOkqruH9ojOqiUmIllC0XTGklEujcd1FFc6F9DywHuvQHw+8P8U1bkX
	 ywaU/YDfMwaPA==
From: Christian Brauner <brauner@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] filelock: Fix fcntl/close race recovery compat path
Date: Tue, 23 Jul 2024 17:41:46 +0200
Message-ID: <20240723-geowissenschaften-abbuchung-1c2797475260@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com>
References: <20240723-fs-lock-recover-compatfix-v1-1-148096719529@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=brauner@kernel.org; h=from:subject:message-id; bh=ZcoBl5D3JOITgJtAz7bCJ479P4um3u+bY4a95Jq8O/0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNP29l/5KJ70LU3Mdz5ryduInlx8Fn+gf9W7aLXQi4F a/uoCuX3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARtkiG/6GbK5eZykiYlj71 qneyVZXpXPnjxrKVuzS/vhMy2aj9056RobfIwnHrXGFzE5NaR93LrZudQn8pN1zfo61lci/G798 MHgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Jul 2024 17:03:56 +0200, Jann Horn wrote:
> When I wrote commit 3cad1bc01041 ("filelock: Remove locks reliably when
> fcntl/close race is detected"), I missed that there are two copies of the
> code I was patching: The normal version, and the version for 64-bit offsets
> on 32-bit kernels.
> Thanks to Greg KH for stumbling over this while doing the stable
> backport...
> 
> [...]

Thanks for fixing the compat path as well!

---

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

[1/1] filelock: Fix fcntl/close race recovery compat path
      https://git.kernel.org/vfs/vfs/c/4bc443404754

