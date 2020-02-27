Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793631713AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 10:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgB0JGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 04:06:30 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:40103 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgB0JGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:06:30 -0500
Received: by mail-il1-f194.google.com with SMTP id i7so1746866ilr.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2020 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syflZTas6oidq14f0UxYrYu5gyw30ZJIZYZtJBdX1EQ=;
        b=uVvtqnYSB2+1XtA0B60aMQRLYswPzDLcvWft9hp6Gzukh5caGIAR9AsVPgxEtRCfw6
         8slv9hAADEmxfrw+CndeRW2hCJrx5c39FVnwInaB+F11pJetFgaBBoZO+RrPnq6vgHtq
         FUoo935KcVG1PyLpVc4OSCA1DOwPPB+w9EEcKmBgMZLTQVDjq2s5O0u4uZNE463j1Yas
         7snOoiAX08WFKIycEvzJAh27tVH3TCdI0XaTXv5ZuqKL8lolwk8B04AVdO3n1y1mdIqK
         rjACfNq4HbheXAP9Cu2GS6MC6BS0idjBYUvwAQUgkkZ2YkkBzwkxqfssl7IUPoH+bEHE
         cOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syflZTas6oidq14f0UxYrYu5gyw30ZJIZYZtJBdX1EQ=;
        b=j/ul2Sd+RK1ykeRXXxbthh4TkOANv8KTikzymUdpUJGbAR+um/ST9hENB40FeeTW3L
         i6C/oAEQKn7aAx4hnBRWpdW90FBkosQ1CTa0mKO9lCbbXuTTvTzUvQ+I3V719l+5CAxX
         KPz8jxCqxkeoXM/wVZi/kyfK1afdFBzazG5MA8pBTOoj02c74F4AJ8oCf6mRQrooOeHQ
         5aoS+qmN/zp/SYregS3NJ1Qp9DH/OmupO7MC88n5Qx3ZdHmzKJ2Plt5B0L6D8ElIG08b
         fFl6nXyDEvWS1bI3w0XNLW9Y28T2Cezw2+7I41WXUzFkbjMWE0pC+aOd45fGJl7KVRZH
         8v6Q==
X-Gm-Message-State: APjAAAVGCSvAgdjgVJ8iEXZ5QTerGT1l+BOAZx6ZHFkabc/7zwb61GOc
        bLwkCiosFhCi5XOxPOuDjzTGE652kO/P/50Gya2srA==
X-Google-Smtp-Source: APXvYqysp/V+VucOPKFZSY17Lo5UypySvl7Dpp1ewuRDy7r38kaGBOXejTza6qB6VoeW/wXihtItyuSXQEjVkg7DKXE=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr4176605ilq.250.1582794389987;
 Thu, 27 Feb 2020 01:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-12-amir73il@gmail.com>
 <20200226102354.GE10728@quack2.suse.cz> <CAOQ4uxivfnmvXag8+f5wJujqRgp9FW+2_CVD6MSgB40_yb+sHw@mail.gmail.com>
 <20200226170705.GU10728@quack2.suse.cz> <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Feb 2020 11:06:18 +0200
Message-ID: <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > So overall I think this would be better. The question is whether the
> > resulting code will really be more readable. I hope so because the
> > structures are definitely nicer this way and things belonging logically
> > together are now together. But you never know until you convert the code...
> > Would you be willing to try this refactoring?
>
> Yes, but I would like to know what you think about the two 6 byte holes
> Just let that space be wasted for the sake of nicer abstraction?
> It seems like too much to me.
>

What if we unite the fh and name into one struct and keep a 32bit hash of
fh+name inside?

This will allow us to mitigate the cost of memcmp of fh+name in merge
and get rid of objectid in fsnotify_event as you suggested.

struct fanotify_fh_name {
         union {
                struct {
                       u8 fh_type;
                       u8 fh_len;
                       u8 name_len;
                       u32 hash;
                };
                u64 hash_len;
        };
        union {
                unsigned char fh[FANOTIFY_INLINE_FH_LEN];
                unsigned char *ext_fh;
        };
        char name[0];
};

struct fanotify_fid_event {
        struct fanotify_event fae;
        __kernel_fsid_t fsid;
        struct fanotify_fh_name object_fh; /* name is empty */
};

struct fanofify_name_event {
        struct fanotify_fid_event ffe;
        struct fanotify_fh_name dirent;
};

So the only anomaly is that we use struct fanotify_fh_name
to describe object_fh which never has a name.

I think we can live with that and trying to beat that would be
over abstraction.

Thoughts?

Thanks,
Amir.
