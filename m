Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA033434C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 15:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJTNvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 09:51:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTNvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:51:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26C9021A7F;
        Wed, 20 Oct 2021 13:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634737779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqmM3h9Cy18Yxo/nPKgmZ3B35y5sxcNst1sW2y1M94A=;
        b=B/OUnEYPKCBPOx/u8qVHxnivSa3DPKeZ0bGeAZ0k/QASEu60oRXpLkYYL5huyQfN7+k4fq
        h+jgivUaginT9PTBbNOYyR5vpfYh7sizyaUm8eDNQOTLsoTCqDMh9bl6VLasmi8iI+Qo2Z
        bi5GlaHF3SDu00oQGmzZzAp9pEU6624=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF2E013B55;
        Wed, 20 Oct 2021 13:49:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eG4BMHIecGFUCAAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 20 Oct 2021 13:49:38 +0000
Subject: Re: [PATCH v11 01/10] btrfs-progs: receive: support v2 send stream
 larger tlv_len
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <8729477d23b83c368a76c4f39b5f73a483a3ad14.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <d628363e-295d-8e84-d6f2-85501ada24ed@suse.com>
Date:   Wed, 20 Oct 2021 16:49:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8729477d23b83c368a76c4f39b5f73a483a3ad14.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <borisb@fb.com>
> 
> An encoded extent can be up to 128K in length, which exceeds the largest
> value expressible by the current send stream format's 16 bit tlv_len
> field. Since encoded writes cannot be split into multiple writes by
> btrfs send, the send stream format must change to accommodate encoded
> writes.
> 
> Supporting this changed format requires retooling how we store the
> commands we have processed. Since we can no longer use btrfs_tlv_header
> to describe every attribute, we define a new struct btrfs_send_attribute
> which has a 32 bit length field, and use that to store the attribute
> information needed for receive processing. This is transparent to users
> of the various TLV_GET macros.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  common/send-stream.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/common/send-stream.c b/common/send-stream.c
> index a0c52f79..cd5aa311 100644
> --- a/common/send-stream.c
> +++ b/common/send-stream.c
> @@ -24,13 +24,23 @@
>  #include "crypto/crc32c.h"
>  #include "common/utils.h"
>  
> +struct btrfs_send_attribute {
> +	u16 tlv_type;
> +	/*
> +	 * Note: in btrfs_tlv_header, this is __le16, but we need 32 bits for
> +	 * attributes with file data as of version 2 of the send stream format
> +	 */
> +	u32 tlv_len;
> +	char *data;
> +};
> +
>  struct btrfs_send_stream {
>  	char read_buf[BTRFS_SEND_BUF_SIZE];
>  	int fd;
>  
>  	int cmd;
>  	struct btrfs_cmd_header *cmd_hdr;
> -	struct btrfs_tlv_header *cmd_attrs[BTRFS_SEND_A_MAX + 1];
> +	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];

This is subtle and it took me a couple of minutes to get it at first.
Currently cmds_attrs holds an array of pointers into the command buffer,
with every pointer being the beginning of the tlv_header, whilst with
your change cmd_attr now holds actual btrfs_send_attribute structures
(52 bytes vs sizeof(uintptr_t)  bytes before). So this increases the
overall size of btrfs_send_stream because with  your version of the code
you parse the type/length fields and store them directly in the send
attribute structure at command parse time rather than just referring to
the raw command buffer during read_cmd and referring to them during
attribute parsing.

This might seem superficial but this kind of change should really be
mentioned explicitly in the changelog to better prepare reviewers what
to expect.


OTOH the code LGTM and actually now it seems less tricky than before so:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


David if you deem it necessary adjust the commit message appropriately.


