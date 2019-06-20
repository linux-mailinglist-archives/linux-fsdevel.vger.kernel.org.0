Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377A94DC80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2019 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFTV3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 17:29:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44219 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFTV3i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:29:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so6694756edr.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 14:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v3IpD3zOAyT/o3jFLveqYdHxVLapPS/YFt6LidFqVKU=;
        b=KvOr4Sp+Id3A6XKZfDq0jaToh9hTpDvR4uHERHTmM5jYRInzJr41kiC9SoOmmDJhky
         oWXqPY/lKaIz9THmlD7IH7YFcmC3tZDq/MG8PgXKGCf9XHFgOdbfcOfRn1VFfw/TeOoP
         bFK/Xo6W9HJHbqyCJAlgYtMGuDNKG7dFjc43Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v3IpD3zOAyT/o3jFLveqYdHxVLapPS/YFt6LidFqVKU=;
        b=gnAipUatzc8f7H+hqY3mjOZIFpOGIN9VzKA3Ql8rX4bSyaOY3qqA92kF6paBG/sMwd
         xK8ThV4Qhkf4VYnEEB+I1KUIHdzNfm4+9ZOF03Xh7JoPLk4S2oSG0ODsKK44+JUOfJ68
         woldF7n9IlffhDeIBTZLNzz6+4MJjn3jQD7GDXMuHwaqWbuPfYuBPpDESf6+dAesngFD
         28UQXqbhHIzRrWUgw3Ft0yBA/xFs59ZEEcb3UQ6+JEJIpq9u7onPpkm8fuA4/l+vwYTv
         WB51uxcPF/i/OSKBje7oqtLwwsq8G7jPMGX3mPqlEZ3dlYFT8xB5wzWw7de1Hvx48P9E
         Hl8Q==
X-Gm-Message-State: APjAAAX7ZHD6VPTCMwM9DvMyjXK+uDU8hcrGoUVKT7hHL9xT7U7M8ig5
        zY4XsgaeVFTGSR+WdZzEFNalmkBmnyY=
X-Google-Smtp-Source: APXvYqwiLdl1uyXIVefZgmANffYZapEg9i+qe3UV5nJXn6SzVdfVpNtt4lMT47bidtl9l8FDiTqxsw==
X-Received: by 2002:a17:906:19c6:: with SMTP id h6mr419861ejd.262.1561066176681;
        Thu, 20 Jun 2019 14:29:36 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id w35sm206082edd.32.2019.06.20.14.29.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:29:36 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id i11so6797261edq.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2019 14:29:36 -0700 (PDT)
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr8174762ejz.312.1561066175899;
 Thu, 20 Jun 2019 14:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190620151839.195506-1-zwisler@google.com> <20190620151839.195506-3-zwisler@google.com>
 <20190620212517.GC4650@mit.edu>
In-Reply-To: <20190620212517.GC4650@mit.edu>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Thu, 20 Jun 2019 15:29:24 -0600
X-Gmail-Original-Message-ID: <CAGRrVHw8LuMT7eTnJ4VV9OpnetSSYaLh5nLkN4Anevz6r8KmZA@mail.gmail.com>
Message-ID: <CAGRrVHw8LuMT7eTnJ4VV9OpnetSSYaLh5nLkN4Anevz6r8KmZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] jbd2: introduce jbd2_inode dirty range scoping
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 20, 2019 at 3:25 PM Theodore Ts'o <tytso@mit.edu> wrote:
> On Thu, Jun 20, 2019 at 09:18:38AM -0600, Ross Zwisler wrote:
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 5c04181b7c6d8..0e0393e7f41a4 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -1397,6 +1413,12 @@ extern int        jbd2_journal_force_commit(journal_t *);
> >  extern int      jbd2_journal_force_commit_nested(journal_t *);
> >  extern int      jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *inode);
> >  extern int      jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *inode);
> > +extern int      jbd2_journal_inode_ranged_write(handle_t *handle,
> > +                     struct jbd2_inode *inode, loff_t start_byte,
> > +                     loff_t length);
> > +extern int      jbd2_journal_inode_ranged_wait(handle_t *handle,
> > +                     struct jbd2_inode *inode, loff_t start_byte,
> > +                     loff_t length);
> >  extern int      jbd2_journal_begin_ordered_truncate(journal_t *journal,
> >                               struct jbd2_inode *inode, loff_t new_size);
> >  extern void     jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode);
>
> You're adding two new functions that are called from outside the jbd2
> subsystem.  To support compiling jbd2 as a module, we also need to add
> EXPORT_SYMBOL declarations for these two functions.
>
> I'll take care of this when applying this change.

Ah, yep, great catch.  Thanks!
