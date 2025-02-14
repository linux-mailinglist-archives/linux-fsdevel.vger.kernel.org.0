Return-Path: <linux-fsdevel+bounces-41706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D9CA356D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 07:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE1216DC14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 06:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064F1FC0E8;
	Fri, 14 Feb 2025 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="COBuBEDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5F1DDA18;
	Fri, 14 Feb 2025 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513639; cv=none; b=f6sY1J+kbWpLWkJXFn7SFQT0ylwkTOv/Zp8HM0cL5PQ0zP8vxMW+p+VP1xDWH+QKQZOimU8/ZAcIJNbYpHJ5z08bTtwqU7C5GhiC6zJfSJjvi6lGchaVV5aov519PHr2YrMwnBP7vYmVWOgk19YfJrAFjLCVXiC1Lbty2CF5W1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513639; c=relaxed/simple;
	bh=jCtbVE5bBQgbr1KkBuaBLNbMVBT/IkDigEj9mDeifos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTUPe5E/vRKVBWMJ1EgHvtyB6LO8tPOcgulCUp8Wy+ZYiYN4tlL7WpUTSWatoOXaQg9t9CTIL6RuUUas1XZokZaGnDmpjuyrvk/bZvM8Zf09Ngdh9HUuLglaDpcA/cG3Z6X9tC+9nJnTJFbjYKp22/ehAup4IWCux6VeQdkLLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=COBuBEDf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XnVwZa3XU2LGnJmQRApZCaWlTj8lhBvtrT87rLs4oUM=; b=COBuBEDf3DJvH9dJcMo9hUYczg
	kDHiwfClBFshyaOxc9hX8kgz9ysvpvnJXFxB/jv+PQDaPwW0t+meqXEYGS+kTJFPIqMw24D5PIMnf
	i+1iUpOw/dUo8qx/4m0YwcaXWgrEqS3tyWJxpK8Kui+gcn6nFWtWbGOT+2Zxrmf45HdNQZukn1BaO
	c5qPGRPyqrICaDS5WTqlzHLDuZHIOhfSUIff3rtF6Klii/NotXfzZakmy+U/n0yVJxh4frQeYE94Q
	e0NowXHxui0W8L4OufoFOdRbWG3go8Ry46sHqxKwAsxSwn3nSTd3oGftcuRBgPT0Sq8GDRVd/2aFF
	0unJKJkQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tioxX-0000000DQVr-2IMS;
	Fri, 14 Feb 2025 06:13:55 +0000
Date: Fri, 14 Feb 2025 06:13:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3} Change ->mkdir() and vfs_mkdir() to return a dentry
Message-ID: <20250214061355.GC1977892@ZenIV>
References: <20250214052204.3105610-1-neilb@suse.de>
 <20250214060039.GB1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214060039.GB1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 14, 2025 at 06:00:39AM +0000, Al Viro wrote:

> 3) I'm pretty sure that NFS is *not* the only filesystem that returns
> unhashed negative in some success cases; will need to go over the instances
> to verify that, though.

Definitely so: in cifs_mkdir() we have
        if ((server->ops->posix_mkdir) && (tcon->posix_extensions)) {
                rc = server->ops->posix_mkdir(xid, inode, mode, tcon, full_path,
                                              cifs_sb);
                d_drop(direntry); /* for time being always refresh inode info */
                goto mkdir_out;
        }
There might be other cases.  hostfs is definitely like that, I'm pretty
sure that kernfs is as well...

