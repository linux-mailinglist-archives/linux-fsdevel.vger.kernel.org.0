Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97322168C80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2020 06:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgBVFVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 Feb 2020 00:21:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726892AbgBVFVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 Feb 2020 00:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582348892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LypZWR3wo1C+DQ15GIrtwcRbipyTjTpddzxoXyYlwg=;
        b=XfUheYHbBlqM8xR7X5B9ofPmsIua9/RQE7QxoMi5BWcyyQJEQHzmWiGgvbuUj/qJVISBDb
        R5gvfl1LXS1qXuajyubQAJ90lK2BBv6czryJOEipPg2Qu1z8nDj3qnsHJibu/nbHYmz/Pp
        iLI5DyVTx4GfsofNtxA/fG+jTY2RH/U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-NwztNkubMvmgWrolAX3oGQ-1; Sat, 22 Feb 2020 00:21:29 -0500
X-MC-Unique: NwztNkubMvmgWrolAX3oGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC8BD100550E;
        Sat, 22 Feb 2020 05:21:27 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40DFB5D9CD;
        Sat, 22 Feb 2020 05:21:26 +0000 (UTC)
Date:   Sat, 22 Feb 2020 13:31:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH V2 3/3] xfs/300: modify test to work on any fs block size
Message-ID: <20200222053152.GM14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Jeff Moyer <jmoyer@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20200220200632.14075-1-jmoyer@redhat.com>
 <20200220200632.14075-4-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220200632.14075-4-jmoyer@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 03:06:32PM -0500, Jeff Moyer wrote:
> The test currently assumes a file system block size of 4k.  It will
> work just fine on any user-specified block size, though.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  tests/xfs/300 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/300 b/tests/xfs/300
> index 28608b81..4f1c927a 100755
> --- a/tests/xfs/300
> +++ b/tests/xfs/300
> @@ -50,8 +50,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0x63 0 4096" $SCRATCH_MNT/attrvals >> $seqres.full
>  cat $SCRATCH_MNT/attrvals | attr -s name $SCRATCH_MNT/$seq.test >> $seqres.full 2>&1
>  
>  # Fragment the file by writing backwards
> +bs=$(_get_file_block_size $SCRATCH_MNT)
>  for I in `seq 6 -1 0`; do
> -	dd if=/dev/zero of=$SCRATCH_MNT/$seq.test seek=$I bs=4k \
> +	dd if=/dev/zero of=$SCRATCH_MNT/$seq.test seek=$I bs=${bs} \

Although the original case won't fail on 64k test. But this change makes
more sense.

Thanks,
Zorro

>  	   oflag=direct count=1 conv=notrunc >> $seqres.full 2>&1
>  done
>  
> -- 
> 2.19.1
> 

