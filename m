Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD87225210
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 15:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgGSN66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 09:58:58 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:45128
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgGSN65 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 09:58:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu9g+koS9AulitpDFni71kAmRfNx8inWLner5zaBv72r8tle84jh7GcC9w9ugcwUzoLIDo/Q0r4Cb8Va90/6VhIkMRiDCnTpsV3/NeS0QfRT1fdb7A8eOwwWoKHnJ8txK/GW7hcSIWvG3ZHbm7erZ2YtvOxurU8Y1KOJT1e/sn5TKuVHYQS+OuwgokF9k8By2OV6rnKZN3OlwZm4OfdLh4w23yGSlVDOyVLeYM1Cz5Y3nFDkEjYiAaujNUPU/k+svPrV0po+WBB6vSImanthxPUAIPbbumQkrCaO7Dpv0IEMdz9rxpl6HRPC9xdZZ8mdCU906lGwpWDpum2pqBNOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLDZWVuBZIH/QKd0zVXc6J1JIuPV3uAfkRk4ld4Zi84=;
 b=a1YEwiQkSVBUXmYQk6xUKABqLcmwWIPx8BHwq6cnRsVaZkLUQWG6xwaaJHc8Aj6kP969AVyQ5yhxJneK6INFAVMQykRbag3XzUsQK3+JAQ49cdeATC5zt3udguZbnOJdkZ9E1Jz76+aoV/g6jH+heoGDBoJgWtnixZ0dZIIeDJtxd3rN9aYEZLuxy+I7vvavL6CUFqs9ZRzYSHWFTyoP1Fx16Vz/lvssLKUw5bpZWTY6lY8YdT2mPn9CWnzD5DbQLXC5ergGhZhaz6zOjPfZJX+lD+U0NJIxyu8ZEWl6hwCHd9rcNb65ucutiO+gZL9kWGXaFC4AJFGQ19ZSWq68jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLDZWVuBZIH/QKd0zVXc6J1JIuPV3uAfkRk4ld4Zi84=;
 b=OGddoAhuLdjnfnQiTHbPkXj4JJpJds8RmQY8Rorz89K3pM7GDY2HzVBJU/lgCDqT8Km7UV33vRfFJHv0ygrFP6U/n1GM02ul4LY9ypOij7DcjayY4uhqDOYDEciRNl3EQ0k53U3UShVFNoPEh3LOuao1ZxtTbDdlueEgjfMGgSw=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3029.namprd11.prod.outlook.com (2603:10b6:a03:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Sun, 19 Jul
 2020 13:58:52 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::6892:dd68:8b6b:c702]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::6892:dd68:8b6b:c702%4]) with mapi id 15.20.3195.025; Sun, 19 Jul 2020
 13:58:52 +0000
Subject: Re: [PATCH] userfaultfd: avoid the duplicated release for
 userfaultfd_ctx
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200714161203.31879-1-yanfei.xu@windriver.com>
Message-ID: <e3cbdb26-9bfb-55e7-c9a7-deb7f8831754@windriver.com>
Date:   Sun, 19 Jul 2020 21:58:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200714161203.31879-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HKAPR04CA0009.apcprd04.prod.outlook.com (2603:1096:203:d0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sun, 19 Jul 2020 13:58:51 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71e07e3a-d304-4a13-f8e8-08d82bebde50
X-MS-TrafficTypeDiagnostic: BYAPR11MB3029:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3029D519F03CD58FA0D6C7BAE47A0@BYAPR11MB3029.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVf+fsFkLAcer+M1ovaBqwit0W1zsXhsHpWbyiF4GnWkGv2Em7NIPTbTzNFDi7G1c+xktPI+lr0GNHi+G1Euf2Luyc3Rcdd0DCek4mrSKEhqoRYRycGJog8CJn/c0PuUGQVPCuEu5rBX4bJzAaN3JThUsLb2gP1MPsl50OcV56L7Xkj9MQc52FL+5emwhtxLTSyiLAVMsg7BejQfYzCElIQjgdSFPPc1OGLAfGIMa6/Hv4rBQLuPVACxYPnXAwA1xc2s21aNvNHDhVZlbtrJDG4mYyez2P/jCIqp+xaz4wZuF1wZcXlN6tHGIzzWIHCg6ghhJfp70pwviw1lhlevfi/dIanfEu4QO4R2mPQrRuxqUIbR1v4bKOkUOqk7z+wkRVDCVdM3KQzwXN5CRy02uKeCdT5EBKaZupJ6zVhYfCyyWGK+RPzXp8pimpeYRXz0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(376002)(346002)(136003)(366004)(396003)(6706004)(31686004)(316002)(16576012)(53546011)(26005)(8676002)(8936002)(52116002)(36756003)(6486002)(478600001)(2906002)(6916009)(5660300002)(6666004)(31696002)(66476007)(66556008)(66946007)(86362001)(956004)(2616005)(16526019)(186003)(83380400001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yAgN9Jcf//OhpBzrK/ZHuwTKaI1SFGNEHHtB4xfZBvDQUoIPFrPBHXajyl7cxr9hVsklg64NEhVwJ7Jh96c+QcmoZU4tzwLMXpb1wgaJMq4KhEFM5/fORW7il6eVqzbKezkxxFpMPkxcwRJguBniQnbkqw/Urmzo6paE+oLvUJAAko7XRgvdq6OwZquBlhehPBB6cDMMcvXDexOEeavuvouFukcUwp2ipOq/uYZn0fwQpsiv/WVGOqDYUQ/MDLuxlyvuHEc9QmkmalKXXdw1kch6oN8RyZNRu0p8DGbN8vlHir6IOkvMEBcJezAo/Jxl/2hpCzG/9H8XqwGi1ZlP+jbZnJ2RgXq4LegmCtaBoV1V5IXhMn0oZ7NXDAse7Y47nnwNXR08eRVrk4RhfGecxIT/kX06QvbI4DJi9ywxRw7z/UM4+imXiW/eN5QCqZfihW8CxE8v1DNO8di5zo9OUSrmutLAZwXD43IUODISa7s=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e07e3a-d304-4a13-f8e8-08d82bebde50
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2020 13:58:52.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfRbn3oHJQ/AKbXfVOrr2wQ7OIk1dFoyVR2YJgYjRXNsXNZQrNN5pDif8lmq1jGmaEK4IVP9gUw9QkQu66bacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3029
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping Al Viro

Could you please help to review this patch? Thanks a lot.

Yanfei

On 7/15/20 12:12 AM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> when get_unused_fd_flags gets failure, userfaultfd_ctx_cachep will
> be freed by userfaultfd_fops's release function which is the
> userfaultfd_release. So we could return directly after fput().
> 
> userfaultfd_release()->userfaultfd_ctx_put(ctx)
> 
> Fixes: d08ac70b1e0d (Wire UFFD up to SELinux)
> Reported-by: syzbot+75867c44841cb6373570@syzkaller.appspotmail.com
> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
> ---
>   fs/userfaultfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 3a4d6ac5a81a..e98317c15530 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2049,7 +2049,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
>   	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
>   	if (fd < 0) {
>   		fput(file);
> -		goto out;
> +		return fd;
>   	}
>   
>   	ctx->owner = file_inode(file);
> 
