Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62260255C62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH1O1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 10:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgH1O1I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:27:08 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637FC061264
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2020 07:27:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so1747662eje.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2020 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl0n7d6uzVJsvRESdz9U6Q5zoOE/mArKZEtiHXlxl+A=;
        b=XQbewNZ6vbVoEOX8gsi1Rc4oDnVeju8D129HRlTSxUJHzvsLy8S4x4ttUv/Q1UbD7a
         RvH7dXTmrZ/ZsiQSdTzwNPUfqx9vmGPSqZ3jM1W1LFFJhJpo1s7/hzIpe/U20goTwNkm
         M/hx0L+ugVWf90stUZL9nRhUG59hiac/rQbow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl0n7d6uzVJsvRESdz9U6Q5zoOE/mArKZEtiHXlxl+A=;
        b=BEIuzC1Uh7p8XzbHKXiVEzOykATZewnDWlkB4gm2RgvXAQ9HtPh3Aifxphf5aIO/uf
         RmRFUw1B6GxCFuDNsaVJ63vnjpZ2U9GJ+Hs/t3hQL4HpV8LyGZFzcN+ZAej3c1bP9Oh1
         KgAobyhH20qNvFxz+a4+tchzold5d65xwbEWRlljxeSDiao7mZ0MgpuhwSyJGNxVLAHW
         nVkvpl8pbT1ovsF8+44k+OfnSTsJU6owF1JCL0S/X+SW0ov9F3ls0A/AlrwwW1wP0YHF
         tmkgzDItyCsCAzr6AJ4SuIw0k7ircq/XZFzJhVOwwPF07M3Fb7vfnERd/lI8MpBK+B6o
         73sw==
X-Gm-Message-State: AOAM5324M6sDswY2ElKUxE/99+gtYZx29irAjrv2GU3qogF0IQJM2hLk
        Uu+IA29jICIQNSrmigqkU+xZ1na0uxswj2RLcZRlHA==
X-Google-Smtp-Source: ABdhPJx/XumYJzNHjGferUrsD62R+WOS937oWA5dXyt/UPWotd7gXol3fLS1WId9GCqY81zy1C7DxVDsLeoyTNi+yYA=
X-Received: by 2002:a17:906:ca55:: with SMTP id jx21mr2095017ejb.110.1598624827171;
 Fri, 28 Aug 2020 07:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200819221956.845195-1-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 28 Aug 2020 16:26:55 +0200
Message-ID: <CAJfpegv5ro-nJTsbx7DMu6=CDXnQ=dzXBRYEKxKc6Bx+Bxmobw@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] virtiofs: Add DAX support
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:21 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi All,
>
> This is V3 of patches. I had posted version v2 version here.

Pushed to:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#dax

Fixed a couple of minor issues, and added two patches:

1. move dax specific code from fuse core to a separate source file

2. move dax specific data, as well as allowing dax to be configured out

I think it would be cleaner to fold these back into the original
series, but for now I'm just asking for comments and testing.

Thanks,
Miklos
