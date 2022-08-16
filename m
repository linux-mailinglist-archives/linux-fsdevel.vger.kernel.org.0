Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F975957C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbiHPKO1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 06:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiHPKNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:13:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17120D6312;
        Tue, 16 Aug 2022 02:37:35 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G3220Q025556;
        Tue, 16 Aug 2022 02:35:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PZIWo8pmH+lv2AelK6uXBXdMYyslhCrirn9LGGJqxv4=;
 b=B+ZD15n7OGv968Uiu1QHAp7jfEZgXHce/CBmuQBNCQIHujFGkTBLqjeOOQoGUyR5kjox
 Wajguwisuyti04qqAIu4cxTvwP3WvIEHoHSuSqHq9zCGofBOKyH67px81/XgNzVntDQP
 +HhOLzEtbMkV8t6wEL/rjW7BfQPZrrt5FQ0= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j02ym1j8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 02:35:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzO+94S6Qg72e6SmcWiYKEUV88ztyeBCJglvAWKXADmX6M/S0wMGAkJwvjAPfg46FNCQIMHD5ZiYE2SoGSOBGXv+YASQB6iAh50WUxPJDxY940t4FVwgBPefJQXEhXKi+B0W8Jxa8rHK9CgXSQSLObaaSiGL75no3sBbNXAhJ9z+MtLqePF+B2a5m9WQe52gzcWTHafx3noHgLPQXcNDkqC352vrPC7nCi4RJT1Y7NwpsPce6zvCKyEIHj8Fu7fT6LGyjBxM4E9HWWf2ltohXeysWjBgH99qx0HjarYLVIKscDFj2g6G9lSb0n8bRsyE4QcBrOvq8sZWKd6KNVYC4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZIWo8pmH+lv2AelK6uXBXdMYyslhCrirn9LGGJqxv4=;
 b=a9ZBugV3ibpue/5oCg3RFz6hxFyNb1ksrt9USvPrmd2TE1UWt7WcaVl2n/J21AOvmyti5y1fDO/jTNa3GSTy+4BlDK7glU9HOZkzmm3ptqMcBXECWC86RReaDqaVH0H4FlkAMq3ZG5BtucKc/hyXxaq2HPCA/O79gk9ftHsSjIGMzwJV1bAw+62v6MEjEN3wdpnIDHXPOncUxg5rgtu7xQ/aBnrFOE3F6rBMVpwwRIOVFZQwORX5aY8+PhtBUuiYznxe4q+c/gQIDz/qtGXzPRO+AiqjFdoweaQSm0njrviOJ44YJrM4DSI6TOrBPNcxI6Dc+Nd7lTP+FUNoYpJ9oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MWHPR15MB1791.namprd15.prod.outlook.com (2603:10b6:301:4e::20)
 by MN2PR15MB3165.namprd15.prod.outlook.com (2603:10b6:208:3b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 09:35:51 +0000
Received: from MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::4057:250c:fd24:d2f3]) by MWHPR15MB1791.namprd15.prod.outlook.com
 ([fe80::4057:250c:fd24:d2f3%11]) with mapi id 15.20.5525.010; Tue, 16 Aug
 2022 09:35:51 +0000
Message-ID: <16d100df-6d88-c7c5-9b1b-fea40ec40d96@fb.com>
Date:   Tue, 16 Aug 2022 11:35:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [fs] faf99b5635: will-it-scale.per_thread_ops -9.0% regression
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        kernel test robot <oliver.sang@intel.com>
References: <YvnMWbRDhM0fH4E/@xsang-OptiPlex-9020>
 <20220815100044.7j2u2yjlkanhkrfg@wittgenstein>
