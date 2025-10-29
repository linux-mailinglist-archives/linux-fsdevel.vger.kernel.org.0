Return-Path: <linux-fsdevel+bounces-66329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA441C1C06A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 17:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F8725C8ACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13403451A6;
	Wed, 29 Oct 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrfiZTNS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F93314C1
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752604; cv=none; b=KkcbL7lNUeC/NPKchoqOsE5PDwOulUV5wyRBhR059EkATG+Wzq7cuWR0w0nl99Pl4HFEgNoalRnkVICEI0SB7na0hw1ILBhY7TNQOx5sjqQDDeZjWJGK/R/Pm4QUMy6V/WdeLHq9ajMcY3P73Zx5mf6FLoy18jJM4BxKnzhj7Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752604; c=relaxed/simple;
	bh=3CgduJxm4esR2fpVITPa0dpSR46tTHcVgolWyalmh74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jalirBFgvX3TRqyajHCPE2b9D5zi4EtfAhhllnNx7IVeNhTgJYDlW13eF0klJG0/MivwMsxoU9d65nujy2erJwHvQDGFUaJ1DANYzD6uRJnpTRESN9Mg1phLFH2xAgZeGoIYTzgONU6pYAuR08WVPd4qWln15xg2LjtnwgwngUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrfiZTNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9D9C4CEF7;
	Wed, 29 Oct 2025 15:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752603;
	bh=3CgduJxm4esR2fpVITPa0dpSR46tTHcVgolWyalmh74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YrfiZTNSXf5AJV06ZcKoQxHnL0Fw08tgLpF43tB+JNeHSemvXNLLvdegX/poOgHbG
	 86eB3dC8wsVxoJy5PRMTyYL3ulLxLjvApKbbRsB5z/bKIZVlwkNn7ZASQKl5NyWI4L
	 3TQ6LUn+XcIzpsy1IqzCvO76srFvKzgNlKih8JqG0vjpdoYgO6u9+KN+vmNST/3wby
	 IVLhd8qP6rPQUB3EMfmGKIEtJMNRyyYm++natQQVbTAgBfJgrDggEb+z1OPYKRcw3y
	 14y2QcY7+bVobfBhiQYYHKHz5XxCxRIFBplXLu5mFqxan9WMVIYPR5Rd1s/8+1JpoK
	 hud9KniE7lplA==
Date: Wed, 29 Oct 2025 16:43:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/14] Create and use APIs to centralise locking for
 directory ops.y
Message-ID: <20251029-management-wortkarg-8231c147605d@brauner>
References: <20251022044545.893630-1-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022044545.893630-1-neilb@ownmail.net>

On Wed, Oct 22, 2025 at 03:41:34PM +1100, NeilBrown wrote:
> following is v3 of this patch set with a few changes as suggested by Amir. 
> See particularly patches 06 09 13
> 
> Whole series can be found in "pdirops" branch of
>    https://github.com/neilbrown/linux.git
> 
> v2: https://lore.kernel.org/all/20251015014756.2073439-1-neilb@ownmail.net/

Are you resending with the dput() fixup or did you want me to just fix
this up?

