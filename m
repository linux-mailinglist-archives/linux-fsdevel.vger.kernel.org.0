Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F062C2CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiKPPln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbiKPPlf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:41:35 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8DD6387;
        Wed, 16 Nov 2022 07:41:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/U+HB6YLbthAepLu3ciW9mbKE6k+rq76N3YRwKgs1UCTvDMMR5fjgeLf2QkT9CC/1/0ZkR7dPmoVdaLxFN1Urw8BwtKowe5129O0Sfg2K4zDMgee4pl9JRa2nsLENP9sgPBFTWtrZdvK4ilfqYtFdY1c8JHtFHpzy1tT43PewxW6BDPD+DDMbdHBGMbAJpRJjtoP62vkRmAr7a1EQxJdtOblm8S+zSJSwdr/tuBCWHOqoSeNPTuY+CQrOp4Ir+UkBtvi7mCTznIcgakTW3jAMYU3g9ItyDmEcstzzHsGH0MCh79bflwxhpGNVLPbGGgbs2WNYI4loYg26eUMqUoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elyUZ8AImWOAsx31FSoLE1+r9dsBEmXnV+JON08a/rQ=;
 b=TaUi/IKNF03JRWqGgF4IBNj3m5TKPnqwIO9m1+vkz3WN5LRVOk9iNBQk4CvcAZr0RKiwMi1+lmubwf5E0GD+jHnR2zJFCY3EsPoCsjUm9Z8ct8s0T+mlxazh73wCNxc0ufOs+cmIKCyZqzGVB4M1g0hPdcyuFoyA0556dpJpx+ixnULgURGJvmzeipH5LRdEYJvGTxMYDmgPEA0wxMB853yj8+16JhQ03RAGtqWj4BCnvJ8o38izAiHe6WXbwaEzrXyykJzdLsfBS0iY0Yvbd3CSUCciyIowTyOTW5IS4OEsydwhFBuQIq1yGkbZqkYIK5eov7dYg3nc0t0UX3v0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 MN2PR01MB6111.prod.exchangelabs.com (2603:10b6:208:16d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.13; Wed, 16 Nov 2022 15:41:31 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a621:8f2f:c5a6:9d33]) by SN6PR01MB4445.prod.exchangelabs.com
 ([fe80::a621:8f2f:c5a6:9d33%7]) with mapi id 15.20.5813.019; Wed, 16 Nov 2022
 15:41:31 +0000
