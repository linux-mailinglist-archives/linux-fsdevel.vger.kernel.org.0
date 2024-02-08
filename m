Return-Path: <linux-fsdevel+bounces-10772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE2884E22F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 14:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CF2285B96
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 13:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CBC7641A;
	Thu,  8 Feb 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4hDhH4m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28966F097;
	Thu,  8 Feb 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399816; cv=none; b=cJrJZerAYro19zV5O5A8fWKWq0UqWW/7trf1pN5dTBDRA6gTru7ds9gjm409IwZMACcZ+goBOAFj5FMNpash9CG5i2XGx2AZgFCCoh/4NPpJOOoW+xCHpJPrpepf5y5ZhP04pqflI9z+iGbwKNPCbhSAwwxaaesuuwU+xOmI+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399816; c=relaxed/simple;
	bh=wKbk920Kjdp3sw+LbV9RY/efmZU+r4AbLarGIr5Q04o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nkktxn+/K9DbQy3yGafit7cFcqYPSl85scSwkUWUnsFWrT0wdPMVkuPGKrobq7UU3tu4ds5WYyQYE5bATaxQgwg1mD8foaEt+EWhItcwBWeYs7MyPBA1iFP+E7T94INmXgZcMT4rOFO5xVGXlR96deUaNUSFdzc1E34vdi4BQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4hDhH4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B68C433F1;
	Thu,  8 Feb 2024 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707399816;
	bh=wKbk920Kjdp3sw+LbV9RY/efmZU+r4AbLarGIr5Q04o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4hDhH4mWUnalGLkcK9D3aR++AMQy1DxjeX5RtdP5/uJF6oAdEnXG1I/xADOMgJIM
	 /iTxr4h0id2W+owj4xC6ua126dRoUOVv639qhPNSEKygfyffdHtW9bMrgCV7+IAtCz
	 944xeuK/nT0vRbpnmL8g4aQfRCXeMUFWvuHKrpMZtDyZHEhAhTDuHkg+9LXrb16cDN
	 40c5K+17xu8a1nb/PRGXuFvzCbCdmJsyti7Gxm/vJh4Y/KcKDzF7Xusw8f8YsCedPL
	 1IM4SBIu0GFHpQd5FVI5BJ9xyJLfFNGR9qckM7A5GNGnUOzfovi4kDxtsvml0p3S9+
	 v2f/W02RIY3MQ==
Date: Thu, 8 Feb 2024 14:43:31 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Karel Zak <kzak@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: relax mount_setattr() permission checks
Message-ID: <20240208-dreitausend-ortschaft-efe30cc59154@brauner>
References: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206-vfs-mount-rootfs-v1-1-19b335eee133@kernel.org>

On Tue, Feb 06, 2024 at 11:22:09AM +0100, Christian Brauner wrote:
> When we added mount_setattr() I added additional checks compared to the
> legacy do_reconfigure_mnt() and do_change_type() helpers used by regular
> mount(2). If that mount had a parent then verify that the caller and the
> mount namespace the mount is attached to match and if not make sure that
> it's an anonymous mount.
> 
> The real rootfs falls into neither category. It is neither an anoymous
> mount because it is obviously attached to the initial mount namespace
> but it also obviously doesn't have a parent mount. So that means legacy
> mount(2) allows changing mount properties on the real rootfs but
> mount_setattr(2) blocks this. I never thought much about this but of
> course someone on this planet of earth changes properties on the real
> rootfs as can be seen in [1].
> 
> Since util-linux finally switched to the new mount api in 2.39 not so
> long ago it also relies on mount_setattr() and that surfaced this issue
> when Fedora 39 finally switched to it. Fix this.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2256843
> Reported-by: Karel Zak <kzak@redhat.com>
> Cc: stable@vger.kernel.org # v5.12+
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---

Fwiw, I've been going back and forth on this yesterday evening because
of an inconsistency in legacy mount(2). The gist is that for changing
generic mount properties via do_reconfigure_mnt() we check_mnt() but for
changing mount propagation settings via do_change_type() we don't. For
mount_setattr(2) we should do better. So the change I originally went
with didn't bother to do check_mnt() when that thing doesn't have a
parent to be true to mount propagation behavior in legacy mount(2). But
I think that this is wrong and this should be
if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
which means we do check_mnt() even for the real rootfs which doesn't
have a parent and for both regular and mount propagation properties.
I've changed the patch to that.

