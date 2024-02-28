Return-Path: <linux-fsdevel+bounces-13041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D393886A740
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 04:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108891C26B1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 03:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C2200D2;
	Wed, 28 Feb 2024 03:38:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7879200AE;
	Wed, 28 Feb 2024 03:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091536; cv=none; b=pQp6tIycDgldsSPR1spbbiTE6o0CTaoonYFlldgVJ5qSuH+pIDEnCkJaTiqjoefg8HYYp+JHRDdEGzRTOKr/i5DGTgucqGH04Ozf7oYmF8rLab7zdzz+ZiD6yd2o34ZhHOXPPJaxpmDzY8vIS5q2ixEjhYatFEcSZD4am5YKF5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091536; c=relaxed/simple;
	bh=66pK7h/am21d6FIDhREV3IGN95EvFDSuL+CsDkHepgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAYwzg87su0LM4fOTjx7+0GSS210SpJ0sVKv/U63SVJIFJbs0hOYKBzOxxFDC/iTETFLxz0fJlw7qD3kYqaaxbWsoKDfNULR8nbeMCZ3yrmCET7Eg3G+8TZAK0/GhfZaZ7HGJW6mX6+e0lNw02s2o13VBXOsyDl8OA86WL9H0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id E4E482055FA1;
	Wed, 28 Feb 2024 12:38:45 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41S3ciHC284101
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 12:38:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41S3cign1670619
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 12:38:44 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 41S3chq11670618;
	Wed, 28 Feb 2024 12:38:43 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Tue, 27 Feb 2024 22:42:15 -0300")
References: <20240222203013.2649457-1-cascardo@igalia.com>
	<87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
	<874jdzpov7.fsf@mail.parknet.co.jp>
	<87zfvroa1c.fsf@mail.parknet.co.jp>
	<ZdhsYAUCe9GVMnYE@quatroqueijos.cascardo.eti.br>
	<87v86fnz2o.fsf@mail.parknet.co.jp>
	<Zd6PdxOC8Gs+rX+j@quatroqueijos.cascardo.eti.br>
Date: Wed, 28 Feb 2024 12:38:43 +0900
Message-ID: <87le75s1fg.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

>> There are many corrupted images, and attacks. Allowing too wide is
>> danger for fs.
>> 
>> BTW, this image works and pass fsck on windows? When I quickly tested
>> ev3fs.zip (https://github.com/microsoft/pxt-ev3/issues/980) on windows
>> on qemu, it didn't seem recognized as FAT. I can wrongly tested though.
>> 
>> Thanks.
>> -- 
>> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> The test image I managed to create mounts just fine on Windows. New
> subdirectories can be created there just as well.

Can you share the image somehow? And fsck (chkdsk, etc.) works without
any complain?

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

