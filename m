Return-Path: <linux-fsdevel+bounces-46567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 197B4A90649
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97225171757
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 14:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A91C54B2;
	Wed, 16 Apr 2025 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6PSwxoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151221AA782;
	Wed, 16 Apr 2025 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813409; cv=none; b=eIF1NOe3rpb3dHDIwuoMtqccAgsPjwWbKmkvOGOqED44VRevuW9lvCPk7nae1nec3O9e5GUK074Qp+qNQbglwU08v39nSrZs2zzvVsmH/iBdw/o7O6rTqOaiCZ91mz0+t0YhGkmYSjS+snoD/jWptJO7TvQ/z99Lb417gBtkmQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813409; c=relaxed/simple;
	bh=31gL/odkYjacobeigorvdBGnAi5DfmJZZ5CDSkbKDd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3AZGvXwoL0i3svn/GYUA37p49w/2Irpo9iMTkN92x7ChqP5B9fUmjtJg1w+nYc5hAY5osv89tcOs1qm4AptC5s/se4EYqY+6cqKJRt/iDSwsGWw2QTtNqJfdXNtrt7Mj0wxdD4KUgAImiOW5cLVuEuplajGIdjs7/ILhToh8CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6PSwxoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C413C4CEE2;
	Wed, 16 Apr 2025 14:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744813408;
	bh=31gL/odkYjacobeigorvdBGnAi5DfmJZZ5CDSkbKDd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6PSwxoIZorXcA58JIzH/ohoGv/St/jGNcjHSa7uMKBlN3pr3Ze+dWK9xj5sE7BvH
	 u1QzFhl6VVh0ZWdjM2HE0KbqHNNdqSygcnThgbE6AX4SaC4OYHUy09CKfL3hxcKY72
	 1oJMEdGBeaOOlUYD9XNAM7nRb1tf/y9rMAFBVRkbHxCDRIN1xXl2TzS0LmYaW7om3u
	 EsE0M8l4fTW4q5EN1bmVyU1cS6uZrMuDT4ql87jGLHKCuDNkZepEGCStunu5NsSS0L
	 e0IPY6Ofypuc0RnHZeOjzI8c5LL9npJKtGu51dpLLAM0+eWdTQg6El3JR6/e1LRhxL
	 sXDmt9H7sfkvg==
Date: Wed, 16 Apr 2025 16:23:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC vfs/for-next 0/1] Only set epoll timeout if it's in the
 future
Message-ID: <20250416-drakonische-sanduhr-56d6363d1c12@brauner>
References: <20250415184346.39229-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415184346.39229-1-jdamato@fastly.com>

On Tue, Apr 15, 2025 at 06:43:45PM +0000, Joe Damato wrote:
> Greetings:
> 
> Sending as an RFC against vfs/for-next because I am not sure which
> branch to send this against.
> 
> It's possible this should be against vfs.fixes with a Fixes

Yes, can you resend against vfs.fixes, please? :)

