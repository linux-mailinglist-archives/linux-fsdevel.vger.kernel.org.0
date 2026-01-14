Return-Path: <linux-fsdevel+bounces-73775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B598D20234
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EEF530161E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0653A1E64;
	Wed, 14 Jan 2026 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVMDyZrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF8F3A1A2B;
	Wed, 14 Jan 2026 16:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407275; cv=none; b=T/UuuVVtWhyn5/bJA/c98lA+TXV8AN8PzsMJejadiMj65d4vGAA4Mm0qAGar36H+NlgLonQIvOBI/TrpTSQjpMOwSytmhDW21mz9/mErWKWFk8xLon6lzbI+C/zVoxam8mFB9283mRuvbdV9M4e96tK4MCeiI2cZbHro0Q0/rnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407275; c=relaxed/simple;
	bh=W1jYo763i1aFlR8wYqpGFkD1e7V8qWDCB9eJbLX3G+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTshU6J75+iHmmzJVURrF0rtWOqlioB/wWWHQCyVtcrmkuMNIf0Zm504KCUkZT+JYM6t1kiC0BT6lCYXKfDp85Saq/N/hGm5kjbZQCNYjocmSjHHlYiyCox1so59OD5K/AJ4pxzC/+CYPN9UtZCMks7W54NgtLrCsmsRQHorZdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVMDyZrD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B58DC4CEF7;
	Wed, 14 Jan 2026 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407275;
	bh=W1jYo763i1aFlR8wYqpGFkD1e7V8qWDCB9eJbLX3G+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVMDyZrDIRWw1dw3GoeZsk7uZjnjZdP+kkYatTZk7BCUkjXOMpxaArRd2lImQkHao
	 nOZmBZqaq2ZQSdI9zl09YsyMUeXDZDOaMsnvlDSxPIpA/oVR8VplAmCKrfZHVX5SKI
	 7PrtfLCl4THL/LZqIpPZBBkU44p5nR9iZ5WPIv/tui3vl692FrrJU8WgK/knHm8JsJ
	 b7JlSUO0jnPjIPRs4wInwXIcHM13MiBZ6frI0juw0AH0dHRHqfJX7x85mvEgUqTtuC
	 vOfXq9E6nGUR4vddEsdxLkCHmMl8H0bcB3ve6SewWP6x8GPBXMVDzLYix/CZ5IgB9r
	 8pANJQNiK0Crg==
From: Christian Brauner <brauner@kernel.org>
To: Zhao Mengmeng <zhaomzhao@126.com>
Cc: Christian Brauner <brauner@kernel.org>,
	zhaomengmeng@kylinos.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [vfs/vfs.all PATCH] writeback: use round_jiffies_relative for dirtytime_work
Date: Wed, 14 Jan 2026 17:14:19 +0100
Message-ID: <20260114-endet-umgewandelt-a639352d24d7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113082614.231580-1-zhaomzhao@126.com>
References: <20260113082614.231580-1-zhaomzhao@126.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=brauner@kernel.org; h=from:subject:message-id; bh=W1jYo763i1aFlR8wYqpGFkD1e7V8qWDCB9eJbLX3G+s=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmH3i20tDnb+3Pu9nPomTW8oavd2A4eLabTVSi9lFbx PZFxTrLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiIsLwT3mnZD3vmfPFZUdW x/HEckkoOvQZs+b6rGoRmFzTe10zlOG/z+M1O69MnPI9yOwZzylJE33F6PMffmrf/mj+LDfq0sp HTAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 13 Jan 2026 16:26:14 +0800, Zhao Mengmeng wrote:
> The dirtytime_work is a background housekeeping task that flushes dirty
> inodes, using round_jiffies_relative() will allow kernel to batch this
> work with other aligned system tasks, reducing power consumption.
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

[1/1] writeback: use round_jiffies_relative for dirtytime_work
      https://git.kernel.org/vfs/vfs/c/e93b31d08162

