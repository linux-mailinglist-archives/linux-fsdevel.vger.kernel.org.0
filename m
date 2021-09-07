Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818C9403071
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhIGVqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 17:46:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49902 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230427AbhIGVqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:46:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTtVu018137;
        Tue, 7 Sep 2021 21:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=H0I9ZxA8iDXQ3t4mptXyJG0+26+le2hc9FNcx6qluD8=;
 b=XbVEKiP7spA/t8e7uYREgbdJG6d21Z9xb49knCC3c/1yi4x35U1ZHgnrxinVWMlX7om4
 30w8J9zCFZub+mkVWw4hlVuHgXQm24Cu13HLpIJ6Ntqa+LsVHBCqO7kwlGFiBsMTKWq5
 k4PtvvLDbQPRKRHwKHFO1Sq1MyP9dh9+F7qYwMGar/aLsZp7QyWZbbHthCY5c2z+LDkg
 lfOmieoaEWNWnZ72wYClqY8Zx1+r6eZBvHuF67eAPhXbQS1VQlxqYs/bXvLj7N0NgoWd
 64v3H0RhZye22TMry8+UEmT2FH+s/17QpEUNQKGvWEwiCJ3INiZO3iRkV49dR/UQEPk+ Aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=H0I9ZxA8iDXQ3t4mptXyJG0+26+le2hc9FNcx6qluD8=;
 b=IdzdXetVR2K76D4AhYcZaOX0fdpvUApcQhqELS3NormBfZSzhQkQ0emPiqEGa4OAGhD3
 fcZzzlSU4keaHNzPE+Z0NoPKKAVxcBNSf6ld1uz9yBMH4CGBHNJ76eQePPDXRqO4fRX5
 q9t5rr5sBrw4C+CrAdiDv6PHDTMI9tDMXHE8RvSwX2KVVNrnKG2kL1dvoknG8HfFkMss
 ls5DW/ZfbdDiKpmXgyxz3IumA1MaE5b2PtJgXqXBE3BdEXZg6cTw/kIzvoKyhzQEkU48
 n51ruDE8FXbvNXBPup8EUofTs1mmInl9ayXCZhK0nlLHqOL5Dyh+hvMimECxQhBpL3jm hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcs18jkj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 21:44:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187LeDNv009468;
        Tue, 7 Sep 2021 21:44:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 3axcppjnju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 21:44:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMGRb4aAhwyRjj4ZOvgfMCcvuBrOw/f0Dh357doIbppYPRkIvGmKlvPFolBPL/STwnip4dJn2F505xYBWyLqj1Ptc0TWp/ulFfM6/sX/6LWQ+oO7123QS25wvEDGXj2iTwaRab9AaQpyfgj+FJdlWYwqwsiQ4fOx5o9e7VGyueZimNj+EhUHOafre3xjDYGc4LjRr7HbM3MpAsCXE49ZIurCO96/Go7ltgAyKvPHt16T4L5nNoV3yx0lBxbqruCZp4825K7v6JzwFtz73hslxwnJ+FIHz1b/S/x4Bn4mHU1ij90tMzPTtyyYdK278dWC3DVFyekisLWygVQM1/CbRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H0I9ZxA8iDXQ3t4mptXyJG0+26+le2hc9FNcx6qluD8=;
 b=RGqLwRl/NatGp9R0rHf6r9NpFX4TTxfZMGTXk+8KAYgSVxnJ2ls+4sPlzPeUahActBoq3jfitQv188mEHuKfSZmVRINHvM1xYEEeGCDr4QzdOcRUUBDsB8DtdjUa5Gy43vxEaJzK2u2AOtcp4a7B2GlKr5I9Z15RGRtcD4/lap7JnAMuLftEbyybUgp4oqO+dhDw1nLx6xykCZHY6vFwxT7KbiSjcTkgj1izxDkhL4F6YIDwZRe3X4fblDSTXbiYIlVaHevyq7QQRpFOkLtYKiwsuADo3yEtYYkPwwis/JFWuYG7cpbeHmEnO5Zycu3hfB8MMsgTp85rbvKGQ6CcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0I9ZxA8iDXQ3t4mptXyJG0+26+le2hc9FNcx6qluD8=;
 b=HeRWOSSx9CZMHCba8yeYDARSILClOYEp2EDANPBKp0FbcX9HmN8YTdhHDaH7PpPTzdLZkZr0abKTJqB9SIRB6elKaF7cx3lZoKGGTTMmD76u8p88jg4IufGMTFmSdz4BhXdvOwVWp+7tLqYrnh83914d5EZDWeLbLmF8tAaWP38=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Tue, 7 Sep
 2021 21:44:52 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%9]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 21:44:52 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] namei: fix use-after-free and adjust calling
 conventions
