Return-Path: <linux-fsdevel+bounces-21972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A698D910750
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24DE1C22EDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DC91B0136;
	Thu, 20 Jun 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiQMW06U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD01B012A;
	Thu, 20 Jun 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718892006; cv=none; b=jIJzw7okWc4eUeCbTTWbMWTMWX/t6sajORZmpp+/OlIP9SUo7IXlDRzrFPCGSfV2+B4K0tHErCZF/Lw2js+P1a8qdg2LEp9Ei8A1Axy7Ea9n0tHqiwJlnIrjn3vP7yPKgvEw4abf47tuLyryeZq42xRbinceFm+zphHV4Cm3eT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718892006; c=relaxed/simple;
	bh=YZKImNC1RfWiWs1j5FyXe+Kr3Xlzbc/EX+IVY1fo+wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuGg/BSmNehdliTc8kDMbJ9KVnFphZHS3mcnyAEfkXF0qRtl2aXcWbcEzjd8m6jlJZ6VWSlInNZh6m/pnOMm4+L6SYJAjRAeUU4WSBcUSTOotEnm8FtKICvyzwZIiPXvE/qZ4a3E90KA5pQeFDmYKzrGsdma1xp6O6D4BxBH9vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiQMW06U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39259C4AF08;
	Thu, 20 Jun 2024 14:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718892005;
	bh=YZKImNC1RfWiWs1j5FyXe+Kr3Xlzbc/EX+IVY1fo+wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CiQMW06ULf3iJ0haviw8Rpo7YHhxc4pPYHzwDxHLOUXr2rGsqVhjG7XrGJztMbcxs
	 SS+2mvrjM/cItNYB4xRJxntkcGjQSpUebzSoL/FZjeRY06S40bFZ0LfXXaDDLu5QOK
	 Dz7DRyzF6KZn/3ORw/jw2kgrFljGF9V/vLUYjDfj1yLDyLvdLXR3zXj8oSg2lHjYlA
	 itjPJlcbtEgfJNR88rnqv7XshRMgdnynLUOBUmT4yWopdAGhwnnpI1C+yRSidV9MWY
	 CEB2DDSkLrzyGWvaunHEzd7jJAJV5nJ2LfSeQu5MJugwIReKJvqkEWOArPcN0KpMiP
	 tk6z3LVoWlpTw==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: reorder checks in may_create_in_sticky
Date: Thu, 20 Jun 2024 15:59:06 +0200
Message-ID: <20240620-unpolitisch-illegal-ec7aa4ade172@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620120359.151258-1-mjguzik@gmail.com>
References: <20240620120359.151258-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=brauner@kernel.org; h=from:subject:message-id; bh=YZKImNC1RfWiWs1j5FyXe+Kr3Xlzbc/EX+IVY1fo+wE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSVmN5z/T6PVTFxT2rAns2iDFZzn/Duy/ZnVj9mHF3is NqZn3drRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESuZDP8FZf8cICBveeteZrt W91Qo+lhLowtSyO0m8sX1xqtYzeOY/gfHef8xybK/LPVtYgTKgZFrdm31vYZ3bplGbVh30Tz3B2 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 14:03:59 +0200, Mateusz Guzik wrote:
> The routine is called for all directories on file creation and weirdly
> postpones the check if the dir is sticky to begin with. Instead it first
> checks fifos and regular files (in that order), while avoidably pulling
> globals.
> 
> No functional changes.
> 
> [...]

The list of checks is unspeakably irritating. I really dislike looking at this
function.

---

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

[1/1] vfs: reorder checks in may_create_in_sticky
      https://git.kernel.org/vfs/vfs/c/6cc620b3a050

