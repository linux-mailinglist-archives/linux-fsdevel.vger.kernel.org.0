Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED13F28F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhHTJO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 05:14:26 -0400
Received: from mout.gmx.net ([212.227.17.21]:44883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhHTJOZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629450821;
        bh=mv68t2KMUNZ8GHcJbnlnEl3mJiU8oOKfYlzayd9FKHE=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Fe7GOohfRYSNo6CSkrBejOKh/M/QuJF/OOI6PLeTIITi42OxOtq+xy8BgfaPWqQRs
         IXnKzkpTkb0hEZGxtMYvinFCNY/HKcCvoN9I1/w4ikD0DsnbmB5jqEc81tN85GICBH
         YjeyO0vxpSd3hnv3YbEtK4OYEtsp95JzpGos6o08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7sHy-1mC2WE3hhK-004xoS; Fri, 20
 Aug 2021 11:13:41 +0200
To:     Nikolay Borisov <nborisov@suse.com>,
        Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <cover.1629234193.git.osandov@fb.com>
 <a00b59623219c8a07f2c22f80ef1466d0f182d77.1629234193.git.osandov@fb.com>
 <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v10 06/14] btrfs: optionally extend i_size in
 cow_file_range_inline()
Message-ID: <2eae3b11-d9aa-42b1-122e-49bd40258d9b@gmx.com>
Date:   Fri, 20 Aug 2021 17:13:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1b495420-f4c6-6988-c0b1-9aa8a7aa952d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aulkFjfLhLeRWSv8bX8WIfa6s+amzSZjKJsdcFS0E6pGAMtu711
 PxpHgCfAHFFxZ5IZTWQepyJKPMX68UGWhjYs89kX+7q8BiNiQ5h1MrhNHFc5pAYshwQnBBj
 NoKQ47uB6a/XwzlB/mOXXZz9SorhljQllKYWReqZBLpdf5dm23Y66r8vWduDC1YrDMrQYmN
 FzPKD/6NGMtaKwjNVxwYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iWYbzrOcXyY=:H3yecQ+4AboPf/dkIYPiGI
 D/NO5yfWhjRufIV/3KYcKhFSnh0oN3w2A+WhcPOJUlrrES9LSiSvxNEFhnxVKrBBOfnTYXV+I
 fAd1gDDc7oENlUxExy0Ddl6OjEHbGm04OHuh7Qf839hKw3hsV88cyCbTHCo3ZoDlRgx/BmP4o
 cJE/2yacqf/KxXFZ4eIpX6/m1RyexT6+C83AXcfQJlnHp73I2vQvwh097s2ofR1bQuEt9S7+y
 isTcNkYX8nz15JOvsadyJQIAgShieynEfbni59vgI6VE9lBM0ct8gO4+rrOpgm5VIGiIQD7Q9
 F6C//KCVt9Rzql1b/p/394QtX10DHwkEuTJnes/eNOCWpiXJVZ5/vycEVU7/t5ITjTuFWu/yi
 LANifOO6PKOo3h71IODshnDK5HJEGmRriIo7k85xEVsiqm2haEEm38cMcBcdcN95bO1V5K0oQ
 WaIWIeLP0kDokOC0+zcszvFtJE06Y92Fo+rNTZrLhq9XXDstkmTAuXN6cc9KcZUBJ7BGWxdPo
 zADIUxjojt2ze95KopbZSbrxvQ+xy1tB37vCCPEnbQM4vW0AMRa+xhrsT3AGa59G8J+U3mbES
 e9V6l3EiYNLsGct7uZeV2REpN/LS846QjK9Nru2f1YUFZ3uoTGNvLdC6dfathO1654k0OnDDX
 mv3KVizdCmS4ZhuWvYlGYFBFHakFB5Zgx/IYoXx6AMFhLBHBSxfqITmho8UvmhUfZDagEEkaQ
 G11sdwj2lX1uS5eEdcPdstfCPdpEq82sk06fqzuHH2DqHIlfLC5bLSmf+il3xqPf+C8Av45Nv
 ZDzwyv2NZ9ADs4HxKQ9CreU+QAzcma3+dgMEQL6K1+4UyL1Ng+oPx8ke5WNrB29jXFtIDXXGH
 C++/mdvkIgMAexukjXNuRZPfuJQarbuJbnnOggpYnOINV+KESNZAhQ5UrD8blWA9qV77RDFCW
 jZAxRo/G9TkDctTD5uVw1NbAtJNa37fFzUbvN304Z2zqAcSXSqQkYmmXsM7u9BufqrSpvP5uX
 7TAuJN0nk1tI9IxPQp2FeSDM+CSqq8TxL4OTm94yzEm48PbkTH1C+eCRkkhxHYgxNHSSRkIDH
 kA3jk0iCv2mPNyo+MNsxcF1e5DtmpEm4LMRfbOE7zH7J8af5AXVtOUE/g==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/8/20 =E4=B8=8B=E5=8D=884:51, Nikolay Borisov wrote:
