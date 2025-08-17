Return-Path: <linux-fsdevel+bounces-58103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB0EB294A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 19:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2893E5E4340
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5463E2FF16A;
	Sun, 17 Aug 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V8wZJlvp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7C41FE44D;
	Sun, 17 Aug 2025 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755453208; cv=none; b=GJCsEWXiArvjTd0Y9tNK61Bk0D4ysXLdfDt5+O3No7SMuuGhiklznH38rbipe1Bc7EiUR2aBQ3uWZImz1PbYQ2GLnD1bVb85JNy+0LFdgzgfP/xYbIbxl6+UuUVTMmGE6hXq9oGfTvPFZKoJBBiNUan4KVeRz1p1OhvepgFKYWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755453208; c=relaxed/simple;
	bh=FV4d31vXhnlOKKl/LB3jEBZ+4DI35Ta4or8jtC6m4R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luqhL+LXDp3qiUGLEVBhbsQr29pFk46r1QtJGX0nIxcN0c/QCabMSQXbgpXkNWqJJ3mpaSySRRyUIyxZJhYuqTmjDl9HERQ1Rgbx5CCVSmuY67pG+q8uMXC5yvErfYk56tlHnfGJ4IJOYcr19lyvw7yDVZTugKz7PcmnxM4i+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V8wZJlvp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5wQD3GdET98B4Lqz6XgdVTX0c9q0vaiXjYgw1oAWM14=; b=V8wZJlvp1ic0GFInj/QJuEoygj
	LULYokP2N7G84XDhd9l9pfkEhYBQSaeWy/MSEJ3plWdDsliEZBjQqkK+c/KTsSkzX8CSXH/rAD+Pz
	4JyoLYpusNz0zU1Np+zphov6ww03RucAleeGSbQOtfbgxHFC2YW0FkQ7L69mAIoYHSpH9HAzim73q
	FoNGhECzauwINnrVMKHM0D0qu4H5wtTTgNcDm4mRHlRxwQL5cpAh7RumgnerF1cRl74OPyXP/2U6s
	H61esojmSqAUYK5/0x3xp6rPjQPwcaIxr2bIr6a0XS+QdUOXljQJiTWimpPLu1A2Ow9McVV+srFLH
	DyouxmEw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unhZH-0000000BVBb-3hM3;
	Sun, 17 Aug 2025 17:53:19 +0000
Date: Sun, 17 Aug 2025 18:53:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	cyphar@cyphar.com, Ian Kent <raven@themaw.net>,
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	autofs mailing list <autofs@vger.kernel.org>,
	patches@lists.linux.dev
Subject: Re: [PATCH 4/4] vfs: fs/namei.c: if RESOLVE_NO_XDEV passed to
 openat2, don't *trigger* automounts
Message-ID: <20250817175319.GY222315@ZenIV>
References: <20250817171513.259291-1-safinaskar@zohomail.com>
 <20250817171513.259291-5-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817171513.259291-5-safinaskar@zohomail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 17, 2025 at 05:15:13PM +0000, Askar Safin wrote:

> @@ -1472,6 +1484,10 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
>  		/* Allow the filesystem to manage the transit without i_rwsem
>  		 * being held. */
>  		if (flags & DCACHE_MANAGE_TRANSIT) {
> +			if (lookup_flags & LOOKUP_NO_XDEV) {
> +				ret = -EXDEV;
> +				break;

I don't thing it's right in RCU mode, if nothing else...

