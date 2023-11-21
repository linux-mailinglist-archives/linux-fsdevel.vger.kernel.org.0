Return-Path: <linux-fsdevel+bounces-3289-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B8C7F258C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 06:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34C92282983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53D31B28B;
	Tue, 21 Nov 2023 05:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3sgcT3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AB2A0;
	Mon, 20 Nov 2023 21:56:21 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5ca8c606bb7so16754977b3.1;
        Mon, 20 Nov 2023 21:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700546179; x=1701150979; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3U+FpGuAA4Y2vy6ujYTNeqLGBXm6pjpyU+SIkMTPVc=;
        b=Z3sgcT3iPtO5XyM+UAbQOxW3KSy9DU3/XmBwxSeofRM78zkd8ouZ0SRbLgGHRURaGB
         TNZb2MiFqAV8Wra5V1tNcbhkAhbN6xOx/D6xcXWCC6akvq2ATbaO7oOK2IEG4iud9xt+
         GGNcvnK2oLtet9viVUDLXTW2p+ZBkTQu7/5WmMADQRCqOCZkvZoBZvhsInkm1RX5/o4g
         SHKcXA45cRy123KZsKjh/OaCaeX/Smd6yhVEVWCq4pBm8fQR3sniO/4qcyQeVHFB5nTL
         lNf6KO52RRHW32i8LelVRPkNg0NCH9ETWHvfduW8jGwBWA7pck8odKSFWfzcOwKDO5Vn
         VuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700546179; x=1701150979;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3U+FpGuAA4Y2vy6ujYTNeqLGBXm6pjpyU+SIkMTPVc=;
        b=Jx40Grk+pqoaJUUEKWB1r8X34WRCHlYaptRGUWTQ0NsI8GOYCmG7PxdPzfbj+5lI5I
         G95IKyt6QyZNKv55u2t4bCZ5dwC19rc7WMIal22WU2uShCbd+Lk41EAJATRKjbb+X8hG
         9xB2qpRncHPxb8zH//uciZtikO+TFcnYACgIvfiYlyLYDwO9PsNgbr95b0Z3H8+DlGi9
         o+M3wVWIddRfWsMrknxxEwmsBAdLkuLw48a17CBUFbpl/Ru0HPk4k5G+EGiurXG37Rp1
         kNsP4yxgBAsWWe/kzGnrwwbq0ZKgVGPcna4Ad6/5f5Rg4g7J38quFBTFGeIqH8dKaCgW
         OhnQ==
X-Gm-Message-State: AOJu0YyJ1684dnqN/kzhHCD+qRVCEwTUNPRyQ+qsLc7nRYh3YplOWPk5
	GMGmNACJb4ehUJRp5z1S3Ep8PhTU8Dc=
X-Google-Smtp-Source: AGHT+IFqMzzl3tRe0eBZ24vMBm/Bl8AXzs1+VL5XfzfscWsW7T5mebb9aNh56PFzl0++m92rps3QbA==
X-Received: by 2002:a81:9989:0:b0:5ca:e8bc:b8e with SMTP id q131-20020a819989000000b005cae8bc0b8emr2919852ywg.17.1700546179261;
        Mon, 20 Nov 2023 21:56:19 -0800 (PST)
Received: from dw-tp ([129.41.58.19])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a00138d00b006cb7c49c5e5sm3716500pfg.132.2023.11.20.21.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 21:56:18 -0800 (PST)
Date: Tue, 21 Nov 2023 11:26:15 +0530
Message-Id: <874jhfy7i8.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 2/3] ext2: Convert ext2 regular file buffered I/O to use iomap
In-Reply-To: <ZVw1xxNYQuHimSmx@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Nov 21, 2023 at 12:35:20AM +0530, Ritesh Harjani (IBM) wrote:
>> - mmap path of ext2 continues to use generic_file_vm_ops
>
> So this means there are not space reservations taken at write fault
> time.

