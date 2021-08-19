Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1853F1FF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 20:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbhHSSf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 14:35:28 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:28000
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230047AbhHSSf1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K36/XhBvsNQ5QG3s6foC7LIr4QUHWIMfZXTx5NVVZJwlQlGKjLGoYkxWfy10uT5AYqIo/UpGfeSVATMK+n9GXSUUrhqcQhAo7mA4/3CiiBzNBUEoWdDDsquz7hokkfWHC4sPcVvDrlJ5xfKVnMlPOFYEooh1pWznqeCVV4md6RohbXL1roQP9NI5zaRzwXrUVGQdNHO8bKhGqXw3yW+WHRDpKNqlQNMRnhKAthIhaynxnhSURt3yMacG4eA9+nWBrGSvMfxAM7t/Zbl0qkUGYrANG3CtXiqTmRNQn/BX6iM1BpiIgBITQ1ZpuDYiFT3rv/2LN+Jzkk4/0sAYQJxcmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkoOiP7x6m2+t8qBJzrDXi37Y5A8ztZsxXi32Mj+XxA=;
 b=EONvqT3Q+VfIrTRtgEjJovq7jEe5uoFCmECU18TxSxxgubMb1Td3oNNY9lvYVzplsBWiSlJbLUweQtKl17pBF8+tkpQQyxsNC3EbQgAW5af4fnHMzD6oUBLWSz1kuMPFdnkFnSr6dnu5a3GELMRehS6BUuz7ZQ5uRx5DvrVx3CmG0U76cDYW9cZK4EMh5CTPZFK6NZg1Ume7L1e2pTwxmmY0GAT9NQEvPxB4D4qidXK8TGzAg/MY2Fxs114ie36NsO8Un7bFNBHGzr2lWzQT22x4n4m/eqTR9aVjb91epRb+2WaOvNbua3A/l+PjpK3Q0HX+xsA2O8Rjjj/o0TrlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkoOiP7x6m2+t8qBJzrDXi37Y5A8ztZsxXi32Mj+XxA=;
 b=Aftoc2D3n6/XywBAyIGz268OIwAKRmNWHK++yhacYGDpFzE+sXFnjna1o8nOGhmCo6wVhYLXk02kxRMft/tz86st4rDjb7h+d96MKFV0Had1gLbghZtUbuYAZsJKjdxLSO2AlxSQ2nwdFQ++gSo78ojjJLZPZHqiZWsPtMjJ2vw=
Authentication-Results: samba.org; dkim=none (message not signed)
 header.d=none;samba.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 18:34:48 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d560:d21:cd59:9418%6]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 18:34:48 +0000
Subject: Re: [PATCH v2 04/12] powerpc/pseries/svm: Add a powerpc version of
 prot_guest_has()
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <cover.1628873970.git.thomas.lendacky@amd.com>
 <000f627ce20c6504dd8d118d85bd69e7717b752f.1628873970.git.thomas.lendacky@amd.com>
 <YR4qfZdkv+91zNZk@infradead.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <58381b1c-79a4-e639-ba48-41b0f3da671c@amd.com>
