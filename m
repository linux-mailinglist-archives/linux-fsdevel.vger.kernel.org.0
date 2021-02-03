Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA130DD8D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 16:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhBCPEZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 10:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbhBCPEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:04:04 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B5C06178A
        for <linux-fsdevel@vger.kernel.org>; Wed,  3 Feb 2021 07:03:18 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id v19so10113vsf.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Feb 2021 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=16cDNKxraA3jARSxbNqlIlmOE3npJRnOa9MH9uHHTKM=;
        b=IgyIS8cRCiVNUXTC+2WVbi+ZidgiMoLewT/JGLIKvrJMri9lw2Shh0SES2p++86DOD
         DjmFXxT3mWC8i7HegTGb8/5ye/98nC04js79jlDh0ejnE5lgrEv0JFXkvlsVXJy/Z9Co
         nA+j2eFBLFImXMFLvQ+Z2jsSRr1Up1Cpdbzko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=16cDNKxraA3jARSxbNqlIlmOE3npJRnOa9MH9uHHTKM=;
        b=H9+QXMNNjt5/aAJnH2yvAYM9sX+7gO7PFloHNn9j+S2IXeypB9lH1o5U1vFQ7p75dr
         1yrb+FYM4O8bnFapZzEU/wm+YTLByCvY7I8EhZGKvifPTFnBiIs0fiJ+s++xLQUHHJJs
         U1MJMVFXQ6vuTQOkIJ5ClAEG0mnq2CMcbC6nxmS5Gk1Q6/4gH/NyEY4lD7k0u+ACE1mc
         AzsFyGNfcI47OnlNNAkIafoLg3rFUIzXdRLNVVpTHteSiwGwcXIWOsPih0AnrD5qHUBD
         TCbK692U1rHsn24WzJS4xLkdF6t/N1Ye7AW2roYCEsmpOojOrflBaXw/FD4qQG/Kcg4k
         c/uQ==
X-Gm-Message-State: AOAM530BCYof5G08eqNMDpdAsjcU609huxoSYOhswQZyWRNMhLHUQmbP
        Z3FNSZO4HtFZSOwVVw0wO8mlKfFaTA9lnVXUnHPdBQ==
X-Google-Smtp-Source: ABdhPJyvk/QConD3gywUwGfKEASsYovv/QTdEyyM8SgVTja0saduihmUwwthGFAWt3bDkKKxgFdHCSdij8V8adGtJ5M=
X-Received: by 2002:a67:fb86:: with SMTP id n6mr1886934vsr.0.1612364597339;
 Wed, 03 Feb 2021 07:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20210203124112.1182614-1-mszeredi@redhat.com> <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org> <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
 <20210203142802.GA308988@casper.infradead.org> <CAJfpegtW5-XObARX87A8siTJNxTCkzXG=QY5tTRXVUvHXXZn3g@mail.gmail.com>
 <20210203145620.GB308988@casper.infradead.org>
In-Reply-To: <20210203145620.GB308988@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 3 Feb 2021 16:03:06 +0100
Message-ID: <CAJfpegvV19DT+nQcW5OiLsGWjnp9-DoLAY16S60PewSLcKLTMA@mail.gmail.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 3, 2021 at 3:56 PM Matthew Wilcox <willy@infradead.org> wrote:

> But let's talk specifics.  What does CIFS need to contact the server for?
> Could it be cached earlier?

I don't understand what CIFS is doing, and I don't really care.   This
is the sort of operation where adding a couple of network roundtrips
so that the client can obtain the credentials required to perform the
operation doesn't really matter.  We won't have thousands of chattr(1)
calls per second.

So I think the principle is more important than the details of the
current implementation.

And I'm saying that knowing that fixing up FUSE will be my
responsibility and it won't be trivial either.

Thanks,
Miklos
