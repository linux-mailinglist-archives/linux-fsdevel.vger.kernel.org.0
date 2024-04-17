Return-Path: <linux-fsdevel+bounces-17122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D58A8232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30D82826F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 11:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130113342F;
	Wed, 17 Apr 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wuflt/+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B82613C9B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353728; cv=none; b=Gw4qc6cOHtulAkZoeUDOS3rqo11xIOabUDS0WUTgp3WYQW2gK4QI1yRDcmbK2DPrnD6HxMoi+wjZoE5qctEM71d8ZrtICYAmxrAJmzJfuKXxHDkvndZsX4V5a/vXvsDshFUFtkxgmLAlcw0DtEA+RBzfe8yy93lmfRoLoFO/xfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353728; c=relaxed/simple;
	bh=0n2iMfnnb+jpbF1fyI3FQ1lPOfzQyjd+tgfAwFAKrKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNsc5apHC+3pxo+s4vRGTiZRsHrGSs/9+cw9wUT5CGS6T8R9wAZtXwLC0PIw5ZkZQn89dtoYx2bVVB3Na4EHkFR2sRBi1GlGBJGiQbR4lm4lZbKutTwDrWuXKVburFxkm44WsQz6E8MSBLa6Mbq6m8KAbLuF6/w1vXOUsJojOds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wuflt/+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBA4C32781;
	Wed, 17 Apr 2024 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713353727;
	bh=0n2iMfnnb+jpbF1fyI3FQ1lPOfzQyjd+tgfAwFAKrKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wuflt/+7IRweoxPUZClcTJHESmCy9IaI+c0o9/34mG5G0J29P/rMfOFh0RwIW75kh
	 8nmm6wUHEO7YoWg6gI1nNyzA6kscCHPCi23QyrxW8mRZSkeuN6OJs1khm/eVqYW2gy
	 baCaZGq09BzeQ09G7A9FvEcTsn4vcRbDcfHkSTT14dhJfnKZfTGyDXpBQqw8J8AZqL
	 lsD2ZM+OC6drSLynKO15Q23q8yqgaGisLWyHT4cX0MzCNcaLU+gbrZwf5NNldSV/5D
	 CEawgz3hMNPk8DHvi+NJwgr4JVrhttz960cZh6IqTWMqWSE7m2HmSf9kMSnhYINocx
	 wPnXn5IUjVCVw==
Date: Wed, 17 Apr 2024 13:35:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Hillf Danton <hdanton@sina.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix UAF from FS_ERROR event on a shutting down
 filesystem
Message-ID: <20240417-geist-badeunfall-97d357510c0b@brauner>
References: <20240416181452.567070-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416181452.567070-1-amir73il@gmail.com>

On Tue, Apr 16, 2024 at 09:14:52PM +0300, Amir Goldstein wrote:
> Protect against use after free when filesystem calls fsnotify_sb_error()
> during fs shutdown.
> 
> Move freeing of sb->s_fsnotify_info to destroy_super_work(), because it
> may be accessed from fs shutdown context.
> 
> Reported-by: syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-fsdevel/20240416173211.4lnmgctyo4jn5fha@quack3/
> Fixes: 07a3b8d0bf72 ("fsnotify: lazy attach fsnotify_sb_info state to sb")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

