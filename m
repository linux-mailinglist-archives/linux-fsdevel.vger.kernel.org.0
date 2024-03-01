Return-Path: <linux-fsdevel+bounces-13267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C398A86E16A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45019B216A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762F40BE4;
	Fri,  1 Mar 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuBR6vEY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC25B3E47F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297961; cv=none; b=OrGpytvUC/PrP+rklAXa7jetHsQXhwO9+NJ/g0p1hQcgHY7jmISrH8pjrjpVgfVeUy89Jn+RrM3nRc33zfBsoHhOzN8B7q6pvsKDjrCfgOA602dbTtrxwMPvuyYOqNV5P3TogCxtyxyGQft85/4g80Qz4W9gSel2Jeo4epm9/t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297961; c=relaxed/simple;
	bh=rx6vJUMXPtWXfv/Vw/HMW3iy86HgXLf7+KS5j6rCpVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXwXEYnRbOvjsPRsH6z+PV58ajMIwaR7cscpjDG91IHUuOFu1xz5MU+qsucQttC2v0aG98AdMwU7uelj4i9sKklc5btFHkABZHaTR8a1IBeyBSrAQU2fgxQydXe0IGBIt5JCyfJtHxqL0iw7cndaFVXsg2Bt5Io1RNPcoE/qFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuBR6vEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CACC433F1;
	Fri,  1 Mar 2024 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709297961;
	bh=rx6vJUMXPtWXfv/Vw/HMW3iy86HgXLf7+KS5j6rCpVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QuBR6vEYoNlzTnXOexP8VO8uv0vHLgRwgXRktIQ/oPIB3+pyJ4arGlAi0Ud9+gXCB
	 VUlo0gMMvzEep/itb+PI6HVvZJxGTIYUCjkk9LjOSa1s2UrEH2yXFnttWQuuLuHmf8
	 0oV8zTjkXa/jkEQ/sfHXkw53CjpDW7deD8/zOyxbpsxwadNxsiSmhwxB9wzKlZVKOu
	 MXTpl1Ifushtg/Skg6iqiElHnTjvITXBX2hRPQtpDJgCbw02BzQs++t85i9DlPWbJw
	 Lnwh3dejEUONWbczAZbDPpA6wd6YwJj0caacCupfup/hTlTYr0pDTvVaVNHb31s7fc
	 r2Mf7EKOfrFNQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Bill O'Donnell <bodonnel@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	al@alarsen.net,
	sandeen@redhat.com
Subject: Re: [PATCH v2] qnx4: convert qnx4 to use the new mount api
Date: Fri,  1 Mar 2024 13:59:10 +0100
Message-ID: <20240301-handwagen-loslassen-1669ef4d91c4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229161649.800957-1-bodonnel@redhat.com>
References: <20240229161649.800957-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=brauner@kernel.org; h=from:subject:message-id; bh=rx6vJUMXPtWXfv/Vw/HMW3iy86HgXLf7+KS5j6rCpVc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ+vKj0fnKo9s2AvasrPHbq13WkbI4LX6gs/+TtX56bT Ff9VznrdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykMoOR4VvQfNuyiQr5tukG c31WVtxfvMyPo7PxlpJBdVP5EoFvMQz/Kx6dvBpUOolp11v7XeYiZw0atHdw+SsFX65X+fiUiec HPwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 29 Feb 2024 10:15:38 -0600, Bill O'Donnell wrote:
> Convert the qnx4 filesystem to use the new mount API.
> 
> Tested mount, umount, and remount using a qnx4 boot image.
> 
> 

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] qnx4: convert qnx4 to use the new mount api
      https://git.kernel.org/vfs/vfs/c/6b91bfa1651d

