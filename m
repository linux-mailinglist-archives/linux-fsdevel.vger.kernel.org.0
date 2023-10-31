Return-Path: <linux-fsdevel+bounces-1614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA057DC4DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 04:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6462815B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 03:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2406653B8;
	Tue, 31 Oct 2023 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZG/4ErlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F3F53A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 03:26:35 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617EC6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Oct 2023 20:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JPobaY23QJvqYxxVObTgBoYolDqpmggkh18ssUtk/2k=; b=ZG/4ErlPNi77EulYA5ALg0OJ0+
	FXx1zQaGe5KljS7XtFmCpqG65GTa75cXfmD+VNya3lFKAQBWlVKwdwwH1qwtod0vPpnPyG6mzZPYO
	XzmnyDPq+NQbEhHlHBqCN+a5pl3jqgBqXEdE9qHI/i4me9K0shunErWPeO9F4+qf8sJwMTzw8s4zD
	U3Kz+kdObp6JsoXOKPaFx3emVleS2amyLGAsTUpIshZRV6aqZY/41YstERGcwTaAVoUOjScpGR29m
	I6daWbmvQeCOEmjLRPnrciOBkI2K7H6Ol5+ImujTuwlm8sJv6e8n0AnIjwCs0d3jzs+lAeZKtRyuR
	rpvsXhQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qxfOb-008HX9-0f;
	Tue, 31 Oct 2023 03:26:25 +0000
Date: Tue, 31 Oct 2023 03:26:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] simplifying fast_dput(), dentry_kill() et.al.
Message-ID: <20231031032625.GB1957730@ZenIV>
References: <20231030003759.GW800259@ZenIV>
 <20231030215315.GA1941809@ZenIV>
 <CAHk-=wjGv_rgc8APiBRBAUpNsisPdUV3Jwco+hp3=M=-9awrjQ@mail.gmail.com>
 <67ded994-b001-4e9b-e2c9-530e201096d5@linux.alibaba.com>
 <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whCga8BeQnJ3ZBh_Hfm9ctba_wpF444LpwRybVNMzO6Dw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 30, 2023 at 05:02:32PM -1000, Linus Torvalds wrote:

> look, if USE_CMPXCHG_LOCKREF is false (on UP, or if spinlock are big
> because of spinlock debugging, or whatever), lockref_put_return() will
> *always* fail, expecting the caller to deal with that failure.
> 
> So doing a lockref_put_return() without dealing with the failure case
> is FUNDAMENTALLY BROKEN.
> 
> Yes, it's an odd function. It's a function that is literally designed
> for that dcache use-case, where we have a fast-path and a slow path,
> and the "lockref_put_return() fails" is the slow-path that needs to
> take the spinlock and do it carefully.
> 
> You *cannot* use that function without failure handling. Really.

Put another way, it's a fastpath-only thing.  Not sure how much use
would it be to slap __must_check on it; a warning along the lines
of "DON'T USE UNLESS YOU HAVE READ <archive link>" in lockref.h
might be useful.

BTW, is there any reason for -128 for marking them dead?  Looks like
-1 wouldn't be any worse...