From:   Stefan Roesch <shr@fb.com>
In-Reply-To: <20220815100044.7j2u2yjlkanhkrfg@wittgenstein>
X-ClientProxiedBy: BL1PR13CA0444.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::29) To MWHPR15MB1791.namprd15.prod.outlook.com
 (2603:10b6:301:4e::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68e7f4ae-1c7a-46a4-67b8-08da7f6ab54a
X-MS-TrafficTypeDiagnostic: MN2PR15MB3165:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4wDY1Aa8Cm0OEXqk8v13mWHHfzn2x2E8SnX6JpqKqEWSj+Q+SBFjcAHSItgpFNC5xlvJ0ygLU2Ktqo4tCc/35t+ua34cKSYkcJ0XKdQnp3c2Q2+R3/aKV/QWbl206KgguqNcQgPhoDEd4lxmzidvcTfYG1wkhosBVv5eMgH84X52rjyh0VzoIoEr2pRhhE/RVw1GN7bG0XtC8yJCH8r2GIkSkc97Z4tQ8iUmH43XH6waYnAup2LgZ4WFP9oPyt1wOyVF+TvGr5aIFyQFFVxx8ykp6fbRIxI4tdofiyCQetdj78+fOnmOSYjZFNoKA8ziDmA79Gx1l9lWtsrt49osgGT5JyooM68no111S/KW5LaESH97oCrJknLbVJynXs1EGwxk7xGhwPTv98hLM26TJJOR7qrqA+ktaothBI6cAyNmsIOC82xv1AtQNtBFfGYOzY4ZKEu/iLNFL8YSMIFo0Ml6wtwtxHsDTknsgbu0BawYG1QFog2SXr+rHZUvbbMR7IBODJR+z/+QXs55xUKfwgCGj3b7F4HPg+j26H/UKeR3mNmoOsh1YJaf+bPnodMkGgctOxuggXFPIIg5tupcvfOCxsPt+AkoUnNuRbFh28OMWhb1bQXDZlsAxVGckp8AocDKTjThSKsBIt1Dc0W9C6QGUEq9HBo1orwLs7H3hSH8ZujcoZUddspDRnUZgA18rMpHOHymEKoAOB/KbaAntNLmk62oHa6kLkbfYnaiWe9dNOdkw/MAkczlvV95X3Yy6GnEv0ZI8uUlgoI/4d0PZPWmUtDaLdU58ehjhmgFDPDcwt9CQ01pTkKoQrX5bJZz4sp50HAXgSjvMrIsPkXto2myBc7knkrrgU7bxp93xI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR15MB1791.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(5660300002)(86362001)(478600001)(31696002)(7416002)(6666004)(966005)(38100700002)(6486002)(41300700001)(8676002)(66556008)(8936002)(54906003)(316002)(66476007)(4326008)(110136005)(31686004)(66946007)(36756003)(186003)(2616005)(83380400001)(2906002)(53546011)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0NSVHcwNStpdUpxdHlTaVh0L3J5SUpRalg0Tjc4eGhSZmYvQ0xreFpPRkw4?=
 =?utf-8?B?RlBBN0c4YWVONUk5MzlBeGxCb2VaSzcyNVdVOVJuWWt2MUhjd2xnN0NkUGNK?=
 =?utf-8?B?TTFGdVROM2g3V3pqbDVWTGlydndJUjA2REVpY2FiTnlyeEdjdWFzWDdJMytK?=
 =?utf-8?B?VEp2NVhkL3ZUQXNhcWRhaVNPbmJ3SVpjMlZRY0YwUXhIcnVHQjEvd210dFha?=
 =?utf-8?B?M255ZUp0aHdpcUFVSUZUZFBrZGpQTWxrTitCd0FTSGxmc1V6MTArZWZ2cHJq?=
 =?utf-8?B?d0dUMTZxOFg5NmQyOGZHekowa1lsamlySXNLQW9hRlc2RG1GSnZuRGtlalBu?=
 =?utf-8?B?Wm5pR0t1ckxFREwzWDRGQ0ZOMDBQOTU4dlRsYWxkNUtRaWk5cGE1L3lsbFRs?=
 =?utf-8?B?ZkFqb1o3amVvVGxZS0h4WWlRbktuMU9EbmRPOW83ZG1mUjZFSkNQQnVONDZt?=
 =?utf-8?B?MFpIN0FxSHVZU1hGNGVGaGlydUtraU1Cd1A1cnYzcG9IOU41NXNFNDgvSXVw?=
 =?utf-8?B?NnVjSkpnY0g3OE5OTUhWTEphLzd4ZVFjVzFERXlOUGcwallSeUs3K2hNaXNE?=
 =?utf-8?B?WTR5cW1jbWtwNUlsN01icVBrak84SmxIRmRRbnppbXh0aXVZdmgrejlSSVB6?=
 =?utf-8?B?eHQwTXpHOHpSOFNNQVd2eVVoY3RzUThrTHRuZkNKSHF2VUs2RzBLdzJiemxz?=
 =?utf-8?B?ejRLQk5sbmVBQ0NuaGhnOXUwd1JXdnM5c2c0NmpncXdMV1A2U05uWUVOUC95?=
 =?utf-8?B?TEFvSzZ6RWFTL1ExaCtiODZaUjE3elhSUlhvM2U1RGpaOVB4d29LQ3pHY3pm?=
 =?utf-8?B?V0hUK0p4SU5sVjdGdURXMUN2RVVxaVVwczVUU2Q1SXFxVERFa3dYK0NUTHN5?=
 =?utf-8?B?NFVWSUZRRzNyNFpOeGxrWS9DdGVWbmh0OFhoUFc1OGxic0tORnhGcVFDSGhx?=
 =?utf-8?B?SVpyd2FoYjZ6N3JRbXFzUk1pS2RXdE41Z0lvSW5FamVVUjZ5SzFDZEUyY3FF?=
 =?utf-8?B?VkdHRG1jZkpBN09Vb3dVY1RsZ3RDck9WcGQ0N0J6Wk4zcmZyNVdtMU5sRSsw?=
 =?utf-8?B?N1l5RnNIZkNzeENsRXNQS3RtYlF2bzBxWkRVZGdCNG1TU1pnT3VGdTdsTThJ?=
 =?utf-8?B?dEwyYzBtcnhvUG9kMVBURWx0b1NIbC9PcTlhaDdxMEdpQTEvUVVPK25QbTVQ?=
 =?utf-8?B?NnNKSnpEV2VLaU9MQzh2Qk9hblcxckZ6ZWYxbHJQUEUxbGVnS3VCUUtZTVhF?=
 =?utf-8?B?SGZEQ0hNUEJiMkloT05EU0dlbGpCZTJrVUYxZUc3eFRnc0g0MVJadXlKWndD?=
 =?utf-8?B?T0hOa1lYOUgzelg1MWExTnZnaEhXNkdEdm1tcmdCcFMzSXBmUDlWdDF3eXJV?=
 =?utf-8?B?QjhRampsVnlqOU5UWHVYOTlmelhjN3pUcWFaV053TDZvbWdBdW9VWmxad0VL?=
 =?utf-8?B?MDhaak43aGFqSlVpam5ib05NRzZ5VHRNSzhmb2pYc1ByT2ZDdU40M1JxRlNj?=
 =?utf-8?B?NGFIenkrb1JCNXdZdnBlRDU4NzVzVlpzbWJSSWYyWkVSMW52VGRWZHJTQ3BV?=
 =?utf-8?B?ZnBHODhLd0lPMElwTG11b0hUL003bGUzOFY4SWp3WXU0TWZvOGYzWXo1ZlZz?=
 =?utf-8?B?ZFROcFowVzkrNzFMU1dWdVJZci8xdkhrN2xKa0JjeTJqUS9YTm9JUUw0cFJt?=
 =?utf-8?B?MHhoaHltUEZWWEF2WWtxS1dEUHJqcGd3bGg5S2tlQStRNnhKOWhyM0VXZWlk?=
 =?utf-8?B?UWxEWkVSN2Z1dmFpYm4zN2xWL0tPbzA4ZWJpODlJR3hhZjVUSnhOZ0FwTnZt?=
 =?utf-8?B?WnR2ZFZrV3doY3JDZTQ5cW45OTJhVjF3V0FPd2lXMEhhLzBydjdTRXhXUGJk?=
 =?utf-8?B?MW9TVVV0THpWVm9pZnorT3pweHRHdVpRYXdXcFVaZk1HZ0R3TWM0V1NiVVFj?=
 =?utf-8?B?QTFQQ2NZNG1Td0pVLzFJUHg5UlN2WEEzOGdtczhPNTBNcVFKK1BoUFl5Z3or?=
 =?utf-8?B?M3RDNzZ1VFhKMXplekEvZnNtYmZVQ2QyWGRZWGJPdEdIV2hEbjFidFNPUnE5?=
 =?utf-8?B?emNkZHE5eTBZS01jQmdMK1Y5bEYrTXhrUHZ4UFdIY1g3TlhlNUd4bVBobmhM?=
 =?utf-8?Q?4IvtUb4nuU4KB5ANHhNaCgliU?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e7f4ae-1c7a-46a4-67b8-08da7f6ab54a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR15MB1791.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 09:35:51.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IPnSKxlJE4pBIH2QZ2Og50PYMRJWiHgcaD1ijLmagsck45NieNn+WKBwVxsw0NN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3165
X-Proofpoint-GUID: nA_ZyGFXbGBy-7ap2Ofd31XT1uqRnufM
X-Proofpoint-ORIG-GUID: nA_ZyGFXbGBy-7ap2Ofd31XT1uqRnufM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 8/15/22 12:00 PM, Christian Brauner wrote:
> !-------------------------------------------------------------------|
>   This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> On Mon, Aug 15, 2022 at 12:32:25PM +0800, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed a -9.0% regression of will-it-scale.per_thread_ops due to commit:
>>
>>
>> commit: faf99b563558f74188b7ca34faae1c1da49a7261 ("fs: add __remove_file_privs() with flags parameter")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> This seems overall pretty odd tbh at least it's not immediately obvious
> how that specific commit would've caused this. But fwiw, I think there's
> one issue in this change which we originally overlooked which might
> explain this.
> 
> Before faf99b563558 ("fs: add __remove_file_privs() with flags
> parameter") inode_has_no_xattr() was called when
> dentry_needs_remove_privs() returned 0.
> 
> 	int error = 0
> 	[...]
> 	kill = dentry_needs_remove_privs(dentry);
> 	if (kill < 0)
> 		return kill;
> 	if (kill)
> 		error = __remove_privs(file_mnt_user_ns(file), dentry, kill);
> 	if (!error)
> 		inode_has_no_xattr(inode);
> 
> but now we do:
> 
> 	kill = dentry_needs_remove_privs(dentry);
> 	if (kill <= 0)
> 		return kill;
> 
> which means we don't call inode_has_no_xattr(). I don't think that we
> did this intentionally. inode_has_no_xattr() just sets S_NOSEC which
> means next time we call into __file_remove_privs() we can return earlier
> instead of hitting dentry_needs_remove_privs() again:
> 
> if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
> 	return 0;
> 
> So I think that needs to be fixed?
> 

Christian,

thanks for looking into this. I'll prepare a fix to maintain the original behavior.

--Stefan

> Christian
