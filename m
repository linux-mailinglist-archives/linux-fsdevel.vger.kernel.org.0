Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 072FA141D4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2019 20:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEES0A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 May 2019 14:26:00 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41838 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbfEES0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 May 2019 14:26:00 -0400
Received: by mail-lf1-f68.google.com with SMTP id d8so7567467lfb.8;
        Sun, 05 May 2019 11:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SH/ILRpdDMLy/Mnf4wxN3xCvxrnc9XArokvPdEhwiQ=;
        b=uj3KNREhRy1l43c9gvpdMfH0J68XrkiOTfDYnqnTCjLaAeVEKBs8TquPO4jJ3lK5g6
         JDNC2/7pIEugqYhaxrTZZ6jCwiAKNpayQH1wccwapifHEt1kfQs6EzByGnab03Ggdu9h
         yILdC4FPOvfT/pZLzeMz2zuZOLyifdBnk6wRvmTPgL0X3wjkQ+3UdmU4BRyOChg8+nlU
         1hrqJDTb0kKQv6oAIY/3F0kUeU0aS/xgUXueOXcbO+CjYeSfhF5FSa8BPqvHdw8eHBIV
         YEh8H3o2qu3KuZv1gq0NTyB7HInSa5PyuaXIjYqycTH9uCe3p8O3Tj1YYD9alCrgPpQf
         uQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SH/ILRpdDMLy/Mnf4wxN3xCvxrnc9XArokvPdEhwiQ=;
        b=jD8xWDNOum2SR3cPxfZxwpWeKTo0phIGf1oWvLZcCJAcr8q+3ET1Y/KJeX6tLRcLkm
         3GZGkqfU67uWTOA2GV9eYMZnIiBqH1/96SSC9+fIeU5vCQ1xCM2elbHU6D0VcID9EAlL
         jpPxQ81uenMiHuk8vqQPbSZWbVVo4C9hVwUdlznkq0ywI2z1o7klZF8mV1oQ+Cs09COU
         SnErTs6p1uHUycpxUvSWqvCersERiMAROYUFCRPXkCyg5sJHY7NJ0PbqQzrcYSttAzF2
         /4PX+f+hLMpT039LU4ax+ZcYSPkQqhD7vs5pWoTHVAGtN6Kn4JZuKj3YOpn3XFblzewx
         i16w==
X-Gm-Message-State: APjAAAWfuwOIOFVe2kTV0UQOEGMJ+zZOixf60McieXGlcXhsqtTWIMW2
        UxlKHQE8Oy6HOdZ5PIVIJEn1kMGhMZnIzAhdRd+farco
X-Google-Smtp-Source: APXvYqxp1p7JTGfU1QWu2LRuzXvKIzTLAQZRFufEeKKRfFLRgIe5Vrpa/2UEjyVTDNyD9z/lB5aRA/GrHWu/N/Jvlr8=
X-Received: by 2002:ac2:4893:: with SMTP id x19mr10668455lfc.109.1557080758612;
 Sun, 05 May 2019 11:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190504094549.10021-1-carmeli.tamir@gmail.com>
 <20190504094549.10021-2-carmeli.tamir@gmail.com> <20190504134503.GA16963@bombadil.infradead.org>
In-Reply-To: <20190504134503.GA16963@bombadil.infradead.org>
From:   Tamir Carmeli <carmeli.tamir@gmail.com>
Date:   Sun, 5 May 2019 21:25:21 +0300
Message-ID: <CAKxm1-H9cgym_RQ-oLcZWEPpyUf5NrZPt_Zu3U=mpU=E38SbvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Use list.h instead of file_system_type next
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I just found it weird that there is a proprietary implementation of a
linked list while surely the kernel already offers well established
data structures.
IMO, the current code is a bit hard to understand, especially the
addition of a new struct to the list in the line "*p = fs" after
find_filesystem returned the last member.
Correct, I'm not familiar with all the use cases of the code.

I'm not sure that XArray is a good choice since there is no notion of
an index attached to the pointer, it's really just a linked list of
pointers.
Tell me if you think there is any way to improve my suggestion.
Thanks for you attention.


On Sat, May 4, 2019 at 4:45 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, May 04, 2019 at 05:45:48AM -0400, Carmeli Tamir wrote:
> > Changed file_system_type next field to list_head and refactored
> > the code to use list.h functions.
>
> What might be interesting is getting rid of this list and using an XArray
> instead.  This would be a more in-depth change; getting rid of the rwlock
> in favour of using RCU accesses for the read-side and the xa_lock for
> write accesses to the filesystem list.
