Return-Path: <linux-fsdevel+bounces-68817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD5AC67098
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 03:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 217DF29E00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E84326D51;
	Tue, 18 Nov 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgY5WW8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2746A2FFF8F;
	Tue, 18 Nov 2025 02:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763433338; cv=none; b=jW95Mg5yvholIfJnx1H796TrXmPZOWM8BKLeVCueFhU2TaDp3f/CSpz99NBAaL7qLYTaLEti3anU/KoVY/2QXqG5RSPNvOiiUN10CQ5CZvTg5lect/sVvSzR/HgSQzMONzI5ZSiQxF/P74wtqn9uswzXihyAExlkgV3eRPBg3H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763433338; c=relaxed/simple;
	bh=CRCD2rguqh+WPne9dd5lj9Micj6TMBS9/fhz6RbrIgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhtkGu10o2WJBtnk7YBUvf17C3myAHhon5enLGMk7ba+yzrCbm4b3LgXO4ZUhymWDAUxGKTzuapLt6MPCzKngWWH3B63VQ7Ta8DOFVTRZlTuvWJMKGoFvyYDVM7ITyQrWqg9t06XSe0ogFEojEiWMaEdIMcX2jeAhpOMJwjfNw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vgY5WW8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0235C2BC87;
	Tue, 18 Nov 2025 02:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763433337;
	bh=CRCD2rguqh+WPne9dd5lj9Micj6TMBS9/fhz6RbrIgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vgY5WW8BnNwTFkr1CqGzVVAn8dfzoBhj2Ep9OZzZPeg1xHu6mF1vh8NeQ5gnPaCUI
	 hehogcf50XcUOoYsd7JVzTDcRwav8kb7J9bp0D7+WA2rBQFS9kfIV8oVTYMHRK1dX3
	 oaScTMoGOaQPuIDGSoELlIlMUyEt/lZG+FvX81p4=
Date: Mon, 17 Nov 2025 21:35:35 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bot+bpf-ci@kernel.org, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz,
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name,
	a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, ihor.solodrai@linux.dev,
	Chris Mason <clm@meta.com>
Subject: Re: [functionfs] mainline UAF (was Re: [PATCH v3 36/50] functionfs:
 switch to simple_remove_by_name())
Message-ID: <2025111717-showgirl-suspend-2f8d@gregkh>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
 <20251111092244.GS2441659@ZenIV>
 <e6b90909-fdd7-4c4d-b96e-df27ea9f39c4@meta.com>
 <20251113092636.GX2441659@ZenIV>
 <2025111316-cornfield-sphinx-ba89@gregkh>
 <20251114074614.GY2441659@ZenIV>
 <2025111555-spoon-backslid-8d1f@gregkh>
 <20251117220415.GB2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117220415.GB2441659@ZenIV>

On Mon, Nov 17, 2025 at 10:04:15PM +0000, Al Viro wrote:
> On Sat, Nov 15, 2025 at 08:21:34AM -0500, Greg Kroah-Hartman wrote:
> 
> > Ugh, messy.  But yes, this does look better, thanks for that.  Want me
> > to take it through the USB tree, or will you take it through one of
> > yours? (I don't remember what started this thread...)
> 
> See #work.functionfs in my tree - that patch carved up + fix for UAF
> on uncancelled scheduled work.  Individual patches in followups.
> If you have problems with that series, please say so.  Otherwise
> I'm merging it with #work.persistence (with #36 in there updated as
> posted)...

All looks good to me, thanks!

If it matters:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

