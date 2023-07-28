Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB6A7667E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 10:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjG1Ix5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jul 2023 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbjG1IxU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:53:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D36E7E
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:52:37 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99bcd6c0282so260259566b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jul 2023 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1690534356; x=1691139156;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FI2jBmUXCaOeFBpwanIsJqeObT9oHvFHE299Ohs95AQ=;
        b=npNNqzerAXVicwOGWx9IsP+wcwlFbulyzqVUSCqEmav+A+GzBcG+diQb4XFTeiAf9H
         nkccsmISFLq4hOLtQej9h2OovLV3XDh+Vx1ty7fln6r+gr3wHQtdiC4/RObCxxog1mk/
         18ronPax9ppmsMP/AR1aSzayxF5ZNcRkBcZzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690534356; x=1691139156;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FI2jBmUXCaOeFBpwanIsJqeObT9oHvFHE299Ohs95AQ=;
        b=PdIzt5GGfgOVyoUZlgP+nfRnfGfMJW9mlf/5MpWtgRqhXzjaxbZsvFPh+eKjaYhDPL
         /PM/+gdZJxllUeVc6eOoixHcQDDEXOn4a85DsFHxG5YvYfgl8/ufWoWZnDvkBqr3J42O
         3NqDWG9CQbdpbE9bT8AY54FuQ4JK6GBWU7dS+vhO2FQe+cR+U8hJ4QWlzERmKPMGIxQS
         r95O8nXMPMK+iV+o0PtRKDKnJU12I+r0q5kZ7Ku0lDhE89o9BuXJpuw5EZKNKEKgbNhM
         j3JkZFMiEGRk/uC88eWAeJCwb0CUCgE9WzFQB+1JmD/s45tWrXgShz9pxc8CN5Py0u/b
         Zx0A==
X-Gm-Message-State: ABy/qLbLIEBqZlsmZDa6klFsBBp0B9nuPHScPypf5kx2HRxZsKVtOQjO
        cojPeE3vVwJWdhu91XwDlakCO02CC8uw6IYBSRDVhQ==
X-Google-Smtp-Source: APBJJlG9EqjpHgkw8pl7RxAwtBTUHkv4IccKQouqxC24nHFxcoS50XbBrbdk5AyeDSVRg9c7uguykOnnN/3wP/INLBw=
X-Received: by 2002:a17:906:86:b0:99b:e6ec:752c with SMTP id
 6-20020a170906008600b0099be6ec752cmr1756688ejc.70.1690534356014; Fri, 28 Jul
 2023 01:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <87wmymk0k9.fsf@vostro.rath.org> <CAJfpegs+FfWGCOxX1XERGHfYRZzCzcLZ99mnchfb8o9U0kTS-A@mail.gmail.com>
 <87tttpk2kp.fsf@vostro.rath.org> <87r0osjufc.fsf@vostro.rath.org>
In-Reply-To: <87r0osjufc.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Jul 2023 10:52:24 +0200
Message-ID: <CAJfpegu7BtYzPE-NK_t3nFBT3fy2wGyyuJRP=wVGnvZh2oQPBA@mail.gmail.com>
Subject: Re: [fuse-devel] Semantics of fuse_notify_delete()
To:     Miklos Szeredi via fuse-devel <fuse-devel@lists.sourceforge.net>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 28 Jul 2023 at 10:45, Nikolaus Rath <Nikolaus@rath.org> wrote:

> I've pushed an instrumented snapshot to
> https://github.com/s3ql/s3ql/tree/notify_delete_bug. For me, this
> reliably reproduces the problem:
>
> $ python3 setup.py build_cython build_ext --inplace
> $ md bucket
> $ bin/mkfs.s3ql --plain local://bucket
> [...]
> $ bin/mount.s3ql --fg local://bucket mnt &
> [...]
> $ md mnt/test; echo foo > mnt/test/bar
> $ bin/s3qlrm mnt/test
> fuse: writing device: Directory not empty
> ERROR: Failed to submit invalidate_entry request for parent inode 1, name b'test'
> Traceback (most recent call last):
>   File "src/internal.pxi", line 125, in pyfuse3._notify_loop
>   File "src/pyfuse3.pyx", line 915, in pyfuse3.invalidate_entry
> OSError: [Errno 39] fuse_lowlevel_notify_delete returned: Directory not
> empty

Thanks, will try this.

Miklos
