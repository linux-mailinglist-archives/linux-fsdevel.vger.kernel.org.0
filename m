Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAD9706A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjEQOBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjEQOBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 10:01:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB975FEB;
        Wed, 17 May 2023 07:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jk45MmP4D2BU61Wh0OSF3fWaodm8ntUO8rAa3w2a/UE6TdolrDoh6F8L9VVMIxQbG3/GTViPzN8r4dmD1OTXloB0q77A+F1b7/l92c+wmcqb5xgglfUid+xEmkrTyguCjbEShMzRiKVL3lkcEg5K+VLAiDOiy55Y2cyOQvI/Eb4IAMZODysWYz1uAk0muDnrpFQUGkF5cvvxI9Tlr5Rlwpl7wQFzou267YD6DEAO6wLFCtVx2xvNALzN+HbcsOvhjgl847u6/whewgP3BhLrgZsBf63F1vYA7Bfhb009LcrWkpNCWaQNO5r6buxko7Z5XQXEwUdveVr9Sl9c8bz6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0R5HnpCLdsb/78pwozWuz39kXCHHNrRHJlfIFqRfzA=;
 b=CY5ghDH0PO99jjKhAEoqyxLE0k/sn/lPW8r4vobfBYZWoa9Ayh/ROXSBu2oYTVDq83emeg63C53eL/y6nC15DAJS6QxJJvBJu1/3WkkiBj4hODepnVqn+rURP27MGDsiflVnmDcJ73JrqLZpd5IIzo10lXlWhPRaBM0dZh6OBMD/Ji3uvnBJVIgLo/rkZxQGQsAy9eIDinyx9Bus1p9pkEX+Jbnx5Vr1+O776WeU7aBThhKFdypv4y06IZxadGqlMXLNojscm0xFzfmU/qbLzSb41oU+STqSwg3oiy499/40k7TuEx3anNVptkmaOt6S6+trUEj/G1rDXcBYPhV/FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BN7PR01MB3794.prod.exchangelabs.com (2603:10b6:406:81::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Wed, 17 May 2023 14:01:07 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b%6]) with mapi id 15.20.6387.029; Wed, 17 May 2023
 14:01:07 +0000
