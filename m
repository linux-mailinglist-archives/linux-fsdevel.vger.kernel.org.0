Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0104215A8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Oct 2021 19:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhJDR61 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Oct 2021 13:58:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57578 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhJDR60 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:58:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 194HHIJg029416;
        Mon, 4 Oct 2021 17:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Su39DftLFc0yzqusKUcwd9c7N7R9oMB5xQ7URt0UiIw=;
 b=LgutBvrBd4rrne+U53jAc2eaZoYMHLgn3qwvx/lPMMU77h97Cv2N0TIorWc4awYiPAkY
 JNf9JGwsHgYu8Qv+fDW3QvjoFCqQ55H+N6eK+sfJYEsLPsZiV5PjNMcl9NOhJ2MFYKKW
 HQmaKzt5bIkHtFSyOgCZvTSBzJ9nugTAn3bBKK+DXf42Papf6rWlTWq68WkyJ70LOUhE
 AkQSmE6kWra5spv3pHmGNNorv9iqgAHVVVgwB9qleeRlg+kpWPwted2zvjYLMwU9jgYr
 D1u59uKvtfSxJ9dl7JWMdD4w1Bhd1M5O+fYlwDXNEyvkubUyO4hNGfwGQV9v7QAYfBQu IA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42khdne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 17:56:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 194Htsiw126619;
        Mon, 4 Oct 2021 17:56:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3bev7s1f9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 17:56:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPhdsq2d0j9tzBdHDqTt07fTYB47At4Ba1yXT7cQSqhSOMKOCe65TM8v4+RT+cWCmpdqWhvTbcwc2PFkJObir6vjtFKjJxEE5ExeSi+YXcBBFocVZB9jtpOTRZQqOZ2jauLXBq7iclNTGl8p3GOxFVI+XrTIIkIdRPQvRNn9xDhug3t9NEL3sgaJ/g2Rk0b3uYnyTHHJNYForYgyKED8jZMhdTlPVJyeywyD+E0oT8YIeFpS6WKqrpYn8YUAWG5sqdFdsqZ/Y+bdfKAgeDyxwncg4GrMNLpLCjGyONIrSbQGRUPaWaLmow6jD75MarNyIyceyuFp/aWjbQECuCFbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Su39DftLFc0yzqusKUcwd9c7N7R9oMB5xQ7URt0UiIw=;
 b=CbJih/GjYwi9qXSDA7kfwqzb3bZ0t+2rFo3DWE+Q2YDBFcAg0mF5mbhhaJaAm5IHQfFgtqwtVeM1OBLwR+tgAWHmD0NnjI4puKjogH/oTl5Tq6zi5v6wWwyWS4RQT+KdoNMG+uyJp4PZUbc3hJH2bcdnYXl3Ic01dQ3JMZFzkcduhbfv7BhpnB7rpjHkvhyiFHlhvtvblKJyzuH5jvL48KkwICC7FQ/DViCBGHrDBLPuPT+LLzzDLT6wacL6/x1AhnVJQzjfFl/4hm4/jqvJefpG9Otw8mPPWDiWkaoXl6tewkbwDvEmPDAfHMWjevovESNcF5BHo/kmN0lmDKbt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Su39DftLFc0yzqusKUcwd9c7N7R9oMB5xQ7URt0UiIw=;
 b=dMxnOdkSA2TK8YjF1567Q0/2x13gv54NGY7iVg4ZpmdMBT8dlNCHYSs8TKkRJ/g3otWX1M4cXqKGz2AkTn0GzllULpMHUe7SzOY6ChmVsU9l1FmNkHtga7feOqHac0dqk6jYYFcE5UWqnX8BrZ8a6L64mrfisw0HV83dP/BXEx8=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4841.namprd10.prod.outlook.com (2603:10b6:610:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Mon, 4 Oct
 2021 17:56:32 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%8]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 17:56:32 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Konrad Wilk <konrad.wilk@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 0/1] proc: Allow pid_revalidate() during LOOKUP_RCU
