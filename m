Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECF4383AC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235630AbhEQRLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhEQRLs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 13:11:48 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F40C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 10:10:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n2so10283621ejy.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQWXlUNmoTHMgeRbNpcw353UuhR2CLKe5FdjnZVXGlM=;
        b=MEuKGQDcHa03p1BmMKDjhFT95CSl32JRfaB96FXizPYf8Meixkj8IxaD9gMkTgPIO0
         XX1zZSj9S+z4pY43YRyS1MKao/+Jd+WrLUSpeMpoPnMOISUydf+tvToYznbDhtlUqb85
         NjcKzHx/H/ClqIOIsnNOdcsfQ4XoGgo1836ZoDs/IonhB+P4ArtjGac/C73ltMYlPmH4
         E3gqunowJ4mvgfMJ1UfCJEVd/F4p+ot+0aMEK4QEPGhMWi8StQGiCXkIKCHLyINRVCcM
         /xyxbz71vbZCFW7sW2y2y4g8gHNjodC9L6wxGHNO78BArRWFkGxW2KJ9TJOA43gHei3q
         s9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQWXlUNmoTHMgeRbNpcw353UuhR2CLKe5FdjnZVXGlM=;
        b=QinBN8sJjaRgH6SJHk4ha0xpunRZ7WL6Y7GMHQxQW1YrNj5yRjeRa8en340V4QTLIJ
         l7FHHjdtvUmLjr9woQI5CasQjLjGoxFk84PM/sq0EfzdT3LkKngms2vjTIYf/+X9WroT
         MNhJ3AlJoUpp+6qELFUvvsiq5coquhamDCFHFAfyv2K0u/VfmAzDTjE34lR639jblOYh
         2xKau/tRCreO0uaNE+fX5NRAIbU1WfI/fkOAm4MO5DrduCuYD81CYpdniRm9052idHGk
         RG1pbf3XQpNZ+Yc7wTafOsCdmgOt8yxnMBK13hZlrxnLNQi1UTvcPxMfcq3LGuedykxC
         S2Rw==
X-Gm-Message-State: AOAM530yLYIGK8JFYpso7oCTPLo/5p/lE+sAe5nUBqvKCBKTxknCx42i
        fIgI9Wib7jXvXCaUl9QI0dY3tnHf43xGZmJgEZoxEQ==
X-Google-Smtp-Source: ABdhPJxXNJ5er2bptuVybeBTe96h0U8ufAdgMDhfZnWJRD79gFPqAYeEfo4+/ynT0o+kO2+VTDRRV5Xudthz7jyEzxI=
X-Received: by 2002:a17:906:d285:: with SMTP id ay5mr960608ejb.418.1621271430280;
 Mon, 17 May 2021 10:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210419213636.1514816-1-vgoyal@redhat.com> <20210419213636.1514816-3-vgoyal@redhat.com>
 <20210420093420.2eed3939@bahia.lan> <20210420140033.GA1529659@redhat.com>
 <CAPcyv4g2raipYhivwbiSvsHmSdgLO8wphh5dhY3hpjwko9G4Hw@mail.gmail.com> <20210422062458.GA4176641@infradead.org>
In-Reply-To: <20210422062458.GA4176641@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 May 2021 10:10:19 -0700
Message-ID: <CAPcyv4jukTfMroXaw+zWELp4JM=kbBaitG1FGwFhxP7u1yQMBA@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 2/3] dax: Add a wakeup mode parameter to put_unlocked_entry()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:25 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 21, 2021 at 12:09:54PM -0700, Dan Williams wrote:
> > Can you get in the habit of not replying inline with new patches like
> > this? Collect the review feedback, take a pause, and resend the full
> > series so tooling like b4 and patchwork can track when a new posting
> > supersedes a previous one. As is, this inline style inflicts manual
> > effort on the maintainer.
>
> Honestly I don't mind it at all.  If you shiny new tooling can't handle
> it maybe you should fix your shiny new tooling instead of changing
> everyones workflow?

Fyi, shiny new tooling has been fixed:

http://lore.kernel.org/r/20210517161317.teawoh5qovxpmqdc@nitro.local

...it still requires properly formatted patches with commentary below
the "---" break line, but this should cut down on re-rolls.

Hat tip to Konstantin.
