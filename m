Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83032BB7B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfIWPTP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:19:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43767 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfIWPTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:19:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so15770455qke.10;
        Mon, 23 Sep 2019 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BvW4XrcJWJ2oTXG4RUy/CKw7q4mi60s93JIV6af2rgQ=;
        b=kZ9aYPC16gNRz8i6VP9vO/K4GSoP3wLXMPBBsvZekcVzoYCp/ynmSRnetM732vuOVt
         OplO7ek58sNltclJVPlLk3kXaWOY0/aKmhkIGg/ZzyowhzqQUH1704eivsGOhumopc0r
         QwYRF1yD3mYkDkXi89VJAG8h7DHCWbt3vyQGbhgozsC7BEsdu8Pa8lYemXVkNKbfNRyq
         9z4vXH6unj3EQUqEzNrtgWBcwkyLUl7UQ0NNDlmcHhAcaHpgREmhh4sGDh3l/6f5ffVN
         FoJpE/QOETTp9mQCKVr5lc5jEkxhyokKa2fOASiGdNRQPkiyxgIBLN1SLU5HridFuQl+
         JqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BvW4XrcJWJ2oTXG4RUy/CKw7q4mi60s93JIV6af2rgQ=;
        b=ab5R/KqifupnEDqe79PaHxutO2Ta+oOTf59Spqmmr9Ri8pq55Egq4pfdaF6jjJsQI1
         J1nKTDHPF1umzevY4b+MsIScbyAxnChtLqavgbH+HZwJzRr/IOHbdEo8TPmgM9D4h/SU
         A5nURPk1xBlckKxHQNehZN8p6x3cvdKG9Tho7zG0PysINscm1VZ7TvlUhKobXg0qyy72
         iqdHoijlsvAvt06iCdapKsJ2HktemgVB1She5xkkBcOOw3l4LKGy4YRoe3qAPGraZeCK
         SM41simnrW1EG6zzvjncYw8AOx8bnXxCX5CLO/WBApBxrgGuITV4CNl2iIbOKsiUjT6/
         YKiw==
X-Gm-Message-State: APjAAAWq3crtVdIFXia0Hc9AD6XQZhwdC5MK363EfsOa9Y7ZFIcaCGnj
        i06xUyAfj21QBvUMRws+Byk=
X-Google-Smtp-Source: APXvYqwI5hVrjpHY8AFygfYIP1Y4nxJNb5fZko8g6cKD6P/lKgXS9sB7qIB/Epsms0XVHt1hGghPxg==
X-Received: by 2002:a37:4794:: with SMTP id u142mr303789qka.265.1569251954464;
        Mon, 23 Sep 2019 08:19:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:83ca])
        by smtp.gmail.com with ESMTPSA id q44sm6356054qtk.16.2019.09.23.08.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 08:19:13 -0700 (PDT)
Date:   Mon, 23 Sep 2019 08:19:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190923151912.GG2233839@devbig004.ftw2.facebook.com>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
 <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Mon, Sep 23, 2019 at 06:06:46PM +0300, Konstantin Khlebnikov wrote:
> On 23/09/2019 17.52, Tejun Heo wrote:
> >Hello, Konstantin.
> >
> >On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
> >>With vm.dirty_write_behind 1 or 2 files are written even faster and
> >
> >Is the faster speed reproducible?  I don't quite understand why this
> >would be.
> 
> Writing to disk simply starts earlier.

I see.

> >Generic write-behind would definitely have other benefits and also a
> >bunch of regression possibilities.  I'm not trying to say that
> >write-behind isn't a good idea but it'd be useful to consider that a
> >good portion of the benefits can already be obtained fairly easily.
> >
> 
> I'm afraid this could end badly if each simple task like file copying
> will require own systemd job and container with manual tuning.

At least the write window size part of it is pretty easy - the range
of acceptable values is fiarly wide - and setting up a cgroup and
running a command in it isn't that expensive.  It's not like these
need full-on containers.  That said, yes, there sure are benefits to
the kernel being able to detect and handle these conditions
automagically.

Thanks.

-- 
tejun