Message-ID: <bd2abfae-b8d8-2416-57aa-49da7a9915dd@talpey.com>
Date:   Wed, 17 May 2023 10:01:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/12] cifs: Pass a pointer to virt_to_page() in cifsglob
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
 <20230503-virt-to-pfn-v6-4-rc1-v1-6-6c4698dcf9c8@linaro.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-6-6c4698dcf9c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::11) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|BN7PR01MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1966ef6f-3422-49e4-2146-08db56df2926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKhPNI3e+QpI7sZ0ui7e0hMC4cdKEcitEqtSzBW9RqDCcyahm6JFnXRvY7faBDQ5Ms5y0SNPmkXdMC75fQNayXHtTqE/5+sFL9Sy+yjmanXDTOFROujqPvDLu+QdTfixaO/UBgLK7ysBhnt2yJJ3QG7ob24upXbi0uCqbQMIx+TPg0hC/OyDG1sTQy9dMQyHt5D+9ItNCpANhCEgjCJl8ZOIS/2aOG6n/14VQZm6608rQCpPZI8ddkzO83Xsn38LEyS+vLF3K73OwJJzQelFKDqwDz+wm8zAhq75FMiHm2Bx+muLlGGcGY/4dTfL5HHLM8vqzAI1YT2eq+fhkUTtxiJEJ0ujyKfgAtKzzu7qLcyzhP152EUcVy/18bn83Uh+VkMz0ZrCPVFFM3EEEBZhK0VqLJI/iH0FbaIZKDtFLUETHyO5Us4hLhRApnoqMJDt6JBd9g8uxrxvUBcB7w3wcU5vd30F5Y3F8jgQYocK8vysa5YklZmlezpHqx2cr51mvXHbE4qK6yBeENbNQJjFuQ26XhYTMb+p055UB558vYDHtcjzTtW0MoHc2JRHyxUNZQHUoSCAt2G5LvANVDG9aHhJMTzUzjvBtkt9esRKShOO2RpUx+xz1GxVFQrN9EDjyjWIrs8RXtPpNaMbZ1CMdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(366004)(39830400003)(451199021)(5660300002)(8676002)(8936002)(7416002)(2616005)(186003)(6506007)(83380400001)(6512007)(53546011)(26005)(38100700002)(38350700002)(52116002)(478600001)(31696002)(6666004)(110136005)(316002)(6486002)(66476007)(66556008)(41300700001)(66946007)(86362001)(36756003)(4326008)(2906002)(4744005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1dtbE5IM1BxdFFMaDFLWmc3YXQ4b0tzUzhUU0N5S2dwdmRCN2lWR216R1hW?=
 =?utf-8?B?TU44WUlvVWVtYVFCWk5XUHdyVHZ4RFJ6ZTRtMloxbmQwREEwcE13UzRGb2NT?=
 =?utf-8?B?QmNzUkpxaWVxSWMxUDFMaVozZXUxQ0gzUUV3UFpXK0FJZkluU0lrRTZmQ0E2?=
 =?utf-8?B?eHpEM1h6bWhDVjA4dE5QTWViOGtFL0NsNktDQUZGTmo4R1RtU3VmUVBwYWdS?=
 =?utf-8?B?RmJBT2dwMHhIbmRiNE5pUnNNSy9JNGNxY1dsT096TlVrbytnclhjSGZGdFlH?=
 =?utf-8?B?MUYybFN6K3dmUXYvUUdmOTdVY2wzSm44RlNXQlVORTliUGpRaEVOdTQ2dzZJ?=
 =?utf-8?B?UkZIOGZkb01hYUoxdXBlclZFWDBwNHE2ckRObmdMTDkxYTF3dDdEU3d4OXBO?=
 =?utf-8?B?djJQMmh1emI3RGM2ZFZMbGJVT2tPNFpHdHVJLzhWai9mYUovek1KcHAwQ3Nt?=
 =?utf-8?B?aUtpaGx2K3NnWnQ5c2ZCelVYS3haK2pWNmpKNmI4cmg1QmhvN1J3NjFXV1F2?=
 =?utf-8?B?ZEw5YTRldWVhNktNRGZsd0FCd3ZzK3pVc0hiaElOUlpWdkd0cWp5b2VGNzlY?=
 =?utf-8?B?VTlFMzRwM0dYSEhVbWxuMTIza3Z6T2ZUZU5pZkFKSlBSdkc0TFkyVXNnMVNB?=
 =?utf-8?B?RDl6MFFuK2FDdm12SzBPT1BXaE9Xd2RFdlFUdUwvb2JGbzdPblg0QU5hSERh?=
 =?utf-8?B?blh6WDJyS0RsV1Q3enNtWVczMTVNZWtXdFZnRWMrbjRlTnA4Q2hFMnB0UGln?=
 =?utf-8?B?WnA3cUtWSkoxSURiSmJaZnJKait5bno5MWZpb1ptaDJibkt3YkZoSnlOR2x4?=
 =?utf-8?B?ekNMUEk4akdWMTh4U081ZDhkK1JtMi96VG1UaW96UUh6ZytTSGI5NXpCLy8v?=
 =?utf-8?B?RnZIZGFONU5FVk9oZ0pWYUxtczJjcmszSm5CejQwMGl1RkxZWEpFWGFvUnRs?=
 =?utf-8?B?dGdvdThEVm5qNUMxZGg1ZkJaNENTdlVQYWtVN2FKSVB6WHFHMmRkbFExVUFL?=
 =?utf-8?B?VGVMVzNPSDBhNEdlOVo3NTBiOTF1RFpUSUtESC9FbjllMkpkTkQ2TkMrSmw4?=
 =?utf-8?B?bC9Ud3VvSmdmUTQzemE5L3VFbkNRekg1dm1SSDRjU1ZaOUFNNGlqYWJOR3Rm?=
 =?utf-8?B?UFFiRHluQjZkL29mMmYyY3ZlSXFyTi9oam4zclRQbDEyTHpSRHlPSjhCaFkv?=
 =?utf-8?B?SXR1OFFPT2VTWjZxTFpyY1hmUlBYam9DQnNNbnRFNlRnd1FJY05tSnNxeTVo?=
 =?utf-8?B?N0c0OXVnd3RWV1paUXAwRXRDbW0zSS9nS1g2UEQ1MEFqRzZpMmE2VEZpT3ph?=
 =?utf-8?B?TFIrcHZmM0JjaW8wOTdhMFByclpxTnd5Z1FKbGZyV29tSkNKcHM4QUZKVWFK?=
 =?utf-8?B?c0RycE5renpicDFsSC9VQnhFVHBQVEJ6YXBKT3hMb3BUVGMzak9NZ2lNS1Jt?=
 =?utf-8?B?ZFphc0Y4SFFqNEpDU2tTK2VFaklLZDFuRzV0YzIzZ0tFSXR1RGpQeDZjT2wy?=
 =?utf-8?B?Z2EvcWFmemZXUDZDNjFMTnB3VkVtc2dTMll1WWQrOXNJK3hJS01NaTZEcTUx?=
 =?utf-8?B?RVgxVmNsMk5Yb2RuVzlsZW50ckN5eEhBUUlMT0w2Y1Y4Rm44QkQrQnZoSnV1?=
 =?utf-8?B?RDh2c0NET3dMUi93WVI2bWFpamNlbC9LUy9DSUVteVJEUVkvb0QzbENYSTNa?=
 =?utf-8?B?a3hFWjFIVEp4Q3VTUEVUM0Y3WWE0U1V0ZzJQaEs1TGlRelp1enY5a3ZNRC9B?=
 =?utf-8?B?NXVIYzUrRTgyNTRwdDhNSmdZVnFwU1FRMVJmd0ZGR2hGdU1wUEpHdXEzSjAr?=
 =?utf-8?B?dzRaYStpNXJ6YWJEZVExY2FvdENUcXArQTdiMHJBREFDNHNYSTRneW00cG9L?=
 =?utf-8?B?S0lvcGpicTlpZ2NaaUh0SUc1ZFhrWUFtWGxHald1U09menRPL3luVC9uRytR?=
 =?utf-8?B?blFVRlZjN0pJRXRlcWxVVTV2T0l0WG0wc05USUNoMmhORmZaKzVxMUNEZkNv?=
 =?utf-8?B?V3V0b1BSMVdOMnphUnFPMWl1cVFpYkoyYWNQREhDL1lLcVU5cmVVTlV6SVYw?=
 =?utf-8?B?MHdtQTZ5ekFOc1JKbzhuNG1ETFVSYThBeGdvbWdJMTRidUYwTnlZbys5YTRQ?=
 =?utf-8?Q?27qoJ/xFefoZTgyFxSv3pKhis?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1966ef6f-3422-49e4-2146-08db56df2926
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:01:07.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DstVk89vSlDEmosLCcRivC/WkwdUgfAvpfm3CORTspDeG0t8KZC7NKjQUXLLFY2H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR01MB3794
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/2023 7:59 AM, Linus Walleij wrote:
> Like the other calls in this function virt_to_page() expects
> a pointer, not an integer.
> 
> However since many architectures implement virt_to_pfn() as
> a macro, this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
> 
> Fix this up with an explicit cast.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>


For fs/cifs:

Acked-by: Tom Talpey <tom@talpey.com>

> ---
>   fs/cifs/cifsglob.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 414685c5d530..3d29a4bbbc40 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -2218,7 +2218,7 @@ static inline void cifs_sg_set_buf(struct sg_table *sgtable,
>   		} while (buflen);
>   	} else {
>   		sg_set_page(&sgtable->sgl[sgtable->nents++],
> -			    virt_to_page(addr), buflen, off);
> +			    virt_to_page((void *)addr), buflen, off);
>   	}
>   }
>   
> 
