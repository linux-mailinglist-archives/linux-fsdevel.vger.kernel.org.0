Return-Path: <linux-fsdevel+bounces-14279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0187A6C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40B11F23B8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 11:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187A3F9C2;
	Wed, 13 Mar 2024 11:06:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB03EA7B;
	Wed, 13 Mar 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328012; cv=none; b=QwcIrrWg46KQeU8grUJMDqGF9+amZUEOFvAwbdgEI44Z/oS+sLO+/SgM4IH+q0x4ZDz3l8WBIcA/L6bzocHcBNG8a+m46O9Qq7eEhLophGTvCe/EDsQMuwy/QcqwDtCAXUhbosdylQeYQ649FjOeQQ863nJJdUXbgV4yMzvd7XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328012; c=relaxed/simple;
	bh=QUK/mXJR9TF8U4K49/iweWEftEMp+8kuzVs1kUkVfQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cGelar/KQbuQ9Yhch2BtPOplFzGLp/c2Lf1b4JNjPDUekxxU5Fg5k0MXGUl8qk4xSWtRucigKLeysTbMV18rAOm5D/hXElz8oGfdlWWfEFnIiJtQLihRk7lkYPDiw/c4+Ssb+s4Sjkhfl9cSgOmNM89rgWb3pUey3Nf7KGKlnKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 6A780205DB9A;
	Wed, 13 Mar 2024 20:06:48 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42DB6gvD219176
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:06:43 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42DB6gQj1312073
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 20:06:42 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42DB6fSW1312070;
	Wed, 13 Mar 2024 20:06:41 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <ZfFmvGRlNR4ZiMMC@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Wed, 13 Mar 2024 05:41:32 -0300")
References: <ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
	<87v86fnz2o.fsf@mail.parknet.co.jp>
	<Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
	<87le75s1fg.fsf@mail.parknet.co.jp>
	<Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
	<87h6hek50l.fsf@mail.parknet.co.jp>
	<Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
	<87cys2jfop.fsf@mail.parknet.co.jp>
	<ZfFcpWRWdnWmtebd@quatroqueijos.cascardo.eti.br>
	<878r2mk14a.fsf@mail.parknet.co.jp>
	<ZfFmvGRlNR4ZiMMC@quatroqueijos.cascardo.eti.br>
Date: Wed, 13 Mar 2024 20:06:41 +0900
Message-ID: <874jdajsqm.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> So you break the mkdir/rmdir link counting, isn't it?
>> 
>
> It is off by one on those images with directories without ".." subdir.
> Otherwise, everything else works fine. mkdir/rmdir inside such directories work
> without any issues as rmdir that same directory.

mkdir() increase link count, rmdir decrease link count. Your change set
a dir link count always 2? So if there are 3 normal subdirs, and rmdir
all those normal dirs, link count underflow.

Thanks.

> If, on the other hand, we left everything as is and only skipped the
> validation, such directories would be created with a link count of 0. Then,
> doing a mkdir inside them would crash the kernel with a BUG as we cannot
> increment the link count of an inode with 0 links.
>
> So the idea of the fix here is that, independently of the existence of "..",
> the link count will always be at least 1.

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

