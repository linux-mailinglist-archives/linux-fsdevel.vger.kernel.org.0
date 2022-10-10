Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE885FA1C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJJQTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 12:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJJQTr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:19:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD5263AC;
        Mon, 10 Oct 2022 09:19:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 207so13583032ybn.1;
        Mon, 10 Oct 2022 09:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urVf0v/te+deuki+GBGLO2FUpbQzib8pEKK61bqpa2U=;
        b=d+QFBncCDIQFCGRHGmJYmHcTDaN6xcG1y5j9sTl4/bWizDCd5e5zN4Sm/OjH14KWfE
         8f46cq4pDL0cvCn5zmjRvSNCl/OLtaj4cyuKa0+eLNbjqdLh3bl2oFN9oQOymI11TI4w
         2MCBLQYKYKI2+nxkiW9lbQQb6O/uOJxKtLj345ysknabTkMATifdnlQwSw11if2kgtFd
         OUfTLZkivgpMjH4UKlk/FpLAP7TkqSsolu0yMNlTxtk3Sq1nGIHdbh+ZhYetEKqB90HA
         kBr4YK79XtRRJSSmp8eWhw7O0WzK/mGp3qAIDJU/tO/E4R5QMCfIGaMfEa50NJPNDLvX
         f6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urVf0v/te+deuki+GBGLO2FUpbQzib8pEKK61bqpa2U=;
        b=lGr7buAKKUV5aSPXYFWeXdgz4bvmKdF4KCYa/oxlcY3Gnx5zedbMWoc0dTeq4e5mqH
         LpK1XRWk/UIEJCqpx3I48RY+sDmEoduPcguSnUjo05jMoxmVXB72ulWuSZaNbLGJ2SRE
         GOxfc988D1f4M5jHkCfsj91DbPl41dzZ9KvYXUmIpWibAejW0qJUVdlOajgnHh67wrFb
         Xds8o0YieQ6vlHRhfVrmPDXextJjdBGxtSPSv4/25rTn8rMHk/haX3oPY9QyRVk8FLex
         v/hz9Sv7dQVAMW44StRXnCQT1juNR5xC7GIWqsMIJ1ERRpDBiGMU51CssB3+sZluLCsv
         F8VQ==
X-Gm-Message-State: ACrzQf2E0qLJXW5uFWeQUQoFQXl0027KZCKHU6bD3XomnA4bQLaRTHiV
        L7fMYqu/2M6nHh0lDnSuCJp0m0oR5JgLmLzYVzw=
X-Google-Smtp-Source: AMsMyM6smWOmH7N3cXuHH7A05vBbbJR+sVGjp3pKL1q0CCVm4rSheNFxwnOBvmKu5WOm+NHCmtvIKkPCluKDjmrgEag=
X-Received: by 2002:a25:6f83:0:b0:6be:37fe:4d91 with SMTP id
 k125-20020a256f83000000b006be37fe4d91mr17167664ybc.562.1665418784697; Mon, 10
 Oct 2022 09:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000117c7505e7927cb4@google.com> <20220901162459.431c49b3925e99ddb448e1b3@linux-foundation.org>
 <Y0HLnmzlmJRK/tHF@casper.infradead.org>
In-Reply-To: <Y0HLnmzlmJRK/tHF@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 10 Oct 2022 09:19:33 -0700
Message-ID: <CAOzc2pyAbEFHCgG_b49n-1ym6-ECZepg+LYKOGzH2u3-Fk_9xg@mail.gmail.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in truncate_inode_pages_range
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

On Sat, Oct 8, 2022 at 12:12 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 01, 2022 at 04:24:59PM -0700, Andrew Morton wrote:
> > On Wed, 31 Aug 2022 17:13:36 -0700 syzbot <syzbot+5867885efe39089b339b@syzkaller.appspotmail.com> wrote:
> >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    89b749d8552d Merge tag 'fbdev-for-6.0-rc3' of git://git.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14b9661b080000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=911efaff115942bb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=5867885efe39089b339b
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+5867885efe39089b339b@syzkaller.appspotmail.com
> > >
> > > ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
> > > ntfs3: loop0: RAW NTFS volume: Filesystem size 0.00 Gb > volume size 0.00 Gb. Mount in read-only
> > > ================================================================================
> > > UBSAN: array-index-out-of-bounds in mm/truncate.c:366:18
> > > index 254 is out of range for type 'long unsigned int [15]'
> >
> > That's
> >
> >               index = indices[folio_batch_count(&fbatch) - 1] + 1;
> >
> > I looked.  I see no way in which fbatch.nr got a value of 255.
>
> NTFS is involved.  I stopped looking at that point; it seems to be
> riddled with buffer overflows.
>
> > I must say, the the code looks rather hacky.  Isn't there a more
> > type-friendly way of doing this?
>
> Looking at the three callers, they all want to advance index.  We
> should probably pass &index instead of index and have find_lock_entries
> advance it for them.
>
> Vishal, want to take this on?

Yup! I'll do that.