In-Reply-To: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
References: <20210907205043.16768-1-stephen.s.brennan@oracle.com>
Date:   Tue, 07 Sep 2021 14:44:51 -0700
Message-ID: <87r1e0rrfw.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0064.namprd02.prod.outlook.com
 (2603:10b6:803:20::26) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.7) by SN4PR0201CA0064.namprd02.prod.outlook.com (2603:10b6:803:20::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 21:44:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35cbdf6-1d10-4eb3-2ae4-08d97248b996
X-MS-TrafficTypeDiagnostic: CH2PR10MB4199:
X-Microsoft-Antispam-PRVS: <CH2PR10MB4199F5B40B65099A9D977373DBD39@CH2PR10MB4199.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzGgBsXaiBAE6cBqPmAV8KCW1lrYOJbdupXFBQOD4H4vvGP0LnDRrG1ulG+AOCRsfpjt6GZjpxoy9BGuciI+T1tQQL3LgU5Uz3RE/SuVbt4x4sLk7WTlOB8/PXU4f+oR4l51g9MYm7JjAwueYKSgCt/wCRJaLqyDIzoFtCmR4044LFc81TUfo4hdXQPk3CjYLaxmqbgilw7MnJsUOmkOClrXOuwvkeknfCzqcb/DFJlbj1A6PxxyEV5xShgTq89+Bvre9GEu18RfmHATuaZHdBe8XIWjclCZZYyoNXzUEFkCGHCuK/Tcz5YwmiE16RzjYDToJVoPUiFQ+ylwEdelrjyQbqatKlHUmmi4eR5+zJ0yejst8HfeIG1iKPmTbgleH8d84YvvU0FfDeBXz/Mcf/LRGrdSnwEXIwwEd65I6YdfL/5eVzzz13CYU6RtFMthi7Nb3/UN0de0AjAHHE8q8OtG/Lms/RRJtPdVj/wYe9vJy3ND8dDagIAGyz7Zf67J2qS2ChR54ToGwxIzv6fW5Ci1seh61VnbHlPOs3ePTtwO7FaAMSG4BIolUQgUkMvm7IQHvUEBPe6Zq2ZcaYuaQQh0pYlW4U/DyfWsk3fy7pqNwf2xG4KPcGJq+C+wPAY3/LK4nSnrxPXkxCK49RovMGKhUIpnpDbBmKAri756tq9dqhtXpMG9lxzFoQ3R1XlF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(83380400001)(6496006)(8936002)(6916009)(4326008)(5660300002)(66556008)(2906002)(52116002)(316002)(66476007)(66946007)(478600001)(26005)(6486002)(38350700002)(38100700002)(186003)(86362001)(956004)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MvqbMbet8c6ijG2cc2CqSbb+jp267B1iJwrdbNXxHviYCdtIhfU13rcS3E4L?=
 =?us-ascii?Q?xfUoxE7TVVSdDVIQv04FTOdurtk6Useaq2mykUaknwLkYQk/AzandTCZZJOP?=
 =?us-ascii?Q?oc278dszaGUE54ucnDbObyLujOPp7Ru0RH4Z4i4NWN8D1Be1crs1unvSvrtL?=
 =?us-ascii?Q?JMOg3tBxfATLMyicte3/yZqEsKCRySXgLDj6lJEet6R7wwX1B4G+SN++9PxC?=
 =?us-ascii?Q?5mSTD74eLVOhyDDJTTFAj9R1PYPp2i4G1AYkCuZMxa19PkRTwiXZ1JL+0fkN?=
 =?us-ascii?Q?/fPNf7S3kfcvlrIjeWfv0gkl5sSrxPPiI+OT1Eu3U01/AZzm0vrN+gY+IcrV?=
 =?us-ascii?Q?AB+cvkkw0OksyZy12FwdpkZ9At9v3IRCbmYhmKMOQjt6sgnCd/IY+tdPo6Vf?=
 =?us-ascii?Q?PtPANgWV3mRP5LCVa+7c+9GzgnJk8tNgkiJBoQT8VvS7rLXdHbrTULul1bQv?=
 =?us-ascii?Q?zEZ3tPtVI7pJcFOAmljj9YvVKhc/Hr9FtpM6whqop+pAmK3zEf9mij0zieq/?=
 =?us-ascii?Q?Tv4KKFHI05cdIlgLT82WwdEQxys1r38RvzJRUlhiSBIgoJc0tDXg3gKoZEUF?=
 =?us-ascii?Q?zrxDe0rEKKiyGWht5PJGMNDqLTX8goIhmIVffoIDX8x2YCc6S2DWZGw7AiOU?=
 =?us-ascii?Q?WRR2RWnjrmezQ2yE2kqZV4GlrQSe8IFYO4kdiLQm30aoaL/k34rDRzKi9OPA?=
 =?us-ascii?Q?U8KAe5orybblHLiU+RmTkPIv9/FM5caicMKMxrcKJXvkfd2LG2q+vHM4SCbc?=
 =?us-ascii?Q?gLUcUX/74fzpEk8AL3EtngW8IzHJrNfNX7E1cVfDd+j5d3Yiak1W7d6CS2c4?=
 =?us-ascii?Q?ijve6mWlYsy5olTTCqMfyhY4e4iCuXBLjOs7auMTWj1Nz7Fkk2nkRPIVeu7z?=
 =?us-ascii?Q?+n1+YBCyO1cuuxadJ3X+nGFySe8QkbEIwf28IzNLN58TUzjgPDkYOOpTDWWo?=
 =?us-ascii?Q?36x5zlxW8pchexjwnBlSN76buLbz+KjHPlq02HRQZgtesHHKd/HuUUIQemX3?=
 =?us-ascii?Q?RRlxlBAnYAe+WgAqOSVAV2znQpk8NfBgVImGisky+rb7580THuKTTuJJOdpZ?=
 =?us-ascii?Q?Sth6oe6wW0ybMIP8q6vXss1+oqyS83xv2dvgUroe8FGH99rrbIyC2UnBo9JX?=
 =?us-ascii?Q?AUzkFmNI68fC1JOwCbL5gdao0x5WHFny8AyhwYLx9sgpWY9/SWAVx+NN4Knf?=
 =?us-ascii?Q?Vo+Rn4446aT4PcjHfFMvDxJ8zSv9WOcicQunMMpos1ApDqWRwyp+BDhHYh/K?=
 =?us-ascii?Q?srQ1xBPxvA3Z/wDZuDHTeXNmJfSPVPKfDuNyUUFyun9wC9PAwIW1kRo2Va74?=
 =?us-ascii?Q?nUaGqefFWyropQIUcIEg94Ev?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35cbdf6-1d10-4eb3-2ae4-08d97248b996
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 21:44:52.7604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nyx86XafqHds+OlsSugBGdZvTAylgQGJqDKgCdPiFLWaA/hXXN9qheoNixE8c61Dx9D1AgTfVgRvOCaZJW0TCpAE5w7zQ6iA5r1hDRsWFOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109070136
X-Proofpoint-ORIG-GUID: A1iHeVVWqay795EXZnpDGoIAzTpB9Cob
X-Proofpoint-GUID: A1iHeVVWqay795EXZnpDGoIAzTpB9Cob
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> Drawing from the comments on the last two patches from me and Dmitry,
> the concensus is that __filename_parentat() is inherently buggy, and
> should be removed. But there's some nice consistency to the way that
> the other functions (filename_create, filename_lookup) are named which
> would get broken.
>
> I looked at the callers of filename_create and filename_lookup. All are
> small functions which are trivial to modify to include a putname(). It
> seems to me that adding a few more lines to these functions is a good
> traedoff for better clarity on lifetimes (as it's uncommon for functions
> to drop references to their parameters) and better consistency.
>
> This small series combines the UAF fix from me, and the removal of
> __filename_parentat() from Dmitry as patch 1. Then I standardize
> filename_create() and filename_lookup() and their callers.
>
> v2: Fix double getname in user_path_create()
>
> Stephen Brennan (3):
>   namei: Fix use after free in kern_path_locked
>   namei: Standardize callers of filename_lookup()
>   namei: Standardize callers of filename_create()

Please ignore this! I missed some feedback from Al and will send a v3.

>
>  fs/fs_parser.c |   1 -
>  fs/namei.c     | 126 ++++++++++++++++++++++++++-----------------------
>  2 files changed, 66 insertions(+), 61 deletions(-)
>
> -- 
> 2.30.2
