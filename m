Return-Path: <linux-fsdevel+bounces-9644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B47BC843FE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 14:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C6C1C2211C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2A7B3E2;
	Wed, 31 Jan 2024 13:01:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7243F7A716;
	Wed, 31 Jan 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706103; cv=none; b=YZfXwGHDsrE4tJ54pXP7ExG01MsbGijNPp6b1iIYmMUnXiZyhLt+jz3qpOakjvjA6uNKUi2j/A/pHpCJS2fe/1iYgFOKkWbgahAaH9kfvJuNBS8fHseJad36PRLVH8IY9huGb/4a0XxjxbTWXHf1V7le5VJ7Ep55XepsbzzT3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706103; c=relaxed/simple;
	bh=A2HkjWs/uqyXRaWNFEgz3xTTLEQ3Q1Ks7F/RFXEiUUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFU+SNOdM2bb0tbVTZmRKuJSA/oDF1HF1C8DvouYYPFBi6/P7SjHehnLbraN59OIez8Q6PhPNhWS8L4S1yxsRu9qOvNPePZSCbbzMRqyWCNKLRbZrIHIVUYXraShw5epX6KowaMa4UtuJuQgZCZr7STdzLrX5T+hAcFauqjXyz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEAFC68BEB; Wed, 31 Jan 2024 14:01:33 +0100 (CET)
Date: Wed, 31 Jan 2024 14:01:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/19] writeback: simplify writeback iteration
Message-ID: <20240131130133.GA25391@lst.de>
References: <20240125085758.2393327-1-hch@lst.de> <20240125085758.2393327-20-hch@lst.de> <20240130104605.2i6mmdncuhwwwfin@quack3> <20240130141601.GA31330@lst.de> <20240130215016.npofgza5nmoxuw6m@quack3> <20240131071437.GA17336@lst.de> <ZbpCEagJOh61eH6M@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbpCEagJOh61eH6M@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 07:50:25AM -0500, Brian Foster wrote:
> The implied field initialization via !folio feels a little wonky to me
> just because it's not clear from the client code that both fields must
> be initialized. Even though the interface is simpler, I wonder if it's
> still worth having a dumb/macro type init function that at least does
> the batch and error field initialization.
> 
> Or on second thought maybe having writeback_iter() reset *error as well
> on folio == NULL might be a little cleaner without changing the
> interface....

I like that second idea.  An initialization helper I could live with,
but if only folio needs a defined state, that seems superflous.

