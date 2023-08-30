Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A7D78DA91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbjH3Sgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243332AbjH3Ko7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:44:59 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A071BB;
        Wed, 30 Aug 2023 03:44:56 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5735282d713so2915195eaf.2;
        Wed, 30 Aug 2023 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693392295; x=1693997095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDg1gJ54LhcHGraF0W90P36J7iWVIjIASj7u9px6qZ0=;
        b=jowOUlmksXh6WJMDBM5SUMOEg3JeZwxrs8MOgWbnYq8oIXcDxqFSZ3yuaNCYj005VC
         eMuSUPbdOXjT39lJn2irSfFWsCx1VYW2EXC1cWZnM6SJntnWaBYMFiRXwKh4JvzjQwS+
         sidXy4W1/N1CbahK4saZN975Rum8LXaYm3AwfYwETHh17cK4uqqEpvbFzlzWxTn3JtES
         EP+wikRZOYXIy5AX8TdzW8aMmroQbW2YrIxwKgqU2YCPn6yqVQGSi5iggxzTpQ+VkmQk
         XtGeSIKapbo9QkENzHrdXTcCBFF73TC/5fC4/tnMz7xhLTYtQAD1M2xehWmrhGZxcQOT
         pghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693392295; x=1693997095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uDg1gJ54LhcHGraF0W90P36J7iWVIjIASj7u9px6qZ0=;
        b=Fgno/+213BF72oUXGwhr1X07yMIJCYReVJTbDVcKizB10uqURozJy5WgyVbPcYZ8a3
         R8OK1rfnN5fKcNfd/iDk7pM8SVmfnaJ4G9993bfAFcefQTZntj0GUK3/IWmDzoszIweP
         PyjTk3EmCyO3Chb36rX6O0ydUZ+rFThRtXJocj2KlrbwiGwdZXOhb4VjkXD3oEGKKbvw
         7NOgtOTJ8KPz+gNLjWbu8i/qe9JcdQwte+VWCwrDT4psCdahi7qAU96UQn933Me+6a3x
         myYtoxWu33/DzOzTIERe3sprgQAEYwviDum0RYEw6K4AwNHTilE6j0ORmnEgKiqbRA/o
         Fcyg==
X-Gm-Message-State: AOJu0YwYX6yrb0UUF6+6zEAr7Q6MwLS4AtWrKMSvlWbgSo4frkIJaUCe
        651mWd7MiIdiyBkn3ye9SJemNezNUa+7ICjZFrHYWexhzpk=
X-Google-Smtp-Source: AGHT+IF95KpxWvZiq1byVjvKpPp7KVB4uGJagT9Ba6+51ZVenyWr+nBiHv9bHLBzZ7hUjhBvu1uBZOvdzeVVNsfCYpk=
X-Received: by 2002:a4a:3954:0:b0:573:3fe0:cdd6 with SMTP id
 x20-20020a4a3954000000b005733fe0cdd6mr1411313oog.6.1693392295590; Wed, 30 Aug
 2023 03:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230825201225.348148-1-willy@infradead.org> <20230825201225.348148-10-willy@infradead.org>
 <ZOlq5HmcdYGPwH2i@casper.infradead.org> <2f1e16e5-1034-b064-7a92-e89f08fd2ac1@redhat.com>
 <668b6e07047bdc97dfa1d522606ec2b28420bdce.camel@kernel.org> <ZO3y9ZixzE4c5oHU@casper.infradead.org>
In-Reply-To: <ZO3y9ZixzE4c5oHU@casper.infradead.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 30 Aug 2023 12:44:43 +0200
Message-ID: <CAOi1vP-jc+GqUKgewEaVRC8TuDjKzh4PeKmWyDf3qxSAWC4dTw@mail.gmail.com>
Subject: Re: [PATCH 09/15] ceph: Use a folio in ceph_filemap_fault()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        ceph-devel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 3:30=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Aug 29, 2023 at 07:55:01AM -0400, Jeff Layton wrote:
> > On Mon, 2023-08-28 at 09:19 +0800, Xiubo Li wrote:
> > > Next time please rebase to the latest ceph-client latest upstream
> > > 'testing' branch, we need to test this series by using the qa
> > > teuthology, which is running based on the 'testing' branch.
> >
> > People working on wide-scale changes to the kernel really shouldn't hav=
e
> > to go hunting down random branches to base their changes on. That's the
> > purpose of linux-next.
>
> Yes.  As I said last time this came up
> https://lore.kernel.org/linux-fsdevel/ZH94oBBFct9b9g3z@casper.infradead.o=
rg/
>
> it's not reasonable for me to track down every filesystem's private
> git tree.  I'm happy to re-do these patches against linux-next in a
> week or two, but I'm not going to start working against your ceph tree.
> I'm not a Ceph developer, I'm a Linux developer.  I work against Linus'
> tree or Stephen's tree.

Agreed.  Definitely not reasonable, it's the CephFS team's job to sort
out conflicts when applying patches to the testing branch.

The problem is that the testing branch is also carrying a bunch of "DO
NOT MERGE" fail-fast and/or debugging patches that aren't suitable for
linux-next.  The corollary of that is that we end up testing something
slightly different in our CI.  Xiubo, please review that list and let's
try to get it down to a bare minimum.

Thanks,

                Ilya
