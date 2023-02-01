Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF756867F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 15:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjBAOFP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 09:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBAOFK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:05:10 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52128133;
        Wed,  1 Feb 2023 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=fC9O1tEpoVUREhcwsJEO8jppUnA8MHBCevsNPI2hq+k=; b=wWgEZibEOQIDRpDLCtGjyz8fP2
        fsTGeqH3zibK4z9yd6nlumZSdE4q8QIjPJFhF3IR2i7Wj6BiK7QN9Djv/XlELWxpQzXhAPJNj9FAW
        QzaZba6ItMMXgke0/IytvQ+1IX4s18+HFPLcSAGT/pNj1gcqxfeTc5Yj2oTEzOunw88oIlFxs9pKY
        P0+Ga2IzMoFpgR3wmnwvBMqnGVFqqI4tA4f/6EJWeBf8WwE58DYMnYhj72UW3GcuiqmLNRTNLErT7
        I6yvI1WGdIPV2xxYxVPOEKnRIDmf2sh4zKDnZEsSmrQgOMa986DfR20IG7o4sbA2DnzYsUaL4QzrF
        907B3UJFVsu8uOh4XlSuzyLp4JBhOiV/vQ6yLfaU8XHB7nHl8BLIBc0p5wAWqXqKbaK1ZH9nsN271
        ugfU2VTGwoyRoljdW2jeZ4M6U9yrKDUHon22XyzVwv4lcrJTs4gfvPKhOcEtphplL/nz5Sgf5z+g4
        sDMFGqnvi1wF2NW1vN6IP9rx;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1pNDjX-00BF5D-Eq; Wed, 01 Feb 2023 14:05:07 +0000
Message-ID: <be4dfc12-5593-e93a-3f78-638ee8ea9ad8@samba.org>
Date:   Wed, 1 Feb 2023 15:05:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 11/12] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>
References: <20230131182855.4027499-1-dhowells@redhat.com>
 <20230131182855.4027499-12-dhowells@redhat.com>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20230131182855.4027499-12-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 31.01.23 um 19:28 schrieb David Howells:
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
> 
> Link: https://lore.kernel.org/r/166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk/ # v1
> ---
>   fs/cifs/smb2ops.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index cea578a45ed8..73b66ac86abf 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -4733,6 +4733,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>   		if (length < 0)
>   			return length;
>   		rdata->got_bytes = data_len;
> +	} else if (use_rdma_mr) {
> +		/* The data was delivered directly by RDMA. */
> +		rdata->got_bytes = data_len;

I actually don't understand why this would only be a problem with encryption.

I guess there's much more needed and data_offset should most likely be
ignored completely in the rdma offload case. So I'd guess its just luck
that we don't trigger the below warning/error more often.

>   	} else {
>   		/* read response payload cannot be in both buf and pages */
>   		WARN_ONCE(1, "buf can not contain only a part of read data");
> 

