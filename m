Return-Path: <linux-fsdevel+bounces-64824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FECBF4ED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085C7501194
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7084227E07A;
	Tue, 21 Oct 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DB6GdZnb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7920E279792;
	Tue, 21 Oct 2025 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030988; cv=none; b=X4d38TMsD2EOwfLYTx9cclgwfxEqW7SBJg00UBNsq11o4BCf0Nbu4DcYIR8e8qgANZ5Z/VSqjLtzIh6gGmF6P4wu4GI4zcuXTnqnBR8G0ksm60ZUK+CELxFyT2/g+Lmr79zG98e4LVPzQK1OMKQLIATIPTudhTCmaBOizIUt1U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030988; c=relaxed/simple;
	bh=IuZy3bORYmWM3ATciEuz7ss8Rod/eltFRSKz+TLyRDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DL3VqOZOraZkyIRpnGAXi90pv6ksHN2u00z9yQqdIAoMN32r1HaiID7iy0qImXnU7BcalhaFrigd55Y8FMPCcKM63yvFea/UaP9ukoxgHoDzpLZotNdKvOwLExCuNPPIKMzteTSLzQAe7C9eRGv36z6DTOjhaIHZeTk6+yzLCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DB6GdZnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0037C4CEF1;
	Tue, 21 Oct 2025 07:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761030987;
	bh=IuZy3bORYmWM3ATciEuz7ss8Rod/eltFRSKz+TLyRDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DB6GdZnbFbPZH7ONQh9UuBnxV4yyVPct2UBrbOx+acy6LJD3IJJ4TqeBWOFuTnxob
	 yQcTMlx/xjhair43mI2kcAlGLlKR8ps3Y7a+miuwU084wFYaZ7cl83CGA5idAHpn4z
	 C7ARslXbVSJo2wbFcP/tFMYJ6I8A0Sh0OKg8AlhA=
Date: Tue, 21 Oct 2025 09:16:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mahmoud Adam <mngyadam@amazon.de>
Cc: stable@vger.kernel.org, nagy@khwaternagy.com,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.1 0/8] Backporting CVE-2025-38073 fix patch
Message-ID: <2025102128-agent-handheld-30a6@gregkh>
References: <20251021070353.96705-2-mngyadam@amazon.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021070353.96705-2-mngyadam@amazon.de>

On Tue, Oct 21, 2025 at 09:03:35AM +0200, Mahmoud Adam wrote:
> This series aims to fix the CVE-2025-38073 for 6.1 LTS.

That's not going to work until there is a fix in the 6.6.y tree first.
You all know this quite well :(

Please work on that tree first, and then move to older ones.

thanks,

greg k-h

