Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993807A4FA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjIRQsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjIRQsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:48:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACAC1728;
        Mon, 18 Sep 2023 09:47:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A389CC433C7;
        Mon, 18 Sep 2023 13:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695042351;
        bh=HYgvqysiYXEBze4xu0V7hvbNlfumeLQhBcoLM4ehRSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b1RHVr7VnZBKe35gk2YjibsLWGUFzDa6Rs5pzFVjT3+aDGTpZh34yeHyFrXrynL2K
         KqjZOVvPMxxpba5mXuTr+rNifmaKdTuBJuThpw3mmOpXucP7FoM/T58YcsXVi2ZjX9
         s6rZikmVXh85yURmqt1dPNeOfA8Eo9m5VW/ZNnDtU6rn7/KPyyZqSeXk17FbB2klQ4
         KgpaR9KKO4x3mG3x6rPOhzPwULyda9Gqt/uPciIbk1huxNbbpuVBvY9pFglPRCV0bl
         wpTGdRsSI2tIKAu8fxG6rG4rjjrdoJijWw14OEaRpYE84ISzldJIP8Z1St5PBmrS7t
         I5bRR5ywRd8zg==
Date:   Mon, 18 Sep 2023 15:05:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230918-bruchfest-erliegen-2bff785bf978@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <CAMp4zn-r5BV_T9VBPJf8Z-iG6=ziDEpCdmPgHRRXF78UoOjTjQ@mail.gmail.com>
 <39dc7081-fef3-007b-eee3-273bff549ecf@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39dc7081-fef3-007b-eee3-273bff549ecf@themaw.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:36:39AM +0800, Ian Kent wrote:
> 
> On 18/9/23 02:18, Sargun Dhillon wrote:
> > On Wed, Sep 13, 2023 at 9:25 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> > > Add a way to query attributes of a single mount instead of having to parse
> > > the complete /proc/$PID/mountinfo, which might be huge.
> > > 
> > > Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> > > needs to be queried based on path, then statx(2) can be used to first query
> > > the mount ID belonging to the path.
> > > 
> > > Design is based on a suggestion by Linus:
> > > 
> > >    "So I'd suggest something that is very much like "statfsat()", which gets
> > >     a buffer and a length, and returns an extended "struct statfs" *AND*
> > >     just a string description at the end."
> > > 
> > > The interface closely mimics that of statx.
> > > 
> > > Handle ASCII attributes by appending after the end of the structure (as per
> > > above suggestion).  Allow querying multiple string attributes with
> > > individual offset/length for each.  String are nul terminated (termination
> > > isn't counted in length).
> > > 
> > > Mount options are also delimited with nul characters.  Unlike proc, special
> > > characters are not quoted.
> > > 
> > Thank you for writing this patch. I wish that this had existed the many times
> > I've written parsers for mounts files in my life.
> > 
> > What do you think about exposing the locked flags, a la what happens
> > on propagation of mount across user namespaces?
> 
> Which flags do you mean?

When you propagate mounts across mount+user namespaces a subset of
(security sensitive) mount attributes become locked. This information is
currently only available via internal flags but not in any way
explicitly exposed to userspace.

There's a proposal to extend mount_setattr(2) to explicitly allow
locking flags but that would mean a new set of mount attr flags.

So until the format of that is determined and settled this should be
kept out of statmount().
