Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EA5950AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 00:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbfHSWWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 18:22:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43680 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfHSWWQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 18:22:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so1639375pld.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Lcaalc+Y1kuv7I/RlswVoXefElZgsvwmbyr3DFrYUyY=;
        b=CZPNWD6YetEikyGkoDCuZkI0MKeRxm3tHLA/tkADRiT8Ty/2bRhrQZVHG6kx2C8Erl
         FyYb2HZW0wqwcR3x2ql2AfH9hEdmKB/QcZkntsUOX7YwQObxP5H7OjhroPhwPh272vBu
         DtoEC3CHyhAZKbeoXxBiwNnzaIZ85lxuKWYayTQU1n4EKAZTva7s5i27mNbkWRfWqeTu
         MC2ZX2nbO9U39lHvxeCW9dQfeCgAV1mlgzqkfY4YefTedsSaE/+xfYRdcKqyQpzNgYYm
         7DsLdXzpQ1i5TxpkO6RMyY5vIzvk0F0aTw660rKdvKaxrx11+0rKap8kyxX3NTF14mGG
         JR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Lcaalc+Y1kuv7I/RlswVoXefElZgsvwmbyr3DFrYUyY=;
        b=CrufTlHOXZZMxIZ8ZDfpcbulK+VL6sAqk/d+y4xAQW1X5Nm7S8dVbsUHqHyvZmEDKW
         96q7yJ3epgyaFskP0SIFHxv92dXE366/bdVe2n7Deo/8n/mtpIusFUQGuM0We3jpp1Rk
         H6n0Q4X1bZyELqioWhAjhP3Ys8RhIEsNv8K4aa5eqSVh3ifXmhG/E+6wSYs5jtv3t8Xj
         Fgo7FcsBc5VCWtrV8eZujMkrseaJD/yJL7OKw+ZtAHHDwoJQkcfgrMQQh5reJMsPzX4b
         XwTo7hsw3XaxaXh8OgfgI5AqrNz69KDI0QgZkMK1RV4PAwRBmrqaL+bXoLr6swhRsRnT
         Uk/A==
X-Gm-Message-State: APjAAAW+TjQ5shpF5uTZLa5ag5KMqMkMoT8mICmM9DutDiJgdLHveGnt
        Lw5LXQfkrWdv82iAXyqKEyYwJg==
X-Google-Smtp-Source: APXvYqyiGoWx93ACPN8pVo/ovNAO+ev/S6tQS4IypxdIbiocT+IvsE3qq6CHW88HuF2pH/t68NQX7A==
X-Received: by 2002:a17:902:2bc7:: with SMTP id l65mr12691612plb.119.1566253334806;
        Mon, 19 Aug 2019 15:22:14 -0700 (PDT)
Received: from [100.112.91.228] ([104.133.8.100])
        by smtp.gmail.com with ESMTPSA id p90sm15926451pjp.7.2019.08.19.15.22.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 15:22:14 -0700 (PDT)
Date:   Mon, 19 Aug 2019 15:21:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: tmpfs: fixups to use of the new mount API
In-Reply-To: <20190819151347.ecbd915060278a70ddeebc91@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.1908191518070.1091@eggly.anvils>
References: <alpine.LSU.2.11.1908191503290.1253@eggly.anvils> <20190819151347.ecbd915060278a70ddeebc91@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 19 Aug 2019, Andrew Morton wrote:
> On Mon, 19 Aug 2019 15:09:14 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> 
> > Several fixups to shmem_parse_param() and tmpfs use of new mount API:
> > 
> > mm/shmem.c manages filesystem named "tmpfs": revert "shmem" to "tmpfs"
> > in its mount error messages.
> > 
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled has valid options
> > "deny" and "force", but they are not valid as tmpfs "huge" options.
> > 
> > The "size" param is an alternative to "nr_blocks", and needs to be
> > recognized as changing max_blocks.  And where there's ambiguity, it's
> > better to mention "size" than "nr_blocks" in messages, since "size" is
> > the variant shown in /proc/mounts.
> > 
> > shmem_apply_options() left ctx->mpol as the new mpol, so then it was
> > freed in shmem_free_fc(), and the filesystem went on to use-after-free.
> > 
> > shmem_parse_param() issue "tmpfs: Bad value for '%s'" messages just
> > like fs_parse() would, instead of a different wording.  Where config
> > disables "mpol" or "huge", say "tmpfs: Unsupported parameter '%s'".
> 
> Is this
> 
> Fixes: 144df3b288c41 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")?

That's the patch and the SHA1 I saw when I looked it up in linux-next
yesterday: I don't know if the SHA1 will change before it reaches Linus.

> 
> and a Cc:stable is appropriate?

No: this is just a fix for linux-next and mmotm at present.

Hugh
