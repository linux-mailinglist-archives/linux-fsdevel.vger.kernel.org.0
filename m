Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E22201EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 03:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGOBlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 21:41:40 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:29194
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbgGOBlj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:41:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyiHP3VX4dWFoa2aLgIgQ8SjQj/ztrv3J2akbQt2nNtWiox8gEP5Lm+U6lCEVyEM9+UOG0xCyZsxz8+oV+SnmjN39oB6wEEtLPelCm2CKjiLhkQz6esQZp8hihVx6/qqlMjkX6U6bq04bKAzOJNuyJ4XxlNwZ1pJfa158SNF6UgYG/Ff8SA7PbuwwwvnuStL2gmws4HoDCd2R936hQ/A3z3d7P8mhW7Pdv3J+FEbQPAZvQAU0ygsH9xlElaAeWqCuUF6ZFLAAaZDqSX0DbcHb6P0FkSOdeEnOxMsjVbYFTZ61Kv2z0BVblOPrNW+/EWN9+pD/zlhpxkdAXzPzZ1lSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=023pgXTD/wpXeVHur5be1QEIQtgEVqTArpymGu42GL8=;
 b=bACEfnDvs1fNBkhXqmH+OC0aLA8S/EtMyIl/S3aEKddfhweIH30lV6KQfSRCMdBROiIJDEPbA0tQADrEjo+c4zXdoYJiQTasc5MGceA7yrGw8V8Z8AgdZUDYLfbY3g+pVBu3i8ANvSQ8pQKH0zZRGFJl02m5eelqkbSo/Me+7+p2uSR33KFzqc8vR9ZCTtDDyGqUkgC8vrUP0fcDdjKI8aHS/c6SvfwnumTpa6pb9ivlPZG7h7sMEMgZ7ygIWlAHfBs+zhZZ4SYqP+nnPehU7yJ3YsdHL01akMg6bva8/LbHt+19oTAWcGrY1XYycu/WLTjBbqBwDuHzLjEOFa61mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=023pgXTD/wpXeVHur5be1QEIQtgEVqTArpymGu42GL8=;
 b=NsD3ShKrUCUa30zgsSCaZVDglo3fCuEYQEOl4cujrTB+BOhrQyC2paSgBU4LRuzFye1d1P8AkBwZPsHZ5Wov2/W3Fap9ClBfiVDAoYN5wCaEc+J+gnkqAgAH8LFzfw9YahvQ7yWZkAGAihnISawKoI7Gv9QoatW6767/jElaybo=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4354.namprd11.prod.outlook.com (2603:10b6:a03:1cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Wed, 15 Jul
 2020 01:41:35 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::6892:dd68:8b6b:c702]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::6892:dd68:8b6b:c702%4]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 01:41:35 +0000
Subject: Re: [PATCH] userfaultfd: avoid the duplicated release for
 userfaultfd_ctx
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200714161203.31879-1-yanfei.xu@windriver.com>
Message-ID: <1a463530-107d-0893-cecf-87ba42ebdbf6@windriver.com>
Date:   Wed, 15 Jul 2020 09:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200714161203.31879-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK0PR01CA0061.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::25) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR01CA0061.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Wed, 15 Jul 2020 01:41:34 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 510f572b-e05d-429e-1264-08d8286035a3
X-MS-TrafficTypeDiagnostic: BY5PR11MB4354:
X-Microsoft-Antispam-PRVS: <BY5PR11MB43540644F7FF9FCC73AED03EE47E0@BY5PR11MB4354.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dtaNFx4No/wrumYvmGuGycGz8urjr4aUnW43NUZF5uc3kolJg/0F5L/CFW7oy+G6vp0YiVG0DevaVEy4ZpJ1XFfQW8pAKqSmNSe2QbkuY41F2WaIKCq5jsGtcfYu3IQpA5i4AX/9oSgwVcLjyOzQx/cVRcBkpesiWFzQWEYFGd4l3VoY3bS9qtTNVeA2+Nw62lXq9F6RgJhEcAuaPfEX1YyufBD2x0S5kWX1M0lHNwufK8+OiXytuNqsCuUPUA4m8QZOs6P62Z3QQTdcg/qUzlpbAhjc4szdwiSAg8nhhlpHg8HYRUeWscWuCWaFD5exd2zXmHDVrW0L71remr4rthmGsKGy+WYzSJyIGqy8hlLURnISTHkBezvELpaQBHU9RJOtRQJqpxNE3ceFDCNDQwOQw+yFzpsrm7+n5HxVq2TiiWg2KDmcFcU4Y32gmeM7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39850400004)(396003)(136003)(346002)(478600001)(2616005)(186003)(4744005)(26005)(66946007)(8676002)(16526019)(31696002)(86362001)(6916009)(66476007)(66556008)(5660300002)(6666004)(6706004)(956004)(16576012)(8936002)(52116002)(83380400001)(31686004)(2906002)(6486002)(316002)(36756003)(53546011)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: e8id6lOHyuIevEHX17jr3C4OqsorjEUUc60wy9rveZGAup3V1MYUC1K+kCUwjzmEB+8TcplRQ51eZh1NVcR7MepoOsG2qOdj8zIDd1hRS2L7xkIwqap5LFS6ktMkDo3z/eifwbTntc7hboje8yBUaRsRqrvo02w8N2y0jcalfbLJ2mWqwnQl8xO6p2qCUqEiiHOv9I2BuAVJcGp7LjD/NQyxJbCO9mGhKkNxi2U6sY/VMCWIP5Xbro/0iKiiH8Ei4RFvVQUbhD/TbpgfqxiGm1rOudnm7fQqWNd63Z01WP7HWhdMEUnkKlNsIVjENO2KZu7UsTS177ZpMncx9nGgkI8Mqh5rw2jaTQHN1wUZQjw+orYFByIa4mRUwEkn6R3Anl61zdznfU5iV1VVMaSYaXzGYmwRwrqmfkOPDlHdgSz71g83qW6vwpDDCbZaYHBmIk1c307bqGF5gxvniG33w2uhKgybaSHphrHp3QgSKuY=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 510f572b-e05d-429e-1264-08d8286035a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2020 01:41:35.6665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R98yxmSfP0IqATewOJr92InTDYOmxO1MMk6wDaXlv+9o0pTfQvRrxTtPY4V0RvH4g61IW969w3Jb1qEmIpNKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4354
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add maintainer Alexander Viro  :)

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
