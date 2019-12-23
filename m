Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BF112909E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 02:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfLWBRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 20:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:49268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfLWBRr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:17:47 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60035206CB;
        Mon, 23 Dec 2019 01:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577063867;
        bh=LGwG4U7RecPSXOwRkJ1l7crn8QRccyP9X+XqHEgdQgM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SxxDQjSgssHgneJP40YKZsT+nmddqfG4oPb7r7TG5wkiOiIz8MlVF9E53okYON4XZ
         gFo5qe02Q5DBuZXqXhfMA8wPQinfqj5M+eSV6CTjhxN7Jeg453oVhs1zERPVDsC3N9
         /GWBepDL0MO44OToiktXummnwF8ONqx8dhIUp6Ok=
Message-ID: <2f6dbf1777ae4b9870c077b8a34c79bf8ed8a554.camel@kernel.org>
Subject: Re: [PATCH] locks: print unsigned ino in /proc/locks
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Sun, 22 Dec 2019 20:17:44 -0500
In-Reply-To: <20191222184528.32687-1-amir73il@gmail.com>
References: <20191222184528.32687-1-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2019-12-22 at 20:45 +0200, Amir Goldstein wrote:
> An ino is unsigned so export it as such in /proc/locks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Hi Jeff,
> 
> Ran into this while writing tests to verify i_ino == d_ino == st_ino on
> overlayfs. In some configurations (xino=on) overlayfs sets MSB on i_ino,
> so /proc/locks reports negative ino values.
> 
> BTW, the requirement for (i_ino == d_ino) came from nfsd v3 readdirplus.
> 
> Thanks,
> Amir.
> 
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 6970f55daf54..44b6da032842 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2853,7 +2853,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	}
>  	if (inode) {
>  		/* userspace relies on this representation of dev_t */
> -		seq_printf(f, "%d %02x:%02x:%ld ", fl_pid,
> +		seq_printf(f, "%d %02x:%02x:%lu ", fl_pid,
>  				MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino);
>  	} else {

My that is an old bug! I think that goes back to early v2.x days, if not
v1.x. I'll queue it up, and maybe we can get this in for v5.6.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

