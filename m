Return-Path: <linux-fsdevel+bounces-53995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C8AF9CCA
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 01:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1534565688
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F1D290D8F;
	Fri,  4 Jul 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqm3tahu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA826D4C6;
	Fri,  4 Jul 2025 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751672618; cv=none; b=k1VYg2S5XAlFjOJfOm3ntTqQ6XhHdf82lEOcfALVbwrlXvta4o2K8+LlZjgUFzzT3JVNum7RScEmB5fjicc3Xhfy16T3n0ic4vohYqeEWTPsqkNYOS9vdC+GFfSfbnuGfGjVjjuJg91IfEFLN3wGOg6r8OyCF6AuesRONIll1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751672618; c=relaxed/simple;
	bh=ynNo1Z4lyyh6Xq3Mw8cGMe5YNA9OWQ0njpEepLshJxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz1EdONeOY+cu0Ai7z23ANRBXiosW2fWnnplbehlXON9JhMe4qlJ6XTbUxQpqguxgKEC9ndAzVZTU4zRjcRTPRdTXdFhDkyvNPM8aF5oI6bCl8sJo/itlBCo38ay/QE7rgiJfOFdvixns8WtYu5TE8ezDtBgO2Jgi+XXsMyWafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gqm3tahu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C6HJ8IcGtBRiubKjaCXVhjsl7fuFELcIKXF72SPTkqQ=; b=gqm3tahumcaChgcx7QDFVmUJvJ
	KKMr79ur1vJTD9agV0AdSDOuzLZ/tbd3SQ4q+MS9MrbVaLAHYHzxVtU+DS/ZA/27EOs2enqJws+Wz
	qK13vj/V/hxtKeNv5bhnczcR+tSx6b0cx94RnLDbwgU6GvH45g0XTnrlgwxNhcFp0R94Uor9XyL59
	Obwza+stWXW+CGjpAcVe9NPjw2NMrph6c6kUws3bQ0NUfNe63YZ68NUsf//f4rJ+UIQKrr0ur5KJ9
	18qf6UbxmNFuHJdUgXycYM5RhLBLq2qbQ6BiQ7QWdT1lBkf/Ue2+x/b7RmqK0Om65bKPQJe8IycDV
	TSGbcB9w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXq3q-000000019v0-1vIH;
	Fri, 04 Jul 2025 23:43:18 +0000
Date: Sat, 5 Jul 2025 00:43:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Groves <John@groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 18/18] famfs_fuse: Add documentation
Message-ID: <aGhnFu8C9wVPiXBq@casper.infradead.org>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-19-john@groves.net>
 <aGcf4AhEZTJXbEg3@archie.me>
 <87ecuwk83h.fsf@trenco.lwn.net>
 <aGdQM-lcBo6T5Hog@archie.me>
 <aGgkVA81Zms8Xgel@casper.infradead.org>
 <aGhjv37uw3w4nZ2C@archie.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGhjv37uw3w4nZ2C@archie.me>

On Sat, Jul 05, 2025 at 06:29:03AM +0700, Bagas Sanjaya wrote:
> On Fri, Jul 04, 2025 at 07:58:28PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 04, 2025 at 10:53:23AM +0700, Bagas Sanjaya wrote:
> > > On Thu, Jul 03, 2025 at 08:22:58PM -0600, Jonathan Corbet wrote:
> > > > Bagas.  Stop.
> > > > 
> > > > John has written documentation, that is great.  Do not add needless
> > > > friction to this process.  Seriously.
> > > > 
> > > > Why do I have to keep telling you this?
> > > 
> > > Cause I'm more of perfectionist (detail-oriented)...
> > 
> > Reviews aren't about you.  They're about producing a better patch.
> > Do your reviews produce better patches or do they make the perfect the
> > enemy of the good?
> 
> I'm looking for any Sphinx warnings, but if there's none, I check for
> better wording or improving the docs output.

That's appreciated.  Really.  But what you should be looking for is
unclear or misleading wording.  Not "this should be 'may' instead of
'might'".  The review you give is often closer to nitpicking than
serious review.

