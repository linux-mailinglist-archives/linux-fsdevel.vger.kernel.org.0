Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935805F7058
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 23:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiJFV3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiJFV27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:28:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2BBA244;
        Thu,  6 Oct 2022 14:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glpg9NaMNBwVZ47EAqJhmoQy5Ovde5grQOUSu1P8ddEhHHUCpi5l3DeNn6AvMl2iPdz6+1fR1ug0ETcNCypoU/IHCnjqBVratqTF3ArxuGKS7QUDTPsIr14f05mD8wZaCJTMXOK75eEfib44k48aJ0InehR/m3qs9QTki+bljnb1htE/InkjGwh56fQxJHCHLo+pkSXIjjYgecBqFIcNBxvg9C2v7F9h0rwQQqqh5epGNe/TWp+1cVzy5TXoXE8Rx+JSXwmE1yW0VGMWVehpPQy/0CtNYsm4ze0RGPbAOZRc0MCUaqBAqghdZsAck47DyMwHs788nTE/E53Q1OsIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH+4zZeyHoHjTmvRfvMSJcdsMjs4MLvjwFEQuPd9oco=;
 b=FGgZ7Lv90mQPPkWoptvjSXWtId/IAj1PS9aBk0IcLmbBEmpvmjlH1pcEeKD6iX9yOqqgW5/AMbgXDV6J97hk7wVgwTscdT4SflpTRDFERb4ijAd+YlLxpLaDFR/G9G9wQKL4IwICBkPVRSB0V2EaKs5UOZ+XLT6QDTQTllJv1ctkDCOEmvPD2jFu6vGZ/Fj44GBQHwK873vNaN0/dHh5dOyzcXOrUu6iI3bddOEAJ4Hiikm2E6/5FnXdtNvV5pUvpKTQIKXgiaWvno5xo6DkSNReYDvoIKvWteeh1BXxkxLvvCs3S7Oo/yXaVx8G6/L5VESw4PihbTXWKp3QO3u/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rH+4zZeyHoHjTmvRfvMSJcdsMjs4MLvjwFEQuPd9oco=;
 b=KwL8SqcLI04TLj1iRqs3LU4hMDG8i0DpmxGxrqNr85l+hVievaUzy+oO53tAinLsJJ+Y+k+dmmXzQM4iNhbgP8AuIS76vua69B7GL5GQdELpE8U3RaIq1aBh0sFg5FapbEnbFPQZvxGS9bNTf2ZPac+BLNpGUtJUqpdvd7q5nxSFo/jUFYv11yPQgBrnLn+YzvwRqeTcP7W8U4gTPJ8171n31FvgsICGImxaC3fd2r/IPAcKMgvff+29JSU+vXS5ox9WzkAurjM5mh1oLa0uEnYKUZDFJoEZ/xNbBEfceRxMltcncGTZcdohIWm8mKhYQabnJ029TcpliI/kojVJTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bu.edu;
