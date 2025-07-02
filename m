Return-Path: <linux-fsdevel+bounces-53659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E54AF5AB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 16:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FDC446890
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4082BE7A7;
	Wed,  2 Jul 2025 14:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHgxogd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBF2BD59E;
	Wed,  2 Jul 2025 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751465560; cv=none; b=KQDlzjtPvFMdIItTxaiG3XDJNv6mNa2wLumQGeO8j1Ul2mkY4E0OgoFtytL5OA9xUKBQvTN0d0ZfHmcnQ70WZt2GSYtxtzFLa67I3k+P8LA56hp2DtHj9LZ9aGfkH3bpJKr/miKC2z386Pc3/q4CsKgZFsXdW7QMFFAYfD9glUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751465560; c=relaxed/simple;
	bh=Dm6xqHk0RBgx7vLihZyB1iyak1emMrW4rq8J0I4i8o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlyUfpzqTPhTiqo7K6c9SfXm/lgyt9Y/yFlueWAWByBfz0DmN36TQ5hT/tjjRGp2/FmWLBmeSsjb09icPDAdTlIULPo0SYb0+YAuYIudcxQonlLp9c3dGTTqbg+ubXULL2tZnZn/FaizrffZ2wHEJHOeGMF7O2NONjeRGZb73dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHgxogd/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b321bd36a41so3965924a12.2;
        Wed, 02 Jul 2025 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751465555; x=1752070355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hi0b4Q2TMU9s9ow4O1FxnYpGW2LdSH037wzbnfcLAI=;
        b=UHgxogd/e2vGa8mbXR0Ryy0YrcG83M1VqWf+KuzZqVLCBaobO/1gDIRxF6h5ZHpclf
         1hDAxIbT26J+e46c0hYZ1WLHcUp/WBp8K6fsU0pHP7/ZGQQA/mzWkNJS15SwT5q3GmJp
         35zIbo38vxOluo0YLt864gYpQh0HCNUH2LKz9nBJJ2PC4wR4n3ex1Sq8m6Dn7k5HOo7p
         F5tprdjz9MtM1bEj/uRufs7poW/H7h7l6t2FKOtInqNNLpD4JmGFvFn/9RQCRpxbUd+o
         jXdhODCa8KjT81recq+ixZiAGMunRlmTbUQzNBufWFAvHw2uj7f856KaDXg2BkuG0/Hc
         OmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751465555; x=1752070355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3hi0b4Q2TMU9s9ow4O1FxnYpGW2LdSH037wzbnfcLAI=;
        b=Tax2hcW/14/rshrtzjm3E1q7/B/C0qMrTRMcuFpMO3vS76Uxe+GTU+ibTokwlcWvsc
         SSritfsSmGL46i0k9gT0tmzeDOglUayZ2nCw8oOquulUi2ity5oH+pA5z4Ff7QWFggfo
         LDYctO6ZWEy2CBwei61OFp2yJz2Xs4X8US2g3YwJ/wAkc6FdOmckDOc69XkfIpiQozI4
         6DjmtS+vi6uWeh9TLbHfhYER5G4WzdnbBcw4/YMZ4PILNyWe891YiQSaEC7i3tzxm819
         CtXRkUhpp04irKIvTY3aYrivsxZvMEc404ox9ZRZXCTrKNtsZSmHf19cm6VcKRQ4Upca
         NKXw==
X-Forwarded-Encrypted: i=1; AJvYcCUOniCKDhgDCCVgUIEBZ0HW0kGhLKtRRoQ1s/cVn8ALYiX2f1U2t0TXGOP1/KyXgt+xzd1Jnaa1hKWE8yuNsQ==@vger.kernel.org, AJvYcCV8MMG+VWc1+LRY/8Nd3GawytSrzz1zUk6T+t7d78haBJLdlt3OuIoYKXI2BZXGY2Yaovt9g3QkUh5iqQ==@vger.kernel.org, AJvYcCVeX1sopL+Q0IW/sBsrJJ8vBA7KmMrqqAf9QZIVpQPycWH+QILO2jiefx40cP31FWBBT3lSCvRMSVbzK76J@vger.kernel.org, AJvYcCWoivTaPMihWtJnHa4F7FsegHAuvTtW39Uz6Q48cjVYpWfB0ivgvoz317ydDPG3B/VlqNKS+JERfRtjsw==@vger.kernel.org, AJvYcCXSlbXAUHmBnv0jqw4JBGILStDgs+jG7qdsGbwN69Zh2/6rw3A9uw/jDiIj9DmEzDLMy36BQAmzyeFr@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFaBB3/GB06zPjVGqI3a8E9KuaIzxmA+q1WNauyUt0sXG0689
	i11Bb6/tgv7KCm8O6UqvpU96kuucTPWDgimJv82OQhCZIbJ06coPtd25
X-Gm-Gg: ASbGncse17autRLbKo7wvsMqi7sv4xUAFj4TV3w5OSPayzbUFHp03nwqsFY938bQPx2
	3GzF/8zGTGrjW+18JhBfRLb1/+ndY2EFuFp7sxJoMH8ttJ041wITc9gH8bxpEK4NBZq7lw3o+FF
	JKF7dFLcSR3LItJy9qtqwtjv7IWzeStXbeIScNdJxzMdbmMRyuMxHuP1LwyOMGJxsqfmMYk0T+b
	wNxSAfMjGoUSpbe/ljnqd8t213EYXMo+sE1cNo6y+HPK2SJL7+jEpSIHRDVCNBB5SrFXA4NVTQS
	mC3d982wBqRnByvOb159jFtBt7P1ASks7pmBe+gE+omGFGOtjwzXsDtNBzXe32UxXBFRmKIgzN5
	THjntgwD4/1F7YcSsDY1oW014ct5/iIwtqZteqVI=
