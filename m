Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D200153DF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 05:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBFEwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 23:52:22 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41862 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgBFEwW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:52:22 -0500
Received: by mail-ot1-f54.google.com with SMTP id r27so4289151otc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 20:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvgZCiawwyylGoanGUUQMTXz0wj9mfE270X3TaVYmAo=;
        b=kSuOC11oNNeuqyLsoBjCG+I8YMYmD8gAcvMvR1ARIP5Iplb+aMJLpWeOhoBQTodTzA
         RxE86zOEq4rfKI1qxgvPwJf3KNtupoi73qX2rG19/eJjkUdetvpfLP2xJIhuIhfNhIiB
         WPhKPC9tqNnlbjWCE76onXbbDXgSuI0daEADtKM3Cp3JeofsClnwG1nSxiodeg/AuEFx
         0oevXnJ9J0KR+Lj81/qjzRQ08QpBVFAhZkAEHwwom4/HrLrhSl4CnotjBX8ejlOu0Ubx
         6LZue27Kq/6ldbma0F/6IJ0TI4glo1+4PAc6VijYPqfulyPiYhNSgmq1H5l27t5V9w1Z
         1/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvgZCiawwyylGoanGUUQMTXz0wj9mfE270X3TaVYmAo=;
        b=hSS+LYgPsAadPIFKI1a4Wj7vQVLxN1Zph8WxQ4NmaUOvoNo/k99rJOD3Hpo/Qw0iMl
         paU7jYTx5U5sljsSOxm/GWClYhpf+9OlkxqTqx6j5xUIMTqlgqY1DKb0oFZn5UwbGs5Z
         5acEt8WHz/gcf3S5sj+8zO/EmGPsLXojsrEZg/ClFLhIDilt+Sj8DUMGmm74ps1lxk8y
         DH1jsDQCbmw3nXnW9kZ+gbzjaFjwEs2Mf0HgOd8VpNnc7qod+vo9fNt5w7b6pOOPcWY3
         5G6tnOV1BVqg2EAClygpJsYfWKL6ODdcp0d+QhTUz7R8yhAOi371xmD4GK0cGAbuA1DC
         jPpw==
X-Gm-Message-State: APjAAAVC6gwLXuQL6ozh9v0NZzfksUcEaR3X6rbmdKPuH6uWxdUhGyy7
        P0Ftp2V/qGKg6cFmlHvski+rFVyaNCCvzdRQ1dqJUQ==
X-Google-Smtp-Source: APXvYqy9Ub4gRjOSxHxrUHPcq9y8tQmg4kIiwEVMDPsXCYRr96aQCznSQJrSB6Unk7jX1gPaxgTaIF9rKwImnAXHyf8=
X-Received: by 2002:a9d:1284:: with SMTP id g4mr28347378otg.207.1580964741046;
 Wed, 05 Feb 2020 20:52:21 -0800 (PST)
MIME-Version: 1.0
References: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com> <20200205192802.GA2425@infradead.org>
In-Reply-To: <20200205192802.GA2425@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 5 Feb 2020 20:52:10 -0800
Message-ID: <CAPcyv4i6Btgb2MSLEPY4Fo_gsVd2HX3zeDen51yvXaNn9p28SA@mail.gmail.com>
Subject: Re: [patch] dax: pass NOWAIT flag to iomap_apply
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 5, 2020 at 11:28 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 02:15:58PM -0500, Jeff Moyer wrote:
> > fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
> > dax".  The reason is that the initial pwrite to an empty file with the
> > RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
> > dax_iomap_rw doesn't pass that flag through to iomap_apply.
> >
> > With this patch applied, generic/471 passes for me.
> >
> > Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied.
