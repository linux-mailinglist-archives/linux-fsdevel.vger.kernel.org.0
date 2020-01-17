Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E83E514085D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAQKvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 05:51:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44824 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgAQKvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:51:10 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so25460153iof.11;
        Fri, 17 Jan 2020 02:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPZgl/q3vIfnV2rf1MzWjb5AG5EqjQJkR1tLQ7+HViE=;
        b=UcD7lZoqdCKmmyidin5ILgMNLGITtnWVYg5U6qgBN3OKJX9tnuHAfbgsm8JJqgjRhx
         zocBJnxCLiRNbzmMpNQkCA9HZmsA65yWUcLaPWycg3x6g/HQQplFsvlb3N92Gj+D391I
         saehgHhAJBVNwhrQzHQsn6UL2Hro4bjML1DZsWY7Q5CDRgV9YbjLOI0ZkEaCngGQ0KPD
         CpDX4S3btG+Nbu6WAZTJEH5O409++Wycn/hxUG+a+ifCjIg/M6S7fd60qWGKcNwghhEc
         WZ5PUXt2oGFCQFKzcDvY8KhZvdmim0nBgYyEz/R2OKHh+mwN1TvhPaaBnMFXVs5ti/CH
         J0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPZgl/q3vIfnV2rf1MzWjb5AG5EqjQJkR1tLQ7+HViE=;
        b=DjPO5M655c3REglHsgTKTRI/TXU6Poi7LoCcPa6oIDt8INzCZErnIcNeVWyr3EHzmY
         vcuacI5k1mdxe5EoUVuKOA5kFo3x2QwUSjT8B8Mc7pjJ4UVAohPZthueH6Z/H2rnTB+i
         KoUWvU4N2Jb0/s7YRHx/FXzg25uQkFnQ58PQOgOAvZxf6Oid6YLpAcsWrcpHump0t8Ij
         aApiZT5K67rTqR3lqdDxs9qJydP3KxdzkDbUEJVOj87nCxOFrGroPHM5UaTAvrNYCyim
         o6W989sYoLsup0NKYwsXFE6t3ygW+bZ+kVhpKv3kTvn/VFEJibk6hDfFqJZb5lwWOcwc
         feaQ==
X-Gm-Message-State: APjAAAVjo6gATj3gpMVF754Izb0EVr8z284OxCI11tW2C1olJ0exlWgD
        74Qyjdcmyhi3Uhc5zaUK5o94JZMXS4q5bPzKUno=
X-Google-Smtp-Source: APXvYqysK2eTf49GiafHKvgR56da2irbgyCZ+FgusY/y8P/HNItR2DbQCVbsqL5oLa8EtQK2WbVUzonQKs1oPXlLUkU=
X-Received: by 2002:a5e:9907:: with SMTP id t7mr30947541ioj.72.1579258269524;
 Fri, 17 Jan 2020 02:51:09 -0800 (PST)
MIME-Version: 1.0
References: <20190829131034.10563-1-jack@suse.cz>
In-Reply-To: <20190829131034.10563-1-jack@suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Jan 2020 12:50:58 +0200
Message-ID: <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] xfs: Fix races between readahead and hole punching
To:     Jan Kara <jack@suse.cz>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 4:10 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> this is a patch series that addresses a possible race between readahead and
> hole punching Amir has discovered [1]. The first patch makes madvise(2) to
> handle readahead requests through fadvise infrastructure, the third patch
> then adds necessary locking to XFS to protect against the race. Note that
> other filesystems need similar protections but e.g. in case of ext4 it isn't
> so simple without seriously regressing mixed rw workload performance so
> I'm pushing just xfs fix at this moment which is simple.
>

Jan,

Could you give a quick status update about the state of this issue for
ext4 and other fs. I remember some solutions were discussed.
Perhaps this could be a good topic for a cross track session in LSF/MM?
Aren't the challenges posed by this race also relevant for RWF_UNCACHED?

Thanks,
Amir.
