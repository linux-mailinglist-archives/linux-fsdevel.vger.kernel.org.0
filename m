Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFE72C63D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbjFLNlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 09:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjFLNlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:41:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6CD109;
        Mon, 12 Jun 2023 06:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3TIK19yKu90JcKDCDR2Dg1MdSJF37REj69ZGEWULiV3DYtbzsZAZr8F2QIu1buWYBUgBvve7Rv0XKyKScEYuE1MG7M6eM6BjRw+nShL7sMv8dubV5d4kgvyCf0Cy1n5+SdAjE+OWaih3yJ+nIrsQOLnOyyYAEqpyJ3Yu+bEVdbTXHwUpDL4NB/n5adNfS56OLsqfQosWilghj7+BzITSa7VFDcYGDaQLaifD0gNjgJf9bNbaudiyIWJqGeUqh8aRMkorQ8UzDzKfsP7tqiMmJkeQfWNr3clQiVtDkaBMG9uHCrD2MyHk6+kdHjpW26jm2y1U3zyFl7OhsL+e1QCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/WheizpUOuCqeT6wYF6UD5tsow/zt0HjUIBAV9LN/M=;
 b=ZQCuFngm6rZ8h6puVwySkR9cHQylMhjaz3xi/jjGJppxYuhWWqaZM8wZR/5XwnZmWRIMiTq7GMBvr9PDGQ5AItFlk81SCMCPRqTDhy0AefixxgVA6/sw/3D74UC27MZBoQZrxkjqsQzmfjrUlNcs6GomCPy1GAFDA9YyJ4/HEonSQNMv2tHr47QWAWd6NpdC4m6PwgMEh1wnHhwZ7j+xyq8M4TJEFIoNatAU6lRFKMMSIp6cjEHiqJIUn9e7Q1201IIOENyBTtBH6o1UC9nhbLVX7xrpNN2RTsH+X4Od3VR7DzZFLVPeJIyzMWd9rFEP9efuJUCaiJUX15xvRgViZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MW4PR01MB6338.prod.exchangelabs.com (2603:10b6:303:7b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Mon, 12 Jun 2023 13:41:45 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::17e9:7e30:6603:23bc%5]) with mapi id 15.20.6455.039; Mon, 12 Jun 2023
 13:41:44 +0000
