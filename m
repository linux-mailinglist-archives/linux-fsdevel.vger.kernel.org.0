Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D762699080
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 10:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjBPJv7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 04:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBPJv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:51:57 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D86BDC9;
        Thu, 16 Feb 2023 01:51:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmeC8vvOOsHGnOLrmd23Ll3ewB8DbIyH1lSpuz/+xk3fP86SvgcV6BXvK03Qbbgx/T9yLkVj1OhMp0CB5iV29Pk/hFg5f5409RwvP86KgcA+wC91fg4t9nV2Z3teakeQXtjtRv87V4A6f9ZZAUOqM0Ql6/NjNZBIR1V/aouAhoV0PzhtIbBAE2E+hYzCr2tusdq7I5siCWsXVIZKXbi0XStUUjRcekHh/cAzNzySyG/lrG1XPqsbXqwvcVjlY2FMRA2iNLn+DQgEcHuZFOzxObkyOoJXO+q6uhrOPhZYTjcPsUlPxMhXUAAdLjy9WKeaWfW7KORRjVwabkQ5l3UMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYhi8XEvPcZF/NFcsIA0cyLpWprtOSD5JJvxwE+I2h4=;
 b=b23R7zb0Wf1Gr6zBH/OYYljiRGyK4HIlK51F2ErHkg975tPbUGk73sGwaek5Kz+xpKsOXRKkAjKi8Ilm6TPpk/mH253sY68pYArd1a9jXy2M+LZ77edDvv9c/g2yw0i1OnNam+hxx5M3iLg5Cqfs/crfOU25HATfaRkGSI52liC+2EEvA6O1R58qo/NUm1AVAdv+ZlvTRD+Em7SPt1zEAj+xWznjL3hVKzfjZUITx3wq2zKUqBMeoYBsJITO0Yhj0pnG0GrK+TesW02WF+aOQQD9Kr51+FrHNsUZ9c15lxMYFhia5lCTFYPFHkEvFYYtssmkjSBI8H+JPfRxHvBLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYhi8XEvPcZF/NFcsIA0cyLpWprtOSD5JJvxwE+I2h4=;
 b=xzTvgJKiIo8mrqoGfICnkaidnekMORdnGhan+niZZ0gazFWzJLiF4gYDbiT951tn0NmyIl87CCztrahy3swvtzbAT3JknYhJZWS2a3ox9jqCqo1HfkJIoRXlSsQpASpYYNRWlqc0U8tfTCbC+MTKRFSqz+l6xxMuY7jZfXMZMTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.13; Thu, 16 Feb 2023 09:51:54 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::6c34:2aaf:bf7:c349]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::6c34:2aaf:bf7:c349%8]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 09:51:54 +0000
