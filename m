Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9131DEE22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbgEVRW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 13:22:56 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:45538 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbgEVRW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 13:22:56 -0400
Received: by mail-ej1-f54.google.com with SMTP id yc10so13811173ejb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 10:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Zsp0c0flOeCORreY3ZgeyelzW9NH+nw9TcY7P/Kkgk=;
        b=BlUCakYUj1sjXS+DW7SxiOx6ki64w4CYRVKDVNIwfX8wfV9oHNV7+Z/8Px/vYiK5kA
         PAYJ2JRuO74qKUmg4SMjttQarwwlxiypR5aJMGWPYueFFk0qwvEt/VzXPjfPi9D7wR1W
         0Vh0IpyENkR5YA/iKbQnQxQv+9PBx4qXlmKesQrV/00UtMWnnVy4tWX7nHD2y2BBIt4o
         6LjPC51b8PlqKgF9uAhBjQmQcqzmpmyk7G/SbsqTXdUcKPrn54UMhuA4sW7TGRDcN2jo
         z+YO3sHl1sRwu78+5DVngXkqgY7RissQ1DKKhJEg+tjF8PmKGiB5Gj6vVMDLL+dAvYcp
         y/2g==
X-Gm-Message-State: AOAM530O3VqHEZEKgk14z2f2kbKJWJeDhiPzLZ/Me4qPpCrvDiu7iSoE
        ngnnVfWD204m6ICSTtI8GTchtDtTL3Q=
X-Google-Smtp-Source: ABdhPJyTU/POz1uvbK+4X1DXkISwUFzdNPB8X9muQ/m6Zc5Zyx9rVab/EWIFWnAh5Tlug2/vwN8Fag==
X-Received: by 2002:a17:906:1b43:: with SMTP id p3mr8571282ejg.265.1590168173744;
        Fri, 22 May 2020 10:22:53 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b23sm8583399ejz.121.2020.05.22.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:22:53 -0700 (PDT)
Date:   Fri, 22 May 2020 19:22:51 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Remove duplicated flag from VALID_OPEN_FLAGS
Message-ID: <20200522172251.GA40716@rocinante>
References: <20200522133723.1091937-1-kw@linux.com>
 <20200522154719.GS23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522154719.GS23230@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20-05-22 16:47:19, Al Viro wrote:

Hello Al,

Thank you for review.  This is going to be an invaluable learning for
experience me.  Also, apologies for causing you to do more work.

[...]
> Now ask yourself what might be the reason for that "duplicated argument".
> Try to figure out what the values of those constants might depend upon.
> For extra points, try to guess what has caused the divergences.
>
> Please, post the result of your investigation in followup to this.

I had a look at O_NONBLOCK and O_NDELAY, and the values of these are
platform-specific, as per:

include/uapi/asm-generic/fcntl.h:
  #define O_NONBLOCK      00004000
  #define O_NDELAY	O_NONBLOCK

arch/sparc/include/uapi/asm/fcntl.h:
  #define O_NONBLOCK  0x4000
  #if defined(__sparc__) && defined(__arch64__)
  #define O_NDELAY    0x0004
  #else
  #define O_NDELAY    (0x0004 | O_NONBLOCK)
  #endif

arch/alpha/include/uapi/asm/fcntl.h:
  #define O_NONBLOCK   00004

arch/mips/include/uapi/asm/fcntl.h:
  #define O_NONBLOCK   0x0080

For Sparc, there we handle it as a special case, for example:

linux/fs/ioctl.c ->
  ioctl_fionbio():

  #ifdef __sparc__
          /* SunOS compatibility item. */
          if (O_NONBLOCK != O_NDELAY)
                  flag |= O_NDELAY;
  #endif

There is also a comment in the fs/fcntl.c that adds clarification:

fs/fcntl.c ->
  fcntl_init():

  /*
   * Please add new bits here to ensure allocation uniqueness.
   * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
   * is defined as O_NONBLOCK on some platforms and not on others.
   */

The behaviour of O_NONBLOCK and O_NDELAY also is platform-dependent,
where O_NDELAY might just return 0 instead of returning an error and
setting errno to either EAGAIN or EWOULDBLOCK.

I also took a look at commit 80f18379a7c3 ("fs: add a VALID_OPEN_FLAGS")
that introduced the new definition.

After looking at the warning coming from Coccinelle, I had a look and
assumed that flag O_NDELAY was added to the VALID_OPEN_FLAGS twice
accidentally.

I am still unsure why we would want to keep O_NDELAY twice?  Setting the
same bits multiple would be a non-operation to the best of my knowledge.

But, I sincerely apologise for a not very clear commit message and not
mentioning the flag in the subject and explaining what has been done
better.  I will send a v2, if that is OK with you?

Again, thank you for you time!

Krzysztof
