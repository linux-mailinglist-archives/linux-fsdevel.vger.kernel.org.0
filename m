Return-Path: <linux-fsdevel+bounces-13087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E711086B1D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE1A1C21806
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D85D15B0FD;
	Wed, 28 Feb 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Cutyhdiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26715AADD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 14:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130769; cv=none; b=Q9lBg8j3pyN0cfnPC1ABQ47ZYvV9Zft8Tyq995/KxDqVqmRRl4qmYzVR+6PoNBWLK4U/SEz8SMOmYth1J2h+6KD2I/UFFXxShnXh+4O66kbT5lPQ6MroswqVlAvo2kTWsmyGsWnjZ1eNrhQ6o99gKcarQZ4gInSyUu7yO9ad2L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130769; c=relaxed/simple;
	bh=Z4/OtHVgP88SJVmMhlRSzEu+uUc+4K+vaFN0dJgQ/Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3Tu/v/dKMZChCk4Uep84lS8MW7c9I1o7ClL/x0Kaf/JEPEXOtSx26Ee2+yLhsi9o8HRFntJF5WoHB8o/+gDEhM9lCH06GKt9bzDtlGrkz9iL02kEg/sAH6LtSSpwolNJC21SPVDdTC+c0ctlOYuAMOYsOxd7UzqXwfs1slnJc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Cutyhdiy; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bf3283c18dso84269739f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709130766; x=1709735566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5AWaBgGMJ+Egc0FydP29vm1V1HTAxeYlVmY0RHDDGQ=;
        b=CutyhdiySQwAYULDY9Ov4OEO6Ule0v5XfBsO6tjjD78QCdCV3J5ER8AYKJMJf3OP9D
         HRIq+8Kf4epXy54GLJnEyrFwbtiNp0zGtvmJmBOJ+tdfcDAWEWOy663JaCtrFJebVLLI
         eZogVPgystZOOzr2N+XDKAyKFGnmxkKJLzCaUXlTXMAhlwpH1fUkk+5xtKrMSg60uw41
         KvgiceyDJTkFAJV8RI1DsgXKLpKmYIHqg1JqtwXCVtRSkNzE/gZpUqLaelRKHNjj4OU+
         L4rEEEAMxJ+Biu3ELmqWms5BUEHxZ29HK1z4ULW/o8/Ezi+EPY0C6gQ3WIw6RVJ5Xblx
         K1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130766; x=1709735566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5AWaBgGMJ+Egc0FydP29vm1V1HTAxeYlVmY0RHDDGQ=;
        b=MxDkQzjlgnhFAYdgBfhIBA+AiFs8h9UlKBoEqUXpmzbt/DScYozhd63sbx31THZp45
         8ihlmy3N64Og4n8AXHn/bsKOURL9FRZ/D48kRGleqipXTdQSEs0ubNm/vF55EPUY0dgt
         7KQymRTb1kU3ngpoYJn6ssvk0tqTNwVjQrQ+DGA36IKAitykihCKuuvP7XE0gLaIYRxe
         d5KL6cVBXYz1pg7qH3VStP1QU9kFh7iT/uC0Jt/DcZnC6Th7T6ORnCWsCLLs/BefLfIL
         Ernu4rV1bvARsvbXrqMDLi/aP+NC2Ow2hfflqpkH/snDibc+ncH80vv8kQWcaHNi+dx5
         8c7w==
X-Forwarded-Encrypted: i=1; AJvYcCUH6qgIvBqUvS/MZ8aSTiNk3foh0bCjWbkcvittkG3qS7I/pFLm26oYnP/XIFVyIJdBv+lvNgAU975K9n7qlJB690u4WYcEn4nr31MQkw==
X-Gm-Message-State: AOJu0Ywq6hdTg15sOR2JAtc3/gePJXR160a+bLSTAh5GIBrImHGmvCA6
	o6ZX9OovYzTVc3IJojMHSqtMtXr+TOhhscMb7c7NYrLW28L6wW5t4GdlkQq1XJ8=
X-Google-Smtp-Source: AGHT+IEOva8/VcA0S3pCJqoDZDi/f+PQ6LlXWSd1zbUYjUE88BUIeGN3Cm0MHY37p9ejCegRNybMkg==
X-Received: by 2002:a05:6e02:152b:b0:365:5dbd:ba43 with SMTP id i11-20020a056e02152b00b003655dbdba43mr13141860ilu.1.1709130766277;
        Wed, 28 Feb 2024 06:32:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r6-20020aa79886000000b006e466369645sm7872706pfl.132.2024.02.28.06.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 06:32:45 -0800 (PST)
Message-ID: <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk>
Date: Wed, 28 Feb 2024 07:32:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>,
 Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org,
 Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
 <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/24 4:28 AM, Amir Goldstein wrote:
> On Wed, Feb 28, 2024 at 1:14?PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Wed, 28 Feb 2024 at 12:08, Amir Goldstein <amir73il@gmail.com> wrote:
>>
>>> I don't think so, because it will allow unprivileged user to exceed its
>>> nested rlimits and hide open files that are invisble to lsof.
>>
>> How does io_uring deal with the similar problem of "fixed files"?
>>
> 
> Good question.
> 
> Jens, Chritian,
> Are fixed files visible to lsof?

lsof won't show them, but you can read the fdinfo of the io_uring fd to
see them. Would probably be possible to make lsof find and show them
too, but haven't looked into that.

> Do they have to remain open in the files table of process that set them
> in addition to being registered as fixed files?

No, in fact they never have to be there in the first place. You can open
a normal file and then register it, now it's in both. Then you can close
the normal fd, and now it's not in the normal process file table
anymore, just in the direct list.

Or you can instantiate it as a direct descriptor to begin with, and then
it'll never have been in the normal file table.

> Do they get accounted in rlimit? of which user?

The fixed file table is limited in size by RLIMIT_NOFILE by the user
that registers it.

-- 
Jens Axboe


