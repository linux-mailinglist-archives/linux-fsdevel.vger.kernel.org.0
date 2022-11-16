Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25D062C2DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 16:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiKPPoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 10:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiKPPoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:44:05 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D2AF594;
        Wed, 16 Nov 2022 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=bdEcS+vdcSbXsBSrCdw98Rsu3DOmt94MjDFyBClSkfg=; b=fPyrelws8wR7l9Kdu4SRzn7mBH
        Hk5z+kxs0Wczs84HkO3+Mu4wqMj8aTx6JqdOd6WBYXqqZgJZYuQfxBvGAR1os7urwzlBGauV0pUsU
        BNiWNmJ77Csr+7CxvQ3nYwYzzpJYjRCPBX+1fOqUezSnk9iFWzljwCF9vYkxDzrXXihPwokYRL+u1
        UNST4C4npDe9Aq3FBK8ZHhCZPlml7n4KP6+Y7U40MKyopyCNaGDPGl0icEe/aYY/RLmfrxhq/7KOL
        yt/kqttt3+LYzyuNztxT7OQ3dHhKLs5Qwd4BLDW53ARF/qQ9yZWO6hnIM6ovS6VqDuqQBI2F5jOOZ
        l2HgmWhQj9uqXZAH+IjsU/rMto2zGB3TwKXJOX8uK0Oig0wuN2zBZSIEJ/WbcopIoZhh9HSwgghoF
        4zwJGnoGQMTSFqjfjutpKaUKtNCg5Xp2nhY82VMC+TkK0fO2LPzSH/YrrtgKlImMxasfVeCyI+exh
        h6KiHnCqZQKfUCrKspcqmRXZ;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1ovKa0-008uOF-DO; Wed, 16 Nov 2022 15:44:00 +0000
Message-ID: <47cd5c51-4b6c-c462-179e-7276c851253b@samba.org>
Date:   Wed, 16 Nov 2022 16:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US, de-DE
To:     Tom Talpey <tom@talpey.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, smfrench@gmail.com,
        Long Li <longli@microsoft.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
 <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
 <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
 <c4f8959b-15c5-b32f-18fc-8befb4f75da2@samba.org>
 <4b94b915-e3cb-01a7-92be-70d291f67f4a@talpey.com>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <4b94b915-e3cb-01a7-92be-70d291f67f4a@talpey.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 16.11.22 um 16:41 schrieb Tom Talpey:
> On 11/16/2022 3:36 AM, Stefan Metzmacher wrote:
>> Am 16.11.22 um 06:19 schrieb Namjae Jeon:
>>> 2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
>>>> Hi David,
>>>>
>>>> see below...
>>>>
>>>>> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
>>>>> server has "smb3 encryption = yes" in its config file, the normal PDU
>>>>> stream is encrypted, but the directly-delivered data isn't in the stream
>>>>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
>>>>> least with IWarp).
>>>>>
>>>>> Currently, the direct delivery fails with:
>>>>>
>>>>>      buf can not contain only a part of read data
>>>>>      WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>>>>> handle_read_data+0x393/0x405
>>>>>      ...
>>>>>      RIP: 0010:handle_read_data+0x393/0x405
>>>>>      ...
>>>>>       smb3_handle_read_data+0x30/0x37
>>>>>       receive_encrypted_standard+0x141/0x224
>>>>>       cifs_demultiplex_thread+0x21a/0x63b
>>>>>       kthread+0xe7/0xef
>>>>>       ret_from_fork+0x22/0x30
>>>>>
>>>>> The problem apparently stemming from the fact that it's trying to manage
>>>>> the decryption, but the data isn't in the smallbuf, the bigbuf or the
>>>>> page
>>>>> array).
>>>>>
>>>>> This can be fixed simply by inserting an extra case into
>>>>> handle_read_data()
>>>>> that checks to see if use_rdma_mr is true, and if it is, just setting
>>>>> rdata->got_bytes to the length of data delivered and allowing normal
>>>>> continuation.
>>>>>
>>>>> This can be seen in an IWarp packet trace.  With the upstream code, it
>>>>> does
>>>>> a DDP/RDMA packet, which produces the warning above and then retries,
>>>>> retrieving the data inline, spread across several SMBDirect messages that
>>>>> get glued together into a single PDU.  With the patch applied, only the
>>>>> DDP/RDMA packet is seen.
>>>>>
>>>>> Note that this doesn't happen if the server isn't told to encrypt stuff
>>>>> and
>>>>> it does also happen with softRoCE.
>>>>>
>>>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>>>> cc: Steve French <smfrench@gmail.com>
>>>>> cc: Tom Talpey <tom@talpey.com>
>>>>> cc: Long Li <longli@microsoft.com>
>>>>> cc: Namjae Jeon <linkinjeon@kernel.org>
>>>>> cc: Stefan Metzmacher <metze@samba.org>
>>>>> cc: linux-cifs@vger.kernel.org
>>>>> ---
>>>>>
>>>>>    fs/cifs/smb2ops.c |    3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>>> index 880cd494afea..8d459f60f27b 100644
>>>>> --- a/fs/cifs/smb2ops.c
>>>>> +++ b/fs/cifs/smb2ops.c
>>>>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server,
>>>>> struct mid_q_entry *mid,
>>>>>            iov.iov_base = buf + data_offset;
>>>>>            iov.iov_len = data_len;
>>>>>            iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>>>>> +    } else if (use_rdma_mr) {
>>>>> +        /* The data was delivered directly by RDMA. */
>>>>> +        rdata->got_bytes = data_len;
>>>>>        } else {
>>>>>            /* read response payload cannot be in both buf and pages */
>>>>>            WARN_ONCE(1, "buf can not contain only a part of read data");
>>>>
>>>> I'm not sure I understand why this would fix anything when encryption is
>>>> enabled.
>>>>
>>>> Is the payload still be offloaded as plaintext? Otherwise we wouldn't have
>>>> use_rdma_mr...
>>>> So this rather looks like a fix for the non encrypted case.
>>> ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
>>> only smb2 response is encrypted for this. And as you pointed out, We
>>> need to implement SMB2 RDMA Transform to encrypt it.
>>
>> I haven't tested against a windows server yet, but my hope would be that
>> and encrypted request with SMB2_CHANNEL_RDMA_V1* receive NT_STATUS_ACCESS_DENIED or something similar...
>>
>> Is someone able to check that against Windows?
> 
> It's not going to fail, because it's perfectly legal per the protocol.
> And the new SMB3 extension to perform pre-encryption of RDMA payload
> is not a solution, because it's only supported by one server (Windows
> 22H2) and in any case it does not alter the transfer model. The client
> will see the same two-part response (headers in the inline portion,
> data via RDMA), so this same code will be entered when processing it.
> 
> I think David's change is on the right track because it actually
> processes the response. I'm a little bit skeptical of the got_bytes
> override however, still digging into that.
> 
>> But the core of it is a client security problem, shown in David's capture in frame 100.
> 
> Sorry, what's the security problem? Both the client and server appear
> to be implementing the protocol itself correctly.

Data goes in plaintext over the wire and a share that requires encryption!

metze

