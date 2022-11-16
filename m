Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7145562C94B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 20:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbiKPTyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 14:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiKPTx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:53:59 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3554D5D0;
        Wed, 16 Nov 2022 11:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=TjCEQduvV3qlgfdvGJChJMqfGyuHBAcSN2ga7Qqs8sI=; b=Hh1RE6bmB14PIhSO2YSajYYh8n
        d42QED86QFeRSLVLNhx+RFcRv/ANDM5ZnB5yZ7IjuO8Mga0DJISWnToGCVN8lMt1BbQTyPd7qN5fq
        9O2D7wF3QbORexxGwyts7dfOrpVHRpCx6uAyUZP3Ckty4HYElY+5v6ZG+PVMyfI9vSqyzC5oKmiqL
        knSB3xGQlmDZSGPglErT9vUoV7P0Ez/WvcpKyolgFx0560h5yBm8EAxzh2BikPNoxJkoaVUDG6/0c
        bb38GbRXuXE2TyNHxiGJovrwLRLiEV7ILorlDHxg65s9NNcgFIJdJo1Hpgs0es4hN4QX8z0gSi6Ti
        wYIzKVuhH7TnMPlfg62RxUeQz30RVkxLT+XywxqvTxI8JF+BklGvVizEBQ9PyDbFjAjlBzqAF1sV1
        Q7DxKHmoPEzPn1i9ITF2VvbEFlhBRL3xBuBB5EqVCEZmkNQioBsliosZZBBEVghT+zuUN+NEi6JSn
        zejElgI+rh/3p1Py7ksYgH5a;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1ovOTr-008wem-75; Wed, 16 Nov 2022 19:53:55 +0000
Message-ID: <3fd0217b-dfcf-05b7-dd24-4ad69f25a813@samba.org>
Date:   Wed, 16 Nov 2022 20:53:54 +0100
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
 <47cd5c51-4b6c-c462-179e-7276c851253b@samba.org>
 <423b4372-2149-6576-ed9e-795ccdece05e@talpey.com>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <423b4372-2149-6576-ed9e-795ccdece05e@talpey.com>
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

