Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7338B14F3AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 22:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAaVUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 16:20:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:42698 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgAaVUZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:20:25 -0500
Received: by mail-il1-f195.google.com with SMTP id x2so7462608ila.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 13:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XsXkK20jPtEnVwhNsitvdugBIKWgAwClWv8+OTKRTE8=;
        b=d+aziJ/+nTTI2qr/oUXg4+d0CV8BTwtqUMq7m70yyGwOM3tfD/4v7qkOCrXHAcAog+
         /G+X04d12UphxRK0tSEFedAsTfYtxywrhzf2N51wmJdHbNgffU+Uwi0ChrYr/bQBnbzJ
         6TrZ+uoA9pVAPEGm40C9HpnQUlFmb+mpZLzNj4cNCsPK1EubqVS38Nq7wr6va4+k0eUO
         i0F5K/O8r7xlzLXnvA0BNcY74cZ2C9ZdX/WozEPn442ZzdM0FHMSGuqTDYVTTSM3wCyn
         Jv5V32ArkeN3hmNp5BZQftPGCdTq2W8JJKUgShEwEyOeHjnGIdGZRK+5sF7uwmRzx4st
         J4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XsXkK20jPtEnVwhNsitvdugBIKWgAwClWv8+OTKRTE8=;
        b=h+XJP1fNtugsfv5LL+uRwpArHiQ6BIcwm9ZkV4m3qB63wlI6/g9lcLSmvT9W9sbCJq
         4FMpK3lvey/7NxGedBTmEnA5AcRzOjDSJd9cLInu1YIGmHKAfSIpUKgy3puVD3eMa+Rt
         JYA3Eh6x4C2pItSk5+eW6DJIDEmjZ6GZoYggyNsQzCeBNFNLHAzf0N7y+BmkB9x/8T5T
         5KwJTSNNMg5od9dG8qYeWLhVOZOERShrxZwpePKLsegPUwSbxKqjLulKAfC50thktBpE
         KDWcSy2LZQzFVsR0d5vHrruvhy8xGvdVGSiCPFCnifjhe/1mJFUapyo5ih1gd8LxgbFJ
         xA/g==
X-Gm-Message-State: APjAAAXKOHFxmWsruxFmvlqvskdVH3o7z2L30U+5mOV7wYVL2aV6OZZy
        JRv7VF6fNhCRsNH9iMeOVwmo+A==
X-Google-Smtp-Source: APXvYqxanQz6LFC/sb5ilIL2kTGGXNfMzO++BYBtgZ4z3pj8S8iAviWR/mgH70n4xVanLgijw/kVpw==
X-Received: by 2002:a92:9f4e:: with SMTP id u75mr10952412ili.116.1580505624177;
        Fri, 31 Jan 2020 13:20:24 -0800 (PST)
Received: from google.com ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id t19sm2704536ioc.38.2020.01.31.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 13:20:23 -0800 (PST)
Date:   Fri, 31 Jan 2020 14:20:21 -0700
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
Message-ID: <20200131212021.GA108613@google.com>
References: <20200131002750.257358-1-zwisler@google.com>
 <20200131004558.GA6699@bombadil.infradead.org>
 <20200131015134.5ovxakcavk2x4diz@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131015134.5ovxakcavk2x4diz@yavin.dot.cyphar.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:51:34PM +1100, Aleksa Sarai wrote:
> On 2020-01-30, Matthew Wilcox <willy@infradead.org> wrote:
> > On Thu, Jan 30, 2020 at 05:27:50PM -0700, Ross Zwisler wrote:
> > > For mounts that have the new "nosymfollow" option, don't follow
> > > symlinks when resolving paths. The new option is similar in spirit to
> > > the existing "nodev", "noexec", and "nosuid" options. Various BSD
> > > variants have been supporting the "nosymfollow" mount option for a
> > > long time with equivalent implementations.
> > > 
> > > Note that symlinks may still be created on file systems mounted with
> > > the "nosymfollow" option present. readlink() remains functional, so
> > > user space code that is aware of symlinks can still choose to follow
> > > them explicitly.
> > > 
> > > Setting the "nosymfollow" mount option helps prevent privileged
> > > writers from modifying files unintentionally in case there is an
> > > unexpected link along the accessed path. The "nosymfollow" option is
> > > thus useful as a defensive measure for systems that need to deal with
> > > untrusted file systems in privileged contexts.
> > 
> > The openat2 series was just merged yesterday which includes a
> > LOOKUP_NO_SYMLINKS option.  Is this enough for your needs, or do you
> > need the mount option?
> 
> I have discussed a theoretical "noxdev" mount option (which is
> effectively LOOKUP_NO_XDEV) with Howells (added to Cc) in the past, and
> the main argument for having a mount option is that you can apply the
> protection to older programs without having to rewrite them to use
> openat2(2).

Ah, yep, this is exactly what we're trying to achieve with the "nosymfollow"
mount option: protect existing programs from malicious filesystems without
having to modify those programs.

The types of attacks we are concerned about are pretty well summarized in this
LWN article from over a decade ago:

https://lwn.net/Articles/250468/

And searching around (I just Googled "symlink exploit") it's pretty easy to
find related security blogs and CVEs.

The noxdev mount option seems interesting, bug I don't fully understand yet
how it would work.  With the openat2() syscall it's clear which things need to
be part of the same mount: the dfd (or CWD in the case of AT_FDCWD) and the
filename you're opening.  How would this work for the noxdev mount option and
the legacy open(2) syscall, for example?  Would you just always compare
'pathname' with the current working directory?  Examine 'pathname' and make
sure that if any filesystems in that path have 'noxdev' set, you never
traverse out of them?  Something else?

If noxdev would involve a pathname traversal to make sure you don't ever leave
mounts with noxdev set, I think this could potentially cover the use cases I'm
worried about.  This would restrict symlink traversal to files within the same
filesystem, and would restrict traversal to both normal and bind mounts from
within the restricted filesystem, correct?

> However, the underlying argument for "noxdev" was that you could use it
> to constrain something like "tar -xf" inside a mountpoint (which could
> -- in principle -- be a bind-mount). I'm not so sure that "nosymfollow"
> has similar "obviously useful" applications (though I'd be happy to be
> proven wrong).

In ChromeOS we use the LSM referenced in my patch to provide a blanket
enforcement that symlinks aren't traversed at all on user-supplied
filesystems, which are considered untrusted.  I'd essentially like to build on
the protections offered by LOOKUP_NO_SYMLINKS and extend that protection to
all accesses to user-supplied filesystems.

> If FreeBSD also has "nosymfollow", are there many applications where it
> is used over O_BENEATH (and how many would be serviced by
> LOOKUP_NO_SYMLINKS)?

Sorry, I don't have any good info on whether nosymfollow and O_BENEATH are
commonly used together in FreeBSD.
