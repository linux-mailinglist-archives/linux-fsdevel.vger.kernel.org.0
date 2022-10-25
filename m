Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADCD60D49B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 21:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiJYTVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJYTU7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:20:59 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F758046
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 12:20:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id w10so3192401qvr.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XRU4yx13ey+qiqkDAd9/g8Rgj3Vasx9oyOtn3EmTBc8=;
        b=gKZF6zvogvMldm+oQGqXDVY4bW6AIdqPdY5Yn4DwG+Xuuy83aD4dQS3reVIM3aM9gd
         z1zx725HmKJKsQaeO7fAqhzBIHjjYcXHRF5TG4M1rjQN9A/mQe2zt+Cm4FO6dfErJZw0
         3AGUFX7DSSp8CLnQalePZ98bsgMtwgsL7+Y8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRU4yx13ey+qiqkDAd9/g8Rgj3Vasx9oyOtn3EmTBc8=;
        b=7f6FrVuFacxsPrZRDocpG7MjwluqGnjwOaa+B3TR9mfrladYnBj1dBds8JQP4o73pY
         u4QXao8FYnormjxJsEUnXiMLg2lopbLTTAG5xjX98VsopV0M+TzWQK0dI9BRzgE6kzsy
         DXLuPbkh9E2bDzyq5DMGWlgqsngLMtUy2cDd7MxV2Nlt23AMZAoJXOS+eL7q/gNIb8f2
         nAryQ4CkVLa3/lWhh+CY9TIKZqFgdxITmqYna+D6o5hwYU3CrxpcXUYhm17nsCt+LU+A
         crzs6tXsO3s6a6iBYBSKh2fKFS/j+65WNRQm+fC5QzRXGf6BdWkQol61z84BdOPsiRtt
         YDlg==
X-Gm-Message-State: ACrzQf37l/3ctTuCvOggLrKHEAwcQoGXh5WpUk2Gh7gjfYVCKUIwZQGy
        OycrX0YcEEweHbA9Xl0hyqifUlnco1qVzA==
X-Google-Smtp-Source: AMsMyM7Tq7eJPupYXycYkglaHwrnqfJPvxj9qPGrl2HvAOzRT1HLFklzBb2LnBl49a5UM1MJ1TPd7A==
X-Received: by 2002:a0c:f00f:0:b0:4bb:6167:d338 with SMTP id z15-20020a0cf00f000000b004bb6167d338mr14632936qvk.11.1666725656734;
        Tue, 25 Oct 2022 12:20:56 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id dt27-20020a05620a479b00b006cdd0939ffbsm2537246qkb.86.2022.10.25.12.20.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:20:56 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 185so5421473ybc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 12:20:56 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr34937084ybb.184.1666725655766; Tue, 25
 Oct 2022 12:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster> <YjSTq4roN/LJ7Xsy@bfoster> <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
 <6356f1f74678c_141929415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <CAHk-=wj7mRYuictrQjT+sacgj9_GrmRetE1KLTiz-nOk-H4DPQ@mail.gmail.com> <Y1g20GUTu6mOq+CJ@casper.infradead.org>
In-Reply-To: <Y1g20GUTu6mOq+CJ@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Oct 2022 12:20:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wggaWpSRkJTG0Y78ne8MVOjNCuxf73HahrRefj=MoQTsw@mail.gmail.com>
Message-ID: <CAHk-=wggaWpSRkJTG0Y78ne8MVOjNCuxf73HahrRefj=MoQTsw@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        jesus.a.arechiga.lopez@intel.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 12:19 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I've been carrying a pair of patches in my tree to rip out the wait
> bookmarks since March, waiting for me to write a userspace testcase to
> reproduce the problem against v4.13 and then check it no longer does so
> against v5.0.  Unfortunately, that hasn't happened.  I'm happy to add
> Arechiga's Tested-by, and submit them to Andrew and have him bring them
> into v6.2, since this doesn't seem urgent?

Ack, sounds good to me.

                  Linus
