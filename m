Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597E3140709
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 10:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQJ5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 04:57:36 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:44934 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgAQJ5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:57:36 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so20794122iln.11;
        Fri, 17 Jan 2020 01:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2iv/H6UUaNNB2wpyKUhzLnF/ZjtEziCyO0ynW904oU=;
        b=lEKhV452mvESziCXpI+s4sMxPGiIoDNhNNtdO1u5G1u6Icw8sIy3JYP9kJPMF8+jiB
         2We/A/aGTdin03iiVhMN7lDtBO+NJ66fmGPFykAKxZVW8Q1+hvCr6cDYOgvFlnhPUs/Z
         iTb22gF9mqbLaS4r80j0brQL6frUI3onep4R5St9MDwHrpzmJv9MDisyS46ql7Yi+mSt
         NzhtirvbOj0her2XJeuglRWTIwSmFFXME+3qFOHTXkTpnIctje4BMv2fMnMN7ytwffjJ
         qQ4uhKJO7ub6f5ip0ui1vulLZtZvYMXFn+oY7t4+5ROwDYswfD5Q/EmY3dxcPH4oeqzi
         M+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2iv/H6UUaNNB2wpyKUhzLnF/ZjtEziCyO0ynW904oU=;
        b=eRJB5CsxPHvxnDJBplevyE6+JQEkFzR8k+hmJotbs7DbVhUREvrVSr/VBUD4JQhQkv
         V3r2cxQC1ZWo9foMEM/CiWJgbIzzAI6x9JwMxU+vaEV9ZkXa+fO5Ka2rNtd9u60Koq5L
         DdXmLwWGGyuYcXSGh9wBXezZnon3Vo8GKeioD4GMLI8LUBZ4RLRZzajzPP+sNvr39paH
         Ev7gc5pZdk62rAa0gV++Bn6CfW/k6J/LsC+NwAtSF007jO5i71bIcgn76BuFg7R6ImLF
         I7xaUpL9U4XU0OF8/3GvcK9UFGx9u7vGWdi4rwmj2/LIwtfecwQXjzF5THS48FUt7Dx5
         82Aw==
X-Gm-Message-State: APjAAAXjkZlLafjE1zfsDU0hbht1oKb0RLs70prxeSpyEJowPPIX3/0F
        5F72ecVQ9RQtPLaP4eauq5ycSg3FOqb+Vrypio2xUA==
X-Google-Smtp-Source: APXvYqwXlxCPM800tjJKMn9q0fTbt1G6E+pDLkKp14cOzG84ftedeRJt5gDSF1/VZifpKyNkSjSA0GITpbV3zIY02Ws=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr2295902ilq.250.1579255055251;
 Fri, 17 Jan 2020 01:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20200114170250.GA8904@ZenIV.linux.org.uk> <3326.1579019665@warthog.procyon.org.uk>
 <9351.1579025170@warthog.procyon.org.uk> <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com>
In-Reply-To: <2397bb4a-2ca2-4b44-8c79-64efba9aa04d@www.fastmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Jan 2020 11:57:24 +0200
Message-ID: <CAOQ4uxgxOzJ+ptExNAJvTJmeW6HNcg7h6siqRzMjYjw3sMYqmQ@mail.gmail.com>
Subject: Re: Making linkat() able to overwrite the target
To:     Colin Walters <walters@verbum.org>,
        David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 5:52 AM Colin Walters <walters@verbum.org> wrote:
>
> On Tue, Jan 14, 2020, at 1:06 PM, David Howells wrote:
>
> > Yes, I suggested AT_LINK_REPLACE as said magical flag.
>
> This came up before right?
>
> https://lore.kernel.org/linux-fsdevel/cover.1524549513.git.osandov@fb.com/

David,

This sounds like a good topic to be discussed at LSF/MM (hint hint)

Thanks,
Amir.
