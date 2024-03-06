Return-Path: <linux-fsdevel+bounces-13759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A2873787
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 14:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800911F20641
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0156B130E29;
	Wed,  6 Mar 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gcsgb1bL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28412D743;
	Wed,  6 Mar 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730829; cv=none; b=u3XQWBwFDhiuofmcOTI21+FQ2nga3tJbdI9YuOaqra9KpX9V9f25fDpGl49ukEhv0JwJqki7kqixWw5WtAOwCsxtkBwm2ZWZKpQsQqwrOkZutoNXnVojj7pJk/gS/4cpE+/7GKzZH0z+at9y0yTknI5yKtKvT7EbvErs1GSsnSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730829; c=relaxed/simple;
	bh=zZTqZM1B1Da/pRYhOGZkJOmcUeVzEW4JS9modMCz4zw=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=bVo6RVZOYsQ7bAFhGYm8mwQmYvyp4V9goPp1BZ+XL2nR4evXDcaK/d9vgF/01Ugkqh8SQFW7GiPyRYi+hVm35bVvEZR2Xf40IT572UUsS3kGuuICkRgDhjk0AVVZGPccV+fl5u6vEku4HBB1BnBDcHOYHKfLzkFGMZB7DotMov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gcsgb1bL; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso6245280a12.2;
        Wed, 06 Mar 2024 05:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730827; x=1710335627; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uypOmawqOIrPwCriVHDF7rFN8Nbzv9NUbNdsbCE+5jI=;
        b=Gcsgb1bLhfVTPJoyoPmfJCV7GP6SIKlqlaVIR6oVU+MWyXbO+acmyB+YkXRu96HAWs
         HId5oV/mjGiCZZxuhrDH+dOCXAPPOijfc1hD9VyJFiHBWY4iEVfwPyMfavLOA/aIfM58
         7S5tbZ5EYNKa90LM78XhfBMAUUIdtvFaXmLYtV+9K4FuslGFc+cf0d9Q5rmuIPABbwLp
         Yjv1ofGP/JKJOh7Cx59C6lBBumtaIcEsIxRlbmdWGejNpuke399xqwCuPBfAgfEhl/I7
         ThNpoBT6Kc1IToFnKheNNnUOIncPhWojg7SfaUxsT55d1RTmJexBAubYmsXIsaM1w9Pa
         uEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730827; x=1710335627;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uypOmawqOIrPwCriVHDF7rFN8Nbzv9NUbNdsbCE+5jI=;
        b=A3TrrS7rEKU92C1wWQIQYCU2Gfsg1MVuqgI4ww5sn1Jrf6Ou1B+S0ey/ipueYZ/vAR
         O38zaOtvZCf/kN2AH4vAMQXQ37GG24FVmbWVJsILIpO5NBOlfgRmu2xkQ3QKfKL8crK4
         mHlvGseazRSvbFY2iyn3F2+c0HLTPt0Qj2kBYla1TjVkq2+3qBsqongxMIg6yFmAhsQn
         gRWM+Hm9gutzKHiAsybbFChhlYsgoObrdxr1n4F7p56Sq3KEdFyUd1XvOUt7otelHltP
         E5+oVl110m8VFfBNHusZlF5SnEQs7zK5WlL1wbw0+yf6SIwrVrmRmk6L0bpa6DUg36CD
         XvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7HFblxm5UykLZ8esNtUXOZVhUgl908mz2QsFk4ps21bQWBzq6WjMKXqFA2iG6viPJAmX+pWKTdXqslDxA7TPHt0MV/xWEKH44eJ70L7WAAivmCOtPWgpfGzDa+1/XNE5U4kMy4vu2tPlKByilCYKpYOZRfiQ4VDNldt6AwOqg13VL6DAM68k=
