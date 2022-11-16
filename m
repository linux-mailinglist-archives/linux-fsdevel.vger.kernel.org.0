Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3AB62C3B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 17:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiKPQOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 11:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiKPQOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:14:24 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A2D104;
        Wed, 16 Nov 2022 08:14:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebICpau37SusZjUvEHdYaCmN6Sp4pElJESTZoJevvXHcik2GUtjI/+/4I1FxNfos4XsxPxuvJTBp/xRgeBg/oZS6QyEL8J08eKilOmmn7EdmcuTIBR/fI8NQIfiF5bm78G/YtKhT30zIEuhKJEzZ+RGCreWQ95B4h0peR1p1N1nBfB0Fb7dt4Aan1f76T6J4byuEed0bUVigF1dzVWN0aEZSqYfXPCWtjIz/n0TQ6OvJbZnbzSdqsJhSHBLmJnFVv4t7GNgkRqgcMLD9GBMykjk617lQJ1djxStqBQssTFS1k0NFROJPPU8NQLwFRMEqceznCLNdD+D+UK9el2Xmqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxUm5tqTav6shSv6yPokJDWmYREE5UlU4R5rUPa5a9g=;
 b=AdiHEobsrXc9O4/s7S6FO16BPBf1ZLcFOrjXRE/ucvNr81Ktrk17/Y1NcV9dovZSFiS2PnINDYh8zBcEMYP4mdwyTj3RSyk7zMtKqHOOxhVmAZ2A9DGHcgKometUpyQFDXQ0qV8woNwXGF4zHl1xKaxfEim1NXGQyr8mG6ZFT69rUT6W308N4EoyTsTOcbo8ltNens0nOAAGtuEStqdMhirhjPCKPiBo1IPrhyqZdhNDjcBNlpw/hAHHvqWrTnbwujeQM1dbeKb9WCgv0L8hDsq/Jk3RWSdh3ojEVZSS5Egi6LFKn92T7IRMX6AjAMzBKkJbdI6DP7qrv3lWZddpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 PH0PR01MB6248.prod.exchangelabs.com (2603:10b6:510:c::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.16; Wed, 16 Nov 2022 16:14:20 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a621:8f2f:c5a6:9d33]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a621:8f2f:c5a6:9d33%7]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 16:14:20 +0000
