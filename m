Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8434A5D78
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 14:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbiBANbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 08:31:10 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60626 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbiBANbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:31:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD4C61550;
        Tue,  1 Feb 2022 13:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90227C340EE;
        Tue,  1 Feb 2022 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643722269;
        bh=4Hph1Xspv1ZkBJhPuwT67fnUqWYd5t9uCiDybIaGUJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXUmP9MiVd67nqDGuae58r7bJ5ejkFSOGKd4+N9JgzF0S+BWzjj1G64KlMu7llkFh
         WbzkUyO/Vy/W++5wS+Wy7SLK2DMtU1ZtsCblfCmtvp4KwEAagyfv1E3y+aNPLhUQA/
         1XPXHa6zZc+BxDs7pYe1AyWSs/qSZa3vmrgobYtjhXMeN2tPSeqmVFxzDi6D6kDzo1
         H2bf9+JafqhAi4GQauDEoVFvsNrABolF5aXfsHNUOhmHeZU4u+FfT48hew7GdHKtWP
         X/22bL0bI/y1Dexb/orSimKzOIcLCiC6mkCAtQ3cpnydGrAdpHGnqONbLuj0PptcJy
         9YSNw79E3WcHA==
Date:   Tue, 1 Feb 2022 14:31:03 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Rich Felker <dalias@libc.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/633: adapt execveat() invocations
Message-ID: <20220201133103.bnqplswevdsdsjfv@wittgenstein>
References: <20220131171023.2836753-1-brauner@kernel.org>
 <202201311245.0B2126B468@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202201311245.0B2126B468@keescook>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:46:27PM -0800, Kees Cook wrote:
> On Mon, Jan 31, 2022 at 06:10:23PM +0100, Christian Brauner wrote:
> > There's a push by Ariadne to enforce that argv[0] cannot be NULL. So far
> > we've allowed this. Fix the execveat() invocations to set argv[0] to the
> > name of the file we're about to execute.
> 
> To be clear, these tests are also trying to launch set-id binaries with
> argc == 0, so narrowing the kernel check to only set-id binaries
> wouldn't help here, yes?

Yes, that wouldn't help.
The new approach of mutating argv { NULL } into { "", NULL } is better.
