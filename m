Return-Path: <linux-fsdevel+bounces-22242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B0915033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 16:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D88280F6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F419AD72;
	Mon, 24 Jun 2024 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDsF0QIy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D619AD5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240130; cv=none; b=glCcBgrCzBrXQIyOwHU8M7GmP5LN2bWYNUgj5jy+eYk0YTBtVtOpmjVF1tuw4LDHFjtkhT7RjekpaLgZbiBRAkMi+DvsrR1XRc++4W0jdmha6uKfd1E/ABnPbjPGhyBsUkFGMP050Q+LjHvjiI1De1Fms94sCcJbqy6pShkl0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240130; c=relaxed/simple;
	bh=/fNP9lHtI2TK5RrwMbpkvfnkfdvJsuINBBNwCdflfCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2jJxiJ2ArkWTRBkjmh7PChA/B0lz6vDbgTZkK/9N3o1ZF7IHeWYrlmTEkxCdBUn/QJMYH0jx6kNErQy4cFsl0puk7GzXISOYRDLqBDgbU8e8BKAxjOsizfQcDg95AePZhD6CuqvK8ynUHfEyk8irMPIDvn2A1+CNiGJmMb2GXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDsF0QIy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719240127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YSFwvfLTs34coaqSsJLjio1esrhhUEBzaPezL3zICw=;
	b=KDsF0QIyEYjg0kAWdcdBGgt7vjmCIwWCkFwzqPRv3Vv+VRbWP7kmBc2mhwwWN0249x2Sm+
	ph9h3qHExKzylvudaKvVO5LW2wQkAYvlXgXIfAI+LY+SKItoCftLvonpruH6jGQa/ackrV
	8ZdVJavqoneV1tNLQjKsPUcbd6jeAK0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gVFIH9phM-i8kN37dUgmbQ-1; Mon, 24 Jun 2024 10:42:04 -0400
X-MC-Unique: gVFIH9phM-i8kN37dUgmbQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b52c538d04so7192096d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 07:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719240124; x=1719844924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YSFwvfLTs34coaqSsJLjio1esrhhUEBzaPezL3zICw=;
        b=Zv2hlUEBBbetYONfL/CVDSFaBO5f6ZlTKFwOYN9rtp+MUgyWJTwDymQ76CsXRVX3v4
         MfsYqZX6m9uB10BaUxsvsDPEE0cQAfcsat/f2wl9FyR62tSIgt176FAmBnGyHy8DRJJT
         2fAvuyC9Exu9Ds7HMxVchfsDtrfHJyJfdNjqD4LFGRSp6PBHzXKl36NazWIdi1yprdKm
         WlSCftpdbbojonOG4c0dYTqKwakNhRRvCm2+wCljDkhp2zvzgiTke3tuQXFNqdyZWucp
         5IU4YEdA3hDkaVvtXsE3d+3fStvb61u4rQ/s/lN8yDLMMa5zZIeOn4NfsAs6/4+5EuP9
         9Hug==
X-Forwarded-Encrypted: i=1; AJvYcCV7Mq0hi5ELdf7o9Rc8y/aqH0gwThq1+r+lhx4ajvSEWf59js3J+ohC1r0b1DOu64hHgcoNDaiGQvejv++01bhw/iS2t2p7PSyXZAqzEw==
X-Gm-Message-State: AOJu0YzsbktVVTdTGsVPKJORsKZXbNLv+Spe4FmG0jEgUIUhoEZ5kpMc
	f9Y/NqGRcwtohzsWYBy8wHILSawuYhwXtXqNjKcqfcUJ8590WASTTI47lCPWgqJYmiWh24ooc2u
	90GUYme2QEBjph4rl5Qe7DIEHi8MU7g4BZp004MsoQT5R8/9DAOetpPiCv0ghJ+k=
X-Received: by 2002:ac8:5753:0:b0:441:1de:8ab0 with SMTP id d75a77b69052e-444cf75fffbmr68514071cf.2.1719240124116;
        Mon, 24 Jun 2024 07:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGggCmyM4O7AbDKTFNzE+M2A0XkOn8q4QKOyaCtAAJssRP1VcmWE+zk9J/aPMuu0F6mZDXJWw==
