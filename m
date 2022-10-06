Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44085F7020
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiJFVUu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJFVUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:20:48 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2100.outbound.protection.outlook.com [40.107.92.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DBDC694D;
        Thu,  6 Oct 2022 14:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4OdeOO9+ZIpRKUrJ6XTXLGmARg/aXDZFe7Tv25v1ZXjhZrU9n+7sP/vkyb+/NgdutYEBoInbo+F07DmUBOdgajMZ2SIypXb39s/E2UKnCo/tskCFVl1FwbXJw1ux38ObVG3iGUh1m3rPAX1hE33SYC4vB7j2T62vschez2b/s4C/XfQKDlRBqK9B7McTB2oSS/7+GKdBWWHOdQZwkZsh2cNbY2Z5XQAKjs6nrZld8Ghil9uw3D2+NBSvMJsVg1SuiqYNhj8iYc6XDZKUiF0H9ZYyEI0mjRXOowrHn3LSVA8XWpSM8LzWOzJGZyPU8uGnSlivJlzN8mruuqpm/Mjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po7SsjWlXsvkiYW5fjqK2WL5VkHQms8a3UXvGuNbrL8=;
 b=n1bNOyHY5GOSdFnVnZXNT6mfqmX3xcS1Kgbw9tEV6/PUcwpZaVHl8NjTa5cqdZln7Hh/1SKULSHpltpksNyfMUkpGfa25NmexNHwf6zfUgoNej+K34UYMiztso4O5v9C8yy9sAl0Bv6xohD3VvdvXDsGXhLzNkZ1CLbBTplEv43abE0JRiXWf53lLvJBVVgdifA1HN9JUW72TzQAYQ0Sgo78L3a/e2l0Kr4Qxwlm1INCT/92PkIYEaTDrPw78rKDWoWO4OHFPsLP4f+BNP+EnVBSMsSeMCiZ+Ezc1wc2EZaatT+j6xGeZ3Wuv2fhh4129pugSjwuXxYXYwBiJmP8zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po7SsjWlXsvkiYW5fjqK2WL5VkHQms8a3UXvGuNbrL8=;
 b=OR2P6pRyNW6dOiN55NGK0cTrJObGEzH6Hrm+z5f2+r63hWH1PbixscPUyaCYP7cOmGigzLZ/j1Sul1WAQug/8t3nHF/w4R5ChZr2quDEXdx3G6aL62E0A5lK5TWDTAlla7HL5z1syRwq4SRGj/erLxsru/Fmn+igaLdMKQifdD/vZG80la0IouV82gdlJ/3dTtNe//R4tnvAk1uMmXyOTYtihoPcZUP4V3YkvyH2CKytNxmRsxQWWMJe0Ltq4syK8K9eqiJaeJAGNSTuvaJvHYZUgpF/Rmp4rQ9adfXj1n7xfewVc+dLVoWFSy5X+SF+yDSdse6k6t53VBVWdCUmlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB5007.namprd03.prod.outlook.com (2603:10b6:208:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:20:43 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 21:20:43 +0000
Message-ID: <fd0c0121-ec9e-94d7-e03e-1493799378dc@bu.edu>
Date:   Thu, 6 Oct 2022 17:20:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 07/10] x86/signal: Adjust signal handler register values
 and return frame
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
 <20221003222133.20948-8-aliraza@bu.edu>
 <40484dc2-8da3-486d-9c53-02ae23a50fbb@app.fastmail.com>
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <40484dc2-8da3-486d-9c53-02ae23a50fbb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0015.namprd03.prod.outlook.com
 (2603:10b6:208:32b::20) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MN2PR03MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c7ece1-3ea8-4eb3-a77e-08daa7e0a02d
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8d9I6Jk3cxxZ3Xwnv5dhJp2eDi5XPxnyUy7GLhhkNKwXDqKo28wCsli7JcFjO6HuIpnXob6we01DQr2IRZLasvhNrwISz4DlrvtNy+iLQ+N02rayYK6X1lgf79BN17gHRB1AXmXzOv7PGyatUNuMRl0P3XsZyFQ+KliKtPcwI4dKOb+1TA4uUyQd52gCoxc34K2DrFyIFz3l49pM/BuA/4SW3xZJP5Gqos2wUi/Fjs6rKv7Yju7WM4AR2VePbCDcTmUEkd/UNyK8xiHGsE7LKfg7goyXW20lDPoZTbW7HO1AZ6/VgZzlZ1fWDWN+wuiWMyuVnpCa1U9iaKAC9QLEVI5jZoHu3Kf9t6V5lFl8bqJniEwiqFRHRsahrixdQiBt4kmRd3+j93zIZGGpn20ajGK6LPBqxFjn1jfdnxlr7vQy/QE2JH+kcnwiRMQZHARoyLNEFk4WmgA4/jkCQJ21X5X+0vguR5o0zu4M8ocT6wGTZCPK990kHODIIQl4nRa45K/JC8ETKpanEJ2xWcDN1/cTYhPpYIHO938rFait0G7D0XhA3dDlGI/fQ/cDF0gWmSgWAjFCrd6pWdxBhIZc2T/1TkEKYyL364XAVO/BOnvrecnoP9LLQNaJlHYZk5vknlkY2uKoTnjvenspoP2M2bKcbOLeYeDlfEB5x1meKkPKnSUkgdYv8aW2/lpDXLsQHhZ30s4OnTOvTKJRrUW3mvlG16V1cWzq2I3/tr3/eub6k9wsVJhkRlQtxixVBe+ND5AtmOGDcBUOE9laB1mhh9nOrbzY7giq5JJncbcQY04=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(83380400001)(186003)(6512007)(5660300002)(2616005)(38100700002)(786003)(7406005)(7416002)(2906002)(8936002)(75432002)(41300700001)(41320700001)(478600001)(53546011)(6486002)(26005)(6506007)(4326008)(54906003)(66556008)(8676002)(316002)(66476007)(66946007)(31696002)(110136005)(36756003)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2JyR0QwTzlmTnVNS3M2UzZPc280T2p5UUk2dHBwaEtrUHhFeGxMd1dHQUVZ?=
 =?utf-8?B?ZnVLeXNLdDBJZHlmSnc4QUxMSFV1U2o1ZnFXb3l3WCtNelhjU0ZEMXpaMGFq?=
 =?utf-8?B?cmR4RWVVS2p6c091RkZVczZIeG1GNmVCT3U0OTRrNGhDdVQwYWQ1QXI0UVQ4?=
 =?utf-8?B?QklveURUUGtSYTBLMEtQdHEyajZkTzZyWnVuNlplOUF2eHR1Q3NOcldPbmFj?=
 =?utf-8?B?MjJ2QVh3SVZTVWpUa1JjM1ZIYU05OGRaSzdJYzBlS0ZzS2hLY1hIRkJ3RDJ1?=
 =?utf-8?B?VDdMdG53YklDQ3ltV2FRQ1k2b0Q5TWF4N0VyZ0ZOZnV5QjJ0NXFBSzNocExn?=
 =?utf-8?B?S2V0TlVuVy85WnZOZzlOYUErSEhuWGJrOUFkcTExc29aN2Y4MUxJV1ZqQ0pE?=
 =?utf-8?B?Uks3bWQvSzE3eUNKb1REMUlzRWxwU3FyTHQ4ampBWWNJM2lWSU9GZCthZ3Ri?=
 =?utf-8?B?MWFiMWxLN0JlR3FMRFlRSFNRZDBFUnoxWDBXTk5jUnFKckM0R2FpaXpnL2ZB?=
 =?utf-8?B?a3FVRWFyTjhxWVVYN0k0SjlHaEJsYm9GUWhWdENVWmx0ZWRQTGNlaG5taTgr?=
 =?utf-8?B?eEg0ZVdDc0N5dDhMYWtxZ0I3U1c0eTZCVjJTeHZXMm5XdUtsVDdCT2RDTENS?=
 =?utf-8?B?SHEwUFNyMllHcERQTXRiQVZ5K1R6VmVvcmt2cFU3cFU4ZFNGY1Npc09Cbjc5?=
 =?utf-8?B?NWVvdUM1Z0R6cUtXdDhRRkk2YzF0SGxURHorWEVXeHdCeFRoZ0JzSDNVMFZK?=
 =?utf-8?B?SDRqWFg1MWJHWklUZ3JqczhZdzVtTU9GR3Q1VWNzWkFEN25sWDlCUnZraTNz?=
 =?utf-8?B?WjNlTkh1VlBQQi9ua0szVlRpOTVpWjV1ZkJBdkdQc2xpVmZ6Sm5vVlFnby9R?=
 =?utf-8?B?bTNKRnhBOVVWSXZnNHh0R3h5Sm9scFgvV1U5S0ovai9sUjMzTnJLTW12c3V2?=
 =?utf-8?B?ZkNpODZnZFhVSlRqeEFlMGhyRm9RQkVnaFVGU2N0RzdKUTFUUkwxVjVHbG03?=
 =?utf-8?B?WGFRclFMYnA2a24rSHljbFpCcjB4NUJqeDVIRkg0YTdQaUs4Wnl6WEhJRHU5?=
 =?utf-8?B?eGVsS2RKVmRSU3B3Ynl3M2JwQkZJVjhkOHRENTBHQ2JYZnJJazhVRGdqdDVm?=
 =?utf-8?B?dVpiTHk1aVBpUytZNnR5NkNTNVBhMUx4R1IxRkJhbFlzRXdqS1JSSUJHWjhk?=
 =?utf-8?B?TUtkN3FIb3BoYnpiSXRLQ2tIaGk3VTdtM1JPQWwySm5KMlQ2dHovbUlUSW8x?=
 =?utf-8?B?REZrT0NPSXB5bXBjcUhJZFh5ZGdyZEZMeGtMd2VpZmF2TjFjVkp3eW51eTh1?=
 =?utf-8?B?Z0hrYWVNWVkxZmdDTkRKZHpDdkZmRkkweFd2L28wU3RIbmZvZ3Z4bjdaakhu?=
 =?utf-8?B?V2kyeDQzTC8wdng3bjFCWXRJYmY3ZXNXQ3hOT0N0ZUMrVEhOOGlOSlJySWgx?=
 =?utf-8?B?UGZTMm0rN1BPa2JKZkdqcWQ5QjdmR2NZRkFiZHdYZXZMS1dmRWU2Wm1pc2xZ?=
 =?utf-8?B?SzMvQzA4cDhycGRPNEFDa0FEWFQ0Yld6VW4rWng5UDBielMvNTA3dmkyYjB6?=
 =?utf-8?B?UDZqSi9nckVnY0JMVjhpR1JMelIzSzhlQzN5ZUhQYWNXRmtNaFhHL2tGNndS?=
 =?utf-8?B?ZUtPcVZIdUp0SGJtcjExcWg1RkVja1AwdFd6RTZMRzgvS2hLaERuYlN6T1RD?=
 =?utf-8?B?K3JFcmNTbG5HalEwcmdGOUZ6TFlGK1F6U2k5SXcrRjg2MUJHUGZObGp0bmEz?=
 =?utf-8?B?OGhRallDS013SUJITVhHN2JGNms4ZUIzcldTYURjNHdrbzcrTnl6akRXK0ZL?=
 =?utf-8?B?WHAyUnFHOTZaTVAyOE5IMmVJRVZydHJ4Q241Skc0eGJHZFJocHhDeXg1dytm?=
 =?utf-8?B?NkZwcFdFR2RQbDA4WmpMNGdDUHNQN1M2VUEvaE0rTmVnQXIxcnNLNTYxc1V6?=
 =?utf-8?B?Y2tIazRaVysvYllRM1pHRHc2c1F5R2o2ZUZkdHJmVGJIZ1JacGF5NXpsOE1D?=
 =?utf-8?B?T3JOZ3ZtbDM0T0xURTRSUTdvTm9wbk44dnNZUGliUjYyYllMQ3lVZ3l5VGpE?=
 =?utf-8?B?TldOeEw1TWlqa1dLS1JCMDdLVTNkMkpsRS9Ed3gwZU94VlFUUFZJQzltcFpv?=
 =?utf-8?Q?iElrd2aaLqEBF6uwvvuB2B4xJ?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c7ece1-3ea8-4eb3-a77e-08daa7e0a02d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:20:43.0237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv4DduUJuvaZ2ZLFaU4cjlyqN8u+RgYQpBd9zI4uvkRYOeIe68kHFQAXzbcXQN9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5007
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/4/22 13:34, Andy Lutomirski wrote:
> 
> 
> On Mon, Oct 3, 2022, at 3:21 PM, Ali Raza wrote:
>> For a UKL thread, returning to a signal handler is not done with iret or
>> sysret.  This means we need to adjust the way the return stack frame is
>> handled for these threads.  When constructing the signal frame, we leave
>> the previous frame in place because we will return to it from the signal
>> handler.  We also leave space for pushing eflags and the return address.
>> UKL threads will only use the __KERNEL_DS value in the ss register and 0xC3
>> in the cs register.
> 
> This is unclear.  Are you taking about returning from the kernel fault code *to* the signal handler or are you talking about returning *from* the user signal hander to the user code that was running when the signal happened?
> 
> In any case, I don't see what this has to do with iret or sysret.  Surely UKL can use a sigreturn() just like regular Linux.
> 
> The part where a UKL thread has permission to return to a CPL0 context should be a separate patch.
> 
> --Andy

Yes, the commit message should have been clearer. 

The changes in __setup_rt_frame make sure that in case of a UKL thread,
the new frame should have the UKL specific regs->cs and regs->ds values,
and not have them overwritten with __USER_CS and __USER_DS. This helps
creating the correct iret frame in the interrupt return case where an
iret is used.

After the signal handler is invoked, user code calls sigreturn() as it
normally would. Once inside the rt_sigreturn() system call, UKL case is
handled a little different than normal. This is because UKL invokes
systems calls as function calls, so user stack gets a return address.
Also, UKL stores eflags on the user stack. This is used on return from
system calls in UKL, where we first switch to the user stack, then
restore flags through popfq. This restarts the interrupts so it is
important to have already switched to user stack from kernel stack. Once
flags are restored, we do a ret instead of iret. 

So, in rt_sigreturn() system call, we calculate the correct UKL regs->sp
by allowing space for the flags and return address on stack. Second, in
restore_sigcontext(), we again make sure that regs->cs and regs->ss are
only updated to user values for non UKL case.

Since, this patch involves both the signal handling and sigreturn case,
yes this can be broken into two patches.



