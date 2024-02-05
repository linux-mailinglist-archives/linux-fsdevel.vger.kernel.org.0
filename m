Return-Path: <linux-fsdevel+bounces-10309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06015849A50
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5CEB26E8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011EE1BDC3;
	Mon,  5 Feb 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvkYEcag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510C1BC2A;
	Mon,  5 Feb 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136312; cv=none; b=ElKzCaaEUKr7wGaxrx0Z9k8gr8Z4SllBG5EdPstjo+DbugsU7vw79zo9/n4YxM8nNPgCTwLz04xMZy1RnlBeUc/GJ3r3EOgKIfjoeoxMs68/JOgnUclR50hMGIQkjURbPUJZmQBkAIYjEPQUEtdx30+K2xTLssWat50Wo5b7NmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136312; c=relaxed/simple;
	bh=OvthZE2bvXcBV8LXD8wNl6xF83BZcROXQGXGKL5j77E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6OKq58uRklDkoTgmhv1IMtCMxHIm5B4m7ytwuon+z5ISqLr28WBWWVIS5ntzZEdQ21OhxmUy4Yx9kvL6gD5mk26Mv0EsAr/kOslDUwfRI1ZGqqb64nApBxS7p8/DVYNk3iMmMEFF43gjYV2po8cK9GOjuhz7L9NDrz98tZRsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvkYEcag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A50C433F1;
	Mon,  5 Feb 2024 12:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707136311;
	bh=OvthZE2bvXcBV8LXD8wNl6xF83BZcROXQGXGKL5j77E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IvkYEcagw9GLn2Xyj27UFyIrKvramr9XYJda4GwFgpoAzGHJ8zlji5QCefmE85kEA
	 hgyI4tDT2LPrie4Vixfa2Lm76eazhGxJjbDJJK2jZ9kdp4wAJJoXXqOxQXWb7TgsQV
	 PsvK7Pmi5GM/YKqbl8MON2xb23fMatq7kv21lylMlheR6k79eL6IBZBnK1DRl+kBTk
	 JRX5o5rU9qMs4O5JSdaA2mjsTPh0H4TZfqItF20s13sdMWTLFXRCpDX9Fh/s7DTxDj
	 Ol8iRSJvR4sIjUnPyR1YBhyP3a8UMDWetTcTXlLahygxEqdkLSgwNb2wOj8zSsc4Lj
	 IvBAZSymNIHJQ==
Date: Mon, 5 Feb 2024 13:31:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 11/13] fuse: fix UAF in rcu pathwalks
Message-ID: <20240205-gesponnen-mahnmal-ad1aef11676a@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-11-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:37AM +0000, Al Viro wrote:
> ->permission(), ->get_link() and ->inode_get_acl() might dereference
> ->s_fs_info (and, in case of ->permission(), ->s_fs_info->fc->user_ns
> as well) when called from rcu pathwalk.
> 
> Freeing ->s_fs_info->fc is rcu-delayed; we need to make freeing ->s_fs_info
> and dropping ->user_ns rcu-delayed too.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

