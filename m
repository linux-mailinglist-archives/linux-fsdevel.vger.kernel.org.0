Return-Path: <linux-fsdevel+bounces-21527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE7290521A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E28B23AE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF6A16F821;
	Wed, 12 Jun 2024 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGXKUFL9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C927416EBF0;
	Wed, 12 Jun 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194118; cv=none; b=rjFVMjTpmeqL5m53ZAXPP3YRGnAo6GrMr5UrLwk3OkqfgsOsl51aERSSP50oABSxjRiWRnT4uwD+lgzTGLEeA4ISfeIwMPHHOv0GqsF1Nc0LDwMyFIlX25elZokHBFDdnzgCYB+op3kHA84G1COHQ1YyCT0jDLc950uUJBnMBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194118; c=relaxed/simple;
	bh=iEZwKN9n2vr0/Rj50GSw6qf0W6CrsyI/vRC8PfMS8VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjSB3VfjdlCaBL3EyNSyF080s2TXmgbmxoElToFILZkI8yguz5BIhAMKTFWBXmeYHD0lJaZsAUt1Etv0ESlhafZcrIqPjFcBGajUa3b6OuGe6xOBmI9pmrcsEqhWJLq/d+nHBLSHM/jnwoKSCzJb3D4JjFnM8ejzXecrHmxLX5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGXKUFL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 480C9C3277B;
	Wed, 12 Jun 2024 12:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194118;
	bh=iEZwKN9n2vr0/Rj50GSw6qf0W6CrsyI/vRC8PfMS8VU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HGXKUFL9sJBYLg7ZTAqnpJbxZdfmwFYv7FAlWLkpyrr9tozcrnEcOcxDU0pv0a4lu
	 gVAd+PNIep4hoE0jCoLX3Q63KEuq2SE+AqQ3qWiKjmzBc2RuJa/+D/V6qGAClCFCiN
	 UqP5gqLQLzwbmD9fkFFvGppMAPg3K76pactCJkn7cb0URoz8euQ/IZjXbx9ITEA924
	 iQOAqxGe2J0hug+rIWyqHxfu9B6YTc5ykGCKu9IWMjsf8PbHNzSjcQsxNrBknGQO80
	 XhsUM4N8SK4xDo2DOVTZIAJ2w6FFaZipXG38++90zWM3cmLGn4pkcrTgqngoPfwE/A
	 9q+0p8P+9039w==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	josef@toxicpanda.com,
	hch@infradead.org
Subject: Re: [PATCH v4 0/2] rcu-based inode lookup for iget*
Date: Wed, 12 Jun 2024 14:08:29 +0200
Message-ID: <20240612-kinoleinwand-umkreisen-acfb5ab14658@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611173824.535995-1-mjguzik@gmail.com>
References: <20240611173824.535995-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251; i=brauner@kernel.org; h=from:subject:message-id; bh=iEZwKN9n2vr0/Rj50GSw6qf0W6CrsyI/vRC8PfMS8VU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRl9u+L/XXjY81J7st/9/z6aWu4V01kSkXV0u3tO2Zcf vXB6cTEmI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJyN9jZHi4KfZEltKpEzMt S0xWCCkLTi3b0PEx4NzFjuPxwSm9mdsY/hmyiES3BccL+xRvupe7/tiDp4vybnVITfdb5fts0tx f9fwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 11 Jun 2024 19:38:21 +0200, Mateusz Guzik wrote:
> I revamped the commit message for patch 1, explicitly spelling out a
> bunch of things and adding bpftrace output. Please read it.
> 
> There was some massaging of lines in the include/linux/fs.h header
> files. If you don't like it I would appreciate if you adjusted it
> however you see fit on your own.
> 
> [...]

Applied to the vfs.inode.rcu branch of the vfs/vfs.git tree.
Patches in the vfs.inode.rcu branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.inode.rcu

[1/2] vfs: add rcu-based find_inode variants for iget ops
      https://git.kernel.org/vfs/vfs/c/d50a5495bae7
[2/2] btrfs: use iget5_locked_rcu
      https://git.kernel.org/vfs/vfs/c/4921028a9c89

