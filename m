Return-Path: <linux-fsdevel+bounces-27572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F37962726
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8723F28517E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110B176259;
	Wed, 28 Aug 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+f2hIIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FFD16BE11
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848500; cv=none; b=q/kLb9P5r/ZMyNj6Jf/4fapncumUMUcUx8I1qdpJV8ZNmQ+eofN1ssRMxT8gEvifIuQZH9Z6qVrLM3Jdg9hGdybO5yxVDGF6+AFVTAp94EjOe5giU2chMHhzTE71cU/l5LnoQxCOr8c5PuutyZ13/yWqGdPEVCuPd6UwGf2B/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848500; c=relaxed/simple;
	bh=KqgDH1ZnHQ/z69qaNmvd4e9mQU4Q722O1wXDs8Wawwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCfFjOeeYhXgw2+ejiD2T297jqwaO+58Ko5TlveIFW2I4rJxcF1HpuLNt9jTsvMi2RndRkPp+E9h8BSQxu0+TaHYlVOkWbDBwulyVuOdamzSHVXgWaEOjxn7s/He/uCOG5GNjEJqbHWmIUPkMq6FsuaHT889Bs5MVRFWG+V6Www=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+f2hIIh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724848497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EAigvyxuhqeoYg4Y0eYmizGDEVtW+d60BU6GHWqWla4=;
	b=O+f2hIIhlD7gb/Ef3RDGp6QKaOJm+20XhHrvQ0NgNE26fDhwNw28mNEJOTgDGXg+/GYjAA
	znecf+amzTkk3wM/94FwBkuRlYY8ApSs5OyUMWuzSeRHlyNfIQSM4+EpO8phgIS5kiS/Fm
	57/rV2WoLhwheA/sD46xYzlk0tsyGlI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-VTkI9Sh1NoScDTFyoE5nUg-1; Wed,
 28 Aug 2024 08:34:53 -0400
X-MC-Unique: VTkI9Sh1NoScDTFyoE5nUg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 790BE1955D4A;
	Wed, 28 Aug 2024 12:34:49 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.95])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBE1119560A3;
	Wed, 28 Aug 2024 12:34:47 +0000 (UTC)
Date: Wed, 28 Aug 2024 08:35:47 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <Zs8Zo3V1G3NAQEnK@bfoster>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
 <Zs6oY91eFfaFVrMw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs6oY91eFfaFVrMw@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Aug 27, 2024 at 09:32:35PM -0700, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 10:23:10AM -0400, Brian Foster wrote:
> > Yeah, I agree with that. That was one of the minor appeals (to me) of the
> > prototype I posted a while back that customizes iomap_truncate_page() to
> > do unconditional zeroing instead of being an almost pointless wrapper
> > for iomap_zero_range().
> 
> I only very vaguely remember that, you don't happen to have a pointer
> to that?
> 
> 

Yeah, it was buried in a separate review around potentially killing off
iomap_truncate_page():

https://lore.kernel.org/linux-fsdevel/ZlxUpYvb9dlOHFR3@bfoster/

The idea is pretty simple.. use the same kind of check this patch does
for doing a flush, but instead open code and isolate it to
iomap_truncate_page() so we can just default to doing the buffered write
instead.

Note that I don't think this replaces the need for patch 1, but it might
arguably make further optimization of the flush kind of pointless
because I'm not sure zero range would ever be called from somewhere that
doesn't flush already.

The tradeoffs I can think of are this might introduce some false
positives where an EOF folio might be dirty but a sub-folio size block
backing EOF might be clean, and again that callers like truncate and
write extension would need to both truncate the eof page and zero the
broader post-eof range. Neither of those seem all that significant to
me, but just my .02.

Brian


