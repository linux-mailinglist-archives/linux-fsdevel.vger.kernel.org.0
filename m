Return-Path: <linux-fsdevel+bounces-58092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E50AB29384
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 16:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BAA1B25D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Aug 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8CB2E7F10;
	Sun, 17 Aug 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="HJOGyR/V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587B2E5D29
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441125; cv=none; b=CTUpvPiZq/+w43LO7Ea5T+Bzjv5QCVyZO5RT6Z9U+nP9emTdD8vl/ak1ZjoL4ip0AtWm/YtwYnDBKuWWxLKzFtUJFBxA8gpF047a5DDDGtNzmxc3RtVdLlCL7VhIyTi1Z6Jzqwas5kTEduMklKpbmHqakAt85Q7jv4YuuXLYm/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441125; c=relaxed/simple;
	bh=APuY7IGlNJIfYkO2UMEto4k+JamrjlxmiPB1aZdUYeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFZEYFcc70lbnV2EQNC8vWtSBYU3m1sw0XBEFQy/qtEikccqPr6qFcpgUIofaqg22XmWvC+BSkjxV60tz8QK3XKAfbKnhU7qD+yKjeC1+9Bgt2hEaGVSntTifuyXpbUw1MCyjS/CeKOJXiLn2dmHXtOydFLyI21wp1OR1kVnfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=HJOGyR/V; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e87063d4a9so390512885a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Aug 2025 07:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755441123; x=1756045923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+77cBk30AgluRk5dNpA6LNSEUzxmOCjKbabXfN6tOQ=;
        b=HJOGyR/VfIe/AZKuQi11FVI3pK3W7p/BbZJXAMMoEpxfJkHYaLOK8120/ejgob8ZrC
         fbTobDKM2Ua/dA4nBKtmxr8iZTLrAirb3tfzmGMDxSUWk3KoVZQQvoVJLGM7GWtPRw2V
         zofHAsi/TZDVd+3B9/Edcr5Bb683pRl5OSSTYmpULg6xyd0E+OMbsBeipJbHZPf0vxEF
         In4uUypXr61iELgLQetx+GobfOR1bwQbdLKdhn976V2INOMJ76cBliEeu2s2AAc1T72j
         g8ar2RIt15BL+4aql7QgTrkvdMKr++yQaExTNCCP2nhrdrfxiBkDKBNKqiZfKru9Tm/K
         DNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755441123; x=1756045923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+77cBk30AgluRk5dNpA6LNSEUzxmOCjKbabXfN6tOQ=;
        b=ngQa/rIqvUCm7JQtm6shzLJxfbKkGshO4f/KlXweyqC8LL5jG5bUiOAdvztcIV8FYo
         G9g9li/axxMTqb9sANS2wK+ZC1DPfDguTi5szyhfAXUGcsAHzP65Yd7CK4HYwooV5WWa
         9750x8CYygAoqeO9xRMNDP/wjOMHtWYNWGtvySWQhvQFoUvNsJ5yN7efDCOVZqXh8juO
         vcmAcjWpiaiOr/kWCnMoIvnuh8u7DEo/SCxUxhncK3EkxsBFzaSDN08haiu/UwLQdePI
         Hv/UOecyIhRu06ssT1AGGtTltOpvqHgpI5RA84a7US6sV4KRP4V4F2ppoHUWYTGvMtPn
         dQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCU8lqAyRisb8EFxr961pvp5rZRmFd/G7oBZXYn8PytzZWrGNAF4w+oMz2XHoLORn6fTtmjbkb37fwGwRczM@vger.kernel.org
X-Gm-Message-State: AOJu0YwopYPfbfsAMh9NmNStvn05nQKt65ggsJ5Vn/5GXYIwt0/a+46S
	aDaW5C4LRnOiKcngQXm0acTfV2PNnH57XBeUWtK5NzTNhWLV/za0D71dCzJLFkkiCRw=
X-Gm-Gg: ASbGncuOWZmyFF8WDZmVocpotHLQjOrRvoOXgojIrlSdZXiS5+QH3w/vEara0HPmqoT
	XcBJfmJSTePQwQyJMHYLunsryNheSgcRi8YRcaCJ93ZF9q+woJlp3qeLyn2ZlPKr104aQ4tGNE2
	Y/QLOujs1Rg5gBydhU6bPAgnyBu8kdCvX7ybe4To0LlIASp1K7NQ+nrJKY9J8seoH6DkiXwcHel
	nfiI5Zmy/EcQdqzD8r+rH9EC+cqcLfrD/xhTl92O3mwSopCtBXAQ84VzablWJ3CVMTHzFHGU4p6
	OPESkYxycG0VICDrfF4cZ8gs+W9CVraNFlKp6wjPn6o5wnG7994ayo7Rr6xU7WlJHnYdBsFFnfG
	NJILBThpLWHgM+jTxjQfDQdoN28OfkgnkQa1SNXIWwusklrJ0
X-Google-Smtp-Source: AGHT+IGY+MsSBNuYrWIdq4vldi7/pBPvMxygBrn12VlSeZTZnUkrutReObMqx5vxy+aFdSI9qkm8Wg==
X-Received: by 2002:a05:620a:2985:b0:7e6:604f:f747 with SMTP id af79cd13be357-7e87e1389e6mr1228444785a.63.1755441122966;
        Sun, 17 Aug 2025 07:32:02 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0204absm435092285a.2.2025.08.17.07.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 07:32:02 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org
Cc: ethan.ferguson@zetier.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Subject: [PATCH v2 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Sun, 17 Aug 2025 10:32:00 -0400
Message-Id: <20250817143200.331625-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
References: <CAKYAXd-B85ufo-h7bBMFZO9SKBeaQ6t1fvWGVEUd_RLGEEK5BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/17/25 08:30, Namjae Jeon wrote:
> On Sun, Aug 17, 2025 at 9:31 AM Ethan Ferguson
> <ethan.ferguson@zetier.com> wrote:
>>
>> Add support for reading / writing to the exfat volume label from the
>> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.
>>
>> Implemented in similar ways to other fs drivers, namely btrfs and ext4,
>> where the ioctls are performed on file inodes.
> We can load and store a volume label using tune.exfat in exfatprogs.
> Is there any usage that requires this, even though there are utils
> that can do it?
> 
> Thanks.
Both e2fsprogs and btrfs-progs now use the FS_IOC_{GET,SET}FSLABEL
ioctls to change the label on a mounted filesystem.

As for me, personally, I ran into this while developing on an
embedded device that does not have, and cannot have, exfatprogs.
Having this be a kernel feature would (I believe) bring the exfat driver
more in line with other fs drivers in the mainline tree.

Thank you for your consideration!

>>
>> v2:
>> Fix endianness conversion as reported by kernel test robot
>> v1:
>> Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/
>>
>> Ethan Ferguson (1):
>>   exfat: Add support for FS_IOC_{GET,SET}FSLABEL
>>   exfat: Fix endian conversion
>>
>>  fs/exfat/exfat_fs.h  |  2 +
>>  fs/exfat/exfat_raw.h |  6 +++
>>  fs/exfat/file.c      | 56 +++++++++++++++++++++++++
>>  fs/exfat/super.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 163 insertions(+)
>>
>> --
>> 2.50.1
>>

