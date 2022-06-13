Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1225482BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jun 2022 11:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiFMJLo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jun 2022 05:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240575AbiFMJLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:11:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20D7FD10;
        Mon, 13 Jun 2022 02:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0fYiUSpYrXIErl9KKak9LKrCYqPoZv5c0Cz0ALIr9F/uhPHf0Ui9jHr+r2V8U4fiTabu1RhSllv7vsywHEeIKn6LFDd7aaohqDMjs8f5B3aLdDvA6JMTS10bl3cDxGlWxZy6OpN0zB60TYCXViP//HsMBFZ866ZN8pO7cPudRIe1pQ98mb4GTFcO4PPyMPGuCflfEj59fwUfSfmqaG98upgFq4IaWJsat8KTqH7741R2Ym6ZzC+NcuNDCZno7kdXZ5IDxol0rcTxB9epCTq1i8wj4sbFsijp0dW+4d8HRmpUrEbBXNIv5kRmd5CAV6BENfWdvFcNMlB8z8bA2xhjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1hRyZF0n1k3WK/gUiUoUBk2k5i181fSZVUFzIcAaAY=;
 b=Df7cOzI9XmTBvw/5XsezSVbkuMgNRS+jCLgpZCEbDewgRueIjuNLHayGxkqfi53ZLaETtOjtUBYMv0B9lhsXoR6LamSwvC8h7lPWw3U277B71EgyBurpR4H2joIWuH7BEua91jZId4wNzzzvL8XhE6X2ez4YJU4WolJcCBPPCsknLB4DB98gOmZ+PtqtheoEPOXzVzoMYbwH3I2lieJ0O67LRaPHgZb2FaFuTvtsYEQK/Nc/MYWmVoYDgrA04QxiUMrTf0b0nNwKFtMImegc52+Y7tW4LAsM8J3coHgKJqLOGn6SujjMR59gAQchSCI+rVpJagM+fl2Wz5DFU7sSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1hRyZF0n1k3WK/gUiUoUBk2k5i181fSZVUFzIcAaAY=;
 b=y13+Xns/52bRyQTEj17yOWG3hyRAqT+9OTwx2FANBwsCA+PeAJJOhoE2Hoe2F44srCaNhS7QTJU8N8zTikolqVs4T+4vKrNT7YHk8B+LVxAOH3k1WXmEkU7aITwZSUFk/Xba2YzNpuz2FzmSgK27JIpnln/8z7RndvbEe1N1mD0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 09:11:39 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5332.019; Mon, 13 Jun 2022
 09:11:39 +0000
Message-ID: <081e264f-c60c-4d25-e5bb-3f135f5eb270@amd.com>
Date:   Mon, 13 Jun 2022 11:11:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     andrey.grodzovsky@amd.com, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, daniel@ffwll.ch,
        linux-tegra@vger.kernel.org, alexander.deucher@amd.com,
        akpm@linux-foundation.org, linux-media@vger.kernel.org
