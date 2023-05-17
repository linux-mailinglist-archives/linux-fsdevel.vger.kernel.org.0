Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9C5706A69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 16:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjEQOBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 10:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjEQOBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 10:01:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D612D4D;
        Wed, 17 May 2023 07:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFozFO8g7Iug0KCS/fpmf3IL+FpOPqofdw4GkBHKxw/D6Hx6JXrAQYVbt03Tbp+STF7luA0GLaXAhurvykC7MSPA/N9wO6OEr+wIil8virwleaVJgtG5FYWZrbrE+ztJV/swjUKmDhKZdkc/teo2BClNEfyIIAoB44llWtKxpTKib6j/t9aqWKwo4ENX8VsqWsAilemwjSetTMGoBH7zoiN1wJla25PKSJVeY6cMWbi5yb76gL9pu9PINtq85+SCJgTM1BtFrZ7yRZVqvin8I5NLde9PuiSLnnWWLansZ8W0QWc6ZKdEQpmwiSp1bVGI/EVGmuGAdBKNNywdTSNakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcTr+4OjYS1N+4DTCyOhmvbpaVciTbnoVinbIPFl/r4=;
 b=GNAHSWXJEJWJYz4SG541pJnCBwgwJDfg+bESbQmHAhHEG5LZiOD1YM6x4dV/ZGLRU050dGlaQX9N3anPLObci6IeeL775UNtBGcBnAn1Nwb2uVA4QYMxT7I/ivSza8/0y8tZIYIq/Lz+8zTrr4PTXVNyFAmsUL71IBsnramTrRx4zkt/kNEgfXhtQqlbfV0XvKB8aZf2kY15vwn+3GJ0NAJ18gZQOAUktbkWv+zF8+hilGdMVFwd7bIrDlzfxGdYSsJMqG3Vm1bnL8hoHtBd9jDCQtEEHwGEdBaChlbaSvXdTA62g39HU2gZdmZju0c8Ow1UNzJYoXkQvEwmhrDAfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 BN7PR01MB3794.prod.exchangelabs.com (2603:10b6:406:81::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Wed, 17 May 2023 14:00:55 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::ef26:464c:ccdf:ee6b%6]) with mapi id 15.20.6387.029; Wed, 17 May 2023
 14:00:55 +0000
