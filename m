Return-Path: <linux-fsdevel+bounces-47492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E3A9EA1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301743A80E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3651F22538F;
	Mon, 28 Apr 2025 07:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTrDVn5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956971DF738
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826936; cv=none; b=LsH6E6fo1lEND8QmK5EhteuBwMA2bVU2bUAhXOUlXb7F0bE8DhwubhEcfJk1WFTHWnWNHF/zPLEaty+PBj4Vv1d+JdShoMy+9gTVm68oqVrJ+J40/RvixjjLbmrC4r2T9JvIBSyyUHhsd8Biv5xdZkbAZfGTxi/xEM3K+Lr2cOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826936; c=relaxed/simple;
	bh=2f1Qf8Gjte1HZnEN2yJtV3FhIQWwj1Tw66TZwkbRGPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFoAFUksBuj0u58G/l9lVFgSy8L7GY7QrofLneXbfUP+/1bTZBuj8meW0ykLFUQTOXjz6OnRWSI5Atna9VSFcnFbs9wKD/XarhBMi2RGHvdglV6tI8Su88qNISf4zrD1jTPUwmdMf3PGI+Egq8pOr6/kDieUKx/47YC9rvHpGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTrDVn5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4DDC4CEE4;
	Mon, 28 Apr 2025 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745826936;
	bh=2f1Qf8Gjte1HZnEN2yJtV3FhIQWwj1Tw66TZwkbRGPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTrDVn5fzDL5faxg1smzUEEV8C2LsvOvuUIoPsDBPKhUvjnkoeiycrLyaq6TXvb9f
	 2vxZWr3PSoiCYJ0S2WBmXupt2URnSF3pKq/zJgHUV/a4wiPwaRSm+ezf+UV/k/3+Wx
	 +F+7IiTmmrM8dC/KUUpkGkXWT3ferlGSeRHQB+kvZmjYE1ny5pM/XnNjpenkHyOSGo
	 kMfEFAjQO1zTYAhD5NPMYk8o9hG6QqbTYGGCA9sKbe7sfwoogDE+6HmfUUYnevtfAR
	 9PBUI0U8KZ9fx2LiGboPP8BzCw9MdRFwiP2SzY+HzO8YPF5GumCAEN6Q1rj8tCXhfq
	 qjg09xOIr0UkQ==
Date: Mon, 28 Apr 2025 09:55:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] __legitimize_mnt(): check for MNT_SYNC_UMOUNT
 should be under mount_lock
Message-ID: <20250428-editieren-zerhacken-50d95639cb65@brauner>
References: <20250427195002.GK2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250427195002.GK2023217@ZenIV>

On Sun, Apr 27, 2025 at 08:50:02PM +0100, Al Viro wrote:
> [another catch from struct mount audit]
> ... or we risk stealing final mntput from sync umount - raising mnt_count
> after umount(2) has verified that victim is not busy, but before it
> has set MNT_SYNC_UMOUNT; in that case __legitimize_mnt() doesn't see
> that it's safe to quietly undo mnt_count increment and leaves dropping
> the reference to caller, where it'll be a full-blown mntput().
> 
> Check under mount_lock is needed; leaving the current one done before
> taking that makes no sense - it's nowhere near common enough to bother
> with.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

