Return-Path: <linux-fsdevel+bounces-35165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FDD9D1CF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 02:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC34283234
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633C4778E;
	Tue, 19 Nov 2024 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J2N/Q53E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232A2E822;
	Tue, 19 Nov 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978577; cv=none; b=q98thjTLy63qfvro1UtAEWzy1unGf7TnizoI6QOvmW+p6O/yTkFFbzrU4jP+fTqsynCWsctpkHnaxjv/gsq2/E4L8ujTgZTRYMoiX8MuZnZ/svPBcAk1f175yptWsCoV/2jzET5MyCFO5MtUeRE3aTrsogDlJFpZSH/6Kv+vDG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978577; c=relaxed/simple;
	bh=LrsF3ZsHuO880knHws8A3cbD2EXMox9VjyA2EeLrLU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4iamJmVHq9sIiNuHmbZsXvVcGCiUCtT+Sf3/5Bi5yedJOdVqqCxZ4DTXcMpjMyzp6HqITifJ6nexkdhD2Cws4BohwTlQn7KUToWlVkrJLbVtSg4REXj75y+SQh7kOUAwbrft/C95Yv6RKPJYpGtaomF2K9qtH23ofpmwKKkKfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J2N/Q53E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB73C4CECF;
	Tue, 19 Nov 2024 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731978577;
	bh=LrsF3ZsHuO880knHws8A3cbD2EXMox9VjyA2EeLrLU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2N/Q53EV+oOVQenVjGBYjgwjml6I8VO8Ri4wRUhgNQQtr2jh/SbCEkE2yLYgvT34
	 vpLiICp5uU1fvF863XHXQgsMb1ly7hH4evjmsdo7T/qqIcAD/P+PTsPCPel1ia0UNp
	 3HdaHH7g7bJgAAbtu6LjxTL+9KzX/+bnOULkA8eY=
Date: Tue, 19 Nov 2024 02:09:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
	corbet@lwn.net, derek.kiernan@amd.com, dragan.cvetic@amd.com,
	arnd@arndb.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
	shakeel.butt@linux.dev, muchun.song@linux.dev,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
	oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
	gthelen@google.com
Subject: Re: [RFCv1 0/6] Page Detective
Message-ID: <2024111938-anointer-kooky-d4f9@gregkh>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com>
 <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>

On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> Additionally, using crash/drgn is not feasible for us at this time, it
> requires keeping external tools on our hosts, also it requires
> approval and a security review for each script before deployment in
> our fleet.

So it's ok to add a totally insecure kernel feature to your fleet
instead?  You might want to reconsider that policy decision :)

good luck!

greg k-h

