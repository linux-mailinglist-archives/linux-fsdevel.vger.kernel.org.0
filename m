Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568334F9318
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 12:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiDHKgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Apr 2022 06:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiDHKgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E035DD8;
        Fri,  8 Apr 2022 03:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC76661F1C;
        Fri,  8 Apr 2022 10:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1574C385A1;
        Fri,  8 Apr 2022 10:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649414040;
        bh=R2y6C4RKRIkqHrX5HzDxzEdmeBfbdg0sMDotWCgU6xE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkTOguwLOcVENUNClGNjsu6kmC+p3CwizYIhpw81bJvpV0+PGgW+gOJ7iRTs9ssVv
         OO0cp0qFUlw31ncXq8IR3CbNRkuvj1D//MO8MRewy/y+UlyUf0DdO8hQWJFAyq2jss
         1xT/S3z06eHyETASC7a1Fn+qyil6HL/acI8xsfPS0fDgKWuokvrZXh2OC15XlGCZWu
         2iHtKsN3YTtuQ5+XOt//DpFFa7xpterdmiFaWKesQkjszb8otlUzrTQzyvlRWg0S4O
         P8YHkqV6dGUfUqRm52qddRYQGlYTMvPBMDQdTe/nAiObH+ZV3E7R94LXaDTJRlh0eM
         e7hjIRgOW3DTA==
Date:   Fri, 8 Apr 2022 12:33:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] idmapped-mount: split setgid test from test-core
Message-ID: <20220408103355.pvxtosootmp5twqs@wittgenstein>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407125509.ammsotnbrimbqjbo@wittgenstein>
 <624F9C07.80808@fujitsu.com>
 <625019FD.2030606@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <625019FD.2030606@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 10:17:34AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/8 9:20, xuyang2018.jy@fujitsu.com wrote:
> > on 2022/4/7 20:55, Christian Brauner wrote:
> >> On Thu, Apr 07, 2022 at 08:09:30PM +0800, Yang Xu wrote:
> >>> Since we plan to increase setgid test covertage, it will find new bug
> >>> , so add a new test group test-setgid is better.
> >>>
> >>> Also add a new test case to test test-setgid instead of miss it.
> >>>
> >>> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >>> ---
> >>>    src/idmapped-mounts/idmapped-mounts.c | 19 +++++++++++++++----
> >>>    tests/generic/999                     | 26 ++++++++++++++++++++++++++
> >>>    tests/generic/999.out                 |  2 ++
> >>
> >> I actually didn't mean to split out the existing setgid tests. I mean
> >> adding new ones for the test-cases you're adding. But how you did it
> >> works for me too and is a bit nicer. I don't have a strong opinion so as
> >> long as Dave and Darrick are fine with it then this seems good to me.
> > Ok, let's listen ..
> When I write v3, I add mknodat patch as 1st patch and tmpfile as 2nd 
> patch(by using a file doesn't under DIR1 directory, so I don't need to 
> concern about xfs_irix_sgid_inherit_enabled), errno reset to 0 as 3st 
> patch. It seems this way can't introduce the new failure for generic/633.

Sure.

> 
> So I will add a new group for umask and acl and add new case for them 
> instead of split setgid case from test-core group.

Yes. What I'd expect to see is something like:

struct t_idmapped_mounts t_setgid_umask[] = {
	{ setgid_create_umask,						false,	"blabla",     },
	{ setgid_create_umask_idmapped,					true,	"blabla",     },
	{ setgid_create_umask_idmapped_in_userns,			true,	"blabla",     },
};

struct t_idmapped_mounts t_setgid_acl[] = {
	{ setgid_create_acl,						false,	"blabla",	},
	{ setgid_create_acl_idmapped,					true,	"blabla",	},
	{ setgid_create_acl_idmapped_in_userns,				true,	"blabla",	},
};

and two command line switches:

--test-setgid-umask
--test-setgid-acl

and two tests:

generic/<idx>
generic/<idx + 1>

where one of them calls:

--test-setgid-umask

and the other one:

--test-setgid-acl

That's roughly how I think it should work. But if you have a better
approach, please propose it.

> 
> ps: I doubt whether I need to send two patch sets(one is about 
> mknodat,tmpfile,errno, the another is about umask,acl,new case).
> What do you think about this?

I think a single patch _series_ with multiple patches:
1. errno bugfix
2. mknodat()
3. tmpfile()
4. umask & new test case for it as sm like generic/<idx>
4. acl & new test case for it as sm like generic/<idx + 1>

Christian
