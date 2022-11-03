Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FED618507
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 17:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiKCQmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 12:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiKCQl7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:41:59 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192D71DDFE;
        Thu,  3 Nov 2022 09:39:00 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3321c2a8d4cso20739197b3.5;
        Thu, 03 Nov 2022 09:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kh3PemVjLOMzD+zXkDJxoTeXa2tk+grc1up9htYz3yQ=;
        b=TBUw7q9qlHT6DGo5HjKtvBxbUDq+n/istEJfhP3bgdU7CnHlK014WON/49qdO7GgS+
         RgxuEN4xbsVF7yK92hmPq+KFzPCfizitf30Jyy5THmkvmvJcf0/AenZJFlTbQOqSaq9t
         mt1fJeTL3SuDAdWBYqrwg+1xS+WwZ0rGkiDIYgN5vnd5oSRNmVoGDw8IxRuWD8Fzi2/s
         WKOAZr7nTjLUCxj01UWCWqYIS/ToOImwMXp0M0aSr7A6X9lD8R+BB9I11dD3UTwY7BMb
         dzvLL11zwCIl9tqMPcVFQSAnwW5T4pu4XVePASsS/ZkKBRZ/zUD8v1hoebUdaSPZeMuh
         xGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kh3PemVjLOMzD+zXkDJxoTeXa2tk+grc1up9htYz3yQ=;
        b=Jcjk9w9OsXZgw+4hY16C/3ZfMy9nLOh2B7H7VF7zZnH1X35S94MvASZiv/iCpHMaWb
         u52DQDdS2qs5lVFM5Lem52JFdTwWPWRYX5AJUJz+sgwGiC38US1zeU1ev4beV9yQYfqv
         6iHErY5LHox+LLFUKHMsCTdCn6H+p+TlXQMNO8GEMIU+yRk94oreCyPUEhyaa3KOhS/+
         D4U9clz53RkZhRuxILZNwfEcHQmJ8T7D3VAGfIjoJ6NgQe1QojrP2zB7w8ANXHDdALaV
         cAr78sOLVe9G8UCOljzJN7HKxaojlrHIh7ug8ZpSFmyX1EyuPnO8MP3qOcPc22SModfY
         ezRw==
X-Gm-Message-State: ACrzQf3N0u/m2fYGmWpOB3c6JEDxwgxSHxi34GzdOAQyyVs2v0qGH5Cl
        SFET0KkT4RqHvr8p9POrARfb7Ah7z7jFsm1Huzg=
X-Google-Smtp-Source: AMsMyM6eD3AkR/tTwVJuSGW1VpJEcDm8gRAUUIITH99yEF6ks7q7BqgOP+0YDkckG+H0+22nmeoDoFNiML2RzB4TzPI=
X-Received: by 2002:a81:1648:0:b0:36b:1891:7dda with SMTP id
 69-20020a811648000000b0036b18917ddamr29441580yww.447.1667493539150; Thu, 03
 Nov 2022 09:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20221102161031.5820-1-vishal.moola@gmail.com> <20221103070807.GX2703033@dread.disaster.area>
In-Reply-To: <20221103070807.GX2703033@dread.disaster.area>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Thu, 3 Nov 2022 09:38:48 -0700
Message-ID: <CAOzc2pzFMU-XiGZ9bsp40JkpYVSzQuxs2VXgfw_p9abkj4GrFw@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Convert to filemap_get_folios_tag()
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org
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

On Thu, Nov 3, 2022 at 12:08 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Nov 02, 2022 at 09:10:08AM -0700, Vishal Moola (Oracle) wrote:
> > This patch series replaces find_get_pages_range_tag() with
> > filemap_get_folios_tag(). This also allows the removal of multiple
> > calls to compound_head() throughout.
> > It also makes a good chunk of the straightforward conversions to folios,
> > and takes the opportunity to introduce a function that grabs a folio
> > from the pagecache.
> >
> > F2fs and Ceph have quite a lot of work to be done regarding folios, so
> > for now those patches only have the changes necessary for the removal of
> > find_get_pages_range_tag(), and only support folios of size 1 (which is
> > all they use right now anyways).
> >
> > I've run xfstests on btrfs, ext4, f2fs, and nilfs2, but more testing may be
> > beneficial. The page-writeback and filemap changes implicitly work. Testing
> > and review of the other changes (afs, ceph, cifs, gfs2) would be appreciated.
>
> Same question as last time: have you tested this with multipage
> folios enabled? If you haven't tested XFS, then I'm guessing the
> answer is no, and you haven't fixed the bug I pointed out in
> the write_cache_pages() implementation....
>

I haven't tested the series with multipage folios or XFS.

I don't seem to have gotten your earlier comments, and I
can't seem to find them on the mailing lists. Could you
please send them again so I can take a look?
