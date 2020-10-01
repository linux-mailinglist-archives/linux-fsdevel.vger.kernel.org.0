Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3CA280120
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbgJAOSA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 10:18:00 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com ([40.107.22.105]:11784
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732104AbgJAOSA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:18:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpAqdmPNs5ZBWVR/ESzWEPscm8zbPl1bTRWkKwgq2gb8uH9NX5zVV31UlFtv0hGk37WYBo3WIJYCiXHrLLw6jOzi9cQLvCSA4YXKYx5WnYHFWZG5qAh26e/MSrbDpl8T4BJKR5RIZ9NVS5atU3lO18g3bp5pV34XTADU+upmXrdc0OQCFxNiQmx34Z29U1n0cohXILv6Q1b6e5s2xGnl7HI1foSAqfi3T/4DtUKSiumOi/8x+kqB+4AVFzNnqYxPb9dEUmwrWIDJccnlvT/pCcpeY25EHW1GCI0w59/YbZGTIhL9i/aA95ixl0exiI/R5WDUq6a15EbJy7xLbxNBxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TaDZ/AAxl4Dvcps094bcdo0lW95pmkoBi0meLLx1ZI=;
 b=NQQ/TJjGoYhSEpIuKwvobIw7HwSLl0zASrxH+H+Xlt359HGRFom8mZ4LImU319M87xZ/wOJuE+8sUoqIjvHzbbdWrhFGdNCNBaAQnSaEfxJ3J4ArW2oI4JKFWIC8HL6S4N1vG+JadG15iHIYTNlgvvAL8HfiJS2/HjFex1bISd1o7qRbk3BUAG7jFVvALYjVLq7CSldb6+wrEFUsfMyxuqHZIzpbErPrnXMPLi5TyXJR1WVYmT2S6O3S5ekZMfrDctNet5dYs1fweM7AOFuCVjXb62VmaYvdC7vjD7z68s9EKd0CDrvtirGYqVNKSxnTqS99XSn6UPwGxqwy2zBozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TaDZ/AAxl4Dvcps094bcdo0lW95pmkoBi0meLLx1ZI=;
 b=JRGlyHyhYMlOG7lZbwUYxBsZ05HXEkQ5wUDpt56lUs5L3MWe6LiLix9P3RH43Q8LLYVU11XrC6zSOe9xkWKL+Zfajm2gw3JGRobFlZ3j3bcCW33upAYHVzfFKUZOpXVV0/8hSrIp6Xl5HR57GL4JcA5Kms6q0VQOBTzVxNGHVvw=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM6PR08MB4756.eurprd08.prod.outlook.com (2603:10a6:20b:cd::17)
 by AM6PR08MB3416.eurprd08.prod.outlook.com (2603:10a6:20b:50::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Thu, 1 Oct
 2020 14:17:55 +0000
Received: from AM6PR08MB4756.eurprd08.prod.outlook.com
 ([fe80::71e0:46d9:2c06:2322]) by AM6PR08MB4756.eurprd08.prod.outlook.com
 ([fe80::71e0:46d9:2c06:2322%7]) with mapi id 15.20.3433.037; Thu, 1 Oct 2020
 14:17:55 +0000
Subject: Re: [PATCH 0/4] fs: add mount_setattr()
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Vagin <avagin@virtuozzo.com>
References: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <8f815e88-d51d-9f70-89f1-a7f54b1200ce@virtuozzo.com>
Date:   Thu, 1 Oct 2020 17:17:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200714161415.3886463-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [46.39.230.109]
X-ClientProxiedBy: AM0PR01CA0163.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::32) To AM6PR08MB4756.eurprd08.prod.outlook.com
 (2603:10a6:20b:cd::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.192] (46.39.230.109) by AM0PR01CA0163.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 14:17:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec28eb8-ec6d-4717-4f60-08d86614ca5c
X-MS-TrafficTypeDiagnostic: AM6PR08MB3416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3416974C6CD6D171911D14E7B7300@AM6PR08MB3416.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+TAdO/8ylEr+3WAvlJKFksyaLTUUkWx9FruoNEjP4/4+ZJQYzU6C16HmDTZmWR7tAFXfqyQx+9y/68Ne/V2ya624FTkywF8OxW2bSguP7WaUbSjEaPAyl8ZTAmvhSm6pUGp1kGSKLB6w4+RB4gtBHsf5gRnFXyT25Cy5Pd0b/BmmzDJThR7eVIrvC2bEqo8mnA0pHn1/HCbnonPmW94ftpbxBSFbxZH5KDCR9JzQD4r4NEfhSm/VTa4qBPKaRhwduYzxG9AknPX2oWI9Fn8Ytitz4uuhe25C+RmMRmlB5OuNPh0kBT6EU1xZCgmMkTsvzBZXLhizwB+L3h0WaGw9Nnk1dNRRdURiI9slvH8VnxheqdML9rrXD05Clcv8gHYwsktRpUCfg2pLFdXeSc+d+gIRE5yPWJtie+fK6DsQUEtW9zz5aCJUVm0UIQ+HbdRzWwFIkBpniE1pDmU6beD0pi4Wr8jCQEos8g5Mea0gPsUlmvMraBqhZSD0SeyC15x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4756.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39830400003)(366004)(54906003)(966005)(31696002)(16576012)(52116002)(2906002)(31686004)(8936002)(4326008)(66946007)(110136005)(2616005)(478600001)(6486002)(316002)(66556008)(66476007)(8676002)(956004)(107886003)(36756003)(83380400001)(86362001)(5660300002)(26005)(186003)(16526019)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: MHeX/xIbnPj+L17IiVexXmPxASgnis0369mRmokJsxPF8VT8zsinpzNEDIKf1HeeShijzwxWEW2gd+n1igHSJ4Z0qTs7EQ9GCVoXSDms9vwgBoyYB9/4OqTn2O2xewV149LESbSBcoT2Yr7Si+j0w8O7+KBTJdxOdJllXoX3V3C5YdRGpXvwDzBXl0YFPKGzaKhpmZyY94jiTnvdzhaD+fEXq2qc4Nl/9UGEEAwfT1DyGsfqq7zASIPtUZU8M3H7lYJwmHzZQ74lingNx0OMC0DxRHIuPT3gKyt0cPZYijO6lZZYyTL0qAHbaG+YFvvQ/XbSMsCA51M0Lutbbm0A91G+mk2R8KGTkayROC8yzoO2MFNZon5ta8TuNcqi7ojdxnB4VIsfvv9Jy70HOPy9GsvTZZzpxLaskR9MfRb/Q/RwNB8C1Q8EFkaxQvXrwf5HxCDlPnibPAkZGzSEfeXEZzNSsLZxdpWMB4H6bQL6wCIbb8xHRIIrCE+20Gs5SltSrQWwU/KZU3HzwtbDmUEr9JcKyGIUH0c+EY95ZJz+0/dJykf45UMmNv1hcH1rDzGs9Jn4klSPwpGktTkj50b/+OIYBH7knIXuRXIqb3sytnwd+SDNTrpY8fkENRodam0qgf4/K7WvfOs2tdOAEe6lKQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec28eb8-ec6d-4717-4f60-08d86614ca5c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4756.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 14:17:55.5470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3Kl/ZwtS4hR2yEJnvXqiITR9Lx1Qyd2z+ZOmKTDUvXMhvS/CilDJxqqEvR3+bHb239jf0M4LpNKvXVt1vlxenJ8aM/Bvq/QAzWXydb0/90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3416
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> 
> mount_setattr() can be expected to grow over time and is designed with
> extensibility in mind. It follows the extensible syscall pattern we have
> used with other syscalls such as openat2(), clone3(),
> sched_{set,get}attr(), and others.
> The set of mount options is passed in the uapi struct mount_attr which
> currently has the following layout:
> 
> struct mount_attr {
> 	__u64 attr_set;
> 	__u64 attr_clr;
> 	__u32 propagation;
> 	__u32 atime;
> };
> 

