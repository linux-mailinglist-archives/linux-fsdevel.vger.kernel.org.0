Return-Path: <linux-fsdevel+bounces-28942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D17971A1D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCFAB23E67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937351B3B19;
	Mon,  9 Sep 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAb8hAul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03961B9B2A;
	Mon,  9 Sep 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886505; cv=none; b=EkkMSnV+tw6op91ueP5iW/dDlr6RYVQdORRX5ahFlKc2TLOc4Y6z4hhxHTMdwnMzVxSzGPX/XG1ZsCEOccvEOmWPE4zIi4hnWtwhBtrIioIdt0Y+G7hRX5BEJBKusTcn7LSoXKBds5XtTgjxcnefkxbJr1Am5+Tvw5bUWf9ZVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886505; c=relaxed/simple;
	bh=mewjZipxo90hzVjrv7kKmKuwCEd4v2A8DphBRjfOlK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAhjzkDygh1O7BTe3KP0fbEWbmTW4ZW8Gg178ll1TkoyLpErVWvs0soqL7zwLhFd+THrRRI0EVhO42VfMbZOeSXCLF3VZhDIYATPGsfDiVb7NGhj82ddLsATgL2lwk9/U49blMNKcsLZjG0TLIwY5RTBD3KlGgwKfvOmC+F4t7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAb8hAul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A87C4CEC6;
	Mon,  9 Sep 2024 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886504;
	bh=mewjZipxo90hzVjrv7kKmKuwCEd4v2A8DphBRjfOlK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAb8hAul8DWLl2kjAOJBLid1JWtsUd/e7CI7VUn1aAyfsvzQ2lMX4w8VKUZA46o2b
	 Q2yL9zQJz/uvVDtXN0DieZmS28RtLK7AFd97jsZ5ZrNTk9nN8uU6iqGcLC66TkYWjm
	 eviEgrIZEcSZf1mDJPpwUiYN5CW2LwRnioSYtpdcQAKW+lFB6vxmXqJLF/wmpP/mDH
	 fOQHm18RKjymymcDd+ttnZkjNqslWDYMrbK4AYXwW+gpaG8SNPm4dHAuIHXp/z4Esu
	 JNfX8Xn94OjKW4yImmLfeBUQm1ctxOjLU4E04TLRgH9XdNbQFY6Otky7Av+hGTdoBM
	 rp9snjmgcsLXw==
Date: Mon, 9 Sep 2024 14:55:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] fs/fuse: introduce and use
 fuse_simple_idmap_request() helper
Message-ID: <20240909-diskreditieren-villa-91d00d7fbb57@brauner>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>

On Fri, Sep 06, 2024 at 04:34:51PM GMT, Alexander Mikhalitsyn wrote:
> Let's convert all existing callers properly.
> 
> No functional changes intended.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

