Return-Path: <linux-fsdevel+bounces-28837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BE096F08D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 11:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E18B20BAA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 09:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9978F1C8716;
	Fri,  6 Sep 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="DU8SwFtu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2054.outbound.protection.outlook.com [40.107.255.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C51C8FC2;
	Fri,  6 Sep 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616566; cv=fail; b=GsK+hxxJZfmTn8zqoPdL3FYvPmGAc+YJ6scmUT0UXhH7DCCcd+xkXidw/7i5Vq5P/vzDzSTtylcRepJG1Fymx54Lgb7JxKnAIlgLGe021SuAfLLMj+WSBTc4/ZyCzZqb6kBomnYFLHYCJz7f25i1H6tqiodVruSGEu8L/uIGwVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616566; c=relaxed/simple;
	bh=9KH1qbvC7k4A7YzH0NnTopSknJOWjoGLYEqP/4Sp0Q4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBEAxLErk3QUWTkTUi+eJWD3UqLoOzWBN7Lgr/1MBX48/ehrHLtRQGDSV3DDxCBnERMKeUhC9NvcihaNNQckZ1pMXiiq7wJ1AIzKAz7b0TrWh2h364kCJ5b7aI87iVHMugco7GV4PvBGLK/lZv8cay0WNtaAUGEXHfvmIVxSKAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=DU8SwFtu; arc=fail smtp.client-ip=40.107.255.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRoyiSWz6IYW3NEyBk3Sqvw90mELeBWTBRnI03MSTN8zA1Hb00cB205781AEUTNBg5gSLJXRtJ082VUL2AJ3OySEOZfJTopts7w+q3Ec9S/fy5M72zmZKYnIqgv4Lh8O9b2nNuKPeVve+SWnyOnHXnXyuhZu6o3fWF3G+WZDyDuCA2VfCMr2BFqtzfLcd6AXw8bLBeePOGPmE2L0HIRws/lxfWitSrzafoV895fPpdMnSi2XvRfw7DvAUUIhVY8iZIDn1kmaTP3LDsry4C+JXQypNWF23eCChhJ+uNtX7jC7v6PNN7ZB/EAjXcSpxcTP0QCNyiy4ZNqWYvUFia2oVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucdrSQJuMEoUO0T/kIc5lLysIXdKQjvuhEdOEc4541U=;
 b=qHnnz/poQM556ndiC1kx+Pc4qOUIr5ebWVFNyhR2GY38/aaObhkqB1D/nNXEJkxoAQLutGLocLfwIL296IsJ9TbnbM6B8gMlw0WQlH/lYtLPZ7I1SRRxM4GSkHJD0X2rR9hymuWRX09XEZdPYeCN0HaYR5evQf3ihfQUg8V7HrD98ARvz7b2z82WvZfarUCurlUwcEGyyuIRJQft55+WWG8P5VstLJ7R8tiQsIyHRwN8Zba7tN83ZwMv6hm1zDIMeQI3ArQV9cev88xpUzH6T7JFN37cIE7B0Rg/X446i9o4waCLFsuJRhTFK2Y9yRxL72OgvF5X6rtAPJ3UvopE9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=gmail.com smtp.mailfrom=oppo.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=oppo.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucdrSQJuMEoUO0T/kIc5lLysIXdKQjvuhEdOEc4541U=;
 b=DU8SwFtufVStvWKfCLpNCHZikZatpjlbvjmBxxt3iMT1II45vSDG61yca4lcwomVSPjWNK4MXuOHmfv+lSGOsolpbeNKAfAodP83sYkFp2imS+Yc95OX+loqLtmDd7hq+aYNPqq/Xew2icaRAEwaK9crAhg/hQqdfyumiosq5PU=