Message-ID: <423b4372-2149-6576-ed9e-795ccdece05e@talpey.com>
Date:   Wed, 16 Nov 2022 11:14:18 -0500
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
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <47cd5c51-4b6c-c462-179e-7276c851253b@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0313.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::18) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|PH0PR01MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: 905bade9-3558-4c25-7213-08dac7ed9e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HI4rvwiSD+IPRwLfGitHXOrWmcrTMPDRbJy7fpwn0B5eUNN87XFz1bYehBMBLnjR55OHt9koa9wI7s0s4lChlVB2CsHLanoMq6kWFNNhfc9CuvAoXLGbTwxaNCodAGiLEB0fyrikQvUnc8Gu8WGLTm0Efndvh6Mi/MFP3M9Ts89stGnzGfKYCDkXrRvYr0ZNVHh4KlRatzInpNQmD9RyrReCzBehZzX9NPjZCI1vcpfkCkf584BfSuz1mXH/h7eVmGgRWJ0s0kO1FYKM4ysfhiIkMRTljcDkovkpzKI4rSOuDsegrhczCYE9B08u7Qeky7a7+ulziDzUsPjRTedzWHlezJCVi3FEvScn8orteZXa9LtgbeI0MEeyCe3UcZQFcOOdso2J01XJCiZDkIkYV04gUEZFoc0+m1PXewNRN0d703kQRkpTKw0C9orOmIqlGez+jR8+9aifRtZAscA4jXf+j8TQnKP6PlN4twcT2Yfog3NRrEJkKmm0XmlJikc23deHR0Re002IcaAG4juHXRuLeCrL+WkZASXuQateWk7g0T9scZ8xSKLu3xXtEmUpeBr7M+/LcwpSVCF5zu0gWmqhwTXSTm1vFesVysLODh188xv6zTs6J9FAqvm/ZZF+IRGBS84WkXAEhfx/Be5a1921f6u0i8fPqWwZG8oY4ANSEKkcFlLKUYPFT4z+/Yd9xDZ8sr5jDrLNdITIS7KDqUOXymOuQfR69q2DN9gO0cx6TJRbJAVlKQVPx/zao72Nrn4I9X6Q3Xgt17PQ1pV/JndKPjDCKHjW9Vqg2kNWt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(376002)(136003)(39830400003)(451199015)(26005)(31686004)(36756003)(53546011)(52116002)(316002)(54906003)(2906002)(6512007)(86362001)(45080400002)(478600001)(41300700001)(31696002)(6506007)(110136005)(8676002)(66476007)(66946007)(2616005)(6486002)(66556008)(83380400001)(4326008)(186003)(4001150100001)(8936002)(5660300002)(38350700002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVVJUnZocmpWMkxEUXVkWlpCOWVSZXJFOUZFOFJMWXdSM1BxTnFQTjJMdGRo?=
 =?utf-8?B?akY1VnhZZWpQcTBnYVQya0wxcHdUc3RURk1LcjlOa3YrNjlQN0VuQnBYTkx4?=
 =?utf-8?B?T2YySUljNzlWaTljNDVmeXh1bWx0TnZlNnVkM3cwc2p3UHdiTVQ5Z1VlVGVq?=
 =?utf-8?B?WVBXL0N2a3JvaE5mR1V1Nml2bm5vV1BldnEzSE9icS9oYWdzT1k3S0lKdWdt?=
 =?utf-8?B?UlRyK0RQeE9Wd0NueksraVJUblowSFM1RDJOSmF0dk1hVGMzK3lMa2hST04x?=
 =?utf-8?B?Y2taYnlWSjg3ZzYxc1pjTGU4dWlYaWZUenM1OVplK3NXbUlqekZ4NEljZWZp?=
 =?utf-8?B?Rk1yTmtBRHMrVGpFcVNOcHNsamowWnc2em1jV2NBTFZIZXNQaVBPQ1d1YVNx?=
 =?utf-8?B?d3dCdTdhenF3ZlBCUGpWSU1rc0JUZDU2M0ptR25TRHNYWDBoUnQ5YmZVeXRM?=
 =?utf-8?B?L0JkYi8weEo2WnIvQzZYY3QzeWg1Y1RIQTlrSkFSU1d6dExuSFo3amhDbTRV?=
 =?utf-8?B?ZHNha3BMck91NUVBWUVIWUtSTW80RWV4QnRTaFZRdGZFWHlYdUdkNWN0WjVC?=
 =?utf-8?B?U2tQcUppd00xQWJlcEdoMm9nR0JibDdJVWdiQkU4c0t3ZUhBaVp0dzFxMjVh?=
 =?utf-8?B?Zzh6MGVIdEVKVkhHcVFaV3Jlb0MzeGs4MkV5TFVoR0k3bUFlbWpiOW5CS0Fw?=
 =?utf-8?B?M2VLL3QzMkxSZS92U0N3MzR1d3hzZ1U4Z0N4SkZUNkF3cGpseW0rcUJGYTI4?=
 =?utf-8?B?UGRMR1FOR0trZndSVnNMbEdseFVyc3FKa1BDQVJ3bzd3WHUwTjlxR0NzZHRG?=
 =?utf-8?B?VTJnTFI2QWZJMjZhR1YwSExBbDlvTENTaWM5V3d5OStuL1dPM1czTjdQbkVI?=
 =?utf-8?B?UDNyZjFsMllQUks5ckg4OWp2ZXBoTWs2Vk5NZ3B6bFphOWg5UGpPZWQrd29l?=
 =?utf-8?B?N3ZUajE0UVVpaGlxMjUwVDRmM0V3TUhTMHZ1em0yOEc4TE01bGZuMyt0VjV1?=
 =?utf-8?B?MGNDaWsvZThZVUpRb2x1ZDlTNmt5cnhxbnowWk9IVXdDUldSUmVXTi9GS2dO?=
 =?utf-8?B?bDlyalM4bFlQbXAxM0FYMnBIRlZyQkFxcURDWi9pYmlPVU1pVnBsMGNhZG9S?=
 =?utf-8?B?SThyUVpQUGFiTGl3bk95VW1vVTJvckQrdUlXYzhKaklIVVo3UGIwaElRU0hK?=
 =?utf-8?B?Vk9VSkt6QlFzWSsvOHpkczU2R0I3VW8xaHI4ZmNQVFNkc01FbDhVd2NCajky?=
 =?utf-8?B?a1U4SVFOUHI5dG8xSHpTSW03U2l5YXRZVTZUWmJZTTlhMW56Ujl6YXVZcEgr?=
 =?utf-8?B?RzV5SEhveXpnQ0FrbGh2cTBGaUdzL0NDdXFRaW1hQkk4dTVsOGF1UThiYmta?=
 =?utf-8?B?T3RFdFNDeHJHa05pWFpDbU1VNERhNE9MRHhTRlJkaGE5MDJ3YmF4Yi9CMUpP?=
 =?utf-8?B?MUg2cllVMlJOUlZMOHJvUUxmc2htblhvaHo5L01zUDNYanNZRGFPaGNyNGdl?=
 =?utf-8?B?R0J6RGt1V3dkN3VnMXJ3TE5NYmtxTnRKWlYvLzI4Y0lzYmxGSDFlaEZHSFJI?=
 =?utf-8?B?Njl4alZ1UUZtUnRGZkFEZXVyakpjSEhGVTN4b2ZxSHZCbStocWFxWTRhUGlV?=
 =?utf-8?B?SFVtZ2ZERjZ2cVhLcm56aWxPN3FYZEpqUHBjRWxCZjZheHZEblViYWFYLzA2?=
 =?utf-8?B?QW9jMWpNVGpVbk9US0VjMlNNaWwwbVQxRDVNQVN4U0JtQmkvWDBWSmkzQ28v?=
 =?utf-8?B?QlI2Q25MVlEyRzVCR0hRK2ZxYVVPN21MbDlUTVMyMVV2NzlQN3FuSTZWNmo4?=
 =?utf-8?B?WDBLcG5SSjgvd2VHSzUxcmFtT2krYVVwYjJaQzBXNUZzKzJTQ1ozY1dFQWRS?=
 =?utf-8?B?YWE3T2VFL054aHdyZ0xVT0VRVGh1Q0REWVZFcDkxdmQ1WkJxWEJXR3JOVXFO?=
 =?utf-8?B?Z0xwTjZWK2VESEYyUEFQYlFJdlpQc2ZSTEV3UjVNbDJHVnpMRlNISEdnVysy?=
 =?utf-8?B?ZEd1ekEvaTMvalFHNFE5RkFoS3dpVkt1R0MrRjhJSWdLQUZTRHFGVlh4bDVh?=
 =?utf-8?B?emtiVSsxdHJoWTZiWkRkeFF6K0lqdm8reWoreUd5RXpRdW9BWTVqb1E4NThN?=
 =?utf-8?Q?bfRw=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905bade9-3558-4c25-7213-08dac7ed9e31
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 16:14:20.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV87pAxMP6mCg/lYbq+jkO9qPhAsu32LFRGOKUNa5MkVVUTIvYlYm++1YFEgQoat
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6248
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/2022 10:44 AM, Stefan Metzmacher wrote:
> Am 16.11.22 um 16:41 schrieb Tom Talpey:
>> On 11/16/2022 3:36 AM, Stefan Metzmacher wrote:
>>> Am 16.11.22 um 06:19 schrieb Namjae Jeon:
>>>> 2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
>>>>> Hi David,
>>>>>
>>>>> see below...
>>>>>
>>>>>> When the cifs client is talking to the ksmbd server by RDMA and 
>>>>>> the ksmbd
>>>>>> server has "smb3 encryption = yes" in its config file, the normal PDU
>>>>>> stream is encrypted, but the directly-delivered data isn't in the 
>>>>>> stream
>>>>>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets 
>>>>>> (at
>>>>>> least with IWarp).
>>>>>>
>>>>>> Currently, the direct delivery fails with:
>>>>>>
>>>>>>      buf can not contain only a part of read data
>>>>>>      WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>>>>>> handle_read_data+0x393/0x405
>>>>>>      ...
>>>>>>      RIP: 0010:handle_read_data+0x393/0x405
>>>>>>      ...
>>>>>>       smb3_handle_read_data+0x30/0x37
>>>>>>       receive_encrypted_standard+0x141/0x224
>>>>>>       cifs_demultiplex_thread+0x21a/0x63b
>>>>>>       kthread+0xe7/0xef
>>>>>>       ret_from_fork+0x22/0x30
>>>>>>
>>>>>> The problem apparently stemming from the fact that it's trying to 
>>>>>> manage
>>>>>> the decryption, but the data isn't in the smallbuf, the bigbuf or the
>>>>>> page
>>>>>> array).
>>>>>>
>>>>>> This can be fixed simply by inserting an extra case into
>>>>>> handle_read_data()
>>>>>> that checks to see if use_rdma_mr is true, and if it is, just setting
>>>>>> rdata->got_bytes to the length of data delivered and allowing normal
>>>>>> continuation.
>>>>>>
>>>>>> This can be seen in an IWarp packet trace.  With the upstream 
>>>>>> code, it
>>>>>> does
>>>>>> a DDP/RDMA packet, which produces the warning above and then retries,
>>>>>> retrieving the data inline, spread across several SMBDirect 
>>>>>> messages that
>>>>>> get glued together into a single PDU.  With the patch applied, 
>>>>>> only the
>>>>>> DDP/RDMA packet is seen.
>>>>>>
>>>>>> Note that this doesn't happen if the server isn't told to encrypt 
>>>>>> stuff
>>>>>> and
>>>>>> it does also happen with softRoCE.
>>>>>>
>>>>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>>>>> cc: Steve French <smfrench@gmail.com>
>>>>>> cc: Tom Talpey <tom@talpey.com>
>>>>>> cc: Long Li <longli@microsoft.com>
>>>>>> cc: Namjae Jeon <linkinjeon@kernel.org>
>>>>>> cc: Stefan Metzmacher <metze@samba.org>
>>>>>> cc: linux-cifs@vger.kernel.org
>>>>>> ---
>>>>>>
>>>>>>    fs/cifs/smb2ops.c |    3 +++
>>>>>>    1 file changed, 3 insertions(+)
>>>>>>
>>>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>>>> index 880cd494afea..8d459f60f27b 100644
>>>>>> --- a/fs/cifs/smb2ops.c
>>>>>> +++ b/fs/cifs/smb2ops.c
>>>>>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info 
>>>>>> *server,
>>>>>> struct mid_q_entry *mid,
>>>>>>            iov.iov_base = buf + data_offset;
>>>>>>            iov.iov_len = data_len;
>>>>>>            iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>>>>>> +    } else if (use_rdma_mr) {
>>>>>> +        /* The data was delivered directly by RDMA. */
>>>>>> +        rdata->got_bytes = data_len;
>>>>>>        } else {
>>>>>>            /* read response payload cannot be in both buf and 
>>>>>> pages */
>>>>>>            WARN_ONCE(1, "buf can not contain only a part of read 
>>>>>> data");
>>>>>
>>>>> I'm not sure I understand why this would fix anything when 
>>>>> encryption is
>>>>> enabled.
>>>>>
>>>>> Is the payload still be offloaded as plaintext? Otherwise we 
>>>>> wouldn't have
>>>>> use_rdma_mr...
>>>>> So this rather looks like a fix for the non encrypted case.
>>>> ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
>>>> only smb2 response is encrypted for this. And as you pointed out, We
>>>> need to implement SMB2 RDMA Transform to encrypt it.
>>>
>>> I haven't tested against a windows server yet, but my hope would be that
>>> and encrypted request with SMB2_CHANNEL_RDMA_V1* receive 
>>> NT_STATUS_ACCESS_DENIED or something similar...
>>>
>>> Is someone able to check that against Windows?
>>
>> It's not going to fail, because it's perfectly legal per the protocol.
>> And the new SMB3 extension to perform pre-encryption of RDMA payload
>> is not a solution, because it's only supported by one server (Windows
>> 22H2) and in any case it does not alter the transfer model. The client
>> will see the same two-part response (headers in the inline portion,
>> data via RDMA), so this same code will be entered when processing it.
>>
>> I think David's change is on the right track because it actually
>> processes the response. I'm a little bit skeptical of the got_bytes
>> override however, still digging into that.
>>
>>> But the core of it is a client security problem, shown in David's 
>>> capture in frame 100.
>>
>> Sorry, what's the security problem? Both the client and server appear
>> to be implementing the protocol itself correctly.
> 
> Data goes in plaintext over the wire and a share that requires encryption!

That's a server issue, not the client. The server is the one that
returned the plaintext data via RDMA. Changing the client to avoid
such a request doesn't close that hole. It's an important policy
question, of course.

I still think the client needs to handle the is_rdma_mr case, along
the lines of David's fix. The code looks like a vestige of TCP-only
response processing.

Tom.