X-Received: by 2002:ac8:5753:0:b0:441:1de:8ab0 with SMTP id d75a77b69052e-444cf75fffbmr68513631cf.2.1719240123513;
        Mon, 24 Jun 2024 07:42:03 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b3689csm42757861cf.20.2024.06.24.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:42:03 -0700 (PDT)
Date: Mon, 24 Jun 2024 10:42:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com
Subject: Re: [PATCH v2 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnmFuAR7yNG_6zp6@x1n>
References: <20240621181224.3881179-1-audra@redhat.com>
 <20240621181224.3881179-3-audra@redhat.com>
 <ZnXwT_vkyVbIJefN@x1n>
 <Znl6dfM_qbH3hIvH@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Znl6dfM_qbH3hIvH@fedora>

On Mon, Jun 24, 2024 at 09:53:57AM -0400, Audra Mitchell wrote:
> On Fri, Jun 21, 2024 at 05:27:43PM -0400, Peter Xu wrote:
> > On Fri, Jun 21, 2024 at 02:12:24PM -0400, Audra Mitchell wrote:
> > > If CONFIG_PTE_MARKER_UFFD_WP is disabled, then testing with test_uffdio_up
> > 
> > Here you're talking about pte markers, then..
> > 
> > > enables calling uffdio_regsiter with the flag UFFDIO_REGISTER_MODE_WP. The
> > > kernel ensures in vma_can_userfault() that if CONFIG_PTE_MARKER_UFFD_WP
> > > is disabled, only allow the VM_UFFD_WP on anonymous vmas.
> > > 
> > > Signed-off-by: Audra Mitchell <audra@redhat.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-stress.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> > > index b9b6d858eab8..2601c9dfadd6 100644
> > > --- a/tools/testing/selftests/mm/uffd-stress.c
> > > +++ b/tools/testing/selftests/mm/uffd-stress.c
> > > @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
> > >  	test_uffdio_wp = test_uffdio_wp &&
> > >  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
> > >  
> > > +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_UNPOPULATED))
> > > +		test_uffdio_wp = false;
> > 
> > ... here you're checking against wp_unpopulated.  I'm slightly confused.
> > 
> > Are you running this test over shmem/hugetlb when the WP feature isn't
> > supported?
> >
> > I'm wondering whether you're looking for UFFD_FEATURE_WP_HUGETLBFS_SHMEM
> > instead.
> 
> I can confirm, its all really confusing... So in userfaultfd_api, we disable
> three features if CONFIG_PTE_MARKER_UFFD_WP is not enabled- including 
> UFFD_FEATURE_WP_UNPOPULATED:
> 
> #ifndef CONFIG_PTE_MARKER_UFFD_WP
>         uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
>         uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
>         uffdio_api.features &= ~UFFD_FEATURE_WP_ASYNC;
> #endif
> 
> If you run the userfaultfd selftests with the run_vmtests script we get
> several failures stemming from trying to call uffdio_regsiter with the flag 
> UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault() 
> that if CONFIG_PTE_MARKER_UFFD_WP is disabled, only allow the VM_UFFD_WP -
> which is set when you pass the UFFDIO_REGISTER_MODE_WP flag - on 
> anonymous vmas.
> 
> In parse_test_type_arg() I added the features check against 
> UFFD_FEATURE_WP_UNPOPULATED as it seemed the most well know feature/flag. I'm 
> more than happy to take any suggestions and adapt them if you have any! 

There're documents for these features in the headers:

	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
	 * write-protection mode is supported on both shmem and hugetlbfs.
	 *
	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
	 * write-protection mode will always apply to unpopulated pages
	 * (i.e. empty ptes).  This will be the default behavior for shmem
	 * & hugetlbfs, so this flag only affects anonymous memory behavior
	 * when userfault write-protection mode is registered.

While in this context ("test_type != TEST_ANON") IIUC the accurate feature
to check is UFFD_FEATURE_WP_HUGETLBFS_SHMEM.

In most kernels they should behave the same indeed, but note that since
UNPOPULATED was introduced later than shmem/hugetlb support, it means on
some kernel the result of checking these two features will be different.

Thanks,

-- 
Peter Xu


