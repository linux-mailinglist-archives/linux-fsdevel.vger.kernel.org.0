Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A35725A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 21:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiGLTcf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiGLTcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:32:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7A2E304D
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:08:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sz17so15996611ejc.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FuyFEs9HlHC7whV9ji2XrH6o4AOh+NDEays0iOB0Kdk=;
        b=A/l+jbKw6rvMs2M1DLdyyIO7Cv6uZ6X/1e9Aeoz8bxjlSfOs/y+ZWWPoTb2Rk/ki2X
         8ZsCo1JRDqBlLZeqPsP9v5Gv9cDlCg5Na9umdjDywlioKUpdD63HpA8RBJog89v+iVdR
         JK9Hs/gBn0WoAMog37CuQF8d/ZO6jlxguOerQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FuyFEs9HlHC7whV9ji2XrH6o4AOh+NDEays0iOB0Kdk=;
        b=nz85Pj9jVYG6VW4bfndDy/5GMJzbhZ/ZP0Iu9yrZoKIDp7z3GsiTTthvpRsItIRkWW
         71VVK1ME+h55K2ckGxcew6BSO1yhaERhD6uEj+WZ7r4d01OZDdqhpMyQmftiFi3ZCl/f
         RakCyOXBXWk0xZfTmhd1eTTgKu6vWgtMDXoRtNcw+jlC7F5Amk4V8hTWV/1I0PZu57zY
         JeFQ3hp/sqZ55vI8I5LhhW7ZqD768AGO7ePprTFiTEgxPztqbTs1rl1IlXck3ig+0g0f
         cJnAoILBHpMODct+TPsHjKlyB1SEmPSCuln4JtWVIc8UqQyZZ6y3yCWjgqBxcsWdVCWY
         KAZw==
X-Gm-Message-State: AJIora+sMvUN/v/ZvFtArAAQRSXdDNk0yFIiTx/d49U5ct1ikYJ+rRZA
        v/vDDhbo93z/V7xZhO4z1ZMpqatdY/16twqXo3g=
X-Google-Smtp-Source: AGRyM1tRWY7BWk74u1ukmJlK/TtXqqpoqCWp9QENJNaeUIjuiZopI0YujtU/HkUKe1FWEgQW7j4VZw==
X-Received: by 2002:a17:906:cc5a:b0:72b:1459:6faa with SMTP id mm26-20020a170906cc5a00b0072b14596faamr26192542ejb.221.1657652883328;
        Tue, 12 Jul 2022 12:08:03 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b0072b51fb36f7sm2682963eja.196.2022.07.12.12.08.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 12:08:02 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so5372283wmb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 12:08:02 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr5462190wmq.8.1657652882375; Tue, 12 Jul
 2022 12:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com> <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
In-Reply-To: <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 12:07:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
Message-ID: <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> > Any permission checks done at IO time are basically always buggy:
> > things may have changed since the 'open()', and those changes
> > explicitly should *not* matter for the IO. That's really fundamentally
> > how UNIX file permissions work.
>
> I don't think we should go this far, after all the normal
> write()/read() syscalls do the permission checking each time as well,

No, they really don't.

The permission check is ONLY DONE AT OPEN TIME.

Really. Go look.

Anything else is a bug. If you open a file, and then change the
permissions of the file (or the ownership, or whatever) afterwards,
the open file descriptor is still supposed to be readable or writable.

Doing IO time permission checks is not only wrong, it's ACTIVELY
BUGGY, and is a fairly common source of security problems (ie passing
a file descriptor off to a suid binary, and then using the suid
permissions to make changes that the original opener didn't have the
rights to do).

So if you do permission checks at read/write time, you are a buggy
mess.  It really is that simple.

This is why read and write check FMODE_READ and FMODE_WRITE. That's
the *open* time check.

The fact that dedupe does that inode_permission() check at IO time
really looks completely bogus and buggy.

                 Linus
