Return-Path: <linux-fsdevel+bounces-8271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B3A831F45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 19:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 895C2285154
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1DE2E401;
	Thu, 18 Jan 2024 18:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hlriTmg7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1532E3FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705603914; cv=none; b=Pdg71NPv2+WLtcL27f6zY+GEPxmqOozGnAynTiAhclvDBecWCUhbOVJ6h42Km5ud1pysMqz7+5gifD79Hqx3dRfW/gNuMbNFJtTN3lJQmfqwwJeFzrxwebA9O1yowE5OzNHDv4lr+OOnLid0/OSDoBRDFq41Ze0NE0t2PyocYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705603914; c=relaxed/simple;
	bh=oI6FvZqMbO9wp9RV7/TFEi79nYF+EBJm0B2fSXoFDMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oJQPs+HzJYcc9pjfZH/yZ92PxLMA4vGih3BFmqwHZrOGWrDCT9nfddjLjysk7fP6dh/6zirfLUCB2A/qObu2y3PG5XRLzH9/422KU8n4f0kUA7srAnBUvpC7jqdzGhnG8YgiJrQ2laf0QO3RtgnL44InJvVMCxxKzh2pLlwccH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hlriTmg7; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240118185143epoutp0209db45b0550ddebdf52728af64a22561~rhba4KhbB3062430624epoutp02V
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 18:51:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240118185143epoutp0209db45b0550ddebdf52728af64a22561~rhba4KhbB3062430624epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705603903;
	bh=oztZkiRrpDW8Hw6r9bH6GEUAxeaCmhaR9M6Ul05bfLg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hlriTmg7pfClIhAFOT2AAXQJoD6iXhMUZq7mvSN2xllT6Mw2P1qjRB5SyVSuE1lnp
	 w/szsnIEqZB3Od8kAZAcrP+YV/wBAyxxktqNR/gPrqAX4V3Z+FBU8YK5OX2zHrCsea
	 xbh1+pSVK50fBI10PKRC+UvtKt6kqHKs35bjRy3o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240118185142epcas5p435343e17ee59310f19d6e813a7285908~rhbZijrJq3047030470epcas5p49;
	Thu, 18 Jan 2024 18:51:42 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TGBg03dqqz4x9Pt; Thu, 18 Jan
	2024 18:51:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.B9.10009.C3379A56; Fri, 19 Jan 2024 03:51:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240118185139epcas5p46946aaed9a375ec4199bbda7aaf1552b~rhbXVQlDQ0349403494epcas5p4q;
	Thu, 18 Jan 2024 18:51:39 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240118185139epsmtrp225db2df454a36c02cd0e338c3f8a10cf~rhbXUhXo-2400624006epsmtrp2f;
	Thu, 18 Jan 2024 18:51:39 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-e2-65a9733c0ff8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.E2.18939.B3379A56; Fri, 19 Jan 2024 03:51:39 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240118185137epsmtip1000035065e54acea4a4f64fe48b7b525~rhbVidIc82329923299epsmtip1B;
	Thu, 18 Jan 2024 18:51:37 +0000 (GMT)
