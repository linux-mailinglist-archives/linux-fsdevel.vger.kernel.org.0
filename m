Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FEC62B559
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 09:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiKPIgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 03:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiKPIgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:36:09 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867E26303;
        Wed, 16 Nov 2022 00:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=eN4GUBLO4XinXXKx2dGMx5wp8m7TkKKrfti4YkHAEpc=; b=AUo/XEGtuLDPm6fRXEGlKLZpLH
        yANwxDWT9xs0+EH0pgyUqS0ddgQaWzmDv8jRtXokgjtwkVzNvSNuryoAkiV6M/AJt8QPROug8pb16
        nhuVMHurvHbeWFcNH+g9UvaWhBcswBo2f4irAfl/KYaonwo2TD3ffHuRSPijkfBpB6Y1hp+mT7g+g
        K8zbnpjBT7ivQOA82SXVs8yrrQs0r8g1ilocy3K8z7yQijfVgZYS+xVyPV+4U5Vd+OQvaYMlaeArR
        nsRCJVrNnObYgg0qeVlzdUY8HrIQJg43apSjqLeENScCsJLJWbaN0WEB38UOiAT+1WbcU1PwgJh78
        boXLXtdrXaSH68pjotSO4q8xzusoMImR6EGrskDQDI/pmxqAPMBoHocgwM64/2MCGYebkWvr3nzWG
        FhjTB8+3Z3olmxdLQ4WPUqhG6ArKHUDAKHVZt7lVva0OIjLf2AhGykB5pznvVbUHFcaQJU26nzrp6
        H4DGbZvGtg/DdFSXtB7vWK5o;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1ovDts-008qWt-Ux; Wed, 16 Nov 2022 08:36:05 +0000
Message-ID: <c4f8959b-15c5-b32f-18fc-8befb4f75da2@samba.org>
Date:   Wed, 16 Nov 2022 09:36:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US, de-DE
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, smfrench@gmail.com,
        tom@talpey.com, Long Li <longli@microsoft.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
 <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
 <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 16.11.22 um 06:19 schrieb Namjae Jeon:
> 2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
>> Hi David,
>>
>> see below...
>>
>>> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
>>> server has "smb3 encryption = yes" in its config file, the normal PDU
>>> stream is encrypted, but the directly-delivered data isn't in the stream
>>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
>>> least with IWarp).
>>>
>>> Currently, the direct delivery fails with:
>>>
>>>      buf can not contain only a part of read data
>>>      WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>>> handle_read_data+0x393/0x405
>>>      ...
>>>      RIP: 0010:handle_read_data+0x393/0x405
>>>      ...
>>>       smb3_handle_read_data+0x30/0x37
>>>       receive_encrypted_standard+0x141/0x224
>>>       cifs_demultiplex_thread+0x21a/0x63b
>>>       kthread+0xe7/0xef
>>>       ret_from_fork+0x22/0x30
>>>
>>> The problem apparently stemming from the fact that it's trying to manage
>>> the decryption, but the data isn't in the smallbuf, the bigbuf or the
>>> page
>>> array).
>>>
>>> This can be fixed simply by inserting an extra case into
>>> handle_read_data()
>>> that checks to see if use_rdma_mr is true, and if it is, just setting
>>> rdata->got_bytes to the length of data delivered and allowing normal
>>> continuation.
>>>
>>> This can be seen in an IWarp packet trace.  With the upstream code, it
>>> does
>>> a DDP/RDMA packet, which produces the warning above and then retries,
>>> retrieving the data inline, spread across several SMBDirect messages that
>>> get glued together into a single PDU.  With the patch applied, only the
>>> DDP/RDMA packet is seen.
>>>
>>> Note that this doesn't happen if the server isn't told to encrypt stuff
>>> and
>>> it does also happen with softRoCE.
>>>
>>> Signed-off-by: David Howells <dhowells@redhat.com>
>>> cc: Steve French <smfrench@gmail.com>
>>> cc: Tom Talpey <tom@talpey.com>
>>> cc: Long Li <longli@microsoft.com>
>>> cc: Namjae Jeon <linkinjeon@kernel.org>
>>> cc: Stefan Metzmacher <metze@samba.org>
>>> cc: linux-cifs@vger.kernel.org
>>> ---
>>>
>>>    fs/cifs/smb2ops.c |    3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>> index 880cd494afea..8d459f60f27b 100644
>>> --- a/fs/cifs/smb2ops.c
>>> +++ b/fs/cifs/smb2ops.c
>>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server,
>>> struct mid_q_entry *mid,
>>>    		iov.iov_base = buf + data_offset;
>>>    		iov.iov_len = data_len;
>>>    		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>>> +	} else if (use_rdma_mr) {
>>> +		/* The data was delivered directly by RDMA. */
>>> +		rdata->got_bytes = data_len;
>>>    	} else {
>>>    		/* read response payload cannot be in both buf and pages */
>>>    		WARN_ONCE(1, "buf can not contain only a part of read data");
>>
>> I'm not sure I understand why this would fix anything when encryption is
>> enabled.
>>
>> Is the payload still be offloaded as plaintext? Otherwise we wouldn't have
>> use_rdma_mr...
>> So this rather looks like a fix for the non encrypted case.
> ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
> only smb2 response is encrypted for this. And as you pointed out, We
> need to implement SMB2 RDMA Transform to encrypt it.

I haven't tested against a windows server yet, but my hope would be that
and encrypted request with SMB2_CHANNEL_RDMA_V1* receive NT_STATUS_ACCESS_DENIED or something similar...

Is someone able to check that against Windows?

But the core of it is a client security problem, shown in David's capture in frame 100.

metze

