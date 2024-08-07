Return-Path: <linux-fsdevel+bounces-25273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B339894A5CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E556D1C20F3A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5033E1DF678;
	Wed,  7 Aug 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CENgGTtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F611D2F56;
	Wed,  7 Aug 2024 10:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027178; cv=none; b=ZPOrFb06/CddHavCdRlRc8X4fXldOOJV1vV6w3ltZJbKsTikm0b1bwScHZIin0BKYsj4e3D72HfCoTNQgT3HT1uYY8Uahj6QX0BiXnj3X7rXSO61oUkl2Scr1GN4awuX/mZSeWxPhtkREhvCSyP2mVil453jDy4vTs6th77J8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027178; c=relaxed/simple;
	bh=308Z34GySE7hugoS4IOu2Ay9wg/V0y18CYXbDqVBg+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/t7NqXVA3Q6a9401IC1HjkDqUtXGffftwQPmWAWPTI20cIKj2mZuPVlDwGSqzs9OhqONLOHrW106ZNgY3y4E7ciwq6tYgcsVBgax4OweuB/G19ObCifQJ/D/kMH+hKbZ1YnwYe/H2MrvCePLNgsHhhjc5xk3t1uO22umQD68XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CENgGTtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18987C32782;
	Wed,  7 Aug 2024 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027178;
	bh=308Z34GySE7hugoS4IOu2Ay9wg/V0y18CYXbDqVBg+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CENgGTtUxKlJdmF7IVR7gzf3xw4oeFWGIchx1XkWrOzOTrz1xOvZPsRIPc10lUvfL
	 qYbc1cN+pmi6bS5245m44KYKGeHEhJid309WxF6MG/kEny0t+K0Ta3KOKMUpDI0mGu
	 4jAct2lHSI23EDQCv8IdcWH2dToFVz290M6TFXZwVSV1lDYluy/cnu7vsoSWggjjbP
	 KLOdSCYJj/mhq5qOEWYG7i9WLiJBCKUwYZwwmj+DPQ9wYlBJaJek0e0rfZ1FHO1ekv
	 h5hmfQbtXORQAz7M0NFJIc8vfeksGlj4TjSHGXSiq4wy4c1BCOZDdNG1OK5LgQfVfU
	 /EVwCzD9xtmCg==
Date: Wed, 7 Aug 2024 12:39:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 25/39] convert do_preadv()/do_pwritev()
Message-ID: <20240807-aufzuarbeiten-kerben-79ecf9b9f65d@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-25-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-25-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:11AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdput() can be transposed with add_{r,w}char() and inc_sysc{r,w}();
> it's the same story as with do_readv()/do_writev(), only with
> fdput() instead of fdput_pos().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