X-Gm-Message-State: AOJu0YxnahSyAqderFvxRQ1HnGK2HGI4NR2K13DzWRsrWQS9UiV4Mxxd
	E4yYSQ9XtiPi5cFQAokBGi8u/1me6o7lTHqCa/nxJjA9Fz0tWDjeTn9yZ7h/JaE=
X-Google-Smtp-Source: AGHT+IG0wggrx1Jx+WY2aA3T8NsgKp7yzhb+H/WmreiPwQFQP+6Qv+dQze5BqQRo6TetqXDOxpZGwg==
X-Received: by 2002:a05:6a20:2584:b0:1a1:6aa8:ee82 with SMTP id k4-20020a056a20258400b001a16aa8ee82mr620624pzd.42.1709730826433;
        Wed, 06 Mar 2024 05:13:46 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id y26-20020aa793da000000b006e6500caa4esm984426pff.199.2024.03.06.05.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 05:13:45 -0800 (PST)
Date: Wed, 06 Mar 2024 18:43:40 +0530
Message-Id: <87il1zpkor.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/9] ext4: Add direct-io atomic write support using fsawu
In-Reply-To: <e4bd58d4-723f-4c94-bf46-826bceeb6a8d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 02/03/2024 07:41, Ritesh Harjani (IBM) wrote:
>> Hello all,
>> 
>> This RFC series adds support for atomic writes to ext4 direct-io using
>> filesystem atomic write unit. It's built on top of John's "block atomic
>> write v5" series which adds RWF_ATOMIC flag interface to pwritev2() and enables
>> atomic write support in underlying device driver and block layer.
>> 
>> This series uses the same RWF_ATOMIC interface for adding atomic write support
>> to ext4's direct-io path. One can utilize it by 2 of the methods explained below.
>> ((1)mkfs.ext4 -b <BS>, (2) with bigalloc).
>> 
>> Filesystem atomic write unit (fsawu):
>> ============================================
>> Atomic writes within ext4 can be supported using below 3 methods -
>> 1. On a large pagesize system (e.g. Power with 64k pagesize or aarch64 with 64k pagesize),
>>     we can mkfs using different blocksizes. e.g. mkfs.ext4 -b <4k/8k/16k/32k/64k).
>>     Now if the underlying HW device supports atomic writes, than a corresponding
>>     blocksize can be chosen as a filesystem atomic write unit (fsawu) which
>>     should be within the underlying hw defined [awu_min, awu_max] range.
>>     For such filesystem, fsawu_[min|max] both are equal to blocksize (e.g. 16k)
>> 
>>     On a smaller pagesize system this can be utilized when support for LBS is
>>     complete (on ext4).
>> 
>> 2. EXT4 already supports a feature called bigalloc. In that ext4 can handle
>>     allocation in cluster size units. So for e.g. we can create a filesystem with
>>     4k blocksize but with 64k clustersize. Such a configuration can also be used
>>     to support atomic writes if the underlying hw device supports it.
>>     In such case the fsawu_min will most likely be the filesystem blocksize and
>>     fsawu_max will mostly likely be the cluster size.
>> 
>>     So a user can do an atomic write of any size between [fsawu_min, fsawu_max]
>>     range as long as it satisfies other constraints being laid out by HW device
>>     (or by software stack) to support atomic writes.
>>     e.g. len should be a power of 2, pos % len should be naturally
>>     aligned and [start | end] (phys offsets) should not straddle over
>>     an atomic write boundary.
>
> JFYI, I gave this a quick try, and it seems to work ok. Naturally it 

Thanks John for giving this a try!

> suffers from the same issue discussed at 
> https://lore.kernel.org/linux-fsdevel/434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com/ 
> with regards to writing to partially written extents, which I have tried 
> to address properly in my v2 for that same series.

I did go through other revisions, but I guess I missed going through this series.

Thanks Dave & John for your comments over the series.
Let me go through the revisions I have missed and John's latest revision.
I will update this series accordingly.

Appreciate your help!
-ritesh

