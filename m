Return-Path: <linux-fsdevel+bounces-42606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB735A44C33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 21:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771371882A11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 20:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEA920F06C;
	Tue, 25 Feb 2025 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddoCZNES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629020DD79;
	Tue, 25 Feb 2025 20:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514505; cv=none; b=CLGoa++YXpBYWToArJocHA1J/zAUSjhXA3L2AbsP4UFSpDDUJdTsPrN1SFBFyruU/xt6czgOBSIUXBMDAbxfKdnWnXBRgSaHwzDG65TArEJHTyOjPmp/A9xhJfvetO82ez68MCH5xs8axzXjLz6fuSMIQc/9P4RdGyB+WS40Iio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514505; c=relaxed/simple;
	bh=t1uT4c11OKQHExsOFtxoy3LJNTAHabS0KKwVGjPQ2l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsgiPmMzF5dhwczFFghmCISsUlOICQYdiK5MbilCjrzy3NhYiexWMGJ75qYMsYalsLjzK/jNpPYAlCif6E56Cf+muWg/Ea3/LGJ+ryBAWWrftyRJqmH2BgKCOKO1z3FzxVdHTo/FNIGP+p8cOyR82r1fLAaWrupGwFINbtbc6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddoCZNES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A18C4CEDD;
	Tue, 25 Feb 2025 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514504;
	bh=t1uT4c11OKQHExsOFtxoy3LJNTAHabS0KKwVGjPQ2l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddoCZNESuEUvBOAtni+HZxp4W5FK3XS8F0PjQh39mIXTURa1oi/RHcN2hxx6jHxmn
	 ++Je50twMeNXzGpxcHjwtsvx+7W+U5umqX6rkYgzEr6Tjs/g0Yx+wVmtBfWc85+ryg
	 QDvGPPCPFNG8b01Rbyz0LAcDE6cFjlhziScDyabCEX5ZKj07m+f1SWYjjvdtiAxHjz
	 vxZvHV1rz42L/frhzXkVMu76ugbpaCQria+BNVOZc0SJc6qgg+hX3QJIZUWbFPuJJt
	 mgChLbN/xk9p14XQMPlq/MX+YV55VL6lfioSdgIIhTVQRD+E0pkfqNshGfXBpA7P7Z
	 9tx4AwJL/2V+Q==
Received: by pali.im (Postfix)
	id A439C89B; Tue, 25 Feb 2025 21:14:51 +0100 (CET)
Date: Tue, 25 Feb 2025 21:14:51 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
	Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <20250225201451.onfuwgkd2umloat7@pali>
References: <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali>
 <Z7UQHL5odYOBqAvo@dread.disaster.area>
 <20250218230643.fuc546ntkq3nnnom@pali>
 <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
 <20250221163443.GA2128534@mit.edu>
 <CAOQ4uxjwQJiKAqyjEmKUnq-VihyeSsxyEy2F+J38NXwrAXurFQ@mail.gmail.com>
 <Z71YEf5zO-AjXZwo@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z71YEf5zO-AjXZwo@dread.disaster.area>
User-Agent: NeoMutt/20180716

On Tuesday 25 February 2025 16:41:37 Dave Chinner wrote:
> Your call - windows attribute support via a small amount of work for
> an existing API addition, or a huge amount of work across the entire
> filesystem ecosystem for a whole new API. The end functionality will
> be identical, but one path is a whole lot less work for everyone
> than the other....
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

So, would you rather see a change which defines all windows attributes
in fsx_xflags field, without any mask fields, and if there is no space
in fsx_xflags field anymore, define new fsx_xflags2 field?

I can prepare new RFC with this approach, and we can compare and discuss
what is better.

Just to note, that NFS4 protocol for supported subset of windows
attribute has for each attribute 3 state value: unsupported, unset, set.
So for knfsd it would be beneficial from filesystem driver to provide
information if particular attribute is supported or not (and not only if
attribute is set or unset). It does not have to be via this interface.
But my approach with mask field can easily provide this information.

