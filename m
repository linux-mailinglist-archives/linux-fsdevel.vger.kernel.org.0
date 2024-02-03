Return-Path: <linux-fsdevel+bounces-10184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A611848670
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 14:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53C2287749
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65F25D755;
	Sat,  3 Feb 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="GRqomXmW";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="e5+fSlKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1BA182AE;
	Sat,  3 Feb 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.121.71.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706965566; cv=none; b=rQ24vsdDx7OU7/bB0VcmoE+pvvQQZwxkFEYeKuUUvIjwt1LnuQ6qD2At3Qzwzqca3bB/ju4H58GqKN2eDkUhz7s6q7C3sLU+xGbJYCVmoOBE3eR3SuFtNLcPpacqp5LMp01Np+RECdsDD0suGwKEpJSuxYFY0zKDfpwFRWNySz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706965566; c=relaxed/simple;
	bh=qOQRRYdzSTfTJ/UMkN2de27peXui9N7BJG5gY0Al9Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iE1QFsDXXAeqV/22/IQTDOHX+V00UeMs971TRHDUkmsWDqPt7LtfAIGdTbk/pTH9DKpsmEv2gGcfEcxLBCTplDnMs+uRHG5N6Ukl3vIUC+ViHB+LftcBUxsahln5LuaVHDA/SwQzl6DqhesE6/y8tRtsXGizJ54H/1o1+afA83Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=GRqomXmW; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=e5+fSlKh; arc=none smtp.client-ip=91.121.71.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: by nautica.notk.org (Postfix, from userid 108)
	id 34D1FC01C; Sat,  3 Feb 2024 14:05:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706965554; bh=MHAYm8L9KXXS9In1gHIi35HSTfn1ejSwBESi0dh8u8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRqomXmWXgreBnG8JZUxbMPhOW96Khhc2tp+1THFlCFRoDogJFAsKY5ciq6ckQffa
	 Kay/4VmyebNFAXAWaLi65TYmt7dnLe/4eomFU5kkkhsI9nmxYmpNUj2QbZaMXvdLDH
	 QczzoB8yvjOtcZ8r2ZuFse3ekXILnFIbGYBLhPbJWCubrG+J5AFFpXtISHQVsDAJjs
	 TZpoFQysXI6eshU8WpUsTcOz74bV11fXOJJgDoMQ3TjlqEowbAt0Uhd1GslUEeumBd
	 M/hDR84YhJeXK2hBOlIvszIjBrMiCIPiL7XZJYrk8aQ0qngohCOWZ3sGNoRvYWppMJ
	 F2iAsn2N/S4YQ==
X-Spam-Level: 
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id BC269C009;
	Sat,  3 Feb 2024 14:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1706965553; bh=MHAYm8L9KXXS9In1gHIi35HSTfn1ejSwBESi0dh8u8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5+fSlKhk6McUCajMlHY++695qW+1FtvB9F8MSRal968n5hsVaEp0JnHmvojsmrER
	 Kcpa47gysDKqVf+Rbrkm5O1OVMKI8asVLGzUcBWJ7IqoUvFS0uOHBY5eHg+XiH35Li
	 ZvWNBxXJtAdBWgOQR2FWn3fsfIrXqBekSWBkLSo4IbAayoKtLUqTm9Xywx5qEWi4a/
	 zC8IbiqbIXu9ZkRmbW2EJHXgzWc3b0LebgbeOmzBiLp7wGx8aAHDe2z0fD/D25CRph
	 kSPud6FD+BMVAzKbV8xBGJH4W4caOwXqWiLLsMusfSLo5yIAVJDenLArKyk/At+qu4
	 GIc3jo1ahrsTg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id f2d44841;
	Sat, 3 Feb 2024 13:05:43 +0000 (UTC)
Date: Sat, 3 Feb 2024 22:05:28 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandanbabu@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [BUG REPORT] shrink_dcache_parent() loops indefinitely on a
 next-20240102 kernel
Message-ID: <Zb46GLPxQNnx16fe@codewreck.org>
References: <87le96lorq.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240104043420.GT361584@frogsfrogsfrogs>
 <87sf3d8c0u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <874jfbjimn.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240118063930.GP1674809@ZenIV>
 <87ede8787u.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240123114043.GC2087318@ZenIV>
 <8734ulsykv.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734ulsykv.fsf@debian-BULLSEYE-live-builder-AMD64>

Hello -- I've also hit this on master as of a few days ago (on
021533194476 ("Kconfig: Disable -Wstringop-overflow for GCC globally"))
just running some short lived docker container in a loop -- the last
process of the mount namespace exiting cleans up the mess docker had set
up and sometimes get caught there:

 #5 [ffff9f0fcd927c48] select_collect at ffffffffb2ffa6c2
 #6 [ffff9f0fcd927c58] d_walk at ffffffffb2ffb0a8
 #7 [ffff9f0fcd927cb0] shrink_dcache_parent at ffffffffb2ffd53e
 #8 [ffff9f0fcd927cf8] shrink_dcache_for_umount at ffffffffb2ffd8e7
 #9 [ffff9f0fcd927d20] generic_shutdown_super at ffffffffb2fdc39a
#10 [ffff9f0fcd927d38] kill_litter_super at ffffffffb2fdc673
#11 [ffff9f0fcd927d50] deactivate_locked_super at ffffffffb2fdd37f
#12 [ffff9f0fcd927d68] cleanup_mnt at ffffffffb3008d1d
#13 [ffff9f0fcd927d90] task_work_run at ffffffffb2cd97e9
#14 [ffff9f0fcd927db0] do_exit at ffffffffb2cb1c9c
#15 [ffff9f0fcd927e10] do_group_exit at ffffffffb2cb264d
#16 [ffff9f0fcd927e38] __x64_sys_exit_group at ffffffffb2cb26c4
#17 [ffff9f0fcd927e40] do_syscall_64 at ffffffffb376ea47

(I'm trying to reproduce another networking bug with that, it doesn't
happen very often but I noticed docker hangs once in a while, more often
after I reduced how much memory I gave to this VM)


Reverting just 57851607326a ("get rid of DCACHE_GENOCIDE") seems to get
rid of the issue at this point, I'm pretty confident it's no longer
happening by now but I'll reply again tomorrow if I hit the problem
again overnight.


Thanks,
-- 
Dominique Martinet | Asmadeus