Message-ID: <a34b598a-374b-5dbf-dd36-4b62e52fe36c@talpey.com>
Date:   Mon, 12 Jun 2023 09:41:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 8/8] cifs: update the ctime on a partial page write
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
References: <20230612104524.17058-1-jlayton@kernel.org>
 <20230612104524.17058-9-jlayton@kernel.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <20230612104524.17058-9-jlayton@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::29) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MW4PR01MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5607b0-0f73-4b03-eebb-08db6b4ac19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya5XKPcBWekEZdw1jgAQZhCRC6oCdMod6fBUEqZongwZE4e7pYiHP7rouXww8PMCGiI5ETv+1FubdoGeS9bHLj8NqGdKiGfKMjDLUTChM+fli01Vz2QaneCyY4Iv81RDeagLVN+SxngUgtKUfcqv9/46H9bn1OCZKjRaXEn1N3cSurntWLPnGzKJ0bGRmHORbQl0XX21TWHBKV2uuHFiaohplF5hAnYZJoxjjWq46jfckpsvDbHTp6wDUnt5K676I9yvWcZ7mEN1bJpB9OecvgbVAzsbQLMbCVt5Z35t2ypOHXf7dA9DNNFnvsIbtwiJb9zEUxREpIhL6vq3Ll3AjcJreZZvagcI2j+/gU2+owSAFWW+g3Hm0coMqZPl5hjojQ0JuMOCwO5URpjIXFk6M9snamRC+zx58YuFr9t/uK3PM0EPnPzKMorB+5PIa2odMUT8mHorYEwRBxC9g1scOOj4T4YpngHRD10H86Z2GTt8Sc+2M7pZGQuQPgm+vI9dqak9ouW2IDPjea9aCheuj/9DZusiXBodhN2ksKopal1hrNyvMnV6eT1whKfiR5ABJUVPEcu3oN5hS9XbrK+nmOtOWFT2KB0mQaNvPDd0FTR3girKVY6Kbn824sIEuOY3BJBHGXzrQ4O9T/RprMdFc3Bfk8wtwYzsAMJEMPavpLM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(376002)(346002)(366004)(396003)(136003)(451199021)(110136005)(921005)(478600001)(66556008)(8676002)(8936002)(41300700001)(5660300002)(66946007)(66476007)(316002)(38100700002)(38350700002)(2616005)(186003)(83380400001)(6666004)(6486002)(52116002)(53546011)(6512007)(6506007)(26005)(31696002)(86362001)(7406005)(7416002)(15650500001)(2906002)(36756003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzU2SzV5R2w4cERPWXExNTRYMVpOUGVxWUhkV1VLMVNXelp5WVIwaDFWbmJr?=
 =?utf-8?B?UUZXTjhNeTMyTWswUHVGQk14YU41WGtiTFU5MGNWSE9MZDk5a2dZRWI2OFRS?=
 =?utf-8?B?MGRtc0txbmg1NWdJRC84UXFpV0I3QmZ2VUIvQTBzZmNyRWRPUDRiRDdSYnhm?=
 =?utf-8?B?RWtiOWhEd1p4aE8yNlIrRjI4dWphZG11Y3k5ODhlRHEwS1RvUkgxSSttVUdY?=
 =?utf-8?B?UVB2bkQzdWFqSUI4TjFjdGpoVVoxY2xvTVFPZ1Vxa3hSVGk4QXVJVm5EeCta?=
 =?utf-8?B?YVMyVUdrbjJwN2lCeDJIK1NYZWhmdDUyQ2tZSWlUUTVuVUsrd2F2NVpOUnEz?=
 =?utf-8?B?SFV5Z053aWlkNVVFVzY2S3pMUjZnaExVamVpczhLNkgyMlBjdmVka205c2RF?=
 =?utf-8?B?dHpwVXR0bVlINzVhUTJZdTVlMFpLS0E3RUU0MjZLSEhJZ1RuTG5hRVZlQzF0?=
 =?utf-8?B?ams1cmMzY2IzNVBxZDBRYmE2czNqNjl0ZEtCWXpPQWhzUnBoK24xejM2R1Yr?=
 =?utf-8?B?QjJrVVE3WEdGK054a0xtbEJDbit5azQ0UTNyeTdFU1hsUHYxclY2ZTExTUZR?=
 =?utf-8?B?MmU5Ums4K2lnam1VZWN6UmxFK29Pcm5jWU1aUS83eG9kNzEweUNvZHJ4dm0w?=
 =?utf-8?B?cTBCTWxBYTYwcGlPZ08rOEVtNG1KT3RjcEJlNzg3T25YZ2RKTGJVNDMrZDl5?=
 =?utf-8?B?NHpnanZLSklMbnlZMDdrSG1tSmgvVVVqNEdYa0xuVGY0dkZUQTV3YTBCM0Na?=
 =?utf-8?B?RFhLZVdjWmRhcWVWNGM0VlU3djU2RlYvM2JoTjN2WkxQSkZBOXJBeU0xOHJW?=
 =?utf-8?B?bWRtOUE2QW81c2dSMjJDUHFKSStCdW1jVmNkR1lRSkV2dmNtM3dITDdOQmp3?=
 =?utf-8?B?ZGVLODVBdVBXYXhRTVlQdS9lNUVrYlE2c2tRMzFCQUJ1cy9pbFZ3cnp3RitY?=
 =?utf-8?B?Y2daZUc5QkJuc3ZoeHhmWmlJbWYzbDN1amN3ZVJWZEJVcjc3TWI2ZDBHSzdV?=
 =?utf-8?B?NkRMMlVLZUs4YVZSRTNpYUsyLzNPY00vdG82MXBFOGVDMXlUbnhwQ3E0all2?=
 =?utf-8?B?eE9GdXdnQmhpbjlzTVNYQ1JpQzJtYjUwUHFmSE80NTA4M0E3dXdBclljbGhv?=
 =?utf-8?B?eFdvVGxpYlMrTUdOeVhtU0JJWWhhajQwSnlLbGRRSUVRN1p4RFAzZElOSWFa?=
 =?utf-8?B?cnBXWWIrWE1kRWFuQkpEN3FQS29iczc3Vjl0RnZEc0xOQmRrcmFtVDFnK3Jl?=
 =?utf-8?B?dWU4dzR1aWNPa3dUZEVwelJlenJpZ2NIT2RHMTlnUU13Ykl5SGY3aFFpK1ln?=
 =?utf-8?B?R3BxblIyR2FTUWtuZU1JSFppanFscE5pSTBtbkUzMEdNdG5PK0Zwa3JEL3R2?=
 =?utf-8?B?OU9SRVBsRi9LSTJPVzE2L1EwUlZaempMMVA5U0NJaUVyYU1SSThINjdPZEFT?=
 =?utf-8?B?ckFuS2p3Rm0xSkFENTRkdStKeUpmWHJ4U2Z4QVUrRmtFQ3kyRDYxTUlhWWFP?=
 =?utf-8?B?MTAzZmxXcGpqM0xDZytkRHBlNWJLWk5WeEpmYWhmNUh5ZUh2S1hPcmpOSVVa?=
 =?utf-8?B?NjBmemVOTWRyL2w0ekJ6eFBQRWlKQXhteDNxc2RpdnJmYWlhUXd6VXVsSWEx?=
 =?utf-8?B?WXdDdEZtRStwaUdoS29adXJYTDYxWk1qR21xOG52V1pFY1lyMG4vdzVLeWFH?=
 =?utf-8?B?SUdYd2FRODE4VXV3WFJJajNERjA0azZTOFVOOS9sYU1sZmY4eVNNT0dpdWVI?=
 =?utf-8?B?WjdrdC95Wm15ZFlBM05XLzJFdXRBMjYwcUFzdDlPNDh6ZjdZVjJrUnBFQ0pV?=
 =?utf-8?B?MFl1Sms2OFJlNmN1dnVTS0NtdnN2NGpnUDFaUzd2R01EYjByRHRoNUVCWVlw?=
 =?utf-8?B?WTlvMmtORmZsN0YxeWthUFZSeFJiWk9RR09xaFN3TFhoV3BabTlsbFpHeWN0?=
 =?utf-8?B?RzhXeWFmS0w4T2RscmtSYVNMYmwvVGErMUtYZW52Um83em9xeVNqU3VZM0Zo?=
 =?utf-8?B?aWdLWDNMWnFrNVZjeFNSU3FNME1VNHZmbGc5YXY1UXVkL1J3czBkeEdKaGFC?=
 =?utf-8?B?T1pmQzRib1hGL2NWVnVHajZZeUxVcGNPd2lTZVBwUHMwbGgwemxNbVdqd0ZP?=
 =?utf-8?Q?72Sjp0RvCpBp5V8m2UqDa4VYh?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5607b0-0f73-4b03-eebb-08db6b4ac19a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 13:41:44.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjGX/3G4SJ3mAjCjgyTNGLVvHFI3PgGglHHug+FAqKPcH+Mefj8Q1o1aIOENTpuL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6338
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/12/2023 6:45 AM, Jeff Layton wrote:
> POSIX says:
> 
>      "Upon successful completion, where nbyte is greater than 0, write()
>       shall mark for update the last data modification and last file status
>       change timestamps of the file..."
> 
> Add the missing ctime update.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/smb/client/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index df88b8c04d03..a00038a326cf 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -2596,7 +2596,7 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
>   					   write_data, to - from, &offset);
>   		cifsFileInfo_put(open_file);
>   		/* Does mm or vfs already set times? */
> -		inode->i_atime = inode->i_mtime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);

Question. It appears that roughly half the filesystems in this series
don't touch the i_atime in this case. And the other half do. Which is
correct? Did they incorrectly set i_atime instead of i_ctime?

Tom.

>   		if ((bytes_written > 0) && (offset))
>   			rc = 0;
>   		else if (bytes_written < 0)
