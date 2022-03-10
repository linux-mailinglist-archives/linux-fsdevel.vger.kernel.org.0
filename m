Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0894D4066
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 05:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiCJEq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 23:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiCJEq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:46:56 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E8E3381;
        Wed,  9 Mar 2022 20:45:56 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1N7X0002644;
        Thu, 10 Mar 2022 04:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KZhn8VrKEDJwN69JmhHP8dtR+vKUg03PhojzYX+qiTk=;
 b=mM+NAj3woqKorJYjy0zaMlM9f4RuIbHGwlGMCTkXwlEq5xuwVs6UUFqGPyk1gV9+Zn32
 DU8kOi2kQ7pdgxIvV8YvIPVPfB3aj6Jn+sOrxBRMhAiN7AxRGaHAnGZrx740Q8KdFgIw
 X8h6RZJWAM1Z7J32KOiwBO/m6VCgUnCUZMewdD9V/OQy1zIW6RElDZsTP9l3c8XyU4L+
 lJ1GjCIY9DNMA8v9wlxXTvcO7WGbsxH4bomQj3ZlEMsBwaEzPfiSchb6iGSnx/bl39B0
 eytlffQRYo8qVstwr4998YyZn61jYRroFrHcy1DBg/EZNM9rCafWScXwr3CbthBmBgFJ Tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9ckv9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 04:45:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A4aReK085214;
        Thu, 10 Mar 2022 04:45:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by userp3030.oracle.com with ESMTP id 3ekvywdh5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 04:45:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2jeFXxc5PcwiAYwnPNHtkoSbD7NpJF76X3Ni3jFWvCAZMm4rMq9cH2LQB1IZZAKG2PE0cKkh9hnVz5hqIzX4c0IlrrfOEHsyGVUfQDjc08Z1SKkTMLJMWUUMr8uwk17suEipTo7oyqF0Fc+CvlQ3f4kTKigKOh3EhKhu8TTDs9i+3CfHnq351qTuyYD4gf8AnPsIX+n3WVptc/QeHGFOGoRNs9XW14KbK/ilTbL5mioZBW3ljWaVl1fAmXINEto+ApnW33Pm95mc3d2/IJ6j/bzkkLJ0T2hJrPAOlmUUkBXulM159YVyvQ4o37WKI3YKiXGypFNs41L2JqTjHoDlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZhn8VrKEDJwN69JmhHP8dtR+vKUg03PhojzYX+qiTk=;
 b=aHA2K0Q/T6m4gS1hvePgDocJ0/7Z5nb4ykckYtNusyIWT8nKIuqhcka1BtwnSUX8bXhXc8RF1Uz6cXglvnllN0vQjw++2PWkCThxqN8e7LTUGjDmM8JaPIAPrk1ZmLca4XOU4XB+kip79ckTBZZ/pYwS48/FVIGpcwQg+U9E/Co2sWwHmTDkohwlfkXgZKWPm55QvtTwKurLxogwigx941nutq2hgg3/wO8Th3IuLdGxte6+aCeW0hUHi/aaOiVYsv6NaLZv33Dl8+xaQcVFxoj5iYBomQswumpAW9kgVvJKd4W5x3qasaR8uekftn3PRxBViDlcY7xeEFUB0WZgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZhn8VrKEDJwN69JmhHP8dtR+vKUg03PhojzYX+qiTk=;
 b=FfjU1iq23ClJkXn8C7bEKgXmrdGgkl7sTbZDByzeiheN6I0TxbrpB9UtyJoXnsZbvASj+VCdoQpLjZy+MUNz4XFF7VQTMCQCA1lEnq1G49gYT3QhIehfP/NtsBpQg3r8C0V91VrdfOZbXfSgrmYzlKtEhqgx2aawq9ovELdO45E=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB3261.namprd10.prod.outlook.com (2603:10b6:208:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Thu, 10 Mar
 2022 04:45:49 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::2803:98d6:9d00:5572%9]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 04:45:48 +0000
Message-ID: <a425dd44-060d-e102-cae0-fe1eb4ce7b24@oracle.com>
Date:   Wed, 9 Mar 2022 20:45:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH RFC v15 01/11] fs/lock: add helper locks_any_blockers to
 check for blockers
Content-Language: en-US
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-2-git-send-email-dai.ngo@oracle.com>
 <AB3847D1-CAD5-4D6F-8D49-C380F2E7AB64@oracle.com>
 <cf55f250-a1ba-243c-f826-3cbd91088d6b@oracle.com>
 <2E15A255-7A0A-4827-987A-E3B4A6A9E590@oracle.com>
