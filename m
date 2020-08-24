Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307362509A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 21:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgHXTyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHXTyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:54:32 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE74C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 12:54:32 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id y11so4388994qvl.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2020 12:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aoGmJKu/IYMkCMsmrRk+N9ZX2m6o31tS+9YtnF+yBmM=;
        b=XozqMs7n1YDGDWeKjTh8V+vZoyH4wIxNv2f9afi8rbknqyPtrS2635xvwFy8vZsPS9
         o3hpIUzLk7DjHbh3IbBk5nommv2xJsAj5U1jU5QedGJjve5qXG+uu7w/QjzKKrNGy+D+
         1eWdtaaMUFG7D8RH6PMYqAn8VBRdN6NWRLE6rD5nRkTQHWxFRGxQPG9uagBLGHYxfzUv
         cUDXZ+weDPggh1zogIgGdZVKb0eZgRMIFA77cWWLM4x9kgWQR1je5mr3Bh2t1Nh4H1ub
         uIjhibyua1UpQibZgwXHD7sy1VahPOaFg70bnNHmyxl9SdMwh6/UGvZRo3Q4GITfkaF4
         +wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aoGmJKu/IYMkCMsmrRk+N9ZX2m6o31tS+9YtnF+yBmM=;
        b=d3ySpBGaZ7SraiF8wo+JUO9Zo15515XTVzWveoZRcHKvQlowKBNYYGKvzyMOeMKehP
         5fSxt6edgY9uv7EAvCf7hugvPEURHezXk8cI34CVqc0b38gFqZua3pZRhHihSjA0/SWA
         h8sgpWWvJR0uRw0aW4WJHLKtTfFNgt5eWSrd89SxjP1naftepSMWgTJeakdUdSkdgbvG
         6HctLDjePM/Cx48x5StNaaXqx9thlQgeLKD7XAX+cGnCxn0Mdv9LkQbfp4rXtaCMXQpz
         XA7wbCOpayeXPy+ArW74ZGe6rtdBY9+HE0FAC4rZ8r1cgAALhQJN9BKH9v6Zb3J9Az0b
         jOMg==
X-Gm-Message-State: AOAM532ycPGWz6VFIKan1JXSdwiBgdXcEdRcJadECPuzPGFwVMSsnOom
        xWcm0LikwYy4cfyeJiDyIYioNg==
X-Google-Smtp-Source: ABdhPJx9gGcxy2qG2eaRGpYM3/vQX1ezJSqBiTigWkWx1WNt29oRgPZbAV9b/5ZPyMpoSmDnyyxdzw==
X-Received: by 2002:ad4:5849:: with SMTP id de9mr6245875qvb.22.1598298871066;
        Mon, 24 Aug 2020 12:54:31 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s184sm10496382qkf.50.2020.08.24.12.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:54:30 -0700 (PDT)
Subject: Re: [PATCH v5 8/9] btrfs: implement RWF_ENCODED reads
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <a52f9e7743bb924cdfa87906295e422bc48801c7.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <06545b90-976e-35a7-182d-8e005fc6b199@toxicpanda.com>
Date:   Mon, 24 Aug 2020 15:54:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a52f9e7743bb924cdfa87906295e422bc48801c7.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> There are 4 main cases:
> 
> 1. Inline extents: we copy the data straight out of the extent buffer.
> 2. Hole/preallocated extents: we fill in zeroes.
> 3. Regular, uncompressed extents: we read the sectors we need directly
>     from disk.
> 4. Regular, compressed extents: we read the entire compressed extent
>     from disk and indicate what subset of the decompressed extent is in
>     the file.
> 
> This initial implementation simplifies a few things that can be improved
> in the future:
> 
> - We hold the inode lock during the operation.
> - Cases 1, 3, and 4 allocate temporary memory to read into before
>    copying out to userspace.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>


<snip>

> +	tmp = kmalloc(count, GFP_NOFS);
> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	read_extent_buffer(leaf, tmp, ptr, count);
> +	btrfs_free_path(path);

Why not just btrfs_release_path(), you're freeing below anyway.

Also a mention that we're explicitly not handling read repairs and backup copies 
would be good in the changelog as well.  Thanks,

Josef
