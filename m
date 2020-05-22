Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078741DF246
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 00:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgEVWrF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 18:47:05 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51403 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWrF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 18:47:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id cx22so5630733pjb.1;
        Fri, 22 May 2020 15:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Soq/qM8YDSOohlZrufc/0p3CKQgnbvVA890O59J+pEY=;
        b=T4c60BJE1K5WK97Myx9p5k9kgcheu1oeR1Oena0sMSpOlo/Sg31AD9Vqkm/6OLhwQi
         plmXRkX/AY9edqEDGzb10vu5jgmSSpYLate6tsk0U4IsN2CqjEiBgYvu7NmS8IDvc7a7
         1qI2tuxeiEhleMMuKteQ/NQijxsqueKTDkatVDaQHZbmXOIdhkhG8kZ51I28bSOaq5l7
         NVJ3MEt602cVxbrSidzxbsP2YMGKzzN/RfkHMSIUX7nb0SxBDIi/Qmqtf2qyrC2YAkux
         KdhpWmgEiMsEh1Pnhu7sq1Sd6QaQMVki8C10P1ViQ/CI6usE4O7JaqUhHpHLRLvMvEKb
         xawA==
X-Gm-Message-State: AOAM531Lugb38lUfyiasmvxyv1GMen0iO4k45dPq3jotEPz6+ttvCZ9r
        LwhqiRA8MzmeVbM76dUPbrw=
X-Google-Smtp-Source: ABdhPJwuZf7IYyU08VzJmlH1p+y4pX6qGSOuydAArSzS/L4mZQdD/DQjfH0EhJXMWd5b4dPo2XAZvA==
X-Received: by 2002:a17:90a:8d16:: with SMTP id c22mr6497706pjo.16.1590187624779;
        Fri, 22 May 2020 15:47:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e12sm6367533pgv.16.2020.05.22.15.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 15:47:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 67CDF40321; Fri, 22 May 2020 22:47:02 +0000 (UTC)
Date:   Fri, 22 May 2020 22:47:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
Message-ID: <20200522224702.GF11244@42.do-not-panic.com>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk>
 <20200513131335.GN11244@42.do-not-panic.com>
 <CAB=NE6WdYcURTxNLngMk3+JQfNHG2MX1oE_Mv08G5zcw=mPOyw@mail.gmail.com>
 <2d298b41-ab6f-5834-19d2-7d3739470b5f@broadcom.com>
 <075ae77b-000b-c00f-b425-59105dc2584a@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <075ae77b-000b-c00f-b425-59105dc2584a@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 03:14:59PM -0700, Scott Branden wrote:
> 
> 
> On 2020-05-22 2:59 p.m., Scott Branden wrote:
> > Hi Luis,
> > 
> > On 2020-05-13 7:19 a.m., Luis Chamberlain wrote:
> > > On Wed, May 13, 2020 at 7:13 AM Luis Chamberlain <mcgrof@kernel.org>
> > > wrote:
> > > > On Wed, May 13, 2020 at 06:49:50AM +0100, Al Viro wrote:
> > > > > On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
> > > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > > index 06b4c550af5d..ea24bdce939d 100644
> > > > > > --- a/fs/exec.c
> > > > > > +++ b/fs/exec.c
> > > > > > @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int
> > > > > > fd, void **buf, loff_t *size, loff_t max_size,
> > > > > >              goto out;
> > > > > > 
> > > > > >      ret = kernel_read_file(f.file, buf, size, max_size, id);
> > > > > > -out:
> > > > > >      fdput(f);
> > > > > > +out:
> > > > > >      return ret;
> > > > > Incidentally, why is that thing exported?
> > > > Both kernel_read_file_from_fd() and kernel_read_file() are exported
> > > > because they have users, however kernel_read_file() only has security
> > > > stuff as a user. Do we want to get rid of the lsm hook for it?
> > > Alright, yeah just the export needs to be removed. I have a patch
> > > series dealing with these callers so will add it to my queue.
> > When will these changes make it into linux-next?
> > It is difficult for me to complete my patch series without these other
> > misc. changes in place.
> Sorry, I see the patch series is still being worked on (missing changelog,
> comments, etc).
> Hopefully the patches stabilize so I can apply my changes on top fairly
> soon.

Yeah I have to redo that series to take into account feedback. I'll be
sure cc you on that. I have a few other series to attend to before that,
so I think this will take a week.

  Luis
