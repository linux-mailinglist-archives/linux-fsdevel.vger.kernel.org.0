Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7659911002F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 15:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfLCOd2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 09:33:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34181 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfLCOd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:33:28 -0500
Received: by mail-yw1-f65.google.com with SMTP id l14so1377294ywh.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Dec 2019 06:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jiCBiSbAobj+KVyUMY5OPOozgvxxmgi20DRZ94BIlhI=;
        b=hi2VZLVRRxv8ofKMuy80jMTXmEo7Mqnt9FU+JWNa4P3SvVlzz2sRsd/rM7996uh5f4
         0b37aG3qO2NkHCRAqRdH/UEtU0ES7Ygr5ixWpFy0T6wQT1qf1pyknxL0nQwmrFgdNd5X
         hd+P6JJgq0yXgPbmxdX/5/COj2gMVZswC8+ihourU9XNdg0xJTWSMwTpXhgXu2aHOUzn
         7BjrAi/+c/rEN0oLfiv7WXt62VHo58UWz06NntDJ3UmJw5jA3cvTVp6VrnqwNbjAdLB4
         Ty+SnZ2jO2OnaR/A/rzaF/OlOdqicjgAvzAE8SyEZg9qQO4xXVUCkT4a6dds7ahyHYwE
         JZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jiCBiSbAobj+KVyUMY5OPOozgvxxmgi20DRZ94BIlhI=;
        b=ChdsiIyqHBY3ubpBWc7+bBBRYAZ7yfP2MNqUqWtPF6WjiySFsKX3sqvlRuUeRGvdCL
         LQm34vbyEkKB6E59PdK8qFCohwFnUoNTEbBT38RkREPmVHw0fGRI9whit0Ye/fd2eSZg
         Aj7srLDE2OLaDAe0zEWagyA9DD2l7I1MHUdVDoLDVFc4vTjD/OfqncUxbdWAHq3NvaTC
         NRkx7h6nmdpWb1jzHI2TIkYBXy9YCa8zK4FXpXhUN6BeLvtAS8U7M/R3cfANJuY1whnx
         SNbNAQ40BHN+3tXdSuLLELhU7WtjLKu+BWEnXE36m4Sc62z4xxP1e3UJYD6X7PRVX+oI
         Szlw==
X-Gm-Message-State: APjAAAVi6fZHnKD1SGG/TxQW3v565WHT3pv9kN+tR//VVaDayP/SHQqi
        8pn1x4xlSeEcPjzSWJUYB6v4zT/L8f73xbmlotg=
X-Google-Smtp-Source: APXvYqwBwjKNqCP4D45QDp1dAM6xaMZUIGNtp9JzNVirWRQh2AnMnl0dFQi+blwo1n1NDAPmIQb8roHqfUzgnmsXuP4=
X-Received: by 2002:a81:14d:: with SMTP id 74mr3988732ywb.183.1575383607089;
 Tue, 03 Dec 2019 06:33:27 -0800 (PST)
MIME-Version: 1.0
References: <1575335637.24227.26.camel@HansenPartnership.com>
 <1575335700.24227.27.camel@HansenPartnership.com> <CAOQ4uxiqc_bsa88kZG2PNLPcTqFojJU_24qL32qw-VVLG+rRFw@mail.gmail.com>
 <1575349974.31937.11.camel@HansenPartnership.com> <CAOQ4uxgcD5gwOXJfXaNki8t3=6oq32TB9URDpsoQo9A5tyCfqw@mail.gmail.com>
 <1575382251.3435.4.camel@HansenPartnership.com>
In-Reply-To: <1575382251.3435.4.camel@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 3 Dec 2019 16:33:16 +0200
Message-ID: <CAOQ4uxh8R_GG+LMScoeuY32rx3sOeMuEK5z+rx=KO8QwGEGyXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs: introduce uid/gid shifting bind mount
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 3, 2019 at 4:10 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> [splitting topics for ease of threading]
> On Tue, 2019-12-03 at 08:55 +0200, Amir Goldstein wrote:
> > On Tue, Dec 3, 2019 at 7:12 AM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2019-12-03 at 06:51 +0200, Amir Goldstein wrote:
> > > > [cc: ebiederman]
> [...]
> > > > 2. Needs serious vetting by Eric (cc'ed)
> > > > 3. A lot of people have been asking me for filtering of "dirent"
> > > > fsnotify events (i.e. create/delete) by path, which is not
> > > > available in those vfs functions, so ifthe concept of current-
> > > > >mnt flies, fsnotify is going to want to use it as well.
> > >
> > > Just a caveat: current->mnt is used in this patch simply as a tag,
> > > which means it doesn't need to be refcounted.  I think I can prove
> > > that it is absolutely valid if the cred is shifted because the
> > > reference is held by the code that shifted the cred, but it's
> > > definitely not valid except for a tag comparison outside of
> > > that.  Thus, if it is useful for fsnotify, more thought will have
> > > to be given to refcounting it.
> > >
> >
> > Yes. Is there anything preventing us from taking refcount on
> > current->mnt?
>
> We could, but what would it usefully mean?  It would just be the last
> mnt that had its credentials shifted.  I think stashing a refcounted
> mnt in the task structure is reasonably easy:  The creds are
> refcounted, so you simply follow all the task mnt_cred logic I added
> for releasing the ref in the correct places, so if you want to do that,
> I can simply rename this tag to something less generic ... unless you
> have some idea about using the last shift mnt?
>

Nevermind. Didn't want to derail the thread.
I am still not sure what the semantics of generic current->mnt should be.
operations like copy_file_range() with two path arguments can
get confusing and handling nesting (e.g. overlayfs can be confusing as well).

Thanks,
Amir.
