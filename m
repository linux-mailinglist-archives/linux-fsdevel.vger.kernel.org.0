Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 783301716E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 13:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgB0MMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 07:12:43 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43854 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgB0MMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:12:43 -0500
Received: by mail-io1-f66.google.com with SMTP id n21so2887972ioo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 04:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADPruQShkcO4rejHA2j7AWDv2l4UzJOhJ1OTB2Et9Kw=;
        b=ZZ3gmJCs59hU/2WPnb5kAnbZzvDvCFV+Z+hlv/6qP1o6o5Ut3P1kkf5p1BLvxwIjhT
         BGoV8kuydZmmbemF8XO0AXJ7lRw678KoTyzqOS93r/IDl9knZqJR0rQqIE2gIlu3Vjmd
         /B+8xMuUotKRxSFV3MPIGTMMTamjVWrEU3TFGtlMM4BKWg7eQHltH3vZvpxX0nViP7Ok
         xBCDAKoGpKjyf0M9MUSazAffLtIgVjwsB68lrqL09LwoOpChKysoeUZEQPAPBjXukRrB
         HYKwrqIYu3VCqUCaFaiYIq8ji2QqBVa1hXvDQQ41weT1/QYDhGmdB4aXltTuEkHY7gYX
         tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADPruQShkcO4rejHA2j7AWDv2l4UzJOhJ1OTB2Et9Kw=;
        b=apT8GZo6I/4Ze2sc8+I1Xjw6q5VWNjUykS+X3kP2bwXajIReYVL0RkzJ7AIY1zL0mp
         lezgeNltiYcOU4W9TJEDQhRSNOi7XGRa6hdqqsZrDNPDj8xy7kEbhd6spAL7H65dP4bd
         FWXDiehuLwh4S2IQMByNaBscXg0j2/lziSjR0ir0+Q1bQRY77jVEvBG3PgCotQq/hgWa
         hLhemC9ogjhw6mGlZYWmOdLibDK6PP03X307sRzi3W2qRNW4wOqWdXdpR9PMFetnUjE0
         9Lcwwadxy1OX4SmJ9avL+SWy64+JgQgWFFtWocnpCaXQhJupY6En4fHc6Jj9ezvX7tOj
         IUvg==
X-Gm-Message-State: APjAAAU6bRsLS0C3nES+lj27VDegtmpQmuXKBuZOM0OiUa3gJMNnyhku
        eDnDIfqcaoml/TfaXSaEMHvV4m1LLHsMSNaOidR+xOTR
X-Google-Smtp-Source: APXvYqzYKkR4fd1U5ypJY1lIRlBzI1ITJKbM/7xyaPrWztExbz3Hd6X3hyB7n85p832DUDIGaQNSYVSwSC6M0JUlQUc=
X-Received: by 2002:a02:cdd9:: with SMTP id m25mr5083080jap.123.1582805562998;
 Thu, 27 Feb 2020 04:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz> <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com> <20200227112755.GZ10728@quack2.suse.cz>
In-Reply-To: <20200227112755.GZ10728@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Feb 2020 14:12:30 +0200
Message-ID: <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>
> > struct fanotify_fh_name {
> >          union {
> >                 struct {
> >                        u8 fh_type;
> >                        u8 fh_len;
> >                        u8 name_len;
> >                        u32 hash;
> >                 };
> >                 u64 hash_len;
> >         };
> >         union {
> >                 unsigned char fh[FANOTIFY_INLINE_FH_LEN];
> >                 unsigned char *ext_fh;
> >         };
> >         char name[0];
> > };
>
> So based on the above I wouldn't add just name hash to fanotify_fh_name at
> this point...
>

OK. but what do you think about tying name with fh as above?
At least name_len gets to use the hole this way.

I am trying this out now and it is really hard for me not to call the struct
above fanotify_fid.
IMO code looks much better when it is called this way.
The problem is inconsistency with struct fanotify_event_info_fid which
does include fsid, but I think we can live with that.

Anyway, I'll prepare a version or two of the end result and let you see
how it looks.

Thanks,
Amir.