Yes.

> While iomap was written with the assumption those exist, I can't
> instantly spot anything that relies on them - you are just a lot more
> likely to hit an -ENOSPC from ->map_blocks now.

Which is also true with existing code no? If the block reservation is
not done at the write fault, writeback is likely to fail due to ENOSPC?

> Maybe we should add
> an xfstests that covers the case where we use up more then the existing
> free space through writable mmaps to ensure it fully works (where works
> means at least as good as the old behavior)?
>

Sure, I can try write an fstests for the same.

Also I did find an old thread which tried implementing ->page_mkwrite in
ext2 [1]. However, it was rejected with following reason - 

"""
Allocating
blocks on write fault has the unwelcome impact that the file layout is
likely going to be much worse (much more fragmented) - I remember getting
some reports about performance regressions from users back when I did a
similar change for ext3. And so I'm reluctant to change behavior of such
an old legacy filesystem as ext2...
"""

https://lore.kernel.org/linux-ext4/20210105175348.GE15080@quack2.suse.cz/



>> +static ssize_t ext2_buffered_write_iter(struct kiocb *iocb,
>> +					struct iov_iter *from)
>> +{
>> +	ssize_t ret = 0;
>> +	struct inode *inode = file_inode(iocb->ki_filp);
>> +
>> +	inode_lock(inode);
>> +	ret = generic_write_checks(iocb, from);
>> +	if (ret > 0)
>> +		ret = iomap_file_buffered_write(iocb, from, &ext2_iomap_ops);
>> +	inode_unlock(inode);
>> +	if (ret > 0)
>> +		ret = generic_write_sync(iocb, ret);
>> +	return ret;
>> +}
>
> Not for now, but if we end up doing a bunch of conversation of trivial
> file systems, it might be worth to eventually add a wrapper for the
> above code with just the iomap_ops passed in.  Only once we see a few
> duplicates, though.
>

Sure, make sense. Thanks!
I can try and check if the the wrapper helps.

>> +static int ext2_write_map_blocks(struct iomap_writepage_ctx *wpc,
>> +				 struct inode *inode, loff_t offset)
>> +{
>> +	if (offset >= wpc->iomap.offset &&
>> +	    offset < wpc->iomap.offset + wpc->iomap.length)
>> +		return 0;
>> +
>> +	return ext2_iomap_begin(inode, offset, inode->i_sb->s_blocksize,
>> +				IOMAP_WRITE, &wpc->iomap, NULL);
>> +}
>
> Looking at gfs2 this also might become a pattern.  But I'm fine with
> waiting for now.
>

ok.

>> @@ -1372,7 +1428,7 @@ void ext2_set_file_ops(struct inode *inode)
>>  	if (IS_DAX(inode))
>>  		inode->i_mapping->a_ops = &ext2_dax_aops;
>>  	else
>> -		inode->i_mapping->a_ops = &ext2_aops;
>> +		inode->i_mapping->a_ops = &ext2_file_aops;
>>  }
>
> Did yo run into issues in using the iomap based aops for the other uses
> of ext2_aops, or are just trying to address the users one at a time?

There are problems for e.g. for dir type in ext2. It uses the pagecache
for dir. It uses buffer_heads and attaches them to folio->private.
    ...it uses block_write_begin/block_write_end() calls.
    Look for ext4_make_empty() -> ext4_prepare_chunk ->
    block_write_begin(). 
Now during sync/writeback of the dirty pages (ext4_handle_dirsync()), we
might take a iomap writeback path (if using ext2_file_aops for dir)
which sees folio->private assuming it is "struct iomap_folio_state".
And bad things will happen... 

Now we don't have an equivalent APIs in iomap for
block_write_begin()/end() which the users can call for. Hence, Jan
suggested to lets first convert ext2 regular file path to iomap as an RFC.
I shall now check for the dir type to see what changes we might require
in ext2/iomap code.


Thanks again for your review!

-ritesh

