Return-Path: <linux-fsdevel+bounces-69931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE8C8C3D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 23:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDC80345C78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C541342C92;
	Wed, 26 Nov 2025 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="i/c1lEtz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B692FE05F;
	Wed, 26 Nov 2025 22:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764197013; cv=none; b=Y1LviIItiaD6qATEnlFp6akbkSjyMTYSTwcKDAHkxnkZy522P5GUeIKnggDZU8IGneTMVOUD3DidqeF3S9CV4GflTQonWif2sh7gXJGMEC22Zcyd2VgWvAjlTYWLYjThMKY+ku+prAwhBH4GnPCwGmjH85vtMI16jU0J/I/BppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764197013; c=relaxed/simple;
	bh=NAO6yiTvhORoUe5ko/Q1ckQoAbMeKVHsSQW/l4sgoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsE1EwhC76Kz97EFEcn3ym+0Ve0o9wuOBiEPWMInXNGaSeo2siIPRvMNk5hfFHIUBlWhlmFfolWt0RKiDWUyE5TettbeqKoyMUjh32ngxTnz7v8PJv23gRbTY6ZF8AO1CWcgppo8rIN6u76geUsS0YjUkhKKzjmD+pFlndhUy+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=i/c1lEtz; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 1628314C2D6;
	Wed, 26 Nov 2025 23:43:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764197001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K0KFCW+5jhg3jR/0FuLUIZLFyoS0cptZj3NFw5LCiBI=;
	b=i/c1lEtzEswoAJQ93Cwk/07NkgT1rVyizTDKKn2vss1Ad2Hq1M+M7CICwNS05h5ldsVqBD
	2MPti6WHEdzK4UuTUCbRdRTllPLzk1ioVkOI/VP2CgmnoTs2EQGKhgH18rJ54WT0e+soUA
	+GadFlWDrhXQ+heZEM8rrvYAVZaWq/xySQz6YS6f63hmNlvtaHAmmWjs1ly2F876MuVYQB
	vGxil2WnhDmwEKrmAP3uC5JbCo5aQz/Sbr2NJNV1qn2Tqr97neJD2U+8MWOUa5bn81gkGx
	SmS9y2fkiLBG61+O094je0e7MsNYIJRHpsSKSn7v1Ptiz7eQ5iDcuT8tDWDxsg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 48b8e30a;
	Wed, 26 Nov 2025 22:43:17 +0000 (UTC)
Date: Thu, 27 Nov 2025 07:43:02 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aSeCdir21ZkvXJxr@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
 <aSdgDkbVe5xAT291@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSdgDkbVe5xAT291@pilgrim>

Hi Remi,

Remi Pommarel wrote on Wed, Nov 26, 2025 at 09:16:14PM +0100:
> While testing this series to mount a QEMU's 9p directory with
> trans=virtio, I encountered a few issues. The same fix as above was
> necessary, but further regressions were also observed.

Thanks for testing!
(FWIW that patch has been rolled into my 9p-next branch, so you shouldn't
have needed to fiddle with it if using linux-next)

> Previously, using msize=2048k would silently fail to parse the option,
> but the mount would still proceed. With this series, the parsing error
> now prevents the mount entirely. While I prefer the new behavior, I know
> there is a strict rule to not break userspace, so are we not breaking
> userspace here?

That's a good question, we had the same discussion about unknown options
which were causing errors in the previous version of this patch.

My personal opinion is that given it's easy enough to notice/fix and it
points at something that's obviously wrong, I think such breakage is a
necessary evil and are occasionally ok -- but it should be intentional,
so let's add some fallback for this version and we can make this break
at the same time as we make unknown options break

> Another more important issue is that I was not able to successfully
> mount a 9p as rootfs with the command line below:
>  'root=/dev/root rw rootfstype=9p rootflags=trans=virtio,cache=loose'
> 
> The issue arises because init systems typically remount root as
> read-only (mount -oremount,ro /). This process retrieves the current
> mount options via v9fs_show_options(), then attempts to remount with
> those options plus ro. However, v9fs_show_options() formats the cache
> option as an integer but v9fs_parse_param() expect cache option to be
> a string (fsparam_enum) causing remount to fail. The patch below fix the
> issue for the cache option, but pretty sure all fsparam_enum options
> should be fixed.

Oww. That's a bit more annoying, yes...

> However same question as above arise with this patch. Previously cat
> /proc/mounts would format cache as an hexadecimal value while now it is
> the enum value name string. Would this be considered userspace
> breakage?

Now these are most likely ok, it already changed when Eric (VH) made it
display caches as hex a while ago, I wouldn't fuss too much about it.

OTOH if the old code worked I assume it parsed the hex values too, so
that might be what we ought to do? Or was it just ignored?
I'll try to find some time to play with this and let's send a patch
before the merge window coming in fast... This was due for next
week-ish!
-- 
Dominique Martinet | Asmadeus

