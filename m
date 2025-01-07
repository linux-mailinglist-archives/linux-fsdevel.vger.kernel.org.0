Return-Path: <linux-fsdevel+bounces-38573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53373A0435A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 15:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A76D1634CE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E7B1F2397;
	Tue,  7 Jan 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjkvKFlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A371DF749;
	Tue,  7 Jan 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261603; cv=none; b=pgB3T7hx3qIKvy5+6C5ciuKMynZ4uLxIZBZmW1C0F0YmITQef1rwykmfntasneSzlT1JxMyhuEWO82juZbV4YYSOWxhz1RRzwRdP3fYVigNvCECobbo7Wo01klV4vHcBxqj/FgzgGZ9yWY+iCrdETWSHeVpRvYKiLm24i7sp3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261603; c=relaxed/simple;
	bh=GnpjmvnUMoYz2GvLIOPTjHDiLas71QEvJn7JLu51h94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnJG7wtJtTgatq3aEaAMH4Zr62cbVz46esQh5TNlGfTK4w4K+pyCy7E7lJd19r/aXtD5oDTuXOEVjjgo/T1+l4aqZWdJSH9OkeI6UTFU6jO0/AhhGV7nrHTYDzY2ibCZSQiflD2QrD25Wa8n4ENBP89c97hAVYjGqlGlPObD4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjkvKFlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7ECC4CED6;
	Tue,  7 Jan 2025 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736261602;
	bh=GnpjmvnUMoYz2GvLIOPTjHDiLas71QEvJn7JLu51h94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LjkvKFlIxmpEX05lXA8Ow/KoaHo4lLpyUn2jN81Kn06BJKJ2j4vz0lDZ9Q1zdAHl5
	 WuIA7efVcl+tavOuPK9i68MrQ4J1uoK6RbMwPdIznlLyU6i1eypyyMXwGip3ErTBx2
	 IEa43p9Ow+IsxFphE2V1Yr2riNBfcadcUN1WmJQoHIlkkZ+p1oU0ppeCWGzKgsr4wM
	 f9fdaLwhuPXkNmO2Vk/pXbn5CqmRN1MA50GKlSivq5bOjE2AqgYc7cic5z1V2M4Z9N
	 Lty4SsNq9xumOyPcaWXZVvS2lMl/pyVaMuFF+yxz18K0gM3r7cInMrJmYA2fHBBrR2
	 HrpbE/lKUTLLg==
Date: Tue, 7 Jan 2025 15:53:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: viro@zeniv.linux.org.uk, elver@google.com, jack@suse.cz, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, r.thapliyal@samsung.com
Subject: Re: [PATCH 1/1] lib/list_debug.c: add object information in case of
 invalid object
Message-ID: <20250107-grade-entgiften-74e459edf9ce@brauner>
References: <CGME20241230101102epcas5p1c879ea11518951971c8f1bf3dbc3fe39@epcas5p1.samsung.com>
 <20241230101043.53773-1-maninder1.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241230101043.53773-1-maninder1.s@samsung.com>

On Mon, Dec 30, 2024 at 03:40:43PM +0530, Maninder Singh wrote:
> As of now during link list corruption it prints about cluprit address
> and its wrong value, but sometime it is not enough to catch the actual
> issue point.
> 
> If it prints allocation and free path of that corrupted node,
> it will be a lot easier to find and fix the issues.
> 
> Adding the same information when data mismatch is found in link list
> debug data:
> 
> [   14.243055]  slab kmalloc-32 start ffff0000cda19320 data offset 32 pointer offset 8 size 32 allocated at add_to_list+0x28/0xb0
> [   14.245259]     __kmalloc_cache_noprof+0x1c4/0x358
> [   14.245572]     add_to_list+0x28/0xb0
> ...
> [   14.248632]     do_el0_svc_compat+0x1c/0x34
> [   14.249018]     el0_svc_compat+0x2c/0x80
> [   14.249244]  Free path:
> [   14.249410]     kfree+0x24c/0x2f0
> [   14.249724]     do_force_corruption+0xbc/0x100
> ...
> [   14.252266]     el0_svc_common.constprop.0+0x40/0xe0
> [   14.252540]     do_el0_svc_compat+0x1c/0x34
> [   14.252763]     el0_svc_compat+0x2c/0x80
> [   14.253071] ------------[ cut here ]------------
> [   14.253303] list_del corruption. next->prev should be ffff0000cda192a8, but was 6b6b6b6b6b6b6b6b. (next=ffff0000cda19348)
> [   14.254255] WARNING: CPU: 3 PID: 84 at lib/list_debug.c:65 __list_del_entry_valid_or_report+0x158/0x164
> 
> moved prototype of mem_dump_obj() to bug.h, as mm.h can not be included
> in bug.h.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---

Can you please base this on either the latest mainline tag or
vfs-6.14.misc and resend, please?

