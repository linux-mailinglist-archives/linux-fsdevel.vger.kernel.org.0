Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034AF3F1E2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhHSQkq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 12:40:46 -0400
Received: from mail-co1nam11on2064.outbound.protection.outlook.com ([40.107.220.64]:4512
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230220AbhHSQkj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:40:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0n4ZfmzWilSAxDGOMWujWi8X0u0EzsUOf/ir54BswSgo1YFFgs1Vdy7mkG4FrOt7riO+LGHEZO0GfuEjMDM4Wfme+eg9sAnbmC29by5uveCsLasw/9BaAI5fXBRTaoF8i9EVRoUglN+4dHqI2gw1sQ0A7ED8o5fANwgEjKaCeSAbDwYt2PZorgBAdc8mzESItj7xAAAa0B9GAVpULARC6h62rY/ardiCTsFBSLLGZ2/8cyOLX2pcQVBK79P2E+DC9cCplW4TIaHoCjq3v6VyBsMjNTBd6F4imIZSe3E9DWlqonkcSypXwLYv7NwX16YuZfL1kKngk0/WbYZjhjTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLUOLW2AyO68bsOcSHTQKBCY1eKk4GI2I/SpXjqqZTY=;
 b=GPDcNGhV8ftI4ETDqK3uZ2W6ok1wmiNelKGTrys0vf4z/4cLjcfC8PBHM1c/4mlE16BSWTuY3fd+Be+mjgLOLXq59UhiPABW4hvTs9Ahny2QNEb90VqTfbM5gM0EEFLa0hX/yUO8aQWKraQ7WHH/pDl4jl7C1Lozw3lG3JXZmVLmJNnhALNZHUyWsWBVOEvgybX9tyuepD+K9kZlqoXneXTdp32VguyAxhuacD0EDTEM57/Z0uV7NV06nq5JFhkAjDkNo7dC94xomYyt3CdXxKQwAssKgJzUermtfAZGLpBA3L275/ydu7ETCYbV1TieTw1cwnXugek31NQkKL2gkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLUOLW2AyO68bsOcSHTQKBCY1eKk4GI2I/SpXjqqZTY=;
 b=UwkwKlPyHtu5/AMIDVHG9riuS0rAg45MdFjHcOvLGWYvXvEsnBntdGsD3TZ4npjmPnzGTgeBgr00YWjmit0TVh0N2ISkCn+yAa6NpW21sYzZ9zoQl7EaLpFXiQMH0vxBurTn7VaEbay+gy94NvV8xfzrP9nevdy/Ayj0/BVKesk=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 16:40:00 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 16:40:00 +0000
Subject: Re: [PATCH v2 02/12] mm: Introduce a function to check for
 virtualization protection features
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-graphics-maintainer@vmware.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Joerg Roedel <jroedel@suse.de>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <482fe51f1671c1cd081039801b03db7ec0036332.1628873970.git.thomas.lendacky@amd.com>
 <YR4ohWC4/cLsuCvv@infradead.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f367b8bd-6f82-5aa3-a27c-7a19959ab435@amd.com>
Date:   Thu, 19 Aug 2021 11:39:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YR4ohWC4/cLsuCvv@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:806:f3::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN7PR18CA0020.namprd18.prod.outlook.com (2603:10b6:806:f3::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 16:39:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc22f772-0113-4ba0-6fb1-08d9632ffcab
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5374FE00DD3EBFBD9CA4F21DECC09@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1irl/Y2hNyRyHlwWH0ag8xSFZW4H+EdQhNYuwS9VzL37O7DvnrzQ6bPyyXEzIjA2Ye0iHbm/RUfLRxV/Tk0BMfkc3Xoy+3RRJXL2mQ0xw64tN+Lw8Gx/OqTx6gmEalSUuX2K5ckZvc5uX5ieOhu2hxo5OOkFiJyFM587MRaV86zFQB+wp7ITJnb2VWYzCRBIwze3q3evCEonbHhK5h7jgKX8o8vGei7iKiin7DHSFrsGc63h9yPTk9u1N72oDf5AMj8ZNq7q+m4sxickhhhOj2vjxDpjra+JIrS5zmJFQbd0XQIlBb3Ldv00MEKbYcB7V4r67bExd2lUNFckG8+pPQx5jSK4rJ/rPXb8DGC8UTKpY92n7vUz6s8Dme+mdVJHl1o49HQ1UiEAAhacJeN79VBVtN8N6lXVwtLElh+TsNqtcGkC0or7n+dDiB+5ZwUoANtcbhIB7eFI6bjyelssixnsEw4lehqY+9sjHWEqmpZ0RidJ+bsstSB6gWNDL+weicyCRXsoFXH9QUb8FwNTKqscyXjakZtpVvkqHsn1FAnnu8dGYxLg51slM/6mE7oP37JM4iGZdpDkf3/s02Kzs8Lt+GgszxkpJL7D8AgGmaIj7oc3j8/CnmbwFiCGlkXg0lNIfBoIz4MtCpNXc4PPlHe7AcfN2FNc9HQ2pS5iLcU1gyPAN1T5zdDgzSIhdbFzt7FTFsCswxkqxMgGgkcfCLDCGWeSuej8cZlAHA+nIFU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(38100700002)(8936002)(8676002)(66946007)(5660300002)(4744005)(31696002)(2906002)(956004)(16576012)(7416002)(186003)(31686004)(36756003)(6916009)(66556008)(2616005)(54906003)(66476007)(478600001)(53546011)(86362001)(316002)(4326008)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzV2eTNJQklydkRVY1ptRDNIMnYyS1YyblVrNmtyc2VNaGVuUGJyVWlMclBJ?=
 =?utf-8?B?QnhDcFh2bXJqK1hPd0xWZWxHVDAxeEYrd2drWW5LWU5HS0s1VXExZWRaZWpq?=
 =?utf-8?B?SjVVMjF6OHBqTXlEbUN4cnJ6QVlnWFRySWdCUE5QZmdiRVNGbTR2Qmt3UEE2?=
 =?utf-8?B?bEFyaW02Nk5heWlSQ0VuVHE4dFhFMDlGSFQzVW5NQTVCRnJKcDlIY2trNFc5?=
 =?utf-8?B?NDlDV1FUckp3Q0VsSTZkSkEvZzhtT0FHTXR6QjY3Y05XS1hWSkthb1ltTE9C?=
 =?utf-8?B?aUY5TEpjdUxhMlVWc1FGSWd3RFhKZS92MlJsMVR6Nmt0TGhHMExaYnk2WWRI?=
 =?utf-8?B?OUE0Q083c2FIOTdKcWgxNVFYUTh0cHc4WUhGb2dXS2VyYXVZbDhiMmo5N1JU?=
 =?utf-8?B?dEdSL0ovVEI0ODJLVVlsMU1vNGRBNjFUemFhUEdVM2NNc3IvUUNZaXFFbjAr?=
 =?utf-8?B?ZGVHOXFOSDdUY3hVTW5FN0Z1V3BvWWtHdTJwaFFhUkdydTR3T0VHTXVEZnE1?=
 =?utf-8?B?OEt2WG0rZGlqZmVBS3ZDZ0NKUExXM0FEaDY5VjhlMnNwRTYwMUZBMFVuTHo2?=
 =?utf-8?B?VlV4a1ZkNDhuTjV3dkVpNGE3TWUvTkZlQi84Tjk5NkZjNlB6TGVCaHZBa2kz?=
 =?utf-8?B?OTM3cSswblI0T3QwdlF6VjJFT2xDbkRBMURYVnR1dmxnaHo5enZzVVl6ZFRw?=
 =?utf-8?B?N2prbWNWSnVQRmZIQkVTd0h5QUorUFlaQXhGUE9iK1ZPbWU5YWtqWDJGbjFp?=
 =?utf-8?B?TklqclpYMVp5cDBEWElldi9JdVZpOFVkZWNxQ2o1TURlVGZBcGRoV05MdGs3?=
 =?utf-8?B?ZFU0YktzblBBNWIrL285VCtJNnkrUElHSldDY21UUzRKWTRkNE9MQThqRmxY?=
 =?utf-8?B?YVRXZVAxVkhxTUJzdEdROGM0OGd5R0RxVGkrMHg1Sk9BY2NndFd5SGkxK29q?=
 =?utf-8?B?Vkw0QlRHYWJxK09hY3M2SktrOGtWdlVVZmpmWG9jYXV1VjIySkp1emtIYlV1?=
 =?utf-8?B?Ky9ySlRnajZOdVk2bmtrTHQraGViOE1zVk1BVytubVl6Y3ZSUjZxcEoxUm45?=
 =?utf-8?B?ckJ0VVVkNjlnWW5YM01uRW1vRm42Skh2bzFsekk1Ny9RVkhpcG5ONExxcEZs?=
 =?utf-8?B?YjB3UldmQ3VmZEVEMGJEYVQ0YUFBYTN3MzJFYWZUZWJsR2R3eXEwc01lajNi?=
 =?utf-8?B?K1U0dmtZT3ByMXg1cXZpY2txc09ZdUdSVWNSeUFLRHE0elVvTmMvd0xSRXVL?=
 =?utf-8?B?dW1LNjJBck9FaFJ5V290eVJEaXNjdHE4S2lZb3p6VnBVVStkNGxNakpHODB0?=
 =?utf-8?B?aDhtM2hPSVFJTFVERTA4WjdyQldWWjh5SzN6TTV4MHpaWS9kcHQ1YituVTBn?=
 =?utf-8?B?ejhudm9ZQ1k3Ry8vdHdQVUdMWnVvOVhQTTYrVEkzbmF4UDVLK2NVWmx6NGhj?=
 =?utf-8?B?c3dRNFpEMEcyNnBHaWpVbTM0MGNNTnBiQjJtWUVEK3NBMVR6KzBIRzUwa3g3?=
 =?utf-8?B?YmpxYjBLcHZjUm1CT1ZUTWlBUGttOHZrMGtyaTc1WEhwYU5UTzRPTU5IcS9U?=
 =?utf-8?B?cG5RT1Y1M3A4T09nT25oWVJ6UDgzcWhWUjROVzF1QVdFbTFQZ1VHdkVvSlI5?=
 =?utf-8?B?MFZhSHlJNU0zU20vZUhIeFo3WmUzSisyUlRoOU9yQklaek41ak9MOUVWWmtQ?=
 =?utf-8?B?VXNKL1E5Zm1WVUV2cXZwdTVKMk4xVXBQM1dxS0lsZEZLNWl1bmpkYW1LMnQz?=
 =?utf-8?Q?YUjI3KkpAuGKTYnXcXw+sUmWxcOjxI1+ogLe4OS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc22f772-0113-4ba0-6fb1-08d9632ffcab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 16:40:00.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cohIkvhfUe8LBj84vSq/WZni+DBVJEKCWSRld+ZdEzmgCFJDGkk1l+43B+tsVgkUtSGWrsmNeEpNzTLPg/Y75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/21 4:46 AM, Christoph Hellwig wrote:
> On Fri, Aug 13, 2021 at 11:59:21AM -0500, Tom Lendacky wrote:
>> +#define PATTR_MEM_ENCRYPT		0	/* Encrypted memory */
>> +#define PATTR_HOST_MEM_ENCRYPT		1	/* Host encrypted memory */
>> +#define PATTR_GUEST_MEM_ENCRYPT		2	/* Guest encrypted memory */
>> +#define PATTR_GUEST_PROT_STATE		3	/* Guest encrypted state */
> 
> Please write an actual detailed explanaton of what these mean, that
> is what implications it has on the kernel.

Will do.

Thanks,
Tom

> 
