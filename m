Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0931835E248
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242164AbhDMPIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 11:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230327AbhDMPIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 11:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618326500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXfHI7Pi/+FuEoIu676iLq6Hjc+4w30CIrx+yrnJUyk=;
        b=Zz6iMBDTAHeWNaW0jgn5VjChX+Zj4dupDudmcZ9gFleptI1HvdkJZTC0fh88JpisPRj7uu
        x25UR3vXaaNjZ1O6vlai4MgltD+0IHNmUXr25HmOr2bK4ABSCNgntFsyIe0wZALHsvvN/j
        5gJmwTI7577SM+aU3Uw9FND8bMzvXbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-5PTN0ALPOXGi0mOkdxb0vg-1; Tue, 13 Apr 2021 11:08:16 -0400
X-MC-Unique: 5PTN0ALPOXGi0mOkdxb0vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58DC107ACCA;
        Tue, 13 Apr 2021 15:08:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-35.rdu2.redhat.com [10.10.119.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC82660DA0;
        Tue, 13 Apr 2021 15:08:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa2O=xLgF+-Q@mail.gmail.com>
References: <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa2O=xLgF+-Q@mail.gmail.com> <20210327035019.GG1719932@casper.infradead.org> <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com> <20210201130800.GP308988@casper.infradead.org> <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com> <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com> <2884397.1616584210@warthog.procyon.org.uk> <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com> <1507388.1616833898@warthog.procyon.org.uk> <20210327135659.GH1719932@casper.infradead.org> <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com> <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com> <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com> <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com> <3726695.1617284551@warthog.procyon.org.uk
 >
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1268213.1618326494.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Apr 2021 16:08:14 +0100
Message-ID: <1268214.1618326494@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike Marshall <hubcap@omnibond.com> wrote:

> Hi David... I've been gone on a motorcycle adventure,
> sorry for the delay... here's my public branch...
> =

> https://github.com/hubcapsc/linux/tree/readahead_v3

That seems to have all of my fscache-iter branch in it.  I thought you'd s=
aid
you'd dropped them because they were causing problems.

Anyway, I've distilled the basic netfs lib patches, including the readahea=
d
expansion patch and ITER_XARRAY patch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-lib

if that's of use to you?

If you're using any of these patches, would it be possible to get a Tested=
-by
for them that I can add?

David

