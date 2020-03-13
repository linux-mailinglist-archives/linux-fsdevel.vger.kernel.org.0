Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95F5C184969
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 15:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgCMOdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 10:33:46 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38802 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:33:46 -0400
Received: by mail-il1-f195.google.com with SMTP id f5so9082930ilq.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JB+4fAurnzbhrSysuhDbKI2ACutNKzpC2UKtT5XNYAQ=;
        b=dSQ9s5yPyRLaufV9UC3f0z5nniA1KSR93hqY2rKXG1vA+r93LifoqxY4y8nbj4pV4u
         inydetbvwKPlDMtSmeimLR5bFla9/g2AL9MaCJRu7cfXcy3WqgSu2FwjPp6wow3EZm53
         zSgrt/heXxli4QVNT4SWd9XCXup5hes4WG1Wr5lBNtS0itZ6IIE11mtMckA8quBkk9Es
         FrGBj9/QgRpx5hFagxa3H20kX5h0iwDEffdnT0baRlwS1Ywqwht52/UL3GuZwRf5JS4e
         E+FiB4IsoLUNcbTCmmaLzbtrhkhrx67h2h4DM7yf7QZYG+W5XrT5u/yrKCnAx9nA8+Bb
         5RJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JB+4fAurnzbhrSysuhDbKI2ACutNKzpC2UKtT5XNYAQ=;
        b=uPMot1c11HhQ8uRtk+EGYOnwcFsYZOLETgJZZqzgLQlqfzkTFwfS9qclMQphhV+6wh
         JxlT8uGZnLPGhkWRWpnqSGNLmYiHIm80Nq3QmXCvGL7lX0axbdba/i+EufLJDoeXMFo+
         Z8ipMMvV71JaqImDkgqu6s+r1J/BErLczmGJ038uwfwuy2WnTM/spznzff5SwvG1VNlC
         XU6SfajcXM4UFjePvwJSTYKBDvY7tk/aqGXjT005QXERCCB7BiXq8fIBy8Q9IQLumUz5
         th7o8+t07ytipRepL8t+T3pKyilObmRWhNQk23hmRBUxJg1k+GCHKvPG9O2n1W6RNPFG
         h1Rg==
X-Gm-Message-State: ANhLgQ0ilwK3bfugT0iDcIgjdFKTLNVJ/iWIx6JJ7dPZnwTT3wcnNa4f
        pCLhDaHUF0Gjy4tZjf6P5ornqIjpUAlouiMvUtI=
X-Google-Smtp-Source: ADFU+vunRI7dIJFbF2gCBY9lexysIhxcF0UoBCWw/HlUehdfK1AH+ypOkNB1lE79BIpbLW9ChQ72U7FSCoI2hQOh91s=
X-Received: by 2002:a92:60b:: with SMTP id x11mr2047891ilg.9.1584110025220;
 Fri, 13 Mar 2020 07:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200126220800.32397-1-amir73il@gmail.com> <20200206214518.GB23230@ZenIV.linux.org.uk>
 <CAOQ4uxiTfS_QZN=vrFed=KSFg+CcSqo1ZRqS8_Mx_uvPk3NTPg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiTfS_QZN=vrFed=KSFg+CcSqo1ZRqS8_Mx_uvPk3NTPg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Mar 2020 16:33:34 +0200
Message-ID: <CAOQ4uxjjZZqrfEVtg+Sx-pGTXY30KeJZuR1Cv9OTL_b_fC4=Pw@mail.gmail.com>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "J . Bruce Fields" <bfields@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 7, 2020 at 8:26 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 6, 2020 at 11:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Jan 27, 2020 at 12:08:00AM +0200, Amir Goldstein wrote:
> > > If a disconnected dentry gets looked up and renamed between the
> > > call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
> > > lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
> > > parent was deleted, we return an error, although dentry may be connected.
> > >
> > > Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> > > warning") changes this behavior from always returning success,
> > > regardless if dentry was reconnected by somoe other task, to always
> > > returning a failure.
> > >
> > > Change the lookup error handling to match that of exportfs_get_name()
> > > error handling and return success after getting -ENOENT and verifying
> > > that some other task has connected the dentry for us.
> >
> > It's not that simple,

Al,

Ping.
Are you sure it is not that simple for all practical cases?
Please take a closer look.

My change attempts to handle a real rename race similar to how
it was handled before the "Fixes" commit.
This is Acked by Bruce and Christoph.

Please see my arguments below.

Thanks,
Amir.

> unfortunately.  For one thing, lookup_one_len_unlocked()
> > will normally return a negative dentry, not ERR_PTR(-ENOENT).
>
> Which is why this fix is mostly relevant to removed directories.
> negative dentry case should be handled correctly by bellow:
>
>         if (tmp != dentry) {
>
>
> > For another,
> > it *can* fail for any number of other reasons (-ENOMEM, for example), without
> > anyone having ever looked it up.
>
> Yes, but why should we care to NOT return an error in case of ENOMEM.
> The question is are there other errors that we can say "we can let this slide"
> as long as the dentry is connected?
>
> I certainly don't mind going to out_reconnected for any error and that includes
> the error from exportfs_get_name(). My patch checks only the rename race
> case because this is what this function has done so far and this is what the
> big comment in out_reconnect is about.
>
> Thanks,
> Amir.
