Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4053A3CCDBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhGSGDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 02:03:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48148 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhGSGDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 02:03:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0C6A201DB;
        Mon, 19 Jul 2021 06:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626674406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSJZS6Jq4QudlpEfILRCfkUag24Hk+LiCeehdWVHlco=;
        b=NR5B1floJAziDy/VETPjHEDehsoSbT6MOy5cb10ijgeduD/5RBv1mkqH7B5FHGYvMAgGTh
        mLUrYNpsMYXM1efuAOoxuFtcu36/BUJ38EZsJMgblxTBqY1VGUMXIAC3IimQDCeZITN96d
        bOpVIetODD0iU7Uxqr4+sM4gZvCxuOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626674406;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSJZS6Jq4QudlpEfILRCfkUag24Hk+LiCeehdWVHlco=;
        b=lXA7TZBoYjVkSrGZqD/G1YP0J7sjuX+Nhqh81iFg2q660ELbjr9X4Tkd5aHeHvLLSl55Hh
        PoNlEjeu1o0HBNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C083E13C8B;
        Mon, 19 Jul 2021 06:00:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Onf6LeYU9WB8cQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 19 Jul 2021 06:00:06 +0000
Subject: Re: [PATCH] fscrypt: align Base64 encoding with RFC 4648 base64url
To:     Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
References: <20210718000125.59701-1-ebiggers@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <619969e7-f044-2f15-69cf-3eeb7a7ccb54@suse.de>
Date:   Mon, 19 Jul 2021 08:00:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210718000125.59701-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/18/21 2:01 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt uses a Base64 encoding to encode no-key filenames (the filenames
> that are presented to userspace when a directory is listed without its
> encryption key).  There are many variants of Base64, but the most common
> ones are specified by RFC 4648.  fscrypt can't use the regular RFC 4648
> "base64" variant because "base64" uses the '/' character, which isn't
> allowed in filenames.  However, RFC 4648 also specifies a "base64url"
> variant for use in URLs and filenames.  "base64url" is less common than
> "base64", but it's still implemented in many programming libraries.
> 
> Unfortunately, what fscrypt actually uses is a custom Base64 variant
> that differs from "base64url" in several ways:
> 
> - The binary data is divided into 6-bit chunks differently.
> 
> - Values 62 and 63 are encoded with '+' and ',' instead of '-' and '_'.
> 
> - '='-padding isn't used.  This isn't a problem per se, as the padding
>   isn't technically necessary, and RFC 4648 doesn't strictly require it.
>   But it needs to be properly documented.
> 
> There have been two attempts to copy the fscrypt Base64 code into lib/
> (https://lkml.kernel.org/r/20200821182813.52570-6-jlayton@kernel.org and
> https://lkml.kernel.org/r/20210716110428.9727-5-hare@suse.de), and both
> have been caught up by the fscrypt Base64 variant being nonstandard and
> not properly documented.  Also, the planned use of the fscrypt Base64
> code in the CephFS storage back-end will prevent it from being changed
> later (whereas currently it can still be changed), so we need to choose
> an encoding that we're happy with before it's too late.
> 
> Therefore, switch the fscrypt Base64 variant to base64url, in order to
> align more closely with RFC 4648 and other implementations and uses of
> Base64.  However, I opted not to implement '='-padding, as '='-padding
> adds complexity, is unnecessary, and isn't required by the RFC.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/filesystems/fscrypt.rst |  10 +--
>  fs/crypto/fname.c                     | 106 ++++++++++++++++----------
>  2 files changed, 70 insertions(+), 46 deletions(-)
> 
Thanks for doing it. I got confused by it myself, and having it named
'base64encode' while not _actually_ being base64 didn't help, either.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
