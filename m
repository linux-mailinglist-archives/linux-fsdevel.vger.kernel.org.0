Return-Path: <linux-fsdevel+bounces-62114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CB6B8459F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3478E4A83BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6C3064A8;
	Thu, 18 Sep 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f81hF/a4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3530216D
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194860; cv=none; b=NV7ipyG18C2Ip8FmoWB+RVnQBpGLfsr085ywutSDxgUQevQ00+Q/+QBpFJ2KGPlqy8W8Hkm4VTZjufqk8EVkqguDLtzeinLXQXnvJ6ZqlVo6olmECgvcT4ksTVcPfJmG7m2+NtxEzuDJ6uTLNLm5AZ+1JeB6MBlNpS6wzLxstJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194860; c=relaxed/simple;
	bh=wjS64QDMlqkfgw27qhtCy4/2laqAX4mv8HYIWp4czpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi8q0hrdmrnInFYSm/hqgV3pj8UiZQcF4sib2U0/HiP+ixm55V4qPssB9cybqqs2kKzEtNiMwxGZ9xZKj4x209B8HyhquXWcvgOaV1mXBXXDx6QC9+ARxwc2bknOyaXCzDlj1oginEmijS2u0p3Anh0Y5UC74jd9ANZm6GRVxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f81hF/a4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758194857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoawklc8os3fAwaoE2OiqJO7AK5pZxPz65KbJfbQGfU=;
	b=f81hF/a4TzTyLAEPHzoJb5dN7WZa7L9Pin8gJAVroCOai3vJGfXV16gZAPX5Y6rla5yHbH
	4/pneoEhAp1LrDQWOhqRODOuTwrg6KL/wAcikjd7clzS315StMeZTMo9lNJ18cIzLcWS6I
	+iaXC0eVCqv9ip72FWJIqXcgjn2aJ4c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-IYQ1ZjJDPiKMpVs4mku6-w-1; Thu,
 18 Sep 2025 07:27:31 -0400
X-MC-Unique: IYQ1ZjJDPiKMpVs4mku6-w-1
X-Mimecast-MFC-AGG-ID: IYQ1ZjJDPiKMpVs4mku6-w_1758194850
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBE0519560A0;
	Thu, 18 Sep 2025 11:27:29 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.134])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF4C11800447;
	Thu, 18 Sep 2025 11:27:28 +0000 (UTC)
Date: Thu, 18 Sep 2025 07:31:33 -0400
From: Brian Foster <bfoster@redhat.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@infradead.org, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
Message-ID: <aMvtlfIRvb9dzABh@bfoster>
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
 <aMqzoK1BAq0ed-pB@bfoster>
 <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Sep 17, 2025 at 02:54:09PM -0700, Joanne Koong wrote:
> On Wed, Sep 17, 2025 at 6:08 AM Brian Foster <bfoster@redhat.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 05:40:01PM -0700, Joanne Koong wrote:
> > > Most callers of iomap_iter_advance() do not need the remaining length
> > > returned. Get rid of the extra iomap_length() call that
> > > iomap_iter_advance() does. If the caller wants the remaining length,
> > > they can make the call to iomap_length().
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > ---
> >
> > Indeed this does clean up some of the calls that create a local var
> > purely to work around the interface. OTOH, the reason I made the advance
> > update the length was so it was clear the remaining length would be used
> > correctly in those looping callers. Otherwise I'm not sure it's clear
> > the bytes/length value needs to be updated and that felt like an easy
> > mistake to make to me.
> >
> > I don't really have a strong preference so I'll defer to whatever the
> > majority opinion is. I wonder though if something else worth considering
> > is to rename the current helper to __iomap_iter_advance() (or whatever)
> > and make your updated variant of iomap_iter_advance() into a wrapper of
> > it.
> 
> That idea sounds good to me too, though I wonder for the naming of it
> if iomap_iter_advance() should remain the current helper and
> __iomap_iter_advance() should be for this more-minimal version of it.
> From what I've seen elsewhere, it seems like the __ prefix is used for
> minimum behavior and then the non-__ version of it is for that
> behavior + extra stuff.
> 

IME the __iomap_iter_advance() would be the most low level and flexible
version, whereas the wrappers simplify things. There's also the point
that the wrapper seems the more common case, so maybe that makes things
cleaner if that one is used more often.

But TBH I'm not sure there is strong precedent. I'm content if we can
retain the current variant for the callers that take advantage of it.
Another idea is you could rename the current function to
iomap_iter_advance_and_update_length_for_loopy_callers() and see what
alternative suggestions come up. ;)

Brian

> 
> Thanks,
> Joanne
> >
> > Brian
> 


