Return-Path: <linux-fsdevel+bounces-63754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6838BCCCD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 13:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7546424B15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DD1286891;
	Fri, 10 Oct 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bradb5iq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257C1494CC;
	Fri, 10 Oct 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760096830; cv=none; b=nPg7nlAF532Z4EaF5J8Dny2F82L311N7RhFcsskLpU/ODDGoqIBFOJCYLIyG2mdtBsuVoIZaZjYMEbbUJ/dyGk4REaDnoJXXh4a15ELUELnsOatyjVTafavzlzaWCPp5rt9b81V8R/jKOilTthUbRSZ9SCzV+W2EdFNsrh9Rlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760096830; c=relaxed/simple;
	bh=UPc3PX96ujolrFCKeAov5/QZ+6RJEXmIxdbgi70aPlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHaNrv/Br+NQiHau7AdZU2Kz0PU2sD+lkQzlLyLg1jrEWMlGRtt5EHxn/Yk5xyRUehCsU9hlBmRSvQY3ACMVPKbK2rFCTgFqANobJMhBWdEsysChmCFSsWvwfMIJ1W/cUal91qN6noEJpr8st80SWJ4Rw9x6YeRqeohpJ04Fg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bradb5iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB9BC4CEF1;
	Fri, 10 Oct 2025 11:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760096826;
	bh=UPc3PX96ujolrFCKeAov5/QZ+6RJEXmIxdbgi70aPlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bradb5iqgfvTuj0qhTn70qVQBCSzaEM7aMRf/JdDcbE6u9pUyPhlVplCSPzCq4P80
	 ba8EpEyZUIQxAntR97mNKBavq+feo39IrLilZZuayH5DPoeGXnyfmQe/B55e9gBT4J
	 H4jyWVQszaglsLbPq9AUXZpybRTCVNC22nAOLuf/pvbkBr02qFyuQFq7u7fb+hjCRf
	 lCmpANIPb98Jv3wI4zsd8Wj7klI8a90qNGs7oTSnOXEsMq3LWSpYyrOBnogMGLxFcn
	 QcEyDT/G/9LHuld68XV6/qM3/YbseRcrWsN+yOT2Z5s6iQIBfAnsNKv1Fk5Y6nIDtj
	 U6mi2QR9ZE7uA==
From: Christian Brauner <brauner@kernel.org>
To: linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 0/2] Fix to EOPNOTSUPP double conversion in ioctl_setflags()
Date: Fri, 10 Oct 2025 13:47:00 +0200
Message-ID: <20251010-frosch-erstklassig-b8ff59fe2c78@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=brauner@kernel.org; h=from:subject:message-id; bh=UPc3PX96ujolrFCKeAov5/QZ+6RJEXmIxdbgi70aPlc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS8+GRawjrf3yD3YtYuYYbKg7ZaE1gMf67ujOzel3mFZ cKlHfmfO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZi+pmRock1efYkhzx7qW1P Pm407inuq2zs25R7ZL7LdK7eif0VDgz/LOfU2t2KWLOcPVu1KflMlz7jAU3BfdfVk42rE7vaw6d yAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 08 Oct 2025 14:44:16 +0200, Andrey Albershteyn wrote:
> Revert original double conversion patch from ENOIOCTLCMD to EOPNOSUPP for
> vfs_fileattr_get and vfs_fileattr_set. Instead, convert ENOIOCTLCMD only
> where necessary.
> 
> To: linux-api@vger.kernel.org
> To: linux-fsdevel@vger.kernel.org
> To: linux-kernel@vger.kernel.org
> To: linux-xfs@vger.kernel.org,
> Cc: "Jan Kara" <jack@suse.cz>
> Cc: "Jiri Slaby" <jirislaby@kernel.org>
> Cc: "Christian Brauner" <brauner@kernel.org>
> Cc: "Arnd Bergmann" <arnd@arndb.de>
> 
> [...]

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

[1/2] Revert "fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP"
      https://git.kernel.org/vfs/vfs/c/4dd5b5ac089b
[2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls
      https://git.kernel.org/vfs/vfs/c/d90ad28e8aa4

