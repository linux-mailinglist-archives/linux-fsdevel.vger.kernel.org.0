Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6148CE719B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2019 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbfJ1MkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Oct 2019 08:40:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44359 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfJ1MkH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:40:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id c4so11132325lja.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATDKJMcIxCSwydf+1lUKxJ7Ftg71NmlGmbozwsqMkmc=;
        b=QlzDd1Bh3krOIKFjcDBdZoayUKXaWxUvGFEq2duRqI6syPWfllKIuNiRiwFp3Rsvlm
         nxqwqgYi8hs/NEk8mASxHt8carAtxDUSL6DW6fwUayesh7ZvlNihXqYJHT/hp5a3B/c/
         sAj/eEL2RfuIZGHXujz05q+R3v1iYQI3WZw6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATDKJMcIxCSwydf+1lUKxJ7Ftg71NmlGmbozwsqMkmc=;
        b=AT5ULvgEKHc0svY0S5YmW7LDFgBk4MLoM3NSxPZ3TZPmG2/b8MOAtDBhullOuvn4Kg
         x6ZvNmO2w9mO8K1lAiMv4tCpfwD7UZiJ8GAsVahJYqMqykG18PYIGwmBchNz5467tfvu
         SVUDIciFSZ4LgFS0nF8MoBoKOk99BA++7gI69x+5f/9D3v0TXApG4gDu2lyrxiRTs1yo
         CSUfW40eFZwfr7Aa9sFpDeDcZKnl6MGkAOOAiSCyGdeA+ABDldQ7Q70F558HTRcKLpK6
         uipQNx1J6c5ccXCtfzeG/hs/cBUj1O9eAzQTNUZujv1srwWRqAgBFCEZuMB7hwgcUqA1
         LTJA==
X-Gm-Message-State: APjAAAVhunLL0WKqpirl5qXUJSjErdnX8TDBzKHS66/Q4tS2LfV5MN7R
        qJCDl8PIj9FzOr5NlxU3OziSO/Zlo8YCtg==
X-Google-Smtp-Source: APXvYqw1sKZoVzuE5SHYbP6k9XUGU7CpYI6m16R6vj7Q5evWDJMjaFeVySYzKYO9xJ5TFRZ8akqoSQ==
X-Received: by 2002:a2e:5c09:: with SMTP id q9mr3314850ljb.22.1572266404750;
        Mon, 28 Oct 2019 05:40:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 141sm5224977ljj.37.2019.10.28.05.40.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:40:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id a21so11145590ljh.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2019 05:40:02 -0700 (PDT)
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr8529100lja.48.1572266402291;
 Mon, 28 Oct 2019 05:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
In-Reply-To: <157225677483.3442.4227193290486305330.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:39:46 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjmLgo7DQT7Cy5rAGd=+2OK5Lqa8BN9qJFW1NPRoDfx5A@mail.gmail.com>
Message-ID: <CAHk-=wjmLgo7DQT7Cy5rAGd=+2OK5Lqa8BN9qJFW1NPRoDfx5A@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:59 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> Page cache could contain pages beyond end of file during write or
> if read races with truncate. But generic_file_buffered_read() always
> allocates unneeded pages beyond eof if somebody reads here and one
> extra page at the end if file size is page-aligned.

I wonder if we could just do something like this instead:

  diff --git a/mm/filemap.c b/mm/filemap.c
  index 85b7d087eb45..80b08433c93a 100644
  --- a/mm/filemap.c
  +++ b/mm/filemap.c
  @@ -2013,7 +2013,7 @@ static ssize_t generic_file_buffered_read(
        struct address_space *mapping = filp->f_mapping;
        struct inode *inode = mapping->host;
        struct file_ra_state *ra = &filp->f_ra;
  -     loff_t *ppos = &iocb->ki_pos;
  +     loff_t *ppos = &iocb->ki_pos, size;
        pgoff_t index;
        pgoff_t last_index;
        pgoff_t prev_index;
  @@ -2021,9 +2021,10 @@ static ssize_t generic_file_buffered_read(
        unsigned int prev_offset;
        int error = 0;

  -     if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
  +     size = i_size_read(inode);
  +     if (unlikely(*ppos >= size))
                return 0;
  -     iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
  +     iov_iter_truncate(iter, size);

        index = *ppos >> PAGE_SHIFT;
        prev_index = ra->prev_pos >> PAGE_SHIFT;

and yes, we still need to re-check the inode size after we've read the
page cache page (since it might have changed during the IO), but the
above seems fairly benign and simple.

Hmm?

              Linus
