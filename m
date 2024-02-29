Return-Path: <linux-fsdevel+bounces-13219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD286D604
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD401F265A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4770516FF4A;
	Thu, 29 Feb 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUKx+tBy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7316FF26
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 21:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241675; cv=none; b=amogOOWyCKe4M7XpCS15gBf0OfI3qYa3oX72UELYvLJgvnj4rbKBjrPkfjWNtncOrYKL+SYuavaR1bCOjCC0bauwL71zJv18ty0ezYoal4hApTMElsFSjn6qWs526vcHfg8WTe1AHnggRqtn6ZGFXvWJJ0yLMPFQCXrN5We371M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241675; c=relaxed/simple;
	bh=aMzV7OLpTO3kiByNe1b2j+oYFtftViCXeIKvxCfXbK8=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To:MIME-version:
	 Content-type; b=ehIe4XTboeRTtZWvnBXJzjDQ3jtV4fRR00rZ7Syy7VaenyfQI/FOsKqmf8l5M/ECLli2OB0/3ebwUh4fnerfls+H2jHQhrJcS5zIIbn8qJbcjd5NxaMxDGHLEpvoG7oM9PdRHnbXCJSlVetDIDDHPeJ43K8a7C0OtXBIjfyCh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUKx+tBy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc13fb0133so11946245ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 13:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709241673; x=1709846473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h5XPcqp74ZmZe2+sDNenmNkvi+dwchPiHeXu7Dqjqzk=;
        b=VUKx+tByRHf6xzz8IX1dCHdFpoaYmL8rtCPUtnNr5xVZet8WIxqMXyUpzt4WnO5Zsa
         gPgwe1wL9I2TIxiIZMpucGxVbHqBS3AfcSvJtm39jOnwWENciFxF6Q1/SXrFTGCf9ei2
         d2h0ETE0DBhEAsijJ0kSJ1XBwUw7iJNTtv1S0PeSoguxeDmwdOiMR01n7nxn/gtWNUvy
         qu7fUUrEo3OSlixOeGFLzW5HkxNjPrN2MHjJsD+P92LTPdrGk4Ig3xna3m/kUeB2Fat1
         pcozsF3z5PyRo6Y3SGYN26yzhNvcj3/zEt3SWfcf6OHG0nh7txHVWhGkOdemWHEQXQao
         gNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709241673; x=1709846473;
        h=content-transfer-encoding:mime-version:in-reply-to:subject:cc:to
         :from:message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5XPcqp74ZmZe2+sDNenmNkvi+dwchPiHeXu7Dqjqzk=;
        b=J2eySBLGcFbuPLhoLNMumXNq4vJGJFqOqQnbLLhWC3an+B0hnSckUdumrpx+4MsIYM
         ngkp0veVddnDb9qSI1AydaROIPM+62ij52nA6S6sXLArD/JgNiub/Ws/noDOvOjXlQV6
         Yg8tGTK8tujCnMQujlIVvA7FSxxLwtMawYBCK61IxfBcH5gsInAFAjAwy6gRE7HfdMA2
         sRnEoJdwbSBLJj/sXzuI6Fux0vndkriwbxU7kBcQr0dbbYlaVeS+fDjMl28PT5Lksb94
         BbpFsseG/ulnROZysYbuTxpTmyp11TXx3apAnPas+kJqS+d5sxf0SSsjVAyLTiCxVQRV
         QnDg==
X-Forwarded-Encrypted: i=1; AJvYcCVhwpoaYyHcnJ5all8Up0dFo0LCyPM6c2C36vRzTJSW/SOkfASioTGU7KvqkPP+PwxJQb69DBsmRWxYKGt/AUqZNbOFskAgpJn8CxxN9w==
X-Gm-Message-State: AOJu0YzP4tYOloydAf7/Sc5RykpOJ3Fihhf/GEcAE/zEEFmjm+TYrctz
	LOXDwOB7XFyyyuKBEi4fH9DiqTJPbwnnUrYOrX3uPoscrMYV2paD
X-Google-Smtp-Source: AGHT+IHFAu7l+ocH9PpJerHbAVdhv4CKKrm5Xk4IxGkDZZHnkhsTsMflqys+q4AP8qtstioWUNhp3Q==
X-Received: by 2002:a17:903:493:b0:1dc:d6ba:ed4c with SMTP id jj19-20020a170903049300b001dcd6baed4cmr2944850plb.2.1709241673416;
        Thu, 29 Feb 2024 13:21:13 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d11-20020a170903208b00b001dcc109a621sm1967934plc.184.2024.02.29.13.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:21:12 -0800 (PST)
Date: Fri, 01 Mar 2024 02:51:08 +0530
Message-Id: <8734tb0xx7.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, Theodore Ts'o <tytso@mit.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] untorn buffered writes
In-Reply-To: <c909dbe7-a6d4-40af-99a6-2b27a2dbb27b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

John Garry <john.g.garry@oracle.com> writes:

