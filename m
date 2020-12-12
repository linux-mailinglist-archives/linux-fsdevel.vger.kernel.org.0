Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C1A2D8A24
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 22:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407964AbgLLVZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 16:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLLVZn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 16:25:43 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09252C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 13:25:02 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q22so9449807pfk.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 13:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mSfGh5SI6dkFgS4zz7vD/f6HXI5N0cRbniGloQY8mjM=;
        b=G9UbvwJpj6LUDHCjanbL6YnUv8gi6L48x5CazUuc16MXD7yJ8K2g2W3ZfYhLrI5k0Z
         GyiTtUkgEWl/mPX+Of+H6TTn+urjBwwHoSqVpR9yLqWA6txAPwh/qc6E7luHDblLplPJ
         TJsn7DHrAi/MZWEySapbZBeH2qQPFTwT/hbDqDGyCwMf8WD5PgtMUHuPflEhhSe3ZvCU
         d3yYHeiOYICQSMJ7m+TT1HoyxEZfNa9j+4AcchVGLiugtbw2wF7Pd5WXnMD4Vkkmwpp2
         5i7vDdynDZ1cM9PImmnSt0wUuvwYp2jfiZzSEhdUUVOkT35nAPNa/+8i48E0jJiVlh34
         KTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mSfGh5SI6dkFgS4zz7vD/f6HXI5N0cRbniGloQY8mjM=;
        b=BtEwX1C67ovjZ5WjjpitxgXjEmJ0a9eCtb+AnrrOwc+HckpsEgIaOZensuZy5HD0+R
         TgQjxkBa4NPf9Z9TGfVM+QUU9lpaKxuettjZbJdiB2pzH3nuDfNh3PvRQQv0tlsouRoI
         iYnbgSFzvAAhrZXC6Fx39LJvtyjLAKUl60A3NUrFhuZSAGbzy32UPvpAvo+1IbqD++sT
         93Lp2ITuM+GLdfYLW1IzpKFGTXNtNhcE2lzNOeaHLmrmq0ZD91wLRoZLKhEPFcjTGoBO
         SBHi4S7dkXoj17hqDHKVyWuZsT+0rYzpA+ysEAeuQtOh4XiaYF8MHkkoNOeHA15NLyy3
         Z6TA==
X-Gm-Message-State: AOAM531SUxjSDmYzwhRnP7lv82kHoxhIRaoMre3HoIeyLg/sQbxw66ud
        1K7VGtWPTSsB+jFka6l5rZ0PEQ==
X-Google-Smtp-Source: ABdhPJxVYMStAJIAG5pJKbLkbHAXSIlSLw+1hds3zUIT82g+63JtOh/mdzYtCkl7uD6Dcv3QTP2Bqw==
X-Received: by 2002:a05:6a00:2259:b029:19d:cfba:5614 with SMTP id i25-20020a056a002259b029019dcfba5614mr17298191pfu.35.1607808302324;
        Sat, 12 Dec 2020 13:25:02 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a17sm13439822pgw.80.2020.12.12.13.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 13:25:01 -0800 (PST)
Subject: Re: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file
 open
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20201212165105.902688-1-axboe@kernel.dk>
 <20201212165105.902688-5-axboe@kernel.dk>
 <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8c4e7013-2929-82ed-06f6-020a19b4fb3d@kernel.dk>
Date:   Sat, 12 Dec 2020 14:25:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiA1+MuCLM0jRrY4ajA0wk3bs44n-iskZDv_zXmouk_EA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/12/20 11:57 AM, Linus Torvalds wrote:
> On Sat, Dec 12, 2020 at 8:51 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> We handle it for the path resolution itself, but we should also factor
>> it in for open_last_lookups() and tmpfile open.
> 
> So I think this one is fundamentally wrong, for two reasons.
> 
> One is that "nonblock" shouldn't necessarily mean "take no locks at
> all". That directory inode lock is very very different from "go down
> to the filesystem to do IO". No other NONBLOCK thing has ever been "no
> locks at all", they have all been about possibly long-term blocking.

