Return-Path: <linux-fsdevel+bounces-14285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA587A7BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C844B1F24642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6497F3A1CB;
	Wed, 13 Mar 2024 12:43:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0738F2BB09;
	Wed, 13 Mar 2024 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333827; cv=none; b=szjkbKdGYsMlr9qH3xnr8gX1XRpxFldtCp9mIUw1w2qzgDdR8uRPPKiN0knQ+ccssDa6gdLECWRT0PO+ajfNeeeM860UaSdRgRw4aiIRRSbXAD+4dMpkwx3KvNikHgU4bMzJaCJRDKXkcEEoMTcSSuEaZNanbNRKMo9uDUv7W8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333827; c=relaxed/simple;
	bh=JnCsaxUnb/cF6AyWmh2AiBaTUlyLUY6tgAL031/OaCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oPPPDzh20iNhEtm2RaPEJPbSRTwdwIvcV3OHrdwBzilVVltsGQipX/4jqIYGwLWRMlONEpPUw7D2PoMCaEk+hL5uPdCqIVNJayXLu9zN1vQWchkIOeZPBPF30wdHoI5Yj0F9l06Y0zYklfXX/W8rw6IW6iIGRKVMW082unYjaTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 03914205DB9A;
	Wed, 13 Mar 2024 21:43:43 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42DChaQV220242
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 21:43:37 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42DChaaN1323405
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 21:43:36 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42DCharF1323404;
	Wed, 13 Mar 2024 21:43:36 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <ZfGLIl7riu0w2pAm@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Wed, 13 Mar 2024 08:16:50 -0300")
References: <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
	<87le75s1fg.fsf@mail.parknet.co.jp>
	<Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
	<87h6hek50l.fsf@mail.parknet.co.jp>
	<Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
	<87cys2jfop.fsf@mail.parknet.co.jp>
	<ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br>
	<878r2mk14a.fsf@mail.parknet.co.jp>
	<ZfFmvGRlNR4ZiMMC@quatroqueijos.cascardo.eti.br>
	<874jdajsqm.fsf@mail.parknet.co.jp>
	<ZfGLIl7riu0w2pAm@quatroqueijos.cascardo.eti.br>
Date: Wed, 13 Mar 2024 21:43:36 +0900
Message-ID: <87zfv2i9on.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> On Wed, Mar 13, 2024 at 08:06:41PM +0900, OGAWA Hirofumi wrote:
>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
>> 
>> >> So you break the mkdir/rmdir link counting, isn't it?
>> >> 
>> >
>> > It is off by one on those images with directories without ".." subdir.
>> > Otherwise, everything else works fine. mkdir/rmdir inside such directories work
>> > without any issues as rmdir that same directory.
>> 
>> mkdir() increase link count, rmdir decrease link count. Your change set
>> a dir link count always 2? So if there are 3 normal subdirs, and rmdir
>> all those normal dirs, link count underflow.
>> 
>> Thanks.
>> 
>
> No. The main change is as follows:
>
> int fat_subdirs(struct inode *dir)
> {
> [...]
> 	int count = 0;
> [...]
> -		if (de->attr & ATTR_DIR)
> +		if (de->attr & ATTR_DIR &&
> +		    strncmp(de->name, MSDOS_DOTDOT, MSDOS_NAME))
>  			count++;
> [...]
> 	return count;
> }
>
> int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
> {
> [...]
> 	if ((de->attr & ATTR_DIR) && !IS_FREE(de->name)) {
> [...]
> -		set_nlink(inode, fat_subdirs(inode));
> +		set_nlink(inode, fat_subdirs(inode) + 1);
> [...]
> }
>
> That is, when first instatiating a directory inode, its link count was set to
> the number of subdirs it had, including "." and "..". Now it is set to 1 + the
> number of subdirs it has ignoring "..".
>
> mkdir and rmdir still increment and decrement the parent directory link count.

Ah, sorry, I misread.  So next, it should create "." and ".." on initial
create/mkdir or such, like mkdir does.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

