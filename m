Return-Path: <linux-fsdevel+bounces-50104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2BDAC8327
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 22:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835764A7C95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 20:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235B29347F;
	Thu, 29 May 2025 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WI+0VGxL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE529290B;
	Thu, 29 May 2025 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748549758; cv=none; b=R8u1TtPD6ymjAMhbWBzVSw4oQpPxHfik8MhXO8mp8Z4dq5QuO9YwarHruIXaoH2K8GBA4yTFS2mZplnE+BRUXX1dlq9/8S7QA/Fg2Nk4HwFjUQ8LgXiJEn1rndD4WMLztETHoQb376muB5ua4/UXE44vp1MO16VXVInjaZw1q8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748549758; c=relaxed/simple;
	bh=AxEUEJtSsXYQkYRCPbp1bT4ANi2whzF8qEjdPxzosWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiF2kOxVesnTzXuzFQZK302QICS30JiSwmR3rCrYBAGPCYI/i001JzONSlG0gko+/7yl5G3NhSknVY4Am4UD2B1cYwo+TT/CeDX1jvZ801/Ui5mxTkJ7HrM0klUiLODLhcNtB3lBxI7NfzgiF35rLuMbE5r1V5lFOIh4+KeTf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WI+0VGxL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dQ+n7cQU5+xMShg0sP1ix7HAXGCsb92WvGzDX6dnJFQ=; b=WI+0VGxLXzk1JH7Xv5hME05JyZ
	8zmrU2Y4w4egnDVyQchexQjKPK25ueis/g1KiICk7FsjQVH4weIjsRHyVlUXXZG5i1w+wVKyjnzzB
	MqzqvA1WnSHqT/tCER7iZWwGuTZNit/ujcbayQYUgjyUZ4yBXudZQgCIgcOuhmlkGbskwbowSbkPk
	ifgqdJX8XnY0yK5E/vQc/9x2hjes0O2Hmmzs/fkCWLJPwQ+I+IKNLZDaKAUP5atLP/9lqHJitg0XH
	y0WZ1/8cRm6J8GiuSzaeB5qiLOmC56FQOisxqpm8GCd8r8qRK555s7NNMLAxzpOXaKkkDNbqXiFu+
	Yjs+hNSA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKjfL-00000003911-1GOO;
	Thu, 29 May 2025 20:15:51 +0000
Date: Thu, 29 May 2025 21:15:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
	mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250529201551.GN2023217@ZenIV>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <20250529173810.GJ2023217@ZenIV>
 <CAPhsuW5pAvH3E1dVa85Kx2QsUSheSLobEMg-b0mOdtyfm7s4ug@mail.gmail.com>
 <20250529183536.GL2023217@ZenIV>
 <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW7LFP0ddFg_oqkDyO9s7DZX89GFQBOnX=4n5mV=VCP5oA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 29, 2025 at 12:46:00PM -0700, Song Liu wrote:

> > Basically, you are creating a spot we will need to watch very carefully
> > from now on.  And the rationale appears to include "so that we could
> > expose that to random out-of-tree code that decided to call itself LSM",
> > so pardon me for being rather suspicious about the details.
> 
> No matter what we call them, these use cases exist, out-of-tree or
> in-tree, as BPF programs or kernel modules. We are learning from
> Landlock here, simply because it is probably the best way to achieve
> this.

If out-of-tree code breaks from something we do kernel-side, it's the
problem of that out-of-tree code.  You are asking for a considerable
buy-in, without even bothering to spell out what it is that we are
supposed to care about supporting.

If you want cooperation, explain what is needed, and do it first, so that
there's no goalpost shifting afterwards.

