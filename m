Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68B20F9C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 18:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgF3QsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgF3QsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:48:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E9C061755;
        Tue, 30 Jun 2020 09:48:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cm21so389175pjb.3;
        Tue, 30 Jun 2020 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ApQe2g3WBSV3ReezXR0608DYl9YKnvXARWYAavQ7YIw=;
        b=fnYHdhusXGwrssNFq9f7RdWQ7QF/8tG0XFxkWiCDzkUEij+ySolbzb52U2TcCqsRMS
         MU8BldCON9vnyFmVZtrMFkJXh2WjUkbe2BFIFS5sTF2Q4IbvJDYdW43aYhkOkKp2oDY3
         BrXNsHyO82piiK6ByZCai2vgKaQosQmLAtAhnsY+4Yw3Q1fMmitdndRuV/+zxoJWnmFH
         BdckYlweDVfZjAhrLEG3LN+lY4R7C45pvY2qjymmYLB8Guoy5gJt4HO5XmzH/0jSgblx
         yKFQI0H+ntsmNKDwFT1+ByfhAHPnIa7ToO8uy9YcqRfebFlCVv7wOagiEMhZDUGqdShp
         buBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ApQe2g3WBSV3ReezXR0608DYl9YKnvXARWYAavQ7YIw=;
        b=SZLGNOmYPng8G7IgACy3q5E1+1RD4gQv/59DEeEJ3jlG/E8TKT9KEGzgIhqqT+P2ZE
         APUh3C3cMZqDQXkXLH5XrFWTg2V6S3jIYCLN+ibvAHPa9OX3LWq9y/hVqhSuBprwcvz5
         Xdnv/bT7SO4dZnBYEOXSFzcCyAkcpCWlE6sJy0Tx/ZhBWIhd3KW6GHxpaRbqbkxpZNwo
         bcyo/P655GyOOLfTGv2ed5cP+IMTP08CrKLOJoV7UVmCWYfRff0+9kg2W8hN5A2GfJp/
         V5VYMUV7p9epM2BAVLXf6D3OMzuJIgX4/mVzJDqw67rYvyXpzlNXUhuJWzzudaYNt0rJ
         QeDQ==
X-Gm-Message-State: AOAM533YDqO+93oi6cX83P5wnqm+NvylTjwlOmkePpDwdikUB03QYAUe
        A9SIh/l8/UDgqDWHzkrGuAw=
X-Google-Smtp-Source: ABdhPJw3cNeLKFTl77Sqa/wvydV1EIpLZeqAcp1qGN0ppQh+lhox9R/cbzDHrG521ewcHmFnMGepDg==
X-Received: by 2002:a17:902:9b97:: with SMTP id y23mr17272992plp.54.1593535700812;
        Tue, 30 Jun 2020 09:48:20 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e083])
        by smtp.gmail.com with ESMTPSA id m14sm2755481pjv.12.2020.06.30.09.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:48:19 -0700 (PDT)
Date:   Tue, 30 Jun 2020 09:48:17 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
Message-ID: <20200630164817.txa2jewfvk4stajy@ast-mbp.dhcp.thefacebook.com>
References: <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <40720db5-92f0-4b5b-3d8a-beb78464a57f@i-love.sakura.ne.jp>
 <87366g8y1e.fsf@x220.int.ebiederm.org>
 <aa737d87-cf38-55d6-32f1-2d989a5412ea@i-love.sakura.ne.jp>
 <20200628194440.puzh7nhdnk6i4rqj@ast-mbp.dhcp.thefacebook.com>
 <c99d0cfc-8526-0daf-90b5-33e560efdede@i-love.sakura.ne.jp>
 <874kqt39qo.fsf@x220.int.ebiederm.org>
 <6a9dd8be-333a-fd21-d125-ec20fb7c81df@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a9dd8be-333a-fd21-d125-ec20fb7c81df@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:28:49PM +0900, Tetsuo Handa wrote:
> On 2020/06/30 5:19, Eric W. Biederman wrote:
> > Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:
> > 
> >> On 2020/06/29 4:44, Alexei Starovoitov wrote:
> >>> But all the defensive programming kinda goes against general kernel style.
> >>> I wouldn't do it. Especially pr_info() ?!
> >>> Though I don't feel strongly about it.
> >>
> >> Honestly speaking, caller should check for errors and print appropriate
> >> messages. info->wd.mnt->mnt_root != info->wd.dentry indicates that something
> >> went wrong (maybe memory corruption). But other conditions are not fatal.
> >> That is, I consider even pr_info() here should be unnecessary.
> > 
> > They were all should never happen cases.  Which is why my patches do:
> > if (WARN_ON_ONCE(...))
> 
> No. Fuzz testing (which uses panic_on_warn=1) will trivially hit them.

I don't believe that's true.
Please show fuzzing stack trace to prove your point.
