Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33E041A939
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 09:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbhI1HDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 03:03:01 -0400
Received: from mail-eopbgr1300087.outbound.protection.outlook.com ([40.107.130.87]:13888
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239024AbhI1HDA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:03:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2XAs9quCvm+zyMh/d96FEfcmqe3H/Uz/05Evp0DE0vMQ2UTy8ljgfxkrxsY6oVooDUvgqtv8PjukZdnQmrQPQEcon/zvt7TeIYtZ1OeTOLIno57+uQ7B3oNdx+ysI2AfS5R93Ejym2fXDqdxwI0USTH1x9cSg926tZleHnU8AviAtS1vUM6Dkzu1bh1m8hejFVcKYl6rmdg4mT16Yh9cpdxglnhgk6sZHrNCBcbKD+tVHGpARE5Pa3/lIauJeAcR1td3ccnFN7vqv1p9FlYvrq3b1xIURuLIEfsYrP7WrLjg1ah+zF1RaDd1lCSPMwhem4RoX7wH9hcmIbQ5E2pGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fo9+W/P9KqMkN/aJ4PypOXEU2UPTkl/HU1srbMD1ZeY=;
 b=mfFqP5kVRp6aI788KygjWYOthUCP5JbPgTx/J7NzaXKRxz5Jd81c/uavedOYWK4if8dlpcK9Y+mmmPFziF1VhUoOO0yGaL6jIN5+vfW0UiLBwbC1loiL93lVFPvYRVLytzQjtMykTPMEpfTGlhpPTXwcxUFah9UmVeNslnpN9W3Es8DffoPVAnEHuND6caStpqysqG0ATNnG/lqQ1fcVDTFEdhwd8WTJm4q2MTWkyA9PRb/N+SBMYZsO4Snidioaetx0iQ6EOj3C8XhGw+9jrNuETr/ye2wjZ++BzfeM0edHsQwkNSZHguMGB0ujU8lEMLvsGvn7BXtzXhfedPO1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo9+W/P9KqMkN/aJ4PypOXEU2UPTkl/HU1srbMD1ZeY=;
 b=pOh3OhSsBtIlBW7MgUkK3mbrkJ4FPygCyXNUe5fnxiPifyoFhS0SkBRbvKI2IgA9amn9zKey1xooSrIiX7VtrGV0G79+qxBINQRb69fsoGaBF0XBkP1pyiw7MjzDA8gGMmvAPX8lVTcmorjR7t7MPvJdJwji4kAsRRDACjvERcY=
Authentication-Results: mykernel.net; dkim=none (message not signed)
 header.d=none;mykernel.net; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4330.apcprd02.prod.outlook.com (2603:1096:0:3::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Tue, 28 Sep 2021 07:01:18 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::5919:768f:2950:9504%4]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 07:01:18 +0000
Subject: Re: [PATCH v3] ovl: fix null pointer when
 filesystemdoesn'tsupportdirect IO
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chengguang Xu <cgxu519@139.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com>
 <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
 <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com>
 <314324e7-02d7-dc43-b270-fb8117953549@139.com>
 <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
 <YVGRMoRTH4oJpxWZ@miu.piliscsaba.redhat.com>
From:   Huang Jianan <huangjianan@oppo.com>
Message-ID: <97977a2c-28d5-1324-fb1e-3e23ab4b1340@oppo.com>
Date:   Tue, 28 Sep 2021 15:01:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YVGRMoRTH4oJpxWZ@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:203:d0::28) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.252.5.73) by HKAPR04CA0018.apcprd04.prod.outlook.com (2603:1096:203:d0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.22 via Frontend Transport; Tue, 28 Sep 2021 07:01:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6b56343-4aac-4e08-b53b-08d9824dc4ea
X-MS-TrafficTypeDiagnostic: SG2PR02MB4330:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4330C4F10E985AE12D53CB80C3A89@SG2PR02MB4330.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu/BYRh2wQ5ZH6+8Z/fqdI+FUuMxmQ+BQwymfkamC+xT86ru8FVj9e0lWZmKqvqOrx3U+YLSwojX3VkJmCx7r5DxFXnWt/KHf4aDeihhQOmWEtMeM1J5ZcOna/r5eBFViGJVOKKO1HakBROZ1N20EQVcdsSUutvfc53jUYsTl3kyN0DMgm2GxcNINaTLme5FNxM3xq6EmYPQ5arnJqTDpiCWVuXley6OzGHsoM0vyVy+xfyfsWbO8UOw9Kd9WsXZ/yquNl27GZ0NUCHiH3LmahCXstom0hnYBgGv9uCSTjtY775EmNj3gRU30ixQROug4G6aG1ADkqF3hjyX9q2Uw95x7S744sT48RZ9vp8Ok8bn7vHUrPz+LokcG79cpZPeW1sgewfn+1tVA4r3tdRKtu/392UTAF8OBzd8MwHeRUIfEL6+sCzgZAN4gqPEqr6A1O8YP4nQ7+JuamJIP92V6lZ0gAh3h+v77QXcvgh88TMFxuaeJ7brZbe+kydUV2PdpNNBiRvUyhpz7LYbAifpaJ8pU4/kZ3EOEwGx4HI7h1xWxnQstoY8bDCFECFHOIv/87Lzd9nTZLKkbGbVLlXIuI3zdGNGQILSVKMvVVN91Qnz75i8vRpyW+mnG+1iJBnkvYKoznDMD0xlLuYRnffl7h6sCUEj4UODslsfGiwElVT7BZj5bI5fFtafr6l5t5lqdJ134TbVauNAovAuUDTDy8aQ6bLVAZeyaOxg5ixJkcvBodFEb0t/uaLOkYCuguTOAmmp+EPpN92U52X0hRZAY8VARNVkRPubM08EDp6coUvrVAt6kHW1RlgttjN7yNBx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(7416002)(66556008)(38100700002)(86362001)(66476007)(4326008)(83380400001)(186003)(52116002)(31686004)(6916009)(38350700002)(66946007)(5660300002)(31696002)(316002)(2616005)(6486002)(8676002)(26005)(956004)(2906002)(8936002)(508600001)(16576012)(36756003)(151773002)(11606007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?gb2312?B?UkhHNFNFVTBsVUtac25ROTl2VXV1bGp1MUR0aXhPaHVtZnRSbSt0Y0xCcGcz?=
 =?gb2312?B?WUFreUVTYWdBKzcwYzVEWG9ubE43ZnAxcDNWN0JSbmxBVVNXTkhwQlFZRGNu?=
 =?gb2312?B?Z082eWtLREgrRFdFSkVId3BLT1JtVTZGTWNEL3UwVzdUMW1NQlk4ckZHS2RW?=
 =?gb2312?B?RlBZaG8rQVM1dDZYU2dGZndRNDVwcG92SHdDYncrWm1ZYThwR2hBNmNhR1VX?=
 =?gb2312?B?YXM1V1pOdXMxWlNhejlOdmltNE1Fak1id1Evayt6Q05FNzRWc0lMNFNwQ2xt?=
 =?gb2312?B?VGRQa1FXOHZ5blJjeHcrelVuUDZxZHBHTUJHUE9pM2ROZnlVNmw4RE1peU13?=
 =?gb2312?B?K05mTC9aQS96WFlwQVNNWnQ5ZXdNdit3bG9CMmdZNWU5QUVKeHl6cHhtSG92?=
 =?gb2312?B?Z2IrZnI5SllCNElzY3A0ZmVaNzhRMUF4MEdpTThpYUVkd2N5THpTZlRBQk14?=
 =?gb2312?B?MUlOYTdScWNoM2Rkc1huYWswRW1SWjZTTnNNMkN4K29GcVNadUYvbjFObWlQ?=
 =?gb2312?B?cUd4cVE4MnRQeDU0Y3ZsTC9yM3NZWmNSNnlMVmVTWUgrRmF3MXU4TWtCOWdX?=
 =?gb2312?B?OHRvTU5CNExtNW9senhuRlVvZTdSWUk3REhuN0g3UGd1a2s3Q0NUUGVXTGNW?=
 =?gb2312?B?MUZpdFZKc3BFYm5qR0VlbmNwZnhLdGZ1WGo2ZWZFWDZQLzZtVHZQYXFxcTBV?=
 =?gb2312?B?cHVsOE1hd2NwYitzNW8yanF3TUlVRVJKQSt6UWx4eTQyd2s3aXRtNWx5M1hJ?=
 =?gb2312?B?ZnJJWUlobWlDRlRyNjlYS1hMYVFXR3R4MVBGQW9xZnZGTWgrUEdGWjR1WTE4?=
 =?gb2312?B?TUdILzJ3RUZyazVQelVZRkQwM2Y2U0pPWVhpcWh4MGZBZmF4YS9kc2JWY0FJ?=
 =?gb2312?B?REg0UytKbnF3ZCtPZmxHR2JDS3ZNbmE3WXpSRkhzcy9HYm5Pb2xDMnpUMEdL?=
 =?gb2312?B?NGhnTXZLeWlTZ3RIQmNydDV3WmlMQnB6NGVZbEpSQW9UY25qUGdsQXdrMjlT?=
 =?gb2312?B?dUU3R2VBV2JURGF5T2ozdDB2WW9FUTh2K3Z5MUwwS2RST2RSSTg2QVE5Wkdy?=
 =?gb2312?B?ZWxKK1Rkcmt6SkJTTkVYenhLejgzQzg4WFNJS2Z4UzN6M0tVRCtYSmowZ21w?=
 =?gb2312?B?WWwxOXhNOUJHenVoSHI1Y0wvcVJDbkVxakRrUTVnZjdiMlRJb1JaaXpyWkFl?=
 =?gb2312?B?amVTWXc2c0NOdjFjWTdiZ2ZnWXZrT1ZjeEJYTnNWK0RGcmZuTTdTQ3ZpZ2hy?=
 =?gb2312?B?dThSSTNWc3M3dDcwMUswVGEzZlcwQ2dYdFFzVkRSUzczNmw3d3k2SU1jdlBL?=
 =?gb2312?B?NE13R29CQ2pMTWdLY05YK2Zwb2RUY2dpMXJVODRsYkZ0SUpRU2h6eE1aTVg2?=
 =?gb2312?B?RFFIMzRMdnRMaFRwclF4dkpuWHRoYjllUkVRRGtkOG5mRjZSMlpiUkwyS3ht?=
 =?gb2312?B?N1ExSyt4VWJLTklZcXBKYzFGOEJRS1Z3ZXNoRWsvMWhoWG5qa3NYRDJ5U3hU?=
 =?gb2312?B?dlYxWFFQUTdLR1ozUTlqdGpqQ05zaUpzaGRhTlQ0VTVNYkJlK3JoUkVDV3A2?=
 =?gb2312?B?bC9SM0NKYjlCMkxNV1Qzb3FoWE9jeXZ6blA3ZldIN2ZqT0tQRjEvYVNqMUR2?=
 =?gb2312?B?MjVSV0JiUUJUSFJEK2d4ZGRHakk5WUIyZHdnNkNxbWxYY3RCQWFtb3BjdVFu?=
 =?gb2312?B?dlhocXR5Z0Q5dGhwRnJ6MTdSZkkxYXdxUyt1NWsyV29oeVl0MXp1eGZvQ0hn?=
 =?gb2312?Q?hAmPDy3qPy38cBBSbL/+91l44o+DKktpvnc9q3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b56343-4aac-4e08-b53b-08d9824dc4ea
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 07:01:18.0043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTUILxZx99vgm6po2IFPn/JHGCq7VWk1g89ut/sS4hj7hskWKP+A9kb3azjNRbaSxwjHAlIW6EOo9LGgQJY/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4330
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2021/9/27 17:38, Miklos Szeredi Ð´µÀ:
> On Wed, Sep 22, 2021 at 04:00:47PM +0200, Miklos Szeredi wrote:
>
>> First let's fix the oops: ovl_read_iter()/ovl_write_iter() must check
>> real file's ->direct_IO if IOCB_DIRECT is set in iocb->ki_flags and
>> return -EINVAL if not.
> And here's that fix.  Please test.

This patch can fix the oops.

Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks,
Jianan

> Thanks,
> Miklos
>
> ---
> From: Miklos Szeredi <mszeredi@redhat.com>
> Subject: ovl: fix IOCB_DIRECT if underlying fs doesn't support direct IO
>
> Normally the check at open time suffices, but e.g loop device does set
> IOCB_DIRECT after doing its own checks (which are not sufficent for
> overlayfs).
>
> Make sure we don't call the underlying filesystem read/write method with
> the IOCB_DIRECT if it's not supported.
>
> Reported-by: Huang Jianan <huangjianan@oppo.com>
> Fixes: 16914e6fc7e1 ("ovl: add ovl_read_iter()")
> Cc: <stable@vger.kernel.org> # v4.19
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/overlayfs/file.c |   15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -296,6 +296,12 @@ static ssize_t ovl_read_iter(struct kioc
>   	if (ret)
>   		return ret;
>   
> +	ret = -EINVAL;
> +	if (iocb->ki_flags & IOCB_DIRECT &&
> +	    (!real.file->f_mapping->a_ops ||
> +	     !real.file->f_mapping->a_ops->direct_IO))
> +		goto out_fdput;
> +
>   	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>   	if (is_sync_kiocb(iocb)) {
>   		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
> @@ -320,7 +326,7 @@ static ssize_t ovl_read_iter(struct kioc
>   out:
>   	revert_creds(old_cred);
>   	ovl_file_accessed(file);
> -
> +out_fdput:
>   	fdput(real);
>   
>   	return ret;
> @@ -349,6 +355,12 @@ static ssize_t ovl_write_iter(struct kio
>   	if (ret)
>   		goto out_unlock;
>   
> +	ret = -EINVAL;
> +	if (iocb->ki_flags & IOCB_DIRECT &&
> +	    (!real.file->f_mapping->a_ops ||
> +	     !real.file->f_mapping->a_ops->direct_IO))
> +		goto out_fdput;
> +
>   	if (!ovl_should_sync(OVL_FS(inode->i_sb)))
>   		ifl &= ~(IOCB_DSYNC | IOCB_SYNC);
>   
> @@ -384,6 +396,7 @@ static ssize_t ovl_write_iter(struct kio
>   	}
>   out:
>   	revert_creds(old_cred);
> +out_fdput:
>   	fdput(real);
>   
>   out_unlock:

