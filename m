Return-Path: <linux-fsdevel+bounces-57633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC639B2401E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6AED17DC32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465A82BE7D0;
	Wed, 13 Aug 2025 05:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iTDCL4fx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB022110E;
	Wed, 13 Aug 2025 05:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755062408; cv=none; b=tK8NlR7/Lvu9GEPrb0bx75QaB8FlYwA+ZOFwygQOavxQlVuMy+2kZhKwrD2Tax1wpMpUdXol4HKfZ7+TIyGAf9ZQkhXYlfOrc6ipVl6XlU7/Xzp8ICZ0RYYEWsbJ9utsjbTZNmFRsNENBYG3PMJ3J2h2bdLOhtP+NARJDKe2sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755062408; c=relaxed/simple;
	bh=pCg5tUn3Jxoz1Rz+ldIsZRcCH30DqmzroJThlBQBMOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDGndwLHcPb3Fzqrub4sQhBkdNgT4g1y2LP2JheSxUvgq2TeuzEgjMTYRA5ELSoN6kGRpSYSdbreghcEs34qA5eXVkcHhCDZoUE1Q0K2uCLpdrwKVV8UCzxoVb//Ht5YLCrgfQgEt06lNKwbg/464iP5eXsxXnHcOYV6eR8v/is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iTDCL4fx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KjOxKUPYOtNCnCd/lus2iP6rL3ZLot/rSauSdHj7XKM=; b=iTDCL4fxLjR1WN6UEkahPvC+Y2
	GNjJps5E4fZouWLRmdQbBwPPH1mCH8GZuT1VtFvidzQL9pFIjrGIy8ger7QFw7qUyB6DSxBFMCmOF
	LWPLns4WENW88IC5y4vnenhiTfcrGz8QaFmiqlZW4dgt3+6URBn25Y2dWP0fnObUcRYE8u8S8Js5y
	356r4/zM5bVk/SCK07iXGFW/ISD/v++GRjYnfAAg17BYdfFru3K+z/kofWvdZPtyUz04rBR64zWhV
	xRBFvJ9qCQ9oZR61+VgVm7T7iOng5g5A6eo9EhDBsPuoLLKcGhLWYsTuqHrwQk8XzDEDDy/1Shto+
	7gs0hgMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3u1-000000060h7-0Shj;
	Wed, 13 Aug 2025 05:19:57 +0000
Date: Wed, 13 Aug 2025 06:19:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] VFS: use d_alloc_parallel() in
 lookup_one_qstr_excl().
Message-ID: <20250813051957.GE222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-11-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-11-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:13PM +1000, NeilBrown wrote:

> + * If it is d_in_lookup() then these conditions can only be checked by the
> + * file system when carrying out the intent (create or rename).

I do not understand.  In which cases would that happen and what would happen
prior to that patch in the same cases?

