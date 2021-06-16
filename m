Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7D3A9DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 16:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhFPOml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 10:42:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233752AbhFPOmj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:42:39 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15GEX8dm038495;
        Wed, 16 Jun 2021 10:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yiLeMrSrLEesWWLZSuwNrEn49+LwO0E0VWIGiQuRAnY=;
 b=kXuCCZ71RETjmzlGqmrfAO/CSnWU0fOW04SVgjGnv21xYQzfV88ygbORWSmC+s8nbohV
 9cvxABbU0c7e3UsINUsMrGcf2xW18n+i/KVexY/dOCyf+enOoT/nljkO+r29okP0JpLY
 o2BjazajK4ImhDrkhvSORPtyHhIOi3Cmgy29pxdX5NYpdgQJzmMUjFwan+UXl4WI7amd
 NqK09Q4p1ArDXhwI7FMdI3oyBIDHzdi2tTPznUoPbXu7lPGWvT1AR4aKW8pJunf2iNxs
 xilF7Ny7xcWn0fotnFiNXsdf2ciJu/qFUjLpnoqGy4tFAOTvepDH65oam6J/HFB0E8Lr vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397hrxke7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:40:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15GEXaat040276;
        Wed, 16 Jun 2021 10:40:25 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 397hrxke6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 10:40:25 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15GEcFbw017445;
        Wed, 16 Jun 2021 14:40:24 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 3965ytxkmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Jun 2021 14:40:24 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15GEeN9U36176192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 14:40:23 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1711124052;
        Wed, 16 Jun 2021 14:40:23 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6A0124055;
        Wed, 16 Jun 2021 14:40:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 16 Jun 2021 14:40:23 +0000 (GMT)
Subject: Re: [PATCH] fs: Return raw xattr for security.* if there is size
 disagreement with LSMs
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com
Cc:     linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
References: <ee75bde9a17f418984186caa70abd33b@huawei.com>
 <20210616132227.999256-1-roberto.sassu@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <6e1c9807-d7e8-7c26-e0ee-975afa4b9515@linux.ibm.com>
Date:   Wed, 16 Jun 2021 10:40:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210616132227.999256-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F0eDltfbP4xgfxmxqWSxxuKCNviflELd
X-Proofpoint-GUID: D7nLuvTheuIzDQKq0leJ7Mh5mKELchNh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-16_07:2021-06-15,2021-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106160084
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/16/21 9:22 AM, Roberto Sassu wrote:
> vfs_getxattr() differs from vfs_setxattr() in the way it obtains the xattr
> value. The former gives precedence to the LSMs, and if the LSMs don't
> provide a value, obtains it from the filesystem handler. The latter does
> the opposite, first invokes the filesystem handler, and if the filesystem
> does not support xattrs, passes the xattr value to the LSMs.
>
> The problem is that not necessarily the user gets the same xattr value that
> he set. For example, if he sets security.selinux with a value not
> terminated with '\0', he gets a value terminated with '\0' because SELinux
> adds it during the translation from xattr to internal representation
> (vfs_setxattr()) and from internal representation to xattr
> (vfs_getxattr()).
>
> Normally, this does not have an impact unless the integrity of xattrs is
> verified with EVM. The kernel and the user see different values due to the
> different functions used to obtain them:
>
> kernel (EVM): uses vfs_getxattr_alloc() which obtains the xattr value from
>                the filesystem handler (raw value);
>
> user (ima-evm-utils): uses vfs_getxattr() which obtains the xattr value
>                        from the LSMs (normalized value).

Maybe there should be another implementation similar to 
vfs_getxattr_alloc() (or modify it) to behave like vfs_getxattr() but do 
the memory allocation part so that the kernel sees what user space see 
rather than modifying it with your patch so that user space now sees 
something different than what it has been for years (previous 
NUL-terminated SELinux xattr may not be NUL-terminated anymore)?

     Stefan




>
> Given that the difference between the raw value and the normalized value
> should be just the additional '\0' not the rest of the content, this patch
> modifies vfs_getxattr() to compare the size of the xattr value obtained
> from the LSMs to the size of the raw xattr value. If there is a mismatch
> and the filesystem handler does not return an error, vfs_getxattr() returns
> the raw value.
>
> This patch should have a minimal impact on existing systems, because if the
> SELinux label is written with the appropriate tools such as setfiles or
> restorecon, there will not be a mismatch (because the raw value also has
> '\0').
>
> In the case where the SELinux label is written directly with setfattr and
> without '\0', this patch helps to align EVM and ima-evm-utils in terms of
> result provided (due to the fact that they both verify the integrity of
> xattrs from raw values).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   fs/xattr.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 5c8c5175b385..412ec875aa07 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -420,12 +420,27 @@ vfs_getxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>   		const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
>   		int ret = xattr_getsecurity(mnt_userns, inode, suffix, value,
>   					    size);
> +		int ret_raw;
> +
>   		/*
>   		 * Only overwrite the return value if a security module
>   		 * is actually active.
>   		 */
>   		if (ret == -EOPNOTSUPP)
>   			goto nolsm;
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * Read raw xattr if the size from the filesystem handler
> +		 * differs from that returned by xattr_getsecurity() and is
> +		 * equal or greater than zero.
> +		 */
> +		ret_raw = __vfs_getxattr(dentry, inode, name, NULL, 0);
> +		if (ret_raw >= 0 && ret_raw != ret)
> +			goto nolsm;
> +
>   		return ret;
>   	}
>   nolsm:
