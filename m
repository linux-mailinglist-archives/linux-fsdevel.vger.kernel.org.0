Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06B4B7B588
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 00:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfG3WPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 18:15:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36300 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfG3WPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:15:43 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so28232060iom.3;
        Tue, 30 Jul 2019 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eJWTXDTsE+z8vuI+3+Qq5diLIDrFR4TuvgdInaKarkA=;
        b=cceTkrjEHo1IVeZWBhk/wi74szSDUuElNWxyWZ9zgPfMQsj0xiNXErA4Ip3Qub2NBU
         aK4zcsxJNL6yGDgvSNU4l3Dz8p2FASqASrIQngRH42ly+ZJJqCt6XF2xW52MHu7UyE6p
         /qljE1Oj+8Hjta/HXbKN3wqKEcRZfGei88rf8iNgT7t2YFZjuQyrUk1M/3r9a/Ne5DgG
         xm3Y9plTVZiAtnbOymCCpefjPufDwpHrSG2ANlrYGA3l6sHpmVoWZ0O7E5S5eeNqDQAr
         O/dUdT8JMSKBvLqkbnYTYSxSfwZlgaTSpI2fbAgOXvGYwBcduzOGfRVbK1ZlIX6bCno2
         JFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eJWTXDTsE+z8vuI+3+Qq5diLIDrFR4TuvgdInaKarkA=;
        b=R8yjoOs8+WuRdavEjorSjOVS50XRtTOPirW7SB4J6yvXDsJAjbwsiCgfJ4EgMlKFts
         hsQEgN6VR0m76MQBwK9wqv6N6B2kno+MYAZFpDqsbc3/AneZe8IbNNi0oLGoas/S4Sfz
         NzvBi1Yi6q/OrAMc51yX4npDQLMVhDNUdPWLbyZXu4AkdMggHQg5Rnv3PwPxHiEBPtdh
         z2DLshXQH6Nd5raENdboPeydze6cluIXf1rTGoOx79kWkmFjoffMOXCSH0Dc0bdqw5Pt
         N4hRp1iSikAXxpwnKEWKb8PfJjQp2jH+a/x6yRkMeOz86IuRudg0T7lLRAnqYjomkPbB
         JQHQ==
X-Gm-Message-State: APjAAAX952354ZsIFlV2Fj0pkyk9rgQDRZ5D/LzpXpLv2JIdMxH/C3/J
        51/yLMhZgtslnarlRQw132vpS6KApOxQdq9p0Qs=
X-Google-Smtp-Source: APXvYqzacbhzX6CmRaif1jdwGFgTYO3dYaLxT/41iTKcLbynfkFATjOsa1NpAW9so1aVjlBxmgqjRRu36ogOi52OC3g=
X-Received: by 2002:a02:662f:: with SMTP id k47mr121858178jac.4.1564524941279;
 Tue, 30 Jul 2019 15:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190730113708.14660-1-pagupta@redhat.com> <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
 <20190730190737.GA14873@redhat.com> <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
 <20190730220102.GA15604@redhat.com>
In-Reply-To: <20190730220102.GA15604@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 30 Jul 2019 15:15:30 -0700
Message-ID: <CAA9_cmd8to1108H+osSuyyRriX50-g1YV3YebJ=PNsKbW0NPFw@mail.gmail.com>
Subject: Re: dm: fix dax_dev NULL dereference
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 30, 2019 at 3:01 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> On Tue, Jul 30 2019 at  5:38pm -0400,
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > On Tue, Jul 30, 2019 at 12:07 PM Mike Snitzer <snitzer@redhat.com> wrote:
> > >
> > > I staged the fix (which I tweaked) here:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e
> >
> > Thanks for picking this up Mike, but I'd prefer to just teach
> > dax_synchronous() to return false if the passed in dax_dev is NULL.
> > Thoughts?
>
> I considered that too but I moved away from it because I'm so used to
> the various block interfaces requiring the caller pass a non-NULL
> pointer (e.g. request_queue):
>
> $ grep -ri return drivers/md/dm-table.c | grep \&\&
> drivers/md/dm-table.c:        return dev->dax_dev && dax_synchronous(dev->dax_dev);
> drivers/md/dm-table.c:        return q && blk_queue_zoned_model(q) == *zoned_model;
> drivers/md/dm-table.c:        return q && blk_queue_zone_sectors(q) == *zone_sectors;
> drivers/md/dm-table.c:        return q && (q->queue_flags & flush);
> drivers/md/dm-table.c:        return q && blk_queue_nonrot(q);
> drivers/md/dm-table.c:        return q && !blk_queue_add_random(q);
> drivers/md/dm-table.c:        return q && !q->limits.max_write_same_sectors;
> drivers/md/dm-table.c:        return q && !q->limits.max_write_zeroes_sectors;
> drivers/md/dm-table.c:        return q && !blk_queue_discard(q);
> drivers/md/dm-table.c:        return q && !blk_queue_secure_erase(q);
> drivers/md/dm-table.c:        return q && bdi_cap_stable_pages_required(q->backing_dev_info);
>
> I'm fine with however you'd like to skin this cat though.
>
> Just let me know and I'll keep/drop this patch accordingly.

Ok, since you've already got it queued, and there are no other
required "if (!dax_dev)" fixups go ahead with what you have.

    Acked-by: Dan Williams <dan.j.williams@intel.com>

I just reserve the right to go push it down a level if the kernel ever
grows more dax_synchronous() users that do that safety check.
