Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8D46032D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJRSvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJRSvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:51:14 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FFB26CB
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 11:51:13 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-35711e5a5ceso145832507b3.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JU/d6aV8CwgbPTzPcET8vyAl1h66wtbam5+BBeLcbDk=;
        b=IBr4moATCsSqkh4S4rNSqkkPZ56PhrLVTrSIcxblAQDAEUgjJqwgRm63PUQWsMQqaI
         gp+d7XA+SsI8iSOCBhRrgclMgHONu1C0evDKP310ZDtgW9XyDEDOltQvXg/5XTkgPf1b
         x0sm1dTrzX+GDItg71BxwGpJomq4Vvp2TdM/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JU/d6aV8CwgbPTzPcET8vyAl1h66wtbam5+BBeLcbDk=;
        b=eTnT9ftHvL/iD46zV1h2LSux6sfPW/ojdNGmf1PQkn/Qa2xWJfjoaavGM0uinXC6K0
         FweCyO+47ODPabVFAvUvvyEpd4P7RwcCo3LsT2fs6ie0lbjemJ15t6K1+3Jnue8gBECm
         QZFs1ksQsIaQSNPeqkyVZmgzT34f8Ln4ZhJSIhvMh6+psfnnYV1pY9echKhOz8LJKHLD
         Xbozv2aN06mMnD5yet3A9BLGWdyDTwT0ucUzwMTT+4haA3Q1aq95/61iSzxrF5lNwIzT
         d6srBKnMaaMgewNql+66/NdndF/SjlD7vAyekq/fiwA2V7dvuBwbQ1o2NU2pSeSW+FpV
         K1Vw==
X-Gm-Message-State: ACrzQf27DA3us3tvH1kS23z3gebjx11goaaT8eXrek42mqul/s0hARos
        rRZJcAldOzn3haLwdXK/yrqF+GU2erA1k3mtDadUUXsl/2p+p88l
X-Google-Smtp-Source: AMsMyM6uGuSh47IZQGwRNtJH2fpbTn7xw0SoWfAWrWS2KDjCJsMbYjkNqnxHiSVYyX/TkX3GixR4bQihSy/xSxMf3O8=
X-Received: by 2002:a81:4c6:0:b0:358:a206:f1fd with SMTP id
 189-20020a8104c6000000b00358a206f1fdmr3762584ywe.104.1666119072935; Tue, 18
 Oct 2022 11:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221018045844.37697-1-ivan@cloudflare.com> <Y07taqdJ/J3EyJoB@bfoster>
In-Reply-To: <Y07taqdJ/J3EyJoB@bfoster>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 18 Oct 2022 11:51:02 -0700
Message-ID: <CABWYdi37Ts7KDshSvwMf34EKuUrz25duL7W8hOO8t1Xm53t2rA@mail.gmail.com>
Subject: Re: [PATCH v3] proc: report open files as size in stat() for /proc/pid/fd
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:16 AM Brian Foster <bfoster@redhat.com> wrote:
> > +static int proc_readfd_count(struct inode *inode)
> > +{
> > +     struct task_struct *p = get_proc_task(inode);
> > +     struct fdtable *fdt;
> > +     unsigned int open_fds = 0;
> > +
> > +     if (!p)
> > +             return -ENOENT;
>
> Maybe this shouldn't happen, but do you mean to assign the error code to
> stat->size in the caller? Otherwise this seems reasonable to me.

You are right. As unlikely as it is to happen, we shouldn't return
negative size.

What's the idiomatic way to make this work? My two options are:

1. Pass &stat->size into proc_readfd_count:

  if (S_ISDIR(inode->i_mode)) {
    rv = proc_readfd_count(inode, &stat->size);
    if (rv < 0)
      goto out;
  }

out:
  return rv;

OR without a goto:

  if (S_ISDIR(inode->i_mode)) {
    rv = proc_readfd_count(inode, &stat->size));
    if (rv < 0)
      return rv;
  }

  return rv;

2. Return negative count as error (as we don't expect negative amount
of files open):

  if (S_ISDIR(inode->i_mode)) {
    size = proc_readfd_count(inode);
    if (size < 0)
      return size;
    stat->size = size;
  }
