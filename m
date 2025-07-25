Return-Path: <linux-fsdevel+bounces-55994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB03B11553
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 02:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8769EAC57AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 00:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565F11CA9;
	Fri, 25 Jul 2025 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUXgHgHK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC713DB9F;
	Fri, 25 Jul 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753403960; cv=none; b=aXKc8xZpnLL2GAUv4ml0hU65VRp3ugTQCai0npljx9Jbvv/UNf59yEkVeW/0k+Bf6F23VvCkJAJZwRvTTt1MuG7YatsZ7pYRuix0M2IE7mXMBLvZGG3ZdjBLpwQpIX+SKJsolVa9PepaDWrli0Ml0dSqPo6qgyyKFZXPMkB6gb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753403960; c=relaxed/simple;
	bh=/7nhN2DOwKFEF1v1+1mtOE9qlVXIIVUam6Kuqynry7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihy1TZuEkQkVGl3ovdqRRvJ4XHuxMTih+/fEEDFgHAikJbzkMHJES75oPDM4EwfFl/XC+E4PfmECJfdsDx8Rl1kDwN0TL4neczgGIWgRMbir09O2jIbauwHjfwMmUpoVWwLqp/hd8Iv8x/TchPCvTJC6XpFgVZXNLxLQOU5JKvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUXgHgHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191B9C4CEED;
	Fri, 25 Jul 2025 00:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753403959;
	bh=/7nhN2DOwKFEF1v1+1mtOE9qlVXIIVUam6Kuqynry7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUXgHgHKvsthaosdF81Y4UKcO51+64+maQ4kCq82oyUqZ4gw95Mr/m10Gy7CLfh9M
	 CRTb6qscZQ/YlLsQhIV1uzeZM98N9gE+gkpsHqRaHJ/8KkqE7mahFJQCoWt7Agu10e
	 +qEUQTHjXEgouPp4edln8lFGexxj5b0IHdHL73/UfSgW8QnAf0PH9qyQZsyxi/5SYr
	 BWm5HHW9GFgezeqdEeh1Hvl5eI3rp7JveBh+didGCE02Q6D0xarHr+HulXVm4SruV5
	 XL5ao8eLrbOc/wm+oyc/9SU5lK2Umdt44WOBTGgbr/5sq4QTnLWbo274ZUzoeHCzx+
	 D2isObWWZyXjw==
Date: Thu, 24 Jul 2025 17:38:29 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v4 07/15] fs: drop i_crypt_info from struct inode
Message-ID: <20250725003829.GE25163@sol>
References: <20250723-work-inode-fscrypt-v4-0-c8e11488a0e6@kernel.org>
 <20250723-work-inode-fscrypt-v4-7-c8e11488a0e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-work-inode-fscrypt-v4-7-c8e11488a0e6@kernel.org>

On Wed, Jul 23, 2025 at 12:57:45PM +0200, Christian Brauner wrote:
> +	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop);
> +	VFS_WARN_ON_ONCE(!inode->i_sb->s_cop->inode_info_offs);

These warnings seem odd.  The first is redundant with the fact that
there would be a NULL dereference anyway.  The second should probably be
located in fscrypt_addr() so that it applies everywhere inode_info_offs
is used.

- Eric

