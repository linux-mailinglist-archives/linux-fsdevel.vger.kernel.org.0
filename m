Return-Path: <linux-fsdevel+bounces-699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B464C7CE78A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E414F1C20D30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B622B450CC;
	Wed, 18 Oct 2023 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fApi6H5s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1142BE3
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 19:18:43 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFF9118
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 12:18:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c1c66876aso1169348066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 12:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697656721; x=1698261521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ne6XlZkvrqbgYXFwibkwS6QVtHojWCVkTUV60CnBXA=;
        b=fApi6H5sdtGja+gvPdUxBBI3kiA0JGH0L3xmIXiiceV5Ts+vQL0HWpKRwl3msjRQ7/
         oYGSBbcD0QRar+rHLq4mQ4IwTF/sL9VpLq8l726AE6pPLeTS79zck18jRfx1zrywG2JC
         2NJLwYsStpZ5MHss5uuDplpxA08zv/sn9UaVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656721; x=1698261521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Ne6XlZkvrqbgYXFwibkwS6QVtHojWCVkTUV60CnBXA=;
        b=mQJexQb/OlmghocbbFsGzCWd1AIRW/XV/XSNkE54l48jA5pVXOvzGF8pP5sfnQNXYy
         CLhRM9EIkTYJ3pPkt1h+pdPHwax3JkrqnteQQ/kVCHWq8x5GmUIPRbhVzoC3i3AigoAT
         FvBAX+IOnMzth+dtKJ7BzOgvPjikg660hVdPHXsWx53CRido64bqNKPt2IWED3v+l2LZ
         8xyzX8WrB03YmsphTZCZjG9mEiaJmrsuEiOb9lKz4DFT8XepbDWJMjUBsvUJZr+Hgqf3
         urx910T5XjJSAQHyvcMyc+aUDYYvv4ttt44YQ7AyGwZLSWLn2zJmoZd0W6y1gQXEA5pM
         i+xQ==
X-Gm-Message-State: AOJu0YzjcH9L81KgcZH7UvlSs/VUOQyw7JrgDRQaLG6Ac1wmtGFEpi/W
	TPPyd7iu8lodee/NaMe81S6oR1LT7+PNgZLHLlWpMFCn
X-Google-Smtp-Source: AGHT+IH0bFdOT8K2a0qO7USxWjIZUq6KKwfKT/44usIYMgXMp/pkpbpf8wrq2LiwV4cWu2Ut7eORAw==
X-Received: by 2002:a17:907:983:b0:9c4:344e:b48c with SMTP id bf3-20020a170907098300b009c4344eb48cmr182039ejc.36.1697656720798;
        Wed, 18 Oct 2023 12:18:40 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id gh6-20020a170906e08600b00977cad140a8sm2212578ejb.218.2023.10.18.12.18.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:18:40 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso1172841866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 12:18:40 -0700 (PDT)
X-Received: by 2002:a17:906:99c4:b0:9bd:a662:c066 with SMTP id
 s4-20020a17090699c400b009bda662c066mr149569ejn.76.1697656719721; Wed, 18 Oct
 2023 12:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
In-Reply-To: <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Oct 2023 12:18:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
Message-ID: <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct 2023 at 10:41, Jeff Layton <jlayton@kernel.org> wrote:
>
> One way to prevent this is to ensure that when we stamp a file with a
> fine-grained timestamp, that we use that value to establish a floor for
> any later timestamp update.

I'm very leery of this.

I don't like how it's using a global time - and a global fine-grained
offset - when different filesystems will very naturally have different
granularities. I also don't like how it's no using that global lock.

Yes, yes, since the use of this all is then gated by the 'is_mgtime()'
thing, any filesystem with big granularities will presumably never set
FS_MGTIME in the first time, and that hides the worst pointless cases.
But it still feels iffy to me.

Also, the whole current_ctime() logic seems wrong. Later (in 4/9), you do this:

 static struct timespec64 current_ctime(struct inode *inode)
 {
        if (is_mgtime(inode))
                return current_mgtime(inode);

and current_mgtime() does

        if (nsec & I_CTIME_QUERIED) {
                ktime_get_real_ts64(&now);
                return timestamp_truncate(now, inode);
        }

so once the code has set I_CTIME_QUERIED, it will now use the
expensive fine-grained time - even when it makes no sense.

As far as I can tell, there is *never* a reason to get the
fine-grained time if the old inode ctime is already sufficiently far
away.

IOW, my gut feel is that all this logic should always not only be
guarded by FS_MGTIME (like you do seem to do), *and* by "has anybody
even queried this time" - it should *also* always be guarded by "if I
get the coarse-grained time, is that sufficient?"

So I think the current_ctime() logic should be something along the lines of

    static struct timespec64 current_ctime(struct inode *inode)
    {
        struct timespec64 ts64 = current_time(inode);
        unsigned long old_ctime_sec = inode->i_ctime_sec;
        unsigned int old_ctime_nsec = inode->i_ctime_nsec;

        if (ts64.tv_sec != old_ctime_sec)
                return ts64;

        /*
         * No need to check is_mgtime(inode) - the I_CTIME_QUERIED
         * flag is only set for mgtime filesystems
         */
        if (!(old_ctime_nsec & I_CTIME_QUERIED))
                return ts64;
        old_ctime_nsec &= ~I_CTIME_QUERIED;
        if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
                return ts64;

        /* Ok, only *now* do we do a finegrained value */
        ktime_get_real_ts64(&ts64);
        return timestamp_truncate(ts64);
    }

or whatever. Make it *very* clear that the finegrained timestamp is
the absolute last option, after we have checked that the regular one
isn't possible.

I dunno.

            Linus

