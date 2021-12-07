Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034446C162
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Dec 2021 18:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhLGRN7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 12:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbhLGRN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:13:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACED0C061574;
        Tue,  7 Dec 2021 09:10:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 209B5CE1C58;
        Tue,  7 Dec 2021 17:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DFCC341C3;
        Tue,  7 Dec 2021 17:10:23 +0000 (UTC)
Date:   Tue, 7 Dec 2021 12:10:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yabin Cui <yabinc@google.com>
Subject: Re: [RFC][PATCH] tracefs: Set all files to the same group ownership
 as the mount option
Message-ID: <20211207121021.4d261d6e@gandalf.local.home>
In-Reply-To: <CAC_TJve8MMAv+H_NdLSJXZUSoxOEq2zB_pVaJ9p=7H6Bu3X76g@mail.gmail.com>
References: <20211206211219.3eff99c9@gandalf.local.home>
        <CAC_TJve8MMAv+H_NdLSJXZUSoxOEq2zB_pVaJ9p=7H6Bu3X76g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 7 Dec 2021 09:04:30 -0800
Kalesh Singh <kaleshsingh@google.com> wrote:

> One thing that I missed before: There are files that can be generated
> after the mount, for instance when a new synthetic event is added new
> entries for that event are created under events/synthetic/ and when a
> new instance is created the new entries generated under instances/.
> These new entries don't honor the gid specified when mounting. Could
> we make it so that they also respect the specified gid?

They don't?

/me looks at code

Aw crap. I thought since I have this:

static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
{
[..]
		case Opt_gid:
			if (match_int(&args[0], &option))
				return -EINVAL;
			gid = make_kgid(current_user_ns(), option);
			if (!gid_valid(gid))
				return -EINVAL;

			opts->gid = gid;

			set_gid(tracefs_mount->mnt_root, gid);
[..]


That the new files would inherit the opts->gid. But I see that they do not.

I'll add that as a separate patch.

Thanks for bringing that to my attention.

-- Steve
