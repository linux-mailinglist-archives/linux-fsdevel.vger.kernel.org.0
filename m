Return-Path: <linux-fsdevel+bounces-73903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBF4D2352E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 10:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA5D303C284
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F10E34026B;
	Thu, 15 Jan 2026 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="OYfw2Sur";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="ArK7qpn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F626A1B9;
	Thu, 15 Jan 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467545; cv=none; b=Cs+hEsdr2pQjfz2FoOEvXclhoU0Uw3MkrD/RYrQxaLEw5uiV33YQMUuw0VKtuS7yTUGLZz92PB6EFFSvi/JeTJc5f1MbBMWlIMajw81H/zasyAbcVwzLFFn6rWdPVXbnMIgztB0y5nXQibk0vw1pK+rIjKDl9jtMPcSDTXl8OeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467545; c=relaxed/simple;
	bh=8YPpj0NEeIuqe+udAz3jb2y7qjyI7ASecGv0DFM4yLU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XaWtVm0fFk92nSoEUREI11wjHS9/BbhQCVfNA62rCwoRqK7kXYduMnmKzXygK85hw/ZC59Mp/2MaeRfxFl9YiLbDn8MVJ/g0vA0yUsYu28/lsvDIMckAQoyuf+ieB2UzQldBmeN2UPx2dCNNZlAAbsNe2BmLcwOwHAtEJSrDhrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=OYfw2Sur; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=ArK7qpn4; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 59948209655C;
	Thu, 15 Jan 2026 17:58:53 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1768467533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=239oZ275b6smCS74K1tWdjRS0BNLiePy77vuyzqmFog=;
	b=OYfw2Sur1UuFe52+b+QneplE8FQ8rN3ZPZNmHUjXZ8I3EUbVeENQa9S7UE9y2K/+XwV3SQ
	I/ZZv2vblo2O4gCBhhbii9EMgTIhTnJ/l+EBkDsJz7Ar+ySVu32QBZ6Gv6ZPTUT/orvUyF
	1QfiBPAonvwEk/e0naEnhF3vz9jWm+xYwR6FdzXz0RU8n3PI0yjEuiVMmzDnXYu3FOUwsO
	ju7euX7+j6w8JoZ6Ylar2ikJfzTuIaPaPoZvjemwpemy6GSLCFLAZkIp5MRiF8qr7GeUC3
	Po5ictZNHCSisTuUNKKDZ7KlEQmc0+zpktZuVHakaOIbuZMCSLmk2ou/QrzuiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1768467533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=239oZ275b6smCS74K1tWdjRS0BNLiePy77vuyzqmFog=;
	b=ArK7qpn4FSYfiTqDwLBIMwdc8g0BdjAmYQzNjX9MTC6w813MFWfk5weBlFC8Egh9ZmVWC0
	pvksDNyaiFFxs1Dg==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60F8wqQB134411
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 17:58:53 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 60F8wpYn351446
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Jan 2026 17:58:51 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 60F8wnRr351445;
	Thu, 15 Jan 2026 17:58:49 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        <linux-nfs@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
        linkinjeon@kernel.org, sj1557.seo@samsung.com, yuezhang.mo@sony.com,
        almaz.alexandrovich@paragon-software.com, slava@dubeyko.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, cem@kernel.org, sfrench@samba.org,
        pc@manguebit.org, ronniesahlberg@gmail.com, sprasad@microsoft.com,
        trondmy@kernel.org, anna@kernel.org, jaegeuk@kernel.org,
        chao@kernel.org, hansg@kernel.org, senozhatsky@chromium.org,
        Chuck
 Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v4 02/16] fat: Implement fileattr_get for case sensitivity
In-Reply-To: <20260114142900.3945054-3-cel@kernel.org>
References: <20260114142900.3945054-1-cel@kernel.org>
	<20260114142900.3945054-3-cel@kernel.org>
Date: Thu, 15 Jan 2026 17:58:49 +0900
Message-ID: <874ionw8ty.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chuck Lever <cel@kernel.org> writes:

> +int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
> +
> +	/*
> +	 * FAT filesystems are case-insensitive by default. MSDOS
> +	 * supports a 'nocase' mount option for case-sensitive behavior.
> +	 *
> +	 * VFAT long filename entries preserve case. Without VFAT, only
> +	 * uppercased 8.3 short names are stored.
> +	 */
> +	fa->case_insensitive = !sbi->options.nocase;
> +	fa->case_nonpreserving = !sbi->options.isvfat;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fat_fileattr_get);

Hm, if "nocase" option is specified for msdos, it would be the case
preserving (ignores/breaks the spec though).

I.e. on msdos mount with "nocase" works like the following

    $ touch aAa.txT
    $ ls
    aAa.txT

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

