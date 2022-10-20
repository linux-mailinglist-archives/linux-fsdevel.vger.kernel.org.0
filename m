Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E26D60638E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJTOwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJTOwD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:52:03 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60D012A9F;
        Thu, 20 Oct 2022 07:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+p9VOQbLPRbtAsGWQQ135OeIfHs+8Lk0Uq/3ZMWKaIhZXamdQ4HFaEqso4N9+Q286NbOK+e0zTKxv6grCLcA9i0orpifck1CIqBrDNlxsK8EumHX8C5kgbPMZgAUThyEHi/JDuDiC1BxHQ/kqFsqX1+4a0l83EfGknmnJGtOPb5xBCQBYntWhuoI7YfEcPSmgeg0jIuvBHYOJYN4e4YmQ0AdHOPco5v/BCfmRgv8+TfU7IRYy3dqs/lxZ3d3nak9JBjfAV0bbbM/EJNmmMkuiofLznhhJbJDFsp3cAhDc6CORhRqLLp7tP3qv2nyWxCNZEn52tz43lWBB8NAxrsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2kS/gCAX0Gy4jULguKIjW6tnBLdLJA27i2Y/HbR7Yc=;
 b=RbwjAQukajAZcDQYCPRVQqcrocAQuoK9HHxDkbr0cbwV6GkDI2w08V8fo8nyCOUh9Zbv619zgVToe96xlFireXZgOHTs1Njwhc4pd2MaeRe1lHepDZzYHY7/90ykKaoUF9tAkP9U5qUCG3emblmYPE+0Lc8sqbVElut0esAKc8QlMk4i+IbWPDZg7xIsIWeEOv7GONsO2TbTfv/tdnWo60ykphV6m5XSSVd/m70yImt5lZlQGdU2dj+HQJjZmNf5klxvkLPfr3EIUJafYWpVd2icG0wSsNttTkzFSQqB3nozz0486HA7cqSDOSyfNwLWQoYgGBN3+8w02UdrsRyP+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2kS/gCAX0Gy4jULguKIjW6tnBLdLJA27i2Y/HbR7Yc=;
 b=CzgeajwIJcMUwLK5kXAtiIXrJK5J5oSS0GqFcgGh3tLtDxkTqXRUZXVUH6xiR7swZIeqREUpM4ne0hCAY5Xmlu/PqIoR6/g0JWe2Vt742wgtqYm1iEnsXcf5W+lDRtMyd/I7ne5ap4fnbtZIES7ycQABHkfKEYyLWcFlsee9EBc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com (2603:10b6:4:aa::29)
 by CY8PR19MB7202.namprd19.prod.outlook.com (2603:10b6:930:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 14:52:00 +0000
Received: from DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::c261:9a38:3a92:d1d1]) by DM5PR1901MB2037.namprd19.prod.outlook.com
 ([fe80::c261:9a38:3a92:d1d1%7]) with mapi id 15.20.5723.035; Thu, 20 Oct 2022
 14:52:00 +0000
Message-ID: <14d25500-98ba-d8e7-40b2-5cc0ef1e66e3@ddn.com>
Date:   Thu, 20 Oct 2022 16:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 1/1] Allow non-extending parallel direct writes on the
 same file.
Content-Language: de-CH, en-US
From:   Bernd Schubert <bschubert@ddn.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org, Dharmendra Singh <dsingh@ddn.com>,
        Horst Birthelmer <hbirthelmer@ddn.com>
References: <20220617071027.6569-1-dharamhans87@gmail.com>
 <20220617071027.6569-2-dharamhans87@gmail.com>
 <CAJfpegtRzDbcayn7MYKpgO1MBFeBihyfRB402JHtJkbXg1dvLg@mail.gmail.com>
 <08d11895-cc40-43da-0437-09d3a831b27b@fastmail.fm>
 <CAJfpegvSK0VmU6cLx5kiuXJ=RyL0d4=gvGLFCWQ16FrBGKmhMQ@mail.gmail.com>
 <4f0f82ff-69aa-e143-e254-f3da7ccf414d@ddn.com>
