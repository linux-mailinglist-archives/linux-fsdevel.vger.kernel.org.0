Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F001115526D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 07:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgBGG0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 01:26:48 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43620 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGG0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:26:47 -0500
Received: by mail-il1-f194.google.com with SMTP id o13so757500ilg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 22:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RogWDChua+WFxHQXK6tlOujlJzK0yywMxBMIxixAbh4=;
        b=Payckzow6Due1zgDNzjiiLApVJDTJ5n0y9ZtfOHF35HmeDRPdqYx80F9hTpHRayHWg
         Ew7HssyBYyR0sqswI3ZUnGn7qF6vFjrcdpxyAaWiMh0SOfBXAuEnzDjFJIsIWvjBSYJF
         HEaCT4ZlD/5Ba86XE4yZm8TkBD4KH6TedEOppNK0WzyzUQWJLIHgHRnJ+sqDDDz7p2F4
         xQGkVPwW+wIDC92LGDz5v7DIpjObj5ksIC6jwr2oz2BuGQYWeKlzlbjaE43cA1myLjmA
         g88v5RDmGfP6U1XiH6BeDxQ2MU9k65aTSOzzMtel3WZfgiukmCynOaSO4ADUJ0UzIaPq
         olUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RogWDChua+WFxHQXK6tlOujlJzK0yywMxBMIxixAbh4=;
        b=rd6csevAnWJwJRXFAGZ9gzYJEXPpIMVPY7+BYUfUoqFX7TKpoX5w6b6F8sCoSW0f0l
         6ulVdZEaGDJ8Lo/UFn+MhQ8/ahdSBh0Twh2rb7aHvDZBbUxQBdKXUk/mamoOfpUEUJcB
         Qy8TLkdxPYfAMvG/xs9ElIyqvB4vh7mQFVSQG4z6k2nH/ZWVY/BRtocc81Jci6AFrxqC
         k8cGTRa23zwnx9rMytxVeX3ds3z71GZYzuVIrnN10hidJCd/BbzXp7fFqXHXc+0qmNjC
         IuEX5P44pVFzS44Rcu4/l6cW0L0TarwxmeN3wzE0u8LCHaHt/+SohUxRUwebfn826gau
         QzKA==
X-Gm-Message-State: APjAAAVr7yqkAcr2SAVGo/WIDprNvqJh1O1L7VwwaUYU22NcpGNzizil
        +aO30I14HsKBT1ctPJsqmaFIn5ylOB6mLSe8Nnc=
X-Google-Smtp-Source: APXvYqxzFYk5rYheb1DhUFIq7NfC44E3MS/n+BRnk44EEcn/vYWvXNY9g8MwurouK4qgzU0YnPGbQPyztzyS9BZpvic=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr7826272ilq.250.1581056806911;
 Thu, 06 Feb 2020 22:26:46 -0800 (PST)
MIME-Version: 1.0
References: <20200126220800.32397-1-amir73il@gmail.com> <20200206214518.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200206214518.GB23230@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 7 Feb 2020 08:26:35 +0200
Message-ID: <CAOQ4uxiTfS_QZN=vrFed=KSFg+CcSqo1ZRqS8_Mx_uvPk3NTPg@mail.gmail.com>
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

On Thu, Feb 6, 2020 at 11:45 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jan 27, 2020 at 12:08:00AM +0200, Amir Goldstein wrote:
> > If a disconnected dentry gets looked up and renamed between the
> > call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
> > lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
> > parent was deleted, we return an error, although dentry may be connected.
> >
> > Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> > warning") changes this behavior from always returning success,
> > regardless if dentry was reconnected by somoe other task, to always
> > returning a failure.
> >
> > Change the lookup error handling to match that of exportfs_get_name()
> > error handling and return success after getting -ENOENT and verifying
> > that some other task has connected the dentry for us.
>
> It's not that simple, unfortunately.  For one thing, lookup_one_len_unlocked()
> will normally return a negative dentry, not ERR_PTR(-ENOENT).

Which is why this fix is mostly relevant to removed directories.
negative dentry case should be handled correctly by bellow:

        if (tmp != dentry) {


> For another,
> it *can* fail for any number of other reasons (-ENOMEM, for example), without
> anyone having ever looked it up.

Yes, but why should we care to NOT return an error in case of ENOMEM.
The question is are there other errors that we can say "we can let this slide"
as long as the dentry is connected?

I certainly don't mind going to out_reconnected for any error and that includes
the error from exportfs_get_name(). My patch checks only the rename race
case because this is what this function has done so far and this is what the
big comment in out_reconnect is about.

Thanks,
Amir.