Message-ID: <b294a619-c37e-cb05-79a8-8a62aec88c7f@samsung.com>
Date: Fri, 19 Jan 2024 00:21:37 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v8 06/19] block, fs: Propagate write hints to the block
 device inode
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Daejun Park
	<daejun7.park@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH7/tsjAdz+jjx9h1duD2dhRRzw7EeEuiHaE9RxmV3GdcdPW7f
	A46x7fZs6eyScWUpiASUByOi7jiDWWdN+bHcPANhmSaY6WQ7EnVkBgyc3tGAsm0PGf+9Pu/7
	/P58vzhP5Bak4GV6MzLpGR0pWMbv7l+flpHDdiJFb4+YOjpaJ6Am+sOAOjwT4VH3R29hlGPs
	Darz6ABGRY44EimP/wnK7TnLp2p8vQLqK+8/GDX0tzfh2eX0pV8L6Es/W2in44CAPjliE9B3
	xv18+tAJB6DvOlNpZ3AKK8SLynNKEaNFJinSawzaMn1JLlmwvXhzcZZaocxQZlNPkVI9U4Fy
	yfyXCzO2lumirZLSdxidJSoVMixLbsjLMRksZiQtNbDmXBIZtTqjyihnmQrWoi+R65H5aaVC
	kZkVdXy7vLSqfoxvdEl31xwMAhvwSKpBEg4JFayv+z2hGizDRcRJAIc7v+NzRhjA85EG3gNj
	oPty1MDjIa6FNE53ATj740IiZ0wBOORqFcTyCok82D/ydWKM+cQ6OOeb4HH6Kni2OciP8Rpi
	J5y7/BmI8WqiCLY3euI+PEIM/cE2LFYsmaChf3IbJ/+FwaYrspgsINbD4UZLTE4iNsFgQwDj
	XNbC97ta4j1Dwo3D2v7WxZ7z4Ue1j3ITr4Z/ek8kcpwC74Y8Ao418JfmCxjHZnjT/cMiPwP3
	/VQXT8OLlj32/Qau1ApYOx/EuOxCuP9DEectg781jCdwLIbXm9oXmYbhkUMYt6gbGGzr8oOP
	gdS+ZCf2JbPbl0xj/7/yF4DvABJkZCtKEJtlzNSjXQ+urTFUOEH8Gae/1Auuj83I+wCGgz4A
	cR6ZLHxVcQSJhFrGugeZDMUmiw6xfSArepx6XsoajSH6D/TmYqUqW6FSq9Wq7I1qJSkWTuxr
	1YqIEsaMyhEyItN/cRielGLDDk5tnJkNedPpvV/qbjQpxdNbW3yS6Q+uHJB11L4SkJ2uN9C3
	y64hrTG80HK8eZWWX143Jt1rRQ6YPPS85A7Mb5wyWLdcHOXtHzwXejz9sWDNHse9286AvXJH
	8vGVNrtvfqxw54qGtos9D2dcmFQlLW/OHN+Wce5U+ynNYXOj+6rjdd/QzWth0THB+dmp1soC
	a+qZjmBeuPVd/K3pzPeqrk5Kqh9RRz73Dzodz2UZ/3jI3i0Nna7+lJ7/tioI5naNp86eeXNW
	E/qkKGC73/Pijh51x71eamB+3ZOub4o30aDSvn3wtbVykPbCgmelanfAFo50WcdTh9ugTH7L
	62nfQvLZUkaZzjOxzL8ovn2DTwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSnK518cpUg/VHdS1W3+1ns3h9+BOj
	xbQPP5kt/t99zmSx6kG4xcrVR5ksfi5bxW6x95a2xZ69J1ksuq/vYLNYfvwfk8X5v8dZHXg8
	Ll/x9rh8ttRj06pONo/dNxvYPD4+vcXi0bdlFaPH501yHpuevGUK4IjisklJzcksSy3St0vg
	ymic+IClYKdCRXfPE8YGxr2SXYwcHBICJhI7/2h0MXJxCAlsZ5S4dOU7excjJ1BcXKL52g8o
	W1hi5b/n7BBFrxklLt7ezgKS4BWwkzh8cw1YEYuAqsSv66+ZIeKCEidnPgGrERVIkthzv5EJ
	xBYWiJJYMnkvWA0z0IJbT+YzgRwhIuAhceuNH8h8ZoFfTBINj69DLbvHJDFh8gR2kCI2AU2J
	C5NLQXo5Bawlnky6zQQxx0yia2sXI4QtL9G8dTbzBEahWUjOmIVk3SwkLbOQtCxgZFnFKJpa
	UJybnptcYKhXnJhbXJqXrpecn7uJERx1WkE7GJet/6t3iJGJg/EQowQHs5IIr7/BslQh3pTE
	yqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGJoG6id7Xq7dt5dl1
	z1718Tt+3VNJiS8VL7bVXlgnEBB1vPgiU9S3VoHMz6zfeh7vb17o9b4maufCJwndoWuTz5uu
	NOxksn1js3XO9ahp0rNNrvRxp68RsAk7pimZ8zRyVuSm1Jm2ChcZP9akvbvwoKhgxZkr3BvX
	CnyznjVz+3GO06685u/FPvTlKF3LzvQomvvSpudwOkeEkv2RfFP2wy4zvF0rkgtfl9R8cbM9
	blU9wcJK2GbCvBnHLWJ2hUS+nFH8VearQ+6BpJvFbP3tk8s6dM4sTtE308rdK/Yu49LqkytT
	pk88cedY19Y/U1VsuH1El6RWcy7M3mp4yYBLe5PN/m3OTXoWTfP1/syuVmIpzkg01GIuKk4E
	AHVcQcwpAwAA
