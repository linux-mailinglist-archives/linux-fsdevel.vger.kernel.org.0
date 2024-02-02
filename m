Return-Path: <linux-fsdevel+bounces-10031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA2F8472E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC383B2430A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C361160249;
	Fri,  2 Feb 2024 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BFpQ0vey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A3145B21;
	Fri,  2 Feb 2024 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887016; cv=none; b=gTIfKcF2zgWBoorwP0MlAyOElJDoywStAMliVNbGwboqDA/2E4reXxQzenTSey7glddK9HzES6rGMejn7+pIBvtM0FNXiyY8QcjT670u6Zz1XtWJKPGIUFsD6b4kTfBzhjLZNn0Uc9lO7tk02jad0oiWKygA8lUfMN1WBarpkyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887016; c=relaxed/simple;
	bh=YCw4cDXb5/di2nLxfvW5MuQDHp4yTAmjCvodHy7oN3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kV94zy3gPirJBSoMB1Ljm9d9laV+bW4Qabm9o9JMJzEYKtmUdA9jR+Eng/gO5JIeVzQH/yCOMYdlMqfWM7f+0jXtusi8zKZAqjFpvUimI4XtEHLuWUFs1y2WSSkE09f39TTOrkqv0SXx/k3089SGyELO7h0LhgfX4gZqJMMYNsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BFpQ0vey; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412Dsi0Z028349;
	Fri, 2 Feb 2024 15:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GFtXPX2zDBlf3MAJ3pukKKNv5yphK9EH9NBq7OjssgE=;
 b=BFpQ0veya5P5aiOv3v/TyuTBi5p4RoiVy3SduXgNKkD4lgSLBybC/s/mBvBVZbb6CKdf
 11yINgbbkTKOlxhSl4hzpyNtSsc7S5RRC5nJLpAkPiEaWV913kMdlYVpSHYsv1crh5rc
 UJoq8XEaYo82m3UMFDnCBYo5ZkNH12zVmbOdOZbQpaxwuokx/wRgSt9/5yd0lr8wP00k
 IV+mp0zl2s8/T+ew5e2iKW6fek0kRwdGx4y1Zk/+Lr2qMa8gSvTH14JsOsw8Nm9kv16Z
 0TRKsd/uJt/vS1wY5Jpyc7+cFRbNI7uz+8Jz+KcnAKKDlqmfOtWsUEP+YtqDKjuzAhP8 kA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w119t2s05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:16:51 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412EobWe031909;
	Fri, 2 Feb 2024 15:16:50 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w119t2rya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:16:50 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 412D3CDl010496;
	Fri, 2 Feb 2024 15:16:49 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5pc15m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 15:16:49 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 412FGmDR1049304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Feb 2024 15:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C252358058;
	Fri,  2 Feb 2024 15:16:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3994B58057;
	Fri,  2 Feb 2024 15:16:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Feb 2024 15:16:48 +0000 (GMT)
Message-ID: <9ff0da83-0be2-4fdc-8108-e65e043eacc3@linux.ibm.com>
Date: Fri, 2 Feb 2024 10:16:47 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: make file_dentry() a simple accessor
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-2-amir73il@gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240202110132.1584111-2-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P3Mv1-12CZv5utfzHqyFN1v8eijGksFn
X-Proofpoint-GUID: 4mmjaq20M99V0eXW4Cr3Vf1BCSQ6n2hT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=639 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402020111



On 2/2/24 06:01, Amir Goldstein wrote:
> file_dentry() is a relic from the days that overlayfs was using files with
> a "fake" path, meaning, f_path on overlayfs and f_inode on underlying fs.
> 
> In those days, file_dentry() was needed to get the underlying fs dentry
> that matches f_inode.
> 
> Files with "fake" path should not exist nowadays, so make file_dentry() a
> simple accessor and use an assertion to make sure that file_dentry() was
> not papering over filesystem bugs.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   include/linux/fs.h | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 023f37c60709..de9aa86d2624 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1078,9 +1078,20 @@ static inline struct inode *file_inode(const struct file *f)
>   	return f->f_inode;
>   }
>   
> +/*
> + * file_dentry() is a relic from the days that overlayfs was using files with a
> + * "fake" path, meaning, f_path on overlayfs and f_inode on underlying fs.
> + * In those days, file_dentry() was needed to get the underlying fs dentry that
> + * matches f_inode.
> + * Files with "fake" path should not exist nowadays, so use an assertion to make
> + * sure that file_dentry() was not papering over filesystem bugs.
> + */
>   static inline struct dentry *file_dentry(const struct file *file)
>   {
> -	return d_real(file->f_path.dentry, file_inode(file));
> +	struct dentry *dentry = file->f_path.dentry;
> +
> +	WARN_ON_ONCE(d_inode(dentry) != file_inode(file));
> +	return dentry;
>   }
>   
>   struct fasync_struct {

