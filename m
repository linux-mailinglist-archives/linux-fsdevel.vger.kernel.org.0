Return-Path: <linux-fsdevel+bounces-47598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF4CAA0BBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0969116C4C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC12C2ACE;
	Tue, 29 Apr 2025 12:31:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA11B86EF;
	Tue, 29 Apr 2025 12:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929898; cv=none; b=Lpj6WV0y8oPuQoGGh5EMLqe2L6CrMBLTejyMv7My9XnztpdmAvhpKyjt8hvEWpLgST4w3IdLqNsbvPq7xvOd2Kv5oli3hrkIDoUusWqJxe9BiaYKvp3rzZaRPSRwIdeefK9VuN6h00kqrHCWZktifZvfaK5r8iQ0712bW7f59RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929898; c=relaxed/simple;
	bh=NCsbwKXyyfYV4qTDFg8sloKEXBMtv45aPB6AJTXz1aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJhuE69bZGVYCSqawvRUhrekcPpDGtLUjiKocIoirImDJpzhvgFJ+XvvsN8LUx0mcFg6+5bQVO/cz4rw7c3ibrD0P23kiqqZGu4/MpqliPrmrhGZ5vZ4Wf1wXLKwJ1JkqTo4hz9KG8+pF1OlQjFnWQ5y4CHKOMKzO709oJ4sodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21BD168B05; Tue, 29 Apr 2025 14:31:31 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:31:30 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>, Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 16/17] zonefs: use bdev_rw_virt in zonefs_read_super
Message-ID: <20250429123130.GB12807@lst.de>
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-17-hch@lst.de> <1116a2c2-9f33-4a2a-8d59-6b1d0a644949@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116a2c2-9f33-4a2a-8d59-6b1d0a644949@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 29, 2025 at 11:44:37AM +0000, Johannes Thumshirn wrote:
> On 22.04.25 16:31, Christoph Hellwig wrote:
> > +	super = kmalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!super)
> 
> [...]
> 
> > +	ret = bdev_rw_virt(sb->s_bdev, 0, super, PAGE_SIZE, REQ_OP_READ);
> 
> Can we change these two PAGE_SIZE into ZONEFS_SUPER_SIZE which is 
> semantically more correct?

I'd like to keep this change mechanical, even if I'm in violent agreement
about using the right constants.


