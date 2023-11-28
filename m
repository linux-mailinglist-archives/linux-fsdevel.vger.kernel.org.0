Return-Path: <linux-fsdevel+bounces-4005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2637FAED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 01:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65FB1C20BF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 00:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEFD654;
	Tue, 28 Nov 2023 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VRre4iyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA71B1;
	Mon, 27 Nov 2023 16:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=D1o97CKdXFovLzKvT8oyszIMw0H5zhvJSxo2FaxQ59Y=; b=VRre4iyfAm/+2o3bd7XA+BObv4
	kx339g/MxXcBntGNW54hq5taSiXRMj+EHQrWT7ZFWmIB4GoHbJh99by6bVT7rSPB+XPcd6aNPtGcO
	1a7ToneeNd6CxfalTUXal08Kna1HeV5XebG7kNdBcjSvFjjzK3BJZe/JIyYGQIJqTLalYfcq5Lw8I
	O4X8dC5M4P8/ZXINgiZoSKyAmsswOpK5YVWsFgDbYO7hD98Jwf0jUoC/JVPYbceqXAHe/C448oDlK
	B/y1QZWZU+Jij5k6jPerzDVd5S4BoRBndVRcnLQOKupiXaLo5I4mV9StTMWy3afje8MHjAydLicHv
	5GqN5m6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r7lYs-004CR7-0F;
	Tue, 28 Nov 2023 00:02:46 +0000
Date: Tue, 28 Nov 2023 00:02:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
Message-ID: <20231128000246.GM38156@ZenIV>
References: <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV>
 <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV>
 <20231123182426.GO38156@ZenIV>
 <20231123195327.GP38156@ZenIV>
 <87plzzgou0.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plzzgou0.fsf@>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 24, 2023 at 10:20:39AM -0500, Gabriel Krisman Bertazi wrote:

> I'm not sure why it changed.  I'm guessing that, since it doesn't make
> sense to set fscrypt_d_revalidate for every dentry in the
> !case-insensitive case, they just kept the same behavior for
> case-insensitive+fscrypt.  This is what I get from looking at the git
> history.
> 
> I will get a new series reverting to use ->s_d_op, folding the
> dentry_cmp behavior you mentioned, and based on what you merge in your
> branch.

FWIW, I suspect that we might want something along the lines of
d_set_always_valid(dentry)
{
	grab ->d_lock
	clear DCACHE_OP_REVALIDATE
	release ->d_lock
}

to make it possible to suppress ->d_revalidate() for this particular
dentry...

