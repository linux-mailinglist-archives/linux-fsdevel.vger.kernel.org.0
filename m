Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A167AA41E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjIUWBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjIUWAu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:00:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD2F49C0;
        Thu, 21 Sep 2023 14:57:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4033C433C8;
        Thu, 21 Sep 2023 21:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695333424;
        bh=xg68CNt2SlaMGpyG4gAVMg4P94guGLZJu+m0KZASMSk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ESb2uPqUJFbYcu+CCCrXk2B2rZnAv2MsIqy0wNTqHU7Hyjkrjyy5h/uMb9fdUNFHN
         8MRX+r9OCdyrZA4238UxTHuVfMXY7AHaHmuiSJeVm23aSc4xOywI3y+QTSPBljFOtn
         dd5V7etyPcl/zgBItr5Painzq+nSFrn8vYlNXYhqKFBPkBkAwRaYWIxBTB3Is9qeEr
         CtKC7H8oAadBfFi79kPpQSM5+mCDvHhn4SfwVwPzzslfSkSBbMpmLGRl1L36L+4xr+
         K18DPpLWdZvJuFi4UysK9m+7d1YA48E8QW5a0WrGWEANfha2S6wk2srn2ynVmTSuY9
         KnrLV4ZT9UwLw==
Message-ID: <bc96335d0427d0e7ded2ea7e1d0db55c7e484909.camel@kernel.org>
Subject: Re: [GIT PULL v2] timestamp fixes
From:   Jeff Layton <jlayton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Date:   Thu, 21 Sep 2023 17:57:02 -0400
In-Reply-To: <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
         <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
         <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
         <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
         <CAHk-=wjDAqOs5TFuxxEOSST-5-LJJkAS5cEMrDu-pgiYsrjyNw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-09-21 at 12:46 -0700, Linus Torvalds wrote:
> On Thu, 21 Sept 2023 at 12:28, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >=20
> > And that's ok when we're talking about times that are kernel running
> > times and we haev a couple of centuries to say "ok, we'll need to make
> > it be a bigger type",
>=20
> Note that the "couple of centuries" here is mostly the machine uptime,
> not necessarily "we'll need to change the time in the year 2292".
>=20

Right. On-disk formats are really a different matter anyway, so that
value is only relevant within a single running instance.

> Although we do also have "ktime_get_real()" which is encoding the
> whole "nanoseconds since 1970". That *will* break in 2292.
>

Still pretty much SEP, unless we all end up as cyborgs after this.

> Anyway, regardless, I am *not* suggesting that ktime_t would be useful
> for filesystems, because of this issue.
>=20
> I *do* suspect that we might consider a "tenth of a microsecond", though.
>=20
> Resolution-wise, it's pretty much in the "system call time" order of
> magnitude, and if we have Linux filesystems around in the year-31k,
> I'll happily consider it to be a SEP thing at that point ("somebody
> else's problem").
>=20

FWIW, I'm reworking the multigrain ctime patches for internal consumers.
As part of that, when we present multigrain timestamps to userland via
statx, we'll truncate them at a granularity of (NSEC_PER_SEC / HZ).

So, we could easily do that today since we're already going to be
truncating off more than that for external uses. Having a single word to
deal with would sure be simpler too, particularly since we're using
atomic operations here.

I'll have to think about it. The first step is to get all of the
timestamp handling wrappers in place anyway.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
