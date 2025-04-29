Return-Path: <linux-fsdevel+bounces-47597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F349DAA0BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 14:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579CA3A3D23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52262C374D;
	Tue, 29 Apr 2025 12:28:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7A029DB74;
	Tue, 29 Apr 2025 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745929701; cv=none; b=sBUbxlxwzyzfaw3glFYLAJBYbd5x0GSAyeYejU4btChn1QfL7TZO2R/j3ncf7I4C2gKdbjKisgj2/8l4ERiczMWKzCBnuzryiLHDSaDnHXtKGcTpfNC2fQjpEn1EaqXVQdg5524x2X6LQGtc5e7NjyIhSBF3lKqwBL57lMioGE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745929701; c=relaxed/simple;
	bh=1CAfX43axeyXhHAA2pWyW1DzJI+aoNNB9mI8PIkd6lY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7OiJLg52kne6QthL9zMWcwRIP218WZNwJH1WSEc2gXMLRLyhpn0YxKYPQLKgqmP/jrvMEwsjAu01pjZBpI4U2T4/IvgfmUyXVSRcpmzf4ezVq+MsTKVuh4sVEUL25rVN7JxzDUb8C/uR2Fgn6UlA7PLMIqwUtdM4W2KUP72bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D4A3E68AA6; Tue, 29 Apr 2025 14:28:13 +0200 (CEST)
Date: Tue, 29 Apr 2025 14:28:13 +0200
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
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
Subject: Re: [PATCH 04/17] block: remove the q argument from blk_rq_map_kern
Message-ID: <20250429122813.GA12807@lst.de>
References: <20250422142628.1553523-1-hch@lst.de> <20250422142628.1553523-5-hch@lst.de> <76ba8f63-b5d3-4e43-beb4-97dae085c5f2@suse.de> <df1fa243-a824-4607-8393-90dedecbe772@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1fa243-a824-4607-8393-90dedecbe772@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 29, 2025 at 11:24:55AM +0000, Johannes Thumshirn wrote:
> > Good cleanup. I always wondered why we need to have it.
> 
> Because we used to call 'bio_add_pc_page()' in e.g. bio_map_kern()' 
> which took a request_queue. But that got changed in 6aeb4f8364806 
> ("block: remove bio_add_pc_page") to a simple 'bio_add_page()'.

Even back then you could have easily derived it from the struct
request, through.

