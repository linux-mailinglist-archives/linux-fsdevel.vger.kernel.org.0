Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8512417FBD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 14:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgCJNQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 09:16:54 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45922 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgCJNQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:16:53 -0400
Received: by mail-il1-f193.google.com with SMTP id p1so7927091ils.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=y5Sujs7GLxJBMNkcS+nL3z7G2RBtvC5q1PspN29iEkI=;
        b=gGF/9GTjQX7REmRD6yzo9gIB3jOxxdpaFdunuZ08/AJCyp2J3Dbl4quT8r1/QZoZ79
         KL1P2ismnGCJV4XWhnFrRgKBKLH9ZBK+fHRFNPm1gUgCggv0LD1Q0vwd6Mm5cnJfHcOY
         ftYNa7tPtXnEP2f9W/E5c1efb4hZ2EgWRY9QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=y5Sujs7GLxJBMNkcS+nL3z7G2RBtvC5q1PspN29iEkI=;
        b=GTr/y5jk5lxo5eDqxNA3MtPfj+rL8OqKFmRfKwgYNm5ZyU0qJR516B8Q+IFmK+VkP0
         TIhb1FWYKrPTXY9jAxRgCcKF2o7T5J+EGwDDHOQqZ/LYyAd6uHWDHizN6QdDaNSiGvwn
         lpTV6WrFv2Af0snO1FQK4nSIQiWScZxlMN2SWH6sv4eNpm6/v/Y1569E9rTx0RVh0Y7A
         GFTmEgKcP49TFz8Q8H/AmFJwq3Q9mDr/9rUhRHsc2A5HO+jJdXZHdnxv/hB0d38T83xg
         kg3YPZEXwcM8Rwa62oN54l1+w+TdNwyGhQZpmYZCub+lBiKh6/Txji3vmbhBiN9PwhXN
         8JHg==
X-Gm-Message-State: ANhLgQ0qOGgCnesK2tA/u7uSUp6HBnrIaAEb/Wc+niXQaoyr2GdtosnM
        vNoUh6ePkdcnaG4FoED0+1CiEwtg0hdLk/Y0UAhmWQ==
X-Google-Smtp-Source: ADFU+vtpdXIOB+Y2PjtlvE0H658znX+xqPsw6UaTa5d8hoEzJfNBkQKAYpQyT3+/cO7swwYlU6P8e/BhhQ3M6b7Z4Rg=
X-Received: by 2002:a92:9602:: with SMTP id g2mr19732783ilh.212.1583846212569;
 Tue, 10 Mar 2020 06:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <8736as2ovb.fsf@vostro.rath.org> <CAJfpegupesjdOe=+rrjPNmsCg_6n-67HrS4w2Pm=w4ZrQOdj1Q@mail.gmail.com>
 <8736aqv6uv.fsf@vostro.rath.org>
In-Reply-To: <8736aqv6uv.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 14:16:41 +0100
Message-ID: <CAJfpegsALuMOxK_Bkry6Cwh76M5sihaJFVT36Z70BXO0FsEGKw@mail.gmail.com>
Subject: Re: [fuse] Effects of opening with O_DIRECT
To:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 2, 2020 at 9:29 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Mar 02 2020, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > On Sun, Mar 1, 2020 at 2:20 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
> >>
> >> Hi,
> >>
> >> What happens if a file (on a FUSE mountpoint) is opened without
> >> O_DIRECT, has some data in the page cache, and is then opened a second
> >> with O_DIRECT?
> >>
> >> Will reads with O_DIRECT come from the page cache (if there's a hit), or
> >> be passed through to the fuse daemon?
> >
> > O_DIRECT read will try first directly, and fall back to the cache on
> > short or zero return count.
> >
> >>
> >> What happens to writes (with and without O_DIRECT, and assuming that
> >> writeback caching is active)? It seems to me that in order to keep
> >> consistent, either caching has to be disabled for both file descriptors
> >> or enabled for both...
> >
> > This is not a fuse specific problem.   The kernel will try to keep
> > things consistent by flushing dirty data before an O_DIRECT read.
> > However this mode of operation is not recommended.  See open(2)
> > manpage:
> [...]
>
> Is there currently any other way to execute a read request while making
> sure that data does not end-up in the page cache (unless it happens to
> be there already)?

Hmm, that sounds something like posix_fadvise(..., POSIX_FADV_DONTNEED).

Thanks,
Miklos
