Return-Path: <linux-fsdevel+bounces-72056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D29CDC48C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7140530778EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EF2332EB7;
	Wed, 24 Dec 2025 12:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnHROVXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C3318130;
	Wed, 24 Dec 2025 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580696; cv=none; b=l3JccWBFYfeGSqg5MemZP/83Baq0vKqvzfQcLqbkAQHkYo3RvXUBfslb48oowy0qR8wwqkgpZPnW/iDFZCbIG7jY3j4+51WxJgrnlZ/07MkPDnJKUBqMRphainOQZ21UQvgKhed2UcIJulvRj2hdc3+z0uT5rro/H96DbPsENvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580696; c=relaxed/simple;
	bh=bFKrhNSgO9tZOZisND9QyFk3olLUBErfEx0vIPopvfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn+yLLRzDc6IWt/ZDMWWcvRPIuUfvH6V8NWZNQmDqPPBJhJKkU8X9W1dkfmdZvglgL0ENE4dZb/oi+QurlOT5aNtNCbdAGfeWfDCNaql0+6un8y2NCCvbFXSQf6/e/DoOdSLTJI3VTJKhzFI6GfJOUakatX57g8SjCvCmmjok3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnHROVXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9603C4CEFB;
	Wed, 24 Dec 2025 12:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766580696;
	bh=bFKrhNSgO9tZOZisND9QyFk3olLUBErfEx0vIPopvfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZnHROVXULmt+jP/g/gD0bFqc7x2/jsr2QqYUJIBpMeD+TfYuTVCNlmf77gaLNSBZp
	 9gOhYwF6aXkaDrciewiq9ccR5BC9lIEuSRIerTigdKwKBc8B/oh2bjE4B1UmbG44HT
	 fdSSDh4Z3Y+i8YQJQnv2LNj1oDXTC1RJsilg0eG75idRUS9mGfTbgJCKokXknTfEzp
	 NhHOSGoDLd8K0U7P45z2oszFsa/Jd4ByoDnvDf5g9H+puMmgZo69r3AjXmp2NYs9nS
	 O6frlTcXUjtgb5X5xw8TpczlUTHb5cMD5DMXWLz0rAxipi5o96u+fXv6PbnM5/Z8VM
	 67n89WJf2t21A==
From: Christian Brauner <brauner@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] namespace: Replace simple_strtoul with kstrtoul to parse boot params
Date: Wed, 24 Dec 2025 13:51:26 +0100
Message-ID: <20251224-knirschen-messen-b175b9e1e854@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251214153141.218953-2-thorsten.blum@linux.dev>
References: <20251214153141.218953-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org; h=from:subject:message-id; bh=bFKrhNSgO9tZOZisND9QyFk3olLUBErfEx0vIPopvfM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6P7yyp5J/ofQjzaV/zv+9qXvhlXpSi9OxeQrftnQ// L1RfcW0kI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ+DxkZOj0+J4X1LfKssWt 0cN1YlH7RrblbkVH4hWVvipLXCy6s4bhf0r7Lon8T+kLYyXYK/UfX5NWZs4O/aapsET2fPLZDvt 8JgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Sun, 14 Dec 2025 16:31:42 +0100, Thorsten Blum wrote:
> Replace simple_strtoul() with the recommended kstrtoul() for parsing the
> 'mhash_entries=' and 'mphash_entries=' boot parameters.
> 
> Check the return value of kstrtoul() and reject invalid values. This
> adds error handling while preserving behavior for existing values, and
> removes use of the deprecated simple_strtoul() helper.
> 
> [...]

Applied to the vfs-7.0.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.0.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.0.misc

[1/1] namespace: Replace simple_strtoul with kstrtoul to parse boot params
      https://git.kernel.org/vfs/vfs/c/3f320e5c2eca

