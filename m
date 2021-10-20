Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB04434DE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhJTOh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:37:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36122 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTOh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:37:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A82C21A5F;
        Wed, 20 Oct 2021 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634740543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vwI55IIQr2YcVAnhjMU6m76BmN6GhKknyEBU0osuTYE=;
        b=RrUu0bHGpdh7Xq1SGMgTed4xzNm+VNKR8OE25px0D/1War1YX0fSqT8wj6JQAh37/o/NLp
        3xLFXCcJpNjcnysDE52R7HIasOUPdcb7miFvnpZmhlQNYmIBYDDQgJXHYC5/oyrVAWJEeG
        bDhyRzlp54XOfFZkUuPTefRGj2Gn8L0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 33C4E13B55;
        Wed, 20 Oct 2021 14:35:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QP0SCj8pcGGXHwAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Oct 2021 14:35:43 +0000
Subject: Re: [PATCH v11 02/10] btrfs-progs: receive: dynamically allocate
 sctx->read_buf
From:   Nikolay Borisov <nborisov@suse.com>
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <01efd9dd3a70c1a765549b16d6aa5c4cec8a67e4.1630515568.git.osandov@fb.com>
 <c30108b4-3001-2f6f-dd01-d3fb31f5d4da@suse.com>
Message-ID: <dbecc5c2-c451-03f4-1a6f-cff09b934780@suse.com>
Date:   Wed, 20 Oct 2021 17:35:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <c30108b4-3001-2f6f-dd01-d3fb31f5d4da@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 20.10.21 г. 17:09, Nikolay Borisov wrote:
> 
> 
> On 1.09.21 г. 20:01, Omar Sandoval wrote:
>> From: Boris Burkov <boris@bur.io>
>>
>> In send stream v2, write commands can now be an arbitrary size. For that

nit: Actually can't commands really be up-to BTRFS_MAX_COMPRESSED + 16K
really  or are we going to leave this as an implementation detail? I'm
fine either way but looking at the changelog of patch 12 in the kernel
series doesn't really mention of arbitrary size, instead it explicitly
is talking about sending the max compressed extent size (128K) + some
space for metadata (the 16K above).

>> reason, we can no longer allocate a fixed array in sctx for read_cmd.
>> Instead, read_cmd dynamically allocates sctx->read_buf. To avoid
>> needless reallocations, we reuse read_buf between read_cmd calls by also
>> keeping track of the size of the allocated buffer in sctx->read_buf_sz.
>>
>> We do the first allocation of the old default size at the start of
>> processing the stream, and we only reallocate if we encounter a command
>> that needs a larger buffer.
>>
>> Signed-off-by: Boris Burkov <boris@bur.io>
>> ---
>>  common/send-stream.c | 55 ++++++++++++++++++++++++++++----------------
>>  send.h               |  2 +-
>>  2 files changed, 36 insertions(+), 21 deletions(-)
>>
> 
> <snip>
> 
>> @@ -124,18 +125,22 @@ static int read_cmd(struct btrfs_send_stream *sctx)
>>  		goto out;
>>  	}
>>  
>> -	sctx->cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
>> -	cmd = le16_to_cpu(sctx->cmd_hdr->cmd);
>> -	cmd_len = le32_to_cpu(sctx->cmd_hdr->len);
>> -
>> -	if (cmd_len + sizeof(*sctx->cmd_hdr) >= sizeof(sctx->read_buf)) {
>> -		ret = -EINVAL;
>> -		error("command length %u too big for buffer %zu",
>> -				cmd_len, sizeof(sctx->read_buf));
>> -		goto out;
>> +	cmd_hdr = (struct btrfs_cmd_header *)sctx->read_buf;
>> +	cmd_len = le32_to_cpu(cmd_hdr->len);
>> +	cmd = le16_to_cpu(cmd_hdr->cmd);
>> +	buf_len = sizeof(*cmd_hdr) + cmd_len;
>> +	if (sctx->read_buf_sz < buf_len) {
>> +		sctx->read_buf = realloc(sctx->read_buf, buf_len);
>> +		if (!sctx->read_buf) {
> 
> nit: This is prone to a memory leak, because according to
> https://en.cppreference.com/w/c/memory/realloc
> 
> If there is not enough memory, the old memory block is not freed and
> null pointer is returned.
> 
> 
> This means if realloc fails it will overwrite sctx->read_buf with NULL,
> yet the old memory won't be freed which will cause a memory leak. It can
> be argued that's not critical since we'll very quickly terminate the
> program afterwards but still.
> 
> 
> <snip>
> 
