Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F041772DEB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jun 2023 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbjFMKGC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242056AbjFMKF4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:05:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8b::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B258E;
        Tue, 13 Jun 2023 03:05:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCCL2/f7gAtGHAjBPZoNkbyrWN8SwISfOA2nAq7HiOsAhZgpIsen4+j4eiVBx0hIl2Eqp+8h0JA79Q1hVHlN3lz6ReyTfdMr8qgS20sQuBSlV7FL8xQBKBOJAoGe5z+JU218TpZKDCVX3eg/dPIBx5dI2T65LObKqojHgiBQReBhgkAq6GdzboA9PuPEF8tfmWD1/5Am2t8B9niuiT+vvdORefGU873wGr7bVNBli00O9I8oUcTGSxiJJeqF3/lmPIwdpnAeI8gl+hyXjLSggDb2dQ+pf2UBJejFC9fSRjoG1ySsk3xAHcUGAGLO+SP9g1PXEF4bYLR+bhTMmmcsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sHf6/mUdfu1Jp2MQi7zQDwbXRUn75w3H5ST9mZdFLA=;
 b=K/p9ngZM1iUCRjzdeOLmDZDmXARHKa+aqcKeMlvyVQLcMafHRrICk9JjnaxiwCKByW2xWExHYTuoOQuG1okmAsD5e11CMNUCZZhfOzh4AMVCe+m2kl9JPEBBH95cMZO5TN0/T/Mozj6sd/sPlKcHavGrevGFILuT876CB4ox4J/EE2/bTle+HPRK63WIEaqbR82T74dig3wdejxiXb7nvXLddgueLwwHaBGFw19ZCkB+ayKhjt6FONAz/MBGgPlgirg5nhcm9No+IMj6ptGghKyvIeRt1npya8/LP1HT4PTfHq3gxYiBR/zyWZ6ZZNfJV6Fyh9rAaI9Hnq4QV55bTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sHf6/mUdfu1Jp2MQi7zQDwbXRUn75w3H5ST9mZdFLA=;
 b=jgea2tStNGSJa/zuvtFREaU6W6yL4q9EGJot/cQ5Dya5Rzdz+R4mR3Ijv8RFiRQsDvTJRGPZoIFJj/4OKqDzi1fex8a5jPeAkJEdQF3HpN1nrl7zZXg690DVDi3p8s5ktcyueIBnLzsj9VXL3vOJ26t/jqE04gpN+u2MnBtj5gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 13 Jun
 2023 10:05:52 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::ff22:cffa:293:5cef%3]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 10:05:52 +0000
Message-ID: <1d55a83a-b36a-4319-16bc-c1aa72e361b5@amd.com>
Date:   Tue, 13 Jun 2023 20:05:41 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [RFC PATCH v3 2/3] fs: debugfs: Add write functionality to
 debugfs blobs
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Avadhut Naik <Avadhut.Naik@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, avadnaik@amd.com,
        yazen.ghannam@amd.com, alexey.kardashevskiy@amd.com,
        linux-kernel@vger.kernel.org