Message-ID: <4b94b915-e3cb-01a7-92be-70d291f67f4a@talpey.com>
Date:   Wed, 16 Nov 2022 10:41:30 -0500
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
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <c4f8959b-15c5-b32f-18fc-8befb4f75da2@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|MN2PR01MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9ed6e4-c2ba-4802-5dff-08dac7e9089f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIPbDBc0wmlWWoJqIBAk08YdYl3CwbWcqehDixY1Y7nHME64pIaV5+6mIPSDo/0kU9C+um9NyQgFOcLGqT0J3vEI0y5psS29kswwXC+QGfKgF1eOo0lXZa5N2XpBjIe+EJOOfUqmQMtf/xwtTttrGQ7Ideid0FhKxU3Zo3qTjFT0jezXBY7ATOI+ID5d6JwlfA7b2t+U5x0Ha96nFcIiqbvoPGrWu6kd4Y/F9RhOzZSNWxaszlJuVwPj9jGwqTf/cDAjZEjqqLbNeuv9gipnszNklZAVvV9R2UWl30/w89I78hNU2OPos8dkKVNTzPCxqTw3spLn3Eewr+X1tGLaOSoWONURVlSODKNdyLZm7XM/2874xvahg7gdGvVVNaKGmKzqOQ2HJT99/G2hOJIevtgJAv0+Bmqusrv0FoONqiGsEixU/d1ebdXTXcpyU97VBG9ulP2dViDALg+hdjUkzy2tYShLjIRQxBntytXjGQ6Mw7y5taM+m72wr31a65psTkk91hN7eFMyj1XoJd3Wl2phabCMykf0xfPIKnPJmGWyB6b0m0P6n/onIUmZQOjEQDMEfr3ZaXQL7iMc+2hUv+uxKZguaC2pX8c2bFx0145K1bjwX9wjDS34LcOmm3j39jDsux6LuKz2lqTDQa0ox9joRCu7od6jqQsPbGX/I9Lkg+13iKUm+kIr4duJJLe/5xzgkDHot8PGVdt6F8mtXTs5APCB2MqZbR1Fh4u95bUGRal59yvMacIH8w8aSjECHizyeK4VrQNhETXbof6mW/y/vGYF3U6YfYcGLJMq9G8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39830400003)(451199015)(36756003)(83380400001)(2616005)(31696002)(52116002)(53546011)(86362001)(26005)(6512007)(6506007)(186003)(38350700002)(38100700002)(8936002)(4001150100001)(4326008)(66476007)(66556008)(66946007)(5660300002)(8676002)(41300700001)(2906002)(6486002)(478600001)(316002)(45080400002)(110136005)(54906003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFNJbW5va0kwQXVIS1FiaUh3enRaZktTbXJFZlNxMCszQ01PTkd2VmU1SmNn?=
 =?utf-8?B?U3BLaHN0V3c4Vld6VnZJTW15SmhYL3dzZDVmM3RuNkFuNGsxU0dSOHdCTXRh?=
 =?utf-8?B?RHIrVGc2ekdadVEyU1NBSDQxVkJoVFgzRXk3QWhzRW42S2tPRHFhSnR2Smd4?=
 =?utf-8?B?dWxsWmJ0TWVFWjFOSCtGY0RoWlBkK2krNnplakRJZ2FSVDcrVllTNUUxNmNw?=
 =?utf-8?B?V0x1bXR4UTJSOUVhSFBFN1ROUTJTYllDWi8rSDA0QThHbG9EYVJERm9GZXlI?=
 =?utf-8?B?V2hzMlFsNzNoVitBM3JKSjFBM3VvVTI2RGZ2MUZaeEpONTNqZTlSOHJydktC?=
 =?utf-8?B?NVJlSFBRdTVYOEVDV2lRRGczcE56SEF0UG0rWm5wZTVpK0pGTkh1NGVORzly?=
 =?utf-8?B?Q3dJVW5TZk1KN1g1eFpmVHJwN24xckh1QSt4d1RvSWNkdWZ4SDVNN05odTdk?=
 =?utf-8?B?Tlc1NEFCK0RkMTlXcVR5dENPYmJWTVJJTmIxb2tNbXVmWDFGRmtFMldScUM4?=
 =?utf-8?B?YWVRYm9oMmJTY0c2Y0FvRmJ2bTl2VC81dDJXWkVCVzg0a3dCTFZoUTVaS285?=
 =?utf-8?B?alpzQkZka3ZHQjk1Tm40YnJOeUJpQXBnZHpNSlVPZFByWlJpWGlmQmF3NVdR?=
 =?utf-8?B?eFRJbWNhT2dqbzZQazkvRWxpTmtMQUIxZ3pOSlBPQzhuVVJpYTJQS1dTL1JY?=
 =?utf-8?B?UTRLZ2hkbVZGWnV0ZUtVb1hENVJ6U1NNR2xHNitTNEZTcGFNaDE4RmNXRXp4?=
 =?utf-8?B?SE1yT3VFTUE1OEpPQVNOamlpZUhKS2Mya2I5ZERFSUhhWUdLZ0ZkNW1SLzlO?=
 =?utf-8?B?a1lKcmMrTCthdEFiWFhSKzB6Rm04M1dsOFIxNmVxRlQ4VTBNb25YWDkySCsw?=
 =?utf-8?B?LytKSWNWaktSVFQxenJ4TTQrYmxVOWU5MnBTODhSOUlJQkdWemhlVDN1b1d6?=
 =?utf-8?B?VTFRZWg0YjhPOEdJcHZpM1ZTY3RHMzIyMHRNRHYxMG9yTU5iaUNiRXpLRlhl?=
 =?utf-8?B?UFJWdm1oaDZpWVd5VU4wSU5abU5PQk1lc0M0dkIra1ZmcW9mdTR6bDREb1BX?=
 =?utf-8?B?c0JEUzdOUlJxbmhLNTZyUGdBcDRUNFhzMGNaclFGaWppMHlLTkZjVVZjcEI4?=
 =?utf-8?B?VGRoMVRwTXpkbjkrUzFNdzBUNlFmM21kYm11c0tneUJnMFlXUE56a2xlUzNF?=
 =?utf-8?B?VHFoSi8zc3JtTE43M3dRZktsRDZMeG5hWEVIQlpsekkyckhraHZuSWxva1dV?=
 =?utf-8?B?dlU0TmJyZFBzbmU3Z3lMdEVZaE85UWdtOURBeGt2QmtTejJac2FYeFAyUW9u?=
 =?utf-8?B?TzRSMEQzdlFBVHU5VFlsdlc5QjdmQ2c4Z2F5dlFkdVdXc2g1WTl2T1ZMckdQ?=
 =?utf-8?B?SEZ6dHVFenhtajI5NTJURVY4T3NHQ0RXM2prOFVYYXNEb1JZV0VaRmczM2M1?=
 =?utf-8?B?VW44ZWlHQ3ZxemszOXNJS1FRNFNTSVJvdnZaeFBBTVRwYThMOHBVY0tFajN1?=
 =?utf-8?B?bW52cStQWWNqeXBzbDduRVVlWExtOVcrSGljWi9QYytqelB2d1BmNjI4UFY5?=
 =?utf-8?B?dVhER1pPcWV0elJGMmhoRmxsaExuelpaR05EL0V6L21ueDNyb050a1IwYUJR?=
 =?utf-8?B?VUd5RGZuTFd3TW9vOTJPd0puOXRjMVgxcDZIbnh4VWV1UlY5eFIvUmVYR1Rj?=
 =?utf-8?B?c1R3Z3ZLTUxXV0d1aklaakxyQ0puSzM4YVNuM1BSMFFVbTNzeUpUYU93QUpn?=
 =?utf-8?B?WC9rSjJFYytEaGFGenNDRTQ0WUJZeVJDeGYvMTd0VzZBWUZPRzJRSFcvY1Ni?=
 =?utf-8?B?ZmErSW5yTnQvUTNZcWtjNGxFdFJQV2JFNHQ1ZjZKQkt0Z3BoczVWc1JqMmVF?=
 =?utf-8?B?T3dEcDRWQ0pmUlRwTU1paGczOHFFK0ZyNEJWdkJHODBnU3JkVUpuQnhULzBi?=
 =?utf-8?B?bWljYWxkN2s5NUZMZThxd3pubHNGTEdtVzhLTW9Zc053TU9xYUxQaDAzSzVN?=
 =?utf-8?B?MDdZNHZJK1poeDJ5aU5CckZWYWNrRkRLMGIvTUpoSkV3TUxYUGkrZmFhemRp?=
 =?utf-8?B?eWpZdGEzenlaY1RlOFhTbTZETDFSWGoxd1Vvc2FabU1saE1lQ1hGYnhGZEVr?=
 =?utf-8?Q?hadA=3D?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9ed6e4-c2ba-4802-5dff-08dac7e9089f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 15:41:31.3722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvbhS8mJcYqqb6ErWdkFbA6y1DkODHBrzwts/WLBUrbM/wpNDbSRUmAJUKlWVbxg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR01MB6111
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/2022 3:36 AM, Stefan Metzmacher wrote:
> Am 16.11.22 um 06:19 schrieb Namjae Jeon:
>> 2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
>>> Hi David,
>>>
>>> see below...
>>>
>>>> When the cifs client is talking to the ksmbd server by RDMA and the 
>>>> ksmbd
>>>> server has "smb3 encryption = yes" in its config file, the normal PDU
>>>> stream is encrypted, but the directly-delivered data isn't in the 
>>>> stream
>>>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
>>>> least with IWarp).
>>>>
>>>> Currently, the direct delivery fails with:
>>>>
>>>>      buf can not contain only a part of read data
>>>>      WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>>>> handle_read_data+0x393/0x405
>>>>      ...
>>>>      RIP: 0010:handle_read_data+0x393/0x405
>>>>      ...
>>>>       smb3_handle_read_data+0x30/0x37
>>>>       receive_encrypted_standard+0x141/0x224
>>>>       cifs_demultiplex_thread+0x21a/0x63b
>>>>       kthread+0xe7/0xef
>>>>       ret_from_fork+0x22/0x30
>>>>
>>>> The problem apparently stemming from the fact that it's trying to 
>>>> manage
>>>> the decryption, but the data isn't in the smallbuf, the bigbuf or the
>>>> page
>>>> array).
>>>>
>>>> This can be fixed simply by inserting an extra case into
>>>> handle_read_data()
>>>> that checks to see if use_rdma_mr is true, and if it is, just setting
>>>> rdata->got_bytes to the length of data delivered and allowing normal
>>>> continuation.
>>>>
>>>> This can be seen in an IWarp packet trace.  With the upstream code, it
>>>> does
>>>> a DDP/RDMA packet, which produces the warning above and then retries,
>>>> retrieving the data inline, spread across several SMBDirect messages 
>>>> that
>>>> get glued together into a single PDU.  With the patch applied, only the
>>>> DDP/RDMA packet is seen.
>>>>
>>>> Note that this doesn't happen if the server isn't told to encrypt stuff
>>>> and
>>>> it does also happen with softRoCE.
>>>>
>>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>>> cc: Steve French <smfrench@gmail.com>
>>>> cc: Tom Talpey <tom@talpey.com>
>>>> cc: Long Li <longli@microsoft.com>
>>>> cc: Namjae Jeon <linkinjeon@kernel.org>
>>>> cc: Stefan Metzmacher <metze@samba.org>
>>>> cc: linux-cifs@vger.kernel.org
>>>> ---
>>>>
>>>>    fs/cifs/smb2ops.c |    3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>> index 880cd494afea..8d459f60f27b 100644
>>>> --- a/fs/cifs/smb2ops.c
>>>> +++ b/fs/cifs/smb2ops.c
>>>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server,
>>>> struct mid_q_entry *mid,
>>>>            iov.iov_base = buf + data_offset;
>>>>            iov.iov_len = data_len;
>>>>            iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>>>> +    } else if (use_rdma_mr) {
>>>> +        /* The data was delivered directly by RDMA. */
>>>> +        rdata->got_bytes = data_len;
>>>>        } else {
>>>>            /* read response payload cannot be in both buf and pages */
>>>>            WARN_ONCE(1, "buf can not contain only a part of read 
>>>> data");
>>>
>>> I'm not sure I understand why this would fix anything when encryption is
>>> enabled.
>>>
>>> Is the payload still be offloaded as plaintext? Otherwise we wouldn't 
>>> have
>>> use_rdma_mr...
>>> So this rather looks like a fix for the non encrypted case.
>> ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
>> only smb2 response is encrypted for this. And as you pointed out, We
>> need to implement SMB2 RDMA Transform to encrypt it.
> 
> I haven't tested against a windows server yet, but my hope would be that
> and encrypted request with SMB2_CHANNEL_RDMA_V1* receive 
> NT_STATUS_ACCESS_DENIED or something similar...
> 
> Is someone able to check that against Windows?

It's not going to fail, because it's perfectly legal per the protocol.
And the new SMB3 extension to perform pre-encryption of RDMA payload
is not a solution, because it's only supported by one server (Windows
22H2) and in any case it does not alter the transfer model. The client
will see the same two-part response (headers in the inline portion,
data via RDMA), so this same code will be entered when processing it.

I think David's change is on the right track because it actually
processes the response. I'm a little bit skeptical of the got_bytes
override however, still digging into that.

> But the core of it is a client security problem, shown in David's 
> capture in frame 100.

Sorry, what's the security problem? Both the client and server appear
to be implementing the protocol itself correctly.

Tom.
