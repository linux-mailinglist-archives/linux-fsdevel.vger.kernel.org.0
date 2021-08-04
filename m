Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E753DFE06
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 11:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbhHDJbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 05:31:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhHDJbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 05:31:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B402D221B5;
        Wed,  4 Aug 2021 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628069490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CL90sbdhCGnwPijnIZMVO1l7TdCtzuZFibOtSaIO3g=;
        b=vnk1T4jqLsR2415kEzCvuSnxDm09j7/RRja16DAosTFHalxLxgBIT08YF2mzYveQ3XZwkj
        SZbcJoCqou/sJrO8c+aIWy4nwuoTYXf1GDwnr878/S8VKAdzm27I+VucnzXVtAHcavNqjm
        NATc5+6EH38AKumeHld3XpKjGUZC1pM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628069490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/CL90sbdhCGnwPijnIZMVO1l7TdCtzuZFibOtSaIO3g=;
        b=ebEeoWXlX+Pg1i8Oo1rgxE/sHDeHH1cw7yTNQ9BxF+BFQZUdj5DGfbEoCrPzTm6uPjP9bv
        1gWXYZsAFHlS/nBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 851841338E;
        Wed,  4 Aug 2021 09:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id rVNrHnJeCmFMbQAAGKfGzw
        (envelope-from <ddiss@suse.de>); Wed, 04 Aug 2021 09:31:30 +0000
Date:   Wed, 4 Aug 2021 11:31:29 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND 1/3] initramfs: move unnecessary memcmp from hot
 path
Message-ID: <20210804113129.60848be6@suse.de>
In-Reply-To: <20210721115153.28620-1-ddiss@suse.de>
References: <20210721115153.28620-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping, any feedback on this change?

I think it's a no brainer, but for kicks I ran a few unrealistic micro
benchmarks on my laptop. Extraction time for a cpio image with 1M+
directories improved by 5ms (pre: 14.614s, post: 14.609s), when averaged
across 20 runs of:
  qemu-system-x86_64 -machine accel=kvm -smp cpus=1 -m 10240 \
        -kernel ~/linux/arch/x86/boot/bzImage \
        -initrd ./initrds/gen_cpio.out \
        -append "initramfs_async=0 console=ttyS0 panic=0" -nographic \
        | awk '/Trying to unpack rootfs/ {start_ts = $2};
               /Freeing initrd memory/ {end_ts = $2}
               END {printf "%f\n", end_ts - start_ts}'

Cheers, David

On Wed, 21 Jul 2021 13:51:51 +0200, David Disseldorp wrote:

> do_header() is called for each cpio entry and first checks for "newc"
> magic before parsing further. The magic check includes a special case
> error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
> special case POSIX.1 check needn't be done in the hot path, so move it
> under the non-newc-magic error path.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  init/initramfs.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/init/initramfs.c b/init/initramfs.c
> index af27abc59643..f01590cefa2d 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -256,12 +256,11 @@ static int __init do_collect(void)
>  
>  static int __init do_header(void)
>  {
> -	if (memcmp(collected, "070707", 6)==0) {
> -		error("incorrect cpio method used: use -H newc option");
> -		return 1;
> -	}
>  	if (memcmp(collected, "070701", 6)) {
> -		error("no cpio magic");
> +		if (memcmp(collected, "070707", 6) == 0)
> +			error("incorrect cpio method used: use -H newc option");
> +		else
> +			error("no cpio magic");
>  		return 1;
>  	}
>  	parse_header(collected);

