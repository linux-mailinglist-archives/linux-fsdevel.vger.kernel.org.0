Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEFF6DA8BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 08:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDGGJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 02:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjDGGJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 02:09:15 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8CA10A;
        Thu,  6 Apr 2023 23:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkkZdWHz/6dB9hkOtGQTexvoAEPDVba9u197pPDe8KnsS5Qbnz3pvdIfDgDy/eFuwwSXui3zPuRQ1EMnTM3JDJFA1QSVjFVcJZxI80S3r8KxdMdQeAj59xmbKV1X0xBSpkAuMTvXYsWmwjZhmBFxhewdonuz+JHyMPLJf1u7ojZLfBgK5nbZ0j9gpaNVJ4e/0f1qqetvLcUdIRibQVulLPyMMij2Nz3lInkP+uusl0l+Y6Jv5BYpN9qtZU6GpKmsfpwzw/1+npqHmh/DAUz+i96uJ17j+M6RXp2/OmQAf6Zg7HhG5NjYaSgZidt1Ng/zWF1nLvsK38bR9okXTgim4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2f0eVhQyzx3bjJQ9y3gm/qKkBhpK4y77kbZLGkY6s4=;
 b=Eo9nKPOCFGj2sKX+7Yp0hTGD46vtZ+6o+6FTygx14BuokY3HHLUiOouGp5//Vn7kKzTNPta7is4S+Q2zLV1PYgWdyU6hir77oJWx8wc/BHHWYgeU+Ze/M58/2Ar7YFEW9us7+KJJ8ZECN5RvmJbWgvOumhOB/ifugHFD/QO8Jsp5n3L/ocZUy75A6S8FB9Z0FDMTFMzK1P+jehFkx5xERHlQlUjUyyjEuY7GljgxaIxiDUOWJrFeb6aSGlqYxp7uaI/YQkc/KqG6uneYtNFDJsLlQe3oOAO6Z07RYz3rpPXt9HN+DlTM6gcziMDFWDN5hyQpKPh0vqtBPiytaR+X9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2f0eVhQyzx3bjJQ9y3gm/qKkBhpK4y77kbZLGkY6s4=;
 b=owD8ZGPa2IqlzPrR3Yx4ccLQHZbjwzz1owWMF1VBDaoUqEAWoKJTEcd/TKBJHUjQXQmn8wndB7dD8MTTh9lD6FeSZMFBRLfrg7kOpqOVEBeJMjvwTGEL5t9kPB0+giWIroJUYrbRmZm6By0VwdAk6/9i6eFfI4q0p/a/XXWu5Yu9Asr7DvjvS/ZkH+ghvC3vaF9/quHadZ2rOEexCy9Cc+yySHRFiV7XWk2bnI/BHsZoJ2q4179ipkv/D7tUqhSjCZqt2HzyEKTEmAQVB6tnrDVsKTXG3VJmr81frrxEWud5Jb8T5hb3D6TaJNpbG9fT1b+fdiTkATn8havBYWZSOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYUPR06MB6079.apcprd06.prod.outlook.com (2603:1096:400:347::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.33; Fri, 7 Apr
 2023 06:09:10 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 06:09:10 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     chao@kernel.org, damien.lemoal@opensource.wdc.com,
        frank.li@vivo.com, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        jth@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        naohiro.aota@wdc.com, rafael@kernel.org, xiang@kernel.org
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Date:   Fri,  7 Apr 2023 14:09:00 +0800
Message-Id: <20230407060901.22446-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <2023040602-stack-overture-d418@gregkh>
References: <2023040602-stack-overture-d418@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0171.apcprd04.prod.outlook.com (2603:1096:4::33)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYUPR06MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b22288-b0c3-428d-bb9b-08db372e9a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tu31TZIxdZa84B8QPjWjhRtM7/krRjuSDbWyWA34iCcdU/mevIf1+kGnt54C0sIBlRcso2hEDnLjfG3a2F4yoCsXu3jSMahFZizBRFcKSFRiiAmthXrcdf7Fah1VRCGOK8u7v453TjBaQueukRgyLeUorYRrJ2wSKJuCfbtlp5jyW0YoMcNj48lnWuWqGZwQqX2ntPEkf4uJbLQEJ/U845e1i1Bj6r9NOwtQiJIyDkpFqoNPSK+u60vvkOgDQzh5mx32oWdSLi/x0qaimh7j2yzAkU3P5xo+/oq553xwMHGc0qkjxsVt9SqVmuJ7xeX2VtkdD8iJ+hGYTlEloH1vi0guGgWm0pGd1cxt2heuxvkOvK+osF24bzoKzb/bazNWIwgqj+TgarPJTW/i9W6tVy930LbYnC1COy22h5z9ud7WkdsPEEIpy5q1MQaqfp7LRmi3+4iWgJjwtCYWc9XBFqoQQIA58+grX78kH/ZfATRgSBJXUhx1tgWPT3StyyZsOsIFWF+heA093ICWGUGNQLx5lzD2flDYl0vgc24p40vNRR6KMjP2mGyKMEP6J+FwZ4xRkSbRRGsHA1MqG3EIXo0v2ZH3u9Wk1Ff9w0VdXbl6+VX7iIIXaVHx3kwryqO8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199021)(7416002)(36756003)(2906002)(8676002)(8936002)(5660300002)(38350700002)(38100700002)(86362001)(478600001)(6486002)(52116002)(6666004)(2616005)(316002)(186003)(26005)(6512007)(6506007)(1076003)(66476007)(4326008)(6916009)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmxZcDQyaHdUTFdMYjNnRkV5OTNJeUZNKzRCVU9RQlNIbTlpZUlzV1YyWXVr?=
 =?utf-8?B?UnBVVTRwQVRxMmtjZmFET0ttNmhibHFmUTdlM0duclowRFVCMkhDbWpDMmsr?=
 =?utf-8?B?Tlo0dnI5dUloR2JNN1h4R3RtVlk0WVV4YmZ1bjkwLzRSQzdzY25jZGlwRmkr?=
 =?utf-8?B?RDFnVGVjNGsrS29BR1Vqbi9RelZWeUF3WUZEeXEwSXpvS01veVZJaFIxUG8v?=
 =?utf-8?B?eEZRTWdNZ2dHd0J3ZlpxRFdxUTd6OTl1UXhYTy9ENjZjdktBY0ZtRVJXV3Uy?=
 =?utf-8?B?Nk1abEdmRHYyMnJTV2h1Z2JkNkowS05sVTd5WFoyRmM2eFl5OHBLYkFqeTJ6?=
 =?utf-8?B?UWJZZGk2WCtIOUlIaTdkRGlpTi94QkVtbmMwMGI2Z0VzODJzTjlwakloem1S?=
 =?utf-8?B?dFNSN2VZYkRON0ZyVlJpaTZVQ3ZUblB0VWRTYTlQTHBSZ3NiUDR5czZUbW5x?=
 =?utf-8?B?SGo3KzBpUUx5ZGdUMjVqUFk1Z2N0N25tT1A1akd6T2Q2OHFqNDVibUpPV29u?=
 =?utf-8?B?Uk1pWkE0MDBKSUg5SEdHeXoxTW5NMTV0UU5yQW10eUNBN3FuU3pBUUVPaU5F?=
 =?utf-8?B?R2xsU2xUbW1Qd2NRdTBkU1lLVWxTSEVmMG5maGsrKzVIWWF1bytZUERFSmxz?=
 =?utf-8?B?RHdPNjNxUnVtd0taT28wU3hJVThZSkIzdUhHNU9sODhWMUZSUGhpcitqTXhx?=
 =?utf-8?B?M3RDYzAzakVDMFFaYlZ2ZmNYamUyWkI0YWFSb1dMSVVueitZWW9VbDM4YXZv?=
 =?utf-8?B?UUxGYVl0cSs3a0xTMDdjQlU4SkVzUWdLTXEyMW1DemtocS9HT3lOY2Z1N01m?=
 =?utf-8?B?R0wzaGhmSXNuTi9BbVhkdFpvYUhMZ1Q2WFFRT3U5dTZLRWR3a1NmT25EZWhj?=
 =?utf-8?B?RHE5SE1YbXQyNjhuZHc2d213Q28yOVgrNFo0RWpES1BqNGRDMWtTb1JJaHJX?=
 =?utf-8?B?SmdiT2FEOGZ4SmdSaGlHK1hWRFZJakV2MkNZRmdCSmtDdlpyY3BUa0Rqcm1y?=
 =?utf-8?B?Qm4wWkZhU3l3b2pwUi9qYUxJME1Ram9QT2E5SzQ3SGhlTmpZdDc4bUNzRTNG?=
 =?utf-8?B?T0RwZDBHKzNNbjdqWVBFOURXcUpraEpCNldNU0NwdjZqL0VPa2x0YWw1bTRG?=
 =?utf-8?B?cVg3eldpTkZBMFBLMzFJZkMzZDZsWnlGMWd6cExNSkIxL2tNTVJXTk83dDhi?=
 =?utf-8?B?S1BPZ0ZHMlVnWk9QYTE3Vmc4ZXIxSnVidGQ3aFR5UTN1WXl3UU1tSW04QWJp?=
 =?utf-8?B?dUtGTmpFdkZlbzVlU2FiMmxsdGF0WXRadUNzNmM0encvTVg2RlB4Y0M3OHpi?=
 =?utf-8?B?S01pb3lLTFU3aTBYMTVSc3ExTDFHQTdJdkpHdkRzQlJ5eFJEQyt5dkU1VS9u?=
 =?utf-8?B?WUJNWmFmWEFrcFpRY0hiRHN1TUtGT2RvSHpDd3BZM3pCekU5K1FlOVVZSy9m?=
 =?utf-8?B?cU9ETmJNb1ZiM01OKzFldjdxSVhvK0NoOWNPWk5IYWlpWXQ3MVBnYXA0OTNW?=
 =?utf-8?B?N2hLUHN0eC9QZ2h1cnlLVHpUUk9OS0VSb1U0T1dJVVlzV2V2TUx3RWdCMkJW?=
 =?utf-8?B?MGc5KytCbjJlTERPY2t2NHJjVUxsQkVlNVMybERFT2EybFU1TUZ6VnErbFM0?=
 =?utf-8?B?Wm5CcDY4azBFZ3pBM1VzcHMyOE43c1ZXbVBPc003T0lINzBUcVhuMSsxdEVL?=
 =?utf-8?B?YUM1U005dXJ6K3BGQTUvSXNpZGZSSjR5M2JFUCsyL09xR2ZJRzVLMHBJUGsv?=
 =?utf-8?B?MHI5QmdYK01GaXpXUWhrbEpKU0d4Y2t6clc2TzJXSnNzb2ZKWUJTY2NwNWdz?=
 =?utf-8?B?cHMwdlI4SXVIVHpBbVV2YWNkOVNmRHZEL0djNmU2RDJUd3NkaS9CN0E4cmFF?=
 =?utf-8?B?MHFOTmEvend6TWJEbmxnZmJjb0l2cURIa3RsTVIyRmN6Mk5lVldLTHJFenI5?=
 =?utf-8?B?amdUWWhyR1BrNHFGTVNJcEJ3aVIvNjYzS005MnZFS1BEa3VUY1p5aEZEZ29J?=
 =?utf-8?B?WWZ4UUYrV1hKakQ2MHpPRGozM0xkSHNLQzNXdVJEcGl5UlF1cWE2emxCV21W?=
 =?utf-8?B?NXZENjNmeTlnTlNJaE9udTZVT25zd2kzbjhXUDlDaDIzaVJ4aGhIOGtOMUdB?=
 =?utf-8?Q?C/I6CJVRdIgo1XnXlA4jCozIg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b22288-b0c3-428d-bb9b-08db372e9a17
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 06:09:10.0107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVEbf2mKqBLfs/qRd4eJ1RId5rF6FMaAvh2c2YfABXnRoFYT0rA72zFVKKw+miTPVOKvEv9m3knkqoBDUsAJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6079
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Greg,

> just let it hang off as a separate structure (i.e. a pointer to something else.)

I have made some attempts. According to my understanding, the reason why the
filesystem needs to embed the kobj structure (not a pointer) is that the kobj_to_sbi
method is required in the attr_store/attr_show method for subsequent data processing.

130 static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
131                                                 const char *buf, size_t len)
132 {
133         struct erofs_sb_info *sbi = container_of(kobj, struct erofs_sb_info,
134                                                 s_kobj);

If we turn the kobject in sbi into a pointer, then we need to insert a pointer
to sbi in the kobject, or perform the following encapsulation.

struct filesystem_kobject {
        struct kobject kobject;
	void *private;
};

Later, I thought I could send some demo code that strips the kobject in sbi into a pointer.

BTW, Now sysfs.c in many file systems is full of a lot of repetitive code, maybe we can abstract the common part?
Like filesystem_attr、filesystem_kobject_ops、filesystem_kobject_ktype...

Thx,
Yangtao