Message-ID: <6050b8f6-2cb8-3b1a-5068-cfed7737207d@talpey.com>
Date:   Wed, 17 May 2023 10:00:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/12] cifs: Pass a pointer to virt_to_page()
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
 <20230503-virt-to-pfn-v6-4-rc1-v1-5-6c4698dcf9c8@linaro.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230503-virt-to-pfn-v6-4-rc1-v1-5-6c4698dcf9c8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::16) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|BN7PR01MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a81b45b-99a3-4b01-b7ef-08db56df2227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbvm7AxkqnRKHm50B3Vs7rDR3YGd9gc/GePzXX1moa5fg/movmvmJjTCs05S2FXXjK/Z4HBT9vG4CMzlxMafdLtklBE/KoDOA2Iyc5LEoFrngbFMeBbV6tExZ7PdwDQ6K8NQjDHR+9Rpx8NIuIz31SqcstH4VS8GSZCtd4BGxfHIminYHZH+A/ao5nM0iM9/m+WoEYxHjYcWNFdlnKffZ6OjcHRkcrG13+H3TYGTDnxrJjFl+1QRSnnT5hpfZ+u7s/VJMcTWn1iuha4M6BSGj7qq5XMbSvseGzHbiRYRhI6k5qt9eIAZZRnn1MZBIjiPB0lNQ+Y00eyZFUK9LBz/TVqPwVBWYWM0BMT2IcSoPOtxvbX/o0OLIAN4qwIOKHjwPWPMnMvvHA5rnsisjhFIGdc006oAJ9cbLr5G0dQKLVl46dlkYpSn0EXkyM5ChGjY1aceBIjPN/MBYSurSnR0i0fte3N8ePA8uT8Cq1nmdF2t3C/zwvWKwMl3elj41X6rxOEBlSqKkOMYejYELJGyxV1nQGV4jTk28y/bw/WrOdVoDz7dsLVTV61SuSIPlq5W10hC98V7KlDpo44VFb3S7By9L2NAUusoPYJOtKNO9ZNSvl1ff4jcEb7juBqIrL8ItBk6wgaRhBe63XHynb1+KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(136003)(366004)(39830400003)(451199021)(5660300002)(8676002)(8936002)(7416002)(2616005)(186003)(6506007)(83380400001)(6512007)(53546011)(26005)(38100700002)(38350700002)(52116002)(478600001)(31696002)(6666004)(110136005)(316002)(6486002)(66476007)(66556008)(41300700001)(66946007)(86362001)(36756003)(4326008)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2I5YnJPNEZMR1RXd1h0ZnZpUHFCL0tXelRtTHlvZ3dWSGlPYnkyZGZPOWdj?=
 =?utf-8?B?KzVXd25IYUlPSTlHV0d1MUdDU2RrUjN1dFFsWVVnbHBwWERVVkp0eHB1SlBq?=
 =?utf-8?B?di9oSVRMZ29uYXMxeE1rWTlNK1hDbm9VYmo1Rm1hM2Q1ZDZhS2xYRFRlL3pu?=
 =?utf-8?B?bXZlK3hRSUlZVDBROE92YnJyYjVpazEvZFlqL1gxUnh3WGsxaSt3clppSWV0?=
 =?utf-8?B?UXhPdys2bldkZDdEeFdLQlNaMHlzOEFnRnpKZFA0c0k3VzYxYXg3b2k5RGxH?=
 =?utf-8?B?QlVLVmMwZXRibjFVM0dQTTRIampxYnVhL0J2N2FyZWQ2VExyNFUvTXNwVFF0?=
 =?utf-8?B?VHRZdzlQN1Q1aEgrNXRMNjYwTjR4TU9yaGdrcVQyeXFMaGNDUDYzdXFXUW8v?=
 =?utf-8?B?M2JiSnE3ZWRUck96V0tVaHNwditaVHZVaGdRN2pNdTdoaEdPdGl6WUl5Y201?=
 =?utf-8?B?M1JhZFJCRTQrcUNUM0tCeEJadHFXY0xUU3JhRVdSd3E0YTVrS241Q1lZd3NB?=
 =?utf-8?B?RG9vNHd3b1IrWXErU2RyWWtSK1pPRlZ0ejhjYmF3Mm5iRG1ERm9NaDJjTkx2?=
 =?utf-8?B?UWszS0ZyYStsWWxBcU1JVzd1ODVOWnFKVU1EMVR4VEIrRFl0eitLbkhVR2Rw?=
 =?utf-8?B?Q0crQ3B5c3owemRHdmtjYXlybG5LYVZMRkJxcmtOMXBwZXFwMnNLRnl4NFZF?=
 =?utf-8?B?L0xqVlpaY1FsWjBjVDdNQ2l0SEdYemd0anRzUUZ0YWxHUVROUEJPZ0xWNXBz?=
 =?utf-8?B?OEJBdHViUzFEQzYwR21xUS9iSGhTZWJBbEl6bXk2VG1ia3VlYlNKVS9nVi9C?=
 =?utf-8?B?Vk9SMDNNV2FvNHFWRHY5SHJrR0pORFZXVHVtaFRXai9VS2VncHN5eWVaWmZT?=
 =?utf-8?B?Q3RWTUpQZUhmV3ZFU0ZGWkUveFlMSW51eHdtWWNENzhwYWM3STMzZnJtcGQ2?=
 =?utf-8?B?YlVQTHp5TmtDM1B6N05LMEpHTWprR3NRR1FBRStkU1BhNGhDb0JDQjFwWW1D?=
 =?utf-8?B?aWlLTWMzSzdDeURxYzdjRFV4Snh0dlYyN1B0VW9nUkF1WlNGclpBaWppZFFY?=
 =?utf-8?B?ZWhlTVE1Q2o2dXFKN3VLYjRKU3gwN1JHRkk1WkJMNzRGSURLM3JPOEE1KzVZ?=
 =?utf-8?B?eTNOQlBtZUhoSzUvQ2UxOE5ZeGFwc1BGbHI0V010bEtFNkFBS3hqL2MzL1RV?=
 =?utf-8?B?TzV4am5ONHB6SG5kWFBCaklMZnY0MHJLeVl4WHl0R1NqcXNSQUFsWHBJd3dp?=
 =?utf-8?B?MzM1ZjFxSTNkbUkrYXBqajN5WDUyS2h1QWZrd0VteWxhblhuMmRmbGJtWTg3?=
 =?utf-8?B?b01wcEZDZ0t5ZnFTeGdvOXZlMWgyaXV1ZGRVV2MzT1g5Yk1wdFkzeDZSNExF?=
 =?utf-8?B?KzQyc2FpUXIvN09nRUxjS1RhMnpoWGN1enFBSXM3Y29yM3JlT3dmNGdGWFhO?=
 =?utf-8?B?eXVYbHdGVWtld0RmU2Z2Q0Nia3RFdVhsMm8wSWlMSHhxZG5wYmdCSFN0WjZn?=
 =?utf-8?B?U3NrWHBZZGFtUHNYU21ZRmdvRTBlV2VtUE1XakZUdE9GMFJiODhuWCtJN0sx?=
 =?utf-8?B?bEZPMC82Wll4SWJzb2dBbXlFM3NaRDVEU1QzeFBFbXNKZkVUeSt0T1NsdVN1?=
 =?utf-8?B?NGUzM2JudVBIMzFzUU84STR4UkdTa3ZtR1FFOWFCMDFDN0xFQkF3S05vQlBl?=
 =?utf-8?B?TlRlVGRWaGd0SnVpRTVLanc0bnQybkgvakxiQ0N1NjRoejBNS3R2dlY1MVgx?=
 =?utf-8?B?d0QvM1M4UFNodUY3LzFxZDdIOUtzbkIzVGlRaHhxbVNJdjNUeVJFL0hoKzlO?=
 =?utf-8?B?aEFVaGZVc252c3J2cU0zU2ZKYUVQUkZZellRNWNQMU1UY0Eycnh6eU1UZHFm?=
 =?utf-8?B?bGt4cm8va2NzMkhDNzczWTR3SVVGNW5zWkhmS0tyd1pZQUw3eC9SMWcvNW9H?=
 =?utf-8?B?bGNuMW1uWnlFTkk3Tnlxd0FwajIvT1J1djRIcm1TSjJNZVBWV05SbGxSZWNF?=
 =?utf-8?B?YmFJYWQ3NXNremYwOEMvR2ZPOWE0K3hTcW5jUUxxWVdiOFdTaFIxUyt1STJl?=
 =?utf-8?B?a3hwejRrUUEvS0VoZ2lJcjV5YmF0VmJNMzU2Q3dCYjMzeGpBZ2VndTRKbFZj?=
 =?utf-8?Q?AGRmpbsREZZ4P3W47fx0rDU9G?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a81b45b-99a3-4b01-b7ef-08db56df2227
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 14:00:55.5740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBudqqi/t63Ph2KzBu5BEfWSoeiJatGUeN2uPBgTgpvYLTCST5oPNO50SxPAp7kW
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
>   fs/cifs/smbdirect.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 0362ebd4fa0f..964f07375a8d 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -2500,7 +2500,7 @@ static ssize_t smb_extract_kvec_to_rdma(struct iov_iter *iter,
>   			if (is_vmalloc_or_module_addr((void *)kaddr))
>   				page = vmalloc_to_page((void *)kaddr);
>   			else
> -				page = virt_to_page(kaddr);
> +				page = virt_to_page((void *)kaddr);
>   
>   			if (!smb_set_sge(rdma, page, off, seg))
>   				return -EIO;
> 
