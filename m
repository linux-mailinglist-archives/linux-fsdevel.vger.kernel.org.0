Return-Path: <linux-fsdevel+bounces-10043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF0284747A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398CA1F22D56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6D61474B1;
	Fri,  2 Feb 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="T81rWylA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071614690E;
	Fri,  2 Feb 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706890579; cv=none; b=RJ3Z9A9jAEvio2/OrdcH+bNG7s4KL/MNmrrtuAZ0POGAv4HlFWhi5Op9GDEtRymq4c6I+ysNivAHiIUWwum/etz9xcrExec10DPWovf9sEhDrslizOOstbXaYkpbGnZmoJspqzmEPDzeGcKvGy/V9n6GbX7SXA5I4jdYfaUydqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706890579; c=relaxed/simple;
	bh=mLMIc1SroO3yXxTLHAMRh3BU9a9MgpgQyVlRrfzkTkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNwCb3ApCPGuoy1O9lCcPt4nW7Esxvgzhice/T+QXl6GeaB4ahfW+Cc3KNbIFU0uVIFnX6+sqO+N9h+dBysrM+9+3KgeeGTGsToPuhAihb/h29rn6kK/MdCIN8tp0DaF/9/0JNfVF9kLnFpNvzxsTC1NEecWmqQAPMwpnr/NGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=T81rWylA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/PNpaXHWsvIDQvHDtXv0Q9pV47OOW+hLVA2RGVaIbqg=; b=T81rWylA7n6OVGsJk9u/H3ytWz
	UjhnoqjoiIvzEl1afLdqepRZLlnhtrtsR48raZmSA18YLtNnTDYExe+I/9acbn/IBQvcHo9QpVLd6
	anusvW599i76l7jHLcDJCd8ikxkCRuMIU8+jNcsSUmDA90MdHmkSRJBGAhKp7lgWTwuFg82901IYC
	9doUlLQXvYRB8cytenFrvZ+zOLUi6hoKgpuL7gD4Gz7j7wvlwfNCsCwXH7cvhwu2iEOKm47hrrt3J
	WTWrqW2IuQzm94aqidTlZ7E4ozNWtNk8pjMACH6dinL6EOEncTxmryikv/ugCmNU7dniMogfKyKus
	KHiSgJEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVwCv-0046Nj-1s;
	Fri, 02 Feb 2024 16:16:01 +0000
Date: Fri, 2 Feb 2024 16:16:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Message-ID: <20240202161601.GA976131@ZenIV>
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <20240202160509.GZ2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202160509.GZ2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 04:05:09PM +0000, Al Viro wrote:

> Use After Free.  Really.  And "untrusted" in the function name does not
> refer to "it might be pointing to unmapped page" - it's just "don't
> expect anything from the characters you might find there, including
> the presence of NUL".

Argh...  s/including/beyond the/ - sorry.  Messed up rewriting the
sentence.

"Untrusted" refers to the lack of whitespaces, control characters, '"',
etc.  What audit_log_untrustedstring(ab, string) expects is
	* string pointing to readable memory object
	* the object remaining unchanged through the call
	* NUL existing somewhere in that object.

All of those assertions can be violated once the object string
used to point to has been passed to kmem_cache_free().  Which is what
can very well happen to filename pointer in this case.

