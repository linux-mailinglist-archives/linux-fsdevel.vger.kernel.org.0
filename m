Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59261BF39B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD3I6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 04:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgD3I6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:58:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BCFC035494
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 01:58:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k8so4058384ejv.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2020 01:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kw+MyCs5dnbWUnTLkNShmUXXjXtDqqnuyJ0rA7GvwNk=;
        b=rR0MeDwLsqLjJaQdT1+3OxUtjA48WjUu9U89zLWzhaRRkxBJYsDbWWgFlryNlBJuWS
         RlC15OhCP+UiHqNZ3K5zasmIuk0uZbtd9IbSkW+UN8FMW9o+hs+dsejvZd2B3MKUrYBe
         BlxJv71jqbQ6BAu+sZrbMcTn/GEPNA3Zfdwzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kw+MyCs5dnbWUnTLkNShmUXXjXtDqqnuyJ0rA7GvwNk=;
        b=BHKx2ongPIB5PMasO7g2EiTeWOplwu7Oa0ZnYYCShUUGjnPtmwLCK/yYi+jvyg8D1A
         j8QzgI+vLiTOni9BjDQ+yXdVf5qsN+LwbBl2b01acNVnyhhymNSMUF1ozK4bldOWbwnx
         J64xYsrF3fkPxsd7Ztydj0Bsvq7YyQSkTLqGVftK56vXY6Q2aoBG8jnsJQgCOF7KSoZ5
         wRPPtzHMRRzjQe1MwvbtvVhAjGUdn3kLjN4c2mZ+qQO3bTfpNbF6w0hA+MUeFjCWdk2d
         bJf6Puq+6JBNrn3NqgueFy1WgtqZTYxo7VX1wyWIxyNlTidmZmtOZNcD7ud4uV+nipo1
         2O1g==
X-Gm-Message-State: AGi0PuazJV3i8zZwr0YCOZ7g8JsMcvfCokAjLQ9NOlZRSoF9vMdpLZ0J
        lCORBBxAITcozoIBdJLhb5raqh61RQ4ZAX9oWmMelQ==
X-Google-Smtp-Source: APiQypJv8Ln6ovkcVWMQJ8v0WFDp/TJibJtI/QxfXgSqPpbZ2gOXoeHTVwvyhAaUV+24TjAqtrmn8OFO5OYT3/t1UPk=
X-Received: by 2002:a17:906:8549:: with SMTP id h9mr1670848ejy.145.1588237133730;
 Thu, 30 Apr 2020 01:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200427180354.GD146096@redhat.com>
In-Reply-To: <20200427180354.GD146096@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 30 Apr 2020 10:58:42 +0200
Message-ID: <CAJfpegunz80iFEvW=OhFHuHe4Zyb3isDBZKqCcLLGcRZp1PVmg@mail.gmail.com>
Subject: Re: [PATCH] fuse, virtiofs: Do not alloc/install fuse device in fuse_fill_super_common()
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Chirantan Ekbote <chirantan@chromium.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 27, 2020 at 8:04 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> As of now fuse_fill_super_common() allocates and installs one fuse device.
> Filesystems like virtiofs can have more than one filesystem queues and
> can have one fuse device per queue. Given, fuse_fill_super_common() only
> handles one device, virtiofs allocates and installes fuse devices for
> all queues except one.
>
> This makes logic little twisted and hard to understand. It probably
> is better to not do any device allocation/installation in
> fuse_fill_super_common() and let caller take care of it instead.

I don't have the details about the fuse super block setup in my head,
but leaving the fuse_dev_alloc_install() call inside
fuse_fill_super_common() and adding new
fuse_dev_alloc()/fuse_dev_install() calls looks highly suspicious.

Thanks,
Miklos
