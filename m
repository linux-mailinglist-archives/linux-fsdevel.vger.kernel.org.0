Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4172EF1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 00:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjFMWZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jun 2023 18:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFMWZX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:25:23 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4692A199C
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 15:25:20 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-33c1e7743b7so34194465ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jun 2023 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686695119; x=1689287119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhN468Fvl8LAS3y7m/PB2LmO8vVuptDlbPL+fXcCF80=;
        b=ujAss478R8WzQraMf+JDZ+jmRlk669FiOEFIGFaA+C0mLGaXr4G32aL7VD9+25w+iO
         39oIZWbr8KoPzYnnEdpMEcUo21Xq6PUfdfEz5/ccEmmdt89opG3WQLa+/FIAV5nPgZYP
         Z3Gzp0jGQAdC4Qa84/JjyNgQZ6UYElhxfLSht9g8U3afG7E1HfW/qXi5ZJ+TdHfduGDf
         fGmY8/2BeJ1egB/Xh97ecQdEbTWQN7n+XTVqqyozwdTAIU6NGYkH7tSuuCrImo1j0tye
         vIZUcNFU2i+qmw99j7PFMZKYaAa+v2emHx+L5P5RI4KWhHlo6R0drMdhjGTGoB/bZ7nN
         v0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686695119; x=1689287119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhN468Fvl8LAS3y7m/PB2LmO8vVuptDlbPL+fXcCF80=;
        b=QFWIf2FQFqarLFOvf6709jb3MQ7rcTZt0kbozaeSHBTJwhuTllatcHmCxwncgxmNWX
         laF7MA3eOG3KTQpxnR/QcoD/5nqZxN8YBmeUfyiDioZm+oj/7YGCTgfSJbYDLlU47v+Q
         ySKLwVJE+MlhfvLQ/4H0rXLsbBQUaAqtamOBALzgW+AS+IDwanWpxYI0lp+f7sQh2gW/
         jpijHlb1Auvahkn25gxfurJszoVQF8CED50A+i5Wh2CqpUGMR1Q8Eu19zJ/CP/H4c98l
         XVbdKhZqXuyrNR1URas6kzKqEROqri2gBovUgrHao3+BZOE9hZ3z/kyowR+qO49PDr9g
         d/wA==
X-Gm-Message-State: AC+VfDxC+0p/R0LnhrOYqLrrTHjrTZ8BOxXNS6DJTH6uJHD9VM05RQ4y
        5gcoppQYwfs/mwhnjp58uhh/Ow==
X-Google-Smtp-Source: ACHHUZ6ArYab1Swh0OTpHIjBNWOZzpwcqzGsh+CK+EF+Jb7G9aYRDjkR3OFDYjUou51loxN3lMMm7A==
X-Received: by 2002:a92:dc0b:0:b0:33a:adaa:d6d1 with SMTP id t11-20020a92dc0b000000b0033aadaad6d1mr13138102iln.15.1686695119607;
        Tue, 13 Jun 2023 15:25:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id t21-20020a63eb15000000b0052871962579sm9653913pgh.63.2023.06.13.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 15:25:19 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9CRv-00BRWR-2U;
        Wed, 14 Jun 2023 08:25:15 +1000
Date:   Wed, 14 Jun 2023 08:25:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, hch@infradead.org, corbet@lwn.net,
        snitzer@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, willy@infradead.org, dlemoal@kernel.org,
        linux@weissschuh.net, jack@suse.cz, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Donald Buczek <buczek@molgen.mpg.de>
Subject: Re: [PATCH v5 04/11] blksnap: header file of the module interface
Message-ID: <ZIjsywOtHM5nIhSr@dread.disaster.area>
References: <20230612135228.10702-1-sergei.shtepa@veeam.com>
 <20230612135228.10702-5-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612135228.10702-5-sergei.shtepa@veeam.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 03:52:21PM +0200, Sergei Shtepa wrote:
> The header file contains a set of declarations, structures and control
> requests (ioctl) that allows to manage the module from the user space.
> 
> Co-developed-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@infradead.org>
> Tested-by: Donald Buczek <buczek@molgen.mpg.de>
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  MAINTAINERS                  |   1 +
>  include/uapi/linux/blksnap.h | 421 +++++++++++++++++++++++++++++++++++
>  2 files changed, 422 insertions(+)
>  create mode 100644 include/uapi/linux/blksnap.h


.....

