Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF20E2E9D9F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbhADTBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:01:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbhADTBA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:01:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72CE92068D;
        Mon,  4 Jan 2021 19:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786820;
        bh=eYDH7I7L8bWL2vt8l49YqGLHaNyHm8zw3PNNa5ep/t8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=L28K6zBEeKe2fgTBqc8D2PhthvUfH/oHDmKj9JDUNdk5zAhV6oUNd0/MlDoCaDAGI
         sO1fpXW19sGVH3rYtZGAWDylA11oJRHw/d/zMYyR239NjrtmmnNcfyv3H0ByuPzTNl
         dLUDqTGTx85Qk+p4o8HEmHBhKasOKJLQk8SGDxSMxhvLVjTwLfROfpdFov3sNVcYQ7
         sWD6TqSeAFdZhx6m2E19/45hTjjmZq9MiWPHBIAWf5jsFKi9GICWfgYvMWiH+oDwtz
         oxpLXUxT/ifTWzDXzS3PjsElX+l9EiGyjBDIyTvxY9v69/rS46pWVcKAbKiFzC3Ymv
         nZitEW+TRhZQA==
Message-ID: <183bdfcf876e7a33586e3236d73b7ad5ba88f293.camel@kernel.org>
Subject: Re: [PATCH][RESEND] vfs: serialize updates to file->f_sb_err with
 f_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sargun@sargun.me, amir73il@gmail.com, vgoyal@redhat.com
Date:   Mon, 04 Jan 2021 14:00:18 -0500
In-Reply-To: <20210104185717.GK3579531@ZenIV.linux.org.uk>
References: <20210104184347.90598-1-jlayton@kernel.org>
         <20210104185717.GK3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-01-04 at 18:57 +0000, Al Viro wrote:
> On Mon, Jan 04, 2021 at 01:43:47PM -0500, Jeff Layton wrote:
> > @@ -172,7 +172,12 @@ SYSCALL_DEFINE1(syncfs, int, fd)
> >  	ret = sync_filesystem(sb);
> >  	up_read(&sb->s_umount);
> >  
> > 
> > -	ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > +	if (errseq_check(&sb->s_wb_err, f.file->f_sb_err)) {
> > +		/* Something changed, must use slow path */
> > +		spin_lock(&f.file->f_lock);
> > +		ret2 = errseq_check_and_advance(&sb->s_wb_err, &f.file->f_sb_err);
> > +		spin_unlock(&f.file->f_lock);
> > +	}
> 
> 	Is there any point bothering with the fastpath here?
> I mean, look at the up_read() immediately prior to that thing...

It is a micro-optimization, but the vastly common case is that we will
avoid the spinlock there. That said, I'm fine with dropping the fastpath
if you prefer.

-- 
Jeff Layton <jlayton@kernel.org>

