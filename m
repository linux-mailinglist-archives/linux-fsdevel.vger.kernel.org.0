Return-Path: <linux-fsdevel+bounces-39187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760E2A1130F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 22:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273013A5ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0A20D507;
	Tue, 14 Jan 2025 21:30:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sxb1plsmtpa01-13.prod.sxb1.secureserver.net (sxb1plsmtpa01-13.prod.sxb1.secureserver.net [92.204.81.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8B29406
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 21:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.204.81.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736890210; cv=none; b=erhxwCJFfuHBYlx7KO2+9UM76DSIetlbgnbwJdItIQnVcf0sHoxmEvKWBXBFR8B056jGrjkPII0l6AjMhxZA6toEJaij7awM4QUOAOw5J2p0R1X0nu/+oQfLvuGIWP+xqKSXx2JNbXeaMV+VvHg+oMrRBRYYaZlG1b1FP9I/CWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736890210; c=relaxed/simple;
	bh=4rpQXrXFh+4KoJuzmTW1bN2o4Zq0/a7XXrl7Zgpulrc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IZxit0UQhAjFVJio8uobqtKADAo6XDGx6VVL/tCwL4PfDfdeCQfU+vJdFPZxD9hayFpJKclXKh586re4Qre1dP5Wt/VVQrf3kzlgBXgml0pcfyJX1dEY6g+I3tmSkc2VDSKrDGe/MBQXQ1SazsrQXvjKHxaw7xLuy/72kTqB47M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=92.204.81.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id XoBgtltPxdEQAXoBgtvQfD; Tue, 14 Jan 2025 14:11:00 -0700
X-CMAE-Analysis: v=2.4 cv=NvQrc9dJ c=1 sm=1 tr=0 ts=6786d2e4
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=JfrnYn6hAAAA:8 a=FXvPX3liAAAA:8 a=z7n7CMp_HCF1xQbUqeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <61b524c4-b3ea-4170-be33-d59c8ce13c63@squashfs.org.uk>
Date: Tue, 14 Jan 2025 21:10:34 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] squashfs: Use a folio throughout
 squashfs_read_folio()
From: Phillip Lougher <phillip@squashfs.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20241216162701.57549-1-willy@infradead.org>
 <0153c973-1100-4863-868d-ba80f736fa41@squashfs.org.uk>
Content-Language: en-US
In-Reply-To: <0153c973-1100-4863-868d-ba80f736fa41@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF3JPhC1jaP8L3FC75uS8SsYPQtN31Zs+HC4Hrkpx1HqJGGEAwuZvJqyvUI7oKhKnZOiR8jZ4KeKxrshCyuqVAvuQbgxtMbP3UZHCuMR8T19IhMHwQIU
 wTBRWsvenXYQ0b11E9HixR/tefgrcfDfomuU/Er5tZmP6SkeLtOYlrkWqtkhX/iNTtOagSPBDaWSQIV7aq37ZH3nnUDV1Wq176AX6jRsWVSWdNDMEu4G4nIG
 S0UNS2ujNEZkDGjgUDBg2X9UC3It+mi4c4UMJUpI/CwcmovdlUlmiaqm5eRyjyyZH1uVK5zv7SZmZfwWtPfe1q6tSe18gFYajaczttVyk4ebPaY27SUG8szP
 tp5YZO4L



On 1/14/25 21:07, Phillip Lougher wrote:
> 
> 
> On 12/16/24 16:26, Matthew Wilcox (Oracle) wrote:
>> Use modern folio APIs where they exist and convert back to struct
>> page for the internal functions.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Reviewed-by: Phillip Lougher <phillip@squashfs.org.uk>
> Tested-by: Phillip Lougher <phillip@squashfs.org.uk>

Oops, wrong patch-series.

> 
>> ---
>>   fs/squashfs/file.c | 25 +++++++++----------------
>>   1 file changed, 9 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>> index 21aaa96856c1..bc6598c3a48f 100644
>> --- a/fs/squashfs/file.c
>> +++ b/fs/squashfs/file.c
>> @@ -445,21 +445,19 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
>>   static int squashfs_read_folio(struct file *file, struct folio *folio)
>>   {
>> -    struct page *page = &folio->page;
>> -    struct inode *inode = page->mapping->host;
>> +    struct inode *inode = folio->mapping->host;
>>       struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>> -    int index = page->index >> (msblk->block_log - PAGE_SHIFT);
>> +    int index = folio->index >> (msblk->block_log - PAGE_SHIFT);
>>       int file_end = i_size_read(inode) >> msblk->block_log;
>>       int expected = index == file_end ?
>>               (i_size_read(inode) & (msblk->block_size - 1)) :
>>                msblk->block_size;
>>       int res = 0;
>> -    void *pageaddr;
>>       TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
>> -                page->index, squashfs_i(inode)->start);
>> +                folio->index, squashfs_i(inode)->start);
>> -    if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
>> +    if (folio->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
>>                       PAGE_SHIFT))
>>           goto out;
>> @@ -472,23 +470,18 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>>               goto out;
>>           if (res == 0)
>> -            res = squashfs_readpage_sparse(page, expected);
>> +            res = squashfs_readpage_sparse(&folio->page, expected);
>>           else
>> -            res = squashfs_readpage_block(page, block, res, expected);
>> +            res = squashfs_readpage_block(&folio->page, block, res, expected);
>>       } else
>> -        res = squashfs_readpage_fragment(page, expected);
>> +        res = squashfs_readpage_fragment(&folio->page, expected);
>>       if (!res)
>>           return 0;
>>   out:
>> -    pageaddr = kmap_atomic(page);
>> -    memset(pageaddr, 0, PAGE_SIZE);
>> -    kunmap_atomic(pageaddr);
>> -    flush_dcache_page(page);
>> -    if (res == 0)
>> -        SetPageUptodate(page);
>> -    unlock_page(page);
>> +    folio_zero_segment(folio, 0, folio_size(folio));
>> +    folio_end_read(folio, res == 0);
>>       return res;
>>   }