>
>
> On 18.08.21 =D0=B3. 0:06, Omar Sandoval wrote:
>> From: Omar Sandoval <osandov@fb.com>
>>
>> Currently, an inline extent is always created after i_size is extended
>> from btrfs_dirty_pages(). However, for encoded writes, we only want to
>> update i_size after we successfully created the inline extent.

To me, the idea of write first then update isize is just going to cause
tons of inline extent related prblems.

The current example is falloc, which only update the isize after the
falloc finishes.

This behavior has already bothered me quite a lot, as it can easily
create mixed inline and regular extents.

Can't we remember the old isize (with proper locking), enlarge isize
(with holes filled), do the write.

If something wrong happened, we truncate the isize back to its old isize.

>> Add an
>> update_i_size parameter to cow_file_range_inline() and
>> insert_inline_extent() and pass in the size of the extent rather than
>> determining it from i_size. Since the start parameter is always passed
>> as 0, get rid of it and simplify the logic in these two functions. Whil=
e
>> we're here, let's document the requirements for creating an inline
>> extent.
>>
>> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: Omar Sandoval <osandov@fb.com>
>> ---
>>   fs/btrfs/inode.c | 100 +++++++++++++++++++++++-----------------------=
-
>>   1 file changed, 48 insertions(+), 52 deletions(-)
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 708d8ab098bc..0b5ff14aa7fd 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -236,9 +236,10 @@ static int btrfs_init_inode_security(struct btrfs_=
trans_handle *trans,
>>   static int insert_inline_extent(struct btrfs_trans_handle *trans,
>>   				struct btrfs_path *path, bool extent_inserted,
>>   				struct btrfs_root *root, struct inode *inode,
>> -				u64 start, size_t size, size_t compressed_size,
>> +				size_t size, size_t compressed_size,
>>   				int compress_type,
>> -				struct page **compressed_pages)
>> +				struct page **compressed_pages,
>> +				bool update_i_size)
>>   {
>>   	struct extent_buffer *leaf;
>>   	struct page *page =3D NULL;
>> @@ -247,7 +248,7 @@ static int insert_inline_extent(struct btrfs_trans_=
handle *trans,
>>   	struct btrfs_file_extent_item *ei;
>>   	int ret;
>>   	size_t cur_size =3D size;
>> -	unsigned long offset;
>> +	u64 i_size;
>>
>>   	ASSERT((compressed_size > 0 && compressed_pages) ||
>>   	       (compressed_size =3D=3D 0 && !compressed_pages));
>> @@ -260,7 +261,7 @@ static int insert_inline_extent(struct btrfs_trans_=
handle *trans,
>>   		size_t datasize;
>>
>>   		key.objectid =3D btrfs_ino(BTRFS_I(inode));
>> -		key.offset =3D start;
>> +		key.offset =3D 0;
>>   		key.type =3D BTRFS_EXTENT_DATA_KEY;
>>
>>   		datasize =3D btrfs_file_extent_calc_inline_size(cur_size);
>> @@ -297,12 +298,10 @@ static int insert_inline_extent(struct btrfs_tran=
s_handle *trans,
>>   		btrfs_set_file_extent_compression(leaf, ei,
>>   						  compress_type);
>>   	} else {
>> -		page =3D find_get_page(inode->i_mapping,
>> -				     start >> PAGE_SHIFT);
>> +		page =3D find_get_page(inode->i_mapping, 0);
>>   		btrfs_set_file_extent_compression(leaf, ei, 0);
>>   		kaddr =3D kmap_atomic(page);
>> -		offset =3D offset_in_page(start);
>> -		write_extent_buffer(leaf, kaddr + offset, ptr, size);
>> +		write_extent_buffer(leaf, kaddr, ptr, size);
>>   		kunmap_atomic(kaddr);
>>   		put_page(page);
>>   	}
>> @@ -313,8 +312,8 @@ static int insert_inline_extent(struct btrfs_trans_=
handle *trans,
>>   	 * We align size to sectorsize for inline extents just for simplicit=
y
>>   	 * sake.
>>   	 */
>> -	size =3D ALIGN(size, root->fs_info->sectorsize);
>> -	ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size=
);
>> +	ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
>> +					ALIGN(size, root->fs_info->sectorsize));
>>   	if (ret)
>>   		goto fail;
>>
>> @@ -327,7 +326,13 @@ static int insert_inline_extent(struct btrfs_trans=
_handle *trans,
>>   	 * before we unlock the pages.  Otherwise we
>>   	 * could end up racing with unlink.
>>   	 */
>> -	BTRFS_I(inode)->disk_i_size =3D inode->i_size;
>> +	i_size =3D i_size_read(inode);
>> +	if (update_i_size && size > i_size) {
>> +		i_size_write(inode, size);
>> +		i_size =3D size;
>> +	}
>> +	BTRFS_I(inode)->disk_i_size =3D i_size;
>> +
>>   fail:
>>   	return ret;
>>   }
>> @@ -338,35 +343,31 @@ static int insert_inline_extent(struct btrfs_tran=
s_handle *trans,
>>    * does the checks required to make sure the data is small enough
>>    * to fit as an inline extent.
>>    */
>> -static noinline int cow_file_range_inline(struct btrfs_inode *inode, u=
64 start,
>> -					  u64 end, size_t compressed_size,
>> +static noinline int cow_file_range_inline(struct btrfs_inode *inode, u=
64 size,
>> +					  size_t compressed_size,
>>   					  int compress_type,
>> -					  struct page **compressed_pages)
>> +					  struct page **compressed_pages,
>> +					  bool update_i_size)
>>   {
>>   	struct btrfs_drop_extents_args drop_args =3D { 0 };
>>   	struct btrfs_root *root =3D inode->root;
>>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>>   	struct btrfs_trans_handle *trans;
>> -	u64 isize =3D i_size_read(&inode->vfs_inode);
>> -	u64 actual_end =3D min(end + 1, isize);
>> -	u64 inline_len =3D actual_end - start;
>> -	u64 aligned_end =3D ALIGN(end, fs_info->sectorsize);
>> -	u64 data_len =3D inline_len;
>> +	u64 data_len =3D compressed_size ? compressed_size : size;
>>   	int ret;
>>   	struct btrfs_path *path;
>>
>> -	if (compressed_size)
>> -		data_len =3D compressed_size;
>> -
>> -	if (start > 0 ||
>> -	    actual_end > fs_info->sectorsize ||
>> +	/*
>> +	 * We can create an inline extent if it ends at or beyond the current
>> +	 * i_size, is no larger than a sector (decompressed), and the (possib=
ly
>> +	 * compressed) data fits in a leaf and the configured maximum inline
>> +	 * size.
>> +	 */
>
> Urgh, just some days ago Qu was talking about how awkward it is to have
> mixed extents in a file. And now, AFAIU, you are making them more likely
> since now they can be created not just at the beginning of the file but
> also after i_size write. While this won't be a problem in and of itself
> it goes just the opposite way of us trying to shrink the possible cases
> when we can have mixed extents.

Tree-checker should reject such inline extent at non-zero offset.

> Qu what is your take on that?

My question is, why encoded write needs to bother the inline extents at al=
l?

My intuition of such encoded write is, it should not create inline
extents at all.

Or is there any special use-case involved for encoded write?

Thanks,
Qu


>
> <snip>
>
