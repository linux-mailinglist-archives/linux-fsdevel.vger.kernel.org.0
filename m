Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91F513D41A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 07:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgAPGFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 01:05:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42761 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729847AbgAPGFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 01:05:12 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so18342792otd.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 22:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKEanVLYKixbIE4jpjng52Wg/z0Mh1eAfP4hJSdIQE0=;
        b=fsNlBtGFziQY0A8zQejjqkkTuvqiwdIiAM7NACeEOxrAaoxzDd4fUjk9pwpqAIUvXJ
         cdDCKjUTJGaZHkHv0G5ee/JsbwsslnTNyPu9bqoswts39/75GIb/59yCbwuO1xPlgi3c
         f+VW6u6TSpKsnTkYP5lrw9eMUS+qyf9nS8llrLCzHtqnC0A8+9WP1s1jpoFVC48zw4nR
         NVsWjZ5qsu9jZPsaq387+XdtKQjAobHkTTamKsz9df6VShLY/jSMaIKhT//gj04wSyQB
         dgjbIZWVcmuv6zDtMtLARK6RBcjdJGnJuT7/m4Mi0K92sfnfQrOSyoSUt8DpH3L7o5oD
         9Oyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKEanVLYKixbIE4jpjng52Wg/z0Mh1eAfP4hJSdIQE0=;
        b=hKodMjlYD1cWw2EsRTRv/XbrIWO+7Miw0zdIt8l4/sbQFbSSVPOmmb2FIrVmGpbsTy
         fuSfjNJhwI8QG10BNJQ4Lo8koW8zVO/qu646PajlihqchAO4Y3rkVfWcB1jUzXLJhLHm
         zgQxLy+NeAGHRD/DflEFvd4ocl5jl20/F+AZvHEBBNEW/KOntxNj2lnNDmD3F/Mh94RG
         nSrU8/go5R1CsXoMi/MKc3YP/2KuzLcx3temRPHf9jg6VP84Ii2QODOSLHvLxcUnsi+U
         m6NsC1uI3Au2YMFV9ZZnBF8s3U6whEQ4XoCRkLCJF1L+/XethM9a7F05GJA/LssmnEkj
         NxYA==
X-Gm-Message-State: APjAAAU7bfit7Jt1Yb6JqtJyvSVnbRjXeRl89TKVmwjgg7Qaw3fmT4+a
        EMgPFP6AsvF70As95ElUTZG3/QDw07b1V+5EEZaAgg==
X-Google-Smtp-Source: APXvYqzEy+pngv/HMRf0P3fZnf1I8EeAbKVY4SqM8e/rzz5VxvD8FVTh6UXXEgSv+bh5N1RhUnQGLNyaWJI9Xe8L7mc=
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr740541oto.71.1579154711112;
 Wed, 15 Jan 2020 22:05:11 -0800 (PST)
MIME-Version: 1.0
References: <20200110192942.25021-1-ira.weiny@intel.com> <20200110192942.25021-2-ira.weiny@intel.com>
 <20200115113715.GB2595@quack2.suse.cz> <20200115173834.GD8247@magnolia>
 <20200115194512.GF23311@iweiny-DESK2.sc.intel.com> <CAPcyv4hwefzruFj02YHYiy8nOpHJFGLKksjiXoRUGpT3C2rDag@mail.gmail.com>
 <20200115223821.GG23311@iweiny-DESK2.sc.intel.com> <20200116053935.GB8235@magnolia>
In-Reply-To: <20200116053935.GB8235@magnolia>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 15 Jan 2020 22:05:00 -0800
Message-ID: <CAPcyv4jDMsPj_vZwDOgPkfHLELZWqeJugKgKNVKbpiZ9th683g@mail.gmail.com>
Subject: Re: [RFC PATCH V2 01/12] fs/stat: Define DAX statx attribute
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 9:39 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
[..]
> >         attempts to minimize software cache effects for both I/O and
> >         memory mappings of this file.  It requires a file system which
> >         has been configured to support DAX.
> >
> >         DAX generally assumes all accesses are via cpu load / store
> >         instructions which can minimize overhead for small accesses, but
> >         may adversely affect cpu utilization for large transfers.
> >
> >         File I/O is done directly to/from user-space buffers and memory
> >         mapped I/O may be performed with direct memory mappings that
> >         bypass kernel page cache.
> >
> >         While the DAX property tends to result in data being transferred
> >         synchronously, it does not give the same guarantees of
> >         synchronous I/O where data and the necessary metadata are
> >         transferred together.
>
> (I'm frankly not sure that synchronous I/O actually guarantees that the
> metadata has hit stable storage...)

Oh? That text was motivated by the open(2) man page description of O_SYNC.
