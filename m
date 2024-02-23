Return-Path: <linux-fsdevel+bounces-12548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C523860C46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9E91C24AA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5118EB1;
	Fri, 23 Feb 2024 08:27:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F414F17C9E;
	Fri, 23 Feb 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676834; cv=none; b=ldFQYvBtyqG8Z/iRM/RaPwvjzw3dYW2qWbDmSOb/6J6ilcvUq3EdOK6jH51emM5W/nW5cXeWIlOr/gkVfypWXp3/EBKYxwYtU5pHBRIqEGcJ8Q60yy0TkSl1oum3FN5tk/JPGi7tO2yjQiniFSMfgie0jCaXYn9lKVLmgxQ0Dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676834; c=relaxed/simple;
	bh=1ndl2jwEP/nNUP8s6SSUqM2otyCLFT+mXsleq3UHp4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U7Lw5rBQpkyiEhRxVjbNhK779ehHAGSsmBEzCDa8QRT/Z0/LZ3uAN8fut+5+MrLqnE61jjm3ULsZcFMuo4kJ0KjvaYnN4T2vQ8XKBTrZDgMHHJPf8v4lLXmPDNXn7l4Uer7mW9E55YIiFRmxn2H4GGL3gUfydOeaXBMrAgMrgmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id ABF63233CCB7;
	Fri, 23 Feb 2024 17:27:10 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41N8R9O9212176
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:27:10 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-1) with ESMTPS id 41N8R9KO1007742
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:27:09 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 41N8R8u71007741;
	Fri, 23 Feb 2024 17:27:08 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gwendal
 Grignou <gwendal@chromium.org>, dlunev@chromium.org
Subject: Re: [PATCH] fat: ignore .. subdir and always add a link to dirs
In-Reply-To: <Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br> (Thadeu Lima de
	Souza Cascardo's message of "Thu, 22 Feb 2024 23:02:16 -0300")
References: <20240222203013.2649457-1-cascardo@igalia.com>
	<87bk88oskz.fsf@mail.parknet.co.jp>
	<Zdf8qPN5h74MzCQh@quatroqueijos.cascardo.eti.br>
Date: Fri, 23 Feb 2024 17:27:08 +0900
Message-ID: <874jdzpov7.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:

> On Fri, Feb 23, 2024 at 10:52:12AM +0900, OGAWA Hirofumi wrote:
>> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> writes:
>> 
>> > The tools used for creating images for the Lego Mindstrom EV3 are not
>> > adding '.' and '..' entry in the 'Projects' directory.
>> >
>> > Without this fix, the kernel can not fill the inode structure for
>> > 'Projects' directory.
>> >
>> > See https://github.com/microsoft/pxt-ev3/issues/980
>> > And https://github.com/microsoft/uf2-linux/issues/6
>> >
>> > When counting the number of subdirs, ignore .. subdir and add one when
>> > setting the initial link count for directories. This way, when .. is
>> > present, it is still accounted for, and when neither . or .. are present, a
>> > single link is still done, as it should, since this link would be the one
>> > from the parent directory.
>> >
>> > With this fix applied, we can mount an image with such empty directories,
>> > access them, create subdirectories and remove them.
>> 
>> This looks like the bug of those tools, isn't it?
>> 
>> Thanks.
>> -- 
>> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Which they refused to fix, arguing that there are already filesystems out there
> in the world like that. Also, there is argument that this works on Windows,
> though I haven't been able to test this.
>
> https://github.com/microsoft/pxt-ev3/issues/980
> https://github.com/microsoft/uf2-linux/issues/6

OK.

If you want to add the workaround for this, it must emulate the correct
format. I.e. sane link count even if without "."/"..". And furthermore
it works for any operations.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

