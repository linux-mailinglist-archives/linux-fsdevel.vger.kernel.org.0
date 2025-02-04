Return-Path: <linux-fsdevel+bounces-40780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C95A2773A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A16B0188472F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E252D2153E6;
	Tue,  4 Feb 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4gj/8PT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402AE2C181;
	Tue,  4 Feb 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686894; cv=none; b=LWBe1uA5RYWBMIbpw1iCjwlZMMGBVFVO84jy54TgVqQrh5zqASBl/tjxKPfFjiaOU6ZAg6rlGMRd7ZNcVaobv58uJab/mpZaAaITxQFpY8V5fLTRSswzR2YGeUpm7FVokdGLISWTG9utsIA2RUNHjgOvDPw6QX8+66MSQy/C4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686894; c=relaxed/simple;
	bh=TI0TbfkWWJrU7AXAP6F3layI4mU8+eUtx1eWzqtqcKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7OEklp2UFwkFXGvEKbSmFR7ILaFCaYSHTa69+TcHuvm6MJ/EmV0oLQNsjxGJmIMprSFVnKx0PvMPqFo1CYidZJFX6g4l+ga5kUAJy5MVpJQXqrBp2PAKGoI4H9nkC9A8GK6mos7Z86LoA8IOd25QBOHQYPC7E9wfSeF9U8y2oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4gj/8PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE81C4CEDF;
	Tue,  4 Feb 2025 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738686893;
	bh=TI0TbfkWWJrU7AXAP6F3layI4mU8+eUtx1eWzqtqcKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4gj/8PTgkV2k1DwV++vpr+S21H1S/2dOWyLzP316mBKsso5iAADtGThEQ/sa00Bz
	 VItO5V9XWQ+wdXonoaIusntBiuhDeMzjiz+9heSvb1ZbIDR7eS6BvficFZBkQkZQ3t
	 atw0Y7hPeaGhhMKflo2HRYlSg9BP9AYoVHGse7uvrKWiUltVX4HH/wPOZ2xIg4Cq2O
	 r61CgxOyGxWaO75q7jUn1OWggwGlFYXEE8L9YS4SQNq6AoAWspte40QCEVwsTjYALn
	 Kz57WTkHfQqWJcjgIzsGvvfpVodaCfULRaHxaH3ANpkO4+Ubx3fSH+CGyER9C/0ntn
	 kwNAi5WVbW5jg==
Date: Tue, 4 Feb 2025 17:34:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
Message-ID: <20250204-autohandel-gebastelt-0ca4424b697b@brauner>
References: <20250204132153.GA20921@redhat.com>
 <CAGudoHGptAB1C+vKpfoYo+S9tU2Ow2LWbQeyHKwBpzy9Xh_b=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGptAB1C+vKpfoYo+S9tU2Ow2LWbQeyHKwBpzy9Xh_b=w@mail.gmail.com>

On Tue, Feb 04, 2025 at 03:21:18PM +0100, Mateusz Guzik wrote:
> On Tue, Feb 4, 2025 at 2:22 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > These numbers are visible in fstat() but hopefully nobody uses this
> > information and file_accessed/file_update_time are not that cheap.
> 
> I'll note majority of the problem most likely stems from
> mnt_get_write_access rolling with:

So anonymous pipes are based on pipefs which isn't exposed to userspace
at all. Neither the superblock nor an individual mount can go read-only
or change mount properties. The superblock cannot be frozen etc.

So really that mnt_get_write_access() should be pointless for
anonymous pipes. In other words, couldn't this also just be:

diff --git a/fs/pipe.c b/fs/pipe.c
index 8df42e1ab3a3..e9989621362c 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -604,12 +604,25 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
        kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
        if (wake_next_writer)
                wake_up_interruptible_sync_poll(&pipe->wr_wait, EPOLLOUT | EPOLLWRNORM);
-       if (ret > 0 && sb_start_write_trylock(file_inode(filp)->i_sb)) {
-               int err = file_update_time(filp);
-               if (err)
-                       ret = err;
-               sb_end_write(file_inode(filp)->i_sb);
+       if (ret > 0) {
+               int err;
+
+               if (!is_anon_pipe(file)) {
+                       if (sb_start_write_trylock(file_inode(filp)->i_sb)) {
+                               err = file_update_time(filp);
+                               if (err)
+                                       ret = err;
+
+                               sb_end_write(file_inode(filp)->i_sb);
+                       }
+               } else {
+                       // Anonymous pipes don't need all the mount + sb bruah.
+                       err = inode_needs_update_time(inode);
+                       if (err > 0)
+                               ret = inode_update_time(file_inode(filp), err);
+               }
        }
+
        return ret;
 }

and then have zero regression risk?

