Return-Path: <linux-fsdevel+bounces-49778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D2AC256D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECC816B966
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B7295DBA;
	Fri, 23 May 2025 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oc//67ZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50722262BE
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011840; cv=none; b=aAxwy5ccOEoiwjtlHSQOEvO1dt61setpaKebzjSkm8/gAM7gDNCpmPVf/zj1UrMomo8crV7qEt/RLO3uOxLVTuHtF59elFqLOAEDTMfBq9i+9ThGynZy8T2JC4b+51QsMSog0UXMX+w52PplRpMKMuoZbbwnDPPk3T5vHw1abdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011840; c=relaxed/simple;
	bh=O7p2mltt/0vUWbWw0+RJmsk3rfweC70X80nPyKhs5Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBQX2Am2xVZjjVTx/16SEy3xvQPLQm1cbvuRQ1NR5Cz9cFqfzpWW99UqOw7keErSV/NvkJo81T1Wq62ATztTOB/UP8BL8q5O2AA74oyX+G4luikMrdCYuUNlvJmRiwA4QrCqkvIz7Q6YyhhMttbEltTyhanJWnvg1Lqsdjnld+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oc//67ZX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748011838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mxi7Zq0dR0jS8AnM3AdP8cSMjc8tuFOCv+7IW3IQb5E=;
	b=Oc//67ZXFA3IlMMRhHq/WBjME0M7xq/OvjwpcvczPaDVi6qnHhdbLDto6+GiIig35uYeVK
	u7SVSBfR8grgQpOyxxC6x2yLnBY/aYJcm0gOF11fvMzZNLWdjLgsgcyeWrC0yb1a1BTajM
	w7dD++HPsVC4TOIIb5PsZIFDVq0TuLM=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-VfzpPPebNnKcXR2r3_v1Ng-1; Fri, 23 May 2025 10:50:37 -0400
X-MC-Unique: VfzpPPebNnKcXR2r3_v1Ng-1
X-Mimecast-MFC-AGG-ID: VfzpPPebNnKcXR2r3_v1Ng_1748011836
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742a091d290so14271b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 07:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748011836; x=1748616636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxi7Zq0dR0jS8AnM3AdP8cSMjc8tuFOCv+7IW3IQb5E=;
        b=NZ475zcoR04HUDvgVXwlbj2Z/dDaTM86+D79TUFqQOFAzvDWbo7v32BoDnfztvolg7
         Wg1RlUAqLQEFtraaf3ubEKt+ZIxFcbB38NU1QWPiodcQsy8+PYUXv1ji5AcvGAxfUG+5
         jpGVGLDWf2ehCqFG8JXANSBiVaikLAzNMsc3lDDiJTtKKN+3QAmFuM3O87oPVvpNKx6+
         YyyTyCXLCoa4J3k9Ek4JBd3lf/fNn24pDxdXzx+O4eTPy7F7EdfoyL+ZiT6f5hPMJLUj
         47hywMvIUdJnqgwiVDnYzFdhKx/YL49IA8crN9udWe0glwm82IqWWRWJ1WfUAyENo8/X
         yb1w==
X-Forwarded-Encrypted: i=1; AJvYcCVYHnliFyN4bfY626Q0XTWnyXbpWqjvMcXZ+wVul4b/Q8ToZp+euCQoHmXOqRWiiMmoIFesz5H1bpy8YQD2@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWF0zu2WdsPRFhWSpXPaA8sH4YEjgwCb9KO71ttoIresWcfs5
	alh258oq5jZHas3tgqKWQzyQb2sG/522d4TOaLlCDOePJyF3NMfJJt0DL3vM676ZScOwJM5R5g/
	WJBOCXgBE5zzOo3EOMgf5LmC1JYQrxtYkYVGCPJYF+oKXWXYwiseySrMQFKvpluQZEn8=
X-Gm-Gg: ASbGncv+SR04W9vBRVkTKi5N9C1wgN7njEU7VN3yDSVfQWmaXvWhpGiCN+qXyRBLrxf
	dIaVgueUY59TQ0EdHOZ3SSvV1Zh5sUfuMtFEh0fTEx2cSCQE5dI3h+4LUr3Ej4UdaI3ydpf9Xvi
	7LK03P2Hsm1oqG5LR7XWIpvSGinGJfZm0qF5B3diEqcE/FjZVoNVF2gco6I8NrpR8IwDeuxIuwd
	j5R3Fu6TnEdObsbwc+wQrN+ee+s1DgjZVCri+uznmYBcVYz6knlgnyCGMttwj2OXjevqKcaVR3C
	VKh5qGpGIPvOibOOxT8gxE7ZPzG78jYc59RsLAYD81sJRKzW1a2Q
X-Received: by 2002:a05:6a21:4ccc:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-216219f8fc6mr45988110637.38.1748011835927;
        Fri, 23 May 2025 07:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1w9qBZW5Gt9zNstNZDFOvmyKJMg7krNycYhMxSQIsqev12VaMfSfVxMJTYhLzOXzz7oMvsQ==
X-Received: by 2002:a05:6a21:4ccc:b0:1f5:6d00:ba05 with SMTP id adf61e73a8af0-216219f8fc6mr45988080637.38.1748011835604;
        Fri, 23 May 2025 07:50:35 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8cc71sm12831936a12.35.2025.05.23.07.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 07:50:34 -0700 (PDT)
Date: Fri, 23 May 2025 22:50:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Tests for AT_HANDLE_CONNECTABLE
Message-ID: <20250523145028.ydcei4rs5djf2qec@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250509170033.538130-1-amir73il@gmail.com>
 <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxht8zPuVn11Xfj4B-t8RF2VuSiK3xDJiXkX8zQs7BuxxA@mail.gmail.com>

On Fri, May 23, 2025 at 04:20:29PM +0200, Amir Goldstein wrote:
> Hi Zorro.
> 
> Ping.

Sure Amir, don't worry, this patchset is already in my testing list.
I'll merge it after testing passed :)

> 
> On Fri, May 9, 2025 at 7:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > This is a test for new flag AT_HANDLE_CONNECTABLE from v6.13.
> > See man page update of this flag here [1].
> >
> > This v2 fixes the failures that you observed with tmpfs and nfs.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250330163502.1415011-1-amir73il@gmail.com/
> >
> > Changes since v1:
> > - Remove unpredictable test case of open fh after move to new parent
> > - Add check that open fds are connected
> >
> > Amir Goldstein (2):
> >   open_by_handle: add support for testing connectable file handles
> >   open_by_handle: add a test for connectable file handles
> >
> >  common/rc             | 16 ++++++++--
> >  src/open_by_handle.c  | 53 ++++++++++++++++++++++++++------
> >  tests/generic/777     | 70 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/777.out |  5 ++++
> >  4 files changed, 132 insertions(+), 12 deletions(-)
> >  create mode 100755 tests/generic/777
> >  create mode 100644 tests/generic/777.out
> >
> > --
> > 2.34.1
> >
> 