Date:   Thu, 19 Aug 2021 13:34:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <YR4qfZdkv+91zNZk@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0092.namprd04.prod.outlook.com
 (2603:10b6:805:f2::33) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.241] (165.204.77.1) by SN6PR04CA0092.namprd04.prod.outlook.com (2603:10b6:805:f2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 18:34:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65dd0c8c-f1f5-4ee6-8ef7-08d9634005f8
X-MS-TrafficTypeDiagnostic: DM4PR12MB5120:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51204710E8C66AABED9BADF1ECC09@DM4PR12MB5120.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GsebWkP3tX7HXAFN74pFjWPxlbXXuIvJZJRBCbGTtCcHXc57azDpDEtZTFi59nOs9rf/yCOZDl2hqOcg91DynjGBCVNtbEfs0GBuvNiQYAUvDEDFghEfbOJARMBHEPOax8KjxlXGkk7oD/4Rd2WsLk3YBnjCy/KK8Xj8ov4DAxKAi8fkdpkYlQhyVgsng7gneTN0lfYZ46zVH8YPHFL9CIs217ccUNJvj0dkRz1pSg/D4JlGWeUBHspmIe7G/bk5B3knpgEXx1SlI1MAuMqEH3qqNid5sBEpAIyqkEMkwdFrDKGDGcgncxNQPyZVAin3wW9RgH2kf4d+X3nEkK05p5xxITQDfR3hIznz0NxqxnleNwTC6fZrKNDmmgf30Oy7teLaelFcD8ZG8FxpAYmaIlHbohN2sum6CP1kGkmQbM02GGb8XCKRVAwpwIrKBMQbHiG8LVQr5qlc+ZhHWAjZ7ch7MtwEv7EE2F6qb10Dx6yscJrLq7tpIu5UR6H1p2XaSJ5ILJ++kv82LB6RmVwQ7QF9BB7NWDrNTy/1Ld8A+H/COqzikjCrGIulpbvMpRRb5vum3nxS0KqMP+kE2vIpTa8fhEGvaGtaFi7QA4cr+aiXr+zm390xBMNDsGoy5F6UhGDlOABUmEopenon1+5v/Q9xe31ojoIfK2qpesnFI/PCkxU1u+BCzXo0k6fo44gE0B6kJhIQ4khDqeqNhJF2YdH+ycnkXC16bSA5iUrSE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(2906002)(66476007)(26005)(53546011)(7416002)(16576012)(66946007)(66556008)(5660300002)(6486002)(6916009)(186003)(2616005)(36756003)(478600001)(31696002)(4744005)(86362001)(956004)(8936002)(4326008)(31686004)(8676002)(54906003)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlN2eU5LTndLVCtST2hjQXhRekJzdXlISXZQVzlMMTdYTWRmZ0xaRmhoeFBH?=
 =?utf-8?B?V2IxdlVDOWxLcHRwd0pFLzFXMkFYREhkdjMxMWlEemxqZnU0aUN4MXJROWFp?=
 =?utf-8?B?UDJRdHI1ZGFJYyt3Z2FpeUV3dUsyVGNKRGxCUUNxZDBIallBRk14TTRpck5C?=
 =?utf-8?B?ZmZnWjdWL05vclVLUGQwSHN0R0R1OUNnVXVzdEhxWStFUmFuYlhzV0JKUTAr?=
 =?utf-8?B?OVBFMStmcXE0Ly94TzRyMTUyTHZkVUlrdHM3eTByVllpMVUxTStTVWM4SzNT?=
 =?utf-8?B?UEIvRUswL2ZJdGFJUC9CUmpxWFBpUWRGU09CcjduUFJnQ2VVdEhJYkpNdHhl?=
 =?utf-8?B?VGtEd1ErQkwwREpBdlF1Z3lTQm4rUklreTRwbzMwUXljTzFjSDhPVlN3cmZv?=
 =?utf-8?B?WGRrSW43ekJQdTl6dm1ITUUzK1o1YVlHcjZJdDZjcmY5NVo1K2JrT0VPbmRZ?=
 =?utf-8?B?aDl0d1YxZDNxY2tRM3pNelB5YWQ4aTlUcUgyaHFXSjJnZ0t3ZEpaenlwTmdY?=
 =?utf-8?B?RkZIODFLbmJ2N3kxdElPME1Ndm0zWlo4YUFtbHpPMGFCNzZZNEFtTndyKzQ0?=
 =?utf-8?B?aUVqc1pUdlNwbm1qVjRxUCtYMGRLLzErYXdOQitYK0JjalJXQ01SMDF2ZkYw?=
 =?utf-8?B?VVd5Y2w0VWxxV2l0eC9SQzBhS3dld21LcTVxM3IwZmZMa1M5QnFOZ0dCZldS?=
 =?utf-8?B?N0hhRWtiWXQxYlNEaTlXK0JOdXpQV0hyTHZMTVQxZjFOOVJyQmVlMkk2Z3FW?=
 =?utf-8?B?azRHeEdQZTlCN0tiUGJLS0g5VHh2OFNPanJzR3JqWkE0enJEKzBzaVJmUGdj?=
 =?utf-8?B?cTd1TCszamJtYVNlMmNyd3N1UzY2UVZSdVk1bGtqQ3YzK0wwcG5MUXBsRThu?=
 =?utf-8?B?UVY5ZU44QlcrUCtMZDVLR05UcUtLQlZaRmhRNjNoWlZ5NDFWK083ZWFPZmQv?=
 =?utf-8?B?VlQzQURPSjgyaHR4M2llZVFOL09vZWJBUzJoQjRTaU1FSVRQQ2xoMG1qMzM2?=
 =?utf-8?B?c0dTYzdocm1UM2lFbjdpRHdEVTI1NE1nYU5YWnZIWFZxTENrNEpYNnlJUzJB?=
 =?utf-8?B?VkdxTkNlV3pxajB3cUJRb0VBOEg5RlRxekdWSFFLSG05Z2dZdmp0RHRvOExx?=
 =?utf-8?B?VVE0OFZ5Z2c4emFNa1dyZENsaEhTTTRobUVqZzhWWGR6dFd3akV4VzZQNEt6?=
 =?utf-8?B?eGMvZjdsV2dWaEIzc096bFpIdnpLcUhFdXQzbGlHbGtZTlQ3OUZoWXl4a2ho?=
 =?utf-8?B?TnFscmR4KzVYWXdRQ2FjSzU2dzRyL1hqT083bHlldDZvVXMrbU8vcnJZam9m?=
 =?utf-8?B?Umt5b1FuSmcxdnZSYXdMRisxUnBOZzNGR2p1dm9ndEMrZUpza2FuN1JreGY0?=
 =?utf-8?B?MHVrT2JjcTB1eTFMYUpkRUhOdWxYTTlNVXRUL3FxMXRGVmNWdmgvdEVqekJW?=
 =?utf-8?B?RW5LTlVFbExLNnV4WXZXL1hmV2ltSzdFWjZ6bDR3UllWNTN3eW5kdzhpSVVn?=
 =?utf-8?B?TzgzR3ljaS9rUGlWU3ppVnljMmI1b0IxdWxvWnVrdTV1dXBpVGFtaXBmVjBF?=
 =?utf-8?B?cE5xRGY0VHpuV29VYkUybGFYVkRjYlFodWh4SkpoSHlyRnNOQVY3T0FDNmxI?=
 =?utf-8?B?Sk5USkNGdk1GVjJnL3JKaGxUR1ZyNTA3cmdud2kyS3VQSWtWNHBPeE53Nkp6?=
 =?utf-8?B?U0M4NFlYSEQvVW4vS0g1TDh0ckQrVjRlWm1RbzNpNFhyWnY4cE9iblhhekVB?=
 =?utf-8?Q?sV+xTXzYThefJa3yzve2YqpTUx3snYcMNuqHUqS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd0c8c-f1f5-4ee6-8ef7-08d9634005f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 18:34:48.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hvhu8fd+ca8A7Jb4Mg4s5OcWHiGNfpem4B0wi/GRSdnsAOa4lvZnB4mmr0J5Rju8m27AO4LX/DcgNK57h3EaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/19/21 4:55 AM, Christoph Hellwig wrote:
> On Fri, Aug 13, 2021 at 11:59:23AM -0500, Tom Lendacky wrote:
>> +static inline bool prot_guest_has(unsigned int attr)
> 
> No reall need to have this inline.  In fact I'd suggest we havea the
> prototype in a common header so that everyone must implement it out
> of line.

I'll do the same thing I end up doing for x86.

Thanks,
Tom

> 
