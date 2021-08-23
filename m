Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B44A3F5296
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhHWVLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 17:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbhHWVLF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 17:11:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E60C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:10:22 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 2so2405362pfo.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 14:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kERAiQoYaUiZLUwWrv4bOyfnlzgpfin7j02w+F9IvyI=;
        b=lt4AXvvtTufuHda/bGjNiZxhwiAm/AnyRlhljPx5+BrAEe34p23FhAtHB3HYEPECjI
         jZJJBRria/KJ2mzQ9LOwyzbCZoSDaOdQR0S9CRFr6soYOqwb/+FUoQUrKf/mlQY4M/No
         ndC3I1GeQjlJMJ/jw/JblYnAZq44iy2TYPyqnbJDRkcgjClk3LC8P4WfyaypwNTJEmKy
         RnigTJKYP/gKvnicdNOGQq68auU7dv4psI4APDrepknd32ykDnbq7z6T5MQJv19mjiWP
         +i8XIcGhUKXqKHEMe1QF0XZeeTc5nlVkb6dsFL2GNpG0DZg+xXbWpj/FUtsMz52eKKbN
         kD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kERAiQoYaUiZLUwWrv4bOyfnlzgpfin7j02w+F9IvyI=;
        b=ENYcRd9ZANpzBIDQeWlNHq84yOsF9xZzFNrju0eU5Jmc2CfKrzG3aZCYvRs8fPHqAn
         WUFMCp17Ihwd0nt/KWaaOvGSiNi2J5+s6YJRiYMtioIM8aQum6s2eA+YBw5WeooGqpKF
         rexiqCrHkxG2H7+AelY8A4P5fSkswoH6f1AFSsRBKT0ogNLWqevtINA8jnf21FAw+t0Y
         DBcfbYx7kGJHTY2wt4ZRdrUNpBQpkrJWb8aQkoLt4394DL1q0T1Q8UMulC0zV/2CWQW7
         NQeQ96YtDMjQ6tWp4RdPYY3wHfRMy7mt3X7ReQf2uZstEwZKtNRrldMMH8os5jg5lulQ
         cMgg==
X-Gm-Message-State: AOAM533w+Hts+sgEy8cFIB15hk3n7EvIhkyfcFQjKd6ioqWhgCs0nzRZ
        4wfVujxYz8Ce49u2a4HfnMVBYz/VN9ZquHu2zXGWmQ==
X-Google-Smtp-Source: ABdhPJx+EAx+0+aNllv7PT9bB+oTaqYHbUG37U6GeVa/xR+D4Ew0wB0pvGbJbwzWaANuG+iJwDebQ2Xozd6MWf+fMBg=
X-Received: by 2002:a65:6642:: with SMTP id z2mr21533804pgv.240.1629753021975;
 Mon, 23 Aug 2021 14:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-7-hch@lst.de>
In-Reply-To: <20210823123516.969486-7-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 14:10:11 -0700
Message-ID: <CAPcyv4jHYL=TYW-_wF3uTnfzDbGuLqSm-P5Uw+w+jyd89J11Sw@mail.gmail.com>
Subject: Re: [PATCH 6/9] dax: remove __generic_fsdax_supported
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:42 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just implement generic_fsdax_supported directly out of line instead of
> adding a wrapper.  Given that generic_fsdax_supported is only supplied
> for CONFIG_FS_DAX builds this also allows to not provide it at all for
> !CONFIG_FS_DAX builds.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
