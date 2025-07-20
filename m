Return-Path: <linux-fsdevel+bounces-55532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7232B0B7A9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F6E178FFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 18:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E625224227;
	Sun, 20 Jul 2025 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cGyns8p0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F522256C;
	Sun, 20 Jul 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036155; cv=none; b=qY364I0efzxX0l3QIjF6A5bG8PsCj8Tlg4c6c8X9SS/POLrclsm6Ye5rJsP2iCretiz7ujbSJeBdF/+Ou/6IURT4MswL1n5bcOFnoSNLOJjkPTqUYED8dkxr49GDGatLcFXgQGrz6p9+DSsLFgJ3I13Jk3lq6zArw4BbDf0pntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036155; c=relaxed/simple;
	bh=2LfnLgfOsyAui8flCm7v4zrqDc+K60iw12jxxJL7Afo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OX37uKET4UfgxJypCCHHdBE+rbXH9yNrh/0U/zvT6XbOrJ7i8Zrnq/49vdKeexM3iegmTDEJ9Ny/RhhvkKaKDCenkPTEkRr0Jvzcnj5ss1A/DvUPlArOGuvtQmwr/rdHC+rxnZ22bFQ3TlPcobNhMg4e8qSLGL1kLyVwjMLMm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cGyns8p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B436DC4CEE7;
	Sun, 20 Jul 2025 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753036155;
	bh=2LfnLgfOsyAui8flCm7v4zrqDc+K60iw12jxxJL7Afo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cGyns8p0iwOz2+rkNjk/p79NMwP2vGSzaO2yngxU64JnauPd0AYPIsZrEVwWfSgqe
	 KrN/ZvQwQ1ey7YmzgdyZWy6c35ptDFQmR/MdE2yBvi7DeVOh4cAb4Nb2OT7TS37/IT
	 pBVVMehALJl+mlSWp8wyLrMWsZ0aGqnKri+g9wTo=
Date: Sun, 20 Jul 2025 11:29:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH v4 06/10] mm/mremap: check remap conditions earlier
Message-Id: <20250720112914.6692e658f4c5b7f4349214be@linux-foundation.org>
In-Reply-To: <8fc92a38-c636-465e-9a2f-2c6ac9cb49b8@lucifer.local>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
	<8b4161ce074901e00602a446d81f182db92b0430.1752770784.git.lorenzo.stoakes@oracle.com>
	<8fc92a38-c636-465e-9a2f-2c6ac9cb49b8@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Jul 2025 12:04:42 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Hi Andrew,
> 
> It turns out there's some undocumented, unusual behaviour in mremap()
> around shrinking of a range which was previously missed, but an LTP test
> flagged up (seemingly by accident).
> 
> Basically, if you specify an input range that spans multiple VMAs, this is
> in nearly all cases rejected (this is the point of this series, after all,
> for VMA moves).
> 
> However, it turns out if you a. shrink a range and b. the new size spans
> only a single VMA in the original range - then this requirement is entirely
> dropped.
> 
> So I need to slightly adjust the logic to account for this. I will also be
> documenting this in the man page as it appears the man page contradicts
> this or is at least very unclear.
> 
> I attach a fix-patch, however there's some very trivial conflicts caused
> due to code being moved around.
> 

OK, I applied this as a -fix.

Moved the two new hunks into check_prep_vma().

Made sure the "We are expanding and the VMA .." hunk landed properly in
check_prep_vma().

I've pushed out the result, please check current mm-unstable.