Date:   Mon,  4 Oct 2021 10:56:28 -0700
Message-Id: <20211004175629.292270-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0110.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::25) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from localhost (148.87.23.8) by SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.9 via Frontend Transport; Mon, 4 Oct 2021 17:56:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25f20044-55b9-422b-8c8e-08d987604c60
X-MS-TrafficTypeDiagnostic: CH0PR10MB4841:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB48414318285DC567813DF29CDBAE9@CH0PR10MB4841.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SJ6WixQSHftAfYLE9ETs/tH868JdIp4mHxb/KGMPNpZnQLevRQm5ZS0Jmzti?=
 =?us-ascii?Q?a9EaAaVLToXicP9Fkr0j2XL+a23tr+siT1YWHiXixAcpD8WcSl6XraVzBI/A?=
 =?us-ascii?Q?cAVR5sx0aAUsJ6dzoqDd90n97kOT0g4Qz7sXMjIbW+v8WGz/V283SiD+bAT1?=
 =?us-ascii?Q?6Qr504ZbtmWfsW2NYO00wz0TJhqRoM30R7wtaCixGFvhBw5+BZzpTsFq3AR8?=
 =?us-ascii?Q?QdyKTkh88HdrOOkvUQb2EjqZ6vKUvttphnRLOlNAmJiG7T3ZdRBcp7SQuJTv?=
 =?us-ascii?Q?34M6ikOgtE/BNWrZoqxelMN30dOpPgT6zCmpYBsT5J/J3tsyg3QxdO2WGttt?=
 =?us-ascii?Q?YynMtYuDnwAlx/f/+88XNAxXoNDXYCPoRBwmv1vvmt7De08tEXrQKmLaZwFy?=
 =?us-ascii?Q?rwoqi6bL7ECZWUSfXbvbrE7rkRpQpjfNKhGNFyCtLdvmEdog2b67fSS38jJs?=
 =?us-ascii?Q?8BTuQwrGmnX73+wgGf/bo0QqLE0zuBrNK6bmuAzrFoes83v5TkejtWA4bkyh?=
 =?us-ascii?Q?eV74wCuDU9vXOUJ9dOdx5R29KVxW1wbirrrnXjUZdgXBuL4QuR13j4ZuO9LF?=
 =?us-ascii?Q?3ULNCqNkwJD3XvqQJ/ETRMUlRnne5LVA99YNOzWkKwn3FxUg43YDd14hDnxa?=
 =?us-ascii?Q?AGOJz4E5wT/Qp1t+/eQQIB0C9vIamDplkZi9PgR8vUX8xzmEzibv00dtxjs5?=
 =?us-ascii?Q?iv/ujAN23EptsoIZaQFjMLvamDcrFbMNR7WDXWzr5CacY4NzULYGJ/w1MeqW?=
 =?us-ascii?Q?6M/kL2rifllWoor3kxJ0coMtjajlBbHSR3gj/tAkZDTZorCGyEkGTxC+L0uH?=
 =?us-ascii?Q?oFSeQI7ntn7yXw51rHAioZmI0hW57xiBMPKDOTGl83AtICycCEyqOIpDneXn?=
 =?us-ascii?Q?4Wy4mw1Ntb4zKGL3JFndQovkl0uxCByAaBv+jp+FNxODdI6S2TgooNhdNqjb?=
 =?us-ascii?Q?36swCRTKg2k0c+d8P8V0OkNejkPX1w2o0ykbjFs7QKwq61RhuAdh25uY2m4V?=
 =?us-ascii?Q?PxoxfMD5zcJSXUe0d/T49kfERstA36N4LDQjdDeR+/+saxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(366004)(1076003)(6496006)(956004)(66946007)(66476007)(66556008)(83380400001)(6916009)(2906002)(5660300002)(38350700002)(36756003)(8936002)(508600001)(6666004)(52116002)(2616005)(38100700002)(6486002)(86362001)(103116003)(54906003)(4326008)(8676002)(316002)(26005)(186003)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dpH9ucPES1VBu8okxS2m7VVeEpPq1f9PM22qYQnslW2zFnTuxIsCygEi6fE?=
 =?us-ascii?Q?xvM6+N9x5G3OObbl/fIdnh+SVEUV3Ad+Y0zlJo9aSgjKkNK2se4PyM8yYknr?=
 =?us-ascii?Q?Zqv/FT2YIQOnEAKW9nKyyVJWEoezBmwxIHorTjBQzBg4eC4awOrvxogeysrh?=
 =?us-ascii?Q?a3bbhl8MBWeuTbTUS5OJ4nb0vl9EZpk7cldn3Q4vxyMzud2T+Ys6w6cvL2kj?=
 =?us-ascii?Q?DWV5M0rN2SyNsTAplL3D0Gc65PALS2OnSxVD05HFb1Bzrs9TJ9H3pU67azQF?=
 =?us-ascii?Q?xlXc9HJSkXiwPFzWJI8URPSY+7C9+cxQzZnUUbyRi0XR+lrIUqnSJpmJnz0V?=
 =?us-ascii?Q?CCUZmv92LK9MW9hU/gFnYIOl96HGnN48G5Ln43eY4uSvXHRtLciPlBhuYBKO?=
 =?us-ascii?Q?hxEh8KA9PMGLONCiSaW0OOQzixtJ5bjMJAlvZyDcF1UkmBWJ2PxHZlsO58St?=
 =?us-ascii?Q?6OUfNLkOdL3To65H+wANG3YC9DqvULqEuN3czcLRYvj7zgLEyLiubBLOvh34?=
 =?us-ascii?Q?aToAM3nDYpVFcJCVDzJq5lefk1+79cKYTXT5lFpMGjn02XKVnNUQSFwbxHU6?=
 =?us-ascii?Q?/7ShXlJSrTpNtO+PaqFN0gVWInFhmhgzp6zC05WYhAINYTf/VLgO9JW3U8oL?=
 =?us-ascii?Q?UDcilYnk2fQZdYs0Q9oWYXXrX+hrs0+zOUaX3ith6UcDvyzcZBwZD68VcCqo?=
 =?us-ascii?Q?84U6xAHNsCjOaD8LqinSgVUhji5en16evcT2YA8VSVHjSmGaMQrG5MbBVAl6?=
 =?us-ascii?Q?WZp0at9vu+rqskLl3x0o10I7HmIiOv+Wwu284gl+p+FkEXTnSK1l3I7nlCfw?=
 =?us-ascii?Q?jEt/B2pMT3OfFJcp82gKV0P6bQTRyQ9gqHRGc3soBeIRVLAX/DC4yS/GrgIF?=
 =?us-ascii?Q?j0r03La742ecd1l4YbqDJdvDxV5uB//xb4eVhC2xJ53EVH+LEd5qQMecldAc?=
 =?us-ascii?Q?gByGeitSYMvPFzmbVqwDz0aktkX7SLvPd1oWK1jmZyxmHhXyrjOhGUkuRLOo?=
 =?us-ascii?Q?4viHVxO051rroYdqka1Mnn5dS1n8+cAfCaWZDMhAVg9E54wAERfe8w4eVcX8?=
 =?us-ascii?Q?z0dIM6R+dUYeBwZFg498p2QYMgabsqZelyUVFLY/BL69m7pF1IBxdwskYX/E?=
 =?us-ascii?Q?oyyY3Wxw0bEfuh69DNm8Gsgtuh2ALXwVFJfKhGLK2Gllo5ut+M0lr/FfHTzD?=
 =?us-ascii?Q?TMYrs+unuFhpvvz9N6N5CJVvAipL4qjMByNpnPG+oGSyGsbFVploJzHQC2Od?=
 =?us-ascii?Q?vwHLhXLgiMkGLn6jK7VrZVaf2fEiYVaoUgnY5GzOSWTR03c6G4JmiU0xfZaT?=
 =?us-ascii?Q?BIrOI7ugA/F5+RInPYEvl/Tp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f20044-55b9-422b-8c8e-08d987604c60
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 17:56:31.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxH9QhN0MvvKqXd7GTlbwQHIMcko0BeRtnKsxjiH/V+HlnjS3ajylzcvTFp2kSfVb/GcAKPc/zDbMbSFkXWAVMT6Q9xksLM6s6vRuPUIIUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4841
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=842 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110040124
X-Proofpoint-GUID: spzd66jRxR3b1R8ZgOaWkSes0toIGgXC
X-Proofpoint-ORIG-GUID: spzd66jRxR3b1R8ZgOaWkSes0toIGgXC
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello all,

