Return-Path: <linux-fsdevel+bounces-63538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E78BBC10EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 12:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4C133C7012
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 10:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828A52D879B;
	Tue,  7 Oct 2025 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNgvoIHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75392D7DEB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834695; cv=none; b=MBU6IhizHgVHcvCFYMsGWY+aKhEs2QtU3F1YMWSekLjiIwZG1NybxLkh5ojtYiJFPpABq0fCig68oAGHZE0Ty8kc2DtLp0T7AM3niIabVu4rPitP5D46oI7t2Pn57qo1rC4edJR4hSXp6Ces7aNOKhxYHrk8G5gC+obAUfRyjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834695; c=relaxed/simple;
	bh=jINHaYNUA48cBodauGfsNBnC9bN+xSxE7V7GOdRUUps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6p21sGmo3TN/fI4uUTuYgFNDyhlCe24yyVmfTwME8L7eR/kHJd48+SQX8N9A6JabYqOEkgF0TMjMXAzsUZEWr7Is/kdA33a49HQ4hgzCp1UgDLSEJbHOc8WtzqkOI4dhhy9CCooOEuwMQYk16GwBBMEyuG8BvF3r0gAZfju9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNgvoIHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BE2C4CEF1;
	Tue,  7 Oct 2025 10:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759834695;
	bh=jINHaYNUA48cBodauGfsNBnC9bN+xSxE7V7GOdRUUps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNgvoIHf+9ZFxHCzS304Oo8AiIqrHgbALW+EqLDLRn1NJZD1nd7XzXkvTGA9vhoC9
	 El7p/8Komm/vRpFxQZ7y4di8mE6KDF0ApLBSBrnByudDTydhcxEkDoCpa7aqaguKRu
	 1aJVGOL52ktTm3xLaMXPwtMwU/wCGbYXX4wOn16s4FTcMr9deDhekYYwdQrYeSlep3
	 p3+Cvc0uIWJr5uW2+zW7zBvYHvXW8NxDqbCm8vUf19oWOl5UlyKQcBphxNSBiDA2Jv
	 xAVnQEfdl4IJurGUL4tDDtlUBSRX0s6V99qljMfgK8AW2oXlA2LXNGsmmL4TIccrEs
	 rLuf2nd3iJfYA==
Date: Tue, 7 Oct 2025 12:58:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, 
	syzbot+e0f8855a87443d6a2413@syzkaller.appspotmail.com, syzbot+7d23dc5cd4fa132fb9f3@syzkaller.appspotmail.com
Subject: Re: [PATCH] ns: Fix mnt ns ida handling in copy_mnt_ns()
Message-ID: <20251007-atomkraftgegner-warnung-6b02ea18eb2c@brauner>
References: <20251002161039.12283-2-jack@suse.cz>
 <20251006-rammen-nerven-f7dff27e8e43@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251006-rammen-nerven-f7dff27e8e43@brauner>

On Mon, Oct 06, 2025 at 01:03:15PM +0200, Christian Brauner wrote:
> On Thu, 02 Oct 2025 18:10:40 +0200, Jan Kara wrote:
> > Commit be5f21d3985f ("ns: add ns_common_free()") modified error cleanup
> > and started to free wrong inode number from the ida. Fix it.
> > 
> > 
> 
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
> 
> [1/1] ns: Fix mnt ns ida handling in copy_mnt_ns()
>       https://git.kernel.org/vfs/vfs/c/502f6e0e7b72

Jan, I think Al fixed this in his series on accident in upstream.
So I think we can drop your patch. emptied_ns is cleaned up after
namespace_unlock() and will call free_mnt_ns() which will call
ns_common_free(). Please take a look at what's in mainline and let me
know if you read it the same way!

