Return-Path: <linux-fsdevel+bounces-66582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DEC24F56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BEDF4F2E8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 12:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CEA2DC78A;
	Fri, 31 Oct 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF9CDJZi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47614A4CC;
	Fri, 31 Oct 2025 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913107; cv=none; b=mylIzdhGGPe2joYRhC5kVdhk7zv8a9JASAS7m18lz7FkYvNW13IzcIdQ4iEc68HzL8BG4vmVvtFXTZ6mgxEYcNnYk6BUBD8SN+b5ebQCwiByVsBl6Ob3f4Dgh8tme2bGJui2KplZihhI3nOSA4GxA3eRP2i/kZRDN9qwXMjq+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913107; c=relaxed/simple;
	bh=0izUsxBWgyKvtaP0ArWOlw4EsPJlU5WFlQUo38lMkIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnw25Gw3n4pi0WYp/4rmZMAf5Cj8qkzJqV0q3aOsnwPxP10AdJ54lWImkFr/RCo33DudJ/M+ceVElDGLANdICwbn/u+hRLkCSp8QJi9GamegqAScNZMi0HM2Z0OtIuTeYul/KU748UWFbplfTLuFYG3Wxrujp4yyloL7aJgwCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF9CDJZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14075C4CEE7;
	Fri, 31 Oct 2025 12:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913106;
	bh=0izUsxBWgyKvtaP0ArWOlw4EsPJlU5WFlQUo38lMkIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bF9CDJZis5oborOba5foFiFpWlstTaDemwZga1eqaZcy7T8FLDW3yXhm4Q+4Ro/5i
	 AJ+xvwPA6an0mqQZIpf9Uk+elCXQzhTuLEpsCS8fBNBbAoNGB4lreUjGg8QvAQITkh
	 3XSiBmipI6qz1usJKVFYjUvPXi4t3ZQydEfdTFDpOrlPQt3er4j6L5eSF1syd1cYav
	 G9zAlp7jgVFNWnIV7cPU6HFVQI7aA9abqKy5MV/nyDrUB+TZBTJ82NW7FnzqX3TBOZ
	 +fCZjEGsFwSL8HIn90PE0V/mTFFpmMdOxezTUFH4ZdafbbsZNg4BGld06V4EDpoucW
	 pUKBnmttRUVkw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Date: Fri, 31 Oct 2025 13:18:21 +0100
Message-ID: <20251031-hautpflege-auszog-418eb5e786b6@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029134952.658450-1-mjguzik@gmail.com>
References: <20251029134952.658450-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=984; i=brauner@kernel.org; h=from:subject:message-id; bh=0izUsxBWgyKvtaP0ArWOlw4EsPJlU5WFlQUo38lMkIk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSyrOS75GmVfkFbWnDq+WOiC4OOTFrk6VIUwclwtcPkj KPp2YijHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPxy2b4H+EqpThxsutGaVcP o2yGM9Eev9XYZfOn1V+PiHrbMSGokOGf5qlHNepx79RvrvrK3mam8kPEPX2L93r+fWZh9vr/K9P ZAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 29 Oct 2025 14:49:52 +0100, Mateusz Guzik wrote:
> 1. we already expect the refcount is 1.
> 2. path creation predicts name == iname
> 
> I verified this straightens out the asm, no functional changes.
> 
> 

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/1] fs: touch up predicts in putname()
      https://git.kernel.org/vfs/vfs/c/20052f2ef08a

