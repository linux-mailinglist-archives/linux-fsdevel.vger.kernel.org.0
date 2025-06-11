Return-Path: <linux-fsdevel+bounces-51355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0E3AD5EAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F413F7A81A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F87B278774;
	Wed, 11 Jun 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CqqXV77N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05861D5CDD
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749668249; cv=none; b=hnNngjXAd90qcSR1EF2dFtVeoqBSGejBIVEFGb0evg+h3JSLC5Hi41sjWGNisAHTiHCQMZYRq3Mu/EHz6ePbIeiERXamoZEvb2kNHiSmuIv35VjYMX96o9EHNPzwcAhfRyZMdv8r5HypoEDE5bWD7vYP+0D3n3+EHmLdqfxGA4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749668249; c=relaxed/simple;
	bh=V+7AKa6FyLjb68uNNu+8sDkh3LsLbmL2kbRMyEaa4PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGmzshGZac3AdASfXmZ6B0BRq89YkzH+5+dsQtfWP9BuWdaWSSbPTsPZvzFvji7wiahvHRxbXn2HwmbBckUMgKcb0ZHLmhcAHkSFbontjc/8y/E+BuBhmbXVZYzU24ru9J2YsFfUJef7K6oevbUGWAClQ9iyUf29YcMBeYN/2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CqqXV77N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0jon10ihRrAz9X8phGqkkZ5jZ6YAa5eolZeDSdBxkBI=; b=CqqXV77NXE39Sjogy47DkJGgtR
	urzYy5XTmkN/jtZALd8daiZBoWL4quxcfbZJSLFhOeWZ2GPokkGRURDtWGfscVUDrYk6E1a8xoUei
	TgyWbjN9URf/s17Bs7RRC5JPbJGlpgn/UvQVjhTryjmmCs1v/hxk2eJvZdMQZjsccDtjvUM0ykVby
	DL2q1FTbyeaZaRHq0wNFCZNAct3CSwBCdx2qB7LVnAxJt5/+VVNZmpWoW1GlGkD9cMm+n8UpOhige
	9zTLrMGr6jOlgCbo+IyO9mZxqnOpMSiP2O3VTHpJtWnyibuCqUb5KQ/3xUOzFrWiiJhXKNXv1cvfY
	mU4VKMyw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPQdZ-00000005Ch1-16wV;
	Wed, 11 Jun 2025 18:57:25 +0000
Date: Wed, 11 Jun 2025 19:57:25 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: constify file ptr in backing_file accessor
 helpers
Message-ID: <20250611185725.GQ299672@ZenIV>
References: <20250607115304.2521155-1-amir73il@gmail.com>
 <20250607115304.2521155-2-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607115304.2521155-2-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jun 07, 2025 at 01:53:03PM +0200, Amir Goldstein wrote:

> -struct path *backing_file_user_path(struct file *f)
> +struct path *backing_file_user_path(const struct file *f)
>  {
>  	return &backing_file(f)->user_path;
>  }
>  EXPORT_SYMBOL_GPL(backing_file_user_path);

const struct path *, hopefully?  With separate backing_file_set_user_path()
you shouldn't need to modify that struct path via that functions...

