Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3864D51C7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 22:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbfFXUi1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 16:38:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39277 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfFXUi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:38:27 -0400
Received: by mail-lj1-f196.google.com with SMTP id v18so13927314ljh.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 13:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1ni3gZJ5DTYbVR+EneqvuBS0klKngeeCXjk7sRCSGw=;
        b=Kq4O+bMGVFxakj9kxG9tRFGL2K0FolT9Gw9P0jU0osuV0wrn2LvztvEJI5K2gdqAdO
         BTY7iQchISdZJb8oUShzSbisNENbHBS1Npx38UjU4RvSM4S5t/DaY+p0iignOeyWElQw
         9E9YKGwdKIThg4sSe1kFEnbIZ1quXo9mGQXZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1ni3gZJ5DTYbVR+EneqvuBS0klKngeeCXjk7sRCSGw=;
        b=IOvLVCXJsY1c1MCx42diSWjRivRyU554Q/VptiwTq/PcIH413BhRuWHx8SeIlfJFkp
         ctV1zJ1w3cZi0W66W4kFzeGtZ3MHVVrD/2kzIQt4gWcKeozVRQolUmaIfTEWgOAZw+Cf
         5gkOBDYf91GAmwC70iLGviUs4YGRT8BX5ZaDipnoAfqJ8bQ3Qj7H9YKzXqjWoaexiYP7
         vIdfCSBHMv+hP/ZxhOAz2ZV8t06irQbra7gw1MTDSsJindFQGel+vwU2K/cut+tRzfWg
         yutiPKIwZ0Qfe4OwS+TX1GyhtEHpUmHJ9pU1lY/78LhJwpD08Nm0pEcd/lkOajK2dJfz
         cw7Q==
X-Gm-Message-State: APjAAAXTeOLvGJvjLFQCVz01+ukmUT5v9ku8Ryn3uk6OoCQPGPTPB/i0
        mDLQjE+pbphqxQOzKwZ2N59dpfBIJHI=
X-Google-Smtp-Source: APXvYqx0FdtSOvIVXpZVyV+Oxvs0ywysV2x/UjcTO3Xx0WGXKToicrzA72UkPZCKPCnYGgtYYVd+FQ==
X-Received: by 2002:a2e:5cc8:: with SMTP id q191mr54387751ljb.118.1561408704423;
        Mon, 24 Jun 2019 13:38:24 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b6sm1910089lfa.54.2019.06.24.13.38.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:38:23 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h10so13971709ljg.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 13:38:23 -0700 (PDT)
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr13248937ljj.156.1561408702960;
 Mon, 24 Jun 2019 13:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190624144151.22688-1-rpenyaev@suse.de>
In-Reply-To: <20190624144151.22688-1-rpenyaev@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jun 2019 04:38:06 +0800
X-Gmail-Original-Message-ID: <CAHk-=wgQaCDiH09ocVA=74ceg9XyS=kRDF5Hi=783shCaKVRWg@mail.gmail.com>
Message-ID: <CAHk-=wgQaCDiH09ocVA=74ceg9XyS=kRDF5Hi=783shCaKVRWg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] epoll: support pollable epoll from userspace
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Azat Khuzhin <azat@libevent.org>, Eric Wong <e@80x24.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:42 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> So harvesting events from userspace gives 15% gain.  Though bench_http
> is not ideal benchmark, but at least it is the part of libevent and was
> easy to modify.
>
> Worth to mention that uepoll is very sensible to CPU, e.g. the gain above
> is observed on desktop "Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz", but on
> "Intel(R) Xeon(R) Silver 4110 CPU @ 2.10GHz" measurements are almost the
> same for both runs.

Hmm. 15% may be big in a big picture thing, but when it comes to what
is pretty much a micro-benchmark, I'm not sure how meaningful it is.

And the CPU sensitivity thing worries me. Did you check _why_ it
doesn't seem to make any difference on the Xeon 4110? Is it just
because at that point the machine has enough cores that you might as
well just sit in epoll() in the kernel and uepoll doesn't give you
much? Or is there something else going on?

Because this is a big enough change and UAPI thing that it's a bit
concerning if there isn't a clear and unambiguous win.

               Linus
