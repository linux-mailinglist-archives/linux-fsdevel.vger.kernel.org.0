Return-Path: <linux-fsdevel+bounces-17624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114468B07D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3876BB22995
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 10:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292DA15A48D;
	Wed, 24 Apr 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="OADCJtgd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFE715959D;
	Wed, 24 Apr 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713956324; cv=none; b=rJsak6qgPGwNqGZ2IHjxPuASjgZ6CwZlEiS7q5fxH3/eEix0Btlrynjuw0CcQHw9eWlmcsGmgwlQw9Mb+/kmfgAf0h6lwwTanYVCdNVLciK5YEkeScz4/stpoh9fYOEB0BjVy8y+4g4s5Ry/w3T0d+tfczLYBJngZx1teTd1++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713956324; c=relaxed/simple;
	bh=6LVH3PMc3HV4V2K+Dpc6Qj7ZwEmZNYbYIZFfgi+/FHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ua4vG0/DctKB/DQRXVwUeZafKHIYcOGIbk4HLibXM8M8Gqnml0fCHSa4cCjVPoVms5s21srI2dpNF4W+XdZfCdo9WuMkaqA/CDBCwGzn0veL9JMJJtav3My8FM7hvgZtsJix2JkNuLTo9JpzmsyydECXSWHPvpOP55ITtUh6Ri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=OADCJtgd; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:b1a0:0:640:e983:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id 178145E9F6;
	Wed, 24 Apr 2024 13:58:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cwIcqh6n3Cg0-0uZpi2sj;
	Wed, 24 Apr 2024 13:58:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713956319; bh=4BFA1sAD3ohdn1FKW4iPGQkacFKBfyHkGIvKIFJupi0=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=OADCJtgd9oliRn+jzQHPuuXfudrvWU+UTsJrTT3QfKTBqJ0y0vuQwlDb9diZRqda2
	 hDlXLaJQ0y6aN8W9udExpL2ldrd8i4qhMY/dZH8gicqlfaNLhCdqIX8GkwtZw+t9xU
	 JiQaarBJixNpo54b9KU65AjYgRR0I26pwfY5pH78=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <6c9e5914-8dee-4929-b574-f59f50305f4a@yandex.ru>
Date: Wed, 24 Apr 2024 13:58:38 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: reorganize path_openat()
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andy Lutomirski <luto@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

24.04.2024 12:17, David Laight пишет:
> You probably ought to merge the two 'unlikely' tests.
> Otherwise there'll be two conditionals in the 'hot path'.
> (There probably always were.)
> So something like:
> 	if (unlikely(op->open_flag & (__O_TMPFILE | O_PATH))) {
> 		file = alloc_empty_file(op->open_flag, current_cred());
> 		if (IS_ERR(file))
> 			return file;
> 		if (op->open_flag & __O_TMFILE)
> 			error = do_tmpfile(nd, flags, op, file);
> 		else
> 			error = do_o_path(nd, flags, file);
> 	} else {

Posted v4 with this code verbatim.

> Copying op->open_flag to a local may also generate better code.
Done this as well.

Thank you.

