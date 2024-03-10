Return-Path: <linux-fsdevel+bounces-14080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D848A877763
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 15:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845901F21B8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 14:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035CA376E4;
	Sun, 10 Mar 2024 14:59:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6967E10EB;
	Sun, 10 Mar 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710082781; cv=none; b=PdBKr3zeGvyEv9z+GHi2FqaPEeAv56ly5iLGZ7QoLZp8ICvW/1TMQu6DwvJxXx5Muo1G3P7CIbgDbEF1biJUzAAu+sOSjiwAhY9l2S3AFZNSich3g+RPYEhL8VvkwRTwFD1p98xcTBomqQMTLW41u0zdTdPwMG7kcQUaoLX77/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710082781; c=relaxed/simple;
	bh=5ch0BcEoY4QFgsjAL51akk8/crXIPVwzpgp1vVyzJCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T7RILc/dam3fT+uYMudzs5XmsdOW8eFt78gU9+fGUSClcvibrL76zXE9lWgJmNU1iIBlaWtONrIyFP7bv75Ojsx64sSLAvix4d1wv0UpNL8VnVrj87212wIiuKUYGHz8KXSoBTXDfiWXjQpUK9x5Ej7L0ne+OnWoeuUiMt+IOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E3B61205DB9A;
	Sun, 10 Mar 2024 23:59:36 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42AExZDr143133
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 23:59:36 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42AExZkw775659
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 23:59:35 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42AExYfT775658;
	Sun, 10 Mar 2024 23:59:34 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Sun, 10 Mar 2024 07:14:26 -0300")
References: <87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
	<874jdzpov7.fsf@mail.parknet.co.jp>
	<87zfvroa1c.fsf@mail.parknet.co.jp>
	<ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
	<87v86fnz2o.fsf@mail.parknet.co.jp>
	<Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
	<87le75s1fg.fsf@mail.parknet.co.jp>
	<Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
	<87h6hek50l.fsf@mail.parknet.co.jp>
	<Ze2IAnSX7lr1fZML@quatroqueijos.cascardo.eti.br>
Date: Sun, 10 Mar 2024 23:59:34 +0900
Message-ID: <87cys2jfop.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> If we really want to accept this image, we have to change the fat driver
>> without affecting good image.  And your patch affects to good image,
>> because that patch doesn't count directory correctly, so bad link count.
>> 
>
> Well, it does behave the same on a correct image. It ignores the existence of
> ".." when counting subdirs, but always adds an extra link count.
>
> So, images that have both "." and ".." subdirs, will have the 2 links, both
> with the patch and without the patch.

You are forgetting to count about normal dirs other than "." and ".."?

Thanks.

> Images with neither dirs will be rejected before the patch and have a link
> count of 1 after the patch. Still, creating and removing subdirs will work.
> Removing the bad dir itself also works.
>
> Images with only "." or only ".." would have a link count of 1 and be rejected
> without the patch.
>
> With the patch, directories with only ".." should behave the same as if they
> had neither subdirs. That is, link count of 1. And directories with only "."
> will have a link count of 2.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

