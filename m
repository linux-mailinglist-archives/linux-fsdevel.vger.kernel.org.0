Return-Path: <linux-fsdevel+bounces-14073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5427877575
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 06:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0261C215CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 05:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC112B72;
	Sun, 10 Mar 2024 05:52:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F016FF54;
	Sun, 10 Mar 2024 05:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710049960; cv=none; b=M3teIGNk9JSW+aNEw1pxvnsz5qivnqZX0WJrZxbKTsLficdXJEwC6t7ZJyMSVzolTlQJPz1c5hwcx4kwtgNyFzT0iCQCS2y8WwmWKGp8cA9aQAdKQYw+knvMts4B8Pvz5uarZIImk+O+oEaI1agoZ3ZKkpp6dHFz1Wj9S2lAGGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710049960; c=relaxed/simple;
	bh=A9LW5U9UCJNGxciKUSGPD7E5AULsadj2d4L30+gwoGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yc47rR+iXtz1k/lqaj4Eq6e7S4n5liqsgwpyJ3qAU+6fBLSdFc/YTYi7WPy4i3YSAM2ffUSXMm7h2NOiObsOjNttgq1MUfiJVNQJ/NmvSzsqXz5yQhMFxP1GVVyIxj+ibLh1OkgyV80YkGOG74TOE4xWx8DP4bCqAQQzGhKhy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 358C5205DB9A;
	Sun, 10 Mar 2024 14:52:30 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42A5qRD9134432
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 14:52:28 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 42A5qRJl710650
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 Mar 2024 14:52:27 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 42A5qR0w710649;
	Sun, 10 Mar 2024 14:52:27 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Wed, 28 Feb 2024 06:10:22 -0300")
References: <20240222203013.2649457-1-cascardo@igalia.com>
	<87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
	<874jdzpov7.fsf@mail.parknet.co.jp>
	<87zfvroa1c.fsf@mail.parknet.co.jp>
	<ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
	<87v86fnz2o.fsf@mail.parknet.co.jp>
	<Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
	<87le75s1fg.fsf@mail.parknet.co.jp>
	<Zd74fjlVJZic8UxI@quatroqueijos.cascardo.eti.br>
Date: Sun, 10 Mar 2024 14:52:26 +0900
Message-ID: <87h6hek50l.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> Can you share the image somehow? And fsck (chkdsk, etc.) works without
>> any complain?
>
> Checking the filesystem on Windows runs without any complains, but it turns the
> directory into an useless lump of data. Without checking the filesystem,
> creating and reading files from that directory works just fine.
>
> I tried to use gzip or xz to compress the very sparse filesystem image that I
> got, but they made it larger on disk than it really was. So here is a script
> and pieces of the filesystem that will create a sparse 8GB image.

I tested a your image with some tweaks. Windows's chkdsk complains about
"BADDIR" directory, and it was fixed by converting it to normal
file. Probably, chkdsk thought that "BADDIR" got ATTR_DIR bit by
corruption.  IOW, Windows FATFS driver may accept this image, but
Windows also think this image as corrupt, like chkdsk says.

I think the app that make this should be fixed. Windows accepts more
than linux though, it looks also think as corrupt.

If we really want to accept this image, we have to change the fat driver
without affecting good image.  And your patch affects to good image,
because that patch doesn't count directory correctly, so bad link count.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