> +/**
> + * struct blksnap_snapshot_append_storage - Argument for the
> + *	&IOCTL_BLKSNAP_SNAPSHOT_APPEND_STORAGE control.
> + *
> + * @id:
> + *	Snapshot ID.
> + * @bdev_path:
> + *	Device path string buffer.
> + * @bdev_path_size:
> + *	Device path string buffer size.
> + * @count:
> + *	Size of @ranges in the number of &struct blksnap_sectors.
> + * @ranges:
> + *	Pointer to the array of &struct blksnap_sectors.
> + */
> +struct blksnap_snapshot_append_storage {
> +	struct blksnap_uuid id;
> +	__u64 bdev_path;
> +	__u32 bdev_path_size;
> +	__u32 count;
> +	__u64 ranges;
> +};
> +
> +/**
> + * define IOCTL_BLKSNAP_SNAPSHOT_APPEND_STORAGE - Append storage to the
> + *	difference storage of the snapshot.
> + *
> + * The snapshot difference storage can be set either before or after creating
> + * the snapshot images. This allows to dynamically expand the difference
> + * storage while holding the snapshot.
> + *
> + * Return: 0 if succeeded, negative errno otherwise.
> + */
> +#define IOCTL_BLKSNAP_SNAPSHOT_APPEND_STORAGE					\
> +	_IOW(BLKSNAP, blksnap_ioctl_snapshot_append_storage,			\
> +	     struct blksnap_snapshot_append_storage)

That's an API I'm extremely uncomfortable with. We've learnt the
lesson *many times* that userspace physical mappings of underlying
file storage are unreliable.

i.e.  This is reliant on userspace telling the kernel the physical
mapping of the filesystem file to block device LBA space and then
providing a guarantee (somehow) that the mapping will always remain
unchanged. i.e. It's reliant on passing FIEMAP data from the
filesystem to userspace and then back into the kernel without it
becoming stale and somehow providing a guarantee that nothing (not
even the filesystem doing internal garbage collection) will change
it.

It is reliant on userspace detecting shared blocks in files and
avoiding them; it's reliant on userspace never being able to read,
write or modify that file; it's reliant on the -filesystem- never
modifying the layout of that file; it's even reliant on a internal
filesystem state that has to be locked down before the block mapping
can be delegated to a third party for IO control.

Further, we can't allow userspace to have any read access to the
snapshot file even after it is no longer in use by the blksnap
driver.  The contents of the file will span multiple security
contexts, contain sensitive data, etc and so it's contents must
never be exposed to userspace. We cannot rely on userspace to delete
it safely after use and hence we have to protect it's contents
from exposure to userspace, too.

We already have a mechanism that provides all these guarantees to a
third party kernel subsystem: swap files.

We already have a trusted path in the kernel to allow internal block
mapping of a swap file to be retreived by the mm subsystem. We also
have an inode flag that protects it such files against access and
modification from anything other than internal kernel IO paths. We
also allow them to be allocated as unwritten extents using
fallocate() and we are never converted to written whilist in use as
a swapfile. Hence the contents of them cannot be exposed to
userspace even if the swapfile flag is removed and owner/permission
changes are made to the file after it is released by the kernel.

Swap files are an intrinsically safe mechanism for delegating fixed
file mappings to kernel subsystems that have requirements for
secure, trusted storage that userspace cannot tamper with.

I note that the code behind the
IOCTL_BLKSNAP_SNAPSHOT_APPEND_STORAGE ends up in
diff_storage_add_range(), which allocates an extent structure for
each range and links it into a linked list for later use.

This is effectively the same structure that the mm swapfile code
uses. It provides a swap_info_struct and a struct file to the
filesystem via aops->swap_activate. The filesystem then iterates the
extent list for the file and calls add_swap_extent() for each
physical range in the file. The mm code then allocates a new extent
structure for the range and links it into the extent rbtree in the
swap_info_struct. This is the mapping it uses later on in the IO
path.

Adding a similar, more generic mapping operation that allows a
private structure and a callback to the provided would allow the
filesystem to provide this callback directly to subsystems like
blksnap. Essentially diff_storage_add_range() becomes the iterator
callback for blksnap. This makes the whole "userspace provides the
mapping" problem goes away and we can use the swapfile mechanisms to
provide all the other guarantees the kernel needs to ensure it can
trust the contents and mappings of the blksnap snapshot files....

Thoughts?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
