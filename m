Return-Path: <linux-fsdevel+bounces-8389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D50835B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 07:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF092877CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 06:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F344DDB6;
	Mon, 22 Jan 2024 06:50:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F053A9;
	Mon, 22 Jan 2024 06:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705906244; cv=none; b=n9kLHz3n3JPQWiXZV3NAE33dKbCYTYMJSrnPfSkYxM1yFOEZ2KRtuhjVV45XOxkproLjqPCuaHq1O36QPMAziAGS+2wXFRBVKHE+0vBFfvPPtYHY51vMZMKuRMwbw1C43D0RjoXNqZ/c74AXldBbu/ORUFHngwzu/rlkUPIKY0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705906244; c=relaxed/simple;
	bh=+KgTSv8/H3nE+NV5+kusCmTjj/zSWk/12velqnvMg5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wfa8KxF6cCHY2eS8r0YndhrCl8nPmp0g+sFhK74NH1ADwNSpVn8kZUr6G1LAzJsxPC1vIoEXDoBsAVDfS1jMOc6Ks27UyW/gM3ZBhmXr20B4Bwwc1+OEYWSj+Y0Zk8F2mfrbAHjlzYysJHr+zo5U50Y3aJ4VwE3jePE+ezojEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5F80668B05; Mon, 22 Jan 2024 07:50:38 +0100 (CET)
Date: Mon, 22 Jan 2024 07:50:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, bfoster@redhat.com,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: fix incorrect usage of REQ_OP_FLUSH
Message-ID: <20240122065038.GA24601@lst.de>
References: <20240111073655.2095423-1-hch@lst.de> <ueeqal442uw77vrmonr5crix5jehetzg266725shaqi2oim6h7@4q4tlcm2y6k7> <20240122063007.GA23991@lst.de> <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eyyg26ls45xqdyjrvowm7hfusfr7ezr3pjve6ojikg4znys6dx@rd2ugzmo44r4>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 22, 2024 at 01:37:45AM -0500, Kent Overstreet wrote:
> > Without this patch as in current mainline you will get -EOPNOTSUPP
> > because sending REQ_OP_FLUSH and finally check for that to catch bugs
> > like the one fixed with this patch.
> 
> Then why did the user report -EOPNOTSUPP with the patch, which went away
> when reverted?

I have no idea, as we never return -EOPNOTSUPP for
REQ_OP_WRITE | REQ_PREFLUSH this would be odd.  According to your
report the users runs a Fedora kernel and this commit never went
upstream or even into linux-next, which doesn't quite add a up to me
either.

But in the end just try it yourself.  On current mainline with the buggy
REQ_OP_FLUSH you should be seeing -EOPNOTSUPP every single time you
try a data integrity operation, without it you should not.  Even the most
basic test should be catching this.

