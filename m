Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F23B29B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 09:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhFXHxK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbhFXHxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 03:53:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B58C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jun 2021 00:50:51 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2953091pjo.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Jun 2021 00:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DuYrhRvvccPm1tuDDRCCJiwUp+nK5oGg2qx9gi2wCLU=;
        b=E1tHorlJ2Q3RtXy2nJKFiv2TCi095JaxSn8/8u2+X3wgTQWTBERzbcf8H4HdZg/T15
         WDx7sMNuR9tHuIW8agdQY9Svoaxg8LsQLdkVMfUpZcReVik/5HGC/wKs9bkHPmizsW0x
         thwgR+kpE3br7f3hLc1a8UugLTUYy5GjHzWlJMeb1S9HGzIDSkbfqN4IzukNrCw9fs3d
         SiHtiYec9lBpnDytaWTGjJ+PwAoqne0/37fIYfRDFtIsZQP2755XH7Hmmeh9+1fQ34Dv
         cE+7PmvyVj0kFKXZBvdA47kpRpGZ/G21O3ag+H3jWvj61qrcT1ItX2FlPQCF2oq+9Slf
         o2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DuYrhRvvccPm1tuDDRCCJiwUp+nK5oGg2qx9gi2wCLU=;
        b=A0VVJalGREuVjrmsr49zC95Rx77Q70TriCfj7VCWMHCiHT0ShwtQfx3P6vYDw/UUMu
         YntRIyhTq4rSos5N0vTl2PXcRipmMpNhCtPdYzTfu23j/bHW/T4OP+S9D5spIDACfjLt
         MxESbP876UgbZ4zvB59wuXakci+D/pUDxQswlkDuN/n7afCIckykX5f8skmBux+S2V0k
         P5D8QOP7RT7eWw8bsb50JUGNNqomzRqNwDRKOh3tASuss1p5ePcRYjZ3Se059ZGgk5rn
         zIlAsFg/Xav6bWAlO1+ZlHrI5Zgfta6dnPe5gfNbhn0bdTyG//9JDjCiXJjL2KPPZSYP
         4/cQ==
X-Gm-Message-State: AOAM531UxqGhXmksVGZcnI+so5PHwpVCADDeMPufy9+QzSj5l3cSPNcw
        +77AmbCCKl2jtY2ANw5EZk1Vrg==
X-Google-Smtp-Source: ABdhPJyRfmSm1SUcUfxHGjDwmKcuk2FKqzM9vMqnbJyAcd/YNIZVThg+ZpYpW8IvtZGBWva8L+Kzsg==
X-Received: by 2002:a17:902:ff16:b029:123:426a:9331 with SMTP id f22-20020a170902ff16b0290123426a9331mr3202253plj.34.1624521050548;
        Thu, 24 Jun 2021 00:50:50 -0700 (PDT)
Received: from relinquished.localdomain ([2601:602:8b80:8e0::ce6a])
        by smtp.gmail.com with ESMTPSA id z204sm2029060pfc.84.2021.06.24.00.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:50:49 -0700 (PDT)
Date:   Thu, 24 Jun 2021 00:50:49 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YNQ5WbH+Gu37nLoS@relinquished.localdomain>
References: <YND6jOrku2JDgqjt@relinquished.localdomain>
 <YND8p7ioQRfoWTOU@relinquished.localdomain>
 <20210622220639.GH2419729@dread.disaster.area>
 <YNN0P4KWH+Uj7dTE@relinquished.localdomain>
 <YNOPdy14My+MHmy8@zeniv-ca.linux.org.uk>
 <YNOdunP+Fvhbsixb@relinquished.localdomain>
 <YNOqJIto1t13rPYZ@zeniv-ca.linux.org.uk>
 <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org>
 <YNQpCGQUIv3kvvPQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNQpCGQUIv3kvvPQ@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 24, 2021 at 07:41:12AM +0100, Christoph Hellwig wrote:
> I'm also really worried with overloading the regular r/w path and
> iov_iter with ever more special cases.  We already have various
> performance problems in the path, and adding more special cases ain't
> gonna help.

The changes to the normal path are:

* An extra check for RWF_ENCODED and FMODE_ENCODED_IO in kiocb_set_rw_flags().
* Splitting some of the checks in generic_write_checks() into a new
  function.
* Checks for the IOCB_ENCODED flag in the filesystem's
  read_iter/write_iter.

At least for Btrfs, the rest happens in a completely separate code path.
So, there are a couple of extra checks, but it's not as drastic as it
might first appear.