We probably can rework "mnt: allow to add a mount into an existing 
group" (MS_SET_GROUP https://lkml.org/lkml/2017/1/23/712) to an 
extension mount_setattr. Do anyone have any objections?

We need it in CRIU because it is a big problem to restore complex mount 
trees with complex propagation flags (see my LPC talk for details 
https://linuxplumbersconf.org/event/7/contributions/640/) of 
system-containers.

If we allow set(copy) sharing options we can separate mount tree restore 
and propagation restore and everything becomes much simpler. (And we 
already have CRIU implementation based on it, which helps with variety 
of bugs with mounts we previously had. 
https://src.openvz.org/projects/OVZ/repos/criu/browse/criu/mount-v2.c#880)

I've also tried to consider another approach 
https://github.com/Snorch/linux/commit/84886f588527b062993ec3e9760c879163852518 
to disable actual propagation while restoring the mount tree. But with 
this approach it looks like it would be still hard to restore in CRIU 
because: With "MS_SET_GROUP" we don't care about roots. Imagine we have 
mount A (shared_id=1, root="/some/sub/path") and mount B (master_id=1, 
root="/some/other/sub/path", with MS_SET_GROUP we can copy sharing from 
mount A to B and make B MS_SLAVE to restore them. In case we want to do 
the same with only inheritance we would have to have some helper mount 
in this share C (shared_id=1, root="/") so that B can inherit this share...

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
