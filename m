Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD99BCEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2019 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHXKCL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Aug 2019 06:02:11 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33649 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfHXKCL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Aug 2019 06:02:11 -0400
Received: by mail-wr1-f52.google.com with SMTP id u16so10783455wrr.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2019 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=algolia.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WYpUeofe5vHaWgvFTlhkq7YwWLvf0aPrJjtylm8BrOE=;
        b=JLU0C3NnMzgfz3n2z0785HY47FBicGDsNkkphNIIASGlDdoNXvSBh5ZH9TIP2xg5PK
         0La39XOovUwY9y0F6r5F/fEQYcIe5wJy5PBLqNU2ph+c4KAUGjW4fznNdVn+hLojB5jr
         ioJC0r0ZzzJNwOCZlWd5vo3PL0rWCufNQn2rc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WYpUeofe5vHaWgvFTlhkq7YwWLvf0aPrJjtylm8BrOE=;
        b=Haa+nilmY/i0nbWEj/LOkv/xYMwe+x/Mo1owmOuOyTz5+O2GsiokNQ5/yX/7MEQfRg
         AHAv0LU8fxpaWbvk362iyftxOCw6Yj1wohqxHuv3zeDsYL1WWSWL6pXAj3EejIX709AQ
         dPP6dopSZNSEBbdb4nHhR0w/yhfTxXU+AJGqqkNAD3ya79FS9q5cyfyjXmSIZO1hzgqc
         TpGfdoy51Ty0SaSxEODxHNyNrRKw/YfVmdr/1IecZR29R+JKTw/lrDOwF1jCXcx7BYOf
         aSg+HE96G1tPKA9TLJptiS5eSzNCAj4NoYiXvkMVRDs7O1aF4SMvWHoJ7EJfJ1D4MyEo
         J8RQ==
X-Gm-Message-State: APjAAAXraMgRtI0ifGoX/KOC0n1tualg8kHZOWxFiYnjcCSuDj3IJnI/
        YYawqpuGN/MY3cbLtL51Rz60tIu5rxJwvvkLLhFdvHi89H4=
X-Google-Smtp-Source: APXvYqxTtsXY0de8u6ZHm1t4glO/Lup3LKHswrhOS+PbdlRZ908womUcv4ewFI4qAdI6cxWXo08DRKnzNEpGHRYA2iQ=
X-Received: by 2002:a5d:5543:: with SMTP id g3mr10497775wrw.166.1566640928980;
 Sat, 24 Aug 2019 03:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAE9vp3JsD1KVqLXnLWpNrAtDSmm6gUa0KC_degOECDsGntvUXw@mail.gmail.com>
In-Reply-To: <CAE9vp3JsD1KVqLXnLWpNrAtDSmm6gUa0KC_degOECDsGntvUXw@mail.gmail.com>
From:   Xavier Roche <xavier.roche@algolia.com>
Date:   Sat, 24 Aug 2019 12:01:58 +0200
Message-ID: <CAE9vp3+SwbbEsXrttvTrw0+Go6CSL8ZrHCE6+zac+7O-dkkFuA@mail.gmail.com>
Subject: Re: Possible FS race condition between vfs_rename and do_linkat (fs/namei.c)
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a small addition:

> But maybe this is something the filesystem can not guarantee at all
> (w.r.t POSIX typically) ?

The POSIX standard does not seem to directly address this case, but my
understanding is that rename() atomicity should guarantee correct
behavior w.r.t rename()/link() concurrent operations:

See IEEE Std 1003.1,

(1) https://pubs.opengroup.org/onlinepubs/009695399/functions/rename.html

"If the link named by the new argument exists, it shall be removed and
old renamed to new. In this case, a link named new shall remain
visible to other processes throughout the renaming operation and refer
either to the file referred to by new or old before the operation
began."

"This rename() function is equivalent for regular files to that
defined by the ISO C standard. Its inclusion here expands that
definition to include actions on directories and specifies behavior
when the new parameter names a file that already exists. That
specification requires that the action of the function be atomic."

(2) https://pubs.opengroup.org/onlinepubs/009695399/functions/link.html
[ENOENT]
    "A component of either path prefix does not exist; the file named
by path1 does not exist; or path1 or path2 points to an empty string."

The only erroneous [ENOENT] case is when the file does not "exist";
but the renaming should guarantee that the file always "exists" ("a
link named new shall remain visible to other processes throughout the
renaming operation and refer either to the file referred to by new or
old before the operation began")

Cheers,

-- 
Xavier Roche
