Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813FA2085B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 15:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfEPNi4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 09:38:56 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41823 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfEPNi4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 09:38:56 -0400
Received: by mail-yw1-f65.google.com with SMTP id o65so1353653ywd.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qr+6WvRiX3pogMssjEbhRp1B31IxMA8hcAHdYWyGHY8=;
        b=oxcIqPaltxcgwo1jyMdclUPP8OnOWZCBy9FoQHdbxSvmHeqt1GgAo0c61oN5znxgH1
         KkJ0RLvb+P3AGftOTe0NDplrkgfUw8f7FnaetRBvnsKYyy5fMauyQz7HIPgRI22XpKNL
         8t754aayZn3t+hZG80EoxdeYAWi6G6RzwwXz8GMaR1gK/EYKNp5ehrhedPmTYwd1GUlx
         Znkd6QVgjaAYdapwI7a91Jr9CnnLC766FLfzv2HNOogWvw2KHVfW2YBKeBvBrWwNrre0
         jI9xwEkzwZqI/CBb+AY4uWRjlMOdUT0I85LZBmJvH21qfErgZhuwzXLZ4hM0hUrPcXkV
         xKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qr+6WvRiX3pogMssjEbhRp1B31IxMA8hcAHdYWyGHY8=;
        b=U6uYEoorxKnnbPRm/uaGUKx9Mrop7D9FlAI+q79Hs1auuo5x+GNiwwxJSqfuDp9QKF
         YImT2vpUijhW/P2i6ukhomhTeVkw18OGSi+/WW7/902yyNlpFCnlUJcQbIwb064ivTLl
         XLsWi3L7XaTkk4xmzfH6EusdXHSfyB/Lu29u2sRZB+U8yviyJrWZMYSQyUkJpRwqtlUg
         6MgDoFR2NAzrv+qRrvcJRJaMoOCEIeozYthwHzW+rSHmhMjAprXrD2iiAWH1tyJr4a+R
         gRVxtoVgjlG1mhI57divBUUuhymnZJoqMUvvngstmeoENm5ubfCOb/8z99ej7Yo08FRc
         TWdQ==
X-Gm-Message-State: APjAAAVS0OFVlun3vjHvGz5QVAYzGMWk28Y7GbXgjOahiUCoOwBxaTjv
        jLEolAU4XKhdQds6AgOxpqLK2an6nhThuVRJ58QiX1pe
X-Google-Smtp-Source: APXvYqzimJZZAb//PnTS37btLLRX8CKAeGGiKsAY0RX26yUaXcJneFIRhlVitwktpsQk2h3xojaICBeJgByREdc3Pqg=
X-Received: by 2002:a81:1150:: with SMTP id 77mr23242584ywr.241.1558013935402;
 Thu, 16 May 2019 06:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190516102641.6574-1-amir73il@gmail.com> <20190516102641.6574-12-amir73il@gmail.com>
 <20190516123315.GA16889@lst.de>
In-Reply-To: <20190516123315.GA16889@lst.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 16 May 2019 16:38:44 +0300
Message-ID: <CAOQ4uximFFFijAu1B5u1zE2PMX07Vi6NaA8Qi1DRxCSUHPMTFg@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] fsnotify: call fsnotify_rmdir() hook from configfs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 3:33 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, May 16, 2019 at 01:26:38PM +0300, Amir Goldstein wrote:
> > This will allow generating fsnotify delete events after the
> > fsnotify_nameremove() hook is removed from d_delete().
>
> This seems to be missing 13 patches of context without it isn't
> reviewable.  If you decide to Cc someone either make sure they get all
> the patches or just don't bother to start with.

You are right. I wanted to avoid spamming all fs maintainers which all
individual fs patches, but should have CC'ed all on the cover letter and
the dependency patches 2-3:
https://lore.kernel.org/linux-fsdevel/20190516122506.GF13274@quack2.suse.cz/

I will go a head and manually forward those messages to all affected
maintainers.

Thanks,
Amir.
