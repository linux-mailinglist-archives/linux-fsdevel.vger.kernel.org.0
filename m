Return-Path: <linux-fsdevel+bounces-50141-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42202AC87FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 07:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357BC1BC173C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03251DE881;
	Fri, 30 May 2025 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfMU7Iaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A210F1;
	Fri, 30 May 2025 05:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748583067; cv=none; b=Je7iwkpd8BTKlhQh5UacOM6IS34vDGecxLDjfIx1maO3SZieKbrQnpHVsmxLtB6g0TzpDvbB/VYMqc4w9jhdKPeGzf3hTO8e8qeIbeTFUfRfG2SnMCDqR3yrpop35emiUYIV5S89nUzv9jxya7AocDOWmOSUZB81diB/imwO21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748583067; c=relaxed/simple;
	bh=9Eqbs9oIqb+kfGf1rNYA2/hmV0SEv4D4bNd1oUa5J74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3WGdaRJAtd8ovmWfU45aeegudjZMIhnkFXjL7oM+TAndViF6NOJfICswvAvKMIxZMGgwj5TFOgyYeorf6OqyNk4Cquao/e7plRG5aZI+36wuCpeIMGnHrIcrTceEUmtxff+YTK7OLcNSU3Zd1P1bMP8r23rdC9VmthOkk/gA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfMU7Iaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA2FC4CEE9;
	Fri, 30 May 2025 05:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748583066;
	bh=9Eqbs9oIqb+kfGf1rNYA2/hmV0SEv4D4bNd1oUa5J74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfMU7IaaslRfAsLAsGX+19zeIRRmEhJuiywijLPAFP1irHuRpaxX9cOuv7iW2zXwN
	 wfA6MJXKyboW0fPFWa+8+yc9N2FzT9mj0krvqZ/pQ+Fyl/xcJA8EkTh99V+gL1WW1/
	 BZxgFrNKg9wbz0knS65kAnjLjLiAaN4aah7tJ0mqMF5dq+xpfdDMpUC2tRGjS1xO5J
	 xQ0I2QX3NlDWs1XNBKdk5uh1tdtZANivZf9NC42FFfViZxc8DdcDPylQ+SExBydQzl
	 32jfm6QC5Q8hpMbY3xVniWjod8ybPzHPwdgR4x8HCjs/UTcQf8NqE+/LiP0VmdJBio
	 74zx4zwxxYBKw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] exportfs: require ->fh_to_parent() to encode connectable file handles
Date: Fri, 30 May 2025 07:31:00 +0200
Message-ID: <20250530-orbit-lockruf-0515c57c166a@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250525104731.1461704-1-amir73il@gmail.com>
References: <20250525104731.1461704-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1051; i=brauner@kernel.org; h=from:subject:message-id; bh=9Eqbs9oIqb+kfGf1rNYA2/hmV0SEv4D4bNd1oUa5J74=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRYOk3NnK2gzWIzyZ6x6+DdKYGR36WM+pJXmbc66RfHS 0hz1V3sKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjWWYafjAqrd5lGxLre37js X9NJg0oF2xln5ya2GK48qyn/JePfIUaGu1UWX75xnz288+TzW4V/hepue6c9eWzMcCTnd7bHcuW 1jAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 25 May 2025 12:47:31 +0200, Amir Goldstein wrote:
> When user requests a connectable file handle explicitly with the
> AT_HANDLE_CONNECTABLE flag, fail the request if filesystem (e.g. nfs)
> does not know how to decode a connected non-dir dentry.
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

[1/1] exportfs: require ->fh_to_parent() to encode connectable file handles
      https://git.kernel.org/vfs/vfs/c/5402c4d4d200

