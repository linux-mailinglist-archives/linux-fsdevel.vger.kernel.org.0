Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD464E2FF4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 19:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352138AbiCUS3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 14:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiCUS3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:29:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0662123;
        Mon, 21 Mar 2022 11:27:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LGiAMb027089;
        Mon, 21 Mar 2022 18:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WePvneQyjaUr3Be2+urm2wFkU4ru+Ufljou7zFQlnaw=;
 b=BcUvpd3pv4n6VqkFUdPn5mOZABKI0CDzxk6omGETgrXEznnX1V7yPkoaj8icH1ueO5Fs
 yGDx4RQfDkeK5/8pwI3bIyO0jMEBn2L3XV20TfcJXy1BgeOfD1P6bU/MmBjKeS5t0aZl
 Q2Fo6Cub3SQdqTTxL+tBa4CbttV+PRrhM4fyWexAulxWxwqJfHV/u3+l/BwJyDf5Afwe
 XGcnjiZEK64kj3rhAeQ/UtQSBnUWtfJGINXpUQgXvhQV1ggR5935K8K8jFygq8CYFt0u
 6wfzu+IGhcUIaYpPO7ENiXd5fUTqrOSZxcRu4qY1JPkMANjXZUnnI5I9D285KizlihtG bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5kcm5qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 18:27:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22LIFXp6179877;
        Mon, 21 Mar 2022 18:27:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by userp3020.oracle.com with ESMTP id 3exawgwvsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 18:27:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnJH1U6tzyF5hhf1RydLC/NIhSI6JfZkFoYTrltbvg3rHS8Mg2qsShqtEeYPbN59bYYVTmTrhkTGGr8a8Vv2BrBIlkcHJMRDv7MqIQr300YJeLBy9t5cL/BBFo3iHjaLJnlZxDZmTNXweC9rnctiIezK3SS4Mn4poZgSJ2SH7YWY7VB93Rw6QXK6EyZofR7FMssjmBWGKfWrT2nKxRgZoJPzojx4XiTObvTkKqxiq95/NyPO0rXnlVS3l5f7JmHd+nrzaceqvrcY+vprEzKsbtIR07xnimXbg2/79O/soD4WdntsT4uDA6hmfPSudiFqMpBbvbJQKvl9FuMNTxqYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WePvneQyjaUr3Be2+urm2wFkU4ru+Ufljou7zFQlnaw=;
 b=F11Sf37UXOUSdIvJu5eaPnWBqhQ4rdlla0B3g+4KdvMMNSK/kd5ThxJspK6ru19Gbd9877Lgp+xGbs3nLQUq2NPP5aAedU1QDAeBuaFqW4uH7AHwGo3tslajFM4UutQCBy4Q3+cjnqkv7ELTpAD3dG5xo8FM+XLvC6hLee0dTL+bHvblJ8BrgkBUohqapqFS5Yoi6gXnZud9fW2mWyhm+gD9sd3wI6hEhbGfnqqkI1QneRVjDPBBQ1woTKwgLQiIHLj7iln7PtSOZS2fhcbQyXrsfDTHtdkwhG7+kc5vJJ8o7OBp1WolnnGpL0Y8clRCMID4EcS8E1IBkEWghEp7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WePvneQyjaUr3Be2+urm2wFkU4ru+Ufljou7zFQlnaw=;
 b=kNZSmtMNc9b/YhhkuTxCy4EG+hp+8hgba8qcjPCUsLpa/nUZX7M7ExcGLtNgPVkKZw7xsXrKTM33w9JKnLTdSsbuknE4AvT5kQslMh9SrfUDgcz5GtVl1SM6a6gDVjJAUKMInSXULDVGoecH6N8OXLYA3Cj5ry4iiCBKbA3NwIs=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN6PR10MB1281.namprd10.prod.outlook.com (2603:10b6:404:41::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 18:27:32 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6075:ab9b:a917:ecc7]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::6075:ab9b:a917:ecc7%3]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 18:27:32 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] namei: make filename_parentat static
