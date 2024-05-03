Return-Path: <linux-fsdevel+bounces-18579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 958FA8BA96B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 11:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520322840F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCFF14F10C;
	Fri,  3 May 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsN6O2NE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659114D446;
	Fri,  3 May 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727102; cv=none; b=aW4emG3/nMaGy2wCwMaBBo8tCBOHQF1sGGe1YiET8DRVDFOXDX/Ylg7Ik7HVJtB5TQjKiKxcfx7KphEB4WWqNmL8mkBPe11Eujq+FBHrfMlrh4ceQQMfeED9tIjHl4ylElF4gU0xIlM6p0zgFPB0TEF999jsMbLvKKQKZ6I2pFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727102; c=relaxed/simple;
	bh=Yhfx72szmxjk3nRHHahO9prNTl117V1dBvHVvqppLdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts+vLWvy262kODn/F9FZZwj7c+gCqErP81VZttdoldrylFlMUgy8YdJ8nFP+FM9ujnTjKwnrBOa3vbzqkMTEo/og2cHG5K2YILg9qAkWu48XbjsMXshDXBIvvWTE53subYXyYCuIM2RcTvpsohRnsB5UqszyJwSTHBhd7oNzM00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsN6O2NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E436C116B1;
	Fri,  3 May 2024 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714727102;
	bh=Yhfx72szmxjk3nRHHahO9prNTl117V1dBvHVvqppLdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsN6O2NENSQOWWV7FXtIg4s46Jx8XD1Ew6pknLjbqtW23AkGek33sqcCKormBng0V
	 WonrFgqwyeCWs1FMb4ApFs+A451LF9NfgOw1JpGx7AYBOxq2aQ33SjN7um44Ee0dN2
	 5NZR+kCaPDAek/0MqcVzK65EgT95nGKD1HmQA1lpipHGQY7M6Xfn5rTfjeiiH14YOo
	 dqUSGy6M39Y7W7SOLojziCTfTEHrWKa3cpKrWqV1+lqHaEM1h+0JaVsmlVW+D8YabY
	 fgvIQYaHMY7FGl2Vgfru3iDIWuRx06sJSZTcbSiNegqDbWVj+tIJQy5ElzzuROLnoN
	 aDyTg9ZMNLbwQ==
Date: Fri, 3 May 2024 11:04:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	nvdimm@lists.linux.dev, John Groves <jgroves@micron.com>, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com, Randy Dunlap <rdunlap@infradead.org>, 
	Jerome Glisse <jglisse@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Eishan Mirakhur <emirakhur@micron.com>, 
	Ravi Shankar <venkataravis@micron.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Chandan Babu R <chandanbabu@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Steve French <stfrench@microsoft.com>, Nathan Lynch <nathanl@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Julien Panis <jpanis@baylibre.com>, Stanislav Fomichev <sdf@google.com>, 
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 07/12] famfs prep: Add fs/super.c:kill_char_super()
Message-ID: <20240503-vorstadt-zehren-caf579725c2a@brauner>
References: <cover.1714409084.git.john@groves.net>
 <a702d42c922737c4f8278617db69ce2b6d813c5f.1714409084.git.john@groves.net>
 <20240502181716.GG2118490@ZenIV>
 <eiobix2ovov5gywodc4bqyhhv7mshe7bvbp2ekewrvpdlnz5gh@6ryuna2lfpt7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <eiobix2ovov5gywodc4bqyhhv7mshe7bvbp2ekewrvpdlnz5gh@6ryuna2lfpt7>

On Thu, May 02, 2024 at 05:25:33PM -0500, John Groves wrote:
> On 24/05/02 07:17PM, Al Viro wrote:
> > On Mon, Apr 29, 2024 at 12:04:23PM -0500, John Groves wrote:
> > > Famfs needs a slightly different kill_super variant than already existed.
> > > Putting it local to famfs would require exporting d_genocide(); this
> > > seemed a bit cleaner.
> > 
> > What's wrong with kill_litter_super()?
> 
> I struggled with that, I don't have my head fully around the superblock
> handling code.

Fyi, see my other mail where I point out what's wrong and one way to fix it.

