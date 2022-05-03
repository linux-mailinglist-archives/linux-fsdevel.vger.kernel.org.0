Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DCD518CA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 20:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbiECS4L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 14:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiECS4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 14:56:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5853E0E0
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 11:52:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i27so35149982ejd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 May 2022 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+53Nu1sdzbhj5f+bVeszWe3uOnWBSR1lb0KWgzfBqos=;
        b=CA7MqryCloS3FBvwU8S/wXU0n7Gs5ssJT66d6+3L+MaMSAq1o7K03VtxVZR20goLQ1
         k16T3/68mpBatPHWuEcGDm3l31LJJ5beiSFCjrTvbiFLIxN6Bc0OHvYG82C9AU90qg+L
         svrtv3fCPbyGI6WWLZl/NmMkkd4E16clswe3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+53Nu1sdzbhj5f+bVeszWe3uOnWBSR1lb0KWgzfBqos=;
        b=wyG1+W18g3xvlbwe0xHABTQxJUWPEGBkG/OiM6YPJSxRF4pIKKvEv4E2Du8Iz/UAf2
         PNyCmYGOj+CCvTSDYk+FuVDfv6RbasRF56HnnqPpkTuBJpRVMY1zxo0sZp1UP5X1hC7h
         cyAbIiMPdSZvRdqK343CU7w4gjms1vPJ8kYxg6Pisw6FZC1cCOm7ZQNlRS4hbMcUXZX0
         A4agfFI2zJoEPdim0QRyrKydnv6PK+oOZMTHOE5MqAfuEEJN864OfKx/YHa+u0u6Fww9
         8jUwSWeR5a6pUIvhLKUNob+q74n3hIttMLi7vsGnKBkC260IziRWhRS5mDjOhDzhcB7g
         q9zA==
X-Gm-Message-State: AOAM530ORTMrStJQM6bEYkCfbbPQvY5tdAdhkwIrLsFh0P0L9lOjZsaO
        S0+dS2TRbRWLC4aYn1Q8c2qqHpsRp9eo+87xe5+MPw==
X-Google-Smtp-Source: ABdhPJysAIdTHp9PSQJkZUq/jimZI5MPOJIj4u+BZoM6Q5whd76vnfVhBKCoOEbFM+b4oGJXiERGdeWvtp6KS96MN34=
X-Received: by 2002:a17:906:58d1:b0:6f4:6e61:dae with SMTP id
 e17-20020a17090658d100b006f46e610daemr7130379ejs.468.1651603955075; Tue, 03
 May 2022 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv7Z7XmyWgp5K8ZshA1OiMBTNGU-v8FdmwwkZaNNe=4wA@mail.gmail.com>
In-Reply-To: <CAH2r5mv7Z7XmyWgp5K8ZshA1OiMBTNGU-v8FdmwwkZaNNe=4wA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 May 2022 20:52:23 +0200
Message-ID: <CAJfpegskJzpXXhWCdw6K9r2hKORiBdXfSrgpUhKqn9VVyuVuqw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] making O_TMPFILE more atomic
To:     Steve French <smfrench@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 24 Feb 2022 at 06:33, Steve French <smfrench@gmail.com> wrote:
>
> Currently creating tmpfiles on Linux can be problematic because the
> tmpfile is not created and opened at the same time  (vfs_tmpfile calls
> into the fs, then later vfs_open is called to open the tmpfile).   For
> some filesystems it would be more natural to create and open the
> tmpfile as one operation (because the action of creating the file on
> some filesystems returns an open handle, so closing it then reopening
> it would cause the tmpfile to be deleted).
>
> I would like to discuss whether the function do_tmpfile (which creates
> and then opens the tmpfile) could have an option for a filesystem to
> do this as one operation which would allow it to be more atomic and
> allow it to work on a wider variety of filesystems.

A related thread:

https://lore.kernel.org/all/20201109100343.3958378-3-chirantan@chromium.org/#r

There was no conclusion in the end. Not sure how hacky it would be to
store the open file in the inode...

Thanks,
Miklos
