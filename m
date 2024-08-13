Return-Path: <linux-fsdevel+bounces-25812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F1950C10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 20:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247542856EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A911A38F0;
	Tue, 13 Aug 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aX9cV+zn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D61A3BAC;
	Tue, 13 Aug 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572967; cv=none; b=fn957E1SlDTrVdvkOjvXVvd/NI3dt9bXUAJNMbwd3yFKYI+qd3Nm1ll8PNp5HQS8fStSnFPdTyvg4sqnK0E9ApOnZwOE8PCYHFauGC7I0VBNjWnaKoqyQeges61tzxLMrh/zJAU1elwNKgZhcYX7p+w5a3rmUswnePuZ843UNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572967; c=relaxed/simple;
	bh=es5zoXWc+PBYCM7GxGFlQQytlOKiC5c8SlC+X+Siqnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQJ2Dqk0jnUYCVNk1A0FywJ7vm7CDDFnTpIGuDCogmaaaUNvWryrJcw0azLslDlo+DoU5WcN57WzqSJmvc4QPNsm1YzlgvQykwFwht9if1AAASKT4qB+3G08096FdryCxKoEeBUJsIxbnvGyqNee/Zc/RBxVkUiCdU808CDeZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aX9cV+zn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iro5IkUK+Vf0QKFwxvnxcDJqhH0H/Ks4BsAOeYqM0cs=; b=aX9cV+znU1uJssvgBmUL9B7q4k
	bQUoQG/sIRP+L2pW/vgVNJsInqJsSGWOAZvDv/kxZf7rhQ0aTok2VSTfUxHCODGTv0On441kFkWSV
	wmDKtF9NA6AleZzsE60k/F4O/DPTf6ESm6n2E5fM8MORL1J0wQQx6KbJnpkqydiS9eZI/QVASjKJu
	AAnWgkLJ3fp7y6tLtZ8XLwY1Zqe3b8nZpuQj9GaaOqnlCk0SmfHsFbZddwJTRPat/UyNkI3K0ECvm
	5BDUqg6q4q2UlLf0c7Rt1FsLFWBEtL6XZbPR5NQz/QzTwKqjBtL7trpMiCQFrusuJwogL8TzVFCrJ
	2bZht83A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sdw3s-00000001QOk-3HJU;
	Tue, 13 Aug 2024 18:16:00 +0000
Date: Tue, 13 Aug 2024 19:16:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [viro-vfs:work.fdtable 13/13] kernel/fork.c:3242 unshare_fd()
 warn: passing a valid pointer to 'PTR_ERR'
Message-ID: <20240813181600.GK13701@ZenIV>
References: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <020d5bd0-2fae-481f-bc82-88e71de1137c@stanley.mountain>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 13, 2024 at 11:00:04AM +0300, Dan Carpenter wrote:
> 3f4b0acefd818e Al Viro           2024-08-06  3240  		if (IS_ERR(*new_fdp)) {
> 3f4b0acefd818e Al Viro           2024-08-06  3241  			*new_fdp = NULL;
> 3f4b0acefd818e Al Viro           2024-08-06 @3242  			return PTR_ERR(new_fdp);
>                                                                                ^^^^^^^^^^^^^^^^
> 	err = PTR_ERR(*new_fdp);
> 	*new_fdp = NULL;
> 	return err;

Argh...  Obvious braino, but what it shows is that failures of that
thing are not covered by anything in e.g. LTP.  Or in-kernel
self-tests, for that matter...