Received: from SI2PR02CA0010.apcprd02.prod.outlook.com (2603:1096:4:194::15)
 by OSQPR02MB7882.apcprd02.prod.outlook.com (2603:1096:604:27d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Fri, 6 Sep
 2024 09:55:58 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:4:194:cafe::26) by SI2PR02CA0010.outlook.office365.com
 (2603:1096:4:194::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 09:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 09:55:56 +0000
Received: from oppo.com (172.16.40.118) by mailappw31.adc.com (172.16.56.198)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 17:55:55 +0800
Date: Fri, 6 Sep 2024 17:55:54 +0800
From: Hailong Liu <hailong.liu@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: Re: [PATCH] seq_file: replace kzalloc() with kvzalloc()
Message-ID: <20240906095554.dkanjjn2yj6z3g3j@oppo.com>
References: <20240906080047.21409-1-hailong.liu@oppo.com>
 <CAGsJ_4yAp=VF4c12soA0U5dzX-ksb3FV4UnC5e7Jtp+D6BO4iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4yAp=VF4c12soA0U5dzX-ksb3FV4UnC5e7Jtp+D6BO4iw@mail.gmail.com>
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|OSQPR02MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 625b90a5-b33b-453b-b224-08dcce5a1a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1l6SHd5NDNHZXkyTHllUCt6TDhhbTNvamFCWVpBb0VBOTd3YjZYRXZtRCtU?=
 =?utf-8?B?Y1o4T3VNUFA3aUg4eG1aYjdNbjEwWjhFcU1PdkxPR09HVU15MzZoQ0pTVDdX?=
 =?utf-8?B?VEg5UnBWdm9qeE1CQSszRUU0RFoyVnhNQko0K1hxVHdOYkxVVmI5T05EZnFF?=
 =?utf-8?B?N0RhZnI4UDFQTytoVStVUzBwU0NWSVJFMmdtblhoaWJhU0FVbGNYOWFRSXFT?=
 =?utf-8?B?bFNEd2pVUTVDMVF0cWdmcXp0aFBMYlllYTdITGpUaklWOEI0TkJqQmsvS3o4?=
 =?utf-8?B?RDFQUC93aTNEMm5JREw4STZkLzBWbFJrM2lOdUhUaVlNNlFrWVl1WlJaY3Qv?=
 =?utf-8?B?UVVYVys3dGtMaS9HdEhYQnFacmVqSXl6bHQ1bEYxMlIwcXhldklVL05JaVlq?=
 =?utf-8?B?ZURyQnFvZDRWYmFXRWhoM2RMWUtXb3ZxKzRKTmhDK0dBUlIyTUI4cFE4cGhk?=
 =?utf-8?B?WDEyaFpxbU50OGE1S0U3aE5jMXFaZzBKbkhXenhDakxpYUZBWjJwT0l3Rlc1?=
 =?utf-8?B?T1czUWxSQWY4WFEwT1ZtT01JemI2cnk2Vk5LbW9FelIrY2FOOUdjOGpsejRZ?=
 =?utf-8?B?VmU4Sk0wVGJ2K2pFK25ZcU0xdE9oajc4MExXMjVDa3VyMVJkT3JzQTgxYVNV?=
 =?utf-8?B?NkZyNXRaUkJkYnJIVzkzYTlGVEpqVTNXZFpOQlNha0JKcHQ1NUJaSTdTTWlT?=
 =?utf-8?B?UVhPZUJ1ckFxU1l0eCtpUHdrUUhjN3JaTDAyY0NXZndGdjVQMzZ2eXZzWDBY?=
 =?utf-8?B?eVRwbjd5Y0pWc1ZVRjdwZlZqMFl2SThPdWxacjUxYlJWZWNnMDNjVkZMZFkz?=
 =?utf-8?B?WXk0NEpYaXdtSDZvSWhtM0VYQnByaDlMb3laVjRWbW9NYXFseE0zRXpUSHRQ?=
 =?utf-8?B?M1E3ekhSVkZFMGZ1Q2pDUlRobHpaclRwMXAzc05uUGhNeW00THFCb1Awc1cx?=
 =?utf-8?B?ZlJMN0lNMDAzajA2S2w1Q3ZXMTZGVE9wK0xnNFc0enV6dnNYMHhEbTJ2aVNp?=
 =?utf-8?B?KzdWRXF0b2RlQmRQZHZUNU9xMTBqL3psTXVObzY2bGc1K2RiQnlOMFZxU002?=
 =?utf-8?B?SXlQRGt1VjhCYW14ZSswNE5BNXhoVGdpaGJwNDB2b0padWdUdkVaaUhpOVpX?=
 =?utf-8?B?VXRlS2JlSm5nOFNSVTZTTnZ0U1ZZeFN0bkFVTkNLQW1vcE1EanJVUEdNRVdw?=
 =?utf-8?B?dnNIMHR3cjdYKzBPeG45QjlFWHRMZUFuSGFmbkRaQWxRTlN4emlSRXd4cFA5?=
 =?utf-8?B?UnRzMFR2emE3ZmQzWHRYbnlodGdCc1hVbmtpTVlTcmpJbGtFY01wako1WjZE?=
 =?utf-8?B?Qm1nMFBWbEFLOU5TSS9mWTVCOFZNYWlTaVEvVVo3dllPSE5xQ1pVVkRpdWJW?=
 =?utf-8?B?bWpEZlBUU0lwcVB1dTFNdlhTMTl6aHgrQkx0R1J6VmpRbEpkUlFucUc0MjJw?=
 =?utf-8?B?Y2k1STJBaG5GU25TZmxCMTNmRVNOdWVSS1J4dXoyYmUrN2t5cWJOenQvR05a?=
 =?utf-8?B?RWVSZGFFS0NiTEFRT1RSOFh1cWlRWEhEOGxNSGJYVExOT29yZi9vNStEaDdj?=
 =?utf-8?B?TmpHSXhZd1NHVmJNdDN2Rm1ucHZwaEdpdmJzSG8zWkRyMENSeDdXSURNQ2Q5?=
 =?utf-8?B?RGRreTRWYzVrS1I5ejgxVFF1TkVBcUhNb0VZeUxCaFViSEZQSEtaNnVjU3FE?=
 =?utf-8?B?YkNCVm04Zm83ck1INU1CQ2YyaVdUbUpZSDYxUm9XWTlYcXpYRzYzUmFKNG5h?=
 =?utf-8?B?RmxkZjNIRTl2MGRFalY3dTZyVWcwc0VySklwZ0FFdGZJZjdqU1AwdkVVMVhN?=
 =?utf-8?B?RXVMdGJHNUFmQ1RnYmZvSXJVbEtSQTJ2V2ZwTEhzYnhJdzRaME1WbTZSVWJn?=
 =?utf-8?B?SFFHWFN4WDdEd0N1cTRaSHEwSnJuMTcvYlRMYjRyZGVBR3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 09:55:56.2014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b90a5-b33b-453b-b224-08dcce5a1a4f
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR02MB7882

On Fri, 06. Sep 21:25, Barry Song wrote:
> On Fri, Sep 6, 2024 at 8:06 PM Hailong Liu <hailong.liu@oppo.com> wrote:
> >
> > __seq_open_private() uses kzalloc() to allocate a private buffer. However,
> > the size of the buffer might be greater than order-3, which may cause
> > allocation failure. To address this issue, use kvzalloc instead.
>
> In general, this patch seems sensible, but do we have a specific example
> of a driver that uses such a large amount of private data?
> Providing a real-world example of a driver with substantial private data could
> make this patch more convincing:-)
>
To be honest, it's a bit embarrassing, but the issue is that my own driver
allocates 256K of memory to store data. :)

