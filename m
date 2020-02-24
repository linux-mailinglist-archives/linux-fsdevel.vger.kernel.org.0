Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D616A8E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 15:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgBXOzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 09:55:39 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:58324 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727359AbgBXOzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 09:55:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D9AAD8EE193;
        Mon, 24 Feb 2020 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582556137;
        bh=nYoNWmZAomzGgPf7q+XQUVWK7ASnTrz9ODYpmR2mpKc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Za/Ozcng988/g8wymADbE9zgdkkvaF7q2cFM+uiHjmqmZVI01eMWKGeGXj5yoZqHz
         zW4LTM5KYvbWvLzaW9jO8C7RbNT2zgWdmQ9ZY6LelAG+ZHkW6+0wPAXJ5fIIef4uVF
         /0z2pvIbXhGqmOrPsG3ZJLCOQ+ILDTlH0xwnz/hE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wH3sn0ON16yB; Mon, 24 Feb 2020 06:55:37 -0800 (PST)
Received: from jarvis.ext.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1B36F8EE0E2;
        Mon, 24 Feb 2020 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1582556137;
        bh=nYoNWmZAomzGgPf7q+XQUVWK7ASnTrz9ODYpmR2mpKc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Za/Ozcng988/g8wymADbE9zgdkkvaF7q2cFM+uiHjmqmZVI01eMWKGeGXj5yoZqHz
         zW4LTM5KYvbWvLzaW9jO8C7RbNT2zgWdmQ9ZY6LelAG+ZHkW6+0wPAXJ5fIIef4uVF
         /0z2pvIbXhGqmOrPsG3ZJLCOQ+ILDTlH0xwnz/hE=
Message-ID: <1582556135.3384.4.camel@HansenPartnership.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        christian@brauner.io, Jann Horn <jannh@google.com>,
        darrick.wong@oracle.com, Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Feb 2020 06:55:35 -0800
In-Reply-To: <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>
         <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-02-24 at 11:24 +0100, Miklos Szeredi wrote:
> On Fri, Feb 21, 2020 at 9:21 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
[...]
> > Could I make a suggestion about how this should be done in a way
> > that doesn't actually require the fsinfo syscall at all: it could
> > just be done with fsconfig.  The idea is based on something I've
> > wanted to do for configfd but couldn't because otherwise it
> > wouldn't substitute for fsconfig, but Christian made me think it
> > was actually essential to the ability of the seccomp and other
> > verifier tools in the critique of configfd and I belive the same
> > critique applies here.
> > 
> > Instead of making fsconfig functionally configure ... as in you
> > pass the attribute name, type and parameters down into the fs
> > specific handler and the handler does a string match and then
> > verifies the parameters and then acts on them, make it table
> > configured, so what each fstype does is register a table of
> > attributes which can be got and optionally set (with each attribute
> > having a get and optional set function).  We'd have multiple tables
> > per fstype, so the generic VFS can register a table of attributes
> > it understands for every fstype (things like name, uuid and the
> > like) and then each fs type would register a table of fs specific
> > attributes following the same pattern. The system would examine the
> > fs specific table before the generic one, allowing
> > overrides.  fsconfig would have the ability to both get and
> > set attributes, permitting retrieval as well as setting (which is
> > how I get rid of the fsinfo syscall), we'd have a global parameter,
> > which would retrieve the entire table by name and type so the whole
> > thing is introspectable because the upper layer knows a-priori all
> > the attributes which can be set for a given fs type and what type
> > they are (so we can make more of the parsing generic).  Any
> > attribute which doesn't have a set routine would be read only and
> > all attributes would have to have a get routine meaning everything
> > is queryable.
> 
> And that makes me wonder: would a
> "/sys/class/fs/$ST_DEV/options/$OPTION" type interface be feasible
> for this?

Once it's table driven, certainly a sysfs directory becomes possible. 
The problem with ST_DEV is filesystems like btrfs and xfs that may have
multiple devices.  The current fsinfo takes a fspick'd directory fd so
the input to the query is a path, which gets messy in sysfs, although I
could see something like /sys/class/fs/mount/<path>/$OPTION working.

James

