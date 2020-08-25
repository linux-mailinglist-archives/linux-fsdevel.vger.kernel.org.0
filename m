Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2B251C52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Aug 2020 17:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgHYPc2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Aug 2020 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHYPc2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:32:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67BC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 08:32:27 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c10so11613065edk.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2020 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWUqkPjaP+eN5TBL4RC6KUdRAVxyQQc3cp7C2UlodlM=;
        b=g44fvTKtmJyTxm7JWmjW5kskx4wvpUqqr6cZOqfp22In3UghI2Riib/zCztP+ikm6j
         DgJWgD7gdgdd5X3xXnnXqpPRURPV/VcV4VNZKlZkUl7t860PfxO4p048n+/jzgoJ1IYA
         a+AJggGuQDyc8ohh9K7B5zLhPv3AvhFMHIPuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWUqkPjaP+eN5TBL4RC6KUdRAVxyQQc3cp7C2UlodlM=;
        b=uAZq3rjifDCrAzJkD5t7DUtg1qs1dqtJx53627DK1YP0fHUWLoUEFsdN0GAbx3byQ3
         +Hz9r1VPbvpaoZS813FGLV4zbkKvauXCrd+RDKFu5N0qnArAQIS4VOhr0CCXpKWqg8Ue
         QR05YrU0Y+ByHvMZcoyTj6V+AN1lK2tnKLQ0jWCrVbNKhTMvzh/Ye0Ta3GMkul238gp0
         1J86DpdCcAUUa1uUQIiqLPCrnwdTlPHK+7d+ghWJZRkxOCXpHPKaJZZmBIXgxytwtAfg
         vLDBvv6Unx9gPlrHucI5BnABNSPAYjGCHtTQcRyH1nKLA2bwJy8LcPbdeiZo11MPlEA+
         NTBg==
X-Gm-Message-State: AOAM531GVWhiAA4z80p2TA//uumonkXEHhBMvQIgvu/4WOLINROVcR8G
        mRoCsiExQW3zqYzWht/G2UDFg1FENrwl0y+u/wTnEg==
X-Google-Smtp-Source: ABdhPJxNmeZCFOIsdvj/Z3YQ9kd3aEBLLZs3ey5QNrFgmOesMW5wcTTYtKsRM8FtMrvaBbBLS8+Z5sRxxZifxLMZ4Rc=
X-Received: by 2002:a50:b022:: with SMTP id i31mr314437edd.17.1598369546344;
 Tue, 25 Aug 2020 08:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200824222924.GF199705@mit.edu> <3918915.AdkhnqkaGN@silver>
In-Reply-To: <3918915.AdkhnqkaGN@silver>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 25 Aug 2020 17:32:15 +0200
Message-ID: <CAJfpegt9Pmj9k-qAaKxcBOjTNtV5XsTYa+C0s9Ui9W13R-dv8g@mail.gmail.com>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 25, 2020 at 5:12 PM Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:

> I can give you another argument which might be more convincing to you: say you
> maintain a middleware lib that takes a path as argument somewhere, and that
> lib now gets path="/foo//bar". How could that lib judge whether it should a)
> eliminate the double slash, or rather b) it was really meant to be fork "bar"
> of file "foo" and hence shall pass the string as-is to underlying
> framework(s)? Simply: It can't, as it requires knowledge from either upper or
> lower end that the lib in the middle might not have.

Nobody needs to care, only the level that actually wants to handle the
alternative namespace.  And then that level absolutely *must* call
into a level that it knows does handle the alternative namespace.

Yeah, it's not going to suddenly start to  work by putting "foo//bar"
into an open file dialogue or whatever.   That's not the point, adding
that  new interface is to enable *new* functionality not to change
existing functionality.  That's the point that people don't seem to
get.

> > The most important thing, I think, is to not fragment the interface
> > further.  So O_ALT should allow not just one application (like ADS)
> > but should have a top level directory for selecting between the
> > various data sources.
>
> Well, that's what name spaces are for IMO. So you would probably reserve some
> prefixes for system purposes, like it is already done for Linux xattrs. Or do
> you see any advantage for adding a dedicated directory layer in between
> instead?

You mean some reserved prefixes for ADS?  Bleh.

No, xattr is not the model we should be following.

Thanks,
Miklos
