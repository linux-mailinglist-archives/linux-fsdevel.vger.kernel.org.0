Return-Path: <linux-fsdevel+bounces-2633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75277E7320
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BF21C20B90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3538237143;
	Thu,  9 Nov 2023 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mkFaZ1pK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8F358B2
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 20:52:32 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89A4695
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RdxLbbxKK4U7thKHxnTFf6WFE5hea1YUTyeTvL6yl6U=; b=mkFaZ1pKRMHk18t2kwhsbsyQhb
	9uKSdlnirSvf1YcSps+uPvSo1A0y7vcTEjC7fuF5qbA1zmxoFEFVvFigiD8cWGrAfWiAcPY9g4gjW
	SeQhyVWFFNsS2cZV/ftyNL4HA0JF7UEdYiys+TC82KjiHxAkjGuVuKYYzWJusCbbE7TUeh0V0GvfU
	ZcOmH/cv6T+LMwfIyNuN8pbIoqMr6XphfArIVJDKRl3IOOC7VKM5yNvZI15zmd+2s/SzAn2h7j4TI
	mX+WQJxyrwa3EifE+0iRkvocDfsdhIcknhGSrc+qtDfDCUgzefurxaEEb+NLL0BW+dfkAmYhcoi8o
	VwbCMcmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1C0q-00DaBW-2r;
	Thu, 09 Nov 2023 20:52:29 +0000
Date: Thu, 9 Nov 2023 20:52:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/22] fast_dput(): new rules for refcount
Message-ID: <20231109205228.GF1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-10-viro@zeniv.linux.org.uk>
 <20231109-aufwiegen-triest-8a95b1a96b40@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-aufwiegen-triest-8a95b1a96b40@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 03:54:34PM +0100, Christian Brauner wrote:
> On Thu, Nov 09, 2023 at 06:20:44AM +0000, Al Viro wrote:
> > Currently the "need caller to do more work" path in fast_dput()
> > has refcount decremented, then, with ->d_lock held and
> > refcount verified to have reached 0 fast_dput() forcibly resets
> > the refcount to 1.
> > 
> > Move that resetting refcount to 1 into the callers; later in
> > the series it will be massaged out of existence.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> 
> Ok, this is safe to do because of
> 
> [PATCH 09/22] fast_dput(): handle underflows gracefully
> https://lore.kernel.org/linux-fsdevel/20231109062056.3181775-9-viro@zeniv.linux.org.uk
> 
> as return false from fast_dput() now always means refcount is zero.

Not sure how to put it in commit message cleanly.  Perhaps something
like the following variant?

By now there is only one place in entire fast_dput() where we return
false; that happens after refcount had been decremented and found
(while holding ->d_lock) to be zero.  In that case, just prior to
returning false to caller, fast_dput() forcibly changes the refcount
from 0 to 1.

Lift that resetting refcount to 1 into the callers; later in
the series it will be massaged out of existence.

