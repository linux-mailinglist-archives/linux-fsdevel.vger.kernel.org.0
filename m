Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61404C505F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbiBYVLc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 16:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiBYVLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:11:31 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E28E1A7D9C;
        Fri, 25 Feb 2022 13:10:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ix4C9Twpq33J8usHZG+gGyKhQZK61WbmcbdEeliINRUAWzKk1hvx+Xb5AKBXPOfU/c6/XIgYs2WVPki+Z5VOMnPk5OSLl4+Y5CRke/o0cfYbOgPVuWQze4Eq3X6d39isAK8K5LzuVxrmQ3Gt265uLrEwyFOVLI+BQZyLbzl5d6X2AEqJTpRLsNlJjLTue8K4gJyHRNbD819ZSt4Tu/UG/0SxBPcIA8SdpFP3qxw4R/ilr10385OUNTCvkAanL+hkxtgn14tl8QDzSG7LHSWgrGtQzSzPbDthOtB0eEkb1eIQcallMFpA1Ohca7o2WWNkNMau7K+xvzDWyp87t06b3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MD5cg6JKU0mYK6vFhMnm1JAZ+jAdinV9tBGeqxkB0Rk=;
 b=YK89wqxf38quqQGAbFSpwXdwkXXuEeldhsdPbcKhcTorMSn1QssCTUKcjR7Mwy23o3HbvBXSfnp19MaTwr5X5oBaSxQZ53q740bNeD1YDWQFYJdr5VreBqUSIG9G1X+dIOtB6BXBcdJgWFGtWW+qI/1G59JG7ksH83/clpcUccPJ7keFkkL8nArfFBlzkinNr7ZbFjzF+9qTCgPJ+y1KmLovlxNj37s6zfaXZtdzFiQzMY8e0TGtcY7rtA3sat4WR39O8aIH/qyrsc9NO5KaieM7N3C/Qy3JSuarE3wsk556D9mZFxyXX0N/vjGMnDZMy/qJa4JhIgUUfYGxkR233A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MD5cg6JKU0mYK6vFhMnm1JAZ+jAdinV9tBGeqxkB0Rk=;
 b=MoKM0Y224/R6sFLLOFqfi3AflKlLfRsfISUcPD6IsUP+pE+gpxh9zu+twsqhltmYSuftTrz7lxcuJqhWf1/w9NQCO8QeR73Fmj1CG2izVsa6PuAwpvxDfaF6r8HCjZEAyPIL0xVcByqG5TRizKAS1COhXX52RMGyUN1hECZKrLSIG5oaDzTfc9seVnpsbmQ1CSTDF6ZP29IQ4gJAgy9jNtA5wksJslTr3JtEWxnu3KqwljRz3WqhvC83FewrhjnAwchl2CeKhGqPcyfdk9IL3egcDbZAxeOhurpwinYs6EL6i6mQL9iqY4gGOUQRB0xrfl4n9d40sY+d2wT4SF+W3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CO6PR12MB5441.namprd12.prod.outlook.com (2603:10b6:303:13b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 21:10:56 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::498:6469:148a:49c7%7]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 21:10:56 +0000
