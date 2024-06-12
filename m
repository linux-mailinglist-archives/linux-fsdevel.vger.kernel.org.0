Return-Path: <linux-fsdevel+bounces-21505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A46EA904C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DEAA2839AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 06:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA116B75C;
	Wed, 12 Jun 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvGNB8Ym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF912B170;
	Wed, 12 Jun 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175320; cv=none; b=P9SuHIR+AtWo7ni+qenRt9CIJIFcH45JhyGcohYhEqrlkXjoH0o3qXmK6voLXCSGvglZVQEjvZh8UCYbzcR0Zk097fEL6ShFLCh8SF5pkRKG6MmDqep5zKDxXefOFRUPiDeYNlH15vxau4b0C7HneS+5u1LWk0CXA/1vszOVjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175320; c=relaxed/simple;
	bh=QL5AzMylb6sWTFFYjKRwgICCtOPS5GZejRXyfM61FcI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=mdUGCPrlkfLDlT/vUWAiJlKZP9Mvm0FFI9suxYs1+9qknhSJrpBWZ3cbT1KTOfLAGK4CNHdBK7QgekC7/nAfpBQWzi/m8MevsM1jk3jp0pUO6hTHv1zAgBmF8J1cZA3JqUe+k52iZFrOO07CdIOfr+FmSxZcBtJIHONDP1nz5Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvGNB8Ym; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so27500395ad.3;
        Tue, 11 Jun 2024 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718175319; x=1718780119; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMu3Q0pXDLFy7A1/gaz15NZUnR2H8RHdoTmM1JvyEeU=;
        b=VvGNB8YmiW0itQScaMwe74YCQktWKTbDqfVb1qNME9IU6IzYzoBbRqQlHCfdI7+gbV
         Y7Occq3jmikBmCKABpE+YltSN9zQcoYq4x+dWSUQsRH6IHfUFsRvmXT4jOcuFNBYES0m
         SDu2T1Ntrm2WTm8NSsD1ZdvVDZpX/bjPIk3UNNkZ/N2FNwMIFw7Nz3IDFR6uah6E/JQl
         1Q+KfoenL/aJlq2bNXkbFmXJn5YJiNQKcc8woLIxSyZojpdl/pISPtEy5yK9s1mFAcRO
         z3hUSENwgLt9p0mwratERknmLNMpovn+otz40zOiWgB+sEdKxsWRJAlA1Lia5OMTbA71
         LO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175319; x=1718780119;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMu3Q0pXDLFy7A1/gaz15NZUnR2H8RHdoTmM1JvyEeU=;
        b=HvPQmL3DTJdt+x5Sp1yuUW0h9bo3AuvlZ7AtvWsbSIjZNJlguOXK6sdFknB7uwHUVy
         TNqgrtVxnnG3pkjCmuiQ3vT29BWm1ts2U82JxD66Q6hbpMSS6o7AqUCZhssS0lpfaWOt
         1dPiSSHjWHZke3zhkjL7FkfLdn2AhOnmYoGmBGfZzVTGlEVfuFDTJgdUCMuz+N2jAzkz
         bPzWC7ysBvDEam3HID/qPXS0NYGM2aQowtQjdsPyEZ190hZL98aPMPvw5vwJ63pPVEji
         hbhiDvNqiEqKWwvbJDCfi3PSJdqtA/yEYGhKWjlUEgRTyAzRp2QZCO+2fhPX+jADazLT
         FfeA==
X-Forwarded-Encrypted: i=1; AJvYcCXbXn2+7e9lr/b6kw4GkxnXZt7QEdWctvkUHNDvq39qZRuu3mIDluASB7DbqDtWBokADfO8XmXVF4YafbSjj1dtTo2orbO6A7qzTT8D9GGGdmFc1tKWysojNdKieuHRdGDF7MSzyM6tuw==
X-Gm-Message-State: AOJu0YxoYX9/J1fuFHhfv1lDNrpjxXJWmDndU2hn7Xt3iGhTRBwOH5q3
	nVi54FdVC8qCg4vFHArWj0XeY8HVUjv61gKIgNs35F8gfS1qWri30y0ciA==
X-Google-Smtp-Source: AGHT+IGYJlnOtKjPo7MDUrhZBOGuuZo7X4JJfOtZfHIsHFUCOh5szXE5Q0XDASNaKtzB0eCJTX9RjQ==
X-Received: by 2002:a17:902:ced1:b0:1f7:13ac:e80e with SMTP id d9443c01a7336-1f83b567e73mr10470975ad.4.1718175318685;
        Tue, 11 Jun 2024 23:55:18 -0700 (PDT)
Received: from dw-tp ([171.76.84.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71be78473sm43982375ad.287.2024.06.11.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 23:55:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] Documentation: document the design of iomap and how to port
In-Reply-To: <20240611234745.GD52987@frogsfrogsfrogs>
Date: Wed, 12 Jun 2024 12:07:40 +0530
Message-ID: <8734piacp7.fsf@gmail.com>
References: <20240608001707.GD52973@frogsfrogsfrogs> <874j9zahch.fsf@gmail.com> <20240611234745.GD52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


"Darrick J. Wong" <djwong@kernel.org> writes:

> On Tue, Jun 11, 2024 at 04:15:02PM +0530, Ritesh Harjani wrote:
>> 
>> Hi Darrick,
>> 
>> Resuming my review from where I left off yesterday.
>

<snip>
>> > +Writes
>> > +~~~~~~
>> > +
>> > +The ``iomap_file_buffered_write`` function writes an ``iocb`` to the
>> > +pagecache.
>> > +``IOMAP_WRITE`` or ``IOMAP_WRITE`` | ``IOMAP_NOWAIT`` will be passed as
>> > +the ``flags`` argument to ``->iomap_begin``.
>> > +Callers commonly take ``i_rwsem`` in either shared or exclusive mode.
>> 
>> shared(e.g. aligned overwrites) 
>

Ok, I see we were in buffered I/O section (Sorry, I misunderstood
thinking this was for direct-io)

> That's a matter of debate -- xfs locks out concurrent reads by taking
> i_rwsem in exclusive mode, whereas (I think?) ext4 and most other
> filesystems take it in shared mode and synchronizes readers and writers
> with folio locks.

Ext4 too takes inode lock in exclusive mode in case of
buffered-write. It's the DIO writes/overwrites in ext4 which has special
casing for shared/exclusive mode locking.

But ext4 buffered-read does not take any inode lock (it uses
generic_file_read_iter()). So the synchronization must happen via folio
lock w.r.t buffered-writes.

However, I am not sure if we have any filesystem taking VFS inode lock in
shared more for buffered-writes.


BTW -
I really like all of the other updates that you made w.r.t the review
comments. All of those looks more clear to me. (so not commenting on them
individually).

Thanks!
-ritesh