Do we ever do long term IO _while_ holding the direcoty inode lock? If
we don't, then we can probably just ignore that side alltogether.

> The other this is that the mnt_want_write() check really smells no
> different at all from any of the "some ->open functions might block".
> Which you don't handle, and which again is entirely different from the
> pathname resolution itself blocking.
> 
> So I don't think either of these cases are about LOOKUP_NONBLOCK, the
> same way they aren't about LOOKUP_RCU.
> 
> The  mnt_want_write() in particular is much more about the kinds of
> things we already check for in do_open().
> 
> In fact, looking at this patch, I think mnt_want_write() itself is
> actually conceptually buggy, although it doesn't really matter: think
> about device nodes etc. Opening a device node for writing doesn't
> write to the filesystem that the device node is on.
> 
> Why does that code care about O_WRONLY | O_RDWR? That has *nothing* to
> do with the open() wanting to write to the filesystem. We don't even
> hold that lock after the open - we'll always drop it even for a
> successful open.
> 
> Only O_CREAT | O_TRUNC should matter, since those are the ones that
> cause writes as part of the *open*.
> 
> Again - I don't think that this is really a problem. I mention it more
> as a "this shows how the code is _conceptually_ wrong", and how it's
> not really about the pathname resolution any more.
> 
> In fact, I think that how we pass on that "got_write" to lookup_open()
> is just another sign of how we do that mnt_want_write() in the wrong
> place and at trhe wrong level. We shouldn't have been doing that
> mnt_want_write() for writable oipens (that's a different thing), and
> looking at lookup_open(), I think we should have waited with doing it
> at all until we've checked if we even need it (ie O_CREAT on a file
> that already exists does *not* need the mnt_want_write() at all, and
> we'll see that when we get to that
> 
>         /* Negative dentry, just create the file */
>         if (!dentry->d_inode && (open_flag & O_CREAT)) {
> 
> thing.
> 
> So I think this patch actually shows that we do things wrong in this
> area, and I think the kinds of things it does are questionable as a
> result. In particular, I'm not convinced that the directory semaphore
> thing should be tied to LOOKUP_NONBLOCK, and I don't think the
> mnt_want_write() logic is right at all.
> 
> The first one would be fixed by a separate flag.
> 
> The second one I think is more about "we are doing mnt_want_write() at
> the wrong point, and if we move mnt_want_write() to the right place
> we'd just fail it explicitly for the LOOKUP_NONBLOCK case" - the same
> way a truncate should just be an explicit fail, not a "trylock"
> failure.

I'm going to let Al comment on the mnt_want_write() logic. It did feel
iffy to me, and the error handling (and passing of it) around makes it
hard to reason about. Would likely make this change more straight
forward if we sort out that first.

I do agree that we should keep the two things separate - and potentially
just have the RESOLVE_NONBLOCK be RESOLVE_CACHE (or something like that)
and not deal with the locking / want write side of things at all. For
io_uring, we really do want to ensure that we don't stall the submission
pipeline by potentially being stuck on the directory lock or waiting for
a frozen file system.

And I don't think we can get around having two flags at that point -
probably by renaming the initial LOOKUP_NONBLOCK to LOOKUP_CACHE, and by
having a LOOKUP_NONBLOCK which has a slightly wider scope.

> I also think we need to deal with the O_NONBLOCK kind of situation at
> the actual ->open() time (ie the whole "oh, NFS wants to revalidate
> caches due to open/close consistency, named pipes want to wait for
> pairing, device nodes want to wait for device". Again, I think that's
> separate from LOOKUP_NONBLOCK, though.

Agree, that's still not done in this patch. I did think about it, and
the only potential idea I had around that was to wrap the actual open in
setting/clearing O_NDELAY/O_NONBLOCK around the open. Which _should_
work as long as it happens before fd_install() is done, but doesn't feel
that architecturally clean.

-- 
Jens Axboe