In-Reply-To: <4f0f82ff-69aa-e143-e254-f3da7ccf414d@ddn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1PR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::48) To DM5PR1901MB2037.namprd19.prod.outlook.com
 (2603:10b6:4:aa::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1901MB2037:EE_|CY8PR19MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 8736a448-9270-41f3-f84b-08dab2aaa449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6VgLflzWQ22dBOl4Wru82lXY10y5dbKN6iqxRbTdWFYIXYEPKdmY7EHTbQbozXisAOd7hl5xcxOZFScwhFQ5F2TU7neSYrHA16xH5e/NmSEGeSBPC3FdQlsQ8V0sU2kaOwkcVuYOV7WNqQKGCJEGY0UJ5tNV8Bnn8NYI8VKT/YwV+HIE8WCfAKQPo2hlmypONmFPGMRVtD3T4NhKGV1O+jJwHAwjyRoHjJJC8oU+EqpG9DX8lh7w5vOW3/IDzG5W35/59VePcbE+UkQAKviRfuZOzifQVEkGfqM9ht3dxyKshd3z/gHoDaCK7DltGGWU1jgwCwHb9on+Q1IaV3aI6VyW9Kvo9p92sj960Qj+s9dT8CsJlqaONeUKXbSWNZ2v4uC8eyaaO+Oa6heLNnjBj/YtHbUn6NZjmPgg3F7GeBgC68rKodndc2beAZPQT+JIryi/+UMfoT7pXFUN8tTSCCBfctUA314hLB6ooNvJVA6KGzEorKs2Jb/yQkWYSeiwRItSFhQFjK5V1qbuL412B1Rt+lUf3OyR19l0/qNMX5XPY8Pdlo6ScMrfbRj1G3rZ0b3lzF1PwHX1ydemrMcr5Ou4+jPfSfOWJwa9S1ouj2p0odR6A+R8oJ0eG4/mePGHbFwzaFvc8TIpYOP42bb2jlnd7Ew3MM9x+CDViw4Ypfh6VSGiPfi5/CctkMdi8uaqozxW9bSZXLWFwRevJ6zjFiHBLUVDIxgJL1WmM5mIlkkz0CqmoZ4Cite/IrUgVYEsH+K8vanKX9zgzUG5T/QJwnrcDoS2EdLZkofTZTTRVOnzYpkVNK6oQLVZPdl004RLjQFr+OfVxbPBmYb71OSBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1901MB2037.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(136003)(396003)(366004)(376002)(451199015)(36756003)(31686004)(186003)(86362001)(31696002)(558084003)(38100700002)(2906002)(316002)(83380400001)(478600001)(54906003)(6916009)(6506007)(6666004)(6512007)(2616005)(8936002)(4326008)(966005)(6486002)(66476007)(66946007)(66556008)(8676002)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHp4R2xjUytqYlBXTWtLWWJZZGZwUEJDVmxUamtrTEs1TFJ5RlV0MXFVZTNv?=
 =?utf-8?B?dG9BOHdOTnBlZ2hSV3dRZnQzZkx0dDBzR1NKLzhDdmpRZno4RFViK0RqRTdr?=
 =?utf-8?B?dEd1cmNnZjgvMk5IOWxISXFNaTJsNTFTZUI4Z2hzT05BZlNYS0p1d2RvWXUy?=
 =?utf-8?B?TFB6QzJuZFZiMzJDTGlEQVpjWXlxVTlTMlNvdk9GZ1hjQ2h1Y1d5MnRZbWRS?=
 =?utf-8?B?Z1hFV21xYVBDKzJUb25KbXA0b1lLaW1rWXpUdk93V1ZobjlOeWo1cG1BUkxF?=
 =?utf-8?B?dGpna1FoL0dOcDRvTmdyTEd4UThRaWVRekQxSFVKWGZqYzRjbFh3cXhCMHlN?=
 =?utf-8?B?Nkpid1dWdThxSUlGQnYya3hqdEVOeFViRGRldGNSUy9SMnJibmliblo5Vy80?=
 =?utf-8?B?SXg4eDdpMXREaHZqYlh6SHk4eUhRZGVTV2lWT1lpQUlKODIrT3NMVGtqT3lo?=
 =?utf-8?B?ODVBM2RrdGdGMWJERG0ycm9HWjZTdTFuWHVIcUM2Wm8xVjVWK08rbnRzS1lm?=
 =?utf-8?B?ZGJVYy9hdlZjYkhtY1MyOTFUc3JDUkYyRUV5NHdMSDBETEN5YUI0dWNlQVhN?=
 =?utf-8?B?NWlGbEVnQXU2WlRzQTZyZTdCdHJBNGd5YUVZcXE4bnRWWW9KeHBwdHd1VEVC?=
 =?utf-8?B?Q2RWSzVLV2xkalhSdzZUc1B5dTZhei9sNklxbGNFZjRKSnVkNjRBVFhJeWZ4?=
 =?utf-8?B?WnY1N1F1MGhMNzVhVjVmSHZOV1pNeHBWOCtvSDArd0lVVWhEeHNTRnF6S1ZX?=
 =?utf-8?B?SVZtbjFnYzY5Vllvd0hrTUw1RktPd015TTZjTG1VVllGVzBYdmRTSXFjRnNi?=
 =?utf-8?B?L2g3NUZ0b1NIUWJqVFFwbFdPd0pyNGdULzVQdXVXRGZ3emRNeE00eFV2N0k0?=
 =?utf-8?B?V0lYRUFjRWgyN2ZkbTMxdExIbFNBaTJvWllUMEpOY1RYdDY4N1FmNEJYVWsx?=
 =?utf-8?B?aXp3ajVieWZyOWhOR2VNQnRFbHd3KzlFTGdOR1VmYXlPVUJPTXppcHU4NDV4?=
 =?utf-8?B?UnFiOS9WSnl1VThmTzNaZDhvRjBPWWxrMnQ2K0RHNUNJTUVaQWdLUEZ5Z0J0?=
 =?utf-8?B?QVJaYnFSV0x5dGFXTzBmT3o4bmhYNlZXL3A0aDlNQ0o4cVdjMFVzaU9NVlNm?=
 =?utf-8?B?QTZGTFVIeFZMNS9jUHlMYVFmVXptSC9XUGVudHZscEJZa2QvSTJ0bWlTb0dj?=
 =?utf-8?B?djZBUWtMcndLbmZoY1l3NlBMZUVVRnJ4WEpRU2lJNEFGY0FmTU5nSUtiODBk?=
 =?utf-8?B?QXVnUVZuanlubC8ybjVYVmdQL0RpRlI5V21ZVlkvd2h4eEtBNEdJVW5lQ3Nq?=
 =?utf-8?B?MGdGU0QvUVN6MWxuU1kyRFA0UnlMdDlPMUlGMzRRMTJHejFJSG1XTTRTZllE?=
 =?utf-8?B?NkQzMXZEbnV6WE5VZWw5elNpaE9idThSNGdyTnJ4UGVwek9ZL2ZFTUt1OU5j?=
 =?utf-8?B?RnlIOUFHVWdoKzk1cjZiTU5USFpua3pTNGFRZzQ5SnVwSDZUaHlaeVBHZ2Ru?=
 =?utf-8?B?TnR5QXVjY2lSR0RobUZkeDV6Mk51TXZpZ0JVdlo2R2tNbWxTenFhUVpqK1dx?=
 =?utf-8?B?WWhxRzNTRFZKL2RvNzlNMm9ZNENGKy9iV2tMMTdPdmdjWEVCTmNTaStRYm50?=
 =?utf-8?B?VEs1VmNrSk1NRVJHcWRNaVYyQnM2NFlCWlpOQnZGZVBBZFZyN0JCZ0ZUdk1C?=
 =?utf-8?B?SFA5Q29DSDlTTVFuSEN1VGRlSGFmQTNQY1pmRHFKQVM0VUxLSDZSd0xjbG5W?=
 =?utf-8?B?dDZWWlE3bHgrdTFOV0ptT0F6RGFsZFRGWGNVbVBXVWkxVjFiUDhTL3dXR1lZ?=
 =?utf-8?B?NXRicG81b2h5QXFXRHpxUXJiOWVuZW0wd0VzLzFUVG5ZZS9xbTNsa3lZTWlU?=
 =?utf-8?B?QkZqSFFReGtlZXArQzFiaUdOT2dnYWk5RFloYSt3Yll5UzBVTEg0aTFVZDd1?=
 =?utf-8?B?cHhHSGJrdVV2eGw2VldnRmtrNGhzSWpVRm9LTDlUNDg1OWJsQklSdUt3YWpr?=
 =?utf-8?B?S2VmL1FNY3BrK2dMSFM0bzA0ajVCNGhkQ2h5SGplSGtpTGZYZHgvVWh5Q1Bj?=
 =?utf-8?B?VHoyelR6cThEUXF3aGRiUVNXMXkyWXZ4NXFESDJzc0cyY1lsdkFuNTFibVRu?=
 =?utf-8?B?Y0x0VjlhNnlRVHB5Nm5nYnF1bmFPb0lwbmpYRzlyU0t1bFIxOFJVMzJWS1Fm?=
 =?utf-8?Q?te3xa+eyv7cl3jJY7lYmPYm+BAIK6QSjpRWw6xsC/H3Q?=
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8736a448-9270-41f3-f84b-08dab2aaa449
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1901MB2037.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 14:51:59.9185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crx2BTvZat9Yd4/hpmqlPdZvp/LyRKTlYepvva30K0RUBQDn5GftWz/e61w4Coaq7RT5f3G34CSEXG9XpFlyCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7202
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos,

is there anything that speaks against getting this patch into 
linux-next? Shall I resend against v6.0? I just tested it - there is no 
merge conflict. The updated patch with benchmark results in the commit 
message is here
https://github.com/aakefbs/linux/tree/parallel-dio-write


Thanks,
Bernd
