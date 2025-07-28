Return-Path: <linux-fsdevel+bounces-56142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C2B13F8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55280169604
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96518274B30;
	Mon, 28 Jul 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vkPBvm2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364722749FA;
	Mon, 28 Jul 2025 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753718697; cv=none; b=MrPxfeUOo610LfW8tHNwvoeRlmkrFI3/dxcZ+tTIfTdGfWEOk2K/SfN5nnLf8iO7jVoGtgUGmF8IteOccMaG12IHvQ8SdrusaumArLALuMbqR7SxLXja9h5f+Bv3jcmWjUIsFWrTTUzgLfXyM13RA2as3hvB24/G3Haoq9UMdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753718697; c=relaxed/simple;
	bh=4DzNpTaAkyb75TjI+d9QFdkd5rn0x5BwMBfG39WZh5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzFSc5kD4feT/lojgfyChxsHNG4Fwyyi0xSfTg1SJb3eZpE3o3gJ5IB2v42MgEz6EAHl34hiDVOSo14gBB713cLWgmvsYMny780e9gpTHotT7WC5nYGa1m7OvfWzyVQkCg8s5O2X/EVgHY50c3C7C8d09GY6Z0EYdflMKJGqaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vkPBvm2N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fkErh0ZXD+pmYfouBjE2XswJsFT87vWSoa2v27OLXCc=; b=vkPBvm2NLiUNMGPhAyD6jWvWJK
	S3OQmIQD7KBxaUBx13whcZcpm1eQEjIbpGVCxojTecNay18WGgzd2MSfJBg0QGUHizTOVvHBUksaG
	DStSJCKVQ0xWsuyh2T6RcJLEvxmhxw+cIWu+MdaZbrozOz3jbHykJQJxxK/sIKX4SmUhdS/kMS7qd
	KRkUOPZYcENoNugoRsCQxYK9L8UgvEbMnQp0TBFQ5I+qqVI9+aLpREa+gy31AyhmMIrAToi31BwF1
	FCupNPhLaQh3d4VymM1IeIM/rQAoA6ixuYyQxWDSKNfJSmZskhZka9bM/jDdOhZCeydnogRoCAZBK
	d0T7NGyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugQLF-0000000BGhi-2qsT;
	Mon, 28 Jul 2025 16:04:45 +0000
Date: Mon, 28 Jul 2025 17:04:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32
 entry
Message-ID: <20250728160445.GC222315@ZenIV>
References: <6887321b.a00a0220.b12ec.0096.GAE@google.com>
 <tencent_E34B081B4A25E3BA9DBBB733019E4E1BD408@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E34B081B4A25E3BA9DBBB733019E4E1BD408@qq.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 28, 2025 at 07:37:02PM +0800, Edward Adam Davis wrote:
> The writer and reader access FAT32 entry without any lock, so the data
> obtained by the reader is incomplete.

Could you be more specific?  "Incomplete" in which sense?

> Add spin lock to solve the race condition that occurs when accessing
> FAT32 entry.

Which race condition would that be?

> FAT16 entry has the same issue and is handled together.

FWIW, I strongly suspect that
	* "issue" with FAT32 is a red herring coming from mindless parroting
of dumb tool output
	* issue with FAT16 just might be real, if architecture-specific.
If 16bit stores are done as 32bit read-modify-write, we might need some
serialization.  Assuming we still have such architectures, that is -
alpha used to be one, but support for pre-BWX models got dropped.
Sufficiently ancient ARM?

