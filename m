Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F177B89C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 14:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjHNM23 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 08:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjHNM2Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:28:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFF8106
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 05:28:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso568065266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 05:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692016098; x=1692620898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izsmEiSniL4Vpqa2NF6daalfMmbpg+9Z6Z1Kc+7+ox4=;
        b=CLfVoiMh1sB0QC7DEWNr+AJPXjOCXiRTkBknLkQ0BAm1E8j6pwL+s7tzvft4DAQVM9
         3f6csuTf4gJD4MTv2vdSdQ17bOyG0pkikKOFgJkQgVsMRMsqi0xODkFfvltuUgmDVvBY
         dk6cF1BjxwJLmw03sxMLCFa7ovXAecTrQTnJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692016098; x=1692620898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izsmEiSniL4Vpqa2NF6daalfMmbpg+9Z6Z1Kc+7+ox4=;
        b=lkPlOdZzuQZRA1JvkCA2jLhgidz0luHnztO25pMyg0zhggiGtEVbMpIv4BnuXZbjVH
         eWz8yxDgXWV6gEUQyX39a24YKrz079bxDJas5C0rOlXg6oYCSBjmru8olJp/PPqlQ4Vu
         dh15Bdy2esLs4q9iRy7HyzY4oB19JTk2O2k48KFUNaWOdeqdIsen9IOkkssqr3RwOYyh
         VtB3MINlJsg7Pvb8Q2n5iNBYP0GI2xkpAcGXmB++7eAYgOJniVxtuFrpFfxPpfb5W842
         OOiTcSxNkfyhwPV+D7bo4WXVXIUyD6OE3vCpTDkE5DmtBWk1H3iPk8T+e3iLMRa+UD39
         ZVWw==
X-Gm-Message-State: AOJu0Yw4Jr4Apz2orsPrh9OzAAWmey8UuTSB8nnbrfwUG5iEijyDYWS7
        WlTKbETTmxJo7KbK3ctKr7CxJZhuFTdYkMs5+wzkVg==
X-Google-Smtp-Source: AGHT+IGB9KGGRhBVej7Q/xDzR/9vvDZmK/JkqOEfmuqgJJ1lhO6IXGwof9X8q3cbaMpkykBpZt14zXaapbKCUOQVLRk=
X-Received: by 2002:a17:906:73dc:b0:99d:101b:8403 with SMTP id
 n28-20020a17090673dc00b0099d101b8403mr7579441ejl.36.1692016098647; Mon, 14
 Aug 2023 05:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <4f66cded234462964899f2a661750d6798a57ec0.camel@bitron.ch>
 <CAJfpeguG4f4S-pq+_EXHxfB63mbof-VnaOy-7a-7seWLMj_xyQ@mail.gmail.com> <da17987a-b096-9ebb-f058-8eb91f15b560@fastmail.fm>
In-Reply-To: <da17987a-b096-9ebb-f058-8eb91f15b560@fastmail.fm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 14 Aug 2023 14:28:07 +0200
Message-ID: <CAJfpegtUVUDac5_Y7BMJvCHfeicJkNxca2hO1crQjCNFoM54Lg@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: execve() fails with ETXTBSY due to async fuse_flush
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Aug 2023 at 14:07, Bernd Schubert <bernd.schubert@fastmail.fm> w=
rote:
>
>
>
> On 8/14/23 13:02, Miklos Szeredi wrote:
> > On Mon, 14 Aug 2023 at 08:03, J=C3=BCrg Billeter <j@bitron.ch> wrote:
> >>
> >> Since v6.3-rc1 commit 5a8bee63b1 ("fuse: in fuse_flush only wait if
> >> someone wants the return code") `fput()` is called asynchronously if a
> >> file is closed as part of a process exiting, i.e., if there was no
> >> explicit `close()` before exit.
> >>
> >> If the file was open for writing, also `put_write_access()` is called
> >> asynchronously as part of the async `fput()`.
> >>
> >> If that newly written file is an executable, attempting to `execve()`
> >> the new file can fail with `ETXTBSY` if it's called after the writer
> >> process exited but before the async `fput()` has run.
> >
> > Thanks for the report.
> >
> > At this point, I think it would be best to revert the original patch,
> > since only v6.4 has it.
> >
> > The original fix was already a workaround, and I don't see a clear
> > path forward in this direction.  We need to see if there's better
> > direction.
> >
> > Ideas?
>
> Is there a good reason to flush O_RDONLY?

->flush() is somewhat of a misnomer, it's the callback for explicit
close(2) and also for implicit close by exit(2).

The reason it's called flush is that nfs/fuse use it to ensure
close-to-open cache consistency, which means flushing dirty data on
close.

On fuse it also used to unlock remote posix locks, and we really know
what other "creative" uses were found for this request.  So while we
could turn off sending FLUSH for read-only case (and use SETLK/F_UNLCK
for the remote lock case) but first let's see a use case.  Sending
FLUSH can already be disabled by returning ENOSYS.

>
> fuse: Avoid flush for O_RDONLY
>
> From: Bernd Schubert <bschubert@ddn.com>
>
> A file opened in read-only moded does not have data to be
> flushed, so no need to send flush at all.
>
> This also mitigates -EBUSY for executables, which is due to
> async flush with commit 5a8bee63b1.

Does it?  If I read the bug report correctly, it's the write case that
causes EBUSY.

Thanks,
Miklos