I'm resending this patch, adding Andrew Morton since I notice many
fs/proc changes seem to go through his tree. Andrew, please consider
this patch if you have the time to look. The patch is the same as the v5
I've sent a few times, but with a refreshed analysis based on v5.15-rc3.

Problem Description:

When running running ~128 parallel instances of "TZ=/etc/localtime ps
-fe >/dev/null" on a 128CPU machine, the %sys utilization reaches 97%,
and perf shows the following code path as being responsible for heavy
contention on the d_lockref spinlock:

      walk_component()
        lookup_fast()
          d_revalidate()
            pid_revalidate() // returns -ECHILD
          unlazy_child()
            lockref_get_not_dead(&nd->path.dentry->d_lockref) <-- contention

The reason is that pid_revalidate() is triggering a drop from RCU to ref
path walk mode. All concurrent path lookups thus try to grab a reference
to the dentry for /proc/, before re-executing pid_revalidate() and then
stepping into the /proc/$pid directory. Thus there is huge spinlock
contention. This patch allows pid_revalidate() to execute in RCU mode,
meaning that the path lookup can successfully enter the /proc/$pid
directory while still in RCU mode. Later on, the path lookup may still
drop into ref mode, but the contention will be much reduced at this
point.

By applying this patch, %sys utilization falls to around 85% under the
same workload, and the number of ps processes executed per unit time
increases by 3x-4x. Although this particular workload is a bit
contrived, we have seen some large collections of eager monitoring
scripts which produced similarly high %sys time due to contention in the
/proc directory.

