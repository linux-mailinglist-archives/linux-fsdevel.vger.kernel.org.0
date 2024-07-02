Return-Path: <linux-fsdevel+bounces-22980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF8C924BA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 00:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077AEB23B1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F3917A587;
	Tue,  2 Jul 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGaG6VsZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C171DA30E
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719959972; cv=none; b=Sap2R3cFhLXOUqomFBPYOanj1+eumcfpUFbzTDzo3B+UmR3ZgO8WJyECEPipJkMI29kXmngZcyEUaqbX8kzWzUl4r0ixOhqcczCfQo38feMpa7fq3jKxdR/83TnAxoBhh8EhyrENQEvCSrBqZ6i8oLvBylASJRolT2XPc1TUSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719959972; c=relaxed/simple;
	bh=76A+W8OanbIXb8meWmS1+nOao4PfXinYWl3p4SkyzrU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LdewLH/m5SZ/5qhQDebeC7DbVUwbuSpLWOAdMxfJYgmxxnBkVmeWUm5Jo1kOqwobdz3zxbHc976rFDdsId+ACAleEQd2XURL/SoWzXgTP5oYFhF5PbiLllTVzia0gTI18TZligYS8VvCenyHAd/XpKKy8FGNZd01FD/z08XC3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGaG6VsZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719959969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GVDgpj7ag0nPRjUnIfuugFXa4lrjCZ60aZiB22UDCFU=;
	b=IGaG6VsZhZ8DM7Q925drKpRRTrDL3Yqa0GNkCJ6EeJwei7Q0RWQjsF3vxNuFb6ZXqvewnJ
	y+JgMcYXfcrNhgH88ZsgNmFJ+wEwFoAqdCXALwnr9CsrjABqYM+inlRVp6PRAWWQDwNKIn
	uIiRZ+kXYKVssUENtAFkB3k65NG/fqE=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408--kcw_JHCMZq5DAmasJVu5Q-1; Tue, 02 Jul 2024 18:39:28 -0400
X-MC-Unique: -kcw_JHCMZq5DAmasJVu5Q-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3c9711ce9so473014639f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2024 15:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719959967; x=1720564767;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GVDgpj7ag0nPRjUnIfuugFXa4lrjCZ60aZiB22UDCFU=;
        b=IGM+dXcWdRlYxueIO3xAPuYwIfGKbyO5wpP6BBBftzsjsnQrQU2AxYdjwPlR4kWL+7
         vdZhBSEVyaDq0facOD2sDdmJP0zZItIkHxEMVuz9wehOFNU3fijS7bLrrW5qagZys4RS
         aM04bX+YC99cMH05iQFpu5QZqFg9CSM6uttuw256N50aauCgCVxPL+YoKfaggGBAYRYh
         mT9tUhp7XMkHxiD8+ea8RpEPlS4vq5LVGIMrDKeNjyls7mV43ezupkUvwfvmclGK1YgU
         iBhxgmK2aHvWdwZfGc0pI1NredvNvn1N6cVZ1zN8sI0fJ/2iyYunhN+DbzTkLva7Bzw4
         ge9w==
X-Gm-Message-State: AOJu0Yzc72HcFK1mrAA5HH4tBT8UaG5h6fUmtWgjV/CPbm1jIikdlJT9
	0kNUSu8yGCX9OUbergPNQWaT9HZh7ZVlHXPTgLf9xUEeJS1cKdLZAlOju7aoKI22IjQv5f1Iru/
	KHX13q8fi4JfLSLvnXl4w+HEh6S3QxqMp5dRVbAYyrN9TfbxR9BhHm2TY5k4MK+oEIzWI25ohTj
	S3VyzAPFL0PwKO5efCXITPVC9z8hXQFyjs8/vfQjvVAKmL3Q==
X-Received: by 2002:a05:6602:15c2:b0:7f6:19b9:3a3b with SMTP id ca18e2360f4ac-7f62edfe2e9mr1325447739f.1.1719959967245;
        Tue, 02 Jul 2024 15:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1YSgeEFq6srNtRNq1QuZ3K6q5UYyewAYoYL3+0oBXFvfYfNhgIql3qOORtB74sU1llMYePQ==
X-Received: by 2002:a05:6602:15c2:b0:7f6:19b9:3a3b with SMTP id ca18e2360f4ac-7f62edfe2e9mr1325445939f.1.1719959966870;
        Tue, 02 Jul 2024 15:39:26 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bc01a6sm3031373173.4.2024.07.02.15.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 15:39:26 -0700 (PDT)
Message-ID: <ec599fc8-b32e-48cf-ac6c-09ded36468d5@redhat.com>
Date: Tue, 2 Jul 2024 17:39:25 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V2 0/3] fat: convert to the new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This short series converts the fat/vfat/msdos filesystem to use the
new mount API.

V2 addresses the issues raised with the 2nd patch in the first series,
details are in patch this time.

I've tested it with a hacky shell script found at 

https://gist.github.com/sandeen/3492a39c3f2bf16d1ccdd2cd1c681ccd

which tries every possible option, including some with invalid values,
on both vfat and msdos mounts. It then tests random combinations of
2, 3, and 4 options, including possibly invalid options.

I captured stdout from two runs with and without these modifications,
and the results are identical.

As patch 2 notes, I left codepage loading to fill_super(), rather than
validating codepage options as they are parsed. This is because i.e.

mount -o "iocharset=nope,iocharset=iso8859-1"

passes today, due to the last iocharset option being the only one that is
loaded. It might be nice to validate such options as they are parsed, but
doing so would make the above command line fail, so I'm not sure if it's
a good idea. I do have a patch to validate as we parse, if that's desired.

Lastly, the 3rd patch converts to use the new uid/gid helpers as proposed
at https://lore.kernel.org/linux-fsdevel/8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com/T/#t
but feel free to squash patches 2 and 3 if you prefer.

Thanks,
-Eric


