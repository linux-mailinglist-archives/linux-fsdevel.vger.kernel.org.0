Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6531C28087F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgJAUds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 16:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAUdr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:33:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419F9C0613D0
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2020 13:33:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id md26so4339280ejb.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2020 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqD5414H2vh/oHhxr4gWzyumwIRB3ByZyFQXRFv8xkI=;
        b=pi70V7/gLqmGu/dKXbW+6FpTg2vXhTfoN1OAknXeP4k49jJ7B7UZqW7VEGYIBRxa4J
         aoWDSN26eY3aON1bXHsHwxlp3CHD7k431bSR1UvGE20hcsNyi+/L8xH1OxeZXGbGF9oz
         ZLY0Y159LOCUA8zCGR1dbsm7pLozoNYH8GwNwdiAUaWR61WWM1cLUbOKP7CfNn3x0JB6
         ZoGZsmCHCvr6J7AfZoAimA4vomcloOw0GjN91y8F/hYKbamnu7KWPz/fjuwNCOCuOSq1
         jEfpf8NItXj1KfT4yrHB4ASTKNPGRGRB0nA91OXN1EW2WW8sWTiwz9xJ9U8NToEnbQ3z
         gv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqD5414H2vh/oHhxr4gWzyumwIRB3ByZyFQXRFv8xkI=;
        b=J3XC2c/Mw29gJTZQn5GaT+/jmzoweuLj88hJpgHoJJgGKLbhMpwxdodKn05taB8Qam
         Y3pyKyEGprzhyVUgZGmH/BxCixHWfPrT+ooI7WOu4msNajc5Xc3lARhT/0b4TdgEezJl
         6kz+muON4qI30sTocSEhPGFT8pKV24o/+UWVViqsXHkReDBu22d7mq2AK5z5lGaSaprH
         Vd5pAjOnPWgPaDn+Ov2qomnQ4BYNQk/xshWonALQb1PauINJ6BvnA/IEmBtH2dLhQhVq
         g+QsFQsCzHOx/jI+pWgAuNjcIUii8+58RGTBrQKfa6ymSJBiF9tZMXPpKlncK1UBQ09Y
         l1GQ==
X-Gm-Message-State: AOAM530BD6hEfgmIVvc/eo+MIyrtauEfTkjYQtv2PO3/i9IuQf3zip58
        mnsJdMpvc1xUOCizbhNvkbtUaZ8yQPtONgacjd1L
X-Google-Smtp-Source: ABdhPJxll4xsFxxmUGYi+l9TqLqMqug55YxXTtXDOkeoST+CE1sfprMbYfpBRw4R7McWr1tZJWrcxaQqRohIqfrQWmU=
X-Received: by 2002:a17:906:14ca:: with SMTP id y10mr9861383ejc.542.1601584424728;
 Thu, 01 Oct 2020 13:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <2745105.e9J7NaK4W3@x2> <20201001101219.GE17860@quack2.suse.cz> <20201001102419.GF17860@quack2.suse.cz>
In-Reply-To: <20201001102419.GF17860@quack2.suse.cz>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Oct 2020 16:33:33 -0400
Message-ID: <CAHC9VhQoc+wXqyQ76bjjYKR+KhMaj7K_p8vEh1=nR_RPMvN2Ww@mail.gmail.com>
Subject: Re: [PATCH 2/3] fanotify: define bit map fields to hold response
 decision context
To:     Jan Kara <jack@suse.cz>, Steve Grubb <sgrubb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-audit@redhat.com,
        Amir Goldstein <amir73il@gmail.com>,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 1, 2020 at 6:24 AM Jan Kara <jack@suse.cz> wrote:
> On Thu 01-10-20 12:12:19, Jan Kara wrote:
> > On Wed 30-09-20 12:12:28, Steve Grubb wrote:
> > > This patch defines 2 bit maps within the response variable returned from

Please use "bitmaps" instead of "bit maps".

> > So how likely do you find other context types are or that you'd need to
> > further expand the information passed from userspace? Because if there are
> > decent changes the expansion will be needed then I'd rather do something
> > like:
> >
> > struct fanotify_response {
> >       __s32 fd;
> >       __u16 response;
> >       __u16 extra_info_type;
> > };
> >
> > which is also backwards compatible and then userspace can set extra_info_type
> > and based on the type we'd know how much more bytes we need to copy from
> > buf to get additional information for that info type.
> >
> > This is much more flexible than what you propose and not that complex to
> > implement, you get type safety for extra information and don't need to use
> > macros to cram everything in u32 etc. Overall cleaner interface I'd say.

Yes, much cleaner.  Stealing bits from an integer is one of those
things you do as a last resort when you can't properly change an API.
Considering that APIs always tend to grow and hardly ever shrink, I
would much prefer Jan's suggestion.

> Now I realized we need to propagate the extra information through fanotify
> permission event to audit - that can be also done relatively easily. Just
> add '__u16 extra_info_type' to fanotify_perm_event and 'char
> extra_info_buf[FANOTIFY_MAX_RESPONSE_EXTRA_LEN]' for now for the data. If
> we ever grow larger extra info structures, we can always change this to
> dynamic allocation but that will be only internal fanotify change,
> userspace facing API can stay the same.

That fanotify/audit interface doesn't bother me as much since that is
internal and we can modify that as needed; the userspace/kernel
fanotify API and the audit record are the important things to focus
on.

Simply recording the "extra_info_type" integer and dumping the
"extra_info" as a hex encoded bitstring in the audit record is
probably the most future proof solution, but I'm not sure what Steve's
tooling would want from such a record.  It also seems to be in the
spirit of Steve's 3/3 patch.

-- 
paul moore
www.paul-moore.com
