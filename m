Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC8B485948
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 20:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiAEThL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jan 2022 14:37:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26708 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243596AbiAEThJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:37:09 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205IiVHL013837;
        Wed, 5 Jan 2022 19:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IdLA61kYrixdd5XkScpQ45Y0yDV2QS8uippXMqD1T+k=;
 b=d3P0p9QUN+kTexO5rpQT3gtPp1PzXwXvEO32Z8smd+m7bGVZkr6kCoGpDHiUphu/NQWw
 aaOsos+q3coZhw3kllxZ68bKoK5qDGX+cZvnbh0HsM8m/GH6C+XcVqHDeoAIRgM2kTVb
 take7VGNePNYCwlqw3z7/olEkihBIwwY4h5cdrhPB+kv8hsnvHxXQkbwGKR3kJsww9jm
 g7JkreLQz344vngBNXZmDP9R+Bk9Bp9Pc6PKeORLuwIt63eH2fGJKOBqlH94SoU7M0Pj
 s8zHLypJWcnCoV9rZQd/i+mwou1gjopaHCCrlGGJLYXK1UTDdhGDwuky0Kdnun2C7aUO Ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc9d94v93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 19:36:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205JZnt0149663;
        Wed, 5 Jan 2022 19:36:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3dac2yvc8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 19:36:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNQzAoLV+Wxt8REi0RdpERQmBLj6GKi/thTU1J2BwcCSBoTBjXjUeMdUC89D/P8s1unZerLVBOV60abbaY2MyAAP35MDJwbju4qQc5WLczgS9A1E1hS1uxca8pLnrEd9SiXZCb2sgFulgofju0dUAkMFvMuUUCzJqqGemwcKz1nvfAgNXC/up/lxhYyIegrOJSK7dQqJbZSsEWcP/vGdrnF0/YF/H+Wl2PfSN3cfxY29zoPEuo2ifW8fbk2fnRN337pDuNXaXgPGhL6bUJrt5BTNKIF/Ax5YEJE53PhTmRvmadPPGrWmVHCZKGAqU7N/QXyYBYt8PTb4AIXgl5hwzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdLA61kYrixdd5XkScpQ45Y0yDV2QS8uippXMqD1T+k=;
 b=ioahrc9wiNlp5zoNJ8l9B5KkPYk2+CEsyFVwLI7iaPqDnoDmKIaN3f/s1qE7xTpLYnva5P2SwGJlFoWpNFF2jB98tJQe6F8I6cGjVNAICfVmU/TAdwIWuf2RXDbvtzkLXuPsFFxBdeKex18UORgoyHv8b4HBq9dTnm4E7UIUzng2UTZcyItiRTNGCIdIBC3/p3dtaCW4KAt4Y4xNW58mFTzhFhPFdrMWwQ3lEsJ1Lt2YtljByZELYng4/2Ky/NORXny6fhmqATaxy0G5/3g47isPXQKPOHBcX4Xdr0+m0FJLH8QcI/NDIJkiT5yWZuJyGnHrM9I7VqQbfqqZ+RYqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdLA61kYrixdd5XkScpQ45Y0yDV2QS8uippXMqD1T+k=;
 b=fuJz6fZIwTlgm9lVeJg9CVB7UPSefQp2flVJ1geh3nLH2FhPxlvB8BrYiX4mLghLGwGcrqYiKdGPuaOMg5B5QLiNaiAoCMfjvAWGFzodXpZ9xnqlcbvL7QHUVjtTU314gFWsYS/rtcJ9C1cA6xRBmz4tnuugPr/ZrYBBKuCW+y4=
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4145.namprd10.prod.outlook.com (2603:10b6:a03:208::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 19:36:29 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8510:6e03:657b:42ab]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::8510:6e03:657b:42ab%5]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 19:36:29 +0000
Date:   Wed, 5 Jan 2022 14:36:23 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Juergen Gross <jgross@suse.com>, Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: remove Xen tmem leftovers
Message-ID: <YdXzNw6IJow2CKcj@0xbeefdead.lan>
References: <20211224062246.1258487-1-hch@lst.de>
 <10ec73d4-6658-4f60-abe1-84ece53ca373@redhat.com>
 <82dbdc2c-20c2-d69b-bdc9-efc54939d54c@suse.com>
 <93a8e489-5ca5-7593-5d2b-59280187e2a1@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93a8e489-5ca5-7593-5d2b-59280187e2a1@redhat.com>
