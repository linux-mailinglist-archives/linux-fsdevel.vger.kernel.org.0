Return-Path: <linux-fsdevel+bounces-63478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C1CBBDD99
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8B21895BB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B0026C391;
	Mon,  6 Oct 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMs2nIz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4C215198;
	Mon,  6 Oct 2025 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759749688; cv=none; b=LKUanut/inq1ZYeXGPSm1fuBmMpxU7lqCnhY3QspdwyN8CePyvocPmt4aKLhB5Hiixm/jU5RnFBBoEMdfI3MjzVVfRn8QbRZedF4+6O/Bd9xKIhcn6avZeJqJyy6UYPiJNnNvUmRPoBPwDO/HKbq41w+Gws/gStYxEl4lXNs0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759749688; c=relaxed/simple;
	bh=9kHxnnWakzqIdiZvArQ58Wnu6eTlglYNhJNBz0MQgd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu7PC1osKgpWyO8NmAERFvSkb8g/q7Ckp0svUxIE4IqI7f7Kr5tvJxvN5HvGu3VzhNe5bwJQGELHeIJcy/ECCuU4Q5maFbaEC7ljQjnRM0fQ2e4BtDqWEYyQUo6ZtqIQKBvfRbd4B8BWqpHgczqMwhG7u0MBgV3EmaZc9N2O4YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMs2nIz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55E3C4CEF5;
	Mon,  6 Oct 2025 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759749688;
	bh=9kHxnnWakzqIdiZvArQ58Wnu6eTlglYNhJNBz0MQgd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EMs2nIz1R7UjlcuYJd6p0EPnsBVGZ6A1fCRcmx0Oj0nngyfW8Gbzs+Nfjk1AVZ2zR
	 LR9Ceq0BFnajFMi55JvJCM6qOyevR9pYS0Ir4AEplsQyTkwgCdXz/zhCqtMFIIYQ84
	 rlYxMbOuxDEerkJXgnUDhtoiZ4L4PCieWFvGa87PxEirpV5Ndj7IWY8FNY6ZqFW7bM
	 onZHk3yJDcRP3uyc7oX08vzYZqJlWpu9zOXgsBgT6HhqolcyiJpmyTu4Za5sfrXCUC
	 lK8pyIU1ra/Indl2ffm/dygRdy75CIfcaC2zTxHWBWY9os+qZ+e5q95QvoB+gSRDKI
	 mJvH3FCsfY7NA==
Date: Mon, 6 Oct 2025 13:21:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] nsfs: handle inode number mismatches gracefully in
 file handles
Message-ID: <20251006-ganoven-normen-afe23381aa3d@brauner>
References: <20251004013452.5934-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251004013452.5934-1-kartikey406@gmail.com>

On Sat, Oct 04, 2025 at 07:04:52AM +0530, Deepanshu Kartikey wrote:
> Hi,
> 
> I wanted to follow up on the v2 patch addressing the nsfs file handle 
> validation issue. Jan Kara has provided his Reviewed-by, and Christian 
> mentioned plans for future changes with the unified nstree work.
> 
> Could you please let me know the status of this patch? Is there anything 
> else needed from my side for it to be considered for merging?
> 
> Thanks for your time and feedback.

It's in the vfs.fixes tree and will go out with the first set of fixes
for this cycle.

