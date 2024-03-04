Return-Path: <linux-fsdevel+bounces-13560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3628870FF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 23:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9551D1F23199
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F137BAED;
	Mon,  4 Mar 2024 22:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gO//cuMW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C73478B5E;
	Mon,  4 Mar 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590611; cv=none; b=BOgbWTpi923spSQku40Mkwlq0kLj84QC2unjIhw5coH0/RWTGXDw5IBoQlycxlLelQtZAYLtHk2lF/vUtzB2ppqfH8URqXn+6XOLdlTEIux2trpQxFWMDwLEjZYAc1vHZl16MiAn4HqdHF/osqRLztH2HadM+846cz6sB/FJ/1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590611; c=relaxed/simple;
	bh=oMSW/l9lKinrJpplamNpwDg1l6Mk3deCCLXQTPl4Ew8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il0Pq+WPske0hP0MXnqWofhd7AFSgGtyxpL+D8ryzoohW8Abm8soLoN5zhP7DaXsT5+K7xm+EKicNZNodUP19Koag1nZJCn1ncO2Gb8e2aQzRV3qaHPsh1LozMdEW6j5IcxrMLIH5kxSPh8YAMb0vatlG5mvneSDe86sLe/Uk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gO//cuMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C956C433C7;
	Mon,  4 Mar 2024 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709590610;
	bh=oMSW/l9lKinrJpplamNpwDg1l6Mk3deCCLXQTPl4Ew8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gO//cuMWvYrQDHWFKIz6ScWuPTxyaJMFL/e9iiHrsWfSyTgfmlagTGS08AN/ddNgJ
	 0X5/udRKi0nY7KKQos4k4Udc4VJLeFNscvXTHkWZaCqCSWq1nbj4y63IPRmKDp5pq2
	 RumO4j13a3ItcPFEUNAcx7SggcO9xRNXE6jMoM8rSu6aDEUEUdpLY2LJzw74JteThe
	 so0bK4avvz0DoVQQ4E8BbBECxh3ia2UTz1Z+Pnl78cQG8CKqwKutmzZtpQ7fOFf1ff
	 oRoIXYFVan0Mt7HLYc7meTHjayf03NL9hBGQkA/Vq9l+IaljmkonxBHlusdY0sFvw7
	 0B7AWi1Bni51w==
Date: Mon, 4 Mar 2024 14:16:48 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/4] xattr: Use dedicated slab buckets for setxattr()
Message-ID: <20240304221648.GA17145@sol.localdomain>
References: <20240304184252.work.496-kees@kernel.org>
 <20240304184933.3672759-3-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304184933.3672759-3-keescook@chromium.org>

On Mon, Mar 04, 2024 at 10:49:31AM -0800, Kees Cook wrote:
> xattr: Use dedicated slab buckets for setxattr()

This patch actually changes listxattr(), not setxattr().

getxattr(), setxattr(), and listxattr() all allocate a user controlled size.
Perhaps you meant to change all three?  What is special about listxattr() (or
setxattr() if you actually meant to change that one)?

- Eric

