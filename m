Return-Path: <linux-fsdevel+bounces-22640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A491AB76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 17:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A998B284DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8381991B9;
	Thu, 27 Jun 2024 15:28:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008E197A61;
	Thu, 27 Jun 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719502108; cv=none; b=fASkRQSpSoOg+8bqam3X+KxU4JScZjZqBSVKSROAg8DKPXJ8gjp4eqqyhjNjHiXVZo9JqmSfCJrwvJtQwcfCSK4WREJBmgnUzxKZI8VBmmAqAANJONubbuDEUkmEJG1KApG9s9dfvysWcf6znvP5e+stO+26hCcWfim11X2gRQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719502108; c=relaxed/simple;
	bh=HbuetP97OhPn2PucQXYuYhb6lAy9dew5SWP2gwy7epk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ItvZU2VGrFqKt9O013UWsveR9UA0FEHSs06+qPN/ALGUjXrfrs5/gW1otHIqUcDv59sYQ8ZvFuRc8k4rxVXjgtubCO1u42H0+0ZnBM6bJSfKSOLLhW/5aSY3svz6lQEnQTku2UvEPbUo3zqlMTYcxIfJIKCkUKm772+UKncGA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C45A62055FA2;
	Fri, 28 Jun 2024 00:28:16 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 45RFSFAl004936
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 00:28:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-4) with ESMTPS id 45RFSFFO018977
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 00:28:15 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 45RFSEDH018975;
	Fri, 28 Jun 2024 00:28:14 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH v2 2/2] fat: always use dir_emit_dots and ignore . and
 .. entries
In-Reply-To: <Zn1gQeWToPNkp9nt@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Thu, 27 Jun 2024 09:51:13 -0300")
References: <20240625175133.922758-1-cascardo@igalia.com>
	<20240625175133.922758-3-cascardo@igalia.com>
	<871q4kae58.fsf@mail.parknet.co.jp>
	<ZnxwEtmYeZcKopJK@quatroqueijos.cascardo.eti.br>
	<87a5j7v517.fsf@mail.parknet.co.jp>
	<Zn1gQeWToPNkp9nt@quatroqueijos.cascardo.eti.br>
Date: Fri, 28 Jun 2024 00:28:14 +0900
Message-ID: <87jzial81d.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> First of all, I'm not thinking this is the fix, I'm thinking this as the
>> workaround of broken formatter (because the windows's fsck also think it
>> as broken). So very low priority to support.
>> 
>> As said, I also think low chance to break the userspace. However it
>> changes real offset to pseudo offset. So if userspace saved it to
>> persistent space, breaks userspace. Unlikely, but I think there is no
>> value to change the behavior for workaround.
>
> So I started doing some investigation and that lead me to the following
> code from fs/fat/inode.c:
>
> static void fat_evict_inode(struct inode *inode)
> {
> 	truncate_inode_pages_final(&inode->i_data);
> 	if (!inode->i_nlink) {
> 		inode->i_size = 0;
> 		fat_truncate_blocks(inode, 0);
> 	} else
> 		fat_free_eofblocks(inode);
> [...]
>
> That is, since the directory has no links, once it is evicted (which
> happens right after reading the number of subdirectories and failing
> verification), it is truncated. That means all clusters are marked as FREE.
> Then, later, if trying to fsck or mount this filesystem again, the
> directory entry is removed or further errors show up (as an EOF is
> expected, not a FREE cluster).
>
> And that is caused by attributing a number of 0 links. I looked it up on
> how other filesystems handle this situation and I found out that exfat adds
> 2 to the number of subdirectories, just as I am suggesting. When
> enumerating the directories (at its readdir), it also relies on
> dir_emit_dots for all cases.

Because exfat doesn't have "."/".." always, IIRC.

> As for programs persisting the offset, the manpage for telldir has on its
> NOTES section:
>
> """
> Application programs should treat this strictly as an opaque value, making
> no assumptions about its contents.
> """
>
> I know this doesn't refer to persisting or not that opaque value, but any
> other changes to the directory would change the offset of its current
> subdirectories and given those values are opaque, no assumptions should be
> made. And unless we find such programs in the wild, the same argunent could
> be made that there may be programs that expect . and .. to be at offset 0
> and 1, like every filesystem that uses dir_emit_dots does.
>
> I understand the cautiousness to prevent regressions, but I did the work
> here to test and understand the changes that are being proposed. I even
> looked into another way of preventing the further corruption, but that
> convinced me even more that the right fix is to assign a minimum number of
> links to directories and I found precedence to this.

I seriously recommend to change app that make this, or changing the fsck
to fix this. Because this looks like broken as FAT.

Honestly I'm not accepting willingly though, the way to add the
workaround for this would be, detect this breakage and warn it, then
mark the dir inode as broken. And add the workaround codes only for
broken dir inode, and make it work for all operations (just make
mountable and readable is not enough, at least write must not corrupt fs
or panic etc.), without changing the behavior of correct inodes.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

