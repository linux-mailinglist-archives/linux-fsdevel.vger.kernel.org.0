Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E7DF5A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 21:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfJUTEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 15:04:22 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45328 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbfJUTEW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:04:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1so8348974pgj.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RCgIMg5B7NG+Cw/Rb7IO9nhjQYm6UV4lzQvw7n5xHqU=;
        b=Ra3XhPS3uMm0QVbDm/niTZdYXUFflJqmi9e2bBR+O4IZOSajDTAVuk56dQSJGaxKb+
         WvNR1ZLlp6OBYi6fahI/4bkbpzbSPFSLUK6lk9pgS0K9bbwXN3EcQ0/z1OCpc0M4FWrG
         UvQbyOnhB9ZsrRO5u3JHvf4caUdHZe4COVcIlSlN91ghI0stdQCskLzw0Ebp0K4gcHoB
         HtvonIUvwhpOiQ1hqmew2CWpBw8vOrc0FFxjKWHpeG1g1soXr5ZqUaOKy9Ow3qsR8kPy
         tCt7r1cSlMAfx4gpZRSdl/pOB5WUkSaxUOqUhrylSmFz/NqCHDSuK9ndzgDMmmspE3iK
         jlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RCgIMg5B7NG+Cw/Rb7IO9nhjQYm6UV4lzQvw7n5xHqU=;
        b=r+5+be2sHyzvCjUR30BytPc20pEzA7R+nHk1VH8+b4EM+7Na15Ku9uubjCrQZXBzvb
         /Kx4zZzNtMYfPPYwfX+gW4cVUI21QVFqxIFRoz1P7xQjd83LzgslsiQil0qpqUmnr+xj
         N7FF6BCCeQOOVv32rxb6V5w5pxq6BR0fo183gVxL2Kn+HjTIqHb9ifieGBqgzuuQehj7
         bc35oWs3JN/b5yzuN94TVhVsyVSWOOmaOoZ/e2gb90Nk52N+d92KKw79yUELa1g4cPGE
         DTrMS5kOFDR8jVbHhX0v00xqhaCZJQcIHtg0cS0yVNevfB9XWeOF7KOktdCK91w8TgHi
         ITzA==
X-Gm-Message-State: APjAAAViTyfZqEdwf+yBlHpTnEvEEWo0gsZGp/heNAsvLIiH5rwGfBN1
        3FeTjd61cC+7lYsprMBny0jUzA==
X-Google-Smtp-Source: APXvYqx9Q5BgYsIJhahfX8S3sG0SJmsHBx5r57qU5LVeawSsDUpTegmLeGq3y6Y+9d0Yuqzc3G7yjQ==
X-Received: by 2002:a17:90a:e652:: with SMTP id ep18mr31730566pjb.72.1571684659833;
        Mon, 21 Oct 2019 12:04:19 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::3:4637])
        by smtp.gmail.com with ESMTPSA id k9sm15784214pfk.72.2019.10.21.12.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:04:19 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:04:18 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 0/5] fs: interface for directly reading/writing
 compressed data
Message-ID: <20191021190418.GC81648@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <cover.1571164762.git.osandov@fb.com>
 <20191020230501.GA8080@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191020230501.GA8080@dread.disaster.area>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:05:01AM +1100, Dave Chinner wrote:
> On Tue, Oct 15, 2019 at 11:42:38AM -0700, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Hello,
> > 
> > This series adds an API for reading compressed data on a filesystem
> > without decompressing it as well as support for writing compressed data
> > directly to the filesystem. It is based on my previous series which
> > added a Btrfs-specific ioctl [1], but it is now an extension to
> > preadv2()/pwritev2() as suggested by Dave Chinner [2]. I've included a
> > man page patch describing the API in detail. Test cases and examples
> > programs are available [3].
> > 
> > The use case that I have in mind is Btrfs send/receive: currently, when
> > sending data from one compressed filesystem to another, the sending side
> > decompresses the data and the receiving side recompresses it before
> > writing it out. This is wasteful and can be avoided if we can just send
> > and write compressed extents. The send part will be implemented in a
> > separate series, as this API can stand alone.
> > 
> > Patches 1 and 2 add the VFS support. Patch 3 is a Btrfs prep patch.
> > Patch 4 implements encoded reads for Btrfs, and patch 5 implements
> > encoded writes.
> > 
> > Changes from v1 [4]:
> > 
> > - Encoded reads are now also implemented.
> > - The encoded_iov structure now includes metadata for referring to a
> >   subset of decoded data. This is required to handle certain cases where
> >   a compressed extent is truncated, hole punched, or otherwise sliced up
> >   and Btrfs chooses to reflect this in metadata instead of decompressing
> >   the whole extent and rewriting the pieces. We call these "bookend
> >   extents" in Btrfs, but any filesystem supporting transparent encoding
> >   is likely to have a similar concept.
> 
> Where's the in-kernel documentation for this API? You're encoding a
> specific set of behaviours into the user API, so this needs a whole
> heap of documentation in the generic code to describe how it works
> so that other filesystems implementing have a well defined guideline
> to what they need to support.

The man-page I sent is quite detailed, but sure, I can add the relevant
information to the generic code, as well.

> Also, I don't see any test code for this -

It's in the cover letter: https://github.com/osandov/xfstests/tree/rwf-encoded

I haven't sent those patches up because it's tedious to rework and
resend them for each little tweak we make to the API.

> can you please add
> support for RWF_ENCODED to xfs_io and write a suite of unit tests
> for fstests that exercise the user API fully?

Reading requires filesystem-specific decoding, and I wasn't sure if that
would be a good fit for xfs_io. Alternatively, it could dump the raw
buffer to stdout, but whatever interprets it also needs the metadata, so
there'd need to be some sort of protocol between xfs_io and whatever
interprets it. I added a btrfs_read_encoded program in my xfstests
branch above instead. It should be easy enough to move the encoded_write
test program to xfs_io pwrite, though.

> Given our history of
> screwing up new user APIs, this absolutely should not be merged
> until there is a full set of generic unit tests written and reviewed
> for it and support has been added to fsstress, fsx, and other test
> utilities to fuzz and stress the implementation as part of normal
> day-to-day filesystem development...

Sure thing, I'll add support to those tools once the API isn't in flux
so much.
