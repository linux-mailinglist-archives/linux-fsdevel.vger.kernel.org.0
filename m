Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70275F7032
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiJFVZ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiJFVZw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:25:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2092.outbound.protection.outlook.com [40.107.100.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F7C14A0;
        Thu,  6 Oct 2022 14:25:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S10nXs5B+5fdE9M+xsSsu79Zb/PKSqW//s9Sf3kEF9eyAaKF66uzOUdd1TfR2k5pfg6lXnRTBrQidWKpfB3p/lhVpZVVSLBrHq2p5ys4B0vmdfc22mKk4KmEWtldIIDnTP3SvUOvMz96a7e0STeYnjOyShOG0Ool282yZYNUghX0oc+Z0RG+eL1dD8DHGVVe560Mmjsb6tyToBRdK9YMC1546GVPL7hLxiGO5R2jm5JiKuDKamIa2B/rJ9zkTQdlrSntG/152yfu+vxvzd+13BA6AWUwpwaW7gVd4sM/464+JLG0rz6nf52fJmUoCAignC9fMSlKcxkfMxORNmn4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mF9fF7D3PEWZ0S19xQvmYSjCA/58tc20mcdbIEn1iW4=;
 b=QGDdX0NCYM2MALyQsdUBJNE/x0kpodcgHX5OK8N3J8ylPuAAp2AgitTyXkiM9fXYCG0bbiv7iIlefbIF5jtR9GK9jTmVfELPqioBR23vfzIg1UHmROiXSoLKP2L+FBh18Ys39EmwgldrZlFSBMyoZFgSWeI1FFjWeWl5PJd6xRbiPuzi/GRmYGlO/Rcb/FC1La/B6mJ2CqsoBQ7vAbekrQ7x8S4xzq1eOQDF/hgIVmhnOH3t2Ql4+6X+6+WvWoU7unw9j6yp0f17l0q3JuIjPytR5hFL8SwO+hO/2XjLryXez9h09A452ls/lH+72EOQYpN497xkCJHkxo1Gl7Y4tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF9fF7D3PEWZ0S19xQvmYSjCA/58tc20mcdbIEn1iW4=;
 b=mOeG6j7DR1gzA1rvPSI4smCn88IQlTUxmUBOUIlLvYgvFt5ftaD49HCvqxDGKKqPIB3holzwHYAG5A4xwsmGHmweYC49TtHdo3odKKslwXHAgF01wNZ818f2/aN2vJpQAlk0Vhj4tXosvsBq4FyRRSo6ya6CH+es9VdWt1oC4ix1JFY1M1t43Twsxv0dMf5gK1XksLFVJF6zCXTgf8BAvwbs2T5VM0/rHURFXA32/0YokfsTscZHmNQrx2sw4E0S8TkGmCr/diQZzGQ1s3BCbQD/e4IIXMXbO28sRcgWslXPlRzqaOHHdHnFJUc58aRC0o1Vlmo5dRNFNEQ6YrkOPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by PH0PR03MB6381.namprd03.prod.outlook.com (2603:10b6:510:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Thu, 6 Oct
 2022 21:25:47 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 21:25:47 +0000
Message-ID: <973e3ed5-8acd-abec-28a6-aceae6d67423@bu.edu>
Date:   Thu, 6 Oct 2022 17:25:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 09/10] exec: Give userspace a method for starting UKL
 process
Content-Language: en-US
To:     Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, masahiroy@kernel.org,
        michal.lkml@markovi.net,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-10-aliraza@bu.edu>
 <20d483b6-da24-4ddc-b6d4-c0c23b8e5ea2@app.fastmail.com>
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <20d483b6-da24-4ddc-b6d4-c0c23b8e5ea2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:208:160::16) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|PH0PR03MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b6defe-5302-45d3-0468-08daa7e15569
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6ZaMkhNuc6jM1ez69F1is4G5mGmGZ/zpWR6vdKjVsYsCKIeh6ulJfXgFK3T3JHrgFnw0eeIGTDm53LafbvOjvCxIoy8kyyzb360MfYtCc4JN4/FzfTVvw2fkf9tzVpo3GJ4zYwxR3Fsyz6YNyvqZMUHgtZsU7rKqep3XNZeRkdSNE1XLM1YqPX1AYHASPGKMju9Ivti3CUBwtZrEJq4AsOFHBXNtCb5jtFXwtB5Rx2u4gPDkqug1kwRi6R1DfSxls78M77Qj7szj7mqGbacSUkUkQY++DbPn63iS3ZkkD9GP7O2clvO7Rs/AnYnlBezgvL5J+P98HtmMvpTtTVrLeSQP7Sn84Q8Iy/jWbZ4kdc29GkVnPJMHt1gDpB+PbxIpiWnf5/diOHEWpKw00o1s4GHu7hgnrTpkrX5Q0oe5F1a9cN+CCH2R0HbUfd5mqOP+nsy5mTsW/+uRw0JpKK0VWmCJ7wBfk91VH6ukyfZgQw/wtUQ8p17AsHeXbmSjYa0iLg4Rh1omXF5Mxb78pASOhQWSuG/4oenOhR+3IGnrJYMmBPrHLJ2efrlLPpRj2N2kuZQ6iNLcto54SQKl3lsS+n4gY7vhk1Wev081ZzbrUf/hs/9pKIEGUFTKq0X5uwutNDyXDWTK2UEn0quy3BUkRPKcj9EdomVNDq+8Mi9mPMx1r0noSMnWWrxmiWVe31DaNrvphHMF6jJz0L2dWmO+MJrwF+KGR7QQG+UZDM29UlJjyX3+bbmZSfmSL0hgPENobuc7QtBxIWtYL3qV1uV3Q0jPdE95RP4tEJqd1L3cm4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(83380400001)(186003)(86362001)(31696002)(6506007)(53546011)(38100700002)(8936002)(7406005)(7416002)(5660300002)(66476007)(2616005)(8676002)(41320700001)(4326008)(66556008)(6486002)(316002)(478600001)(6666004)(41300700001)(786003)(66946007)(2906002)(26005)(75432002)(54906003)(6512007)(110136005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUI3dEFJei9UUElLT3gxZ3dKRzA2MzJCa0xrMC9GVGorYksrSWdKOHplUWhn?=
 =?utf-8?B?d0Y1ZlFGdkc0V3cyMExQTlRFSVBBQ1ZwRGVKODcxZTdmZXpSdnA0L0ZKR2Jv?=
 =?utf-8?B?dkU4a3NWbTBKRGxuS1U2dXNXWDBuSldwWCtmWjEwTTVsOGdLMldFcUdxU0p6?=
 =?utf-8?B?WFJSZEJKUUl2REZEejlmTXFmQUZkblpqZUZSbXcyYnFJQk81QUJRNksyQ292?=
 =?utf-8?B?c09lMjU0TlNNT0svTFdnOSsrMkxqOE9Zc3pLeFltdWVBdkIwaUxjOWVhbDdK?=
 =?utf-8?B?ZUdTNzBhQmRPOGY3WUhSelBOUlZpQ1F3UGphUGxNSVdzUFRKM3ZFV0hrNU5D?=
 =?utf-8?B?Y0drdlBkWC9Bc1FzaWU5Qzd3djBXWERjekUwZVFYd2k3Y2pIcm1hQzZjSUVm?=
 =?utf-8?B?enlZTS9vaVM2aFFONnBBQ0h0Nm0rUjJlZkpTQmpnRThoeHRQQldod1pGT0Fv?=
 =?utf-8?B?dEZoZkZQa0g0d0JkMWFhTWRCN2tGeWxMSU9HcWIwa0lTYTBqb2dnK210Vm1Y?=
 =?utf-8?B?WTJ3UWFmWHdFWkl3aXZ0cVBZT3A3R215Y0t1NUtUL3g5UUxucmVpQjV3bjU0?=
 =?utf-8?B?WEdpU3RPY1hwMXcyaDdHNDV0V0dUQ3JybTl4cXZUTmc2aGVZbnJFek0yenlj?=
 =?utf-8?B?UzgxWnYyMDY1ZHdGcno5WlRzWTJRdUI3bnZmNitNK0s3RUxVU3k4T1Y0ajhs?=
 =?utf-8?B?RlVwYTZncUpyRGQ5RTRPYmpKWUJaUmYzRG9TTndUMmx3b0hOSmN3ME9RdndJ?=
 =?utf-8?B?TUQyK29Od1RRek1ndDU5N2YwNE5nSWo5dVo4K3EzRGpBdkZRU2tyR1VmZDVO?=
 =?utf-8?B?a3NPODBFak45ZGxYeHg2WUJNWVh1cHR0TGxjSWhvVnNUSHcxV2t1L2xCK09P?=
 =?utf-8?B?Z2E1aXZtMXVLbWNXR3JORmkrNlhMMHlkUUdUS0h6bHhrak1Ydi9uVGtqSlAx?=
 =?utf-8?B?QUJwY1E2ckNKSGgvbUMwbmx5eVBLek1rWnkwQ1cybmtDRERnNHpvUkUxaGZH?=
 =?utf-8?B?bnhCUHZMaGd2VVZQU005ejZxVis5TGUyMVBGY21LQys3MkdPZXV2VGFJeGdG?=
 =?utf-8?B?cG0yRlNzVmNUb2ZVUG0wcW1ZRlIvTXM5OUZ6bGdhOENOWXNoK25SWkJKYXR0?=
 =?utf-8?B?WlJzMG9aekZNcFU4QkxSQmNzajBHOSt1aUl2Nzgxb2NSK2NFS2loTTRNclZa?=
 =?utf-8?B?NHV5UnQ3N0R0a3JscXNpc21Ra2NYL01SaUhUUWEwekNjRUVSOUp3QmRmRzBp?=
 =?utf-8?B?WmVQU2R1TWhuQ0ZzUEtTaEg1VFJPZkdWaldTZTJIZWs2cXhYKzFOVjRHZk9C?=
 =?utf-8?B?ald2bCtERCtEVXA0RlhncXA5eUZJb2xXMDFFbk56aFVValVyVUtxQ2NiTCty?=
 =?utf-8?B?bzJ5VGpVbEhIb3JCNFp6Q0VoSGNqaHNnbllKRHZFcWdYVmJ2ZzRlMXM1Qi9k?=
 =?utf-8?B?OEFFenpYSWdPcGxFK0x0VG0ydWNPbkx4c0hiUFdKc0RtSWhId3lMMEJCZXdF?=
 =?utf-8?B?OHNqcDBLNWNUOFAzeVVoclpWaThuK241TlMwNjc3MnpiSnM5ZGt3VDlBRG9q?=
 =?utf-8?B?NjFLWmV1UFFsU1dSQ0ZuSjFJU3FXT1JScGthQXVNTk8yNnpPdExEY0dIbnh3?=
 =?utf-8?B?dHhuaFh2YThtQWRhY3Jnc2dkL3diSzlzbk5iS1EwTXFVQWd4dmM2bFNVSnM5?=
 =?utf-8?B?alM1UGJ4TnpmMWhXQzlXekplSUgrOGx2K1JYeDh3SExCSWxTK3ppQkZEV0FI?=
 =?utf-8?B?U3FHZVROTERWbU9mcVg2aVVQNXZJdWVzSUNkUjVkbnMwQ1dWdGNiakk3V3Bk?=
 =?utf-8?B?ZjA0TEhobEZ1OFBqSnFxUGpqU2RTbHl2bWpsbEdCYlBRbURaU0xBNXVRT1lW?=
 =?utf-8?B?bXM4WDNJeGgzYnF4S3RNUzVxYXcvbS9ZNUlFRWNEZ01HdUE1cHM5ZjI2aWtB?=
 =?utf-8?B?aXV5b1IwYkpuQXFXRE9CYzgzcVRsMjZRcFFlQ3BHUkJTQkZnQXZyZGRJcERr?=
 =?utf-8?B?VnZqWnFBc0JzUk1vNnpmZVBGdVZvblgwRStaWGVVV2tudlc0SnRkWi9QM0ZP?=
 =?utf-8?B?ZmJXa1NEZjd5RFpXcVdReWh1S01rWDhXUUpVSkNHbGJ3dkhHRndOWjNxWVdE?=
 =?utf-8?Q?s4elI+cQKXyIPEjdDX9fEiRfp?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b6defe-5302-45d3-0468-08daa7e15569
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:25:47.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81K9+CjVMa5hOfmDH9ROiSZXJow/hjC+HtgyTlZ2RuZFGbEMLy+x5qiMqeD0YW1p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6381
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/22 13:35, Andy Lutomirski wrote:
> On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
>> From: Eric B Munson <munsoner@bu.edu>
>>
>> From: Eric B Munson <munsoner@bu.edu>
>>
>> The UKL process might depend on setup that is to be done by user space
>> prior to its initialization.  We need a way to let userspace signal that it
>> is ready for the UKL process to run. We will have setup a special name for
>> this process in the kernel config and if this name is passed to exec that
>> will start the UKL process. This way, if user space setup is required we
>> can be sure that the process doesn't run until explicitly started.
> 
> This is just bizarre IMO.  Why is there one single UKL process?
> 
> How about having a way to start a UKL process and then, if desired, start *another* UKL process?  (And obviously there would be a security mode in which only a UKL process that is actually part of the kernel image can run or that only a UKL process with a hash that's part of the kernel image can run.)
> 
> --Andy

Again, the commit message could have been worded better.

There can be two cases here, one where a UKL process forks or a new UKL
process is run once the first finishes. In this case, there a single UKL
application being run multiple times. The second case is where two
different UKL applications (both linked with the kernel) are run in
different processes, concurrently or one after the other. Lets look at
both of these cases.

For case 1, there is no restriction on how many UKL processes can run.
UKL allows forking, so there can be multiple processes but they will
have to share the text and data which is loaded along with the kernel
text and data. In the future, one can borrow ideas from how glibc
handles TLS i.e., where each UKL process would copy data into its user
half of memory. But we have not designed or implemented that yet. We
have tested applications that fork/clone. We have not tested running the
same UKL process again after an earlier UKL process exits, but there is
nothing stopping that from working.

For case 2, we have not yet implemented that. But for discussion's sake,
we can have two or more mutually trusting applications, all linked with
the kernel. And if you do /UKL1 or /UKL2 (or some proper names), you
should be able to run them concurrently. Again, although much of the
plumbing for this is there, we haven't implemented it fully yet.

Thank you again for the detailed feedback.

--Ali
