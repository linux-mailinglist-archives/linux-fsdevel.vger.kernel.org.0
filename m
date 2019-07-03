Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADBC5EF2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2019 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGCWfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 18:35:53 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42394 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfGCWfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 18:35:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so4053872otn.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jul 2019 15:35:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uF998D8BR4hjaWYM/cm2nCswL6OUaWgofBX0cNua7mY=;
        b=Oh85pGaoRfsoaqsDmyLA35uUD3i2iLVLsG2rXzSpjf+skjPaQhYaFQJBnp6R9jgBqn
         fsn5kYADp/VM4oJmLp1IgmAQl/R5cSMbWeV3Ug2v9S6pmrxPLr+2ucXtqIVFsFB/o4mp
         UUwu8nnPHjPIJZjQFNZqyx1DPSEG+cqGCnvTMG+p757Dgo9yH2uJPEvhYSRpEd7+Df4A
         IVqybH5jcN3fse8TVw9feDm7EUpTRc2DA5nvuN+EOEV2r/58TFUNEWKzRRODvLN26Ean
         02+Wub7Elmy2GeDgwagYBNY5mSp2Hg5e3dNYWsopohFMyAE7BldEa0BTt31YgqXImrrp
         5MXA==
X-Gm-Message-State: APjAAAW0JA6XJkb8JMdYrK6Xo/u+7pSeIAhiToK8yhpmilx2sdttME7D
        8H5QPZcqlIntvMay+UaRH8hcECYVnaE/VIB351YJjA==
X-Google-Smtp-Source: APXvYqyb3lCMpWvP5vv5fGbRMbkszNsSf4Dh8Q3SscBMZpgOEptvKSRqy1VjJc/2nmujeUFQiYMDumOh8kn0s1bWND8=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr28332622oti.341.1562193352267;
 Wed, 03 Jul 2019 15:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190701215439.19162-1-hch@lst.de>
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 4 Jul 2019 00:35:41 +0200
Message-ID: <CAHc6FU5MHCdXENW_Y++hO_qhtCh4XtAHYOaTLzk+1KU=JNpPww@mail.gmail.com>
Subject: Re: RFC: use the iomap writepage path in gfs2
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Mon, 1 Jul 2019 at 23:54, Christoph Hellwig <hch@lst.de> wrote:
> Hi all,
>
> in this straight from the jetplane edition I present the series to
> convert gfs2 to full iomap usage for the ordered and writeback mode,
> that is we use iomap_page everywhere and entirely get rid of
> buffer_heads in the data path.

thank you very much, this is looking very good. I've done some testing
with your cleanups applied so that those can go in in this merge
window. The result can be found here:

  https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/log/?h=for-next.cleanups

Patch "gfs2: implement gfs2_block_zero_range using iomap_zero_range"
isn't quite ready: the gfs2 iomap operations don't handle IOMAP_ZERO
correctly so far, and that needs to be fixed first.

The actual buffer head removal will obviously have to wait a little
longer because of the required infrastructure changes, but also
because that still needs a lot more review and testing work.

> This has only seen basic testing which ensured neither 4k or 1k blocksize
> in ordered mode regressed vs the xfstests baseline, although that baseline
> tends to look pretty bleak.

Some of the tests assume that the filesystem supports unwritten
extents, trusted xattrs, the usrquota / grpquota / prjquota mount
options. There shouldn't be a huge number of failing tests beyond
that, but I know things aren't perfect.

> The series is to be applied on top of my "lift the xfs writepage code
> into iomap v2" series.

Again, thanks a lot for the patches!

Andreas
