Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C88128F2D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Dec 2019 18:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfLVRvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 12:51:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37382 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfLVRvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 12:51:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id o13so4216105ljg.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2019 09:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+DFRZm1mZCG8Q4iFUUSl87IJ9WC5zykHr6alPq0ZLo=;
        b=CQ8K6tZmrYw+i7cLRAX6nHHWBuA0WZCjyD1+ygJortD1DDEXd5VUtlYicd8UB1mI62
         u7NC/dlgoayz6shYBUr0GxxKdDUXPS9FLAP4nfrxjjyeNFGvs0cWJ/yiwbhnGE1BHFIo
         ow2Mg7DSIY0wQAnnfuT4xNkYfh9ioXkz9mqrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+DFRZm1mZCG8Q4iFUUSl87IJ9WC5zykHr6alPq0ZLo=;
        b=Kd8Dj/uKBVRgsXp4N5R/12kWlC9g5MaFGyC8JU93pVZMWLbAhkpe34c8PmAlvwxZJ8
         ogqJQpJ2kRxbfhFzZj6/CiFahcLAn1lSl6yjh4D+YWsEBvJJdB+QfQ8C+S+smUpkNlWV
         Lm5d0/qek3iJNgcyX9HKtn9DH53eHsTP82/UpLtWNJrznfHg/PG8+RecBwHAnePJ8o62
         OTu7WJQvQVo4bx06tIYM3bUqxvOnDBso2Mp/MVe7wjigPjc1PeIk19zvjYBjKRhhpr7m
         u8Ip6ZM2HwkdEifjyn6CfRQFDWFPoM9QHBgvqoMSwBSEjiI9sNNUQgav/pQREzRTKpWp
         92gA==
X-Gm-Message-State: APjAAAWB4ZHQgTmCvfRIheLH3AVuCf3TDZuehrQfZ4S9aLg5+psBCM4c
        W0usc89FDzfFOrt3ASLuYxCtPvmvchQ=
X-Google-Smtp-Source: APXvYqwH8xDaoGCITvwVMEnGHc0+aoi5NGyB4/ESusHpvF5JgssekH6vJm1an4DbS5/6K0pp2XVMjg==
X-Received: by 2002:a2e:2c16:: with SMTP id s22mr15599799ljs.248.1577037071310;
        Sun, 22 Dec 2019 09:51:11 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w6sm6870162lfq.95.2019.12.22.09.51.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 09:51:10 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 15so10980996lfr.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Dec 2019 09:51:10 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr14384920lfm.29.1577037069868;
 Sun, 22 Dec 2019 09:51:09 -0800 (PST)
MIME-Version: 1.0
References: <65b22cd4e8bb142c5b7b86bc33fb08de6f318089.1577017472.git.jstancek@redhat.com>
In-Reply-To: <65b22cd4e8bb142c5b7b86bc33fb08de6f318089.1577017472.git.jstancek@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Dec 2019 09:50:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGB-Xt1CPbLQ3wY5KENq48Ws5WNwHz+aQp+gmZY+47EQ@mail.gmail.com>
Message-ID: <CAHk-=wiGB-Xt1CPbLQ3wY5KENq48Ws5WNwHz+aQp+gmZY+47EQ@mail.gmail.com>
Subject: Re: [PATCH] pipe: fix empty pipe check in pipe_write()
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, rasibley@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 22, 2019 at 4:35 AM Jan Stancek <jstancek@redhat.com> wrote:
> Problem is that after pipe_write() reacquires pipe lock, it
> re-checks for empty pipe with potentially stale 'head' and
> doesn't wake up read side anymore. pipe->tail can advance
> beyond 'head', because there are multiple writers.

Thank you. Patch is obviously correct, applied.

I wonder how much that whole "cache head/tail/mask" really helps, and
if we should strive to get rid of it entirely (and just make
"pipe_emptuy()" and friends take a 'const struct pipe_inode_info *"
argument).

Oh well.  I've apple your one-liner, but next time I might decide the
cleverness and slight code generation advantage might not be worth it.

Hopefully there won't _be_ a next time, of course ;)

             Linus
