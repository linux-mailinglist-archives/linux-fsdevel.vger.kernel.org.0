Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47712153E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 10:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGFIVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGFIVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:21:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08667C061794
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 01:21:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i25so38537380iog.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2020 01:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5EBosS/RsWqp/M19KQhBR7ltqJugSfxK3830yJE8Mlk=;
        b=iGUoW5fqLWFHZgZZTXFpa6yc0exxSgyqStv4aFZTv7Vpfr/hcBpCCdYkVH2niL3zJU
         f4CXPw8xa/HMqQUoF2ZG02mEs3n0xSO9RnDnRMlO6qGam0l5244iIfosBWoqTqod00uH
         nM1FpNDDPNmvMwSkYMKH6bFtPRZmZLvRF8oTzITxN1Su2X0CB/05y5n8yeorK3fA4HGw
         7zKsfBIihFAE+fPl27WE7QQTe1SMFZKf2bdsNRSI+Jfhd0SNx6P9NA1Cp+hAm4Kzrwfw
         OJ96k9sFRvqved19ugKB634LDEK1Z0D3cDKxw+VHwVFxE6286z4L4C+FgTKgoUU2g2yF
         3fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5EBosS/RsWqp/M19KQhBR7ltqJugSfxK3830yJE8Mlk=;
        b=KjSDiNvMeggt45dMkyrnnzHVymzvWJRlZR2dIcsPkrV3aS0wiFGtlCGuAOWGxOa1/z
         4VqueyhhgkJ6bYlmMrERcOPhLEEaurGg3mz73ThrPwSuz87TiwGTWO7J9ShJ0OzeRGEZ
         7xLyOdUpGB5xL8lKqeviye9EhpmcJXCFf4KPWrHVVu7KECdyjuLBIK8S/v5hz/cuqk/s
         JpFHNURUmKUYg5wnca9nsljaOU1ya2sKy3d3r8RDelUSk1nCma2WcC76AIcOmo6ICF4j
         C2ntd8kVgfLyLp9VWJo84xh8HkCk0VtGssn6oWJrRKTZfMI3T7qlJQWXaV7NN1he6t2d
         ZHXw==
X-Gm-Message-State: AOAM532YvYvOL0Le5scCWsxtB6xGajGo4hgSx6N2pM21V7NPJ/loTQmE
        9NdNzlmwpIsmxsCFtMMjSeb4BJ4dbcLc6majLsAfaWdr
X-Google-Smtp-Source: ABdhPJz+68DTVwEcr8MiT1AKd+Zws7pCao32hzBHCGnGujtZC5/mlnVXPy+q9eUddHxfIPIIK2Tlj0Eu7QTYXddpwUk=
X-Received: by 2002:a6b:b483:: with SMTP id d125mr24119566iof.186.1594023695203;
 Mon, 06 Jul 2020 01:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200612093343.5669-1-amir73il@gmail.com> <20200612093343.5669-20-amir73il@gmail.com>
 <20200703160229.GF21364@quack2.suse.cz>
In-Reply-To: <20200703160229.GF21364@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 6 Jul 2020 11:21:24 +0300
Message-ID: <CAOQ4uxjG6pd2_Rd1ssh__0f7=HVc0iOjAkQwaLsD+BOFPz2F=A@mail.gmail.com>
Subject: Re: [PATCH 19/20] fanotify: move event name into fanotify_fh
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 3, 2020 at 7:02 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 12-06-20 12:33:42, Amir Goldstein wrote:
> > An fanotify event name is always recorded relative to a dir fh.
> > Move the name_len members of fanotify_name_event into unused space
> > in struct fanotify_fh.
> >
> > We add a name_offset member to allow packing a binary blob before
> > the name string in the variable size buffer. We are going to use
> > that space to store the child fid.
>
> So how much is this packing going to save us? Currently it is 1 byte for
> name events (modulo that fanotify_alloc_name_event_bug() you mention
> below). With the additional fanotify_fh in the event, we'll save two more
> bytes by the packing. So that doesn't really seem to be worth it to me.
> Am I missing some other benefit?
>
> Maybe your main motivation (which is not mentioned in the changelog at all
> BTW) is that the whole game of inline vs out of line file handles is
> pointless when we kmalloc() the event anyway because of the name?

The only motivation, which is written in the commit message is to make
space to store the child file handle. Saving space is just a by product.
In fact, the new parceling code looses this space back to alignment
and I am perfectly fine with that.

> And it's
> actively wasteful in case handles don't fit in the inline space. I agree
> with that and it's good observation. But I'd rather leave fanotify_fh
> struct alone for the cases where we want to bother with inline vs out of line
> file handles and define new way of partitioning space at the end of the
> event among one or two file handles and name. Something like:
>
> struct fanotify_dynamic_info {

I called this fanotify_info. There is no ambiguity that justifies _dynamic_.
The encapsulations are:

fanotify_fid_event { ..., fanotify_fid { ..,buf[INLINE_BUF] } }
fanotify_name_event { ..., fanotify_info { fanotify_fid { ..,buf[..]
}+, name[..] }


>         u8 dirfh_len;
>         u8 filefh_len;

I called these {dir,file}_fh_totlen to distinguish from fh->len, which does not
include the size of the fanotify_fh header fields.

>         u8 name_len;
>         unsigned char buf[];

This had to be 4 bytes aligned to contain fanotify_fh.

> };
>
> And at appropriate offsets (0, dirfh_len, dirfh_len + filefh_len) there
> would be additional info (e.g. type + fh for file handles). Maybe this
> format will require some tweaking so that processing of both storage types
> of file handles can be reasonably uniform but at this point it seems
> cleaner than what you try to do fanotify_fh with combining lenghts and
> offsets and some blobs in the middle...
>

I tried your suggestion (with the minor modifications above) and I
like the result.
Pushed prep series with 2 last patches changed to branch fanotify_prep.
Old prep series is at fanotify_prep-v2.
Pushed tested full series adapted to this change to fanotify_name_fid.
Old full series is at fanotify_name_fid-v4.

There was almost no changes to the fanotify_name_fid patches besides
adapting the accessors, e.g.:
-               fanotify_fh_blob(&FANOTIFY_NE(event)->dir_fh);
+              fanotify_info_file_fh(&FANOTIFY_NE(event)->info);

Please let me know if you want me to post fanotify_name_fid-v5 with these
changes.

Thanks,
Amir.
