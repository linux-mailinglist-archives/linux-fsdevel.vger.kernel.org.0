Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0026E6D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 22:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIQUhy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIQUhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:37:54 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE834C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 13:37:53 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e7so3034485qtj.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 13:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QiQ0kO+8lF/Z138k7zUyPtaMOwszzsTtEfF+Vg9q0h4=;
        b=YROCZWIAQseUE6Pl4bXAkOl5BXyaq743DVnwo3GY/4Z7fRZLoQv1lKcEz/URHdJjB9
         tnWU4F29xgaGWiuCuCLimFbC94YyficR49QoVZFc0Fcv1qXRGBy0ZTdy8NS31i+syOeu
         sh91rMAIkqI+qppdXU+BgDsnBRIkK2LbBRXRRWRd1cfP3cS9Kqre9nmUiRf0lxElVBiU
         EbuW0fcGzF9j03ZUU/54oFVJZQRb8b+iUeEKELtVDnbGUZhF5vYCG/rCesI9UIl7XIvr
         WnVAdiHsO0xhzbZVlHga8BUFTyv35oj0DnsfqSh39IxW0hluzFdWF6ixMwavteUcg65a
         Uxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QiQ0kO+8lF/Z138k7zUyPtaMOwszzsTtEfF+Vg9q0h4=;
        b=RVEmxSubSDOJWjRQUPfw0w3RW80kqSg9phyGQrAfX0TrClNBH4VH+9C0W77XboQJQN
         MfrpgjbFbT7nXz3FmUpVO4AiHeqmgJDhq+JeCOcaNUFXqlWOLrtLD1pgTOJEPPT9HAdl
         jFcwL3efC6h2s/DtNdhhadCOFLvcF/SpRqzQbqYeJSirkVkORuGSqUwkE1TPXQ+uHyou
         QhALDqCDktWexkCJ8DZEOJrMfv4TkwLVKGYrFJus/ZPguzxjzATTZ+UudCyXj++swcJ4
         jAqYzS1lk2QyYgeycIBCI2r7zlJzJACio6RzhCAB5nq4s6fX2NghGTZtppLk0rlV5DZ4
         QEFg==
X-Gm-Message-State: AOAM533kTvCPKZIlhuQBpfev18xoh92UnSrui5jaTrQCk5/rksOraN/x
        SqyImg9pA77SR9UB/VAYoOt1Jw==
X-Google-Smtp-Source: ABdhPJwHbSwIxtvxBYMEmQf7fuQnPjJ7tGr56g7apVRDeWG8zJzSIvcuo3Xh7jFIOxeDT3zAnhE4dw==
X-Received: by 2002:ac8:100c:: with SMTP id z12mr29015990qti.81.1600375072316;
        Thu, 17 Sep 2020 13:37:52 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:2003:d617:ca70:4fd1])
        by smtp.gmail.com with ESMTPSA id v131sm667025qkb.15.2020.09.17.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 13:37:51 -0700 (PDT)
Date:   Thu, 17 Sep 2020 16:37:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] sha1-file: fsync() loose dir entry when
 core.fsyncObjectFiles
Message-ID: <20200917203749.GA1589021@nand.local>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-2-avarab@gmail.com>
 <20200917140912.GA27653@lst.de>
 <20200917145523.GB3076467@coredump.intra.peff.net>
 <20200917145653.GA30972@lst.de>
 <xmqqzh5os9cg.fsf@gitster.c.googlers.com>
 <20200917171212.GA3732163@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200917171212.GA3732163@coredump.intra.peff.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 01:12:12PM -0400, Jeff King wrote:
> On Thu, Sep 17, 2020 at 08:37:19AM -0700, Junio C Hamano wrote:
> > Am I reading the above correctly?
>
> That's my understanding. It gets trickier with refs (which I think we
> also ought to consider fsyncing), as we may create arbitrarily deep
> hierarchies (so we'd have to keep track of which parts got created, or
> just conservatively fsync up the whole hierarchy).

Yeah, it definitely gets trickier, but hopefully not by much. I
appreciate Christoph's explanation, and certainly buy into it. I can't
think of any reason why we wouldn't want to apply the same reasoning to
storing refs, too.

It shouldn't be a hold-up for this series, though.

> It gets a lot easier if we move to reftables that have a more
> predictable file/disk structure.

In the sense that we don't have to worry about arbitrary-depth loose
references, yes, but I think we'll still have to deal with both cases.

> -Peff

Thanks,
Taylor