Received: from BL0PR03MB4129.namprd03.prod.outlook.com (2603:10b6:208:65::33)
 by MN2PR03MB5007.namprd03.prod.outlook.com (2603:10b6:208:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:28:55 +0000
Received: from BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581]) by BL0PR03MB4129.namprd03.prod.outlook.com
 ([fe80::9e2b:bf05:79ec:581%4]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 21:28:55 +0000
Message-ID: <53c84c25-31ff-29d5-c6fb-85cb307f1704@bu.edu>
Date:   Thu, 6 Oct 2022 17:28:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [RFC UKL 10/10] Kconfig: Add config option for enabling and
 sample for testing UKL
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, ebiederm@xmission.com, keescook@chromium.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk, arnd@arndb.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        pbonzini@redhat.com, jpoimboe@kernel.org,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, rjones@redhat.com,
        munsoner@bu.edu, tommyu@bu.edu, drepper@redhat.com,
        lwoodman@redhat.com, mboydmcse@gmail.com, okrieg@bu.edu,
        rmancuso@bu.edu
References: <20221003222133.20948-1-aliraza@bu.edu>
 <20221003222133.20948-11-aliraza@bu.edu>
 <d2089a89-21a9-1e05-5d58-91b8411f7141@gmail.com>
From:   Ali Raza <aliraza@bu.edu>
In-Reply-To: <d2089a89-21a9-1e05-5d58-91b8411f7141@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To BL0PR03MB4129.namprd03.prod.outlook.com
 (2603:10b6:208:65::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR03MB4129:EE_|MN2PR03MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de5ff61-d8c8-452c-0728-08daa7e1c59e
X-LD-Processed: d57d32cc-c121-488f-b07b-dfe705680c71,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GKCxcmd5oR5bMTnGakK2qc7W8s1WnHUKKXfnYAtifdVmjjKoS2MTfqIR80bR3oo+wUxyNecTP+xVX08ZP/ZU+YeYMV75jKfifhzO/zMUczwhapHBZ/i3n84oTrGfBMfUw/rJ/ydXqubF2RMUQfGMvV7IATltwGv+Cjzx0IYmryTEDvX9L4Vj4XMG3i7UVlZrQaljNsr+TMN4XolBcjNuy8FQQF0jIDfbLYK6ldHm5WO9u3rDIE9bna6+YFSsedYSgomzPD14pTJJpWvDD70sPlu95+q4qioURct4vfovwMCv421m0NzznhSAU1RVzfp2Wgpf207cPrQsgu0AjoDBHx5+szCMCnjoUVwi5BiyS/fyUUJpVPmUcj3E06g35u+T88aNSMUECrS0ewLrK570URVf6HeCBa0Rrxr5W33sI1eOBg7x5mgOmgl4ogo4eW1BdBd/WFHRGgJjlelyier/NZz7EIkTmujuYABTg6/fC4oxUM77UiN3WHUQRmSBel8C1dxR5RJh6V7f/Q98VWdmkz6amQq6D7ynwXCuJ38ZzJR+sYtsUc8lCF6F5lK6rS8izd6e8ZoLYZULCSLVD+K5py6Vk4pR68RA63DiOQwwNshL5n3lldlXIV9m3+W6ND7KDZVZcJeevZt4YvsXrNIoumKn+IFsHM0RPbnlPf68Q2V6qppUxswc8kEDY36IvkDAQR9XeDhq06EhJ3qequyfy46F1NCPTkNpcHIL8Rx3DXyNGNZynWSipXepSLaSFrtprclz+VlMyACx2zP/OdWQvVZ9dxsrwTt6+qQdVfzsLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR03MB4129.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199015)(186003)(6512007)(5660300002)(2616005)(38100700002)(786003)(7406005)(7416002)(2906002)(8936002)(75432002)(41300700001)(41320700001)(478600001)(53546011)(6486002)(26005)(6506007)(4326008)(66556008)(8676002)(316002)(66476007)(66946007)(31696002)(36756003)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWdaR2dHVElsZEF1NjZSbUZlY0xkMzgxL01pbllGbnIrZ3YyNlFWZmpWd0VB?=
 =?utf-8?B?VVhDNjVhMUR2alFRUkpTbWxYSXRRS2JLZTQ2cEdJalhHN3ZSVXpDY2RKUFVw?=
 =?utf-8?B?TVJZbU9OL3Rxb2YwVlRjaWVOMXVHZjR2OFhrdmRmQTFTS0RiTnN4RUNScDZP?=
 =?utf-8?B?YjRTcFpWd3ozTlJpVFFldm1WQjAvM1pZMnRiaWMvc3JJbnIvekR5VmlNUjRh?=
 =?utf-8?B?N2tkOVlEYmZOdG9iRlMwSkxhYzgvdWxRV3NFbVYzaGE0Yk54cjZmeEkyYnIz?=
 =?utf-8?B?R0RQQUI0T0lvYUZzWXlEUytycnZmcEpadTJpYS9kUTNvQTIvVFBxcUEyaXNZ?=
 =?utf-8?B?VU9QcWFhTmNxSVFVY01UZTliTHM5dWUrSVpUdWQ1Qi9CanBLMStpTUFTQ0JP?=
 =?utf-8?B?K0hJc0tKcVdIQXlpbUpvWVBCZUovMjJvRzF4R3JhRWl0L1B4amxMT0tqK1Bt?=
 =?utf-8?B?ME9xT1hYbFBYUWNCa2hRSVdrRytnMVYwRkttNlJkdWNIb2Q0bHo2dG4wUVVh?=
 =?utf-8?B?cDF4a3c3M2FlWUgzdUJ6dk9obW56c0gxNDNJMzNIaXp4blJOV05pamFBcnFx?=
 =?utf-8?B?eDhxREZEMi84WXRRaHhLYW1kY1l4UmdMY2xRTFNZUDBaV0FrWmdLSTRET3Bq?=
 =?utf-8?B?dWlyMUlxRlcycHhOQWpHakZnRVd1RFU5UUNRMHhUUjE4YXF3MjhOd0x0SzhP?=
 =?utf-8?B?K3BDRWpDTitPNGRkMXFsRldrVEVwSFk1YnQwcUxWRnAxM0I3Ny92TFVITDJP?=
 =?utf-8?B?YkV4OGNMSTl1MDBrNFo1RjdyZ1dFdk1CTENuTzR2OVBzSWtaZmJ4UDIvRlRS?=
 =?utf-8?B?bFVXWWVSUm5jY3pIeGpXQlN2blVuaGd3bStwSDNLQ3lGcDJGZ1k4WHdlNFNp?=
 =?utf-8?B?RHR6S0NiZHIwWmNJKy9haG9qOEtPRUgzT2ZMMWhmQnovbDFQNkJydXBtckFR?=
 =?utf-8?B?MjN6c0FVOGZZU2JiM241b0llSFBtckExMEFUT2ZsVmsvN2d2WUZKS1BVbDRw?=
 =?utf-8?B?ZTJ2d1Z2aEY3SWlxSURIdFU4Rmp6Nko2cStRMHdzVXlKcGJwMXdZZWJyMUlY?=
 =?utf-8?B?MHh4S1dCUllaV0RmeUhZaWtreG1VaTVmd2JQQmpRU2ZYbkFvd2tJK2hSMW16?=
 =?utf-8?B?N05NbmZkYkduVUR4UlBKc0tUdmxnbXk1OUlGb2NJTU1Eb1Rva2oxWnpUSzV6?=
 =?utf-8?B?UUtHV3hWTGc5ajZ6Z05OZTJ6c3VxcERkR0ZCTVBzVDkrQjNuaUpwYTZRNkRs?=
 =?utf-8?B?Tnl4QUpkdjFXaFpGZCsra2pNRm8rWEdtTFVpc2x4UEU5Mi82M3pNaVI2a2hq?=
 =?utf-8?B?WDIvSzhPY1NVc3lMRThac1g0VTFDMWh0OGw1c1lmTS9IRzBJSkxYWitTTEpz?=
 =?utf-8?B?TVhONE1HMjlaZTFLWkZWdXRPU3kyOEpUcFVMREQ3T0RGZ3VXalcvcS9BaUpB?=
 =?utf-8?B?eThGeUJpbWRCSUVLOE4vanhUNmxZblp3Z0JSWWlsQWlLMzlBdzJTcm5mSjVL?=
 =?utf-8?B?VWx4M0FKUFh4L0ZvcCttaTYxWTBhQVJ0aHRNSFQ3VHRwZG5GODFzdDVpaEN5?=
 =?utf-8?B?SXI4VytIQUI4eDFMbnM3VU1Ob0h0a1I3dzEzSFUvN29zNHMyUm8ySHlRZUF1?=
 =?utf-8?B?aE93UHduOEZrcElFS3NMekpIdlZlWnkrK0dRazQyQlBCZER5MlJxTWdRbGdF?=
 =?utf-8?B?NTFSRU4zeE9VVE15bnN0WWpZZTlZMmVNNFY4N0pNWCtITzRFRE1mZ1RrOUph?=
 =?utf-8?B?YnJHQzl1N0trSnltU00yU2pXTjZSZ2VhZXY1YmZHL0RwLytnWHhFVmFleHJG?=
 =?utf-8?B?dmdXNUZzTHhTRG9UVDJGR0VjOHBsY1VKVVpMQXN0amR2ZWtINWNHcFZIQzcz?=
 =?utf-8?B?dFNXdWp0bXcyUisvd01zZHJlaHdnYWs4M1VyOWNsdW5uaDl3MFFFa0FPbk4v?=
 =?utf-8?B?NU5lK3k3Yncvb2FRcnBRa3pvanZkT2hPWTlyRWpHdTQzMWpCRFZucG1CTjg1?=
 =?utf-8?B?U2M2NmVTaU82WHBSY1J1eE44QjFPK01UbzBnZUtsUjNReStGVHBGT1k4c0t3?=
 =?utf-8?B?THpjNVNDdm9MTDNYd3JvTlEvNmszSC9rNTlDMHNlT0VvejZ1QUcrVmsrRHMz?=
 =?utf-8?Q?2I9gfV3p/zj0nXZdLRq4+Op/Y?=
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de5ff61-d8c8-452c-0728-08daa7e1c59e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR03MB4129.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:28:55.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kleVeVS18y3QLTJpbYaFnYbAcYgznyCbvL6cTSD/8DzUBIzORvlSeSIWq5gxsepF
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

On 10/3/22 22:11, Bagas Sanjaya wrote:
> On 10/4/22 05:21, Ali Raza wrote:
>> Add the KConfig file that will enable building UKL. Documentation
>> introduces the technical details for how UKL works and the motivations
>> behind why it is useful. Sample provides a simple program that still uses
>> the standard system call interface, but does not require a modified C
>> library.
>>
> <snipped>
>>  Documentation/index.rst   |   1 +
>>  Documentation/ukl/ukl.rst | 104 ++++++++++++++++++++++++++++++++++++++
>>  Kconfig                   |   2 +
>>  kernel/Kconfig.ukl        |  41 +++++++++++++++
>>  samples/ukl/Makefile      |  16 ++++++
>>  samples/ukl/README        |  17 +++++++
>>  samples/ukl/syscall.S     |  28 ++++++++++
>>  samples/ukl/tcp_server.c  |  99 ++++++++++++++++++++++++++++++++++++
>>  8 files changed, 308 insertions(+)
>>  create mode 100644 Documentation/ukl/ukl.rst
>>  create mode 100644 kernel/Kconfig.ukl
>>  create mode 100644 samples/ukl/Makefile
>>  create mode 100644 samples/ukl/README
>>  create mode 100644 samples/ukl/syscall.S
>>  create mode 100644 samples/ukl/tcp_server.c
> 
> Shouldn't the documentation be split into its own patch?
> 
Thanks for pointing that out.

--Ali