References: <20230612215139.5132-1-Avadhut.Naik@amd.com>
 <20230612215139.5132-3-Avadhut.Naik@amd.com>
 <2023061334-surplus-eclair-197a@gregkh>
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <2023061334-surplus-eclair-197a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0020.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::17) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: ad859824-3b00-41b9-f985-08db6bf5c4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wGpei2tSuLtmvdk7nXabxz+K5+iBW0rPw4sp9n8yGaKRNbkQ8buwWKaaBVXawEA1dNRiOoDI+uO67ks6fN5C8S6Kt9LxW8g14c+nFnv6y176VozUAS00DlZO/snjUTGYt9VKrBy5TXg8oMPxdC2ToUsJWNi+9zqQggB/hYR2w0eYKK630jvOmvxwROx2r18ih2kzz5xfx7s7BsrnpV57q0jUa8VE785SOGv+pp1rwp/NbPvHE73Cmn4s0aWuWSfPudiiiYRPZNO3ZkDpiavPrnH2g9qnSTIGf9g20qWrGMk32v2en50XOPJKDE0uo1OrFQ1fkKcaFXt8HANMvS1AoCTMnhFZB5/RV24QJaDestk9hbVY47/f0pCyA0mEJTsHDCioiLUp/TUOaj/DSRtkVzsgxHxTs5Y2Ua8XwaSYyYNgSSDSfrzOK0nU1MU+pwwj+y9IsMHlObIOU8E4ew3H+oWjQR/uRIlydzt0m94gCXPeREb6xjInTAlwdhAurLfyygq4NgZcJWdG+Je/v/vQvNINGckmW04+O9Be4lmwUijd2naoD5DHhVVI/iVAYrA8sEPvkPqBuLPiPGwcq6pcmvuk0IR5ZIyfVID9cIf/vhMFTqQVQero1lhZCxceHTSt0PfymqKG043jICgYoyOg6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(31696002)(36756003)(38100700002)(6486002)(2906002)(6666004)(186003)(53546011)(6512007)(6506007)(26005)(316002)(66946007)(6636002)(4326008)(66556008)(66476007)(8936002)(8676002)(478600001)(5660300002)(41300700001)(110136005)(31686004)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmEzZkt4R2RQb2N2NDFCOWRTcmJLL3pIZm1aTzVyNzVROG1ON2VpVkN3eE5M?=
 =?utf-8?B?YkE0NEdmWlBIRDZZbW9vT2ZIM2NQNGo1cW5VWTlVdzArNW14U3YreTlWNjlZ?=
 =?utf-8?B?UFh0Y0wzcFBsbHVIOVlIZjlaWkdlbVVvMlBCa1oyY29HZnkvcFhmRk02Sm4z?=
 =?utf-8?B?ZndpUEJCZHI5V1Y2V3Q5a0czZzBDMk5xUSt4TWw3RFFOR0xCd2R6aUR3d1dz?=
 =?utf-8?B?TkRoOWMyV0wyT2dsR292Ri9Ib2NXMXB5WExBcmR6cmYzS0JRZzhpV2hOUlp0?=
 =?utf-8?B?N3U2WXNSZ3ZwN2tpVDdNYWJxSHYrQlA4UHRXUEZZcFpsYUV2ckV0SVFUeWF5?=
 =?utf-8?B?OTdxbUEvRHhyKzZOVjBtRHU2MGFERU9sVzBMdlNKODFCOW1OYWQ3WjFxVGNy?=
 =?utf-8?B?UGlYMjNnc2lvdCtGaHlzM3pCV1VrcXBhMXk0YkliTHUxZ0wzOCtVRG9WNFlF?=
 =?utf-8?B?YVJNZHhtMHdBTmRpWW1ic1hTWmh2M0pPWHVHTGRQS1dCcEFBNjFqYWxlZkxq?=
 =?utf-8?B?NGNXRXh6Y1lpemZOM1ptcFdaazhHRGFUZFQySS9tc2twcWY2L1NicDZ2NjU4?=
 =?utf-8?B?cTVzNXJlTE5ubm1pb1NyRTRNOGNHclU4KzFQMmpkUEVJeTJMOUZPNnpLbHF2?=
 =?utf-8?B?clhCZDBVNEs1cExmQnlaWHk4UWRhWTN3R09JakIyMG1PNHcxSi9rQzRxd2FN?=
 =?utf-8?B?R0g1cU9RZDJ5VEcydGhpSis5ekpTRkE0dUtLMU0wZm8vMTFUSHp6RmtSTWgv?=
 =?utf-8?B?RjA5bmZOaFBPNGlEWGJpdjVNdlR5b1Qwb0ZSZXJib2xXK0MvTzhXdlljNzVo?=
 =?utf-8?B?UFlmbVpGNng1ZENQRERNV21sanpwSmRncUxDQWJ0dlhPVU5wMDlWL3RISWc5?=
 =?utf-8?B?dm1jeVBjdUFxZUZVbWFVdk55NmRIS0lBdUx1anZ2NkJaWnZnNU56YTJxeDd5?=
 =?utf-8?B?a2J2UHQ2Rm5GR2NGWk5XUE40bHJmc0tLRk9zZk1FcllKeVB2V3l1eVNMSm5Z?=
 =?utf-8?B?c3dSVFlqeXM2WWpXLytJeHJ3ZE1IbnIrMWJtbUZLUStHL0F3ZmQwaW5kZldV?=
 =?utf-8?B?SmlrSEV0dUlHYUVyRUVLeDFXMU5QM1BCV0JLRmIyUXpBdEtxZitqMGMxM3lj?=
 =?utf-8?B?MXo3SXB3OWxoakpTRHdxSFExLzNLZExTYkkrMzRaSnVUT2tCQVFHVEZ5eFpt?=
 =?utf-8?B?NGR1cUdzVHE4VFBHellHdU5XMmV1NldBU05EYzdWYjdxZnI5SFdQL0tpQzg5?=
 =?utf-8?B?VXM4RUdhM25XZmFaTkZyNUdLU09kbnJkSkpXR2wwc1NVdWtGUWVxeVphZ0J3?=
 =?utf-8?B?Y3ZGOVlXdENuNDRpbnFSME1LNU9pSDVVeVY1TnhvUFBTZzlBbWRJNXBhNm9E?=
 =?utf-8?B?Vkhpa0VjTGFrVE5PUG5aMVdMTitERWtDNGtDTkVkSVRYRmRuRVliTTlDNEtx?=
 =?utf-8?B?QWVLL0E1QmI4UjU0QVlwNC9xSGxCTVdER1duSnpmczYzVVgzVDJsN0kyZmxV?=
 =?utf-8?B?WmFyVjZnNk5IMHhISkVmOVN0dTA3Vmp0ck9MRkoxUktmM20yY0NKQ3Y5NEFH?=
 =?utf-8?B?SUdGZllYd0YxdU11akREc2lGUDNvb0VhMzdKSkh3MVdZVUZsVVdpdzMwVDBq?=
 =?utf-8?B?bWUrMWxFM2JLQ0hKNDhRMUdSU3VCQXlNbVZWU0VOTnYzTnQ4ZzRpOVU3UlFT?=
 =?utf-8?B?K2tsYUtJNjVjUTdSRGdUcXlaSnRxNWNWcUxlVnpSTmdWSldENVRiUStPVDAv?=
 =?utf-8?B?Vnc2bE8vbk1mM0RCMlg4QXplcG8rSkdTaUt2d0Rwb2tWRGZ2TndoTk1KWTR5?=
 =?utf-8?B?UGlQTmRkMXh0dlBFd3VhbGJCWFl2b0s0Ymd3R1BBZ3MvRXFWSXFadlBPaVda?=
 =?utf-8?B?d0dabi91RHB3WXdZcHlRdVRwUjEvRWNMYkxRelZUaWs2REt2MDI5bUUyT3RM?=
 =?utf-8?B?dnI1cy9SNUVYRlpHZDlub2xtMGZsZW1RWVh6Njk0YWwrR1ZkZVdFdGE0UEZ4?=
 =?utf-8?B?QlR6ak9qZlVFc09vc1R0SlZMNHBaUTdxTGpqbzV0TUxiWEczMnJCQ1pXamFa?=
 =?utf-8?B?blFJTTUrNHZzYmRETis3b1VFa09QQVZaM09YRGs4RDZ4OE9VOWFid08wSWpE?=
 =?utf-8?Q?jgCK9+uewU3YZe7O1/4SI1lWs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad859824-3b00-41b9-f985-08db6bf5c4db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:05:51.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5PG6ziJJSyVlut3YBQsLltr85TYccHZaWa0bEaqmRzT1lVh6+Qm9a1zT8bXqHlK9sLt90S30bB1lhJR7iLf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 13/6/23 17:59, Greg KH wrote:
> On Mon, Jun 12, 2023 at 09:51:38PM +0000, Avadhut Naik wrote:
>>   /**
>> - * debugfs_create_blob - create a debugfs file that is used to read a binary blob
>> + * debugfs_create_blob - create a debugfs file that is used to read and write
>> + * a binary blob
>>    * @name: a pointer to a string containing the name of the file to create.
>> - * @mode: the read permission that the file should have (other permissions are
>> - *	  masked out)
>> + * @mode: the permission that the file should have
>>    * @parent: a pointer to the parent dentry for this file.  This should be a
>>    *          directory dentry if set.  If this parameter is %NULL, then the
>>    *          file will be created in the root of the debugfs filesystem.
>> @@ -992,7 +1010,7 @@ static const struct file_operations fops_blob = {
>>    *
>>    * This function creates a file in debugfs with the given name that exports
>>    * @blob->data as a binary blob. If the @mode variable is so set it can be
>> - * read from. Writing is not supported.
>> + * read from and written to.
>>    *
>>    * This function will return a pointer to a dentry if it succeeds.  This
>>    * pointer must be passed to the debugfs_remove() function when the file is
>> @@ -1007,7 +1025,7 @@ struct dentry *debugfs_create_blob(const char *name, umode_t mode,
>>   				   struct dentry *parent,
>>   				   struct debugfs_blob_wrapper *blob)
>>   {
>> -	return debugfs_create_file_unsafe(name, mode & 0444, parent, blob, &fops_blob);
>> +	return debugfs_create_file_unsafe(name, mode, parent, blob, &fops_blob);
> 
> Have you audited all calls to this function to verify that you haven't
> just turned on write access to some debugfs files?

I just did, it is one of S_IRUGO/S_IRUSR/0444/0400/(S_IFREG | 0444). So 
we are quite safe here. Except (S_IFREG | 0444) in 
drivers/platform/chrome/cros_ec_debugfs.c which seems wrong as debugfs 
files are not regular files.

> Why not rename this to debugfs_create_blob_wo() and then make a new
> debugfs_create_blob_rw() call to ensure that it all is ok?

It is already taking the mode for this purpose. imho just 
cros_ec_create_panicinfo()'s debugfs_create_blob("panicinfo", S_IFREG | 
0444,...) needs fixing.

> 
> thanks,
> 
> greg k-h

-- 
Alexey
