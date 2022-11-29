Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E963BF00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 12:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiK2LbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 06:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiK2Lao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:30:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F342F7E
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 03:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669721387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ba4L6Jy3iTd5d984B4HuUQo6AgG8IkQsEu+Q1segjoE=;
        b=Xz87xfMWlj7kx5CKXppVAuF18M1U/zrvqo9rsKHfL8ZOZo8EXtojMCqY2Uq817ih5rXZB/
        lExVEYotWGvcGnilF3Ticre3IwrI3qtvthT9IGxvRe/yEG8YNBcmSRAnL8nc29uJ6g69B6
        QoI2psaKii8Ua+TxzBbWW5UIhF4JJoc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-50-gT1tT3LwMOWTPe4oEf9xCA-1; Tue, 29 Nov 2022 06:29:46 -0500
X-MC-Unique: gT1tT3LwMOWTPe4oEf9xCA-1
Received: by mail-qt1-f200.google.com with SMTP id f4-20020a05622a114400b003a57f828277so20855471qty.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 03:29:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba4L6Jy3iTd5d984B4HuUQo6AgG8IkQsEu+Q1segjoE=;
        b=HzRY79PhmCb3FFvM4sHvFgQHE7mFm6wlKSyrmQRsvbKmPZ84/yiUBLzFTBijj2dsHb
         pYIsgR47K3xkRrozfkm5/wvuq86dc9t4rZWHzIuvwZoTo9mX5AYUQ7usmrBqL4rxgGG1
         2EwXbx4K75NlEz5Xoxj6jHZN5Cc7n4f5epsEsqrKycbx2m7lS7Q2I0LVQjlfy7UBJzgU
         XFfoK09s6F8LWRUOu6ze0MzNkdZMGg7aDUO8rKgb7rcvrrLZ0nm8G5acVGU8QdkZzKyC
         jpWO2ymVoBUhzCrqLTYygS9xBv6lX7iCxkpBM+3XHwOTne/OfqgjuHJvlI4pC4nQD5Sx
         3H9A==
X-Gm-Message-State: ANoB5pnIKDLppM4CI1bSP9KcJ1G5OxhhJf3Efcp2YHXxoh/P5LPu/UOM
        KBzwhEzGh2dkuSGcCJ+KtJX2njkg9RmFUqTdF6oJX7goYWmKQnvMxW8ARSnRXxwMAKTd/lkeszu
        XXIg8w5FnFJqPBxvtcGurSX5bsw==
X-Received: by 2002:a05:622a:1a01:b0:3a6:21e5:d409 with SMTP id f1-20020a05622a1a0100b003a621e5d409mr50174968qtb.206.1669721385745;
        Tue, 29 Nov 2022 03:29:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7LobABfCCcHaRkIFz/ZUyfvj0EToACFaPLbvEwhqy7/XZk6IzmRLIFs8uccjEne2PUKmWhvQ==
X-Received: by 2002:a05:622a:1a01:b0:3a6:21e5:d409 with SMTP id f1-20020a05622a1a0100b003a621e5d409mr50174961qtb.206.1669721385513;
        Tue, 29 Nov 2022 03:29:45 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id n1-20020a05620a294100b006fa16fe93bbsm10496012qkp.15.2022.11.29.03.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 03:29:45 -0800 (PST)
Date:   Tue, 29 Nov 2022 06:29:51 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/remap_range: avoid spurious writeback on zero length
 request
Message-ID: <Y4XtL9SzQN/A4w5U@bfoster>
References: <20221128160813.3950889-1-bfoster@redhat.com>
 <Y4TubQFwHExk07w4@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4TubQFwHExk07w4@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 09:22:53AM -0800, Darrick J. Wong wrote:
> On Mon, Nov 28, 2022 at 11:08:13AM -0500, Brian Foster wrote:
> > generic_remap_checks() can reduce the effective request length (i.e.,
> > after the reflink extend to EOF case is handled) down to zero. If this
> > occurs, __generic_remap_file_range_prep() proceeds through dio
> > serialization, file mapping flush calls, and may invoke file_modified()
> > before returning back to the filesystem caller, all of which immediately
> > check for len == 0 and return.
> > 
> > While this is mostly harmless, it is spurious and not completely
> > without side effect. A filemap write call can submit I/O (but not
> > wait on it) when the specified end byte precedes the start but
> > happens to land on the same aligned page boundary, which can occur
> > from __generic_remap_file_range_prep() when len is 0.
> > 
> > The dedupe path already has a len == 0 check to break out before doing
> > range comparisons. Lift this check a bit earlier in the function to
> > cover the general case of len == 0 and avoid the unnecessary work.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> Looks correct,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Should there be an(other) "if (!*len) return 0;" after the
> generic_remap_check_len call to skip the mtime update if the remap
> request gets shortened to avoid remapping an unaligned eofblock into the
> middle of the destination file?
> 

Looks sensible to me, though I guess I would do something like the
appended diff. Do you want to just fold that into this patch?

Brian

--- 8< ---

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 32ea992f9acc..2f236c9c5802 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -347,7 +347,7 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 
 	ret = generic_remap_check_len(inode_in, inode_out, pos_out, len,
 			remap_flags);
-	if (ret)
+	if (ret || *len == 0)
 		return ret;
 
 	/* If can't alter the file contents, we're done. */

