Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E862CC9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 22:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKPVVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 16:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKPVVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:21:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC05D6BB;
        Wed, 16 Nov 2022 13:21:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UT45jSaI0XnpVsJ+T6CVpF6Q+/ZtXAAVpeOObPVhDSL+wNZggXp3G98Ywp7qe7mE3tCje9GSHE8qDQDR/8hAw1kgMCNacqehH3YUY5gvmVUgcffW1kpecKjYIWJFD+eQc61LqAxOchuoRy8YJlQeVNx4aqOQQOqdZ2BlECtaPEe70p7CGX86Inhs8HvDwc/er4CHCaazXb3M0tGI7l6UXTafR0pKuJ8N04YH7Vh5tLaxOUTfQvLaN5W6r+j/lWQgvGur5GNAaE0HPnDBSqcPCMBAbXXtxwmCOkKGbP4OK2wJwq1Y23OBxt2LJt53r/4iHTt+jzN0GdEVllc3vYGzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlBooel3bQsx0yj2lfPEm6xPnqfMroYPlRTiC+tc8pE=;
 b=No6FIq0MEUgdJwpHdNMjeDo8f7La/AvwVeFoNibyEpKBiDtW1/gpohS78XxL9a/Sz8l0wIlIUCHUs952Ba+uDKb7lMd81f0wCqxlb+Oo6efWAq25wEMuWZ4UkU5mbcwuKQ1rOnxuVWNhfRe9COFA50b0759G0gbcWBIGt1/DDU9YziuMuK8U5OluU8UcLsXngETxTf1MJZTFZWdGa1ob5xES+MfeEAceJuAVOupIe5hQ6pbjwXYdUqap14IIS2lI8CC10YioxyCCGH0iSmVmkZ7SRnBlBksf9lCpomQs6mH7UDJlySlgNXEbdZaWinXDsPFYv9BACYD44fN2LWWZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DM6PR01MB4569.prod.exchangelabs.com (2603:10b6:5:7c::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.18; Wed, 16 Nov 2022 21:21:12 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a621:8f2f:c5a6:9d33]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a621:8f2f:c5a6:9d33%7]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 21:21:12 +0000
