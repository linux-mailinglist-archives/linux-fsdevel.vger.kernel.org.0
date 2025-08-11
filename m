Return-Path: <linux-fsdevel+bounces-57412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC94FB213EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC662A632C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DCD2D6E78;
	Mon, 11 Aug 2025 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jP1EzFrR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44D2D6E69
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754935964; cv=none; b=DPdyP3U3v4SKGi2zHRNs22TK5EZuJTC77QFeefH56Y5W8OPS4KWu22IzxaZAD+VCnOJ1GqwYsUOqCtrPaN67g01lsunE1fI7VikC1JbGVRg2UTqGRhsxE7Mv1FGiQIHHTskBsX5dReQeYfIVMvjAsWIdCuc7YR62PmVs7DsfAjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754935964; c=relaxed/simple;
	bh=T1TbY2V3duINVsRmkHpfxRcOte3eOWw8A/E06eTbPow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wc8v7OtYlQG0Dt9svgon0tTHZPNLICSQouC0DfHsbcVnULqRx0uKiEury0kjO5+YtiVkgy5RyGl8rsSiuX9S2jKisP7YvGec9XEBWp/l+CPsf4EGlaNWUyVnH7BXUE9YTAC+aTy3t9W79n/mOogvgolYNqkewxQW2AARdx/gIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jP1EzFrR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754935961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=81uqlJiu3KKJ+tPXBfJ9HETxELLjgevjOQyrFQtsQWA=;
	b=jP1EzFrRoQyUP0/TkVN47yPU8F2RZGvR/gWLxrTtzCpEb1NrQ5620CGbNMI7Es34CiXQsf
	ltx7vSK4XqoA3gmD/TsTe5x++5wPWiwR2rQphZVicyXLPtKZBYK8fupAi3z55GcT58S9VF
	Iy3gUH3LxOPMSN0OskY/PbwrkmAAGno=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-woHW4xABMliIju8VudRIJg-1; Mon, 11 Aug 2025 14:12:39 -0400
X-MC-Unique: woHW4xABMliIju8VudRIJg-1
X-Mimecast-MFC-AGG-ID: woHW4xABMliIju8VudRIJg_1754935958
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b604541741so2431450f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 11:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754935958; x=1755540758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81uqlJiu3KKJ+tPXBfJ9HETxELLjgevjOQyrFQtsQWA=;
        b=KLw9AxTpKmT/2+4TyyXoYRbzfDaKmCSGVUhuowal9NkNnGfT+VS3xVD/VoB1YO8Vwe
         suSC7SHoejiTr7I123xC9xUwVVFvgc8Vf/zBD8ddDRtYDBjWteFVPiD7aRgyvHlrF6bu
         lzHWZjY5eLj1qu5JEUoGs2p2eoxpklTFoUEnDG/aMAgpriOvo9Lwq/RNUdrcz57KBlGb
         52IlVa3v1CCt6TkvuX0dmdTH438UMttvNpudDU+o6xyDvSkVDfRgX+XYOz9Nk+lrDlaZ
         LYvKol8QsoHujLNYQAezQULjJ1iG5tcU78RmAJBXCsw2WAfv5cELP0ItuFx0hzxw5FwG
         Xgsw==
X-Forwarded-Encrypted: i=1; AJvYcCV8xF8woiVkjsYSN6mp/J/1fxnDQK4GGWEcxpumsiHXoPMpnjH1ovqCc4gMbVG9mLAqs0SwYddMzHFqwdKF@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQle4XLQa10HDlZ/gwQLjXocNu+clEXsorWUNlHSrlhhkWvpB
	9rVPpCjvU9/qDbkqN6UipUl6SWfZNcU79XU3HQgBU+iM4Y1FcutSchysIejW2BGI+2JtrCgvdcH
	DEHDG/EWDyhDpmWOBFp/MjEtsUBVifNswHykN9LiH43IeYskjeGimWqXroIvCRbvHeNKqtTrSzw
	==
X-Gm-Gg: ASbGncukL0Yp5BtY9mO4HV1r8DTFzBJ3Yg9JyMBO++O+JamSzQdWpLkdX5/U9u9uF4h
	0OTZh9ReWV9aa0SaZUIxzGRQTesEg9qQA4mxhUHvFbAgEhS5FqOrl7UDa2Of3HqMHOeVeY3mx9s
	qC02GM5Vz/ci/QjW3SKmaltVDVge6N7NHOfvaDlXhwTy3os5QQkesns+IxpDvkiY/pCO68lKcNT
	m2QKvVDocpt8Yv4MNVqy0qiA3e8Ey9crL3MzhQpCZIGAB6QvP9GJh+Z3onLnjrO+FnVXS5uK5yJ
	z3cYGhCbng/IcAGx1X6GjrrYxe2ZouQ1LTtNJi0q6RW5Vdf5NQppbqb0CF4=
X-Received: by 2002:a05:6000:4387:b0:3a4:f72a:b18a with SMTP id ffacd0b85a97d-3b900b52958mr12107088f8f.26.1754935957776;
        Mon, 11 Aug 2025 11:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMlgmyhItfKunlp7MS1hsmVXPdcoGXFCSQWd0jOrnBuISzKtEDYAL3EkLU5AqA2dr0zaPDQg==
X-Received: by 2002:a05:6000:4387:b0:3a4:f72a:b18a with SMTP id ffacd0b85a97d-3b900b52958mr12107060f8f.26.1754935957372;
        Mon, 11 Aug 2025 11:12:37 -0700 (PDT)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed0ecsm183736025e9.4.2025.08.11.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:12:37 -0700 (PDT)
Date: Mon, 11 Aug 2025 20:12:36 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <4lvrb3s5nrch3bas53ig72d5aqlc3tnvtfbnrvgvattxsftdrk@utdtay3kavej>
References: <20250808-xattrat-syscall-v1-0-6a09c4f37f10@kernel.org>
 <20250808-xattrat-syscall-v1-1-6a09c4f37f10@kernel.org>
 <20250811175107.gxarqqcsftz5b6m4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811175107.gxarqqcsftz5b6m4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On 2025-08-12 01:51:07, Zorro Lang wrote:
> On Fri, Aug 08, 2025 at 09:31:56PM +0200, Andrey Albershteyn wrote:
> > This programs uses newly introduced file_getattr and file_setattr
> > syscalls. This program is partially a test of invalid options. This will
> > be used further in the test.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  .gitignore            |   1 +
> >  configure.ac          |   1 +
> >  include/builddefs.in  |   1 +
> >  m4/package_libcdev.m4 |  16 +++
> >  src/Makefile          |   5 +
> >  src/file_attr.c       | 277 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 301 insertions(+)
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 4fd817243dca..1a578eab1ea0 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -210,6 +210,7 @@ tags
> >  /src/fiemap-fault
> >  /src/min_dio_alignment
> >  /src/dio-writeback-race
> > +/src/file_attr
> 
> I'm wondering if xfsprogs/xfs_io would like to have this command :)

it has chattr/lsattr, but this one also generates quite a few
invalid arguments for these syscalls, I don't think it would be
useful in xfs_io

-- 
- Andrey


