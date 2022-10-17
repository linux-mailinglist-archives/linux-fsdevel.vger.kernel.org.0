Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B36C600726
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 08:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJQG7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 02:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJQG7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:59:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4211819281;
        Sun, 16 Oct 2022 23:59:07 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id j23so12798141lji.8;
        Sun, 16 Oct 2022 23:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3eKWV3ZnNjGmxLIU+eSsnyLxu6igTVT8zL8/KZHEyfE=;
        b=ULCMVuisMAVondNv3Qbd6taxl1211DmPh5RUhFIO3JzsPKLGMG4WHSWy92PX0ZRQb9
         dCg0XTX2vcYf8McVzR9AxFC0d9pcE3rc7gpIqm7weeuvAzu0J0mBxQqaY5Nq04w4zsRF
         eJz4VYLwSt5hfhpujxeVUSt32FihHROSDmRV5Z9sEUOOHkLG6ySzqh4JmMKyQxY65bKC
         UNbtoMQ6IWMpH4SqIzofi4Xdi4SS71tSZ1OIAeE2HUqhWseSNq1ABF2frDCLu0n0msD7
         /8hvIqm78IDifI5qOuX/rRoyxmspOOHZeoRv2vfDVqHvmaGNASYcUrylAH+wJrissucT
         PLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3eKWV3ZnNjGmxLIU+eSsnyLxu6igTVT8zL8/KZHEyfE=;
        b=oWK9jVk6R1a1kSVq4igLwSeLfdQ+XnqFXNVGUl82zX45fHEmeIVOWBtkugubInUpEj
         yU7GuBDWqCMi9lw84ufCKZBshRBsiVMx4Iyw8zNZTI+rmwF2CvEqsvvUKvxObw5ytjAp
         BWyh9AU8b2VUfcLx0SMgFLKPsIZs2ljVIXpGYGWu+cpems9MWrVOb2m14ylxu2NAYSD3
         k02DYAoVxMPJhnIVfZ/1P47wH+8tnP22qZRcxatxNQr7xi1QjCf5uRoeuCMeyE633If8
         o2xfPQ3zvDBP5b7xIcAa+JQGE6LUIemYDipCS8RjZOIQ7wrGKEGnNynuTiiQmNIhDvaY
         /KqQ==
X-Gm-Message-State: ACrzQf0W2VpSrXclzGly1l8D21LeJpEzMD9tjCyRCfROnhoS3NcoWopK
        ZjghGGb7cA5CV07N6VG5Wde6DehaftLnrwUFI9q3jeHL49A=
X-Google-Smtp-Source: AMsMyM7frChQl+feuZyDV+ee1f4QRfiaspPBOzN9qzHg/ei+IIM3Q/XmXCurcINYzfwXfDhCMnmB0DldiPPlGchdlxM=
X-Received: by 2002:a2e:bea3:0:b0:26f:de79:dc2e with SMTP id
 a35-20020a2ebea3000000b0026fde79dc2emr3288714ljr.92.1665989945450; Sun, 16
 Oct 2022 23:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y0lSChlclGPkwTeA@casper.infradead.org> <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
In-Reply-To: <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 17 Oct 2022 14:58:36 +0800
Message-ID: <CAGWkznEAHh6=DEkHQVH+=tmi5VmG6Aduy-q2B7HRDhj4CAMjcA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 17, 2022 at 1:34 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > >
> > > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > > superblock's inode list. The direct reason is zombie page keeps staying on the
> > > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > > suggest skip this page to break the live lock as a workaround.
> >
> > No, the underlying bug should be fixed.
> >
> > >       if (!folio || xa_is_value(folio))
> > >               return folio;
> > >
> > > -     if (!folio_try_get_rcu(folio))
> > > +     if (!folio_try_get_rcu(folio)) {
> > > +             xas_advance(xas, folio->index + folio_nr_pages(folio) - 1);
> > >               goto reset;
> > > +     }
> >
> > You can't do this anyway.  To call folio_nr_pages() and to look at
> > folio->index, you must have a refcount on the page, and this is the
> > path where we failed to get the refcount.
> OK, could I move the xas like below?
>
> +     if (!folio_try_get_rcu(folio)) {
> +             xas_next_offset(xas);
>               goto reset;
> +     }
sorry, It seems the above suggestion doesn't break the loop. update it
by moving one step and goto retry instead of restarting from ROOT.
      if (!folio_try_get_rcu(folio)) {
              xas_next_offset(xas);
               goto retry;
      }
