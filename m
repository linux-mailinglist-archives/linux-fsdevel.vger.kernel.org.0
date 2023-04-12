Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA866E013B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 23:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDLVyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLVyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 17:54:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0F949EA
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 14:54:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c3so14049970pjg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1681336459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o22buf+xWsiAjf8q6ZesO0xScrJcUXPqlMC3QN5HAOw=;
        b=Yy3j4sLbegTgjTgcaNkTrZN/7M/ZDOBxoDHaSLn5Pvs9AGyWlutR7JOp3C/z4US/gp
         JNPTAtUNdJOlsJMwAZAYLjjXgeUJyPzUdHpGtSOGmX5lYsrPKucYHAo/cYimJILvx4gB
         OKFw08M/dWu59tVxZ7w1Dzgj3U+EnZFrEXJ64FYZtEh1KqO/19LCCZEvZWCjoKE9pdAr
         vs2zzEf263lIvs3SmG2hUA02lOqYO8qc3/+kQc9ScXsTt2CnOeRnQUKRL1IcGhl/LPN8
         a8PKswraiwJP8W5Xv2F1/P+DwTWy25rTTwzQ3gnPCBPPhpnguImNFaCwzMSw5648XLbi
         eIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681336459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o22buf+xWsiAjf8q6ZesO0xScrJcUXPqlMC3QN5HAOw=;
        b=NpibfwJ+kKCNUdLOkDtrEAp+W42TF4TxtLrarx9fLVx2I1R2CosAtjMzFi+wkepvJ3
         mIwr6ihl7F4LpHcE3XG2shDRbqFjgtl/mUA4D2RDK3kALv3Sv5po50OXK3m3dQeATFuZ
         hsTMESd+1yxJbVwTl4E9fEompmKClTsaSZ422poeEJVul2P9GwBq0iINSXqGa2LARbDa
         ETM6Qq9UFhduyj8idXbIIcFGVFa/x1kGY7wbKeIb5s+2YcUq6w78B6EffzxsJD2cRQbI
         pwL3DRRTzMx0PORdvx/0zgMVaK1t49iM+XhSByGtRUzdq725aNFSrHe37ykX4HaQaCj9
         OCKQ==
X-Gm-Message-State: AAQBX9f2b3n8K+cyQ7cT48+FiImYKL2F2u1sWX8tyA55dEDagcsBaA5r
        nZbgUCZ4Bkw88Av4oPpdjCu8Mw==
X-Google-Smtp-Source: AKy350aC1dzQ8x6PzYL+9Tqb4+YvtNMti2RvQcBthymKE8OIbVbW6YHQBEHsX8JXr4+ccGakpel1Hg==
X-Received: by 2002:a17:902:c713:b0:1a4:fcc9:ec61 with SMTP id p19-20020a170902c71300b001a4fcc9ec61mr332187plp.5.1681336458813;
        Wed, 12 Apr 2023 14:54:18 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id i4-20020a1709026ac400b001a1b66af22fsm71183plt.62.2023.04.12.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 14:54:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pmiPv-002eH2-Dy; Thu, 13 Apr 2023 07:54:15 +1000
Date:   Thu, 13 Apr 2023 07:54:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     syzbot <syzbot+listea0b12829deaef4101fd@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly xfs report
Message-ID: <20230412215415.GM3223426@dread.disaster.area>
References: <000000000000529f1805f81b23c2@google.com>
 <20230411013512.GX3223426@dread.disaster.area>
 <20230411043517.GC360895@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411043517.GC360895@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 10, 2023 at 09:35:17PM -0700, Darrick J. Wong wrote:
> On Tue, Apr 11, 2023 at 11:35:12AM +1000, Dave Chinner wrote:
> > On Thu, Mar 30, 2023 at 02:58:43AM -0700, syzbot wrote:
> > 
> > > 13      Yes   general protection fault in __xfs_free_extent
> > >               https://syzkaller.appspot.com/bug?extid=bfbc1eecdfb9b10e5792
> > 
> > Growfs issue. Looks like a NULL pag, which means the fsbno passed
> > to __xfs_free_extent() is invalid. Without looking further, this
> > looks like it's a corrupt AGF length or superblock size and this has
> > resulted in the calculated fsbno starting beyond the end of the last
> > AG that we are about to grow. That means the agno is beyond EOFS,
> > xfs_perag_get(agno) ends up NULL, and __xfs_free_extent() goes
> > splat.  Likely requires corruption to trigger.
> > 
> > Low priority, low severity.
> 
> I've been wondering for quite a while if the code that creates those
> defer items ought to be shutting down the fs if they can't get a perag
> to stuff in the intent.  xfs_perag_intent_get seems like a reasonable
> place to shut down the fs with a corruption warning if someone feeds in
> a totally garbage fsblock range.

You know, I think this might be the same as thex  case below where
a bogus AGF field is getting past the verifiers in recovery...

> 
> > > 5       Yes   KASAN: use-after-free Read in xfs_btree_lookup_get_block
> > >               https://syzkaller.appspot.com/bug?extid=7e9494b8b399902e994e
> > 
> > Recovery of reflink COW extents, we have a corrupted journal
> > 
> >    [   52.495566][ T5067] XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
> >    [   52.599681][ T5067] XFS (loop0): Torn write (CRC failure) detected at log block 0x180. Truncating head block from 0x200.
> >    [   52.636680][ T5067] XFS (loop0): Starting recovery (logdev: internal)
> > 
> > And then it looks to have a UAF on the refcountbt cursor that is
> > first initialised in xfs_refcount_recover_cow_leftovers(). Likely
> > tripping over a corrupted refcount btree of some kind. Probably one
> > for Darrick to look into.
> 
> Somehow the bogus refcount level field in the AGF is getting past the
> verifiers.  I'll look into this later.

... because like this one, it seems to require corruption getting
deep into the modification operation without being detected.

As for shutdown when a perag cannot be obtained by defer items, I'm
hoping that the perag get operations slowly disappear from those as
we slowly move the perag references higher up the heirarchy. The
perag should not go away in the middle of a defer chain, so I don't
think we should ever get a NULL from a lookup except in the case of
buggy code....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
