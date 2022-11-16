Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E7162B049
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 01:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiKPA5O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 19:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKPA5N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:57:13 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C992FFED;
        Tue, 15 Nov 2022 16:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=h6LDOkE4F3jh6WWfsdhzELVK6aXoBJDVXJXXM0KDKpM=; b=UPHhsJznUb0Eh/YazapU8tbety
        ncVk9mYqt1t4xtQkgxCb8iKYtGFc8PTq/F6dCpZ9TjiF8LqV4fdgmcTkwm2Fo9GruzH8gYgVvACuG
        Z9a/8rPTsNM4bRw3wi3QmkuYvrXUVy0Bp7upjl/CHD4ftyoN3h8tcln1wAMHITdjtPkM2oUEQombN
        BVpsaA+k/qXG9i1JRGMQutXq+LvKogqoV8KdMlmnA8bke+Y/Dg4vxRHHwzjhk32ezRwCgVE1qK5I9
        anaA/e/1yKVghoIubHWWvuxhec++wFp6eUenpI5qozguZsrN15uW/XzXAFo+Vc3UG3wlCoO/M0J40
        cAnnkzULUsrW10bBxuHBGxjC7BsemmT71hW8M6qP4mtCe2KR2C/QmdYLvMdun3Dtf1+Bnt8IS589Y
        4NLNB5zQAIFlTTTPGHsNy7i792kaXewveMcTiCBxxJ6NK3tB2mlVpTflJmItHwC1RN/Z8doIL4p8v
        UElYd8/7gQAHxuQxkQHJlJLP;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1ov6jl-008mxT-Hh; Wed, 16 Nov 2022 00:57:09 +0000
Message-ID: <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
Date:   Wed, 16 Nov 2022 01:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US, de-DE
To:     David Howells <dhowells@redhat.com>, smfrench@gmail.com,
        tom@talpey.com
Cc:     Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
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

Hi David,

see below...

> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
> server has "smb3 encryption = yes" in its config file, the normal PDU
> stream is encrypted, but the directly-delivered data isn't in the stream
> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
> least with IWarp).
> 
> Currently, the direct delivery fails with:
> 
>     buf can not contain only a part of read data
>     WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731 handle_read_data+0x393/0x405
>     ...
>     RIP: 0010:handle_read_data+0x393/0x405
>     ...
>      smb3_handle_read_data+0x30/0x37
>      receive_encrypted_standard+0x141/0x224
>      cifs_demultiplex_thread+0x21a/0x63b
>      kthread+0xe7/0xef
>      ret_from_fork+0x22/0x30
> 
> The problem apparently stemming from the fact that it's trying to manage
> the decryption, but the data isn't in the smallbuf, the bigbuf or the page
> array).
> 
> This can be fixed simply by inserting an extra case into handle_read_data()
> that checks to see if use_rdma_mr is true, and if it is, just setting
> rdata->got_bytes to the length of data delivered and allowing normal
> continuation.
> 
> This can be seen in an IWarp packet trace.  With the upstream code, it does
> a DDP/RDMA packet, which produces the warning above and then retries,
> retrieving the data inline, spread across several SMBDirect messages that
> get glued together into a single PDU.  With the patch applied, only the
> DDP/RDMA packet is seen.
> 
> Note that this doesn't happen if the server isn't told to encrypt stuff and
> it does also happen with softRoCE.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <smfrench@gmail.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: Long Li <longli@microsoft.com>
> cc: Namjae Jeon <linkinjeon@kernel.org>
> cc: Stefan Metzmacher <metze@samba.org>
> cc: linux-cifs@vger.kernel.org
> ---
> 
>   fs/cifs/smb2ops.c |    3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 880cd494afea..8d459f60f27b 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>   		iov.iov_base = buf + data_offset;
>   		iov.iov_len = data_len;
>   		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
> +	} else if (use_rdma_mr) {
> +		/* The data was delivered directly by RDMA. */
> +		rdata->got_bytes = data_len;
>   	} else {
>   		/* read response payload cannot be in both buf and pages */
>   		WARN_ONCE(1, "buf can not contain only a part of read data");

I'm not sure I understand why this would fix anything when encryption is enabled.

Is the payload still be offloaded as plaintext? Otherwise we wouldn't have use_rdma_mr...
So this rather looks like a fix for the non encrypted case.

Before smbd_register_mr() is called we typically have a check like this:

       if (server->rdma && !server->sign && wdata->bytes >=
               server->smbd_conn->rdma_readwrite_threshold) {

I'm wondering if server->sign is true for the encryption case, otherwise
we would have to add a !encrypt check in addition as we should never use
RDMA offload for encrypted connections.

Latest Windows servers allow encrypted/signed offload, but that needs to be
negotiated via MS-SMB2 2.2.3.1.6 SMB2_RDMA_TRANSFORM_CAPABILITIES, see
https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/52b74a74-9838-4f51-b2b0-efeb23bd79d6
And SMB2_READFLAG_RESPONSE_RDMA_TRANSFORM in MS-SMB2 2.2.20 SMB2 READ Response
https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/3e3d2f2c-0e2f-41ea-ad07-fbca6ffdfd90
As well as SMB2_CHANNEL_RDMA_TRANSFORM in 2.2.21 SMB2 WRITE Request
https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/e7046961-3318-4350-be2a-a8d69bb59ce8
But none of this is implemented in Linux yet.

metze
