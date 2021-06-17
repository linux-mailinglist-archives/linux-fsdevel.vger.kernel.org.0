Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A6A3AB533
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhFQNx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhFQNx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:53:56 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBDC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 06:51:48 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s19so3220118ioc.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 06:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IBnAxN1dl6e6lZ7Q2+bXcJtvvGJUhNFBADX0tltMbYs=;
        b=iGZa/MBwUZTxhbvaH2pkbARXjaJwOuAWvE39FCcm87r3nMneeDNoHcaM+m0D8QgY7d
         pNCq9MG3N17jfW9bNEKAzthntHWOdJjDgA8Vr19YJtYKu5Mwt1X2KkcTqvSEEHWpnOP6
         ejwONe80kKU17iXXr4uhLuH9T27K/LGGzPvTdxQ2cIUfRs04j2VP9KhhhHmLgjK8CWwN
         bii4M39vbzsPvcNN1hfiawAiic7N7kckTTgGLoGqeoKN6edXjezhqRcK8IAWvSQVvAlb
         65HT+iBcfim5dVvI4XbPJmDCvSqYcVXyGBdY+9wKKr5UB3ZP3pG6dfOsxxroYCG+A8rz
         FfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IBnAxN1dl6e6lZ7Q2+bXcJtvvGJUhNFBADX0tltMbYs=;
        b=l5h+O8HBcKfH6hM6ac+ZaqP2cjgqa9iTrSc/e13RwsUvsNA3qMlDwPt/+UGB1djaAF
         T3efTWvg6FYYhSQ9F40TqMpzooV7+JrS+PPpLvYy7wG0cxXxJv9QUXZTYYlenbQZXJCO
         rpAzZuCzQ+isPKJmDTBbiXWNPoQDp65pXbdTug/jKjHgmQ+o8uJGTa2mq0VXdwT3q0MX
         Gtm+dHpu/uS0qEfsWmOqbS/HFq3NoNpJjQlHKL96DsBeVIu05AwEOUAsro0GLVovQ+AI
         maGsX6poRFxTc5wgdnUllZVSh7iBPJU0/CGq9+inqrziPOT8Zj64LB+pFBjONmrZ8/XB
         T6Yw==
X-Gm-Message-State: AOAM533DtOQYYRIvQ0/aSpghdBScevngeDwOWkId0EpJcDnNEt9hztOJ
        pXw4Sfz/d3ZMbXfR5fskYEu2jq7dzWwnTnSGEQQ=
X-Google-Smtp-Source: ABdhPJwBQoF4/Nf0BbJAHPrl6HX1fhry+d+xCvy1D7YjRHXQ1W62qzYqdepR/o6YlpNJt5QJOzIAK0kX4GwjKFQViLY=
X-Received: by 2002:a02:3505:: with SMTP id k5mr4815550jaa.123.1623937908390;
 Thu, 17 Jun 2021 06:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210609181158.479781-1-amir73il@gmail.com> <CAOQ4uxi3vK1eyWk69asycmo5PTyUE9+o7-Ha17CTXYytQiWPZQ@mail.gmail.com>
 <d7a38600-5b4b-487e-9362-790a7b5dde05@www.fastmail.com> <CAOQ4uxgzpKRWU2fFgF4OxROHZ84VZw7Ljqt5RvAi4b3ViTNfYg@mail.gmail.com>
 <87r1h13p39.fsf@vostro.rath.org>
In-Reply-To: <87r1h13p39.fsf@vostro.rath.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Jun 2021 16:51:37 +0300
Message-ID: <CAOQ4uxi8DymG=JO_sAU+wS8akFdzh+PuXwW3Ebgahd2Nwnh7zA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix illegal access to inode with reused nodeid
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:52 AM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> On Jun 16 2021, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Jun 16, 2021 at 8:25 PM Nikolaus Rath <nikolaus@rath.org> wrote:
> >>
> >> Hi Amir,
> >>
> >> On Wed, 16 Jun 2021, at 16:03, Amir Goldstein wrote:
> >> > Per request from Nikolaus, I modified the passthrough_hp example
> >> > to reuse inodes on last close+unlink, so it now hits the failure in the
> >> > new test with upstream kernel and it passes the test with this kernel fix.
> >> >
> >> > Thanks,
> >> > Amir.
> >> >
> >> > [2] https://github.com/libfuse/libfuse/pull/612
> >>
> >> Actually, I am no longer sure this was a good idea. Having the libfuse test suite detect
> >> problems that with the kernel doesn't seem to helpful.. I think the testsuite should
> >> identify problems in libfuse.  Currently, having the tests means that users might be
> >> hesitant to update to the newer libfuse because of the failing test - when in fact there
> >> is nothing wrong with libfuse at all.
> >>
> >
> > I suppose you are right.
> > I could take the tesy_syscalls test to xfstest, but fuse support for
> > xfstests is still WIP.
> >
> >> I assume the test will start failing on some future kernel (which is why it passed CL),
> >> and then start passing again for some kernel after that?
> >
> > I was not aware that it passes CI.
> > There are no test results available on github.
>
> Arg. Looks like something is broken there. I mistook the absence of
> results for a passing result.
>
> > I am not aware of any specific kernel version where the test should pass,
> > but the results also depend on the underlying filesystem.
> >
> > If your underlying filesystem is btrfs, it does not reuse inode numbers
> > at all, so the test will not fail.
> >
> > For me the test fails on ext4 and xfs on LTS kernel 5.10.
> > As I wrote in PR:
> > "...Fails the modified test_syscalls in this PR on upstream kernel"
> >
> > If you revert the last commit the test would pass on upstream kernel:
> > 80f2b8b ("passthrough_hp: excercise reusing inode numbers")
> >
> > We could make behavior of passthrough_hp example depend
> > on some minimal kernel protocol version or new kernel capability like
> > FUSE_SETXATTR_EXT if Miklos intends to merge the fix for the coming
> > kernel release or we could just make that new test optional via pytest option.
> >
> > After all, regardless of the kernel bug, this adds test coverage that was
> > missing, so it also covers a possible future regression in libfuse.
> >
> > Let me know if you want me to implement any of the listed options.
>
> I don't want an old kernel to result in libfuse unit tests failing, but
> I think it's a good idea to cover this case in some form.
>
> Would you be able to make the test conditional on a recent enough kernel
> version?
>

That looks trivial, like:
def test_write_cache(tmpdir, writeback, output_checker):
    if writeback and LooseVersion(platform.release()) < '3.14':
        pytest.skip('Requires kernel 3.14 or newer')

I'll just wait to see if Miklos takes the kernel fix to v5.13
so I know which version to use in the condition.

Thanks,
Amir.