> On 28/02/2024 23:24, Theodore Ts'o wrote:
>> On Wed, Feb 28, 2024 at 04:06:43PM +0000, John Garry wrote:
>>> Note that the initial RFC for my series did propose an interface that does
>>> allow a write to be split in the kernel on a boundary, and that boundary was
>>> evaluated on a per-write basis by the length and alignment of the write
>>> along with any extent alignment granularity.
>>>
>>> We decided not to pursue that, and instead require a write per 16K page, for
>>> the example above.
>> Yes, I did see that.  And that leads to the problem where if you do an
>> RWF_ATOMIC write which is 32k, then we are promising that it will be
>> sent as a single 32k SCSI or NVMe request
>
> We actually guarantee that it will be sent as part of a single request
> which is at least 32K, as we may merge atomic writes in the block layer.
> But that's not so important here.
>
>> --- even though that isn't
>> required by the database,
>
> Then I do wonder why the DB is asking for some 32K of data to be written
> with no-tears guarantee. Convenience, I guess.
>
>> the API is*promising*  that we will honor
>> it.  But that leads to the problem where for buffered writes, we need
>> to track which dirty pages are part of write #1, where we had promised
>> a 32k "atomic" write, which pages were part of writes #2, and #3,
>> which were each promised to be 16k "atomic writes", and which pages
>> were part of write #4, which was promised to be a 64k write.  If the
>> pages dirtied by writes #1, #2, and #3, and #4 are all contiguous, how
>> do we know what promise we had made about which pages should be
>> atomically sent together in a single write request?  Do we have to
>> store all of this information somewhere in the struct page or struct
>> folio?
>>
>> And if we use Matthew's suggestion that we treat each folio as the
>> atomic write unit, does that mean that we have to break part or join
>> folios together depending on which writes were sent with an RWF_ATOMIC
>> write flag and by their size?
>>
>> You see?  This is why I think the RWF_ATOMIC flag, which was mostly >
>> harmless when it over-promised unneeded semantics for Direct I/O, is
>> actively harmful and problematic for buffered I/O.
>>
>>> If you check the latest discussion on XFS support we are proposing something
>>> along those lines:
>>> https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/Zc1GwE*2F7QJisKZCX@dread.disaster.area/__;JQ!!ACWV5N9M2RV99hQ!IlGiuVKB_rW6nIXKv1iGSM4FrX-9ehXa4NF-nvpP5MNsycQLKCcKmRgmKEFgT8hoo7rfN8EhOzwWoDrA$
>>>
>>> There FS_IOC_FSSETXATTR would be used to set extent size w/ fsx.fsx_extsize
>>> and new flag FS_XGLAG_FORCEALIGN to guarantee extent alignment, and this
>>> alignment would be the largest untorn write granularity.
>>>
>>> Note that I already got push back on using fcntl for this.
>> There are two separable untorn write granularity that you might need to
>> set, One is specifying the constraints that must be required for all
>> block allocations associated with the file.  This needs to be
>> persistent, and stored with the file or directory (or for the entire
>> file system; I'll talk about this option in a moment) so that we know
>> that a particular file has blocks allocated in contiguous chunks with
>> the correct alignment so we can make the untorn write guarantee.
>> Since this needs to be persistent, and set when the file is first
>> created, that's why I could imagine that someone pushed back on using
>> fcntl(2) --- since fcntl is a property of the file descriptor, not of
>> the inode, and when you close the file descriptor, nothing that you
>> set via fcntl(2) is persisted.
>>
>> However, the second untorn write granularity which is required for
>> writes using a particular file descriptor.  And please note that these
>> two values don't necessarily need to be the same.  For example, if the
>> first granularity is 32k, such that block allocations are done in 32k
>> clusters, aligned on 32k boundaries, then you can provide untorn write
>> guarantees of 8k, 16k, or 32k ---- so long as (a) the file or block
>> device has the appropriate alignment guarantees, and (b) the hardware
>> can support untorn write guarantees of the requested size.
>> 
>> And for some file systems, and for block devices, you might not need
>> to set the first untorn write granularity size at all.  For example,
>> if the block device represents the entire disk, or represents a
>> partition which is aligned on a 1MB boundary (which tends to be case
>> for GPT partitions IIRC), then we don't need to set any kind of magic
>> persistent granularity size, because it's a fundamental propert of the
>> partition.  As another example, ext4 has the bigalloc file system
>> feature, which allows you to set at file system creation time, a
>> cluster allocation size which is a power of two multiple of the
>> blocksize.  So for example, if you have a block size of 4k, and
>> block/cluster ratio is 16, then the cluster size is 64k, and all data
>> blocks will be done in aligned 64k chunks.
>>
>> The ext4 bigalloc feature has been around since 2011, so it's
>> something that can be enabled even for a really ancient distro kernel.
>> 🙂 Hence, we don't actually*need*  any file system format changes.
>
> That's what I thought, until this following proposal:
> https://lore.kernel.org/linux-ext4/cover.1701339358.git.ojaswin@linux.ibm.com/
>

So there are two ways, ext4 could achieve aligned block allocation
requirements which is required to gurantee atomic writes.

1. Format a filesystem with bigalloc which ensures allocation happen in
units of clusters or format it with -b <BS> on a higher pagesize system.
2. Add intelligence in multi-block allocator of ext4 to provide aligned
allocations (this option won't require any formatting)

The patch series you pointed is an initial RFC for doing option 2,
i.e. adding allocator changes to provide aligned allocations.
But I agree none of that should require any on disk fs layout changes.

Currently we are looking into utilizing option-1 which should be
relatively easier to do it than option-2, more so when the interfaces
for doing atomic writes are still getting discussed.

-ritesh

