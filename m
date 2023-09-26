Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B737AF738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjI0AQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 20:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjI0AOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:14:40 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F51BF3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 16:33:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c4194f769fso72610725ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695771214; x=1696376014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fzAFOkzwhGAtezwb7Q8ZYaVN+d4jFFOQUeui0g8VHkA=;
        b=sBnAWOGFYan30AwkwAHVHA6/L+FTM1f/NiupNKpc3STfRpE0HsEJ/8KrYtkJUY2XB9
         XIqjUXsKH6CYscchdDYRZLYqTe0wGS1AshaM6+gjWx6550Q98rRBhWfPPkW0qZP2EY3o
         IanCzpnqgH5eLtSPPUwk+0hB33CqjAyKaSr7O4yCesVE6EM6E39/BmkTEinl0RPiSWNj
         cEPvY8zu2JCHuiFNwPlYiyhAj1ACFpsvEukkleY4Dwmi29a18ey97pEfEqp+4sYsoeKT
         2mw6kl9KXR/aEbrr08UGYsMDsg5DXXxVU8X0EIiFHt6G9C40j2R51+Tipoc0oWn4w/zJ
         kt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695771214; x=1696376014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzAFOkzwhGAtezwb7Q8ZYaVN+d4jFFOQUeui0g8VHkA=;
        b=JXyhdEjNBZvZFijuKZs+LBfRjhfowPZHDgCXLaq5dTytObOFvIFNrlhDHUc+aM3GQY
         7rTPNjGq14nM5dZYkORK7oI6Xe1aV9YZF0qrD9Db3NttiF8KFC6Ox1Z+yar2J3v0bOcM
         4LEGmj9yjcfONcfkfXB+MuuAJJQ8Ny78vnVRHrQeAQIfQbE77zLJAOKbCGxlfUI7kBB8
         B3UOI6NcOwspw/MqWsAqYnyhs9kXnyUsmYNTsqTDJfr2bgU2IcHDoaHOYHRHv0zQX9Mn
         XtC/LNdcXeucgUbRr17lXvopmFJ+547C1LxVoYLz4oTV2TRA5spXU2zGHrrUVJSfPVah
         1BLg==
X-Gm-Message-State: AOJu0Yx0ZfKToZQGfAEqUu4TA+zmoDbIBmw2vd8mW9SkYdL9AstBFL23
        f9/JEpa3SWpBTZ7Q/JAKzQ6eDg==
X-Google-Smtp-Source: AGHT+IGNDTgPnX9/61UW1DFLe1t2ekDtE9xmnNxExg0YxAsa8gYAb5Jp9QJLDjbnQrHCfTGC0cwTTQ==
X-Received: by 2002:a17:903:246:b0:1bf:6ad7:2286 with SMTP id j6-20020a170903024600b001bf6ad72286mr239913plh.43.1695771214349;
        Tue, 26 Sep 2023 16:33:34 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001c42d4b3675sm4138030plg.309.2023.09.26.16.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 16:33:33 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qlHYY-0062Td-3C;
        Wed, 27 Sep 2023 09:33:31 +1000
Date:   Wed, 27 Sep 2023 09:33:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
Message-ID: <ZRNqSvHwkmQoynOc@dread.disaster.area>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
 <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
 <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
 <CAOQ4uxjrt6ca4VDvPAL7USr6_SspCv0rkRkMJ4_W2S6vzV738g@mail.gmail.com>
 <ZRC1pjwKRzLiD6I3@dread.disaster.area>
 <77d33282068035a3b42ace946b1be57457d2b60b.camel@kernel.org>
 <ZRIKj0E8P46kerqa@dread.disaster.area>
 <54e79ca9adfd52a8d39e158bc246173768a0aa0d.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e79ca9adfd52a8d39e158bc246173768a0aa0d.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 07:31:55AM -0400, Jeff Layton wrote:
> On Tue, 2023-09-26 at 08:32 +1000, Dave Chinner wrote:
> > We also must not lose sight of the fact that the lazytime mount
> > option makes atime updates on XFS behave exactly as the nfsd/NFS
> > client application wants. That is, XFS will do in-memory atime
> > updates unless the atime update also sets S_VERSION to explicitly
> > bump the i_version counter if required. That leads to another
> > potential nfsd specific solution without requiring filesystems to
> > change on disk formats: the nfsd explicitly asks operations for lazy
> > atime updates...
> > 
> 
> Not exactly. The problem with XFS's i_version is that it also bumps it
> on atime updates. lazytime reduces the number of atime updates to
> ~1/day. To be exactly what nfsd wants, you'd need to make that 0.

As long as there are future modifications going to those files,
lazytime completely elides the visibility of atime updates as they
get silently aggregated into future modifications and so there are
0 i_version changes as a resutl of pure atime updates in those cases.

If there are no future modifications, then just like relatime, there
is a timestamp update every 24hrs. That's no big deal, nobody is
complaining about this being a problem.

It's the "persistent atime update after modification" heuristic
implemented by relatime that is causing all the problems here. If
that behaviour is elided on the server side, then most of the client
side invalidation problems with these workloads go away.

IOWs, nfsd needs direct control over how atime updates should be
treated by the VFS/filesystem (i.e. as pure in-memory updates)
rather than leaving it to some heuristic that may do the exact
opposite of what the nfsd application needs.

That's the point I was making: we have emerging requirements for
per-operation timestamp update behaviour control with io_uring and
other non-blocking applications. The nfsd application also has
specific semantics it wants the VFS/filesystem to implement
(non-persistent atime unless something else changes)....

My point is that we've now failed a couple of times now to implement
what NFSD requires via trying to change VFS and/or filesystem
infrastructure to provide i_version or ctime semantics the nfsd
requires. That's a fairly good sign that we might not be approaching
this problem from the right direction, and so doubling down and
considering changing the timestamp infrastructure from the ground up
just to solve a relatively niche, filesystem specific issue doesn't
seem like the best approach.

OTOH, having the application actually tell the timestamp updates
exactly what semantics it needs (non blocking, persistent vs in
memory, etc) will allow the VFS and filesystems can do the right
thing for the application without having to worry about general
heuristics that sometimes do exactly the wrong thing....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
