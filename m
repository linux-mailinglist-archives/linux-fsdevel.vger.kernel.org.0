Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147D518334A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCLOiG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 10:38:06 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52972 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCLOiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:38:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCOyH-00ABbH-Uc; Thu, 12 Mar 2020 14:38:02 +0000
Date:   Thu, 12 Mar 2020 14:38:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] umh: fix refcount underflow in fork_usermode_blob().
Message-ID: <20200312143801.GJ23230@ZenIV.linux.org.uk>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:43:00PM +0900, Tetsuo Handa wrote:
> Before thinking how to fix a bug that tomoyo_realpath_nofollow() from
> tomoyo_find_next_domain() likely fails with -ENOENT whenever
> fork_usermode_blob() is used because 449325b52b7a6208 did not take into
> account that TOMOYO security module needs to calculate symlink's pathname,
> is this a correct fix for a bug that file_inode(file)->i_writecount != 0
> and file->f_count < 0 ?

> -	if (!file)
> +	if (!file) {
>  		file = do_open_execat(fd, filename, flags);
> -	retval = PTR_ERR(file);
> -	if (IS_ERR(file))
> -		goto out_unmark;
> +		retval = PTR_ERR(file);
> +		if (IS_ERR(file))
> +			goto out_unmark;
> +	} else {
> +		retval = deny_write_access(file);
> +		if (retval)
> +			goto out_unmark;
> +		get_file(file);
> +	}

*UGH*

	Something's certainly fishy with the refcounting there.
First of all, bprm->file is a counting reference (observe what
free_bprm() is doing).  So as it is, on success __do_execve_file()
consumes the reference passed to it in 'file', ditto for
do_execve_file().  However, it's inconsistent - failure of e.g.
bprm allocation leaves the reference unconsumed.  Your change
makes it consistent in that respect, but it means that in normal
case you are getting refcount higher by 1 than the mainline.
Does the mainline have an extra fput() *in* *normal* *case*?
I can easily believe in buggered cleanups on failure, but...
Has that code ever been tested?

	It _does_ look like that double-fput() is real, but
I'd like a confirmation before going further - umh is convoluted
enough for something subtle to be hidden there.  Alexei, what
the refcounting behaviour was supposed to be?  As in "this
function consumes the reference passed to it in this argument",
etc.
