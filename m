Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9965641DF4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Dec 2022 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLDQiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Dec 2022 11:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLDQiE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:38:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E492C12AF3
        for <linux-fsdevel@vger.kernel.org>; Sun,  4 Dec 2022 08:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670171823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xAcFBfhNJHwotRSc2lWCOi76ow6aaVuRhG6ZwPyPCys=;
        b=EsgFR8HCYcIPx8mtoKDsF/vUsMjV2STZQC3l5PToDRyU55uNLbMDYk7D+/yF3PBaCLtj7B
        o68oleKEA/7EzhiWk10+BJ8jbBNA32wirBWLusKgV+gOqkXbJcgQsa1gOKx+opCRlJGFyI
        ZbehxZdxxcAOgbCS6OYjzF92+V/doQ0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-BCk2y08VOCye01x7h6BqDg-1; Sun, 04 Dec 2022 11:37:01 -0500
X-MC-Unique: BCk2y08VOCye01x7h6BqDg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-349423f04dbso101558017b3.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Dec 2022 08:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAcFBfhNJHwotRSc2lWCOi76ow6aaVuRhG6ZwPyPCys=;
        b=3UaAxodOg4WrJiDOqsPARDu4I9cpe4xTw7fXBOd7RHVBUwSUff1SfoSYLBrQGVo41O
         C8HZtXLlNeXzme23K60D//PapMl2SZDW65sSTfp997g8SNxnfmumtWgFydNwLMCpYThO
         3lK3H3KIR5UKnOw6Fm/4hsBx1onk5FS0mZOA8rLuXW8mvn8yzb93tfWvbVKdeJDH8kSc
         mzUaDFo8ESSgfzWxXQuAPvPYZlyPf+TW0cppTsT9d5t/OJRKu/SM+nZmMdTdMXX9WUvF
         +hUIGbn9+vHG88SyvsTQ1O6iXsFwvVTH4Ug6oPRxupVyxJJ86DFhI6zvxHuPLizaE65I
         8f+g==
X-Gm-Message-State: ANoB5pnlyuBqUwwvMHUiLij7swhaFdfYAEcIiQ2clTCDou0NwpA1rk6U
        8zU3nm4Z2Rr0wCgp3aUZ2L2KznT/DYhhJKuLRAzJx2k40LCY3wK0EV9ESDvb5GxR+oYzQ4T43ET
        9M98ez2S5u3KJceKxX0crgRewvjwYitr0E8lt13a/cQ==
X-Received: by 2002:a05:6902:1370:b0:6ff:eb24:45aa with SMTP id bt16-20020a056902137000b006ffeb2445aamr3374363ybb.321.1670171821155;
        Sun, 04 Dec 2022 08:37:01 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6l1GEsDbt+1fLFvB5CX9o/590iQHKz3Y0r+oifb1/CEIrRXsQMblaRNYfjnfzmfVHrTa1jtlVuqyzychSWXQ4=
X-Received: by 2002:a05:6902:1370:b0:6ff:eb24:45aa with SMTP id
 bt16-20020a056902137000b006ffeb2445aamr3374352ybb.321.1670171820974; Sun, 04
 Dec 2022 08:37:00 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d1663705ee97d4d7@google.com> <20221129203054.GF3600936@dread.disaster.area>
In-Reply-To: <20221129203054.GF3600936@dread.disaster.area>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 4 Dec 2022 17:36:49 +0100
Message-ID: <CAHc6FU4OhgPsgBGZjKEma8Qt0=HnfkTWL2mWEXCrJEi4P4SnLQ@mail.gmail.com>
Subject: Re: [Cluster-devel] [syzbot] WARNING in iomap_read_inline_data
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+7bb81dfa9cda07d9cd9d@syzkaller.appspotmail.com>,
        linux-xfs@vger.kernel.org, cluster-devel@redhat.com,
        djwong@kernel.org, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 9:31 PM Dave Chinner <david@fromorbit.com> wrote:
> Looks like something to do with the gfs2 inline data functionality -
> syzbot probably corrupted the resource index inode given the
> gfs2_fill_super() context.

Hmm, interesting. We're not checking the size of inline (stuffed)
inodes when reading them from disk in gfs2_dinode_in(). I'll fix that.

Thanks,
Andreas

