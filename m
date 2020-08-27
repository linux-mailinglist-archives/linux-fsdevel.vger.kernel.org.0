Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C140253EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 09:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH0HLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 03:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726826AbgH0HLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598512295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wA1E5VINX4qFtBzgdOzHpby4Hxj21VGI22LvPkpMV1U=;
        b=ew+QOu9+yZBKWVD1bgmuNZs6AK4oxgHTlR4QCagvL2Em0XeFVD+9XUoKDS94Io9nhPPIo5
        V5T5cqWMRrBa9NrtonaAvABW+X9cUCyHzrWqipp9gqfKutOTHKd4nByfOR/pM3jbqv5Y8X
        8yNg4Yj65UF+eBA7g1RP9xAzNftfTck=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-tb1SvpSyMYebHxO1dgrxlA-1; Thu, 27 Aug 2020 03:11:34 -0400
X-MC-Unique: tb1SvpSyMYebHxO1dgrxlA-1
Received: by mail-wr1-f71.google.com with SMTP id y6so1153046wrs.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 00:11:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wA1E5VINX4qFtBzgdOzHpby4Hxj21VGI22LvPkpMV1U=;
        b=KnKINbD+9/XPVj6yTLskZvc7HSFwdts2bZvD+MWeOuHUU5NbQsDdVM3swFGMx69ox8
         dKJHy0+ey8TeDLOlQRGMrZqcxQ7jH781i4TIWQeItgYqhkSJrPYIXOQMNA8ufBp56hX6
         XAd5eWkpPu2ftwr7HPdjACT8CjE88hxBr8HJBL66UrUzjhkpuf7KSNVsxprwWK+UoKvV
         M3ET+vYiwGyljXPduzjhBCVOykflKe15jQkiR0Z2+sbmv/13lVPCHww7eh4MAr/2FMrc
         mnOA4JPTZMXMD9J2/PRHJvOggZbuii2oq+rIBAZMHEBqGTUi5OV0lfUytlVJZ5DkmQBn
         Y7+Q==
X-Gm-Message-State: AOAM533DZLC+r4KIVfyADbQ3ctlDzMrDAVzuCoJKBplTvinnUyvXJZvd
        lQlYYTsCt4D2S9mfRFBjf53RgbrDc8MpfzxL71lwc7JHipmnEqSZaI//mU4jW9xKWLcR4Ozen+t
        LsXACmJOsmrYzS6m9E3D+/tK+rQ==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr5699020wmg.92.1598512292923;
        Thu, 27 Aug 2020 00:11:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQLLfupwT3htk3SZsVuWhYX6+i7LaFRQaqAJ1Z0qPYkQk0csrl0zkKVvfPCI25zfzRfGsBQw==
X-Received: by 2002:a1c:e1d6:: with SMTP id y205mr5698987wmg.92.1598512292689;
        Thu, 27 Aug 2020 00:11:32 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id v3sm3099244wmh.6.2020.08.27.00.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:11:32 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:11:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>,
        Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>, io-uring@vger.kernel.org
Subject: Re: [PATCH v4 1/3] io_uring: use an enumeration for
 io_uring_register(2) opcodes
Message-ID: <20200827071127.iqq4gt3d5bpsq4xu@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-2-sgarzare@redhat.com>
 <202008261241.074D8765@keescook>
 <C1F49852-C886-4522-ACD6-DDBF7DE3B838@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C1F49852-C886-4522-ACD6-DDBF7DE3B838@dilger.ca>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 26, 2020 at 01:52:38PM -0600, Andreas Dilger wrote:
> On Aug 26, 2020, at 1:43 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> > On Thu, Aug 13, 2020 at 05:32:52PM +0200, Stefano Garzarella wrote:
> >> The enumeration allows us to keep track of the last
> >> io_uring_register(2) opcode available.
> >> 
> >> Behaviour and opcodes names don't change.
> >> 
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >> include/uapi/linux/io_uring.h | 27 ++++++++++++++++-----------
> >> 1 file changed, 16 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> >> index d65fde732518..cdc98afbacc3 100644
> >> --- a/include/uapi/linux/io_uring.h
> >> +++ b/include/uapi/linux/io_uring.h
> >> @@ -255,17 +255,22 @@ struct io_uring_params {
> >> /*
> >>  * io_uring_register(2) opcodes and arguments
> >>  */
> >> -#define IORING_REGISTER_BUFFERS		0
> >> -#define IORING_UNREGISTER_BUFFERS	1
> >> -#define IORING_REGISTER_FILES		2
> >> -#define IORING_UNREGISTER_FILES		3
> >> -#define IORING_REGISTER_EVENTFD		4
> >> -#define IORING_UNREGISTER_EVENTFD	5
> >> -#define IORING_REGISTER_FILES_UPDATE	6
> >> -#define IORING_REGISTER_EVENTFD_ASYNC	7
> >> -#define IORING_REGISTER_PROBE		8
> >> -#define IORING_REGISTER_PERSONALITY	9
> >> -#define IORING_UNREGISTER_PERSONALITY	10
> >> +enum {
> >> +	IORING_REGISTER_BUFFERS,
> > 
> > Actually, one *tiny* thought. Since this is UAPI, do we want to be extra
> > careful here and explicitly assign values? We can't change the meaning
> > of a number (UAPI) but we can add new ones, etc? This would help if an
> > OP were removed (to stop from triggering a cascade of changed values)...
> > 
> > for example:
> > 
> > enum {
> > 	IORING_REGISTER_BUFFERS = 0,
> > 	IORING_UNREGISTER_BUFFERS = 1,
> > 	...
> 
> Definitely that is preferred, IMHO, for enums used as part of UAPI,
> as it avoids accidental changes to the values, and it also makes it
> easier to see what the actual values are.
> 

Sure, I agree.

I'll put the values in the enumerations in the v5.

Thanks,
Stefano