Message-ID: <86d7cc82-8ff9-769b-f80f-ff18fe28f44d@amd.com>
Date:   Thu, 16 Feb 2023 15:21:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/9] mm: Introduce memfd_restricted system call to
 create restricted user memory
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20221202061347.1070246-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::17) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: e96d707f-90aa-4882-dacd-08db10036ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfGRgkh27w0t8Vh/5TP63H4fV9VGnxCmtMIkQaDTgM+QVimFWRQUKRb2l9+MyokIRgW+N2zNNJB15ZifmDod0YHtAbGK7HeMSnhJmx2gdbqSFemJtMctQKusQZJoFu06ueFBTNgJoTwR7IbmTlTiCCZoxSxToDqal8bxTOuT5JxyjJimPNJeSpCBTrT0sWyBAmb/EEd5eI5JRnFTzp9g0aOxEZLgffTdF0J4BFhvi+h2tn7L2U7aBm3lJTwuAZU7h56H8RcqMtb4Zd3mEKCWffiZ79fO/TXB2OGKva+UDJ/kRGnNNH3kAahVyykxKKO44g/84tD9LPPy/J/kHFHP5pFC3xgfrBwUELvGb+yQHNwqqWefl/lbVoV8XvhJQMDnf0l0pC0dWOJdht9vb2F3WE6mJaaosVBSg/ATk5h2ZOi6TakvhopUFQMAghFfMrP9DBISBzInBdFGbCaJO0+YESw8NgOoATY9ZwTWuO6yCRTw4uz3K01iRRMvfy8jX5w0v9fSkVUsuLyClBxqGVwXpsS0ISeQ9Z2YEZnjNK8toI9Cd8+zCSgH/WlN0oiahsqeCjHMA4MJRpS+YsAetSV+kxf+8bjRVkqLItYoNOczezOKy82nFaxXGCKqMoGZJ2PDOsIA46frQ+Zy1j01Ilb5xi0rvM6LcX63+enpOijYz4WJeDM04Y/FSC+Iy8VRVdasFB/aZaSzGK0PDhTcP+kBa+1ezSN+3BfQTJ7ewWCbU7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(31686004)(36756003)(54906003)(2906002)(7406005)(7416002)(5660300002)(8936002)(66556008)(66476007)(66946007)(316002)(41300700001)(8676002)(4326008)(478600001)(6486002)(186003)(6512007)(26005)(6506007)(31696002)(6666004)(2616005)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVnWG5DT3pBUnlkeEhSWjhxYnFaYTB6ejZhSkhIOFlJdER6T2kwY2NheWZu?=
 =?utf-8?B?ZHZsR1JCbnl5K3E1cWU3TjlyL3UzVmJ1UmJraW91WXlWUUtxNzBFanI3bGQx?=
 =?utf-8?B?WXpRdnROcEpLU2E2bFFIdUJNVHI4dEcxRGI1U1pUYkNmUmtYeXQ3NDRjMHJq?=
 =?utf-8?B?NDdtcm1KVHZrS3FoSEthS3dXeWl1Wm9teTM2RWptRFlVN2N0MGd3eEdYL05p?=
 =?utf-8?B?NHczRHNkZEMzWjVFQW14WkNRM2dJR2U4TU55WFo0UTlEUkxRK2Njdm5YeitJ?=
 =?utf-8?B?c3BuV1Ziblg5K2g3a0RnODdSdkFhRW9McS95b09qUG43bUhMeVduSGZXY1lm?=
 =?utf-8?B?RzR0Zlc2dHF0SG1oWjFkblB3K1BCaWh5STI4YUsyUzVhSFBxTU4zckxkN2dL?=
 =?utf-8?B?cUtKQ0htYXpIZW9UQ054Q2dGMHg0NjI3dUlqYXpZTVlaOXdYdFRqMWhkbVdB?=
 =?utf-8?B?T1RqalFxTVpZK3pidzJwRUVtZkk0QmhpdGZxa1VXYjBhYlZvRkpkLzRLd0wz?=
 =?utf-8?B?RkUrN01xS3hRMXNJOXVZR1k3ZVBTaWQzODZqMjhNeE5GaUh5dlBvRkxPVDEz?=
 =?utf-8?B?Um5qU3FTeDU4b1V3c0pvaldIdHAzYUZ0U2ppTkpKKzlidXhXQUt4RFd4bGwx?=
 =?utf-8?B?Y2ludzQ2NjlLQ2lvMHZJWlVrb0lMNEIrbEVhdmZLWE5zRkFhdUxscEJIQUMy?=
 =?utf-8?B?TVpURVpQTWpJWmE0Y2pmTHJHVERZZU0wRUpRSWtQZTRhc0QvVDRkOWsycGYx?=
 =?utf-8?B?MnFjby9OZjhQMGI3bXpETTl4N09ldVNEb3hTZkNkb3k1S1B4aFdGTkVDUzJP?=
 =?utf-8?B?QnlqQkNrMjRyN0tGeHZaUXYzZkRQVmh4d253SzMwY05vNExVU0YrVmtUb0hj?=
 =?utf-8?B?eldCL1MxSXZLd0hwN3UzSzZwbjhTVUZjZVFhS201Z3VsRVRINVM5RG44aStq?=
 =?utf-8?B?YzRTanFPcERUeEpGVFh4OFJzRERpTjIyRHFESzRaUllxUU9FcGhqZFlyWSs3?=
 =?utf-8?B?czlpQkVBUGVibk84MXJKN2tibHZCV0pRQzBwQktneWZoWGVydjVJQmxJZkZj?=
 =?utf-8?B?Tm5TTjJ3b1dtZC80YWpwZ3ZCMCtWWjNMZVIzTTBoWU9qWGtrRHo5TGVNNStk?=
 =?utf-8?B?T1k1TlRubkNmWmVQMWxCU2hZOUg2SWsrTFZTRlNURTdoNWlLakRUbVdpZVIx?=
 =?utf-8?B?d2JKbzRMTGdHbUh3K0x2Um94dDZKZVVnTjcyZ21JMFBxdHYvVE1HbHNYVzdh?=
 =?utf-8?B?blFISzkyY2VPUGc3RXFDUmxWTmhjdHhxVXlyVHlNY25OWTdFdGQ0cXVSY2ta?=
 =?utf-8?B?eE9QN1dnSkhlcllMcjNRaDBoMkhNSnQyNWNEMWF0Z1Bqc3NjRGpLR296aWI2?=
 =?utf-8?B?bWxpY1RKR2xMbTlNeUNzb1lFcmVVZ2lqWFQyajBDRU94RlYyYkcrRHdqL0wx?=
 =?utf-8?B?N2x1MmtLVUFXcEtGZDl3cDN4Q2xtY25uZGxwRXBTSlR2eFNpQTNMeVBjNUw5?=
 =?utf-8?B?V1NpWGROaktLdDRiTFhLSTl3SXhtMjNWYjdYNThueFJhY2R4U0l6Zit5ekJF?=
 =?utf-8?B?NzFDZkhWSThNaGpKUWRGK1JvbkR2K2RmMGV6VFhpc1RIOWdEQnYyZUxxcFcv?=
 =?utf-8?B?am1QQndtRm5OYXFReDN5YVhMUjJnL1RST3BwUyt4UDRSdUNROXF2emlmd3FQ?=
 =?utf-8?B?aUJnN1hQd3FQb2tDaEpCcEE4U28yTE1NcGZVYnQ1Q2tnc3BKb0M4WnF3K0ps?=
 =?utf-8?B?ZTFIY3BYZ05NZUJUbWNlcC93WWVzK3RNdkpOM1VDNm1Hb3J6SHZjMnFjRUZ0?=
 =?utf-8?B?ckVkaEp2MWU0MWhtMThycmNhaFg1Q0V4ZkhBMWkrdXpkdG04bTQ2ZmY3Qm5B?=
 =?utf-8?B?SG1UTGMvNzZ3ZHkrQldOeS9DOUl1SXdrdlFjeWc5a2R1eE11YlNxYmFZa0lU?=
 =?utf-8?B?QkR4MUE0enRSMEhVbk9rV2dUMFltSlpNejhkTWtONlplWS9IQVU4di9SaVV6?=
 =?utf-8?B?MlJSb3NDN1J3cWE3Y2V1V1dwdm9OQUdaL3ZmUGVGQ1l0K0lFZThlMDJBZU84?=
 =?utf-8?B?cTlOREVrUTZqMmF2T0ZkeEpvMWdlZ21HV0ZWdTNIUjY2SkQ0VGpTazZRUFYx?=
 =?utf-8?Q?rgFgqaG8ZnkJVK4qqBoKR+Hr6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96d707f-90aa-4882-dacd-08db10036ed9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 09:51:53.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lL4mnVPD9cv0od0rUs88y4Ud1AUMOK2PHaHIvvnI2WhZDRcZQH9xfDWnrUACOSTjR0V+CwDAUnTN4ccPcQTPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


