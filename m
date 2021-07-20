Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9263D0255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhGTTKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 15:10:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:50408 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhGTTKF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:10:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16KJWGkq020466;
        Tue, 20 Jul 2021 19:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=bnMBp6luuELZ0fBc185CIokG7o48gGZsHxS1IzVftZk=;
 b=jSKuQAKm1jCoCwfQz1jS9ORnpDurpa5MrvrMRk5fliEeIrQs3wcRNr+HmdFp6PavN8He
 pw34SznGw+qX3WXd6zgL8bZkZahieFOXKkXfhxJeg5vG9CLERxGtIpVjia1LIYWPtoSS
 x5SBpW72eRtUeAFfO9qPNPx4ZzMWFY8bG5hJB5QAIjE15vDlmuf+cQZsbhNpt8hfUXTW
 mBHOZ4F84EDLjlLLRdBEzne1XRYkglRle5Rg7lCqXMaA6z0g3iMDwbrgN89LrBW0TuNT
 yBp0wQtpo9rwjzbLBMZc2/aTVl9pCo/xCdCHa9Ui/WjQN3hfvEKnNOG4E0ifaCvVwysm AQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=bnMBp6luuELZ0fBc185CIokG7o48gGZsHxS1IzVftZk=;
 b=XZgm7xGMgHYwJqaGBA97g6eXC5aYFESt6dEmVbJu4diESgqoWLWWNXXkk1cH6UoEXKY3
 ZBPIxhcds2s6T8oTpTwvOb5lENJ0Sx+flgP+hjgmkyiOc+QkhyVOBFajqTnHW1HRJ7HD
 0KEQ9IoBtVmiXe1+Gtq3uVu4hteXMApf2Rc58puMrjadTxj/K8xzmra+jvRnqV+SFrDQ
 q3J8EU2CZuL83vuiccuXwiL4V4pz6c4wbfU4+mOP+xBrMoJXDA5TX9nBFfIh4rOMA+sO
 Sll8JtPi06BQs3oDzkvFQA4ccREmMN02E4/NgsKY30L8Vqx0dkxqsyWUR9l5LAL9qe5n Sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39w9hfum4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 19:50:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16KJZYAM156535;
        Tue, 20 Jul 2021 19:50:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by aserp3030.oracle.com with ESMTP id 39wunjd1bu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jul 2021 19:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QazFAFQk7vWE8zq+NA748aoWwRzcF1gXkvg8ZYFfursf3f6mfzsmc++5M5FLPqH1SEW76xiaMMXULH2kl6Sd7TDGu4gSEwJ4YnYUYWD9/tsT6vjTghixyl6VBCRO6GOQTgJ65xShTbbdrxCorTze0/Xqu3S31eS/lStIVleKQ0RxnQSAvDSO0+fbjwWgLM342hofHOKg3y4emhnypbp6tvZk6HGHUWcDP2zWKVjRy5IRqSPVjtTPqSeeb+kKDowXna7gccAyI/PhGaIzRW+Y4XNtCUJ4Z7f4yqdpdm0yzMpw0WKD/IcrrndWCvN3bQrrqeJ8KehJCpFC2fOScZdnsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnMBp6luuELZ0fBc185CIokG7o48gGZsHxS1IzVftZk=;
 b=TO9kjQ9+/H6r5gNOZkkSBrE3TH082N7e0Smc+dJuRLZEA1OqNE/r5ccp+98NfcyBqP3V+rH3EmTRHyQjXlxCLDdxCK+TlK0GWzWh6jCOH8Vjdp9dLDYpPNe4BCJgcttKYfQqIcGenlIFONaKLP7+7qWrP3BoPCRotL5rgip87oNDNEjhtd8c3kWNUykf7uuY9Zu5Zhczdep5Z5jlh9RhD8cxJgmI01Sei6ZPjcLOE/6JzLuEyxW4B005ZMlNTBLHZHa4UfhWCsrjDx9cXf/AW4kC27xwvr5irX7RQocA+1UFOeb4MGItOtUBTj4voNdeV+KzsfjQ1mPOq4UsIHmofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnMBp6luuELZ0fBc185CIokG7o48gGZsHxS1IzVftZk=;
 b=RuHgJPuCwyTyU2y49zafMsXMUZg29hWjz6/5Am3weM3BeQZi1ratBsgoA2QAudfu+mxBlI+cF8unHM1jiz+q1beBi/+YqN62hnKOUJvPOlDFLDUZ6TxVaXsSY8a2ktDtncNSsVBznrdVB63P4J8uLdFKC2eq9yKVAjzdpUXmqaA=
