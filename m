Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A782E7405F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjF0Vvi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 17:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjF0Vvh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 17:51:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A283AE4
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:51:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2792898b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 14:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687902696; x=1690494696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OS6MgGhISKl+4ZHC9ghL6Yintvw9W2ToO6ap0Ix/zho=;
        b=vAOb02oAZ2HVhyJ0K0bu4FKOaD/Vpoxied7rfRc1fjuh4tqReR9JgES4O26PL4XqzK
         v1Jm8FA0aFYuw+MtrWvwjXiscNahzfUQKpXw9zIG4KL76Kw6pCSGKR6+9gDk3n5RUYB5
         rkUg0Um9nvzTFp0QGVKmSAuDo8bgpOrO+aQ/aqQRB/VZNUi9mbIz40F7pCP1jWBXk/kZ
         4lzvDs9VwtJ7rgSXmSduEL3qzVDAtaNXdspBfoYNL9+uOI1BasmcQBogGmUJO6vANAmG
         WBfveESGkCLqiBaslOwIjTg64+V41AY4VxfUkHBullGaC2C6+B8E76ekfMcMp7MrSrJv
         Ki3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687902696; x=1690494696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS6MgGhISKl+4ZHC9ghL6Yintvw9W2ToO6ap0Ix/zho=;
        b=Tt2PMKtO1KgujZSDCVs+81XJsKEi/59MpHsZfWfIADkQV0q+mSz+zPuXD5JgDR6O1M
         ob5Xu4ib1f6GKVl0bmAzoz1gXHzsVvn6tteBIlvEMiORbm+s603mhAw8N6kjrajP39lC
         gNdMjOaWvHBbXVkVxmO6m9b4+EZINUQ+L7nnkTfJkqCxAz9la6lDDoyvPQky756Xo6+C
         h7oXM655lKMgy/Nq6k0vJqrN/cKzPyMjlmcSnKRBB3UGYov+XomxzEqb2+M9c9KrU8Cj
         7LNBOafRE8ela1reZ8Texel7geJCnk8UtT2Ebnyi7q6kypBDofa74geXlNk3rxx6hw5q
         ceIQ==
X-Gm-Message-State: AC+VfDx8VakmR5ubwLxiujsd6TGGObRvYHSyNK7NwcpJ2OaziZQJxrNo
        COJldFxaxFSlpkyuXW8lYpvJyH9QX97x8XkknPs=
X-Google-Smtp-Source: ACHHUZ6LMHthYi1H6je+RpECLuP9X8UFHaa11RvzOhkiSd4T78mjtifetq2MK97yyFtz0xYePngiOA==
X-Received: by 2002:a17:902:aa49:b0:1b6:c229:c352 with SMTP id c9-20020a170902aa4900b001b6c229c352mr7507416plr.14.1687902696080;
        Tue, 27 Jun 2023 14:51:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001b02162c86bsm6421489plg.80.2023.06.27.14.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 14:51:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEGaz-00Gywa-0H;
        Wed, 28 Jun 2023 07:51:33 +1000
Date:   Wed, 28 Jun 2023 07:51:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [Reproducer] Corruption, possible race between splice and
 FALLOC_FL_PUNCH_HOLE
Message-ID: <ZJtZ5ZH1/50B9UEv@dread.disaster.area>
References: <ec804f26-fa76-4fbe-9b1c-8fbbd829b735@mattwhitlock.name>
 <ZJp4Df8MnU8F3XAt@dread.disaster.area>
 <858f34c7-6f9c-499d-b0b4-fecce16541a7@mattwhitlock.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858f34c7-6f9c-499d-b0b4-fecce16541a7@mattwhitlock.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 02:14:41PM -0400, Matt Whitlock wrote:
> On Tuesday, 27 June 2023 01:47:57 EDT, Dave Chinner wrote:
> > On Mon, Jun 26, 2023 at 09:12:52PM -0400, Matt Whitlock wrote:
> > > Hello, all. I am experiencing a data corruption issue on Linux 6.1.24 when
> > > calling fallocate with FALLOC_FL_PUNCH_HOLE to punch out pages that have
> > > just been spliced into a pipe. It appears that the fallocate call can zero
> > > out the pages that are sitting in the pipe buffer, before those pages are
> > > read from the pipe.
> > > 
> > > Simplified code excerpt (eliding error checking):
> > > 
> > > int fd = /* open file descriptor referring to some disk file */;
> > > for (off_t consumed = 0;;) {
> > >   ssize_t n = splice(fd, NULL, STDOUT_FILENO, NULL, SIZE_MAX, 0);
> > >   if (n <= 0) break;
> > >   consumed += n;
> > >   fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, consumed);
> > > }
> > 
> > Huh. Never seen that pattern before - what are you trying to
> > implement with this?
> 
> It's part of a tool I wrote that implements an indefinitely expandable
> user-space pipe buffer backed by an unlinked-on-creation disk file. It's
> very useful as a shim in a pipeline between a process that produces a large
> but finite amount of data quickly and a process that consumes data slowly.
> My canonical use case is in my nightly backup cronjob, where I have 'tar -c'
> piped into 'xz' piped into a tool that uploads its stdin to an Amazon
> S3-compatible data store.

Neat trick.

I think that what you really want for this is something like blksnap
so you can have temporary atomic snapshots of the filesystem to take
the backup from :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
