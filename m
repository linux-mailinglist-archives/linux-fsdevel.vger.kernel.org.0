Return-Path: <linux-fsdevel+bounces-29017-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 977C8973828
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA89283277
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64F818D637;
	Tue, 10 Sep 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="WcQtoJaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59C3C0C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973265; cv=none; b=tTOcYNXmZyt8vwGApKh4ZIA3gYzK/Zoft1eByGgDcOSQcndyWQkCw9JMn+CNXYO20CMXmBgIjzaXsGHDjiZ5UsETWx09YEeiMzBVgUjZ1ndsc49vgytpnB7yt5YqcIa5yOUxrhKQ1qrZovArq9Y+CXXnB1hrUdlk06N+uhSlq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973265; c=relaxed/simple;
	bh=ChgHbqv+IWCo9fLhW35s+qcMH8JdJX2jyK34cNLIEHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3+FOvlV8g2r5WOYNlhuz2bk6oAfNiqG+RVxykc3wxX+RjE0PrqPX9nkT8+rhjAVymko3262tKyn0XoFIa9yOQLf8sVCKNvjfikJPxNqLcEoNvyJjR8ySB6zYuyZmh7UdpZNlaay9kCghoanlW6bAlDDlTmzVrcxCZe6WyuXGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=WcQtoJaU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-76-111-137.bstnma.fios.verizon.net [173.76.111.137])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 48AD0hCq004162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 09:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1725973246; bh=sOdADL69ADLurAaxJtZqMfKLMrLeeaUIAyhfePmAyNw=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=WcQtoJaUlP4yjNlCSmz4V7iA3MjycLQ8T9Hcahsr80PF7A4smL2RajIzmoTzGRPCD
	 UBBRDBAJM6P+I13XgmiMoICTU3r9no7pgo3HYfhP+xNA3cVSDuN9exWKUsQwarV2cD
	 kGZKW8TitlYlTaiF3q25p6lVTkuTdO8+0PdaQu+dMgs6AnTb39ngygX0aBdBGxfcNs
	 cR5ZLQWmmrtCdJxlSPuXZn1UyYT2muSgD5d8zA9nv9X+ZPVUP/SwlKpaGYZbaT9na1
	 bNvRrP2g0yHuT81Vk6p/E2GO+WGWwUiTnnQhm0fKZqGWH4sOG03s0QMM/8FSn9l6+Z
	 xG4xiguc+Ottw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 909CD15C19A9; Tue, 10 Sep 2024 09:00:43 -0400 (EDT)
Date: Tue, 10 Sep 2024 09:00:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] uidgid: make sure we fit into one cacheline
Message-ID: <20240910130043.GA1545671@mit.edu>
References: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
 <aqoub7lr2zg6mlxmhe4xgulk2vteu6p2rsptqajxol2qawgtef@mz2xks2gkjul>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqoub7lr2zg6mlxmhe4xgulk2vteu6p2rsptqajxol2qawgtef@mz2xks2gkjul>

On Tue, Sep 10, 2024 at 12:48:16PM +0200, Mateusz Guzik wrote:
> May I suggest adding a compile-time assert on the size? While it may be
> growing it will be unavoidable at some point, it at least wont happen
> unintentionally.

That should be fine for this structure since everything is defined in
terms of types that should be fixed across architectures, and they
aren't using any types that might change depending on the kernel
config, but as a general matter, we should be a bit careful when
rearranging structrues to avoid holes and to keep things on the same
cache line.

I recently had a patch submission which was rearranging structure
order for an ext4 data structure, and what worked for the patch
submitter didn't work for me, because of differences between kernel
configs and/or architecture types.

So it's been on my todo list to do a sanity check of various ext4
structuers, but to do so checking a number of different architectures
and common production kernel configs (I don't really care if enabling
lockdep results in more holes, because performance is going to be
impacted way more for reasons other than cache lines :-).

Hmm, maybe fodder for a GSOC or intern project would be creating some
kind of automation to check for optimal structure layouts across
multiple configs/architectures?

	     	      	      	    	       - Ted