Am 16.11.22 um 17:14 schrieb Tom Talpey:
> On 11/16/2022 10:44 AM, Stefan Metzmacher wrote:
>> Am 16.11.22 um 16:41 schrieb Tom Talpey:
>>> On 11/16/2022 3:36 AM, Stefan Metzmacher wrote:
>>>> Am 16.11.22 um 06:19 schrieb Namjae Jeon:
>>>>> 2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
>>>>>> Hi David,
>>>>>>
>>>>>> see below...
>>>>>>
>>>>>>> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
>>>>>>> server has "smb3 encryption = yes" in its config file, the normal PDU
>>>>>>> stream is encrypted, but the directly-delivered data isn't in the stream
>>>>>>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
>>>>>>> least with IWarp).
>>>>>>>
>>>>>>> Currently, the direct delivery fails with:
>>>>>>>
>>>>>>>      buf can not contain only a part of read data
>>>>>>>      WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>>>>>>> handle_read_data+0x393/0x405
>>>>>>>      ...
>>>>>>>      RIP: 0010:handle_read_data+0x393/0x405
>>>>>>>      ...
>>>>>>>       smb3_handle_read_data+0x30/0x37
>>>>>>>       receive_encrypted_standard+0x141/0x224
>>>>>>>       cifs_demultiplex_thread+0x21a/0x63b
>>>>>>>       kthread+0xe7/0xef
>>>>>>>       ret_from_fork+0x22/0x30
>>>>>>>
>>>>>>> The problem apparently stemming from the fact that it's trying to manage
>>>>>>> the decryption, but the data isn't in the smallbuf, the bigbuf or the
>>>>>>> page
>>>>>>> array).
>>>>>>>
>>>>>>> This can be fixed simply by inserting an extra case into
>>>>>>> handle_read_data()
>>>>>>> that checks to see if use_rdma_mr is true, and if it is, just setting
>>>>>>> rdata->got_bytes to the length of data delivered and allowing normal
>>>>>>> continuation.
>>>>>>>
>>>>>>> This can be seen in an IWarp packet trace.  With the upstream code, it
>>>>>>> does
>>>>>>> a DDP/RDMA packet, which produces the warning above and then retries,
>>>>>>> retrieving the data inline, spread across several SMBDirect messages that
>>>>>>> get glued together into a single PDU.  With the patch applied, only the
>>>>>>> DDP/RDMA packet is seen.
>>>>>>>
>>>>>>> Note that this doesn't happen if the server isn't told to encrypt stuff
>>>>>>> and
>>>>>>> it does also happen with softRoCE.
>>>>>>>
>>>>>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>>>>>> cc: Steve French <smfrench@gmail.com>
>>>>>>> cc: Tom Talpey <tom@talpey.com>
>>>>>>> cc: Long Li <longli@microsoft.com>
>>>>>>> cc: Namjae Jeon <linkinjeon@kernel.org>
>>>>>>> cc: Stefan Metzmacher <metze@samba.org>
>>>>>>> cc: linux-cifs@vger.kernel.org
>>>>>>> ---
>>>>>>>
>>>>>>>    fs/cifs/smb2ops.c |    3 +++
>>>>>>>    1 file changed, 3 insertions(+)
>>>>>>>
>>>>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>>>>> index 880cd494afea..8d459f60f27b 100644
>>>>>>> --- a/fs/cifs/smb2ops.c
>>>>>>> +++ b/fs/cifs/smb2ops.c
>>>>>>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server,
>>>>>>> struct mid_q_entry *mid,
>>>>>>>            iov.iov_base = buf + data_offset;
>>>>>>>            iov.iov_len = data_len;
>>>>>>>            iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>>>>>>> +    } else if (use_rdma_mr) {
>>>>>>> +        /* The data was delivered directly by RDMA. */
>>>>>>> +        rdata->got_bytes = data_len;
>>>>>>>        } else {
>>>>>>>            /* read response payload cannot be in both buf and pages */
>>>>>>>            WARN_ONCE(1, "buf can not contain only a part of read data");
>>>>>>
>>>>>> I'm not sure I understand why this would fix anything when encryption is
>>>>>> enabled.
>>>>>>
>>>>>> Is the payload still be offloaded as plaintext? Otherwise we wouldn't have
>>>>>> use_rdma_mr...
>>>>>> So this rather looks like a fix for the non encrypted case.
>>>>> ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
>>>>> only smb2 response is encrypted for this. And as you pointed out, We
>>>>> need to implement SMB2 RDMA Transform to encrypt it.
>>>>
>>>> I haven't tested against a windows server yet, but my hope would be that
>>>> and encrypted request with SMB2_CHANNEL_RDMA_V1* receive NT_STATUS_ACCESS_DENIED or something similar...
>>>>
>>>> Is someone able to check that against Windows?
>>>
>>> It's not going to fail, because it's perfectly legal per the protocol.
>>> And the new SMB3 extension to perform pre-encryption of RDMA payload
>>> is not a solution, because it's only supported by one server (Windows
>>> 22H2) and in any case it does not alter the transfer model. The client
>>> will see the same two-part response (headers in the inline portion,
>>> data via RDMA), so this same code will be entered when processing it.
>>>
>>> I think David's change is on the right track because it actually
>>> processes the response. I'm a little bit skeptical of the got_bytes
>>> override however, still digging into that.
>>>
>>>> But the core of it is a client security problem, shown in David's capture in frame 100.
>>>
>>> Sorry, what's the security problem? Both the client and server appear
>>> to be implementing the protocol itself correctly.
>>
>> Data goes in plaintext over the wire and a share that requires encryption!
> 
> That's a server issue, not the client. The server is the one that
> returned the plaintext data via RDMA. Changing the client to avoid
> such a request doesn't close that hole. It's an important policy
> question, of course.

No, it's the client how decides to use SMB2_CHANNEL_RDMA_V1* or
SMB2_CHANNEL_NONE. And for any read or write over an signed or encrypted connection
it must use SMB2_CHANNEL_NONE! Otherwise the clients memory can be written or read
by any untrusted machine in the middle.

MS-SMB2 says this:

3.2.4.6 Application Requests Reading from a File or Named Pipe
...
If the Connection is established in RDMA mode and the size of any single operation exceeds an
implementation-specific threshold <138>, and if Open.TreeConnect.Session.SigningRequired and
Open.TreeConnect.Session.EncryptData are both FALSE, then the interface in [MS-SMBD] section
3.1.4.3 Register Buffer MUST be used to register the buffer provided by the calling application on the
Connection with write permissions, which will receive the data to be read. The returned list of
SMB_DIRECT_BUFFER_DESCRIPTOR_V1 structures MUST be stored in
Request.BufferDescriptorList. The following fields of the request MUST be initialized as follows:
...

3.2.4.7 Application Requests Writing to a File or Named Pipe
...
If the connection is not established in RDMA mode or if the size of the operation is less than or equal
to an implementation-specific threshold <141>or if either
Open.TreeConnect.Session.SigningRequired or Open.TreeConnect.Session.EncryptData is
TRUE, the following fields of the request MUST be initialized as follows:
- If Connection.Dialect belongs to the SMB 3.x dialect family,
   - The Channel field MUST be set to SMB2_CHANNEL_NONE.
   - The WriteChannelInfoOffset field MUST be set to 0.
   - The WriteChannelInfoLength field MUST be set to 0.

For sure it would be great if servers would also reject SMB2_CHANNEL_RDMA_V1*
on signed/encrypted connections with INVALID_PARAMETER or ACCESS_DENIED,
buth the problem we currently see is a client security problem.

> I still think the client needs to handle the is_rdma_mr case, along
> the lines of David's fix. The code looks like a vestige of TCP-only
> response processing.

I'm not saying David's change is wrong, but I think it has nothing todo
with encrypted or signed traffic...

metze

