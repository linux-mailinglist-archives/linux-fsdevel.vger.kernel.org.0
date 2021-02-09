Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39D6314B68
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBIJWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 04:22:33 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8547 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229894AbhBIJTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:19:00 -0500
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; 
   d="scan'208";a="104367244"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Feb 2021 17:15:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A2C304CE6F86;
        Tue,  9 Feb 2021 17:15:13 +0800 (CST)
Received: from irides.mr (10.167.225.141) by G08CNEXMBPEKD05.g08.fujitsu.local
 (10.167.33.204) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 9 Feb
 2021 17:15:12 +0800
Subject: Re: [PATCH 5/7] fsdax: Dedup file range to use a compare function
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <willy@infradead.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
        <linux-btrfs@vger.kernel.org>, <ocfs2-devel@oss.oracle.com>,
        <david@fromorbit.com>, <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20210207170924.2933035-1-ruansy.fnst@cn.fujitsu.com>
 <20210207170924.2933035-6-ruansy.fnst@cn.fujitsu.com>
 <20210208151920.GE12872@lst.de>
From:   Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Message-ID: <9193e305-22a1-3928-0675-af1cecd28942@cn.fujitsu.com>
Date:   Tue, 9 Feb 2021 17:15:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208151920.GE12872@lst.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204)
X-yoursite-MailScanner-ID: A2C304CE6F86.ACFE6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/8 下午11:19, Christoph Hellwig wrote:
> On Mon, Feb 08, 2021 at 01:09:22AM +0800, Shiyang Ruan wrote:
>> With dax we cannot deal with readpage() etc. So, we create a
>> funciton callback to perform the file data comparison and pass
> 
> s/funciton/function/g
> 
>> +#define MIN(a, b) (((a) < (b)) ? (a) : (b))
> 
> This should use the existing min or min_t helpers.
> 
> 
>>   int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>>   				  struct file *file_out, loff_t pos_out,
>> -				  loff_t *len, unsigned int remap_flags)
>> +				  loff_t *len, unsigned int remap_flags,
>> +				  compare_range_t compare_range_fn)
> 
> Can we keep generic_remap_file_range_prep as-is, and add a new
> dax_remap_file_range_prep, both sharing a low-level
> __generic_remap_file_range_prep implementation?  And for that
> implementation I'd also go for classic if/else instead of the function
> pointer.

The dax dedupe comparison need the iomap_ops pointer as argument, so my 
understanding is that we don't modify the argument list of 
generic_remap_file_range_prep(), but move its code into 
__generic_remap_file_range_prep() whose argument list can be modified to 
accepts the iomap_ops pointer.  Then it looks like this:

```
int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
				  struct file *file_out, loff_t pos_out,
				  loff_t *len, unsigned int remap_flags,
				  const struct iomap_ops *ops)
{
	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
			pos_out, len, remap_flags, ops);
}
EXPORT_SYMBOL(dax_remap_file_range_prep);

int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
				  struct file *file_out, loff_t pos_out,
				  loff_t *len, unsigned int remap_flags)
{
	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
			pos_out, len, remap_flags, NULL);
}
EXPORT_SYMBOL(generic_remap_file_range_prep);
```

Am i right?


--
Thanks,
Ruan Shiyang.

> 
>> +extern int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
>> +					 struct inode *dest, loff_t destoff,
>> +					 loff_t len, bool *is_same);
> 
> no need for the extern.
> 
> 