From:   dai.ngo@oracle.com
In-Reply-To: <2E15A255-7A0A-4827-987A-E3B4A6A9E590@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0011.namprd12.prod.outlook.com
 (2603:10b6:806:6f::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875d5b7f-24ef-4b9f-1fa2-08da0250d8f3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3261:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB32615CC1452D601D7E822103870B9@MN2PR10MB3261.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KUnLxKZtzWglyh4IoFRFgQM4kwlsk+/NyaWHOCWbn0uVeWKRckDXjv18ojVnH0izS+nrS3IeoaIyF3qMakCcE5w0+ho24kWP/ap/5qx1zJbgT7ueXezhb4wpzboIfWdlILkT49/K22xLxsu5NSPNDibgicHYJNHS3YEn53tmFndk675rB/cGX2Rx5SdeKPxtBBTij6SaRCW/5HWSkskCMpqiV7r/rsNvXHvy6q9edGAlLyN77pimnVEI2W0rxPgmcBECQatIGJWbJ3V9t6IeBOUMBcZdT1Nibs1CB622X4tpvYyhKia0NCioj4EN7Gz9pWiWmi8iyXlYYxZPOYuC7vLrgePF5XJ/Hu4+ezCr9exeLnna+ev/Kx7YahtmmAmpQrVEo263G8+jHtWR92ZWd5Sn3ur6I3TnPp/SH2Bka/s649Ez/bDiYh4LnpHctIg7f+V+5Zpco7ASb+xM131vfzavNgxIvERVcOXvp4eWhhUcJmpLAahKx4yqfA2ia9Q9T9bixGbw2r4Sqsn354W/l7KJ+rO9XrzjUtDXOS3RoViqWiPmuy9hiWyWuV+4ZcnOLZrKap9ZeGGKTSWBn4PYjt9FRaVHfxD2+G0kf2ByVwncSrL0LsUlFVrBM+WR584Zc5GnIsp+2auwm1cCk2NqCTNxl2jaE1bY9ruIr9pY5bFxCGARoH1C2ANQLi8/g39Jh7bPj894ac2OKwha2ysU6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(2906002)(508600001)(6486002)(53546011)(36756003)(26005)(186003)(2616005)(6512007)(6506007)(31686004)(9686003)(31696002)(86362001)(4326008)(66556008)(66476007)(5660300002)(8936002)(38100700002)(66946007)(6862004)(54906003)(8676002)(37006003)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlVjTFpMb3MyMzdEUlR5eFBGUUR4YjFBV1NFRUJ4WG8vSTFwVzRFRzUvazFY?=
 =?utf-8?B?Q2EvN1k4ZUFqcHd3SXZISC9QVzR3dWprZkdTclRNZTJCRlphWGkvcGIydHZ6?=
 =?utf-8?B?TnV5UERuSU53N0JEa1c2T0JmU2kzYlpBalh0bURKVFpCVmhBdExzNjBHelNr?=
 =?utf-8?B?NWdma20yaS93bzlxT2RoNEQzRjg0SFJSbDdleFREbDRFb2N2VXV1bThJYTUw?=
 =?utf-8?B?TjhZdFRvaytPcWVKRE5TRnpza2pETlJuZjVWZTRudU43bENXRXd2Qm1jR0xp?=
 =?utf-8?B?NytlWGNTU0hFbHZtcDVIUU1yZDBjckViN0tmUEl3OTBtdkJJdXllanBGVWx2?=
 =?utf-8?B?dG1TaTV4L3FqdjRXeUNreDlNWU1DY0MvQzc4amU1QXVTb2l5N1l4Q3VYN3ZB?=
 =?utf-8?B?OFEwQTZSK2c0anF1UXRYdGZrUm9hVmpIanhjME9ZSUo4QjFISjk4aG5kU0lw?=
 =?utf-8?B?VU9HN1NGMjZvWG8xQVZKTmtIS0NDYURtQzFWaktTTHRiYklJeFRoeUlWYi9r?=
 =?utf-8?B?MUxid1lnZzFsSW9XYjNqbU9KeXgyOWFvdU1qUmJBNjhVUHh1RDlpY1hNUXBk?=
 =?utf-8?B?YURmODZTWWZVTTZKekRnL2JNS0VHWnlGeWRyZHMvQ1hMOWhORmhjaTJvTHNp?=
 =?utf-8?B?bTlxUDN4RHg0T1VKNTVZbDVCUHdjNHdLaVRweHZSMy9rblExeGUvc21kOC9J?=
 =?utf-8?B?b09nbm1IY3g1UW9jTXgzUWczU3ZZN0t3S1o0OXdrR0NXSmF0YnYwbStwNnd4?=
 =?utf-8?B?cHVpZXczOVI5U3lDSmcxMVAwdHBweGV3Qm5kT2M1ZEVpU0hGb0hVN3B1T1VF?=
 =?utf-8?B?VUltdDZISnpjYlZEVitzTFpGUXFpQjBMWm0zK3FaYTVoaFd2MWx4ZzRnUTZV?=
 =?utf-8?B?aThPN3NEb1NNdDdwTUE0MTVydE1lYk1jMFkrM0cxUkFtUi9LaEdmd2g3Rlc1?=
 =?utf-8?B?QkpPOW5DMUVsaWpJSTFTR1VtYUJYWTk4NmF2NFBWaUhQTElHT3B6bVVmVjdv?=
 =?utf-8?B?bUNUSXIyOHZaOEErdDdDaTJJeTVKblJJVnVqakM1Uy9reFg0Y1dzU2t0RmRi?=
 =?utf-8?B?YmlNMVVTdW5RY01QZ0RFRTFVSStRdVUzelI2ekxPOWk1dm1zcmpIQUVzMkNS?=
 =?utf-8?B?OEFOVE84TVBkYm9SUlhUVkNLWityVDFvUWpHZzREMkZOZDVqY3FQRCs3OC9l?=
 =?utf-8?B?c0J3Y0FNQlFLQ0RjL2FYeHVKVzRnWXpyTTNuM2dDelhiYTJqbmVlK09FbFFL?=
 =?utf-8?B?bTU5b3I0ZUVVS1pWcC9ZTEJwbE9JUVRUL1RNbisyZTFYN21USEVWa0FleDF5?=
 =?utf-8?B?QUFlNHowSEpjTjQ0czhnLzIxVnhzNG52VUNBZU5IWEczRUhzT2xDVzNpQ1hZ?=
 =?utf-8?B?dlRJK2hFV2t0YTFWTnl0cWxoZ1RidGIrZjZITFdzdkdPOFlxMW1Mdnp5UjZ1?=
 =?utf-8?B?bkRsKzN3Zy9ZVEpDMUdlOEtnT0lhQkRDS3d5L1dYSXVrV0tLUEtXcjkxSlli?=
 =?utf-8?B?clBHa3poVU01NXJqNkYxTDNFTEdzZmdSM3k4S0NRemNqWnp6cjlBek43d282?=
 =?utf-8?B?MVNBTW1Fb1FHbFRXaS9ZRDk5OGY4RExlQjFkSk80U0xBSTQzQmNvNWZXSnFx?=
 =?utf-8?B?ZFlrK1N1bCtsUFNhRkpYelk3cThWSmlDUmNyOCt2anc4NDNHV1Jnd2dlQkxF?=
 =?utf-8?B?TVl1WHAxVmZQQnJQak9rSUNTTXkyakJiMU04eno4cGc2YVVZMGsya3dxVW00?=
 =?utf-8?B?RWJVSmZUREZRWHJGVFB2cG4xekx0dXpsY2lkdlBrSDlobW1BcE5UR3MwemJO?=
 =?utf-8?B?Y3dCc0d4Ukp0ZjJjVkV2eXA4RS8rSkhDTFdENVlKWXBWMG9tZkpicXFWeUtX?=
 =?utf-8?B?a3NSMVh0WW1Zbkt4emdLU2FUVUU1NGpPVFNVOVd1SU9xWDkxUW1mcnBrVTZr?=
 =?utf-8?B?bFdEUWV1K0o2RmVLWGFPaTRCbzBTbmRkcTZTN25zQ0Z3K0IxbVdBNlNmV3VI?=
 =?utf-8?B?aEwydWx2QjdkRmdFc2JxSjkxRlhtbUVKOWdqdkdpdTVIMXUzeTFxTWFJUG9k?=
 =?utf-8?B?V011TU9hSGFiZ1RzUkxmZXRvRDc5YWtvZkxyZ2FYZ3lCQUVSNnFBWU01SWh2?=
 =?utf-8?B?cGRER2d2bmF4RjFza2s4dGJIRmFoVmpDWWhOUklPZWdmVjgzUVFkUjI0bEV6?=
 =?utf-8?Q?xP0KsYKbvqjuq8AFLoy26n8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d5b7f-24ef-4b9f-1fa2-08da0250d8f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 04:45:48.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayjuxJ3CWhIs30XtRnN8z8YRg0U/CFUM2EBO4gKc3OfFRPWyUshOJR0xC/j/UaCxx8sB8YzWFncspn4JvT2Nlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3261
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100022
X-Proofpoint-ORIG-GUID: 2-qsQZaBMHxpTVs3KiKH3gzbxlzqVxxo
X-Proofpoint-GUID: 2-qsQZaBMHxpTVs3KiKH3gzbxlzqVxxo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/9/22 8:08 PM, Chuck Lever III wrote:
>> On Mar 9, 2022, at 10:11 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>
>> ﻿On 3/9/22 12:56 PM, Chuck Lever III wrote:
>>>>> On Mar 4, 2022, at 7:37 PM, Dai Ngo <dai.ngo@oracle.com> wrote:
>>>> Add helper locks_any_blockers to check if there is any blockers
>>>> for a file_lock.
>>>>
>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>> ---
>>>> include/linux/fs.h | 10 ++++++++++
>>>> 1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index 831b20430d6e..7f5756bfcc13 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1200,6 +1200,11 @@ extern void lease_unregister_notifier(struct notifier_block *);
>>>> struct files_struct;
>>>> extern void show_fd_locks(struct seq_file *f,
>>>>              struct file *filp, struct files_struct *files);
>>>> +
>>>> +static inline bool locks_has_blockers_locked(struct file_lock *lck)
>>>> +{
>>>> +    return !list_empty(&lck->fl_blocked_requests);
>>>> +}
>>>> #else /* !CONFIG_FILE_LOCKING */
>>>> static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>>>>                   struct flock __user *user)
>>>> @@ -1335,6 +1340,11 @@ static inline int lease_modify(struct file_lock *fl, int arg,
>>>> struct files_struct;
>>>> static inline void show_fd_locks(struct seq_file *f,
>>>>             struct file *filp, struct files_struct *files) {}
>>>> +
>>>> +static inline bool locks_has_blockers_locked(struct file_lock *lck)
>>>> +{
>>>> +    return false;
>>>> +}
>>>> #endif /* !CONFIG_FILE_LOCKING */
>>>>
>>>> static inline struct inode *file_inode(const struct file *f)
>>> Hm. This is not exactly what I had in mind.
>>>
>>> In order to be more kABI friendly, fl_blocked_requests should be
>>> dereferenced only in fs/locks.c. IMO you want to take the inner
>>> loop in nfs4_lockowner_has_blockers() and make that a function
>>> that lives in fs/locks.c. Something akin to:
>>>
>>> fs/locks.c:
>>>
>>> /**
>>>   * locks_owner_has_blockers - Check for blocking lock requests
>>>   * @flctx: file lock context
>>>   * @owner: lock owner
>>>   *
>>>   * Return values:
>>>   *   %true: @ctx has at least one blocker
>>>   *   %false: @ctx has no blockers
>>>   */
>>> bool locks_owner_has_blockers(struct file_lock_context *flctx,
>>>                   fl_owner_t owner)
>>> {
>>>     struct file_lock *fl;
>>>
>>>     spin_lock(&flctx->flc_lock);
>>>     list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
>>>         if (fl->fl_owner != owner)
>>>             continue;
>>>         if (!list_empty(&fl->fl_blocked_requests)) {
>>>             spin_unlock(&flctx->flc_lock);
>>>             return true;
>>>         }
>>>     }
>>>     spin_unlock(&flctx->flc_lock);
>>>     return false;
>>> }
>>> EXPORT_SYMBOL(locks_owner_has_blockers);
>>>
>>> As a subsequent clean up (which anyone can do at a later point),
>>> a similar change could be done to check_for_locks(). This bit of
>>> code seems to appear in several other filesystems, for example:
>> I used check_for_locks as reference for locks_owner_has_blockers
>> so both should be updated to be more kABI friendly as you suggested.
>> Can I update both in a subsequent cleanup patch?
> No. I prefer that you don’t introduce code and then clean it up later in the same series.
>
> You need to introduce locks_owner_has_blockers() in the same patch where you add the nfsd4_ function that will use it. I think that’s like 7 or 8/11 ? I don’t have it in front of me.

