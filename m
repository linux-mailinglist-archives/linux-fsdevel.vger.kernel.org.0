Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBE5294676
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 04:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405845AbgJUCVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 22:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439900AbgJUCVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 22:21:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D25C0613CE;
        Tue, 20 Oct 2020 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qMhC7eSdOuZjAVyPwc2U8Ot0KVpklRJ/N2V0T6Ore0Q=; b=i5DkVknCAxGcv+ozAKP2bavo3f
        W1vm+AdoVB1oxCrymV47Wv3xmx4wFF8DRIkFbqGhtwcJalCdCeAz0MAj+kj3rTk0Hm46nAPNh2mHC
        3oPgpFLDuXau5Tl/0UOB5pQZ55M8o4OgbtdhfHKDKVqNc0y21TJmL6nnHCaoUpLsBMBnSKscv001y
        1t0wxxGeA0aJ+pAdngPOPRk4wGcsBcPMEhpYmDxmRYaQMhdGjBAxyTvq8itOEh5Cx/19aSmt53JZ3
        vh4V81qQPTbiuoqsGXe7Oc5iqgs2NE5VLnMTI/byyHV78bojUoA+2uReBlLBnEUrR8LdPz8yK4zdF
        /zr33wIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kV3kc-0006c2-5h; Wed, 21 Oct 2020 02:21:18 +0000
Date:   Wed, 21 Oct 2020 03:21:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Subject: Re: Linux-cifs readdir behaviour when dir modified
Message-ID: <20201021022118.GH20115@casper.infradead.org>
References: <CANT5p=pwCHvNbQSqQpH3rdp39ESCXMfxnh9wWrqMaSk9xkdq1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANT5p=pwCHvNbQSqQpH3rdp39ESCXMfxnh9wWrqMaSk9xkdq1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 20, 2020 at 11:14:11AM +0530, Shyam Prasad N wrote:
> A summary of the issue:
> With alpine linux containers (which uses the musl implementation of
> libc), the "rm -Rf" command could fail depending upon the dir size.
> The Linux cifs client filesystem behaviour is compared against ext4
> behaviour.
[...]
> Now the question is whether cifs.ko is doing anything wrong?
> @Steve French pointed me to this readdir documentation:
> https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir_r.html
> 
> If a file is removed from or added to the directory after the most
> recent call to opendir() or rewinddir(), whether a subsequent call to
> readdir() returns an entry for that file is unspecified.
> 
> So I guess the documents don't specify the behaviour in this case.

Or rather, your implementation of 'rm' is relying on unspecified
behaviour.  If it's doing rm -rf, it can keep calling readdir() [1]
but before it tries to unlink() the directory, it should rewinddir()
and see if it can find any more entries.  It shouldn't rely on the kernel
to fix this up.  ie:

	DIR *dirp = opendir(n);
	bool first = true;

	for (;;) {
		struct dirent *de = readdir(dirp);

		if (!de) {
			if first)
				break;
			rewinddir(dirp);
			continue;
		}
		first = false;
		unlink(de.d_name);
	}
	unlink(n);

... only with error checking and so on.

[1] Use readdir() rather than readdir_r() -- see the glibc 2.24+
documentation for details.
