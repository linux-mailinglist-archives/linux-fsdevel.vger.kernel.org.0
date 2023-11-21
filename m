Return-Path: <linux-fsdevel+bounces-3291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339027F25AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 07:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901BE281611
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4026E1EA7B;
	Tue, 21 Nov 2023 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+uP3HEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054AA139;
	Mon, 20 Nov 2023 22:15:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc2fc281cdso35725245ad.0;
        Mon, 20 Nov 2023 22:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700547345; x=1701152145; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9a/5eSMh2PzmvUF0Lex3Fjc5Rp+v2WckaR46YPiH1w0=;
        b=A+uP3HEcFDTEL6xkWaX+KXJ+ycvC+jiC3es7JlCuV3REGuVkalpIURG2jFRLbYiuJ4
         zK5ayeRE3SoXFFH7IpXVGV9pylBUXh47aQxZHGEr8jDxvrKmAtxz6YLjccE6LEl0oMDf
         ergkEjoH01ZJEw7pNcbflzJBUGRYn4vQttB8BJ3Tl2p9AHIqdevy/sWXFfYUjVjNWMpm
         t5OeYHw1j2eOde3dGODObplqmPtWFCLn7kgG6IUpbuR5YoqWEoJqlUE/Inifoc848vyc
         PnjBxQCrLHxMiVXjjvHUW3ek6TB9wOeHl7KipsAaxgG+D7kABCPqAt980hPQWbw4WnEq
         pfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700547345; x=1701152145;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9a/5eSMh2PzmvUF0Lex3Fjc5Rp+v2WckaR46YPiH1w0=;
        b=N8dA9Kg6WM9v2Uf3aF0M5XSDfL89hmhn5vGuIyOVWsN5+Pi+QWq882ErR2DcFbSpCt
         4sVADteOmC0QRCIcXNnMA0SkjqU3iqaQOyc0lB1K2Q7RqXsazHiNsgDMc/MiG+nBsOYi
         9KJAA4lVuTACO2y4JOpPC/uizuZOL0sfAo2Op3jWiASFmVPKxt+OEvEQlmk7HX6OgT/4
         xCfdQZsAPi5xWY1DiZnlJn3ZXDiWI62Fw4x13tTdPp0ctuAD+hreuZzpERPFajHE/j5C
         hIlxEYArwXB03li4kTWStYRD8oEQ/hyAfplcU69+McO9hAwL99HU2J6zwYTSPK/i4ae3
         qiDA==
X-Gm-Message-State: AOJu0Yy4EAWD4raSSLUXbvrXMWWuoWOJ4wx6/yZneO7DLG2NRmw9Deuj
	pef0ITWdfO8k0R8qSE3i6JFRBwvdznA=
X-Google-Smtp-Source: AGHT+IHIb64DncFY9jowIuQnc3KP2i9DltM8idSCU0MoVUFvYcI57DequXTRrgd1EFOcYqcEK1Ap7Q==
X-Received: by 2002:a17:902:9894:b0:1cc:bf6b:f3b1 with SMTP id s20-20020a170902989400b001ccbf6bf3b1mr7861726plp.37.1700547345448;
        Mon, 20 Nov 2023 22:15:45 -0800 (PST)
Received: from dw-tp ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id c10-20020a170902c1ca00b001cc55bcd0c1sm7086700plc.177.2023.11.20.22.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 22:15:44 -0800 (PST)
Date: Tue, 21 Nov 2023 11:45:41 +0530
Message-Id: <871qcjy6lu.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <ZVxJXxKipvxcPlSo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Nov 21, 2023 at 11:26:15AM +0530, Ritesh Harjani wrote:
>> > instantly spot anything that relies on them - you are just a lot more
>> > likely to hit an -ENOSPC from ->map_blocks now.
>> 
>> Which is also true with existing code no? If the block reservation is
>> not done at the write fault, writeback is likely to fail due to ENOSPC?
>
> Yes. Not saying you should change this, I just want to make sure the
> iomap code handles this fine.  I think it does, but I'd rather be sure.
>

Sure. I can write a fstest to test the behavior. 

>> Sure, make sense. Thanks!
>> I can try and check if the the wrapper helps.
>
> Let's wait until we have a few more conversions.
>

Sure.

>> > Did yo run into issues in using the iomap based aops for the other uses
>> > of ext2_aops, or are just trying to address the users one at a time?
>> 
>> There are problems for e.g. for dir type in ext2. It uses the pagecache
>> for dir. It uses buffer_heads and attaches them to folio->private.
>>     ...it uses block_write_begin/block_write_end() calls.
>>     Look for ext4_make_empty() -> ext4_prepare_chunk ->
>>     block_write_begin(). 
>> Now during sync/writeback of the dirty pages (ext4_handle_dirsync()), we
>> might take a iomap writeback path (if using ext2_file_aops for dir)
>> which sees folio->private assuming it is "struct iomap_folio_state".
>> And bad things will happen... 
>
> Oh, indeed, bufferheads again.
>
>> Now we don't have an equivalent APIs in iomap for
>> block_write_begin()/end() which the users can call for. Hence, Jan
>> suggested to lets first convert ext2 regular file path to iomap as an RFC.
>
> Yes, no problem.  But maybe worth documenting in the commit log.

Sure, I will update the commit log.

-ritesh

