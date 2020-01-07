Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE2131CB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2020 01:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgAGAQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jan 2020 19:16:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38761 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgAGAQq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jan 2020 19:16:46 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so51980728wrh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2020 16:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGk27tieF5qc3+4BsLtXvy4RIdrTncxHg+KG4kUOS9s=;
        b=m5nCqznlM4JSZCk8W7Cx425R6aY8G01X2cjR/HweAPIu+lsEDl9b5iJKdJslYHErz/
         dXghDYg096xzvAyL+PV03IGKgAEJz3PCZdKlSNYz7b/mwBVjyDQEG0fWiD5YJzRgzARu
         CT4nt5aT6dj6zI1WL63GDxnLIt4036XiK2Ypo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGk27tieF5qc3+4BsLtXvy4RIdrTncxHg+KG4kUOS9s=;
        b=PUq5dg8z8iYcgd+OakzETlggSQckGEvlDxSr5s1QfN4w55sqU/vJFSc+0Zgj8bhSCl
         2E8vtBKKtDd/SD5qVNTYjaR+/0HP2G8gdEPTK+yiaT+j6BxyZgfsfCb3j+o+opP6Ein7
         +WAlSPLBOzrLJzqjIH9exVHGUw8a9kLO7tjKxrYshnN74kAinJoUckSFCbB+DRvACjmm
         AWIDxpLgNTzp0xINCNPSCqGRH/AyeeTvvhq+gUTJW4FLqzO23dsAflYezb3nKGbXKIx3
         pr11EYAY7yDOoUgLAHSDcZt6mg/LMwVL68F5UIadrn7gZftxlt2PTx8H1pxUa5tH9gtK
         HVSg==
X-Gm-Message-State: APjAAAUaAtWvlonYdj7a+7SqE7QQphL077BM4tOel1tw6XcCbMS4PkTL
        PW1TSbxJi2nfl1Qp4a5OjS8oEQ==
X-Google-Smtp-Source: APXvYqwEnlHAHFnlhdcoAURhVkhVhX/fSGgeDovIudqAqXXQpqBFeY9oaowcMHxtXYpvG862TBzKtQ==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr108384665wrt.267.1578356204280;
        Mon, 06 Jan 2020 16:16:44 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2344])
        by smtp.gmail.com with ESMTPSA id a133sm24612835wme.29.2020.01.06.16.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 16:16:43 -0800 (PST)
Date:   Tue, 7 Jan 2020 00:16:43 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-mm@kvack.org, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200107001643.GA485121@chrisdown.name>
References: <cover.1578225806.git.chris@chrisdown.name>
 <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200107001039.GM23195@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner writes:
>It took 15 years for us to be able to essentially deprecate
>inode32 (inode64 is the default behaviour), and we were very happy
>to get that albatross off our necks.  In reality, almost everything
>out there in the world handles 64 bit inodes correctly
>including 32 bit machines and 32bit binaries on 64 bit machines.
>And, IMNSHO, there no excuse these days for 32 bit binaries that
>don't using the *64() syscall variants directly and hence support
>64 bit inodes correctlyi out of the box on all platforms.
>
>I don't think we should be repeating past mistakes by trying to
>cater for broken 32 bit applications on 64 bit machines in this day
>and age.

I'm very glad to hear that. I strongly support moving to 64-bit inums in all 
cases if there is precedent that it's not a compatibility issue, but from the 
comments on my original[0] patch (especially that they strayed from the 
original patches' change to use ino_t directly into slab reuse), I'd been given 
the impression that it was known to be one.

 From my perspective I have no evidence that inode32 is needed other than the 
comment from Jeff above get_next_ino. If that turns out not to be a problem, I 
am more than happy to just wholesale migrate 64-bit inodes per-sb in tmpfs.

0: https://lore.kernel.org/patchwork/patch/1170963/
