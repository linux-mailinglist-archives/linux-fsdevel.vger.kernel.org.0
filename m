Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3663762B2A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 06:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKPFUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 00:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPFUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:20:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64F2FFE4;
        Tue, 15 Nov 2022 21:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3032B617A1;
        Wed, 16 Nov 2022 05:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C79C433C1;
        Wed, 16 Nov 2022 05:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668575999;
        bh=bMYtf+33rhwquTkOxdjXtZH0gz9zjSF6U2NjYATCvWI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=JY/3E3B2DVp9Bl61z8IvwJ1Ne3PRZ0AmsBgjPUaRROyc3XWDir6ZHWYe3aPbptHPy
         OO7fdWmUuT6emdnmRkSKe1lwPuYaupRnRCyEMlFVzBZvIqdXvxd/53k1eNatC+omyX
         Pn/mRM4cmk19aXaaXkGMnwGd6fMl0Wm14g5YC4luGX2GcDkMuYf/eRY9XSHLXsoxsZ
         /aI7wgiAeOGEuKSMu7g0i37TyrjFDuBB9DGySFaI4EYhGtmW3atK4XwiDSZyC0627v
         GWHyjKDHRvbmw3cuJc+u4vZjHuVU14763HG70YsKofQ8rUAyJk/D4ZTl7tHcxMRVWV
         YXj47Y5jH//Hg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-12c8312131fso18866881fac.4;
        Tue, 15 Nov 2022 21:19:59 -0800 (PST)
X-Gm-Message-State: ANoB5pmWrad1PzAv+iFww1X6pcRkkJLEtEK+6jCGiyHemNo3MmpvuKh1
        qXsu4UsnTerHVELS60SS5nn+PFQ3MNgTaJzVVKA=
X-Google-Smtp-Source: AA0mqf719094vOtFZxQJDBle3QLRb+M0z74slyzvRPhNKMloF9DmklRNv4QjGWCioe4EJH620hdc7KPRj7HwK/L560w=
X-Received: by 2002:a05:6871:4486:b0:141:828c:12b5 with SMTP id
 ne6-20020a056871448600b00141828c12b5mr959062oab.8.1668575998749; Tue, 15 Nov
 2022 21:19:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6839:1a4e:0:0:0:0 with HTTP; Tue, 15 Nov 2022 21:19:58
 -0800 (PST)
In-Reply-To: <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
References: <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
 <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 16 Nov 2022 14:19:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
Message-ID: <CAKYAXd-Eym2D+92Vh=W=-LLVZ+WLVuvLZxqjJiUGZSykBpQdkg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
To:     Stefan Metzmacher <metze@samba.org>
Cc:     David Howells <dhowells@redhat.com>, smfrench@gmail.com,
        tom@talpey.com, Long Li <longli@microsoft.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2022-11-16 9:57 GMT+09:00, Stefan Metzmacher <metze@samba.org>:
> Hi David,
>
> see below...
>
>> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
>> server has "smb3 encryption = yes" in its config file, the normal PDU
>> stream is encrypted, but the directly-delivered data isn't in the stream
>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
>> least with IWarp).
>>
>> Currently, the direct delivery fails with:
>>
>>     buf can not contain only a part of read data
>>     WARNING: CPU: 0 PID: 4619 at fs/cifs/smb2ops.c:4731
>> handle_read_data+0x393/0x405
>>     ...
>>     RIP: 0010:handle_read_data+0x393/0x405
>>     ...
>>      smb3_handle_read_data+0x30/0x37
>>      receive_encrypted_standard+0x141/0x224
>>      cifs_demultiplex_thread+0x21a/0x63b
>>      kthread+0xe7/0xef
>>      ret_from_fork+0x22/0x30
>>
>> The problem apparently stemming from the fact that it's trying to manage
>> the decryption, but the data isn't in the smallbuf, the bigbuf or the
>> page
>> array).
>>
>> This can be fixed simply by inserting an extra case into
>> handle_read_data()
>> that checks to see if use_rdma_mr is true, and if it is, just setting
>> rdata->got_bytes to the length of data delivered and allowing normal
>> continuation.
>>
>> This can be seen in an IWarp packet trace.  With the upstream code, it
>> does
>> a DDP/RDMA packet, which produces the warning above and then retries,
>> retrieving the data inline, spread across several SMBDirect messages that
>> get glued together into a single PDU.  With the patch applied, only the
>> DDP/RDMA packet is seen.
>>
>> Note that this doesn't happen if the server isn't told to encrypt stuff
>> and
>> it does also happen with softRoCE.
>>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: Steve French <smfrench@gmail.com>
>> cc: Tom Talpey <tom@talpey.com>
>> cc: Long Li <longli@microsoft.com>
>> cc: Namjae Jeon <linkinjeon@kernel.org>
>> cc: Stefan Metzmacher <metze@samba.org>
>> cc: linux-cifs@vger.kernel.org
>> ---
>>
>>   fs/cifs/smb2ops.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>> index 880cd494afea..8d459f60f27b 100644
>> --- a/fs/cifs/smb2ops.c
>> +++ b/fs/cifs/smb2ops.c
>> @@ -4726,6 +4726,9 @@ handle_read_data(struct TCP_Server_Info *server,
>> struct mid_q_entry *mid,
>>   		iov.iov_base = buf + data_offset;
>>   		iov.iov_len = data_len;
>>   		iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
>> +	} else if (use_rdma_mr) {
>> +		/* The data was delivered directly by RDMA. */
>> +		rdata->got_bytes = data_len;
>>   	} else {
>>   		/* read response payload cannot be in both buf and pages */
>>   		WARN_ONCE(1, "buf can not contain only a part of read data");
>
> I'm not sure I understand why this would fix anything when encryption is
> enabled.
>
> Is the payload still be offloaded as plaintext? Otherwise we wouldn't have
> use_rdma_mr...
> So this rather looks like a fix for the non encrypted case.
ksmbd doesn't encrypt RDMA payload on read/write operation, Currently
only smb2 response is encrypted for this. And as you pointed out, We
need to implement SMB2 RDMA Transform to encrypt it.

>
> Before smbd_register_mr() is called we typically have a check like this:
>
>        if (server->rdma && !server->sign && wdata->bytes >=
>                server->smbd_conn->rdma_readwrite_threshold) {
>
> I'm wondering if server->sign is true for the encryption case, otherwise
> we would have to add a !encrypt check in addition as we should never use
> RDMA offload for encrypted connections.
>
> Latest Windows servers allow encrypted/signed offload, but that needs to be
> negotiated via MS-SMB2 2.2.3.1.6 SMB2_RDMA_TRANSFORM_CAPABILITIES, see
> https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/52b74a74-9838-4f51-b2b0-efeb23bd79d6
> And SMB2_READFLAG_RESPONSE_RDMA_TRANSFORM in MS-SMB2 2.2.20 SMB2 READ
> Response
> https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/3e3d2f2c-0e2f-41ea-ad07-fbca6ffdfd90
> As well as SMB2_CHANNEL_RDMA_TRANSFORM in 2.2.21 SMB2 WRITE Request
> https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-smb2/e7046961-3318-4350-be2a-a8d69bb59ce8
> But none of this is implemented in Linux yet.
>
> metze
>