X-Google-Smtp-Source: AGHT+IFKRDLioih13g48ycaXA5K8ysUyKk1vSQvjV96+wwiKTloc/oO2WVx/lFSAoNhOajXgeeSAFQ==
X-Received: by 2002:a05:6a20:a126:b0:21d:fd1:9be with SMTP id adf61e73a8af0-222d7de1c90mr4563817637.12.1751465555071;
        Wed, 02 Jul 2025 07:12:35 -0700 (PDT)
Received: from ?IPV6:240e:305:798e:6800:ad23:906d:e07c:8a1e? ([240e:305:798e:6800:ad23:906d:e07c:8a1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af56ce9f3sm14100034b3a.122.2025.07.02.07.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 07:12:34 -0700 (PDT)
Message-ID: <54a85ec6-992d-4685-9031-114ba634e0a3@gmail.com>
Date: Wed, 2 Jul 2025 22:12:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] fs: change write_begin/write_end interface to take
 struct kiocb *
To: Matthew Wilcox <willy@infradead.org>
Cc: "tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "chentao325@qq.com" <chentao325@qq.com>,
 "frank.li@vivo.com" <frank.li@vivo.com>
References: <20250627110257.1870826-1-chentaotao@didiglobal.com>
 <20250627110257.1870826-4-chentaotao@didiglobal.com>
 <aF68sKzx24P1q54h@casper.infradead.org>
From: Taotao Chen <chentt325@gmail.com>
In-Reply-To: <aF68sKzx24P1q54h@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/6/27 23:45, Matthew Wilcox 写道:
> On Fri, Jun 27, 2025 at 11:03:11AM +0000, 陈涛涛 Taotao Chen wrote:
>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
>> index 841a5b18e3df..fdc2fa1e5c41 100644
>> --- a/fs/exfat/file.c
>> +++ b/fs/exfat/file.c
>> @@ -532,10 +532,12 @@ int exfat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>>   	return blkdev_issue_flush(inode->i_sb->s_bdev);
>>   }
>>   
>> -static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
>> +static int exfat_extend_valid_size(const struct kiocb *iocb,
>> +				   loff_t new_valid_size)
>>   {
>>   	int err;
>>   	loff_t pos;
>> +	struct file *file = iocb->ki_filp;
>>   	struct inode *inode = file_inode(file);
>>   	struct exfat_inode_info *ei = EXFAT_I(inode);
>>   	struct address_space *mapping = inode->i_mapping;
>> @@ -551,14 +553,14 @@ static int exfat_extend_valid_size(struct file *file, loff_t new_valid_size)
>>   		if (pos + len > new_valid_size)
>>   			len = new_valid_size - pos;
>>   
>> -		err = ops->write_begin(file, mapping, pos, len, &folio, NULL);
>> +		err = ops->write_begin(iocb, mapping, pos, len, &folio, NULL);
>>   		if (err)
>>   			goto out;
>>   
>>   		off = offset_in_folio(folio, pos);
>>   		folio_zero_new_buffers(folio, off, off + len);
>>   
>> -		err = ops->write_end(file, mapping, pos, len, len, folio, NULL);
>> +		err = ops->write_end(iocb, mapping, pos, len, len, folio, NULL);
>>   		if (err < 0)
>>   			goto out;
>>   		pos += len;
>> @@ -604,7 +606,7 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
>>   	}
>>   
>>   	if (pos > valid_size) {
>> -		ret = exfat_extend_valid_size(file, pos);
>> +		ret = exfat_extend_valid_size(iocb, pos);
>>   		if (ret < 0 && ret != -ENOSPC) {
>>   			exfat_err(inode->i_sb,
>>   				"write: fail to zero from %llu to %llu(%zd)",
>> @@ -655,8 +657,11 @@ static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
>>   	struct file *file = vma->vm_file;
>>   	struct inode *inode = file_inode(file);
>>   	struct exfat_inode_info *ei = EXFAT_I(inode);
>> +	struct kiocb iocb;
>>   	loff_t start, end;
>>   
>> +	init_sync_kiocb(&iocb, file);
>> +
>>   	if (!inode_trylock(inode))
>>   		return VM_FAULT_RETRY;
>>   
>> @@ -665,7 +670,7 @@ static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
>>   			start + vma->vm_end - vma->vm_start);
>>   
>>   	if (ei->valid_size < end) {
>> -		err = exfat_extend_valid_size(file, end);
>> +		err = exfat_extend_valid_size(&iocb, end);
>>   		if (err < 0) {
>>   			inode_unlock(inode);
>>   			return vmf_fs_error(err);
> This is unnecessary work.  The only ->write_begin/write_end that we'll
> see here is exfat_write_begin() / exfat_write_end() which don't actually
> need iocb (or file).  Traditionally we pass NULL in these situations,
> but the exfat people probably weren't aware of this convention.
>
> exfat_extend_valid_size() only uses the file it's passed to get the
> inode, and both callers already have the inode.  So I'd change
> exfat_extend_valid_size() to take an inode instead of a file as its
> first argument, then you can skip the creation of an iocb in
> exfat_page_mkwrite().


My initial goal was to maintain consistency with the updated ->write_begin/

->write_end interfaces. That meant passing the iocb to avoid special cases

and keep the changes minimal and safe.

But you're right, since exfat_write_begin() and exfat_write_end() don't 
use the

iocb or file pointer, passing NULL is fine, and having 
exfat_extend_valid_size()

directly take an inode makes the code simpler and clearer.


In addition, inside the ntfs_extend_initialized_size() function, I also 
set the iocb

parameter to NULL when calling ntfs_write_begin() and ntfs_write_end().




