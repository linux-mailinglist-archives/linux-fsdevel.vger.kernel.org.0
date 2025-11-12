Return-Path: <linux-fsdevel+bounces-68031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A527BC516F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 10:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67A484FECE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC230149B;
	Wed, 12 Nov 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyDFIVHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A73009D8;
	Wed, 12 Nov 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762940031; cv=none; b=JDTSOtPJUfGZ8XEFGl4HMhj/Nqk/Q8PMYeiMUW8/w2ZcuRpIyzSmp+mlzlCKoz11xZKMnU/UzQ/8ir2zKDJaDznMLo3+RMtns216r27+uqHA2GcKyiLgm3meaz+jbihsClXtYpTkiElGPinebevo9hs995IzVsTlOJaqAnXRbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762940031; c=relaxed/simple;
	bh=VaWvuF/ukzI6PWpHBDHmQqomQZveyXgP4iaU8vUBouQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlKpktXZ87A5KNVk6uDj7REcXTyH8phFrMQdt7bwtTPrsKKn08vOTkID6nS0tuo87gIWMHL7w/ztnWXmoDg3n4WHqyT1f7U3qX27aNeceKlS9hrMg9npx5Foe68fhcbe2DzQ8PAdA0hB3Y62JMGAKgpobl7TGbvMiKptJgGJHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyDFIVHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190E7C4AF09;
	Wed, 12 Nov 2025 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762940030;
	bh=VaWvuF/ukzI6PWpHBDHmQqomQZveyXgP4iaU8vUBouQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UyDFIVHupVESBO5dKdFJrpimm/QKcIKr0pIBA+/nRs7CPrOokVE1j8R2pbbZo4+D6
	 LaLcQ4msb6O040l0Xlul+J1I0CxWKJtpzwQpFHibIydSaDzMYJLRAPITnAZrKB/7Xj
	 Cw4xqTjQFeN2a6S3mtZteOzH165g3rvMwinBE0FwcIc/6VSoKC5bUVF5vz1T4grRN3
	 02cWymyRwrBcC9ero4np0nIOiLCCkVhnPUQXIaF+rfVOWu4buqIhpWHkQya3TZ95al
	 puiWSHBqlsb7mXu0ckqvIpdIYrfcKU/4mAXxe7WT8wnXsdFy2CeSgWtdvibGgEaM8/
	 4p8JFjxn7NAEQ==
Date: Wed, 12 Nov 2025 10:33:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mike Yuan <me@yhndnzj.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
	Hugh Dickins <hughd@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] shmem: fix tmpfs reconfiguration (remount) when noswap
 is set
Message-ID: <20251112-vorbehalt-heizsysteme-3b11ba2b7ea3@brauner>
References: <20251108190930.440685-1-me@yhndnzj.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251108190930.440685-1-me@yhndnzj.com>

On Sat, Nov 08, 2025 at 07:09:47PM +0000, Mike Yuan wrote:
> In systemd we're trying to switch the internal credentials setup logic
> to new mount API [1], and I noticed fsconfig(FSCONFIG_CMD_RECONFIGURE)
> consistently fails on tmpfs with noswap option. This can be trivially
> reproduced with the following:
> 
> ```
> int fs_fd = fsopen("tmpfs", 0);
> fsconfig(fs_fd, FSCONFIG_SET_FLAG, "noswap", NULL, 0);
> fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
> fsmount(fs_fd, 0, 0);
> fsconfig(fs_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);  <------ EINVAL
> ```
> 
> After some digging the culprit is shmem_reconfigure() rejecting
> !(ctx->seen & SHMEM_SEEN_NOSWAP) && sbinfo->noswap, which is bogus
> as ctx->seen serves as a mask for whether certain options are touched
> at all. On top of that, noswap option doesn't use fsparam_flag_no,
> hence it's not really possible to "reenable" swap to begin with.
> Drop the check and redundant SHMEM_SEEN_NOSWAP flag.
> 
> [1] https://github.com/systemd/systemd/pull/39637
> 
> Fixes: 2c6efe9cf2d7 ("shmem: add support to ignore swap")
> Signed-off-by: Mike Yuan <me@yhndnzj.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

