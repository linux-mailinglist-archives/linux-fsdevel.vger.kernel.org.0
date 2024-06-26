Return-Path: <linux-fsdevel+bounces-22515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761D91835E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6BB2876C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C674184119;
	Wed, 26 Jun 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4U3NGVv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1CB14EC65
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410009; cv=none; b=UGoa2HPUcgoMpRPdGHhEVxc5zyaQtZEEPoXrXrOkcG//MGq1hSbw+7XcVlj6lVrdsC3xbItL+dv+RxevmuWQYMy8cp9YOWFs2wVvbCZSI9XatR/VtlgUztTAQoLhA9C/v77+i46dcvVN5Jkv71WOHCJs1gTifRGBOpAOgpI8n8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410009; c=relaxed/simple;
	bh=A2o+l3NuRNw2a+iRKsLea/VZp78l6U646vGfevTxLB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIbVa/FZY4Ur2AZMwUqog4vla/KmEG13ti35u+sE+7N+Z2I1WOQEMrPEOD9SOFVQuSJzYJDPWQ5Wiui1sWIvOf/kuJyBNrDukyKwlqRTkaieqrCp+xxVDTeRvFj5A1ckAdAMW9sOrD26+JTWsq3joSQGB3UhsS2Rt9KPHNxQRPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4U3NGVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719410007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6L/CySx21VlY9lkKLs/UvRv4ham7l6zFWPjNK0vJEd8=;
	b=G4U3NGVvhW6/ThD4blwT6mVmWPNzZSryL4PDJe1GnTiIMMBiCBjjO3rY/pfZ7scipKhdsI
	b9+FXX+nc8B+w/kEZWQg68GYiEEN13mit36JFuPUxrg+KfvgJEEvijzx2zkb16zshOnVnK
	GDp9iNqThQ/fRg7W42ZqZ7jr+5+2JG0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-BGOAK69dP-WtwC6HH1_Ckg-1; Wed, 26 Jun 2024 09:53:25 -0400
X-MC-Unique: BGOAK69dP-WtwC6HH1_Ckg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43e2c5354f9so14968631cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 06:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410005; x=1720014805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6L/CySx21VlY9lkKLs/UvRv4ham7l6zFWPjNK0vJEd8=;
        b=D8T3tB1J+hzzKmYI5Ut20WSOtYN5XM/bP7uX2vZjRztXhAgaFnBgMYWiEY+7YB0Fky
         YivdsDoNHSV+Kpkv0tusnETQs7SscOwisEbXegA17M/OhMc3gnUnac3m3Zqry8dweLYQ
         OyKeOOlLLATKNDwnmWz+L+NjTYdPfMx6e9yodLLElicGKCs9KdBzUzEbI33fHnRzlZc/
         Osjd4nJ4z7xuf044LtqU5VB9gYUCbc+3b9x1VAWbLywkiCDZFg71fR1RJdcHxiF7txY4
         N50v4Ltno+zHvswg+ioBlvZw1MlWtC4XBp33XrgyZgdOAsZzJzAVqJSMRQPj3nmCcxqS
         n9ww==
X-Forwarded-Encrypted: i=1; AJvYcCUJi0H77/OxSoNyN4tZSOPOdks8AQR4Yb1orixtcqyclqJX/XjfbxlPtrmSUaMV115LEU0vKTTDe7wUXgCAdN54f92yDgUCQvwpCw12lg==
X-Gm-Message-State: AOJu0YzUPXO3h3jEdT/OVe6dkqFQMrv9G0GQ/ewCnGGWa00GNSVT9PMM
	b56Okbp/RWeCZBiKGwCGOV1rxyt7RPk4aTHyru44UdOilQz1jRV/MO2HmEe8TZP5pI8FySFd5Uj
	L83yiVH8muT/PnHFa+ev+czlKylFAXTpSOfgVSQ99h86nJdJC0nINNR5gCOIOhMQ=
X-Received: by 2002:a05:620a:29c5:b0:79d:53d0:95af with SMTP id af79cd13be357-79d53d098f6mr146858885a.2.1719410004600;
        Wed, 26 Jun 2024 06:53:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfg5gp8Vxw/erpGLqvLxIwWQrtznQgrqGbKZUsqsdxrw8Gui1u4uAwFXpio7u+OhtBKCeLlg==
X-Received: by 2002:a05:620a:29c5:b0:79d:53d0:95af with SMTP id af79cd13be357-79d53d098f6mr146856185a.2.1719410003910;
        Wed, 26 Jun 2024 06:53:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c082c7433sm137223985a.53.2024.06.26.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:53:23 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:53:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Audra Mitchell <audra@redhat.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	aarcange@redhat.com, akpm@linux-foundation.org,
	rppt@linux.vnet.ibm.com, shli@fb.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, raquini@redhat.com,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 3/3] Turn off test_uffdio_wp if
 CONFIG_PTE_MARKER_UFFD_WP is not configured.
Message-ID: <ZnwdUJmo7-7tjcB3@x1n>
References: <20240626130513.120193-1-audra@redhat.com>
 <20240626130513.120193-3-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626130513.120193-3-audra@redhat.com>

On Wed, Jun 26, 2024 at 09:05:13AM -0400, Audra Mitchell wrote:
> If CONFIG_PTE_MARKER_UFFD_WP is disabled, then we turn off three features
> in userfaultfd_api (UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
> UFFD_FEATURE_WP_UNPOPULATED, and UFFD_FEATURE_WP_ASYNC). Currently this
> test always will call uffdio_regsiter with the flag
> UFFDIO_REGISTER_MODE_WP. However, the kernel ensures in vma_can_userfault
> that if the feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM is disabled, only
> allow the VM_UFFD_WP on anonymous vmas, meaning our call to
> uffdio_regsiter will fail. We still want to be able to run the test even
> if we have CONFIG_PTE_MARKER_UFFD_WP disabled, so check to see if the
> feature UFFD_FEATURE_WP_HUGETLBFS_SHMEM has been turned off in the test
> and if so, disable us from calling uffdio_regsiter with the flag
> UFFDIO_REGISTER_MODE_WP.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  tools/testing/selftests/mm/uffd-stress.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index b9b6d858eab8..3266ae885f75 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -419,6 +419,9 @@ static void parse_test_type_arg(const char *raw_type)
>  	test_uffdio_wp = test_uffdio_wp &&
>  		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
>  
> +	if (test_type != TEST_ANON && !(features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
> +		test_uffdio_wp = false;
> +
>  	close(uffd);
>  	uffd = -1;
>  }
> -- 
> 2.44.0
> 

-- 
Peter Xu


