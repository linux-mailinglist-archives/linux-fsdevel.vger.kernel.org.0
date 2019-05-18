Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 980A4224BD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfERUEL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 16:04:11 -0400
Received: from fieldses.org ([173.255.197.46]:55060 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725950AbfERUEL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 16:04:11 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 535441C81; Sat, 18 May 2019 16:04:11 -0400 (EDT)
Date:   Sat, 18 May 2019 16:04:11 -0400
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] nfsd: allow fh_want_write to be called twice
Message-ID: <20190518200411.GB32684@fieldses.org>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
 <1557969619-17157-2-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557969619-17157-2-git-send-email-bfields@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ugh, sorry, ignore the two old patches that got sent with the new
series.

--b.

On Wed, May 15, 2019 at 09:20:06PM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> A fuzzer recently triggered lockdep warnings about potential sb_writers
> deadlocks caused by fh_want_write().
> 
> Looks like we aren't careful to pair each fh_want_write() with an
> fh_drop_write().
> 
> It's not normally a problem since fh_put() will call fh_drop_write() for
> us.  And was OK for NFSv3 where we'd do one operation that might call
> fh_want_write(), and then put the filehandle.
> 
> But an NFSv4 protocol fuzzer can do weird things like call unlink twice
> in a compound, and then we get into trouble.
> 
> I'm a little worried about this approach of just leaving everything to
> fh_put().  But I think there are probably a lot of
> fh_want_write()/fh_drop_write() imbalances so for now I think we need it
> to be more forgiving.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/nfsd/vfs.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index a7e107309f76..db351247892d 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -120,8 +120,11 @@ void		nfsd_put_raparams(struct file *file, struct raparms *ra);
>  
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
> -	int ret = mnt_want_write(fh->fh_export->ex_path.mnt);
> +	int ret;
>  
> +	if (fh->fh_want_write)
> +		return 0;
> +	ret = mnt_want_write(fh->fh_export->ex_path.mnt);
>  	if (!ret)
>  		fh->fh_want_write = true;
>  	return ret;
> -- 
> 2.21.0
