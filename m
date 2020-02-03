Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E383E151244
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2020 23:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBCWQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Feb 2020 17:16:02 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36359 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBCWQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:16:01 -0500
Received: by mail-il1-f194.google.com with SMTP id b15so14093636iln.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Feb 2020 14:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N18s231yY+8bRBxz6jlhKscwOcWQ7ObAnQtkJ/vjaq8=;
        b=UT/YLhMNgCkg6m8MJUbzv2/FNS9NWOl8g+UoRsZlKp8VgBY9m8zq+rvatIR9qXvJsA
         784jnT/62MmfoSkYBxWo8Kcm4imJwmk12n7gWzmkKfe4+f0cezZTgPiVZ+ni9glcjJi/
         6pXl0NAwRHduY2KI6cXBzvPE6llyBVYk5dGgofKcIA2HvZhQ5OBlxjPs4zdlYJ9uLLBB
         t8mw+8K1b10SDE2zkOD0sq81zKMKO5GUApEpT4lZ6OzdFFpfhQK67amA62oDy2ty6vVr
         IYS6Hg69b3FUHJpSe+o+khHl4JucLZvOK067pZZC6/p/Orcmyqj3htAzwVE9cUsYkrFG
         PL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N18s231yY+8bRBxz6jlhKscwOcWQ7ObAnQtkJ/vjaq8=;
        b=aEFQHG5TimnjD2jnPXalTnQzYiS104CyuqvkGhuLcq562SS24ug9ZyTMm2cQzTxfCV
         4s5HuV59vlFE/NxESiBWrBmJjIuD1h64RjIQpdclfxaOfPtCdwLrnfzxfpc6Lgy+dKan
         txsVtvwWTfoNU1hiFheV3zsyHqRn12gQaMt182YQHxzhLMuXBKWV9fGR0Qyy6hXSILjq
         tG7DCs7MaY3cF4GdVL/9ELd07oDPGXk5rwwws8uBgK58iqvAk0XbXLkNkuckfWPuzno4
         tlc59mOt8Gmqh9qNMDz9sTyjqw1Wh8ltiaExM/NwXcrBcS/V2frweNJAKu3w1bqCDjrl
         QwaA==
X-Gm-Message-State: APjAAAUlg8Q5xijfI7RYr5CIOTDI4PdpX1vPobqcp0D1LjzrkewP7kQE
        NFOyiAZZVGbCQA6iEWpmQtfF1A==
X-Google-Smtp-Source: APXvYqyj2dne19ab1rjfalZGoyo95xeVJVbOUcISZLU0CPvZuSl4lzRIXlRCEKqGWYzuYS/FRUGnUA==
X-Received: by 2002:a92:4a0a:: with SMTP id m10mr17469494ilf.84.1580768159049;
        Mon, 03 Feb 2020 14:15:59 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id a21sm6017650ioh.29.2020.02.03.14.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 14:15:58 -0800 (PST)
Date:   Mon, 3 Feb 2020 15:15:56 -0700
From:   Ross Zwisler <zwisler@google.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org,
        Mattias Nissler <mnissler@chromium.org>,
        Benjamin Gordon <bmgordon@google.com>,
        Raul Rangel <rrangel@google.com>,
        Micah Morton <mortonm@google.com>,
        Dmitry Torokhov <dtor@google.com>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4] Add a "nosymfollow" mount option.
Message-ID: <20200203221556.GA210383@google.com>
References: <20200131002750.257358-1-zwisler@google.com>
 <20200131004558.GA6699@bombadil.infradead.org>
 <20200131015134.5ovxakcavk2x4diz@yavin.dot.cyphar.com>
 <20200131212021.GA108613@google.com>
 <20200201062744.fehlhq3jtetfcxuw@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201062744.fehlhq3jtetfcxuw@yavin.dot.cyphar.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 01, 2020 at 05:27:44PM +1100, Aleksa Sarai wrote:
> On 2020-01-31, Ross Zwisler <zwisler@google.com> wrote:
<>
> > On Fri, Jan 31, 2020 at 12:51:34PM +1100, Aleksa Sarai wrote:
> > If noxdev would involve a pathname traversal to make sure you don't ever leave
> > mounts with noxdev set, I think this could potentially cover the use cases I'm
> > worried about.  This would restrict symlink traversal to files within the same
> > filesystem, and would restrict traversal to both normal and bind mounts from
> > within the restricted filesystem, correct?
> 
> Yes, but it would have to block all mountpoint crossings including
> bind-mounts, because the obvious way of checking for mountpoint
> crossings (vfsmount comparisons) results in bind-mounts being seen as
> different mounts. This is how LOOKUP_NO_XDEV works. Would this be a
> show-stopped for ChromeOS?
>
> I personally find "noxdev" to be a semantically clearer statement of
> intention ("I don't want any lookup that reaches this mount-point to
> leave") than "nosymfollow" (though to be fair, this is closer in
> semantics to the other "no*" mount flags). But after looking at [1] and
> thinking about it for a bit, I don't really have a problem with either
> solution.

For ChromeOS we want to protect data both on user-provided filesystems (i.e.
USB attached drives and the like) as well as on our "stateful" partition.  

The noxdev mount option would resolve our concerns for user-provided
filesystems, but I don't think that we would be able to use it for stateful
because symlinks on stateful that point elsewhere within stable are still a
security risk.  There is more explanation on why this is the case in [1].
Thank you for linking to that, by the way.

I think our security concerns around both use cases, user-provided filesystems
and the stateful partition, can be resolved in ChromeOS with the nosymfollow
mount flag.  Based on that, my current preference is for the 'nosymfollow'
mount flag.

> The only problem is that "noxdev" would probably need to be settable on
> bind-mounts, and from [2] it looks like the new mount API struggles with
> configuring bind-mounts.
> 
> > > However, the underlying argument for "noxdev" was that you could use it
> > > to constrain something like "tar -xf" inside a mountpoint (which could
> > > -- in principle -- be a bind-mount). I'm not so sure that "nosymfollow"
> > > has similar "obviously useful" applications (though I'd be happy to be
> > > proven wrong).
> > 
> > In ChromeOS we use the LSM referenced in my patch to provide a blanket
> > enforcement that symlinks aren't traversed at all on user-supplied
> > filesystems, which are considered untrusted.  I'd essentially like to build on
> > the protections offered by LOOKUP_NO_SYMLINKS and extend that protection to
> > all accesses to user-supplied filesystems.
> 
> Yeah, after writing my mail I took a look at [1] and I agree that having
> a solution which helps older programs would be helpful. With openat2 and
> libpathrs[3] I'm hoping to lead the charge on a "rewrite userspace"
> effort, but waiting around for that to be complete probably isn't a
> workable solution. ;)

Sounds great.  Here, I'll merge the nosymfollow patch forward with the current
ToT which includes your openat2(2) changes, and we can go from there.

Thanks for all the feedback.

> [1]: https://sites.google.com/a/chromium.org/dev/chromium-os/chromiumos-design-docs/hardening-against-malicious-stateful-data#TOC-Restricting-symlink-traversal
> [2]: https://lwn.net/Articles/809125/
> [3]: https://github.com/openSUSE/libpathrs
