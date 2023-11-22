Return-Path: <linux-fsdevel+bounces-3473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 470B97F5197
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 21:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB36BB20F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612FB5CD1E;
	Wed, 22 Nov 2023 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY+U2osZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA29A;
	Wed, 22 Nov 2023 12:26:27 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-359c22c44d6so629325ab.2;
        Wed, 22 Nov 2023 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700684785; x=1701289585; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MYNW2A2wXnMUotvyb3lU3//WT+ELjlFrTwfx+eM2UFY=;
        b=BY+U2osZRKvoMw9Vo+OdWRQP3vfbAlq7j+ipaaRlahG5hkxiPwb8ssXwRKKuwGbZT0
         +UWiYv7C0Weov3kwGVT73vNLH8IUqXZ6NYD+m88qjOUjQFh6gy8Z3J/QgepujxVZtY5V
         OCfXTu0qjABjdcEUlBDLXcSwt5PWG1IhS890A7h9/QOfYRqhj2PH29vQPkoYRUrY340a
         t4w9V7ca89m0YKwp/Ae4nFdDvSMWHcfcqmTtzZUcf8iSZp1JEFtdSDwClee1UJBJwJ56
         wMcXxdO9lrCfnzW6LMWidt6CFBriVjYah3qyeqdE2SkhfbM1WhhETNGcGvqQSq0jIs5C
         nZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684785; x=1701289585;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MYNW2A2wXnMUotvyb3lU3//WT+ELjlFrTwfx+eM2UFY=;
        b=dB9m/7iewo4kcNl+VMaXYLEFTtDNgY29HIofOi1qwEhzy9gaNEV6mu/NpPea6tlP/B
         bTbJRY1xxAjLkpmXOr/UdY52mbLPx4lC6odtFtPULkxccsPhPhMq1JIneKUNxZW03QI2
         5k2BJ+6+scDA3Pgrt/GwbiAaPscuVO21LP6FPa4U1EKyM67+1dzUKUcKbJhdCdqQ7TKK
         qxiYq7RNGSJjWfGAzP0fMbXxaowJioMwSVQAu06BK55GYBHRilrsnIUDbT592SWhhHQ1
         tgzh/7OengGdA0cOf39nkfPx4uhNkzuv1A7NNoZIuiD2TIUl3XvLoaKjn2HcjZS51JF1
         WB3A==
X-Gm-Message-State: AOJu0YxyC4N1oyKDWMjdX7D3uho1bgnk+/5riICwK2ncTeMn13NGNpcH
	h5FyDnJ5vQJQhYD9RaTUGeh2GmwuGwo=
X-Google-Smtp-Source: AGHT+IG/oEoeRQ8bRQnwsot1BUJe0ZNuEd5dSXHtE+mpDE3Oxpp+K+1934xc8T/eLceqjGwDwvyE0Q==
X-Received: by 2002:a05:6e02:1c2d:b0:359:3ac2:5123 with SMTP id m13-20020a056e021c2d00b003593ac25123mr4920456ilh.23.1700684785468;
        Wed, 22 Nov 2023 12:26:25 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id b20-20020a63d314000000b005c215baacc1sm94413pgg.70.2023.11.22.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:26:24 -0800 (PST)
Date: Thu, 23 Nov 2023 01:56:21 +0530
Message-Id: <87msv5r0uq.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <ZV399sCMq+p57Yh3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, Nov 22, 2023 at 01:29:46PM +0100, Jan Kara wrote:
>> writeback bit set. XFS plays the revalidation sequence counter games
>> because of this so we'd have to do something similar for ext2. Not that I'd
>> care as much about ext2 writeback performance but it should not be that
>> hard and we'll definitely need some similar solution for ext4 anyway. Can
>> you give that a try (as a followup "performance improvement" patch).
>
> Darrick has mentioned that he is looking into lifting more of the
> validation sequence counter validation into iomap.
>
> In the meantime I have a series here that at least maps multiple blocks
> inside a folio in a single go, which might be worth trying with ext2 as
> well:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iomap-map-multiple-blocks

Sure, thanks for providing details. I will check this.

-ritesh