As a result this patch, Al noted that several procfs methods which were
only called in ref-walk mode could now be called from RCU mode. To
ensure that this patch is safe, I audited all the inode get_link and
permission() implementations, as well as dentry d_revalidate()
implementations, in fs/proc. The purpose here is to ensure that they
either are safe to call in RCU (i.e. don't sleep) or correctly bail out
of RCU mode if they don't support it. My analysis shows that all at-risk
procfs methods are safe to call under RCU, and thus this patch is safe.

Procfs RCU-walk Analysis:

This analysis is up-to-date with 5.15-rc3. When called under RCU mode,
these functions have arguments as follows:

* get_link() receives a NULL dentry pointer when called in RCU mode.
* permission() receives MAY_NOT_BLOCK in the mode parameter when called
  from RCU.
* d_revalidate() receives LOOKUP_RCU in flags.

For the following functions, either they are trivially RCU safe, or they
explicitly bail at the beginning of the function when they run:

proc_ns_get_link       (bails out)
proc_get_link          (RCU safe)
proc_pid_get_link      (bails out)
map_files_d_revalidate (bails out)
map_misc_d_revalidate  (bails out)
proc_net_d_revalidate  (RCU safe)
proc_sys_revalidate    (bails out, also not under /proc/$pid)
tid_fd_revalidate      (bails out)
proc_sys_permission    (not under /proc/$pid)

The remainder of the functions require a bit more detail:

* proc_fd_permission: RCU safe. All of the body of this function is
  under rcu_read_lock(), except generic_permission() which declares
  itself RCU safe in its documentation string.
* proc_self_get_link uses GFP_ATOMIC in the RCU case, so it is RCU aware
  and otherwise looks safe. The same is true of proc_thread_self_get_link.
* proc_map_files_get_link: calls ns_capable, which calls capable(), and
  thus calls into the audit code (see note #1 below). The remainder is
  just a call to the trivially safe proc_pid_get_link().
* proc_pid_permission: calls ptrace_may_access(), which appears RCU
  safe, although it does call into the "security_ptrace_access_check()"
  hook, which looks safe under smack and selinux. Just the audit code is
  of concern. Also uses get_task_struct() and put_task_struct(), see
  note #2 below.
* proc_tid_comm_permission: Appears safe, though calls put_task_struct
  (see note #2 below).

Note #1:
  Most of the concern of RCU safety has centered around the audit code.
  However, since b17ec22fb339 ("selinux: slow_avc_audit has become
  non-blocking"), it's safe to call this code under RCU. So all of the
  above are safe by my estimation.

Note #2: get_task_struct() and put_task_struct():
  The majority of get_task_struct() is under RCU read lock, and in any
  case it is a simple increment. But put_task_struct() is complex, given
  that it could at some point free the task struct, and this process has
  many steps which I couldn't manually verify. However, several other
  places call put_task_struct() under RCU, so it appears safe to use
  here too (see kernel/hung_task.c:165 or rcu/tree-stall.h:296)

Stephen Brennan (1):
  proc: Allow pid_revalidate() during LOOKUP_RCU

 fs/proc/base.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.30.2

