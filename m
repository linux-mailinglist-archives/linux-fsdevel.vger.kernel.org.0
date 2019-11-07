Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7FF36C1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2019 19:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKGSPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Nov 2019 13:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfKGSPm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:15:42 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93ECF222C2
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2019 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573150541;
        bh=mkkJBDyIiAdnm/glQLkfsD0szVtlg4EXK/75ogcIUiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pQqJMQdtiWhzbkNUqqqm0gMcVuFUFO6KFRLn/L3tv6U+SHbk6Yl5nXLVb2nXQjgFW
         YjXLXvGC8ZXU3YaPRHpZzlWR5Gjr/8D28yaAwzDWfK26KeGUzf3KvZ7inKo317qC7G
         1cIx5r9ZIlXNLcSGM/Nd3hpDiNqLz/fqkOviuI2Q=
Received: by mail-wr1-f54.google.com with SMTP id e6so4198078wrw.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2019 10:15:41 -0800 (PST)
X-Gm-Message-State: APjAAAVDp+W3HOE++aIjLD2ewNtJfNz0fNDiApyYvw0X3TTdybozqUuJ
        Bh0ieX/Kdl21ufBEEFJdTC8mkf4fYPN6N8+LyBYWdg==
X-Google-Smtp-Source: APXvYqx20OM7QsTfSBvENmpd1ZzYDPmxA0e8l69FibUDYivV3Y4TzOtfUMdKVs1bwqiNP0U1tpOoZOTXhte3WmwIXm8=
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4364675wrm.106.1573150540087;
 Thu, 07 Nov 2019 10:15:40 -0800 (PST)
MIME-Version: 1.0
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
 <157313379331.29677.5209561321495531328.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313379331.29677.5209561321495531328.stgit@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 Nov 2019 10:15:28 -0800
X-Gmail-Original-Message-ID: <CALCETrWszYm9=-WEgSbhmGc3DYCvY6q3W4Lezm6YtKnGtRs_5g@mail.gmail.com>
Message-ID: <CALCETrWszYm9=-WEgSbhmGc3DYCvY6q3W4Lezm6YtKnGtRs_5g@mail.gmail.com>
Subject: Re: [RFC PATCH 08/14] pipe: Allow buffers to be marked
 read-whole-or-error for notifications [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 7, 2019 at 5:39 AM David Howells <dhowells@redhat.com> wrote:
>
> Allow a buffer to be marked such that read() must return the entire buffer
> in one go or return ENOBUFS.  Multiple buffers can be amalgamated into a
> single read, but a short read will occur if the next "whole" buffer won't
> fit.
>
> This is useful for watch queue notifications to make sure we don't split a
> notification across multiple reads, especially given that we need to
> fabricate an overrun record under some circumstances - and that isn't in
> the buffers.

Hmm.  I'm not totally in love with introducing a new error code like
this for read(), especially if it could affect the kind of pipe that
is bound to a file in a filesystem.  But maybe it's not a problem.
