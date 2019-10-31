Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5CEB45B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2019 16:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbfJaP5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Oct 2019 11:57:39 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39213 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfJaP5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Oct 2019 11:57:39 -0400
Received: by mail-il1-f193.google.com with SMTP id f201so181615ilh.6;
        Thu, 31 Oct 2019 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fMqgxCz9YeELky5sdMvqRGe8oe8TryFm0ddjx2jFJ8=;
        b=r2LAcakqEaUTEWVB42o7netz4E9VSlpCiF1h3M4FyqmZMW8hARpE28IicCl+YOx7cK
         wIYdFj49qzwuextspvTS4pX+SXfjLIQH5ePcrW24wrFI2FLPYPUJWlXcZK5vfQUYH0vM
         LDVsW0NrfZXiJiuQa2lgvWH+vqp5PLuOBFuN8dfnoxXb2ChS8BlOoPnJ44oH3vCkeE9r
         e7EaZZse7IDcGaylRdktf7O2XJMiLmms8LvvHOLxS4oGNFpEZb+kY2i5x5SAxqU2Otni
         sHQPudwD1eG2lPICtrGXqx1E0CmeCqZbtDV3Yd397iWEVLyCsSkk9zsjZIBQpoEfEhlU
         fUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fMqgxCz9YeELky5sdMvqRGe8oe8TryFm0ddjx2jFJ8=;
        b=tYJhUQYiPRhWk8CfaGeWA3C5WNuKjTxAuxGp2qT3xpch3eF6+rCKblZviMmMWG1iBk
         MuvxK3faCpJ+QfaXjW2FAXDz0gM8ueRVGujVMMsDwK8P0YlYKKfJM9gMWQSvbQo35JSn
         iQh1u8a6juw9opcB5NN642tlHdM4NQpp21QkLETaDaSVIWIQgzTjabJI965EmV/D/v6H
         CLHZEs5WFxB4VWd5LuysjnqTibuHL6NGLoxRgM8TQL4W1eAQlHjg4NsjQOfUG/GSnzJA
         64PBJLCNUUWW/wJqprnV5m65hZtmb6f/EwzZPiR0rqHvEIHtSDyfSgJOjgzY+V75jWzJ
         Vbwg==
X-Gm-Message-State: APjAAAUpnn9DIRCzU8vhxC8K2Fk8DXI1JWSCdQ9TAPn8hxEm07AYse8d
        nHy42b5LFHhwGJ7JNi+yMjRocNiCMQS6AVz6iHA=
X-Google-Smtp-Source: APXvYqxDzIvxdrtfoc1J6pHr6V7TIkjAtYww+JMfs2+Z9EUun1ZsfTWDhGu6aMUtGhRbc9znef8AcsrZINaCIzSjCbQ=
X-Received: by 2002:a92:b656:: with SMTP id s83mr6910636ili.282.1572537457279;
 Thu, 31 Oct 2019 08:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
 <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com>
 <4892d186-8eb0-a282-e7e6-e79958431a54@rasmusvillemoes.dk> <16620.1572534687@warthog.procyon.org.uk>
In-Reply-To: <16620.1572534687@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 31 Oct 2019 16:57:53 +0100
Message-ID: <CAOi1vP9GAmy5NXJisrDssspoRcc+UHum+cyBsJTMNTjz_jieoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 4:11 PM David Howells <dhowells@redhat.com> wrote:
>
> How about:
>
>  * We use head and tail indices that aren't masked off, except at the
>  * point of dereference, but rather they're allowed to wrap naturally.
>  * This means there isn't a dead spot in the buffer, provided the ring
>  * size is a power of two and <= 2^31.

To me "provided" reads like this thing works without a dead spot or
with a dead spot, depending on whether the condition is met.  I would
say:

>  * This means there isn't a dead spot in the buffer, but the ring
>  * size has to be a power of two and <= 2^31.

Thanks,

                Ilya