X-CMS-MailID: 20240118185139epcas5p46946aaed9a375ec4199bbda7aaf1552b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240103230906epcas5p468e1779bf14eeaa6f70f045be85afffc
References: <20231219000815.2739120-1-bvanassche@acm.org>
	<20231219000815.2739120-7-bvanassche@acm.org>
	<20231228071206.GA13770@lst.de>
	<00cf8ffa-8ad5-45e4-bf7c-28b07ab4de21@acm.org>
	<20240103090204.GA1851@lst.de>
	<CGME20240103230906epcas5p468e1779bf14eeaa6f70f045be85afffc@epcas5p4.samsung.com>
	<23753320-63e5-4d76-88e2-8f2c9a90505c@acm.org>

On 1/4/2024 4:39 AM, Bart Van Assche wrote:
> On 1/3/24 01:02, Christoph Hellwig wrote:
>> So you can use file->f_mapping->inode as I said in my previous mail.
> 
> Since struct address_space does not have a member with the name "inode",
> I assume that you meant "host" instead of "inode"? If so, how about
> modifying patch 06 of this series as shown below? With the patch below
> my tests still pass.
> 
> Thanks,
> 
> Bart.
> 
> 
> ---
>   block/fops.c       | 11 -----------
>   fs/fcntl.c         | 15 +++++++++++----
>   include/linux/fs.h |  1 -
>   3 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/block/fops.c b/block/fops.c
> index 138b388b5cb1..787ce52bc2c6 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -620,16 +620,6 @@ static int blkdev_release(struct inode *inode, 
> struct file *filp)
>       return 0;
>   }
> 
> -static void blkdev_apply_whint(struct file *file, enum rw_hint hint)
> -{
> -    struct bdev_handle *handle = file->private_data;
> -    struct inode *bd_inode = handle->bdev->bd_inode;
> -
> -    inode_lock(bd_inode);
> -    bd_inode->i_write_hint = hint;
> -    inode_unlock(bd_inode);
> -}
> -
>   static ssize_t
>   blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
>   {
> @@ -864,7 +854,6 @@ const struct file_operations def_blk_fops = {
>       .splice_read    = filemap_splice_read,
>       .splice_write    = iter_file_splice_write,
>       .fallocate    = blkdev_fallocate,
> -    .apply_whint    = blkdev_apply_whint,
>   };
> 
>   static __init int blkdev_init(void)
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 18407bf5bb9b..cfb52c3a4577 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -306,7 +306,6 @@ static long fcntl_get_rw_hint(struct file *file, 
> unsigned int cmd,
>   static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
>                     unsigned long arg)
>   {
> -    void (*apply_whint)(struct file *, enum rw_hint);
>       struct inode *inode = file_inode(file);
>       u64 __user *argp = (u64 __user *)arg;
>       u64 hint;
> @@ -318,11 +317,19 @@ static long fcntl_set_rw_hint(struct file *file, 
> unsigned int cmd,
> 
>       inode_lock(inode);
>       inode->i_write_hint = hint;
> -    apply_whint = inode->i_fop->apply_whint;
> -    if (apply_whint)
> -        apply_whint(file, hint);
>       inode_unlock(inode);
> 
> +    /*
> +     * file->f_mapping->host may differ from inode. As an example,
> +     * blkdev_open() modifies file->f_mapping.
> +     */
> +    if (file->f_mapping->host != inode) {
> +        inode = file->f_mapping->host;
> +        inode_lock(inode);
> +        inode->i_write_hint = hint;
> +        inode_unlock(inode);
> +    }
> +

Are you considering to change this so that hint is set only on one inode 
(and not on two)?
IOW, should not this fragment be like below:

--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -306,7 +306,6 @@ static long fcntl_get_rw_hint(struct file *file, 
unsigned int cmd,
  static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
                               unsigned long arg)
  {
-       void (*apply_whint)(struct file *, enum rw_hint);
         struct inode *inode = file_inode(file);
         u64 __user *argp = (u64 __user *)arg;
         u64 hint;
@@ -316,11 +315,15 @@ static long fcntl_set_rw_hint(struct file *file, 
unsigned int cmd,
         if (!rw_hint_valid(hint))
                 return -EINVAL;

+       /*
+        * file->f_mapping->host may differ from inode. As an example
+        * blkdev_open() modifies file->f_mapping
+        */
+       if (file->f_mapping->host != inode)
+               inode = file->f_mapping->host;
+
         inode_lock(inode);
         inode->i_write_hint = hint;
-       apply_whint = inode->i_fop->apply_whint;
-       if (apply_whint)
-               apply_whint(file, hint);
         inode_unlock(inode);