References: <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
 <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
 <51536e97-ca5f-abe4-b46c-ee3eb57f891e@mailbox.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <51536e97-ca5f-abe4-b46c-ee3eb57f891e@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0301CA0001.eurprd03.prod.outlook.com
 (2603:10a6:206:14::14) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ab5217a-e11b-4659-64f0-08da4d1cb931
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3483115C70464740B70424B083AB9@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZN5ycR3OU50XPLYsGCfHvXBYeTKaWFFzh4UysirhANDq93Gcmm/86wmXPWwtjdmeVRj2mdpo01ORp4DsxGjfmzS7Cb4kjzr90QxoQ/dmUyAc7FpRY6W+LcPx06yth1rNYVod31S5pOH5v4XnFrcGdFE9cSQe7ao21duTpAPHItl/ynfW6k+REtSJ8JMPfEvH5sRuNpZkUljJkTYwlUEOU3Bh5EVJfFP89YKfMEou9/sFCLW+U5TcQH01Dl1gONwI+AYPZ+fA1HwEws8NaTgxyQt6I1R9dYa9cirCWSMRr2NFhaZsrGSMYIJgAo5ZPDDbxnEGDLRjVvo+h0qAf0vP4uu8rMIuOunlYvDKMbqY7+kJkRa5SpV8umOmhjZKj9yVqBcnO/4roRHM57hE7YMB4Ot8Q0swMiL4x3CHwIXy5X3n6r74/Kl3FjbFea24gkcRBgnbuJ48tBWjJaah8tJcjXVokj412BALYCA6Ktqz5iFcK58gTitPhdAtS6bdfs+eS4TpBFixvdM80jsr2dd10qo66CpM4JZWmT8jZxUfnblwua4mZl/I1y2n+ZdH60a4rP7ZHzy9NfKeYmelwgHbDR+ij/xVmoat93gCe/rD7Ctt7pgYFVDZkWXjnemrM0fvlQ5ixBAtM8Uq8GusSWhN4XNs0oJY4oYtLrpRVpWY4HFga2ZM5WSW081oFcVUj3DGqAoUCytYnc7KHpO3sw6Qv+4hkmRKd2nqeJKF0bxxG3qnroipSNbF0SqDTSYbDfE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(6486002)(6506007)(31696002)(7416002)(508600001)(5660300002)(186003)(83380400001)(8936002)(66574015)(6666004)(6512007)(31686004)(2906002)(2616005)(26005)(53546011)(38100700002)(66556008)(36756003)(316002)(66946007)(110136005)(8676002)(66476007)(86362001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3hObHpKcGY1QkhFMjVscU55VXZlQ0p5QVdrRUNWaG8xa2g4bEE3R3JBQ1Bp?=
 =?utf-8?B?ZW1HUWdIZjZJSkU4M0Q5K25yWVcyVmFrcVl4a0dOV2w5WEVVbjFLWXVaa2dv?=
 =?utf-8?B?S2Zja3laMUtsb1lmZ1BMVXVra1oydE9tbnU3cTltUmJaMzY4NndZSkZxZFVh?=
 =?utf-8?B?RzhNNVc0NXc0dVdNSE5NNmlyZnhHcElkTXB2QXM3aTUwSjZtQlVDRWY3Skow?=
 =?utf-8?B?WS9qa2FyMTAvblNiZk40akUrN1RmMEtlVTFyUFpCVkN5aXZjdUhGN0ZlV3Jh?=
 =?utf-8?B?dWErOTUrRHJCSDVrek9rcEkxYTJyRVlmOW1hV3lFT2dnak53b0dxaVlRaXA0?=
 =?utf-8?B?YUUybkpSOVo5VnRWcWRFQnVRMjVTR21sLzhpalNRYW0yNTBmRGlVWjQ2T3k3?=
 =?utf-8?B?TWlIbEtzVHJCR1k3Qy9MZHJZakt2Q0NPc29FZ3c5ajdTdHF0T1dhc0Ira1gv?=
 =?utf-8?B?UGt2QUFtTzJ4eEJUYjdIVlZneExIczRta1pzOWU5YUk0VzJFZ2UwVmVXWjdQ?=
 =?utf-8?B?aXlzRk1wTmNobmdaNmQ5SW0yRzd2MnJyS1JmNG1Kb08rN3IyNmFkdGZKMnEv?=
 =?utf-8?B?d3BwTHZHT1FDR3AwQUxMOE5sQ1ZBaGdsVndtWmZYK2N3UkpIRTM3bUVua05o?=
 =?utf-8?B?OGFHVXRiblBGMU92S01GUnZURFNrVjBQVFJRZDdiM1ArLzR4TC93dkV1VU9G?=
 =?utf-8?B?R0NMbUxFdkVaWDdlbnJqTVhxMGg1cUdmV1QzVCtQK2NxWVdCNnhCanUvRXZZ?=
 =?utf-8?B?MjhUaHB3cTNHcGN1NzJxT0NHRFBNNlBnMHlPZGRra1czdENlYWkwUW1ZRzZH?=
 =?utf-8?B?blpCa2xOcW5RbHgxZEEzdDNDQjg2WVRFQ28zRkpFcFFYOFM2RTJaUmFudlpo?=
 =?utf-8?B?VUVIeCsxZFVybHRrdTluS1hXNngyOGI0YlBiZUpQTy9FTC9NTUZkWEFyYjR6?=
 =?utf-8?B?ZE5EcWpQaXhqVFlHNkRCNmhYVFI2M3RQa0xSNncwSHpKM1BTUUlzN3A4eExj?=
 =?utf-8?B?djRLeURsbDBmYUhzUS92N0xvYjI1R0F0WDltUVRYSEF6VkVvbUtKeGp3cGxT?=
 =?utf-8?B?dkdWQ0lrWUl3UXppcE14bUNXSVpYeGMvcSsrdU9RMWoyb0cwZmE3R3RaSGNU?=
 =?utf-8?B?Z1NsTGxLeWtiWFQ2cXRYb2cyRmN0YVNadmtZVG1paEhEckh2UStvYy9rRDlV?=
 =?utf-8?B?d1FsQ0F4enpubVpDWFlsNFZXZ21Ba29rYWQ5TDNYRXM3UGpUcE1MekozV01P?=
 =?utf-8?B?MFZRMkMzQXp1MmtSTEVnRHlOL3VNM1h0V042cG5FRnhUSjRwcWUxRWhrYW1s?=
 =?utf-8?B?ME1SeStiV3FnUjlZdFFWSEcyUVFOUTVSY20yWHFkYldzcXFtRVFBUTFjZ0Nw?=
 =?utf-8?B?QlIxK1BMQWs5ZHFsTHZUQ3ErdGg2VmZGVThIUFdZajlhRytMZlJ2alNxUzho?=
 =?utf-8?B?S2VUc0hUamNyWCthNDIxYkJjZVYra0ltK2pTUC92OWlyWlNQVUZZTVZlY3o5?=
 =?utf-8?B?MHRJMTlhZzd2RmNWYlpSZ1kyT0dHc0g5STc0VmxlMXpPZU9idlluSlF1ZUVy?=
 =?utf-8?B?bThINEtzaHBCeFRkS1J3bHE2dDJUbXFKL3V0MVhyWE1rL2dHdTZmYll1aVRh?=
 =?utf-8?B?TnRyQWJxb2NibDNON0lCNHR1R1AyMlN0Wm9zekZCdHM1UysyQU9td2tMSFIw?=
 =?utf-8?B?QlI3ZjBYNTRPdzNZL0pZTW1kV1YxcVJJVlpGLzI0T2FGOCttRHZmYWtkWUJJ?=
 =?utf-8?B?RFI2VTBkTXJXbTYxMjFCUDFFU1U3aENMdEJWdmpjRlNhdFF0TTlHSjFmY3Bw?=
 =?utf-8?B?WmV5RDJYbUpqMUl6SGxrV2ZtRDVQdnlsSmNyNndkMVVvMDNwQmk2eDBYT3Vs?=
 =?utf-8?B?SThmYWJDMElsYjFPajRKTnBiUERRUFJnaGpqaW9uT1AwME9Pc1llS2FWbG5Y?=
 =?utf-8?B?UW9sblduRU96NlFGQ2pydStZUHFzVzZycnRYLzdsWlpGNTBjZHIxbUVYOWhn?=
 =?utf-8?B?NEpFdC9selN4aURFZDZPZGpUd2grNitrQ0hxQlh4cHVGLy9zRkJlek9kMkE0?=
 =?utf-8?B?VkExSUxYZjVQOXpSL3lrMVA5dWk4RkpQLzVhcUY2eUU2TFFoMExJcXBuTjU3?=
 =?utf-8?B?WTlLOGhSelZvNXcwZ2dxdUl4MW05ZkFWME96WnhEOEFSb2k0alNiQ1dySE1u?=
 =?utf-8?B?YTBhT3ZmekExT29BUEZISHJ2Z3N5Q3MwNTBxQWpIeStzTStRT0Jka09RNk9R?=
 =?utf-8?B?RlFKSVVHd1psVndyM0Z4N1BKTm5jOTNYKzlqLzFPUk8ydDVzSG9OSCsrUTFD?=
 =?utf-8?B?MEVKNnJ1WUlCRGZFSTNsMVY4RWFzNWcwb2luTVBYMFA5Nm1VbUhIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab5217a-e11b-4659-64f0-08da4d1cb931
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:11:38.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: po9bmp363bgeo+0TwN8/68GeOvnCYriW6hdj4l5V+yvhyumlnQlQiQtv7Pm+DxZZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 13.06.22 um 11:08 schrieb Michel Dänzer:
> On 2022-06-11 10:06, Christian König wrote:
>> Am 10.06.22 um 16:16 schrieb Michal Hocko:
>>> [...]
>>>>> Just consider the above mentioned memcg driven model. It doesn't really
>>>>> require to chase specific files and do some arbitrary math to share the
>>>>> responsibility. It has a clear accounting and responsibility model.
>>>> Ok, how does that work then?
>>> The memory is accounted to whoever faults that memory in or to the
>>> allocating context if that is a kernel memory (in most situations).
>> That's what I had in mind as well. Problem with this approach is that file descriptors are currently not informed that they are shared between processes.
>>
>> So to make this work we would need something like attach/detach to process in struct file_operations.
>>
>> And as I noted, this happens rather often. For example a game which renders 120 frames per second needs to transfer 120 buffers per second between client and X.
> FWIW, in the steady state, the game will cycle between a small (generally 2-5) set of buffers. The game will not cause new buffers to be exported & imported for every frame.
>
> In general, I'd expect dma-buf export & import to happen relatively rarely, e.g. when a window is opened or resized.

Yeah, on a normal Linux desktop. Just unfortunately not on Android :)

Anyway even when this only happens on game start we can't go over all 
the processes/fds and check where a DMA-buf is opened to account this 
against each process.

We would need to add callbacks for this to make it work halve way reliable.

Christian.
