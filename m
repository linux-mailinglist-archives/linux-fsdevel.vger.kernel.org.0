Return-Path: <linux-fsdevel+bounces-33628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9609BBB3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04F19B22035
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 17:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E61C7269;
	Mon,  4 Nov 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F4V+x0I/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA41C4A3C;
	Mon,  4 Nov 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740376; cv=none; b=ejoyEzSH5lPS1taVj3wxYmOYNadc41Acl+sb3vyatuKDZAYtesjksejjDKQUV7TjFUudmUJ7kRxbIh8TQMJVT7WxtzV15lJqkkVguL6twPt2guzp4bAbPIvrRfiD/iXQmEdhBI62RR3E/1wIltOmUTlQa38//usxpUXvVE74qLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740376; c=relaxed/simple;
	bh=U2n+VratdOLz+XI1C0YnsMs73NGJc0lLzHsILwqI6FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Crrt7ZMEtNXt7HREInyTPC7zb+aNVQ4nqte84ZyK/DJgqhLBLlmLsy3Dvok0K/B5EA8bPagADimJHajavsMs0zY5VF+bXE3WKdxAwrMfPuunmx2nWOwGFhqm8LM/zhYPcuawRpLGMPLlE/dpYJrRKE7PCgoi1a23xzIVnUrIgjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F4V+x0I/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=q8iLecLEKa/r3VYIqb+8t/jQ6aKfvsWL9FBNV9ep8SI=; b=F4V+x0I/tUhbdjsnHjapWOGEb7
	YbSq2hbHkNTSHjLDHu0IKPMQ1Da82KrK2A975/AT7MHTAThCs8kVIfPg1RT/+MpLE9WSqcynPnTH7
	6lFqm7jPWS+3OruLMcmw6fqY4N75LC7rykazqA2X6JXYefNt/q8mMKOQmHZsodhEy+/4RwR8OQYY2
	n42CmbVf8dH1RA4yZ5jKdqExr3Lv1ti3ls2X7CWI9IBlTWmVBRUkugQGaa0yTuZPnPIu58Cpmsb4N
	rQytygBZMlzlzR/jgSzvEQvbDinPwR4GtPO66KZhzwXlaPc8v+gl0b/JOTXPvgpnps93H72Tc58At
	UcEo1o/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t80dH-0000000B3C5-2DAw;
	Mon, 04 Nov 2024 17:12:51 +0000
Date: Mon, 4 Nov 2024 17:12:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Subject: Re: [PATCH] fix: general protection fault in iter_file_splice_write
Message-ID: <20241104171251.GU1350452@ZenIV>
References: <20241104084240.301877-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104084240.301877-1-danielyangkang@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Nov 04, 2024 at 12:42:39AM -0800, Daniel Yang wrote:
> The function iter_file_splice_write() calls pipe_buf_release() which has
> a nullptr dereference in ops->release. Add check for buf->ops not null
> before calling pipe_buf_release().
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
> Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")
> ---
>  fs/splice.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index 06232d7e5..b8c503e47 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -756,7 +756,8 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
>  			if (ret >= buf->len) {
>  				ret -= buf->len;
>  				buf->len = 0;
> -				pipe_buf_release(pipe, buf);
> +				if (buf->ops)
> +					pipe_buf_release(pipe, buf);
>  				tail++;
>  				pipe->tail = tail;
>  				if (pipe->files)

Wait a minute.  If nothing else, all those buffers should've passed through
pipe_buf_confirm() just prior to the call of ->write_iter(); just what had
managed to zero their ->ops and what else had that whatever it had been
done to them?

Note that pipe must've been held locked all along, so I suspect that we
ended up with ->write_iter() claiming to have consumed more than it had
been given.  That could've ended up with the second loop running around
the pipe->bufs[], having already emptied each of them and trying to
find where the hell had that extra data come from.

I'd suggest checking which ->write_iter() instance had been called and
hunting for bogus return values in there.  Again, ->write_iter(iocb, from)
should never return more than the value of iov_iter_count(from) prior
to the call; any instance told "write those 42 bytes" should never
reply with "here, I've written 69 of them", lest it confuses the living
fuck out of the callers.

