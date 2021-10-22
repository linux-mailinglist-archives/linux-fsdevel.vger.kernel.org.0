Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFD74371D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhJVGh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 02:37:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44434 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhJVGh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 02:37:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FD871FD59;
        Fri, 22 Oct 2021 06:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634884538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aU+GGUZR+JbcOgvKpGdMDYJHC4yv0Y07Dxz9R6inlGk=;
        b=tiUe1Qbm0QmYXsnY+Snk0m0N8HGHNf5bIAmMrI35wfggei9LDLwkIN2/A5vqVkeZjT2oNp
        Y20oc2VjBOSa2XdzWVFaNYEZ8QqXyRsKaqXU1W60gcjVjnIsfYgjSSSmYR30A18t4hxwk3
        UAMnByeuPg3gDhBadw4q8Ipp1QKu3Bw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD1C913A17;
        Fri, 22 Oct 2021 06:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9VpzL7lbcmHZDAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 22 Oct 2021 06:35:37 +0000
Subject: Re: [PATCH v11 09/10] btrfs-progs: send: stream v2 ioctl flags
To:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <cover.1630514529.git.osandov@fb.com>
 <9228a836d43b1d721fbdbd662e1c8558cb27be67.1630515568.git.osandov@fb.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <b5f0cc44-6900-8cb8-a21e-4289102dbe23@suse.com>
Date:   Fri, 22 Oct 2021 09:35:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9228a836d43b1d721fbdbd662e1c8558cb27be67.1630515568.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 1.09.21 г. 20:01, Omar Sandoval wrote:
> From: Boris Burkov <boris@bur.io>
> 
> To make the btrfs send ioctl use the stream v2 format requires passing
> BTRFS_SEND_FLAG_STREAM_V2 in flags. Further, to cause the ioctl to emit
> encoded_write commands for encoded extents, we must set that flag as
> well as BTRFS_SEND_FLAG_COMPRESSED. Finally, we bump up the version in
> send.h as well, since we are now fully compatible with v2.
> 
> Add two command line arguments to btrfs send: --stream-version and
> --compressed-data. --stream-version requires an argument which it parses
> as an integer and sets STREAM_V2 if the argument is 2. --compressed-data
> does not require an argument and automatically implies STREAM_V2 as well
> (COMPRESSED alone causes the ioctl to error out).
> 
> Some examples to illustrate edge cases:
> 
> // v1, old format and no encoded_writes
> btrfs send subvol
> btrfs send --stream-version 1 subvol
> 
> // v2 and compressed, we will see encoded_writes
> btrfs send --compressed-data subvol
> btrfs send --compressed-data --stream-version 2 subvol
> 
> // v2 only, new format but no encoded_writes
> btrfs send --stream-version 2 subvol
> 
> // error: compressed needs version >= 2
> btrfs send --compressed-data --stream-version 1 subvol
> 
> // error: invalid version (not 1 or 2)
> btrfs send --stream-version 3 subvol
> btrfs send --compressed-data --stream-version 0 subvol
> btrfs send --compressed-data --stream-version 10 subvol


Why would we want to predicate the compressed writes usage on anything
other than the stream version?

> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  Documentation/btrfs-send.asciidoc | 16 ++++++++-
>  cmds/send.c                       | 54 ++++++++++++++++++++++++++++++-
>  ioctl.h                           | 17 +++++++++-
>  libbtrfsutil/btrfs.h              | 17 +++++++++-
>  send.h                            |  2 +-
>  5 files changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/btrfs-send.asciidoc b/Documentation/btrfs-send.asciidoc
> index c4a05672..202bcd97 100644
> --- a/Documentation/btrfs-send.asciidoc
> +++ b/Documentation/btrfs-send.asciidoc
> @@ -55,7 +55,21 @@ send in 'NO_FILE_DATA' mode
>  The output stream does not contain any file
>  data and thus cannot be used to transfer changes. This mode is faster and
>  is useful to show the differences in metadata.
> --q|--quiet::::
> +
> +--stream-version <1|2>::
> +Use the given send stream version. The default is 1. Version 2 encodes file
> +data slightly more efficiently; it is also required for sending compressed data
> +directly (see '--compressed-data'). Version 2 requires at least btrfs-progs
> +5.12 on both the sender and receiver and at least Linux 5.12 on the sender.
> +

The version of progs needs to be adjusted but I assume this will be done
by David when this patchset is merged as we don't have a target ATM.

> +--compressed-data::
> +Send data that is compressed on the filesystem directly without decompressing
> +it. If the receiver supports encoded I/O (see `encoded_io`(7)), it can also
> +write it directly without decompressing it. Otherwise, the receiver will fall
> +back to decompressing it and writing it normally. This implies
> +'--stream-version 2'.
> +
> +-q|--quiet::
>  (deprecated) alias for global '-q' option
>  -v|--verbose::
>  (deprecated) alias for global '-v' option
> diff --git a/cmds/send.c b/cmds/send.c
> index 3bfc69f5..80eb2510 100644
> --- a/cmds/send.c
> +++ b/cmds/send.c
> @@ -452,6 +452,21 @@ static const char * const cmd_send_usage[] = {
>  	"                 does not contain any file data and thus cannot be used",
>  	"                 to transfer changes. This mode is faster and useful to",
>  	"                 show the differences in metadata.",
> +	"--stream-version <1|2>",
> +	"                 Use the given send stream version. The default is",
> +	"                 1. Version 2 encodes file data slightly more",
> +	"                 efficiently; it is also required for sending",
> +	"                 compressed data directly (see --compressed-data).",
> +	"                 Version 2 requires at least btrfs-progs 5.12 on both",
> +	"                 the sender and receiver and at least Linux 5.12 on the",
> +	"                 sender.",

Ditto

<snip>
