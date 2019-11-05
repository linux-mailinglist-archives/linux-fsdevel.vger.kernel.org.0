Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9BF05EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 20:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbfKETZ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 14:25:58 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46561 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390314AbfKETZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:25:58 -0500
Received: by mail-yb1-f194.google.com with SMTP id g17so421185ybd.13;
        Tue, 05 Nov 2019 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KChVl98RtUbkgrTOQAVv+rIQgGh7eAxBXODW2CW7diU=;
        b=gr3DvwnNJUf3Y48Dj/m1is18b4uN/Ngwj7G0hU5nh705p48wIU/R6fdiQDM2RyKmS5
         B4+tCC7gc0ICBXMdqQWvzmJ/ccdkGS4Km7CVRUycrScH451IQUia3g+sE/5gaXZddvvY
         I2pDqQgPoVRbB+yNOiwgSxIWfFL1lb9JXhQoryEYHCs1nzLLtvoVwwUW9CvEZnMwR3m/
         52DfEtsh/HX0a2fbBDrsFjV7uE9QVwgXfOs95DxVHZzqUhS04ytJ96mXTyCh105y/HUS
         BjhzqqiChzRRcqdkexMbU3yMO8CqYb82E8llWTzjWYpzTlSKCxf65d3FE9VmBhPne6+j
         bqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KChVl98RtUbkgrTOQAVv+rIQgGh7eAxBXODW2CW7diU=;
        b=bvy0uSTGcsUCj1g6EGeSu+9PcQMzbs5O7Dutdfuc34ULCVwNFSLorFL/6KtvhMQiJg
         6nQIkmptAfk4Y+8GDkIBRJaDeeRsdPAfVSZcPhTe/qS8a1r3W92PqZqhszAYKAJ/Q1EO
         nrJPUYo/CLLxy6Xlz66IBk56MHYFwDkKzKryDpZi7gh4qDCQDSbM6yheZV7wWZBXkavw
         /BAEx6nVeu+/kDPUFCjxmStkA5T2xxwfAfZCEghWBnBxvJUFd6JDhtCWoM/qpJs9v755
         4CCKNr7JzkS0uAk89froiXMKbuKdvyM25hIB53rS0OFFWJjchgEJ9wzQiR3P0AoQocOm
         zfng==
X-Gm-Message-State: APjAAAVf1j8MXsVljadlXxARs4/+VoWQKglRHuj5HiTeFRzWvFH5M19p
        WWciCw76Fo3w9J4S175VZb5A77lAmBZRQ7PNLTQ=
X-Google-Smtp-Source: APXvYqx6aFWSGHN0fNloB89+dY7LDFF8+dPoO/5MWUfPSHQSvaN/hiXzcFRfW+Ck3Kgv5gJ2I+zUDkQwtgzJ4cufWWU=
X-Received: by 2002:a25:3744:: with SMTP id e65mr28077525yba.126.1572981956875;
 Tue, 05 Nov 2019 11:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20191104215253.141818-1-salyzyn@android.com> <CAOQ4uxhoozGgxYmucFpFx8N=b4x9H3sfp60TNzf0dmU9eQi2UQ@mail.gmail.com>
 <97c4108f-3a9b-e58b-56e0-dfe2642cc1f5@android.com>
In-Reply-To: <97c4108f-3a9b-e58b-56e0-dfe2642cc1f5@android.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 5 Nov 2019 21:25:44 +0200
Message-ID: <CAOQ4uxindmuTdfW6NNM2=Bt=y7KDMQsfN=zA_Z7dgkrHfptoHA@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] overlayfs override_creds=off & nested get xattr fix
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 5, 2019 at 5:20 PM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 11/4/19 11:56 PM, Amir Goldstein wrote:
> > On Mon, Nov 4, 2019 at 11:53 PM Mark Salyzyn <salyzyn@android.com> wrote:
> >> Patch series:
> >>
> >> Mark Salyzyn (4):
> >>    Add flags option to get xattr method paired to __vfs_getxattr
> > Sigh.. did not get to fsdevel (again...) I already told you several times
> > that you need to use a shorter CC list.
>
> This is a direct result of the _required_ scripts/get_maintainer.pl
> logic, I am not going to override it for first send. I was going to
> forward to fsdevel after the messages settled, I am still waiting for
> 1/4 to land on lore before continuing.

How do you expect it to land in lore if the mailing list server rejects it?
If I were you, I would *first* post the patch to the small crowd of the
patch set, which includes fsdevel and *then* forward patch 1 to all
maintainers with a link to lore for the series.

The result as is was in your last 15 posting is much worst.
There is a ghost patch in the series that nobody knows where to find.

>
> The first patch in the series needs to get in before the others. I was
> told to send the first one individually because the series has so many
> recipients and stakeholders, and <crickets> because no on could see the
> reason for the patch once it was all by itself. So I rejoined the set so
> they could see the reason for the first patch.
>
> If only the first patch in the series that added the flag argument got
> in (somewhere), then the overlayfs portion would be much easier to handle.
>
> >>    overlayfs: handle XATTR_NOSECURITY flag for get xattr method
> >>    overlayfs: internal getxattr operations without sepolicy checking
> >>    overlayfs: override_creds=off option bypass creator_cred
> > It would be better for review IMO if you rebase your series on top of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git ovl-unpriv
> Will do, send it only to fsdevel, other recipients? What do I do with
> get_maintainer.pl? The first patch in the series is noisy, I am getting
> more and more uncomfortable sending it to the list as it looks more and
> more like spam.

get_maintainer.pl is a suggestion. common sense should be applied.
Sending the entire series to the crowd of this message seems fine to
me (I also added fsdevel). LKML is quite an overkill IMO and
linux-doc also seems out of context if you ask me.

Thanks,
Amir.
