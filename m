Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C6767754D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 07:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjAWG4O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 01:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjAWG4F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 01:56:05 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42FD1A975
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 22:55:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so9886835wmb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jan 2023 22:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BapcGcLwvJxKIYZFp7Q5wOviGXexhaLM7jIgbS939wc=;
        b=XrNfGRTFsXzdKeJuTPhkp60AmFBfCfJT8YEvY4SAmBoydz/LFWk9C1IDB8ZT8aATgC
         eYRnZkP96KOOmzblJVJZyWQJjaRWmNe8NLpbtgacr0KHaeAgr8KjRd/+khhzh5c1JLGb
         yH0ZOXlvZVCc8mR/TYDFIPr7u/T/LsSLP1JJHW9vA4hGVm/e3vveO9XlGaIr+Mm8IkS6
         JYcdG8vhH5O4oViISYQvgeGvFZoUNxjPfH/FaFlEODF94//ZLqX9bLRQqQKvS5ZIm01D
         +lrv++pEAQbxbp3QiwKFwZDNO6vj6FDrTXd1Ylk6bUarI39BetnkdQvPSjozYaSdhd4k
         hIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BapcGcLwvJxKIYZFp7Q5wOviGXexhaLM7jIgbS939wc=;
        b=hsF/KFxfqMi0AH3WMaBhcWEqa49U0Sd4qUT5IYTqM5e/fAHbXSc95PsVvqpgOr4i6N
         SnqjQTir4JMNVU5q3eKt7bmtvQo4sA4Nr/G1EZ2V0znYPh6UNk0sBDEojhMGPI64MPCC
         og2p4a02s7czoWriOXll3OlJRjBW8MaOwYjzNuw/fz0DuNQIYB2bdaTcynMC9EVfDxJX
         zqOOZcc5lrxHgRLozhYXzb6SVxx00uhjyz+E2NXofVho9n8/+ZxmwGJvOtOHNN6lqZAQ
         ZKCDc+La6xuqzdbpl5peJ+SZveC9I46OR4gfNpoVVuEacJfqZ2zohbohk/FaflUhDWf/
         qaWA==
X-Gm-Message-State: AFqh2krrYAatpHmGGKzqO77mlsNGxA2qZ24BiD/+Y0+XagSF7Xy9eGvf
        QxKZS271GXHzJZDqMywO7GY=
X-Google-Smtp-Source: AMrXdXvYEfoQ2Ft+AAF1X8x0lBUvtmE3SVIj1KcGDs2Ow87F00/eYQoIUHRtfYHUuGTWubx+U5NnRQ==
X-Received: by 2002:a1c:7417:0:b0:3da:fcd:7dfe with SMTP id p23-20020a1c7417000000b003da0fcd7dfemr30705283wmc.10.1674456937076;
        Sun, 22 Jan 2023 22:55:37 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm13469706wmo.0.2023.01.22.22.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 22:55:36 -0800 (PST)
Date:   Mon, 23 Jan 2023 09:55:32 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dchinner@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [bug report] iomap: write iomap validity checks
Message-ID: <Y84vZBLWx4KsuUz1@kadam>
References: <Y8qbWDfLGqUDnbsz@kili>
 <Y8q+d7TIZiT9nRVa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8q+d7TIZiT9nRVa@casper.infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 20, 2023 at 04:16:55PM +0000, Matthew Wilcox wrote:
> On Fri, Jan 20, 2023 at 04:47:04PM +0300, Dan Carpenter wrote:
> > Hello Dave Chinner,
> > 
> > The patch d7b64041164c: "iomap: write iomap validity checks" from Nov
> > 29, 2022, leads to the following Smatch static checker warning:
> > 
> > 	fs/iomap/buffered-io.c:829 iomap_write_iter()
> > 	error: uninitialized symbol 'folio'.
> > 
> > fs/iomap/buffered-io.c
> >     818                 if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {
> >     819                         status = -EFAULT;
> >     820                         break;
> >     821                 }
> >     822 
> >     823                 status = iomap_write_begin(iter, pos, bytes, &folio);
> >                                                                      ^^^^^^^
> > The iomap_write_begin() function can succeed without initializing
> > *foliop.  It's next to the big comment.
> 
> Yes, but if it does, it sets IOMAP_F_STALE
> 
> >     824                 if (unlikely(status))
> >     825                         break;
> >     826                 if (iter->iomap.flags & IOMAP_F_STALE)
> >     827                         break;
> 
> so it breaks out here.  Maybe we should return an errno from
> iomap_write_begin() to make life easier for the static checking tools?
> 

Thanks for taking a look at this.  I say just leave it as-is.

I know how to modify Smatch to handle this correctly, but it's quite a
lot of typing involved.

regards,
dan carpenter

