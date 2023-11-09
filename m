Return-Path: <linux-fsdevel+bounces-2624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A19207E71AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D672B20DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A81DDD3;
	Thu,  9 Nov 2023 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TBrVTxqw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B828D27E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 18:47:38 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8903C0E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 10:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hQ7XMK1WH4VIHYXquQGrVAIAB/lHCpXCHmQYQu+YNg0=; b=TBrVTxqwPFH9Z+rgKjsXvU4Bq7
	dE6pC9T/dpYAkBib0deNqUcsIocpk0DiE1Ych6YyDsYetO+ReeQ5KUPeUYMTXhVIuHwGfrjUEchbB
	4ii6ImCkzH8kOcUzQk7cAWP5kbutHxHWjR1Ns0izl6MfVSoeHIhYAr6YcbOSIJc8GNbUrox7v1CBW
	4ZyZhhAdebZvbdN9PQlzHn/2KVEVhMQ/Qv1o4fk7I3DO84jQB10NZAM8VJ5HG1uikPTBtttNI/ZNh
	3wyE8BT1VNEuF64ynjbPEvJpPhQfMTrlRcxtuY8tMjWygk87AAQvaVFKBfnZsQLKE7MAw0o4wBalr
	7g11LetQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1A3x-00DY8l-1B;
	Thu, 09 Nov 2023 18:47:33 +0000
Date: Thu, 9 Nov 2023 18:47:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 02/22] switch nfsd_client_rmdir() to use of
 simple_recursive_removal()
Message-ID: <20231109184733.GB1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-2-viro@zeniv.linux.org.uk>
 <ZUzmL0ybLk1pMwY2@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUzmL0ybLk1pMwY2@tissot.1015granger.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 09:01:19AM -0500, Chuck Lever wrote:
> On Thu, Nov 09, 2023 at 06:20:36AM +0000, Al Viro wrote:
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> Future me is going to be mightily confused by the lack of a patch
> description. I went back to the series cover letter and found some
> text that would be nice to include here:

Does the following work for you?

switch nfsd_client_rmdir() to use of simple_recursive_removal()

nfsd_client_rmdir() open-codes a subset of simple_recursive_removal().
Conversion to calling simple_recursive_removal() allows to clean things
up quite a bit.

While we are at it, nfsdfs_create_files() doesn't need to mess with "pick    
the reference to struct nfsdfs_client from the already created parent" -
the caller already knows it (that's where the parent got it from,
after all), so we might as well just pass it as an explicit argument.
So __get_nfsdfs_client() is only needed in get_nfsdfs_client() and
can be folded in there.

Incidentally, the locking in get_nfsdfs_client() is too heavy - we don't 
need ->i_rwsem for that, ->i_lock serves just fine.