> +static struct file *restrictedmem_file_create(struct file *memfd)
> +{
> +	struct restrictedmem_data *data;
> +	struct address_space *mapping;
> +	struct inode *inode;
> +	struct file *file;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data->memfd = memfd;
> +	mutex_init(&data->lock);
> +	INIT_LIST_HEAD(&data->notifiers);
> +
> +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
> +	if (IS_ERR(inode)) {
> +		kfree(data);
> +		return ERR_CAST(inode);
> +	}

alloc_anon_inode() uses new_pseudo_inode() to get the inode. As per the comment, new inode 
is not added to the superblock s_inodes list.

/**
 *	new_inode_pseudo 	- obtain an inode
 *	@sb: superblock
 *
 *	Allocates a new inode for given superblock.
 *	Inode wont be chained in superblock s_inodes list
 *	This means :
 *	- fs can't be unmount
 *	- quotas, fsnotify, writeback can't work
 */

So the restrictedmem_error_page will not find the inode as it was never added to the s_inodes list.

We might need to add the inode after allocating.

	inode_sb_list_add(inode);

> +void restrictedmem_error_page(struct page *page, struct address_space *mapping)
> +{
> +	struct super_block *sb = restrictedmem_mnt->mnt_sb;
> +	struct inode *inode, *next;
> +
> +	if (!shmem_mapping(mapping))
> +		return;
> +
> +	spin_lock(&sb->s_inode_list_lock);
> +	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
> +		struct restrictedmem_data *data = inode->i_mapping->private_data;
> +		struct file *memfd = data->memfd;
> +
> +		if (memfd->f_mapping == mapping) {
> +			pgoff_t start, end;
> +
> +			spin_unlock(&sb->s_inode_list_lock);
> +
> +			start = page->index;
> +			end = start + thp_nr_pages(page);
> +			restrictedmem_notifier_error(data, start, end);
> +			return;
> +		}
> +	}
> +	spin_unlock(&sb->s_inode_list_lock);
> +}

Regards
Nikunj
