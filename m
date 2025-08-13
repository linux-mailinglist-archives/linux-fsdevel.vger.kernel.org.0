Return-Path: <linux-fsdevel+bounces-57621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC596B23EF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A791684120
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 03:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9152C2BCF43;
	Wed, 13 Aug 2025 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fAFNgc1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D71C860B;
	Wed, 13 Aug 2025 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055354; cv=none; b=eT+6lbq8K5dj4JLIWcWxiHY97U90Ut6dj9x75+JwN6caLPvkurXSZy9mDYdG1hXpmaOh1ZyqPt++VnTNTklIYc8f8mbOnDB+TY5UH8eZM3mMRtddI3vKE9nY3FHLJBqk258tkvuQhAu6mSnAVJvz6tZKMdXUfj8Z1E4X2o2CsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055354; c=relaxed/simple;
	bh=zxMEJ8m+zRkwij8kWIT31y8xRPVRlMmpgTq7ZqEzhG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk3av9VmFKu0F520qnq1rUSMmdws56OasBnfWVlO/5YgO+LT8/Edu5prLC50em76LFXS0u6piQsQaHay0XuMiZlD8o16UFx0DvY9KnB0oS+3Ivrybb0m7juN8V3f8jR23MLo1dZCSqkiUHzIm2tV1thuNJKMnbXGcSCDMnlah3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fAFNgc1a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mZv6+PvJUXtJWPttoq47kMgqdSRNoX5QOTrEIOYs1uE=; b=fAFNgc1auSoV8mA7b6YMBtX+j5
	rl8bDV/EeCqND0al4fPbDzIAEpPYcyF7qkiUImV7O4z6/z4uY4kXywRzc1pGW1crAJalXzhJBGEzd
	S6obRySg4KfM6Rlmcyo74FXF9pwKE1B0Uz9zgiAO73PqvC5pg/VHWinHUWiWDIDBgZElXJt0aq0XM
	tvIU6HFgTuPeaU4k8wfdhReTrAd/x6tskDlpsFNzLn1+69HtZ8V07NJFErG7xVWEdqrKPndQ4zIOJ
	yLXsMqeqHWjN1NAVE5WT0ZDeTc2PqoTipg/C9vNxL5JZKL1GnCqx5nKXIadgYfbGnlkr7P1ZiQwmV
	l/wZ3+4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um24B-00000004v1A-2JpQ;
	Wed, 13 Aug 2025 03:22:19 +0000
Date: Wed, 13 Aug 2025 04:22:19 +0100
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
Subject: Re: [PATCH 01/11] VFS: discard err2 in filename_create()
Message-ID: <20250813032219.GX222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-2-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-2-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:04PM +1000, NeilBrown wrote:
> During the time when "err2" holds a value, "error" does not hold any
> meaningful value.  So there is no need for two different err variables.
> This patch discards "err2" and uses "error' throughout.

I'd probably replace the first sentence with something like this:

Since 204a575e91f3 "VFS: add common error checks to lookup_one_qstr_excl()"
filename_create() does not need to stash the error value from mnt_want_write()
into a separate variable - the logics that used to clobber 'error' after the
call of mnt_want_write() has migrated into lookup_one_qstr_excl().

