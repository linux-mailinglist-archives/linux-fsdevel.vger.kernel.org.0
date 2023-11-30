Return-Path: <linux-fsdevel+bounces-4324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A77FE92A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 07:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97CD1C20A12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A9E20DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afQ17xJa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B118710D5;
	Wed, 29 Nov 2023 20:37:52 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cdd584591eso554356b3a.2;
        Wed, 29 Nov 2023 20:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701319071; x=1701923871; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ByPdLVUoOLVZ48+By0ZGaQZsMUA+NEYCsjkvaY2u+8I=;
        b=afQ17xJaP1NYZ70l7vSIyXMn9XBFPGmUtcFoWqZhnFi1AjvFslRwqxIxnRnDMxl3W1
         EGBRX1AXPSiqhNyOROAly4fQazJFcZ+IBwOz7zBv7s4O2IYsIAnS3hXpUHQWr4hGVbDz
         LY9y4U0lHEnbTBJmP+oB2Vb9MiwAbrqJo7dSaq1fCetWmD2a5L3CMYcvOXSShN/iCnNq
         V8pp039b8+KyEnnFyRZ4o4MaoTYfmlMJQgYiegOZsD7aopy36ZdB9Xxfjm5zgLsWNDVu
         LgZQo7rrrDdu44oIciIf4qyXfKTgj7Uevd2TG3foBgaXPrAylWajhrGIDRfGu0U8gfF6
         d72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701319071; x=1701923871;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ByPdLVUoOLVZ48+By0ZGaQZsMUA+NEYCsjkvaY2u+8I=;
        b=DQ2q832KEFYFgg02JhgbVm40V+Ru+AxsqqURlebO9WrUdfsupW5+ArAEQaQWx+4WOE
         tWYl+gRKgJ9o4RoqjyCRvJMjgX9M7ElMZENUgCilo8jNtlRbITq2g0BEAshVJzLcmGnE
         NGzbrPatjGXHl5GgOar9vLhr6W8eF9jRpCd8bDBKPdkpQUAJ+qO+EF1x8nmAIjHlc45e
         4+5ImXHFlykIGFsq5OvTN8oQVh7j+Vu/s6EzZCJciBIRw8EIX0mE3Wadi6I3WGQo486J
         ARnx7Y8pThpsfRwOBB82JNOLFugbMznzbik8wnz1ELhr2PR3+ei8HeTszoNvH9oSYsAI
         p+dQ==
X-Gm-Message-State: AOJu0YzjQJCVL8Roc1Kb/FQmR5ijKXcNCTXIPopltALgaII0ti0RGN4s
	ymGzFZbeBEyZJ8f7GXlWjbxFG/3hUOM=
X-Google-Smtp-Source: AGHT+IGRGgaIeuEItybCy/qXNjLIltdEwM7V+sMAvRcUeRhWnb21Z7zOXsfDl8kylFJyFk4rwf9Dew==
X-Received: by 2002:a05:6a21:998d:b0:187:a2ca:409c with SMTP id ve13-20020a056a21998d00b00187a2ca409cmr23146492pzb.5.1701319071210;
        Wed, 29 Nov 2023 20:37:51 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001c73f3a9b7fsm228003pli.185.2023.11.29.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 20:37:50 -0800 (PST)
Date: Thu, 30 Nov 2023 10:07:47 +0530
Message-Id: <87zfyvhn50.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <ZWgOHWyUW+bJWTkQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Nov 30, 2023 at 08:54:31AM +0530, Ritesh Harjani wrote:
>> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
>> index 677a9ad45dcb..882c14d20183 100644
>> --- a/fs/ext2/ext2.h
>> +++ b/fs/ext2/ext2.h
>> @@ -663,6 +663,7 @@ struct ext2_inode_info {
>>  	struct rw_semaphore xattr_sem;
>>  #endif
>>  	rwlock_t i_meta_lock;
>> +	unsigned int ib_seq;
>
> Surely i_blkseq?  Almost everything in this struct is prefixed i_.

Certainly!

-ritesh