Message-ID: <9a39e80c-d68f-aad9-b68d-6e578d7b8839@nvidia.com>
Date:   Fri, 25 Feb 2022 13:10:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <ad29be74-d296-a9fb-41d7-00d2ba15ea5c@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ad29be74-d296-a9fb-41d7-00d2ba15ea5c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e30c5636-7311-42ac-971f-08d9f8a3508f
X-MS-TrafficTypeDiagnostic: CO6PR12MB5441:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB54417F6030CEFB253379B290A83E9@CO6PR12MB5441.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Krk71xnI0UDP9hmNdyzScBF479LDq7HeifzS+F6zVgMV1l9AnAV6pRLeia89B08mFTrYxQRWyv+kQKsWN9u3vAk4PH1Oh6soVpCMLe/tGnG9x7mF3nTqdyZW7W+hPZkd3hg6DfWE8OgPVr+RLeivQNNOZtbp+keP5TLDtQ+Htax0Ikpx9CWyP9KxyZQKasPIselw9eTaXf1R+0JepgB/CHs309sw9UpzqCM1RzlXyLokpTw2uAmCs3HbYBfkwPXbgKz5DclXSy88oThBXZI4AIAO4uIczevR8tBNj1tw+6qTR/YI+LsqceHiBISiRRwIrmKpJ6Hgfps5MaWcmPPmkHYykMCHTcXalUlr8sYRNmthXCY3YQYdOniMIhe5UNo3fj4Tn595pfeIR48EROJdA3eW7bKeS03ZbI0Q+xVYScfQCgWaSt50e+JCAj4XfGp2rOhw389ULP6vK1EIO2UEGGj1UUx7aSy4D380JpWq7U78KWzn43JbHjK6sU2De8SV7zeSS/L/HTelqw0Dp4krDT+Z2c77EDfqUDRmGrWz2QkaTileJTyZpnrOlaOhDYEkPfxbwzDiYWAb06i3UwshpSUx9LrpG5/zIom03ar6PxTaRU+Cn1E4GAbQqHEaAMEJNl4Qjty9BvdqTsaWnzDmD1gGJezmoh63zpwfpBcPGLeDBmDYuz93+UqJwS3T6aL4PAsmPMED0P5bKRH+TVzBDxt6lvyZayMp3elXFt6W0vGe2bSzZEkoBuL9gn+wmCxHQrgEgYIqrso3x7/SqXtNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(53546011)(316002)(4326008)(6636002)(8676002)(110136005)(66476007)(66946007)(921005)(66556008)(38100700002)(31696002)(86362001)(508600001)(4744005)(8936002)(26005)(6486002)(31686004)(36756003)(5660300002)(6512007)(186003)(2616005)(6506007)(7416002)(6666004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlY3SWhhUm5XeUNRTHlyWnh6b1NGSDREYy9NS29qRWRqSnpDdW1UR0VSNmhP?=
 =?utf-8?B?TTNsOXpadzR1aGhUb3JUSG40OHpSa1I0eXdVQWZvTkp5bDJCODE2VUlJc21o?=
 =?utf-8?B?UmJUTHZLZUlUdkh4aFZKd29GNGtSUWgzTDNjdkk0ZjNYQURBd3JHWnltMTFO?=
 =?utf-8?B?TWRqWkxONGJ1Nkx5VmR2RE1DZnBJZGNjYVNzK1VjbHlsYzVrL1ZDZ25wOEhv?=
 =?utf-8?B?bEdBSitPYXJ1ODR6M2VWRGZXRit4Z3RtcDVHL3Zkd2lEZE5Vb2JrVFIzY1Zm?=
 =?utf-8?B?NXQ0UERDL0Z5NEFQOElKVi96SXJoYjB3STAyeE5HcWZFTnpmdGtxL2daTThW?=
 =?utf-8?B?QnZnQlBRS0pvNkxXMjE3VDNZT2hxRXk2RjlNa1JNMVBNRDRoNlpJbTRYemM4?=
 =?utf-8?B?czFRdERiRWFDSndYS1ZTM2NOb0R0QW90L2tJQUtJcXBFRnR3ZVpadHhFUzl2?=
 =?utf-8?B?NlpMNEVyZUpnWm9rY21uc0dvNjcreDB4eEZCTS9GRFg3RitxWE5CUzlFbkt2?=
 =?utf-8?B?dU5DeFpMYmw4NUdxV21RZmhYNEZkc1I1M2NNcGZNWlUyMGI3OXh0cGZXNFBi?=
 =?utf-8?B?UjBuK2tzdGM4eGZmZTlNaUxIZzVYT0hzS0tyb21qcWwzNVFiajlHak8vMVpt?=
 =?utf-8?B?ZUpWYjBpZk45TmxnaFJLTVlMdlFIUk1LSEhBTlEyeUpnQXpHUGFwZlZYRThT?=
 =?utf-8?B?MWFnZEZNYWVhZFFVSUdPNW1XaG0rV0hVYk56aVJJZ01VMkhVeVBUc2NRSXNG?=
 =?utf-8?B?MUFCR1Q3NVhaUjVyUHQ1VE5qYk9DZ0xiTEt2UjBCQmZVa1k2a3NvcElVQ0Nu?=
 =?utf-8?B?c05jSEwydm1RNkMvSU5qMGZGeVhVcXc4ZERhaitLelhITzJTc3FObFgzc1k3?=
 =?utf-8?B?bndLSk0yT3lhMnNDNmY0K003aTE5RzBhMVduanh1Y2ZYUm43RHpxS2kxWm1r?=
 =?utf-8?B?U3hRay9FODg1YnZmSUpwSUllQXZCNmdVL1BOVWtYWWxGNFVzRWhoM1RhK0pV?=
 =?utf-8?B?L2xQNFdQUitCSEh2MDI0SXpReVpLRm90dUtPV1lab0M2ZCtBaHBwRmUwVFh2?=
 =?utf-8?B?K0RObzFRaDhFKzNJTExWL0NxY2lLbHZtRU1yVGJHc1MvNHovRzVCRUh0dkl2?=
 =?utf-8?B?ZE9HRWRSMjdibk9RQ1N2TFVGNUQzS2VmeitCN2d3SUtSdEhNV1VaR0tJZUk4?=
 =?utf-8?B?YzlFd3dNUlZYQ2dabS9JMHo4Q2xEL1hEOEdQRDZpZzM0QTFKYnZnUVdONEg2?=
 =?utf-8?B?QlFJUVBXS1BKdFVtb2VPNnBZVlBxanpQbHFubmVnUldxZS9PS1VVQU1RcWJS?=
 =?utf-8?B?ZjI0YWE1MnhIcGhqTC9uN0pQSzN6UlNrMmliaWh0enBUOEFZdm5xWEgvSS9Q?=
 =?utf-8?B?eW9vVzBhdXNlY0M2R0lQWVk4TkVPN2Fza0pZdVB1bTlpUXd5WVZ3a1ByQ2Rm?=
 =?utf-8?B?RjlxOUFudU44Y2ViK3pMNTB2RTRGUml1djErY1p0SW9ZSHNuSHNEQUppODZx?=
 =?utf-8?B?RG1SZXFDcnBobUNMbnVhS3RzRm84cXZ2WFVYZFRxdlhDNUFGRE00Mnp6MjZo?=
 =?utf-8?B?Q0VuOTlCZ01zZ0JubFpBWmgrbWdlSFpuU1kveEoyQ25wVHhmMUUxcTdKRlUw?=
 =?utf-8?B?T2RHdTBwQU5NeHhMRWVqclc0WXpTTkNJNGFFaW1KLzNiZ1p0emE2cGZFSHdr?=
 =?utf-8?B?Smk4ZEVUa0RtaUFDNnJxMWI1ODIwYjFSWVdERzZUaWYxYm9NOXIwWHFCRGU1?=
 =?utf-8?B?RklRZDNiVHloekhJQmlwOGNabm1OOTlzdFdIbGk0eGp6UXJ4ZVIrWmJ1MnpT?=
 =?utf-8?B?cjNUQUhwWlI5VHZBelh3SmV0M3VnbG81dEtiNERhMCtRMDBWUmtiN0pqWmdG?=
 =?utf-8?B?QjUvK2doL3A5TUtFZHUrL1d1SXU0Z0N2czBlbzRHTFVtZVBxRmdWSi9HSTdM?=
 =?utf-8?B?eVYycE82M1RqRjY4TWNWUEsrZzJFM2svM3RGUVpqK04ySWtFQUMxRkhHUEZD?=
 =?utf-8?B?Q0hEYkxJZ1h4UXBaOUpnME5tWU00YWxFem12bGMxVDZJYnJ4N3lXa2s1L2ht?=
 =?utf-8?B?UzhSQXFueEdBVVM0YTJaN1l3bXB4L2dQcXcyUmxFb01hV3Y2MXhUT2c4RFlq?=
 =?utf-8?B?eWdFbnIyd0FnNWF3Y3pkRE1IWXhZY1JCa1pGdjFtMzRKQ2owdmRDa0V3d1VS?=
 =?utf-8?Q?2drpYRI6pwWq4DDHa2V1Jgk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30c5636-7311-42ac-971f-08d9f8a3508f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 21:10:56.6768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kahZTN2gpSVjz97PtWcxNrRQk2L+0z7U47WNmmg7hC5f95AvpsWdxVZOS1Cxsy3Mv9EQaYpdm9egu6I4Qz2Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/25/22 05:12, David Hildenbrand wrote:
> vmsplice is another candidate that uses iov_iter_get_pages() and should

Yes.

> be converted to FOLL_PIN. For that particular user, we have to also pass
> FOLL_LONGTERM -- vmsplice as it stands can block memory hotunplug / CMA
> / ... for all eternity.
> 

Oh, thanks for pointing that out. I was thinking about Direct IO, and
would have overlooked that vmsplice need FOLL_LONGTERM.

I'm still quite vague about which parts of vmsplice are in pipe buffers
(and therefore will *not* get FOLL_PIN pages) and which are in user space
buffers. Just haven't spent enough time with vmsplice yet, hopefully it
will clear up with some study of the code.


thanks,
-- 
John Hubbard
NVIDIA
