Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7399A459A36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 03:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhKWC52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 21:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhKWC52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:57:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B1C061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 18:54:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so1606676pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 18:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Al5JsM62A3tHtpfVSPPyo8ez+nZ96myx/BqVadpnmZE=;
        b=xC+R2Ze1hcDaIg+74cuixxadPvoKZHVUfRh3cG7NL6liGTAKRC1u/dtLV2Upl+DjCb
         lz8tF4p8hd5xqtUPL0FFIN4COIFn8gNO0kZEDg0AZkuF8D8jKwc0aEvQ7rx69yXQ0Onu
         ygsv6Lso/1XQ2tNifMHR6wKXy6FdeML5mJLZDRvnaAHvQPYqIVreOhkxmGyxQPa6SI/i
         eitCea7WNPUHw+NWqm+DDMhFpduBZks6zZt+EcfeE8ME4X0s0nFvXWdxr1dRMwydHs/r
         NeInAl4EFa9zlunOlALEVrXarilVx4ntLaJRr9tg/Qn0MoP7TxRpqBu+w38vRZVF2hEy
         GCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Al5JsM62A3tHtpfVSPPyo8ez+nZ96myx/BqVadpnmZE=;
        b=jM+QuizEh5Bg6C4S1kSemxtviMf364o8bApD22wwzuusisiyYIpDfo/K7hDZMZinwV
         Prdqp8rumLR90tCX5+AxqAIdBeYW+vAmhqF5CQjQuo8rdXwLbJYzHOmFK5DDzI9eF/6B
         SJAkbwkJ1WuUeut6OwVLcb/M/h/kQBZ7IpWzJceSbWOPh1I+k3NAabetnlM5GNJa/1f5
         XWHA1QlZfPSj2mIDYJ/Z5aX8sRTgdDnXOrr25DapulWPKGM8mX0k9Gx4fAxMdYPntUCY
         pd4fvYhlEHK+nRqSwXRu9rPidW/4ml5BHyxX7MC5SOVuNtN/d0s9jl0lgX3JU33K9fps
         C+Jw==
X-Gm-Message-State: AOAM533xxuLWSFq2gFuUwOlNY9Q3MVGvQLW7cuPswqN/mHfHy62WpZvo
        zOOijDIafBRChqr9wkte1FsqFxC4ELInzVEnL484vQ==
X-Google-Smtp-Source: ABdhPJzVmbqwkteuXJ4hKBjAQTD1mqO5WV/z0skpRbQzjFZ3o+tEVCfuAJYtWwfPr8oZjtyH1KqF3yLKCjaZBtlyJ4k=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr2220703pjb.93.1637636060294;
 Mon, 22 Nov 2021 18:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-3-hch@lst.de>
 <CAPcyv4iPOcD8OsimpSZMnbTEsGZKj-GqSY=cWC0tPvoVs6DE1Q@mail.gmail.com> <20211119065457.GA15524@lst.de>
In-Reply-To: <20211119065457.GA15524@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Nov 2021 18:54:09 -0800
Message-ID: <CAPcyv4iDujo8ZZp=8xNEhB3u6Vyc6nzq_THGiGRON7x3oi9enw@mail.gmail.com>
Subject: Re: [PATCH 02/29] dm: make the DAX support dependend on CONFIG_FS_DAX
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:55 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 17, 2021 at 09:23:44AM -0800, Dan Williams wrote:
> > Applied, fixed the spelling of 'dependent' in the subject and picked
> > up Mike's Ack from the previous send:
> >
> > https://lore.kernel.org/r/YYASBVuorCedsnRL@redhat.com
> >
> > Christoph, any particular reason you did not pick up the tags from the
> > last posting?
>
> I thought I did, but apparently I've missed some.

I'll reply with the ones I see missing that need carrying over and add
my own reviewed-by then you can send me a pull request when ready,
deal?