X-ClientProxiedBy: MN2PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:208:120::27) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ba2d87f-66db-494f-16b8-08d9d082ab93
X-MS-TrafficTypeDiagnostic: BY5PR10MB4145:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB41459AD1DD56D0C8E47C2981894B9@BY5PR10MB4145.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xC2Vr9uIsb56ip2q8sJD4Ba/mBrQ1IuMS8ytgeqZBazZbvGTyThhIp5zqry3kGsrgq1e4INidc71wrlgsFAl8XbevayDLxYV/TNiPd7HbWNpVBVjOh628Unv9M8nDI+eXEZRdTQO9EMzmvaDAhTgQXW6cJntHa0seQ0alZeP+dx19uP9UUxZGJ/XswhTPFZwOesLK+VJYBfycxaQPLInqAzf0/5c8XwiiB8aJp336jibGXmuOGKasSWOyNsXwJhHQWFergoYcgKaoEzQmIJDXpyCcc22WuV3ksdjrbwYFAuRQ73T+4ixbed8LTQrzfn9xEFaghAbHC1PLQlhpTbSXYCHNpT7Sxd4MCKhuwVLNw8saAqbJIMjyZaWx845DsiClXeybdvSuyI6CA0sZ9kG1vI5+LiqUMSshWWdp2lVrPSeEeD/6PgvOBfBkfW4SbkOW8xasuWj4v9NnqLScm2MsIOLfYeghwyz7ff7EUqXPTG06XHY58ItlF/jTDi8Mr0N4OV5C1hMbzP60pXoBnYOILNGOBoNs2XZ6Z9sHwAzUMCKi3xZDeVYSYcwval7LqvMKw4pYKGIA74JdkwSeIoOG9FjmRqhIOOG5fOaMhU58eoVhCAmeTuO386FtaF0ARObcwK0A3Ksd8yWWogs7nfppXhPyNXOjj7UTHX9U9dsx8mS6u7zxRZS/l9akV5Gc0E2EIT2V0tnLCa9tSnxLcOziQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6666004)(36756003)(86362001)(2906002)(4326008)(508600001)(52116002)(186003)(316002)(26005)(54906003)(8936002)(6916009)(8676002)(66946007)(3480700007)(66556008)(66476007)(83380400001)(38350700002)(53546011)(6506007)(9686003)(6512007)(38100700002)(6486002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mxtjQ6MCr4xQ7v4eiX5YUTyYWkvI63bVeX8e90N1sx7LOFL7HNy4yVd/ZEYn?=
 =?us-ascii?Q?K7XScTTUQXqaQQH5EEbevnFyQqGSHU1sXG2Z2+dvCUWvCQ+zB620SbNnm5AR?=
 =?us-ascii?Q?CBnjgUJ5kcjRJTfdMCe61ThJOPimtB8lpdzPg0WzrqFGA7CTzMoWeCPruwDE?=
 =?us-ascii?Q?LBRaLc/F8inkk3G7t4inXW0fSpcvVtyEWqGvPX0s5jfZeYFni+Tzlke5EtNr?=
 =?us-ascii?Q?YIFWbgaKNo7AxFmxd2HzfgLeCwbUeZcG5teFI0MvcHoVio+s7GkFGCn7Ez3/?=
 =?us-ascii?Q?XQr9obDjfuI+ulK2JGSBRszLxxOdKV3y99uXWLZ/E9EbWtqREXMZkGbIZunm?=
 =?us-ascii?Q?uFqvCCPjT2KM3ToQFOz5TppbMiNafdXUSIDvTKszUenfnxOSzN1YxQYs89iB?=
 =?us-ascii?Q?88Uc7iVSQsl1q6rnpMpKePp/+ZDLieOsvLDh4NFoXo/i7iUUFYR/eo4mdPGb?=
 =?us-ascii?Q?CbRp6DdlTnrExHa/Tc4E56MX6HcbkOyR3YTvkDxNvh9yq5WaCaWdr5FWyKmm?=
 =?us-ascii?Q?TJRP/BQvs9BWCp0819lo7WhGdn1iU3yN5iPojQAKeYRYdWdj2YxtTCSkggyb?=
 =?us-ascii?Q?xtNsFCZDmPgZYTFZ4E9pfUVKCt81LkJvYNLaQUN4nmW0lVxDqicUHEtZUabO?=
 =?us-ascii?Q?0HXcK6z2g6U4O389i9dqJqlUNiCd+MNjPqlVikxQ2L3yqR7ZHqbqNcNcA6J3?=
 =?us-ascii?Q?vg+4abYiPzTn7pYiaBmypBX/bfzk748cul8aDLRbJ9aLAf+LG7awQXMeewLR?=
 =?us-ascii?Q?1fbWNHf6Z3jl77rWzwC3GAswucuzEEE9IqQZv80lZBOlcCbZo1rj6i4Dor8S?=
 =?us-ascii?Q?slg7DnN/oajLrbAn9DaowZPTMy6mFrK9SPXsZTkKWBaKPRZGfzn+bZp2sGVf?=
 =?us-ascii?Q?Nj0qQ8tgoF6RjHjtwgl/VPYPm8LCkA20Lq6Zsv0hun9lEMyoom5g7XwJy9zB?=
 =?us-ascii?Q?XQxtvCxFkwpZ1I/GTG0c1h/+e5oaHPPeoaK5o/wOPS5Sjz7TO1ESR1fR/zki?=
 =?us-ascii?Q?+1cv40C45t5EYPP+LgYwn4Kh5j/XgUyXRJtTVVg2DiYgFLBsZ5q7DmhL9ob8?=
 =?us-ascii?Q?oNVmQ9QKfDYtAjZLRkDsK6BjeKaqBUfWvXLHg5ZJakS4nN4hc8kGvthyCu+6?=
 =?us-ascii?Q?0eI7lkODUkBHyGIL9Zf5eYA4u/H6SR36ZLVUMVS7N5Y00AS+geKbVXnfD3kl?=
 =?us-ascii?Q?ixsIq8I9avJoLgEVJoUQNhT9uqKkv6ZJw7+oEPzpWqrdSEa2dgAqLpjnfi8z?=
 =?us-ascii?Q?uqC/v03aZOXUdqnmf0Ta3qhg+veeevVArIjxpDSE5mEhYddEKquJdN5T7FD4?=
 =?us-ascii?Q?EL8wmFuAAKerlhy3xZXM7kHc7QLDmm0VP0/ffhAcxp1emUDN/x+vikhog8gl?=
 =?us-ascii?Q?cyOH21FrXJy9ODsJVpU0cfcCwg3w50jAo1+3H9iZLvyv5RYIjGOfFRpd21QJ?=
 =?us-ascii?Q?/kO04eahiTxmeEwpsso9182fChioIueyFKITZB5PDbhS2d9ASx6ZJsbH9n1t?=
 =?us-ascii?Q?cXh0YFzQawwii3BHgkHkfFx3v4s8nEFhWrAgUsCUxGfYZanAuEMApHRSH1Dv?=
 =?us-ascii?Q?D5x55sw1IaxpqE4wBeZ++7z+krcSa3AJAF8B+v/bdoqLGj2D8B0siEpGenO8?=
 =?us-ascii?Q?1bhqOysQ11MioS/GwYbYcYo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba2d87f-66db-494f-16b8-08d9d082ab93
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:36:29.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61mXD5QQjp4vSkCy7bApfVgOy5FDXVyKCxxA5jNQDWSGewQX1azIJvVTCPLSpLbHjdfPsYBS06km2xRhgPbSiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4145
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10218 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=565 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050126
X-Proofpoint-ORIG-GUID: 4Z-5cdxwMOK7tJtg_DDcABaKYUK9yUM_
X-Proofpoint-GUID: 4Z-5cdxwMOK7tJtg_DDcABaKYUK9yUM_
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 05, 2022 at 09:46:05AM +0100, David Hildenbrand wrote:
> On 05.01.22 07:08, Juergen Gross wrote:
> > On 04.01.22 15:31, David Hildenbrand wrote:
> >> On 24.12.21 07:22, Christoph Hellwig wrote:
> >>> Hi all,
> >>>
> >>> since the remove of the Xen tmem driver in 2019, the cleancache hooks are
> >>> entirely unused, as are large parts of frontswap.  This series against
> >>> linux-next (with the folio changes included) removes cleancaches, and cuts
> >>> down frontswap to the bits actually used by zswap.
> >>>
> >>
> >> Just out of curiosity, why was tmem removed from Linux (or even Xen?).
> >> Do you have any information?
> > 
> > tmem never made it past the "experimental" state in the Xen hypervisor.
> > Its implementation had some significant security flaws, there was no
> > maintainer left, and nobody stepped up to address those issues.
> > 
> > As a result tmem was removed from Xen.
> 
> Interesting, thanks for sharing. I know tmem mostly from the papers and
> thought it was an interesting approach in general. There was even papers
> about a virtio implementation, however, actual code never appeared in
> the wild :)

There is a repo of it .. I can find it if you are interested - but as
Juergen mentioned - I didn't have enough steam to finish up the security
rework so code removed.