Authentication-Results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1246.namprd10.prod.outlook.com
 (2603:10b6:301:5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 19:50:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 19:50:24 +0000
Date:   Tue, 20 Jul 2021 22:49:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, amir73il@gmail.com,
        kbuild-all@lists.01.org, djwong@kernel.org, tytso@mit.edu,
        david@fromorbit.com, jack@suse.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 14/15] samples: Add fs error monitoring example
Message-ID: <20210720194955.GH25548@kadam>
References: <20210629191035.681913-15-krisman@collabora.com>
 <202106301048.BainWUsk-lkp@intel.com>
 <87mtqicqux.fsf@collabora.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtqicqux.fsf@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24 via Frontend Transport; Tue, 20 Jul 2021 19:50:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e25057c-8feb-4d33-2ae5-08d94bb79d6e
X-MS-TrafficTypeDiagnostic: MWHPR10MB1246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB124687056F2C5D313DEE9B3D8EE29@MWHPR10MB1246.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyiHkbeGwiBdGYWDei9MrBVCmCU7PjFH7uSWiOso8ikGaLliQ3865AAS+aNgpJfJgyQoZpBQL2c4WlQ6E/0Vhg4vC2G9xfXOZxbIDl8A1FAqASrKB9Ko1vXc/ZjrG5LBRFribe4bFEXxAzY0hzTq04OnjQQPtTzkP+Dxee338jIHK0lYM4JPNBkBxuRemo0SB7vDe0tIyR9Yl+3/AtH/kr88NCRjC/U6f/5kMDwq3edWgQtsgH6dU4uifcEjEkQIAQeZ7PRi6pcdotVuAHCYtExcWpBOL+aFjw1JLkX9u503mZoyA6cSRwquS5+Q5frM7wEtNrfLpXEki6fBlcEAc4l8wVp8mWXgc0K5SYkEuFFi0eKTb+dHecf1uaOLIuCZJmE4RtYiNY4ih5tZ4uhpj3/mCcmaCrRICjAjzaWKMUEDUHHqR0ggf84HkqtacciiI20ggZ1EfI8LLYgqpkbZtyFgHH9JWLqSGa/g9SFCEwoxaEVbBYg80H4dcQZSlPcJ8xnNHTmWYKZOG/5lRUThDgxzoiVV+CT/jqJ0hAxnSK4ygc6D7xCp8E0TwDYutghqUNlGVmGKj24Zi4fWDirc3YhuLvOdiZPKuoGiP+FtYbbAzikmyU9ZAnuNjrQKwi2N50tUQ2oBY65cs/D+wzGzz4CgIYgTblHQpGzDmEBXjj/hgzbOI8TrEvE64/Kf3sGzosIH4ZX8WtmjeMKPKEWQT1EiuNflesu1q0fweRdArmd9PIVkADeVc9cTohQo5ZyUg9wdskzQy5pzHIWU6Z6ZG/+Eatra/KpMcvDPwB2BSXzYfb9Kb1cr+PSq0vXBL+5k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(44832011)(83380400001)(9686003)(38100700002)(86362001)(66476007)(38350700002)(956004)(316002)(110136005)(966005)(66556008)(66946007)(1076003)(9576002)(2906002)(8676002)(186003)(33716001)(6496006)(26005)(4326008)(33656002)(5660300002)(52116002)(7416002)(6666004)(8936002)(55016002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mRziixWVZlIpxDcZHKDGuR2qh8UM+0+zwGZld4GLWo3+69ardmD5tkhnXzNZ?=
 =?us-ascii?Q?A3Uh0mpqJOwPcU5Q3oKZ1T4OjHef+9PBNhei+ZeBl9Inao/rXgG2/V26z728?=
 =?us-ascii?Q?PUavN6xRCU3LbjKr+uCTSUKqQfUE22hcVr/1NTaPmN4gxmOmlLy5QoVX0S3G?=
 =?us-ascii?Q?ggRC9dRKjYv1VvInGGZJuVHU/KdzzjLgxyoJ9Vrp7MZuOBRO2wffuUqAopDn?=
 =?us-ascii?Q?UGe9vtYbcyFtDUsTCu7coT7KZmCw7uUlrWO/NHp/2KaxK0PjgORCcUS5Jm8C?=
 =?us-ascii?Q?jJ3szXzSAAqhy+Z3XarcrpDyVlfjxC4RBJ2Fr/jrWVoFqg2dFWwr3Ta5dQSw?=
 =?us-ascii?Q?3PPAL3y5qn6iY7MnpkrLzhC+y8cSGZx/7TEqfVIgIyaF/9M+NmpdMLqUkm3S?=
 =?us-ascii?Q?bHxRVAP5IYpkAbfnA3h8pSu5s535jUzS5vQ0WdAwlxe8rm2+4eYsW+Lqu9m9?=
 =?us-ascii?Q?7HZZ0+bBfHCYl7JgAgdSCqYziBZhoi5O9HmGIzzxdF0fvWquwUzBoqxwa39e?=
 =?us-ascii?Q?4hGuKRUQ77bSQdKpgw3YplhJ8NWv++2ye5nLQcsLYhGsYOfiYLFlKSX8py9I?=
 =?us-ascii?Q?AYrIeAI25y4TSIPh3R0OUgU0aOEZQDICboUmTN/RjUXbHYxiC3ho5ijyIq3e?=
 =?us-ascii?Q?0KVUWygwgTKJrPZtQG2uUYNaKcYXe2lLNyAkr5kVV2xJXoq44dinzwvwn/Tg?=
 =?us-ascii?Q?lpSjgzqaQvau9lePVnEE/HseiI9Lxwf4ShpDPfbkps3ARwN1wjgXe9K2i2TY?=
 =?us-ascii?Q?hFILRafLji03eeJCKASldGvq67xa+Az+fcLkrMcOOYkruFBH/j5wNQRL54D8?=
 =?us-ascii?Q?2qFrZyIn/1ZM6PrH8i5DVXb/ekYCCFqOzRGTJm9V43VBo9NyWfIA9DrG45Tj?=
 =?us-ascii?Q?i3CEXF3ZAqEPLlXKwWouZxgG6UxV7lJ0o/u3cUVOSk986Ice3VHbRrwnt6K9?=
 =?us-ascii?Q?GcsvB5se78cMRobcNxss1T5PKra46W0ZYGvdSEfLhpXYuK+5mibxExk/AMyx?=
 =?us-ascii?Q?RkBVyuzdHdOXlIostOvRCpTy9vup3CsSlzoEzFZWy9s57naqGiEiaJKozJ8J?=
 =?us-ascii?Q?AmaYZphx6i8YshzG+eBIgVRkz6rsLG5nxvLQ82xI9VDrcOMc2RmOtQYeZokC?=
 =?us-ascii?Q?Q2gjpUxjRV/MgOaOqFRdCdoVBtLh0eg4eSvZlmzgQ8HN4235f3Rxxw6cWtm4?=
 =?us-ascii?Q?2LJdJYlp/hnzYR621pGywpA/IDrm75w69JV9aJVby3C++lBla5y98hXi+c1/?=
 =?us-ascii?Q?XkcxHyEa7VrskO2LSH8TYgqP9SJT8HGBqEBSnM8lbb9zK6xJyBqkQQ5yWSeI?=
 =?us-ascii?Q?2ByLclaw1VpJ521Ja91BEtIk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e25057c-8feb-4d33-2ae5-08d94bb79d6e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 19:50:24.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0asRyq/jQT6kmbN/8d7AhiaZFYkhYJzEVfbp1aO0a19/5NFiD8EV9vQuc0ALo0KlUrypd3LWgj0G/dt6cG52sL00JozpX53mYk+kqE03Pag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1246
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10051 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107200126
X-Proofpoint-GUID: tq0brRkX_FgpbPxpmLm23ydEf06EfDtS
X-Proofpoint-ORIG-GUID: tq0brRkX_FgpbPxpmLm23ydEf06EfDtS
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Mon, Jul 19, 2021 at 10:36:54AM -0400, Gabriel Krisman Bertazi wrote:
> kernel test robot <lkp@intel.com> writes:
> 
> > Hi Gabriel,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on ext3/fsnotify]
> > [also build test ERROR on ext4/dev linus/master v5.13 next-20210629]
> > [cannot apply to tytso-fscrypt/master]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch ]
> >
> > url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347 
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git  fsnotify
> > config: arm64-allyesconfig (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross  -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/746524d8db08a041fed90e41b15c8e8ca69cb22d 
> >         git remote add linux-review https://github.com/0day-ci/linux 
> >         git fetch --no-tags linux-review Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
> >         git checkout 746524d8db08a041fed90e41b15c8e8ca69cb22d
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash samples/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >>> samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
> >        7 | #include <errno.h>
> >          |          ^~~~~~~~~
> >    compilation terminated.
> 
> Hi Dan,
> 
> I'm not sure what's the proper fix here.  Looks like 0day is not using
> cross system libraries when building this user space code.  Should I do
> something special to silent it?

I'm not the person to ask, I just look at Smatch warnings.  Rong Chen
might know the answer.

regards,
dan carpenter

