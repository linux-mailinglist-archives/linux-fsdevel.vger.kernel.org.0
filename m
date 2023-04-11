Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC06DE7DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 01:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDKXNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 19:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjDKXNu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:13:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AE3171B
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 16:13:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso12734747pjs.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112; t=1681254829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cm7n7h0+YQqhaMN60giOfNLEV6DHkhKIhtK3vaJrO+s=;
        b=UBHxzOgxwXGsNLNd5A9P7VT4b7Po+zYBdXSmczVUbcnEawjNUyc6Q0yDVbqcVgbHAg
         QTmK+YIBP35K5pUYpip9sBXhtyUf3gX81/VeiKVT9jXLZfpHY4YVEyyU98F+6x0du6WZ
         0zcsJKBeXD/aW3FwNY4xrZy9lJPBMYsetXsgXCawQz79UCg/xkbw2C6P4uSHEP5b0LeH
         Yp4N8YFsCKela8bX7OHmf/BCOT0KrvQlxQBmDffLwLAoPcYTSBOAI1r/FXscGJF4uU+I
         h84W2aDFzxwDHnMk2PUzMcRvbOJzzT7/wuUQYX4/fg8IeZhrkFXJLIAckBOjX9w41HXp
         ooow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681254829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cm7n7h0+YQqhaMN60giOfNLEV6DHkhKIhtK3vaJrO+s=;
        b=4bElQLR36zgZo1KebryAgEoQZT2c8+ZvHU3Whkj54+uLOvaSQzowJR7EUmhM9WTRWC
         U8gR4eIRvjBrclDAY+6xeC4fR74+mokiLDsqY3CAa6boupdp78BcwosIUFbHzO0G6L8Z
         bLU/TT5BgZxwe421hcXeCGsKEF+PSqL4iRk7XRQRnm+gf08K4QrYYqqhlnYxczs5cmdn
         DMZ2X3XHGijcA/7Kv/F5/vERE1MXGJIuumsUGNrIUoeN1JhrelMCOmfHROXavOPvfBNl
         /tem6gtFahSKP9wVlDxVwDNwnUVX6UKgBcXZVk9fBTii4+9xMGLL90ZsjM4F+na3B2Cp
         kSLQ==
X-Gm-Message-State: AAQBX9cj+gMXYSvqkceI8ie5NFdhqElHr9mYnPs+GADMqFn7ihP2rZ5z
        TMCG48VzXMvu1dqzTToWdiV71g==
X-Google-Smtp-Source: AKy350bcqK4pAcsiH06EOT8P/jZME+o+zads0C6tIbm53vEQbRbnDvgTAjpPgh+ebvn7V4wp2JvjLw==
X-Received: by 2002:a17:90a:6b09:b0:23d:16d6:2f05 with SMTP id v9-20020a17090a6b0900b0023d16d62f05mr17621391pjj.22.1681254828818;
        Tue, 11 Apr 2023 16:13:48 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-41-174.pa.nsw.optusnet.com.au. [49.180.41.174])
        by smtp.gmail.com with ESMTPSA id jh6-20020a170903328600b001a64011899asm330544plb.25.2023.04.11.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 16:13:48 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pmNBJ-002H1W-AF; Wed, 12 Apr 2023 09:13:45 +1000
Date:   Wed, 12 Apr 2023 09:13:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/3][RESEND] fs: opportunistic high-res file
 timestamps
Message-ID: <20230411231345.GB3223426@dread.disaster.area>
References: <20230411143702.64495-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411143702.64495-1-jlayton@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:36:59AM -0400, Jeff Layton wrote:
> (Apologies for the resend, but I didn't send this with a wide enough
> distribution list originally).
> 
> A few weeks ago, during one of the discussions around i_version, Dave
> Chinner wrote this:
> 
> "You've missed the part where I suggested lifting the "nfsd sampled
> i_version" state into an inode state flag rather than hiding it in
> the i_version field. At that point, we could optimise away the
> secondary ctime updates just like you are proposing we do with the
> i_version updates.  Further, we could also use that state it to
> decide whether we need to use high resolution timestamps when
> recording ctime updates - if the nfsd has not sampled the
> ctime/i_version, we don't need high res timestamps to be recorded
> for ctime...."
> 
> While I don't think we can practically optimize away ctime updates
> like we do with i_version, I do like the idea of using this scheme to
> indicate when we need to use a high-res timestamp.
> 
> This patchset is a first stab at a scheme to do this. It declares a new
> i_state flag for this purpose and adds two new vfs-layer functions to
> implement conditional high-res timestamp fetching. It then converts both
> tmpfs and xfs to use it.
> 
> This seems to behave fine under xfstests, but I haven't yet done
> any performance testing with it. I wouldn't expect it to create huge
> regressions though since we're only grabbing high res timestamps after
> each query.
> 
> I like this scheme because we can potentially convert any filesystem to
> use it. No special storage requirements like with i_version field.  I
> think it'd potentially improve NFS cache coherency with a whole swath of
> exportable filesystems, and helps out NFSv3 too.
> 
> This is really just a proof-of-concept. There are a number of things we
> could change:
> 
> 1/ We could use the top bit in the tv_sec field as the flag. That'd give
>    us different flags for ctime and mtime. We also wouldn't need to use
>    a spinlock.
> 
> 2/ We could probably optimize away the high-res timestamp fetch in more
>    cases. Basically, always do a coarse-grained ts fetch and only fetch
>    the high-res ts when the QUERIED flag is set and the existing time
>    hasn't changed.
> 
> If this approach looks reasonable, I'll plan to start working on
> converting more filesystems.

Seems reasonable to me. In terms of testing, I suspect the main
impact is going to be the additionaly overhead of taking a spinlock
in normal stat calls. In which case, testing common tools like giti
would be useful.  e.g. `git status` runs about 170k stat calls on a
typical kernel tree. If anything is going to be noticed by users
that actually care, it'll be workloads like this...

If we manage to elide the spinlock altogether, then I don't think
we're going to be able to measure any sort perf difference on modern
hardware short of high end NFS benchmarks that drive servers to
their CPU usage limits....

> One thing I'm not clear on is how widely available high res timestamps
> are. Is this something we need to gate on particular CONFIG_* options?

Don't think so - the kernel should always provide the highest
resoultion it can through the get_time interfaces - the _coarse
variants simple return what was read from the high res timer at the
last scheduler tick, hence avoiding the hardware timer overhead when
high res timer resolution is not needed.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
