Return-Path: <linux-fsdevel+bounces-32167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B8B9A1A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 06:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA3282E07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 04:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B474C08;
	Thu, 17 Oct 2024 04:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="o8mhPT2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70FF184D;
	Thu, 17 Oct 2024 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140757; cv=none; b=b2Ey7fCgAP+GT7U0T9HpiZk2H7RIuDea6phx1AIV/vcUbV7Cyi+/Qevgm5RD6cfolWy7sn3t047ehXbQOnTApSjtFG8oOhel4GwDGa7K/Ve82WhTtRlXdPhZoVUFGe+M779BQztiVix2O/mxgKeXnEdKfUVBuyxvR4Ki5qhUHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140757; c=relaxed/simple;
	bh=oZKN1OJ9039wREb4uyWNgSHnLH6qQGkRmyAB3as3wTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5pdD1hy+DAwNvddKy034FH9fCziqIdShtxzcaQfyakWIX9XlgRRrwFoehw/RK4l6zim3Qk/VZb03z0DpJIIfHw1SkLVJuRV3HRs0jaEPrhYzDcMeFCWGEWcPLmPH0PFteKJnZF0KEwSNzLdiwgY28teIBUVB/vuVlq6LgB9Vlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=o8mhPT2s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wCXDrd9dZ5kU0FE76T/mgwdNLbKstDYbCAWNeX867Bw=; b=o8mhPT2sK24XHtgx4O/MV6mCFz
	SAQ99i+Fn+yx6E59aEvz9BRqp8YUQQsPutF6KoV6A57URee7Ir0K0zxxVXThx01xkzGEC5wVAqrgb
	uWsSu3usYDLHNK4Jr6sxS+Rcd1gI+oVnM4PSx7GNZnVoIfQDrws7tpjYy+8pchqzxn8ZJZvyu5jsh
	kk2j/vzaWabUgP+tE6x/opD+7HjgJh1PFAQ/WPAc/xQErbTLJhhH8zNOdhcbUrHR5ZeItNRug8suq
	HU5MItEubWcZjFNRqgoAByLk/pxrIW+HMqxTk4QnG2ovVp+zWk1zLrMp1zFuPQhN3vDvsKDvAXZJj
	3V2/+eRA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1IUx-00000004ZdZ-1zLQ;
	Thu, 17 Oct 2024 04:52:31 +0000
Date: Thu, 17 Oct 2024 05:52:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Store overlay real upper file in ovl_file
Message-ID: <20241017045231.GJ4017910@ZenIV>
References: <20241007141925.327055-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007141925.327055-1-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 04:19:20PM +0200, Amir Goldstein wrote:
> Hi all,
> 
> This is v3 of the code to avoid temporary backing file opens in
> overlayfs, taking into account Al's and Miklos' comments on v2 [1].
> 
> If no further comments, this is going for overlayfs-next.

BTW, looking through the vicinity of that stuff:

int ovl_cleanup(struct ovl_fs *ofs, struct inode *wdir, struct dentry *wdentry)
{
        int err;

        dget(wdentry);
        if (d_is_dir(wdentry))
                err = ovl_do_rmdir(ofs, wdir, wdentry);
        else
                err = ovl_do_unlink(ofs, wdir, wdentry);
        dput(wdentry);

        if (err) {
                pr_err("cleanup of '%pd2' failed (%i)\n",
                       wdentry, err);
        }

        return err;
}

What the hell are those dget()/dput() doing there?  Not to mention an
access after dput(), both vfs_rmdir() and vfs_unlink() expect the
reference to dentry argument to be held by the caller and leave it
for the caller to dispose of.  What am I missing here?

