Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86042254684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 16:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH0OLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 10:11:12 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:48385 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgH0OKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=CCa4kfn3vpnBF8Rj2S30fsBuR4gERAiFmIY3NeXQZyA=; b=n/0pxv4AYQ3fUBkOv1U407afU1
        xVahq5gPEya24BZaVxYESvsMhpCGgSbY69twelpBQUcb0JLMzyZZ04eHHT7H4J9AEHHWUuy/qavEJ
        HpJH+Tfgm/JE7uWXBo59pN1QxV91XpgHaSmmqXDW5gDXalttiyncmoG0OtBgn80gE0z5ZxqQWyenr
        RBU7s0gwQtubRR6nAMx7/y7zFh0P73mtAiCBKc3wRuUfjaJ+hu+DtozriMDReuyQcRNwl41kEytGk
        DQ5Bkr5NZxpr/q6vfTy60vYn2KNDJYhLeHTzkKn4Spc51etGWfLy4TmvhJXkYOSet4eSOF64alGI6
        hVk84xug==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Thu, 27 Aug 2020 15:48:57 +0200
Message-ID: <3331978.UQhOATu6MC@silver>
In-Reply-To: <20200827122555.GD14765@casper.infradead.org>
References: <20200824222924.GF199705@mit.edu> <1803870.bTIpkxUbEX@silver> <20200827122555.GD14765@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Donnerstag, 27. August 2020 14:25:55 CEST Matthew Wilcox wrote:
> On Thu, Aug 27, 2020 at 02:02:42PM +0200, Christian Schoenebeck wrote:
> > What I could imagine as delimiter instead; slash-caret:
> >     /var/foo.pdf/^/forkname
>=20
> Any ascii character is going to be used in some actual customer workload.

Not exactly. "/foo/^/bar" is already a valid path today. So every Linux sys=
tem=20
(incl. all libs/apps) must be capable to deal with that path already, so it=
=20
would not introduce a tokenization problem.

The caret character is not reserved by any filesystem either:
https://en.wikipedia.org/wiki/Filename

The only change a caret delimiter would bring, is a very minor change in=20
semantic: apps would no longer be allowed to create dirs/files named exactl=
y=20
"^". But I find that a very small restriction compared to the negative impa=
ct=20
of other delimiter options, i.e.:

	touch /some/where/^          # error if forks enabled, OK otherwise
	touch /some/where/^whatever  # always OK

So if you have apps that need to access dirs/files called *exactly* "^", th=
at=20
would be easy to fix. And if you don't want to, you just keep kernel's supp=
ort=20
for forks disabled and preserve old semantic of "^".

> I suggest we use a unicode character instead.
>=20
> /var/foo.pdf/=F0=9F=92=A9/badidea

Like I mentioned before, if you'd pick a unicode character (or binary), the=
n=20
each shell will map their own ASCII-sequence on top of that. Because shell=
=20
users want ASCII. Which would defeat the primary purpose: a unified path=20
resolution.

Then even if you'd pick unicode, that would raise new questions and problem=
s;=20
e.g. utf-8, utf-16, utf-32? Character normalization required? How do you=20
ensure each layer will use the same encoding?

Best regards,
Christian Schoenebeck