Message-ID: <1712a4c3-459e-bb25-5b02-fc3fb96145f2@talpey.com>
Date:   Wed, 16 Nov 2022 16:21:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US
To:     Stefan Metzmacher <metze@samba.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, smfrench@gmail.com,
        Long Li <longli@microsoft.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
 <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
 <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
 <c4f8959b-15c5-b32f-18fc-8befb4f75da2@samba.org>
 <4b94b915-e3cb-01a7-92be-70d291f67f4a@talpey.com>
 <47cd5c51-4b6c-c462-179e-7276c851253b@samba.org>
 <423b4372-2149-6576-ed9e-795ccdece05e@talpey.com>
 <3fd0217b-dfcf-05b7-dd24-4ad69f25a813@samba.org>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <3fd0217b-dfcf-05b7-dd24-4ad69f25a813@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0047.prod.exchangelabs.com
 (2603:10b6:208:25::24) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|DM6PR01MB4569:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a06649-9119-4f3f-2340-08dac8187c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hVqFF/oVh9uhkIs9giqS4DGZixB76OnauFD/O89Mw1DXXvcjhzqNSUPq0Ue/I2Ruhxhegew5G6NyP21Uq/0at7d4y8vwJWNQ8ZzGDiruyibCycMLWKcvtzIx8/0uXh7Hhl1U3UgCkT5K8rOPwr8R+RTaX9C+a2CuVjBvHFAscBGTMGUvlXncuGaYCNyr55ZtkY8vueweyglOnrtJIvhe8QVR0xBvBPmKzQRdOkHXK81JWC+mPqC0yZZlnm8mziZQLWifs/GgvvpVPw5Lqf0hPcjtmUqgYzGhWWZodan4kKGkXNdhCUAPr79z8MaH/+wK0XEKG3TWVSv2K3CvZytOVf6YGvnuC3g2sSCWfcw67dYEuncsyk+1zZ5AVEK9FnrpJqZMwGzdi67LVYADDYkUg0YyfmERsMF/yI6OPal5wX9loCzi9A+Iy4PIVo7dZ1YwH5t8HrOaJNwLRSd9DKI6FIzRP2tr6ykO62ITM+zCEMP7VYpBSLGYU7a6DGevrxuY+S/2TNdg1CcWOwqhLian9cv03M4ZYYxTIHTnB4fXn4qrlteZn/ZSIaBL2U2ZFAoygh//MLeNTzHvw5test2wJBcQhaJAC9n97HCPPGiYBA8K8h78lg6JvIpw5GthI7rbn0Hklrn8vdhsi9L3O/s2vJscAtzI+4LwHrFjxB8ioRjuJ9W+RoLbhEcbejQKFY3gASVBgAOhZtpdoe2b7l3QkuRcfyl7YpM7lSk9vBOzAYBpqY5i1rn3Yj4BHh5aZJK4SjZiMgpXXmx5OLrNmC9g6k26NMYRW2sWz6yWhg9HPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(39830400003)(136003)(346002)(396003)(366004)(376002)(451199015)(186003)(6506007)(66946007)(6512007)(66556008)(26005)(66476007)(8676002)(83380400001)(316002)(4326008)(2906002)(4001150100001)(478600001)(5660300002)(36756003)(41300700001)(6486002)(2616005)(8936002)(45080400002)(31696002)(38350700002)(38100700002)(86362001)(110136005)(54906003)(53546011)(31686004)(52116002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnhjdTFETkRadjNwTEFCa2U3NkNUQzhQLy91dDE4aXJLTXVJZ3JKbVlwV2NU?=
 =?utf-8?B?TC9nLzdzWkwzcGVTcHNVQjZHZVA3S0J4b1dZS1U0QUMzZ0FQYTFXcFhXTE16?=
 =?utf-8?B?Z1M1VnIyWUIrUFV5TXI4MXZ4aElCQ1hYaVhEN3VuOXg0OVlTNTBRRDF0VXlH?=
 =?utf-8?B?WFE2TVB2SFJGbGdZMVpGSVV1V1gxUVdncUhYdCsveWFSeElnY0kxRWYrcms5?=
 =?utf-8?B?VmlFZGFrTGJtbGZ6MWRURTQ5cFkyek1wTWhGa00yVjRQNDlmbDJWWmphV2gv?=
 =?utf-8?B?Z2NRdHhySEptdHFSZndDbTRJQXVBaU9PdWN1U21kMmpTdE9ZZmgwWGhwTlhS?=
 =?utf-8?B?TFpnZ1p6b24rcGhRZW55WXlYMVVjdUQ1ZU56Qm0yMnFtVnlRWFVCTi9mWU1Z?=
 =?utf-8?B?bXd3Zzd3UUd0TGd1aDJGTEFITDRBNC9HWnhuQkpPL1c1ZnBxMXZLVURGSDVI?=
 =?utf-8?B?ODdIcE1WMkh1T1d5WVVOOGFQYlVBM0s2QTRLS1FzR0paeUJCOFRNaDBqTWdw?=
 =?utf-8?B?eE9DUFdXK1d1NmJMNVdMQVF3MGkxS3dWZDFzZ1d3YVh1QWtmN0EvTlN0NUcv?=
 =?utf-8?B?VFdoY2lGRmdQQ0hOUUhiUGMrSWJHM2hsMkRGRlRwZkdhbkwyYnprU2paRWtB?=
 =?utf-8?B?Zlg4WThUYkM2N1NtWlNYZWdVUFYvRGgwTTFNQUpPTTBCMXNrUkUwNjNmYUZV?=
 =?utf-8?B?b0pCU0VEanZBdHloV1lPcmtqdTlsbzk0ZlVnK0o2Y0wwZm91eEhyNWhkWUVu?=
 =?utf-8?B?K1UwNFhxa0JGT2NLUmVsRThNdk1lTHlQK0tGNGE0YS9yVmtqb2tBQmFXakJj?=
 =?utf-8?B?cXMrMEF2bTBlV0VURjhKSlNBa0hvY00xbktSbCtieFo3ZUlJWnpYR3UvMXZx?=
 =?utf-8?B?QlpRZEY4Y0drd2VYb0hlTURHTHNETGRxc2o3Rng1VUVRSmhJYnpMMmJmMkpv?=
 =?utf-8?B?alFWbFEvd3JEZ0dBcmxCM0tCWTM2N1ZBQ0NJbStuampqcmJNR0pYemxjdWdP?=
 =?utf-8?B?M2w3UmtTZHF2ekJjRHJub045VFM0dEZwRGFSSjZHcnFSVjh0RUpwNGZUclRR?=
 =?utf-8?B?TWNNUHllaUU3MU5qTWt5TEtqMU9RcDN4bjU1VDVsSE90OXE0ZzdZVWtPTjNh?=
 =?utf-8?B?STVkN3BpYlVXeVRuaSs3Tk1DZk1OZGJGWWVLSldyQ1diYzRBNjVBaVhaS2dX?=
 =?utf-8?B?L0ZjTVhLNTRCd3RkT2gvcThsZlUrcmZlNE91cmI3c2hXM3hjTWRnTlQvckpk?=
 =?utf-8?B?NG03blNTN3kwQ0p3VUxTYnJBUGcvM1hhbndERDlSNU53VXlINzRYMGZjRFgv?=
 =?utf-8?B?NFJ4SUtaVmdBbTh3TWNJdmxrUGJFUkZWTGRJeC9DUStUM0ZaRWUvSGY2Nkhm?=
 =?utf-8?B?bTJFVW4veHNiUUZMc1lDTXpHYlNXSjhZdHVCanNOdE0zSmJGZVJFYTJqRTYv?=
 =?utf-8?B?N3ZIdnFJTkVhdWNtV1hoZ1JxTkFYTHpEU3FGZTFGRWZaR3FUSS9JNUd5ZEcx?=
 =?utf-8?B?ajAxTDRoSm5UWjZmL1haVVNkcCtwYVE2ajZRN0s5aUUrMFhPQXZiRFRDelYx?=
 =?utf-8?B?UUZGZFM1SGlmSTdzVnc2bHFxeW50eHhtMStZeVRHZWNHbjZsZ09uNDBUclhh?=
 =?utf-8?B?ZzduajFDOXNiQVVkcVNpWUN5aENRZk9JSHNGN2krd0pTSHAyc3RwYU54WnFG?=
 =?utf-8?B?elNrYmRvYVl5QzczMzBrL2VMU25ZNEZ3amFkUE5mNVlQN2JhS24xRXdpSFdw?=
 =?utf-8?B?TExvd1EvS3l6WlMzeFBBUGI0SE5VSlZGYjFTQkZycW5QWmEzVHI2OGFzMDlO?=
 =?utf-8?B?YlpHR0JpakpkTndBVzJva1BMODV1UFMvWXhoaWQxVGROSHRUQXk3RnV5QnBQ?=
 =?utf-8?B?WVFxMWJidUdMZ1dyZFhXcGdOa2VGZkthMkhsQUJpMG9LYkNISHI0M3o3TkVt?=
 =?utf-8?B?dFBhWW54Zk5wRGttRGVIUHFGYXJXL1IwTFNTZ29sSXVPVC8yOG00d2pQM2pw?=
 =?utf-8?B?aGdhRlBML29ZN2ZjL3o2KzZPUG1kMWhIdCs0bkJ2Y29JdHBoYTg5eHhqR0ZZ?=
 =?utf-8?B?ZWRrVDhDZnhXdDU5RWgrQS9yL292QkNaQitSUGgxZGFLRkFHTFlxbzRlMlJs?=
 =?utf-8?Q?oAm8=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a06649-9119-4f3f-2340-08dac8187c67
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:21:11.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66nlZ4V+T9yAaN6W4aBczRX79/XzGvKcMN7FmOvai8vaXl3JTRo79C+wz0GJ4aOq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB4569
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/2022 2:53 PM, Stefan Metzmacher wrote:
> Am 16.11.22 um 17:14 schrieb Tom Talpey:
>> On 11/16/2022 10:44 AM, Stefan Metzmacher wrote:
>>> Am 16.11.22 um 16:41 schrieb Tom Talpey:
>>>> On 11/16/2022 3:36 AM, Stefan Metzmacher wrote:
>>>>> Am 16.11.22 um 06:19 schrieb Namjae Jeon:
>>>>>> 2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
>>>>>>> Hi David,
>>>>>>>
>>>>>>> see below...
>>>>>>>
>>>>>>>> When the cifs client is talking to the ksmbd server by RDMA and 
>>>>>>>> the ksmbd
>>>>>>>> server has "smb3 encryption = yes" in its config file, the 
>>>>>>>> normal PDU
>>>>>>>> stream is encrypted, but the directly-delivered data isn't in 
>>>>>>>> the stream
>>>>>>>> (and isn't encrypted), but is rather delivered by DDP/RDMA 
>>>>>>>> packets (at
>>>>>>>> least with IWarp).
>>>>>>>>
>>>>>>>> Currently, the direct delivery fails with:
>>>>>>>>
>>>>>>>>      buf can not contain only a part of read data
>>>>>>>>      WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>>>>>>>> handle_read_data+0x393/0x405
>>>>>>>>      ...
>>>>>>>>      RIP: 0010:handle_read_data+0x393/0x405
>>>>>>>>      ...
>>>>>>>>       smb3_handle_read_data+0x30/0x37
>>>>>>>>       receive_encrypted_standard+0x141/0x224
>>>>>>>>       cifs_demultiplex_thread+0x21a/0x63b
>>>>>>>>       kthread+0xe7/0xef
>>>>>>>>       ret_from_fork+0x22/0x30
>>>>>>>>
>>>>>>>> The problem apparently stemming from the fact that it's trying 
>>>>>>>> to manage
>>>>>>>> the decryption, but the data isn't in the smallbuf, the bigbuf 
>>>>>>>> or the
>>>>>>>> page
>>>>>>>> array).
>>>>>>>>
>>>>>>>> This can be fixed simply by inserting an extra case into
>>>>>>>> handle_read_data()
>>>>>>>> that checks to see if use_rdma_mr is true, and if it is, just 
>>>>>>>> setting
>>>>>>>> rdata->got_bytes to the length of data delivered and allowing 
>>>>>>>> normal
>>>>>>>> continuation.
>>>>>>>>
>>>>>>>> This can be seen in an IWarp packet trace.  With the upstream 
>>>>>>>> code, it
>>>>>>>> does
>>>>>>>> a DDP/RDMA packet, which produces the warning above and then 
>>>>>>>> retries,
>>>>>>>> retrieving the data inline, spread across several SMBDirect 
>>>>>>>> messages that
>>>>>>>> get glued together into a single PDU.  With the patch applied, 
>>>>>>>> only the
>>>>>>>> DDP/RDMA packet is seen.
>>>>>>>>
>>>>>>>> Note that this doesn't happen if the server isn't told to 
>>>>>>>> encrypt stuff
>>>>>>>> and
>>>>>>>> it does also happen with softRoCE.
>>>>>>>>
>>>>>>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>>>>>>> cc: Steve French <smfrench@gmail.com>
>>>>>>>> cc: Tom Talpey <tom@talpey.com>
>>>>>>>> cc: Long Li <longli@microsoft.com>
>>>>>>>> cc: Namjae Jeon <linkinjeon@kernel.org>
>>>>>>>> cc: Stefan Metzmacher <metze@samba.org>
>>>>>>>> cc: linux-cifs@vger.kernel.org
>>>>>>>> ---
>>>>>>>>
>>>>>>>>    fs/cifs/smb2ops.c |    3 +++
>>>>>>>>    1 file changed, 3 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>>>>>> index 880cd494afea..8d459f60f27b 100644
>>>>>>>> --- a/fs/cifs/smb2ops.c
>>>>>>>> +++ b/fs/cifs/smb2ops.c
>>>>>>>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info 
>>>>>>>> *server,
>>>>>>>> struct mid_q_entry *mid,
>>>>>>>>            iov.iov_base = buf + data_offset;
>>>>>>>>            iov.iov_len = data_len;
>>>>>>>>            iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>>>>>>>> +    } else if (use_rdma_mr) {
>>>>>>>> +        /* The data was delivered directly by RDMA. */
>>>>>>>> +        rdata->got_bytes = data_len;
>>>>>>>>        } else {
>>>>>>>>            /* read response payload cannot be in both buf and 
>>>>>>>> pages */
>>>>>>>>            WARN_ONCE(1, "buf can not contain only a part of read 
>>>>>>>> data");
>>>>>>>
>>>>>>> I'm not sure I understand why this would fix anything when 
>>>>>>> encryption is
>>>>>>> enabled.
>>>>>>>
>>>>>>> Is the payload still be offloaded as plaintext? Otherwise we 
>>>>>>> wouldn't have
>>>>>>> use_rdma_mr...
>>>>>>> So this rather looks like a fix for the non encrypted case.
>>>>>> ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
>>>>>> only smb2 response is encrypted for this. And as you pointed out, We
>>>>>> need to implement SMB2 RDMA Transform to encrypt it.
>>>>>
>>>>> I haven't tested against a windows server yet, but my hope would be 
>>>>> that
>>>>> and encrypted request with SMB2_CHANNEL_RDMA_V1* receive 
>>>>> NT_STATUS_ACCESS_DENIED or something similar...
>>>>>
>>>>> Is someone able to check that against Windows?
>>>>
>>>> It's not going to fail, because it's perfectly legal per the protocol.
>>>> And the new SMB3 extension to perform pre-encryption of RDMA payload
>>>> is not a solution, because it's only supported by one server (Windows
>>>> 22H2) and in any case it does not alter the transfer model. The client
>>>> will see the same two-part response (headers in the inline portion,
>>>> data via RDMA), so this same code will be entered when processing it.
>>>>
>>>> I think David's change is on the right track because it actually
>>>> processes the response. I'm a little bit skeptical of the got_bytes
>>>> override however, still digging into that.
>>>>
>>>>> But the core of it is a client security problem, shown in David's 
>>>>> capture in frame 100.
>>>>
>>>> Sorry, what's the security problem? Both the client and server appear
>>>> to be implementing the protocol itself correctly.
>>>
>>> Data goes in plaintext over the wire and a share that requires 
>>> encryption!
>>
>> That's a server issue, not the client. The server is the one that
>> returned the plaintext data via RDMA. Changing the client to avoid
>> such a request doesn't close that hole. It's an important policy
>> question, of course.
> 
> No, it's the client how decides to use SMB2_CHANNEL_RDMA_V1* or
> SMB2_CHANNEL_NONE. And for any read or write over an signed or encrypted 
> connection
> it must use SMB2_CHANNEL_NONE! Otherwise the clients memory can be 
> written or read
> by any untrusted machine in the middle.
> 
> MS-SMB2 says this:
> 
> 3.2.4.6 Application Requests Reading from a File or Named Pipe
> ...
> If the Connection is established in RDMA mode and the size of any single 
> operation exceeds an
> implementation-specific threshold <138>, and if 
> Open.TreeConnect.Session.SigningRequired and
> Open.TreeConnect.Session.EncryptData are both FALSE, then the interface 
> in [MS-SMBD] section
> 3.1.4.3 Register Buffer MUST be used to register the buffer provided by 
> the calling application on the
> Connection with write permissions, which will receive the data to be 
> read. The returned list of
> SMB_DIRECT_BUFFER_DESCRIPTOR_V1 structures MUST be stored in
> Request.BufferDescriptorList. The following fields of the request MUST 
> be initialized as follows:
> ...
> 
> 3.2.4.7 Application Requests Writing to a File or Named Pipe
> ...
> If the connection is not established in RDMA mode or if the size of the 
> operation is less than or equal
> to an implementation-specific threshold <141>or if either
> Open.TreeConnect.Session.SigningRequired or 
> Open.TreeConnect.Session.EncryptData is
> TRUE, the following fields of the request MUST be initialized as follows:
> - If Connection.Dialect belongs to the SMB 3.x dialect family,
>    - The Channel field MUST be set to SMB2_CHANNEL_NONE.
>    - The WriteChannelInfoOffset field MUST be set to 0.
>    - The WriteChannelInfoLength field MUST be set to 0.
> 
> For sure it would be great if servers would also reject 
> SMB2_CHANNEL_RDMA_V1*
> on signed/encrypted connections with INVALID_PARAMETER or ACCESS_DENIED,
> buth the problem we currently see is a client security problem.
> 
>> I still think the client needs to handle the is_rdma_mr case, along
>> the lines of David's fix. The code looks like a vestige of TCP-only
>> response processing.
> 
> I'm not saying David's change is wrong, but I think it has nothing todo
> with encrypted or signed traffic...

Ok, I agree that this uncovered two issues. And they're independent.

I'm digging into dead code and questionable read response parsing in
smb2ops.c. I guess we can be thankful it failed. :) I've also asked
Microsoft for clarification on the Windows SMB3 server behavior
regarding non-encrypted RDMA.

Tom.