ok, fix in v16.

>
> Because it deduplicates code, cleaning up check_for_locks() will need to involve at least one other site (outside of NFSD) that can make use of this new helper. Therefore I prefer that you wait and do that work after courteous server is merged.

ok.

>
>
>> I plan to have a number of small cleanup up patches for these and also some nits.
> Clean-ups of areas not having to do with courteous server can go in separate patches, but I would prefer to keep clean-ups of the new code in this series integrated together in the same patches with the new code.
>
> Let’s stay focused on finishing the courteous server work and getting it merged.

ok.

Thanks,
-Dai

>
>
>> Thanks,
>> -Dai
>>
>>
>>> 7643         inode = locks_inode(nf->nf_file);
>>> 7644         flctx = inode->i_flctx;
>>> 7645
>>> 7646         if (flctx && !list_empty_careful(&flctx->flc_posix)) {
>>> 7647                 spin_lock(&flctx->flc_lock);
>>> 7648                 list_for_each_entry(fl, &flctx->flc_posix, fl_list) {
>>> 7649                         if (fl->fl_owner == (fl_owner_t)lowner) {
>>> 7650                                 status = true;
>>> 7651                                 break;
>>> 7652                         }
>>> 7653                 }
>>> 7654                 spin_unlock(&flctx->flc_lock);
>>> 7655         }
>>>
>>>
>>> --
>>> Chuck Lever
>>>
>>>
>>>
