Return-Path: <linux-fsdevel+bounces-29566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B797AD6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11C1287ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEC01607B7;
	Tue, 17 Sep 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkDNdmJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B28155A4E;
	Tue, 17 Sep 2024 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563566; cv=none; b=V/Z9vHZDEDMhJ/6wjOVH4UH49lG+HaE1g7ZG0O8pVqJ62yqVSR24OGSj0FlTqD+/QiS8pATeDQBrhSfoPKEO7WChvzOhHGssSTIRQzRBRNIaBDQCGESojEcz68VNpZHVq3coem6CDMg+skw9R+PrGrh/BNgZ/W3JM/DpFUmXbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563566; c=relaxed/simple;
	bh=NKhckBMgwJKcDCDVH8R0awRFV2BdU7iPgvD+2gL7lgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9lUlOZEVdCbkez3KlIIHLIuOSrJNqG/ijHdRRUngyGK5jmru+drcm15nOu31EZz5kZY7QtYo951hrdzgnfMUq3SdgSaSpSY2+SMwO/syEq+yxE/hSmvrd6Kj5yr6IgP2CwfH3RsFBiECWYYyz0YvpiLhTyXapQQ0FEGfffgM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkDNdmJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D740C4CEC5;
	Tue, 17 Sep 2024 08:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563565;
	bh=NKhckBMgwJKcDCDVH8R0awRFV2BdU7iPgvD+2gL7lgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hkDNdmJIqrdgegnNnlNIX+KgWGmbQVXD0wGSGAL40K5YK6/9OiM77zzk8lTJJ/ey+
	 pSQucHG+KwI3gBYSQQnMjr4N6r8Kxb6oo6opLTyN1j0bJ4zYr+9eRvqNG/oFa1BFVn
	 0x73yZxa3S8ErYG/OOGjY+olVwnDwH1rUGx1j+dS7NyfDFIv5tJQpNTvgqlyRzEd5S
	 GxqXgz8kDXz6jp5wuALWXxyaNKBnKagklUvt/wNOgRv+U7so1tOD1KnbykM3Om8IoU
	 TL7E7p0M0xgIMiBmbUWh4aBopqjaiWmli6y+ndzwnRhx13WBhz6I7/NMJfOZXLLNtl
	 XkieuQHSDBerQ==
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Jeff Layton <jlayton@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>
Subject: Re: [PATCH] netfs, cifs: Fix mtime/ctime update for mmapped writes
Date: Tue, 17 Sep 2024 10:59:01 +0200
Message-ID: <20240917-hypen-advokat-2d384f761fde@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2106017.1726559668@warthog.procyon.org.uk>
References: <2106017.1726559668@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=brauner@kernel.org; h=from:subject:message-id; bh=NKhckBMgwJKcDCDVH8R0awRFV2BdU7iPgvD+2gL7lgQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS9dHkifZuvafk8YU0el0MKa2IWePC8W985wW7OriN/9 2XPu96xrqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiL94yMjwWaFw0J4T3h9QW b/us1ave1cQcyYt+2Rm32IXvYn5u5lGGf4b8a5pt1jjYmEn4OzLJ2SvwXZvXe0pr2b/I8Buaqhv sGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 17 Sep 2024 08:54:28 +0100, David Howells wrote:
> The cifs flag CIFS_INO_MODIFIED_ATTR, which indicates that the mtime and
> ctime need to be written back on close, got taken over by netfs as
> NETFS_ICTX_MODIFIED_ATTR to avoid the need to call a function pointer to
> set it.
> 
> The flag gets set correctly on buffered writes, but doesn't get set by
> netfs_page_mkwrite(), leading to occasional failures in generic/080 and
> generic/215.
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

[1/1] netfs, cifs: Fix mtime/ctime update for mmapped writes
      https://git.kernel.org/vfs/vfs/c/edd297c2764c