In-Reply-To: <20220317014859.4292-1-jiapeng.chong@linux.alibaba.com>
References: <20220317014859.4292-1-jiapeng.chong@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 11:27:28 -0700
Message-ID: <87sfrb40vj.fsf@stepbren-lnx.us.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:40::24) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d3698d-a744-4783-aabd-08da0b6876bc
X-MS-TrafficTypeDiagnostic: BN6PR10MB1281:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB12815A9D3A0588580F26BB3CDB169@BN6PR10MB1281.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cul0IXWj85GfNMm3i7YN5EMevkiUq4S7ZfLzknuND1AYV5IM7KeZswyinVBibT4q5vLVXsREoSutP6G2GZY5l4UZicevqby6T9B6ftFe1Jine3AW8XP8X4B7swpQykBTM/z0yFdqWNqPIsIFk6BzHZ7lFB2SijY5oFUDMVuSs3SN8VBNJIo2f46XvNN8Q4xwNFTCGzNR+pbOKYOxtpt27wIU/Nmxwv7Xrt4W1EbGp4OEFzxDpj2++WcOsLARuod0MXDXvZRCgZ6O2cWHalJ/wFFwx9a2g2OhKp8+4m005ZowVGNf/ojKXxuyKcKxKLkolOuZjL4ArzwTpMtWmKYY5PxP8ZoBcNXnw89tZzr0d+hPyxLgZwWI2ZThBO/MhF0ZqS0W7ItXrdJS3ZF8j0QXkEJM5XDLAacw3mPtOE9LxunFQ17p2hAiyIba3e7gujebO5Ne+hZ/dKbxyhyPVCdIwr9kg50HTSoBb7JISeE5NBj7218D7OsaXdR80g3aufa+s8Od8C62cMXJD2ZXccwuRDPHHLVvJbQ3AzfiWJvF+XVwkhmKcS6BxtEg1U92e/X5Nhq8PMUPSnIej6hZvmzcq/S8njXKtNWW+9pqC70ta4rPJItesZSMvos8ICfarzPSEALmpt3CfcrXbLH7YkeDCB6YjTFFZUGjdCkBqjg4nAcVigJAajnPGWEixV2sV+OdFpcW6RiwN3PFjBLuGih3wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6506007)(6512007)(52116002)(2906002)(6486002)(38350700002)(38100700002)(86362001)(54906003)(316002)(5660300002)(8936002)(508600001)(8676002)(4326008)(66556008)(66476007)(26005)(186003)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5TZVphUG95ZTVwYlFqbnBFUUJ1TjRBaGk3MFBvdmM2ZHY5MisvSGNJMkJQ?=
 =?utf-8?B?ckI4MlR6V3RKclB4bnRRd3J3T0hJTW44STFTTjB3MEV4STVDVFFsa2JkU0pB?=
 =?utf-8?B?bFd5UStSdkdtZnVtWExkM2g4QTdnQUFaYi96Mlk3aVFCbTFwbDRUTXV0R1dv?=
 =?utf-8?B?SkFwMDk5NlRFT0VUb3p6b3VKbXg3S0xoK2QvK0t3Q3ZaR2VEYmdlY3lKS3Ny?=
 =?utf-8?B?S0E5a1M5aU9wazkvZjVWSnhBSHBpNTNaVmZiTzIxTXdRM0h2cVBIQ0NRMjYw?=
 =?utf-8?B?cTR2TzY5aGNUYVg1TU0vbVlpZXN1M0dQNzVYUy9DRDV2dkxmb2pxcnc5Q1lB?=
 =?utf-8?B?OVQwcDNhd2Nhc1dkNVRVLytXemJ0QWMrbHdMUmJvaTV2eTJkb3IvaDhqcGRV?=
 =?utf-8?B?RncwYXFKdUhLZmgwYlQrUnhTM1hhRGZPVXM1NXVZbzdVUWhHazhmcVpMcEtB?=
 =?utf-8?B?a3hzb0EyTG1rTHF0UHNWZTZueGhPMnFsT243K3lLdUoxckdKR2I0cGozVUEr?=
 =?utf-8?B?M1NmV3hYZmE4cnVTQVBZQ3lneTlRaW5aSlNyS1FmMEd3RFIvSklmd2ZwT00y?=
 =?utf-8?B?MUtCVmZYelMrNHBjQ3dIMkNCSDRETWsvYlVRdHJqQWl4bTFXRzdObFZaa0xH?=
 =?utf-8?B?QkFUNC91L3UrN0ZkVW5JMWVVQnhNQnpsRXhvREdlZTlHS3lUc0pkci9tZ0xk?=
 =?utf-8?B?c1JnK1lQaTRMbUpSd0o0RVNvZHNHaVc4K2FCYlU1a003Q0hub2gzYmZZS0Nw?=
 =?utf-8?B?aHMrY0hLNVR3cDhLRFJCeXBUKzhJLzV1Qkx3M2pqdmFDd3M3eWZKalBBMytK?=
 =?utf-8?B?ZTFPRUF2eFh2R2YrUUZwb3ZrZERWbjlrWlFBQWl6UWxtTnhvZEhQRzVjcmFl?=
 =?utf-8?B?UTNEckpVV0htbHhiamEyNVF6b2ZmWGRhaVlJVjdHbUFxT200aUd2VDIybytS?=
 =?utf-8?B?UTU4cWdEdFNRNVZqMzJIVi9kKzI4NkVFRHl0UjJWTG1ON2U2cVBtelVBbzRq?=
 =?utf-8?B?WUlEdUpZa08zTUwxeDVrbWVWQ2lBMzNUVlF0V3BHa1lXRExVK2xuam9iMHMx?=
 =?utf-8?B?ZG9nRUI1OHgrQXhNTUd2SlRTWmVoY1VoeVF3MGxSczZqSXJLVlNKekp4MXl1?=
 =?utf-8?B?MXI3bUs3bDZ1bXV2cUJIckcxSUtwbmFsVmdiRFBRalc0aVg3Tlh5ZzdRYzBr?=
 =?utf-8?B?WFhSck01R1VTNzZuOUthTHY0emdzQk9Wa3MxYTBISTNKQTFqNllod20xc1B2?=
 =?utf-8?B?WndzM2s5emgraUsxN2h0UVU3R2JPQ041dEM1dzAzdHNKdG04T2xUQVVHUnpF?=
 =?utf-8?B?VjZkMzF2RnpGWGZEaCtOVGZWMFRBaTJkbkdxN1BZZnIvOWJMclNTS1ByY0kx?=
 =?utf-8?B?SE9CdXhjSXBQb2JKaEV6bHQ2dEJFQmFPb3YyK2MzOW1TZ3BXRHpZb2p3cU9u?=
 =?utf-8?B?b0cxM1FnVS91c3FDMEhKbC9nUW5CaWZ4RklpSWwwckloTG9pY3ZNdDF3OUFW?=
 =?utf-8?B?ZFhDSERXc0JFZi9mVHE3dWUyUWo5WjdsN2puSTVOUEV6WEtJblc3NzA1cnpk?=
 =?utf-8?B?MFlZdkxGdnVGQ1hNOWs0TzBBUUFYaXFmbUdGZzBHNkFJZlJ1YU1IU2QwKzZW?=
 =?utf-8?B?SXRkb3VqMlp0VGtLNnNXSEhLRDY2NVVVL2hkaHpDWUpmU25iSmNXZ0RzMFJx?=
 =?utf-8?B?aEdnRCtHTXR2UTdSRUEvVXpjdEpuVVJQajJrTElYcXUzTDJvMUJGVWRZQ2N3?=
 =?utf-8?B?Q3pjOWtLMmZoRGt3ZWVTcWlEdkdoKzliSVdobDZPUkNNMG9JSCtGVENwWmEx?=
 =?utf-8?B?dXA2SVpSSXloMkZIZDltTCtIMjNhbEtvOFpsaFdRZUJRcXcwSi9LbmRQRFVY?=
 =?utf-8?B?a1FCaGNYc3N1cmE0NkhQc3g1L3R6bkNIdUN0QWJ6aENBN1NmcGw3b1J3SlRu?=
 =?utf-8?B?SXhzK0ZMRzkyRkVlUEVIYkwzdHMvSkE5QS9GUTRaUFRzNVhLYUFTYWJXOTd1?=
 =?utf-8?B?YWErL3N5eGlBPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d3698d-a744-4783-aabd-08da0b6876bc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 18:27:32.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbpwJW4HS8LWRMX7s1UA1eQjuMWjyoCvgIhkCNwy1I3qKAAlPL9TdmeQNJV2NzbObF1MAV2Sxrw5spm6AlSomYc81qzlfPyoFAhoO1SXNjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1281
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10293 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203210117
X-Proofpoint-GUID: BRgbSX7G1VMPVvNTV8fsUcVwYEgEAYaK
X-Proofpoint-ORIG-GUID: BRgbSX7G1VMPVvNTV8fsUcVwYEgEAYaK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> writes:
> This symbol is not used outside of namei.c, so marks it static.
>
> Fix the following w1 warning:
>
> fs/namei.c:2587:5: warning: no previous prototype for
> =E2=80=98filename_parentat=E2=80=99 [-Wmissing-prototypes].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 44c366f3152f..fe3525807361 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2584,7 +2584,7 @@ static int __filename_parentat(int dfd, struct file=
name *name,
>  	return retval;
>  }
> =20
> -int filename_parentat(int dfd, struct filename *name, unsigned int flags=
,
> +static int filename_parentat(int dfd, struct filename *name, unsigned in=
t flags,
>  		      struct path *parent, struct qstr *last, int *type)
>  {
>  	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);

You must have based this on something other than the latest upstream
tree. Currently on v5.17 we have:

2559 static int filename_parentat(int dfd, struct filename *name,
2560 			     unsigned int flags, struct path *parent,
2561 			     struct qstr *last, int *type)

Regards,
Stephen

> --=20
> 2.20.1.7.g153144c