Howeve I grep the __seq_open_private in drivers and found
https://elixir.bootlin.com/linux/v6.11-rc5/source/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c#L3765
static int ulprx_la_open(struct inode *inode, struct file *file)
{
        struct seq_tab *p;
        struct adapter *adap = inode->i_private;

        p = seq_open_tab(file, ULPRX_LA_SIZE, 8 * sizeof(u32), 1,
                         ulprx_la_show);

->                      seq_open_tab...
->                              p = __seq_open_private(f, &seq_tab_ops, sizeof(*p) + rows * width);
->                              ULPRX_LA_SIZE * 8 * sizeof(u32) = 32 * 512 = 16384 = order-2
->      if system is in highly fragmation, order-2 might allocation failure.
        if (!p)
                return -ENOMEM;

        t4_ulprx_read_la(adap, (u32 *)p->data);
        return 0;
}
So IMO this issue might also be encountered in other drivers.

I should also change the comment in Documentation/filesystems/seq_file.rst
```rst
There is also a wrapper function to seq_open() called seq_open_private(). It
kmallocs a zero filled block of memory and stores a pointer to it in the
private field of the seq_file structure, returning 0 on success. The
block size is specified in a third parameter to the function, e.g.::

        static int ct_open(struct inode *inode, struct file *file)
        {
                return seq_open_private(file, &ct_seq_ops,
                                        sizeof(struct mystruct));
        }
```

if the patch be ACKed. I will add this in next version.

> >
> > Signed-off-by: Hailong Liu <hailong.liu@oppo.com>
> > ---
> >  fs/seq_file.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/seq_file.c b/fs/seq_file.c
> > index e676c8b0cf5d..cf23143bbb65 100644
> > --- a/fs/seq_file.c
> > +++ b/fs/seq_file.c
> > @@ -621,7 +621,7 @@ int seq_release_private(struct inode *inode, struct file *file)
> >  {
> >         struct seq_file *seq = file->private_data;
> >
> > -       kfree(seq->private);
> > +       kvfree(seq->private);
> >         seq->private = NULL;
> >         return seq_release(inode, file);
> >  }
> > @@ -634,7 +634,7 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
> >         void *private;
> >         struct seq_file *seq;
> >
> > -       private = kzalloc(psize, GFP_KERNEL_ACCOUNT);
> > +       private = kvzalloc(psize, GFP_KERNEL_ACCOUNT);
> >         if (private == NULL)
> >                 goto out;
> >
> > @@ -647,7 +647,7 @@ void *__seq_open_private(struct file *f, const struct seq_operations *ops,
> >         return private;
> >
> >  out_free:
> > -       kfree(private);
> > +       kvfree(private);
> >  out:
> >         return NULL;
> >  }
> > --
> > 2.30.0
> >
> >
>

--

Help you, Help me,
Hailong.

