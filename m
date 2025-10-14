Return-Path: <linux-fsdevel+bounces-64144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E92BDA97F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 18:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A66D3B18F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC83009C4;
	Tue, 14 Oct 2025 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXuZJAub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C42FA0C6
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760458668; cv=none; b=OLgWgvQP/zLXNlRf8LJ0DsnfgkPM/bYkqN6E7ihV7R3f61sJ1bSJj7/NWL2mXb9f9SWu2qvdCrkb5C+9klCKo2l2ClMUNdDaWSDqhVy3k9vgeq5Q53LbF69q6wPMto8ZzHpKNDPv3SSZBjBXfyQbOfDWyecrpJC0df2w6KmSgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760458668; c=relaxed/simple;
	bh=sXYeV6SJvnYFewQXtnz8bcuu33UPWzv6xA4EwlwAh/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIbLZSpU2nfT/w4vIT+xcGM7jCTtoR8O5goQTnEtrIpAPHRyCjoHP4Udcamu1srA/+ashWdiMl+cfHyugcHChktpkEada1dKGYytcO0nytj9+3zsZSLqvIt14M9QAT3Z32C5PGmMbGESBm2t5+cAohxlB+2QJSLUipavpsorFrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXuZJAub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760458666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o9khWbtiHfpLUnJNco9dO+izGUV0ZZpx22djFvdPesc=;
	b=JXuZJAub8GdFurfhm9tYlUrEi6MXoKbYiRSbDxzTEmzAkbEgPhhZmVw0UpFPF2Y+EReCUZ
	CoDEwiQ9TMHFG8rXqUmupmdvDVGaHGzHUNcFWGFRs/9uunMp10gBwh4St/46SIqbSmUaIc
	lUChNK0VybNuRMhpTdlPlGcDe5Z9FiE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-td5a2psvMYeZyIlTF0Xn0A-1; Tue,
 14 Oct 2025 12:17:42 -0400
X-MC-Unique: td5a2psvMYeZyIlTF0Xn0A-1
X-Mimecast-MFC-AGG-ID: td5a2psvMYeZyIlTF0Xn0A_1760458660
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 666CA1800447;
	Tue, 14 Oct 2025 16:17:40 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.119])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 010B21954107;
	Tue, 14 Oct 2025 16:17:38 +0000 (UTC)
Date: Tue, 14 Oct 2025 12:21:48 -0400
From: Brian Foster <bfoster@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Message-ID: <aO54nHhk_R1rs6X8@bfoster>
References: <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <aO06hoYuvDGiCBc7@bfoster>
 <CAJfpegs0eeBNstSc-bj3HYjzvH6T-G+sVra7Ln+U1sXCGYC5-Q@mail.gmail.com>
 <aO1Klyk0OWx_UFpz@bfoster>
 <CAJfpeguoN5m4QVnwHPfyoq7=_BMRkWTBWZmY8iy7jMgF_h3uhA@mail.gmail.com>
 <aO5XvcuhEpw6BmiV@bfoster>
 <CAJfpegvkJQ2eW4dpkKApyGSwuXDw8s3+Z1iPH+uBO-AuGpfReQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvkJQ2eW4dpkKApyGSwuXDw8s3+Z1iPH+uBO-AuGpfReQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Oct 14, 2025 at 06:10:45PM +0200, Miklos Szeredi wrote:
> On Tue, 14 Oct 2025 at 15:57, Brian Foster <bfoster@redhat.com> wrote:
> 
> > But TBH, if the writeback thing or something similarly simple works for
> > resolving the immediate bug, I wouldnt worry too much about it
> > until/unless there are userspace fs' explicitly looking for that sort of
> > behavior. Just my .02.
> 
> Agreed.
> 
> I just feel it unfortunate that this is default in libfuse and so many
> filesystems will have auto_inval_data enabled which don't even need
> it, and some mixed read-write workloads suffering badly as a
> consequence.
> 

Maybe it didnt really need to be on by default? I don't recall caring
much about that (but again, long time ago) as long as the fs that wants
it can enable it.

Brian

> Thanks,
> Miklos
> 


