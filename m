Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8AF3654
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 18:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389893AbfKGRzA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 12:55:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387473AbfKGRzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573149299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OcNFikfjq1BX5+nPgo4efKiLi5+1HMQMe6Ro0KRZSBk=;
        b=b7bbGUq/5xBfBSQblOQZWi4/wN9riXzBRAg4K7gjBLALROTt0NUc6W6DahRSWppa04aMnu
        alN26Q/4j9tjntG6HHod/wtw2YLuBwkzfk6xrH8ZyYLH0Jhy84cP98YogI26A475CdoNAu
        tuDBiipavbCepLIwa145/E+vlZfkEUg=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-Abx3Ze9ONP-28toTcRVeAQ-1; Thu, 07 Nov 2019 12:54:57 -0500
Received: by mail-ot1-f70.google.com with SMTP id g17so1462780otg.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 09:54:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTyEtIAxeTb5uCPTzRm1VfghpAdZyRKOiXCNpposzoM=;
        b=Hl40KRvatWIF4uZ0bjNHuEfoqS4Yel7KlZc9wRNwKs7XSQ69MqWLf36vuNDf2zwdVG
         5EvUugbb0x7Tw5aYMYyx6L26/V9l1RDQLX1PbxSbNfwltV/oFvakSu/Mv9294UHCsZwS
         KqZVNYIbtSPSDeu4I2UgD1p0hr1owDEwzpQKU9NgQke/4WqE5QwYLL16zXmA9bsQr96Z
         Ru/h5YZLb15EMTForSOa8/fr6mXEqYW7jx0+PVUWIJnx4O64Bq3K906dmi+wWwTwsGwo
         RPUoVb32bO5NBa+P/O0mEjSNhTjEi5L2Prg2l0dxI2YUf7RijLzzbYxJcccZLjvvwfFe
         unfw==
X-Gm-Message-State: APjAAAV6WSHRFWyQQ1EUsSnDFSy0IsErEq+XO5oiKTMQOvKxJ7wwivqD
        gWloW2nBa6ROjEPT6pFQo1N1UqoTIJBYKC0eEqgVRkV0xXtIjytkYBx1L4O2fwiAIf1BpNDztEE
        plVDCrzociGc3qEMrh8FOtKWmRDjiU/xLDJ29uTTBhA==
X-Received: by 2002:a05:6808:a93:: with SMTP id q19mr4586984oij.178.1573149297222;
        Thu, 07 Nov 2019 09:54:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqw0A2DoTN7Dd2YoA7wNZdzvb4Bs3F8W8ZXlYA+sAvpG9vN1il3FFfXJ85lmrnNflzjHOBC3OdkylYKZdk7tGrA=
X-Received: by 2002:a05:6808:a93:: with SMTP id q19mr4586966oij.178.1573149297020;
 Thu, 07 Nov 2019 09:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20191106190400.20969-1-agruenba@redhat.com> <20191106191656.GC15212@magnolia>
 <CAHc6FU4BXZ7fiLa_tVhZWZmqoXNCJWQwUvb7UPzGrWt_ZBBvxQ@mail.gmail.com> <20191107153732.GA6211@magnolia>
In-Reply-To: <20191107153732.GA6211@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 7 Nov 2019 18:54:45 +0100
Message-ID: <CAHc6FU4MbJ5T+W_ku2gQzoquvMeh3Wbvus-c+tjOc6ZrOwTRiQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: Fix overflow in iomap_page_mkwrite
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
X-MC-Unique: Abx3Ze9ONP-28toTcRVeAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 7, 2019 at 4:37 PM Darrick J. Wong <darrick.wong@oracle.com> wr=
ote:
> I'll fix it on commit.

Thanks.

So now the one remaining issue I have with those two functions is why
we check for (offset > size) instead of (offset >=3D size) in

  if (page->mapping !=3D inode->i_mapping || offset > size)

When (offset =3D=3D size), we're clearly outside the page, and so we should=
 fail?

Thanks,
Andreas

