Return-Path: <linux-fsdevel+bounces-22489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA479180DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 14:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7AA28BC8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 12:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E718181CE0;
	Wed, 26 Jun 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEfFxai0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFA13D89B;
	Wed, 26 Jun 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404411; cv=none; b=Ro6AmNkPAPJFU1JLEb2O27hoyO6cpWHFCsIyImKQXb267rBswF6rrwCcc0p1cs5ub+gyQ+R1xTijJ3vboRTvl0/bP66e6Ar+srMRS3ATepRrNsC7lHCvRl6Iqppte1AIU0Oyq1/4cxLeX8tu9UhrjwfQoPxEE/g/GgC9071Qxqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404411; c=relaxed/simple;
	bh=qh1CC8/TG0M3ZkLLHN/ok2FTcUZmPX1MDXFCjPnlN8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rok5rL7mXhQFP2W+EpBjV6nIAcUlHVgFEWb65tRMKHt/968iUWFjCAKRkWSoY6fN1OWi+//W/pDGEQWI9+LKNfIjIIEzr8r2EuWlR03lj90rBlxleDYW25K8bmJa0NFZ4w/2Z4ivRa9I2pemySyZBiNILJssUYj3WWFqx8Biv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEfFxai0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDCAC2BD10;
	Wed, 26 Jun 2024 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719404411;
	bh=qh1CC8/TG0M3ZkLLHN/ok2FTcUZmPX1MDXFCjPnlN8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEfFxai0d3lLGbVSvxt7yqUt49GscgqKT2P6AP0kGxfkPlzY6UNO7IrmnQxSlZqoz
	 eHrENsIhCNSspA8sIxKynpL5w2wQmxCsaygXUX4lU4oFgh0PgHsoNkv4l2HA+Rzkjn
	 HWIL5hoSKQlpx7v+pd9VmDvdoISqEqEfBWCdlYhdkqwCP2jwhgJB+k4xK8NPO2OhvO
	 3OE9IxfYkquXupYtMI98JRS1xYCI1MdJuaQyGfmNDmPdN4dP8kVTK5zF77ZbEjEs5U
	 MZEbiLNMtQMPzNLxKfhtvk4mPH6KVCAs8lgpjxT9PU9VxAH34ex6PxETw7wZyLamCt
	 hRnYHoSjd6hpA==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev,
	v9fs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait
Date: Wed, 26 Jun 2024 14:20:02 +0200
Message-ID: <20240626-wippen-total-5deff480eac7@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <614300.1719228243@warthog.procyon.org.uk>
References: <614300.1719228243@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=brauner@kernel.org; h=from:subject:message-id; bh=qh1CC8/TG0M3ZkLLHN/ok2FTcUZmPX1MDXFCjPnlN8s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTVsBc/0KoTzY53/ufsuPBUX4x9fHQQR/iHAM31JzYXT tZcVrSvo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLG8xkZrmy3euG8J7jqN5Nv f//Dp+HX2Zc87HzEFfw9/6/zD57QTYwMxwp+39LrnOzw0Wn63vUPTvge2635XeOiy6u4RgPvLWn 1nAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 24 Jun 2024 12:24:03 +0100, David Howells wrote:
> Fix netfs_page_mkwrite() to use filemap_fdatawrite_range(), not
> filemap_fdatawait_range() to flush conflicting data.
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

[1/1] netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait
      https://git.kernel.org/vfs/vfs/c/9d66154f73b7

