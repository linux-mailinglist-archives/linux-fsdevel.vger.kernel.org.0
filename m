Return-Path: <linux-fsdevel+bounces-1473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FB47DA534
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 07:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD7E2827FB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Oct 2023 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A73138C;
	Sat, 28 Oct 2023 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QL8DEWLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133764F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Oct 2023 05:25:45 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E1124
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 22:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cZBUs7anM+nSRmNNo+CijPqwwzEFbbGwbxY9Dbd4HE4=; b=QL8DEWLWxTzXvSwunyMm/dJ8OM
	PeO0widR+Ar3IZi9940mmWFNUuyhbrytGcj0nc1Yf4Ff6CIHWL3IYKqadnBbe7QTic+XUEFsjRi5q
	wGV/lnjZw2SNKyIa0zBEUsTlIVmXIyLgJGXFRFxpieGSsEERS81foJQk7wCBXj4JNrRaE5ho8nCsK
	beaHTKIUGFRRhDpRb6qLe0XX4OEj925bkTlBYDmkY6zekxeegVw2d4Si81N5mAKVfHYkDLPIZwSRr
	gqRRAb1b9/vSsm3PBk3rhf/rGjAofQV2uFTN1S6qObfj9cdZ7Fpgy729qKFwEu7736my4lzJSXP8N
	KICwo4SA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwbpO-006tcR-27;
	Sat, 28 Oct 2023 05:25:42 +0000
Date: Sat, 28 Oct 2023 06:25:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm,
	miklos@szeredi.hu, dsingh@ddn.com,
	Horst Birthelmer <hbirthelmer@ddn.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v10 5/8] fuse: Revalidate positive entries in
 fuse_atomic_open
Message-ID: <20231028052542.GU800259@ZenIV>
References: <20231023183035.11035-1-bschubert@ddn.com>
 <20231023183035.11035-6-bschubert@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023183035.11035-6-bschubert@ddn.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 23, 2023 at 08:30:32PM +0200, Bernd Schubert wrote:

> +		if (!switched && !d_in_lookup(entry)) {
> +			d_drop(entry);
> +			new = d_alloc_parallel(entry->d_parent, &entry->d_name,
> +					       wq);
> +			if (IS_ERR(new))
> +				return new;
> +
> +			if (unlikely(!d_in_lookup(new))) {
> +				dput(new);
> +				new = ERR_PTR(-EIO);
> +				return new;

Again, huh?  You call d_drop().  Then another thread tries to look
the same thing up and gets there while d_alloc_parallel() is
allocating a new dentry.  d_alloc_parallel() sees that dentry
is already in hash (if lookup has managed to complete) or
in in-lookup hash (if lookup is in progress).  In the former
case it returns the dentry it had found (and frees the one
it intended to put in); in the latter it waits for lookup to
complete and checks if dentry is hashed, has the same name and
the same parent.  If it is, same as if we'd found it hashed
in the first place - we return an additional reference to it.

It's perfectly valid and I really don't understand what are you
trying to achieve here.

