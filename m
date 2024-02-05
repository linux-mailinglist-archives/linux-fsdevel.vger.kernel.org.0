Return-Path: <linux-fsdevel+bounces-10298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7A2849A13
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8671F22B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF41BDD3;
	Mon,  5 Feb 2024 12:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLjj9MqM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2191BDCD;
	Mon,  5 Feb 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135988; cv=none; b=Wwcp3LFiBSq3RkN26cwU4wPyN4O7htvK7Z/XtJGUNR6NDg9Ytmwhijrkg1AY7lu8Zt5k2zqBOjmHeDSHAaQ/3OVh6fDgCFFlWHnAfWlfsl68ndvNjZyCZePP9aOx8sqMs0t5XKkU9/c5Wog86xF1wq5HBLIIERavyqkrYjvq+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135988; c=relaxed/simple;
	bh=lwxblrQaM2PU9Ph0KtCfSJXHKczy/LKctqp8Xqj3Rw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbzB0ioClxvymu85YdX2KgNWJAIw33MQ9exJ1+CX6okUVVzpyeCm3Q3v1px69SNITmNzrHJL5B/sgsgQnKEX4z0BP9X16qzH9OTH7Ca/eJ2WGPznHpWp1tr2m7Wa8KYrTMJ7gZi8AFNh9GxHPhPTh4SFuD41+XaGH/p2p7AEHJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLjj9MqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76934C433C7;
	Mon,  5 Feb 2024 12:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707135987;
	bh=lwxblrQaM2PU9Ph0KtCfSJXHKczy/LKctqp8Xqj3Rw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLjj9MqMpYWzW8XmWY+gk6EEjKdchMCsqNOFXyY9iyNaJO+wCQ1nOYqjgBhsNRvW4
	 TEV3V1bd3MsFrsZbnalzZFr3TxuSbI+7b+UblKvssGHqxfygd2Cg6kmt60Fy+dKPqz
	 2Olnb8KKLknh8FkuSyommmZptuz1sZ6D8zDGieY8lr5RuSEmBq+9FwK0XyFf47NRx5
	 S6yyf0zwc25xp4RnW5pbKyDzXaGQ7vYwHsJnD5Jp2/aM4qR7i+BbeZtyYMNZTLtHS9
	 Ppowtka7S/ChEiuJ8L5jn/C60zUozcjDFxTr6LOBPEvKV75cFIBjecn/NYkY4ip+NA
	 EGSq9CZ1D6xzQ==
Date: Mon, 5 Feb 2024 13:26:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 02/13] rcu pathwalk: prevent bogus hard errors from
 may_lookup()
Message-ID: <20240205-beifahrersitz-flutwelle-efcc1a812ec6@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-2-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:28AM +0000, Al Viro wrote:
> If lazy call of ->permission() returns a hard error, check that
> try_to_unlazy() succeeds before returning it.  That both makes
> life easier for ->permission() instances and closes the race
> in ENOTDIR handling - it is possible that positive d_can_lookup()
> seen in link_path_walk() applies to the state *after* unlink() +
> mkdir(), while nd->inode matches the state prior to that.
> 
> Normally seeing e.g. EACCES from permission check in rcu pathwalk
> means that with some timings non-rcu pathwalk would've run into
> the same; however, running into a non-executable regular file
> in the middle of a pathname would not get to permission check -
> it would fail with ENOTDIR instead.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

